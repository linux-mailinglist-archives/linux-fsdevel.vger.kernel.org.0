Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857AD1E71D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438224AbgE2A7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:59:34 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2823 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438188AbgE2A7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:59:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed05e180000>; Thu, 28 May 2020 17:58:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 May 2020 17:59:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 May 2020 17:59:31 -0700
Received: from [10.2.62.53] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 May
 2020 00:59:31 +0000
X-Nvconfidentiality: public
To:     Jan Kara <jack@suse.cz>, Linux-MM <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Subject: Question: "Bare" set_page_dirty_lock() call in vhost.c
Message-ID: <3b2db4da-9e4e-05d1-bf89-a261f0eb6de0@nvidia.com>
Date:   Thu, 28 May 2020 17:59:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590713880; bh=UaFydq34A3WyVB6O+aiR/+Gh0JTIRS04gbdko0cn1Pc=;
        h=X-PGP-Universal:X-Nvconfidentiality:To:CC:From:Subject:Message-ID:
         Date:User-Agent:MIME-Version:X-Originating-IP:X-ClientProxiedBy:
         Content-Type:Content-Language:Content-Transfer-Encoding;
        b=K7jI8KLsHwLvykOP5bSBEs2AsHREIrQ/N7eNctwfF/fhY8MlIwca2IAJ5FR+PI7jX
         zu3quObFg+MTsO54lBNwOn3n9b7/6NUcKhYk1eoARP9nOTs4T1hl0ANV8efdyINzjF
         J18WLzhsP0jrrSFDHGKfIy3Jj1pDJqRImnVn+Xl/5nFCrUTUEvXCnWQeDp6WFmYSmi
         vb0WrLi7HPJcpclB/SS98ddjGqNoy63gquPE/znBXGrCW36n3ev//lPhlMSSkvCIYY
         5sdRbBs/oBC0UFZSo9XmP/VHS4y8kR5qLyACp9BOFNwPMMqt3946lgGpb2YNTAUa3r
         1bSEKmCuno/Vw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

While trying to figure out which things to convert from
get_user_pages*() to put_user_pages*(), I came across an interesting use
of set_page_dirty_lock(), and wanted to ask about it.

Is it safe to call set_page_dirty_lock() like this (for the case
when this is file-backed memory):

// drivers/vhost/vhost.c:1757:
static int set_bit_to_user(int nr, void __user *addr)
{
	unsigned long log = (unsigned long)addr;
	struct page *page;
	void *base;
	int bit = nr + (log % PAGE_SIZE) * 8;
	int r;

	r = get_user_pages_fast(log, 1, FOLL_WRITE, &page);
	if (r < 0)
		return r;
	BUG_ON(r != 1);
	base = kmap_atomic(page);
	set_bit(bit, base);
	kunmap_atomic(base);
	set_page_dirty_lock(page);
	put_page(page);
	return 0;
}

  ?

That is, after the page is unmapped, but before unpinning it?
Specifically, I'd expect that the writeback and reclaim code code can end
up calling drop_buffers() (because the set_bit() call actually did
dirty the pte), after the kunmap_atomic() call. So then when
set_page_dirty_lock() runs, it could bug check on ext4_writepage()'s
attempt to buffer heads:

ext4_writepage()
	page_bufs = page_buffers(page);
         #define page_buffers(page)					\
         	({							\
         		BUG_ON(!PagePrivate(page));			\
         		((struct buffer_head *)page_private(page));	\
         	})

...which actually is the the case that pin_user_pages*() is ultimately
helping to avoid, btw. But in this case, it's all code that runs on a
CPU, so no DMA or DIO is involved. But still, the "bare" use of
set_page_dirty_lock() seems like a problem here.

thanks,
-- 
John Hubbard
NVIDIA
