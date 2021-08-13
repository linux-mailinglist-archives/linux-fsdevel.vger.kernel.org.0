Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC903EB10E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 09:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbhHMHEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 03:04:04 -0400
Received: from verein.lst.de ([213.95.11.211]:46549 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238964AbhHMHEE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:04:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 314E46736F; Fri, 13 Aug 2021 09:03:35 +0200 (CEST)
Date:   Fri, 13 Aug 2021 09:03:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, Seth Jennings <sjenning@linux.vnet.ibm.com>,
        Bob Liu <bob.liu@oracle.com>, Minchan Kim <minchan@kernel.org>,
        Dan Magenheimer <dan.magenheimer@oracle.com>,
        trond.myklebust@primarydata.com, darrick.wong@oracle.com,
        hch@lst.de, viro@zeniv.linux.org.uk, jlayton@kernel.org,
        sfrench@samba.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/5] mm: Remove the callback func argument from
 __swap_writepage()
Message-ID: <20210813070334.GB26339@lst.de>
References: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk> <162879973548.3306668.4893577928865857447.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162879973548.3306668.4893577928865857447.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 09:22:15PM +0100, David Howells wrote:
> Remove the callback func argument from __swap_writepage() as it's
> end_swap_bio_write() in both places that call it.

Yeah.  I actually had a similar patch in a WIP tree for a while but
never got to end it out.

>  /* linux/mm/page_io.c */
>  extern int swap_readpage(struct page *page, bool do_poll);
>  extern int swap_writepage(struct page *page, struct writeback_control *wbc);
> -extern void end_swap_bio_write(struct bio *bio);
> -extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
> -	bio_end_io_t end_write_func);
> +extern int __swap_writepage(struct page *page, struct writeback_control *wbc);

Please also drop the extern while you're at it.

With that:

Reviewed-by: Christoph Hellwig <hch@lst.de>
