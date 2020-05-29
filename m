Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219461E764F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 09:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgE2HDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 03:03:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:52818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgE2HDq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 03:03:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2323EB001;
        Fri, 29 May 2020 07:03:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 796C61E1289; Fri, 29 May 2020 09:03:43 +0200 (CEST)
Date:   Fri, 29 May 2020 09:03:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Question: "Bare" set_page_dirty_lock() call in vhost.c
Message-ID: <20200529070343.GL14550@quack2.suse.cz>
References: <3b2db4da-9e4e-05d1-bf89-a261f0eb6de0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b2db4da-9e4e-05d1-bf89-a261f0eb6de0@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Thu 28-05-20 17:59:30, John Hubbard wrote:
> While trying to figure out which things to convert from
> get_user_pages*() to put_user_pages*(), I came across an interesting use
> of set_page_dirty_lock(), and wanted to ask about it.
> 
> Is it safe to call set_page_dirty_lock() like this (for the case
> when this is file-backed memory):
> 
> // drivers/vhost/vhost.c:1757:
> static int set_bit_to_user(int nr, void __user *addr)
> {
> 	unsigned long log = (unsigned long)addr;
> 	struct page *page;
> 	void *base;
> 	int bit = nr + (log % PAGE_SIZE) * 8;
> 	int r;
> 
> 	r = get_user_pages_fast(log, 1, FOLL_WRITE, &page);
> 	if (r < 0)
> 		return r;
> 	BUG_ON(r != 1);
> 	base = kmap_atomic(page);
> 	set_bit(bit, base);
> 	kunmap_atomic(base);
> 	set_page_dirty_lock(page);
> 	put_page(page);
> 	return 0;
> }
> 
>  ?
> 
> That is, after the page is unmapped, but before unpinning it?
> Specifically, I'd expect that the writeback and reclaim code code can end
> up calling drop_buffers() (because the set_bit() call actually did
> dirty the pte), after the kunmap_atomic() call. So then when
> set_page_dirty_lock() runs, it could bug check on ext4_writepage()'s
> attempt to buffer heads:
> 
> ext4_writepage()
> 	page_bufs = page_buffers(page);
>         #define page_buffers(page)					\
>         	({							\
>         		BUG_ON(!PagePrivate(page));			\
>         		((struct buffer_head *)page_private(page));	\
>         	})
> 
> ...which actually is the the case that pin_user_pages*() is ultimately
> helping to avoid, btw. But in this case, it's all code that runs on a
> CPU, so no DMA or DIO is involved. But still, the "bare" use of
> set_page_dirty_lock() seems like a problem here.

I agree that the site like above needs pin_user_pages(). The problem has
actually nothing to do with kmap_atomic() - that actually doesn't do
anything interesting on x86_64. The moment GUP_fast() returns, page can be
unmapped from page tables and written back so this site has exactly same
problems as any other using DMA or DIO. As we discussed earlier when
designing the patch set, the problem is really with GUP reference being
used to access page data. And the method of access (DMA, CPU access, GPU
access, ...) doesn't really matter...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
