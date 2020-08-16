Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A45F24554E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Aug 2020 03:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgHPBs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Aug 2020 21:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgHPBs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Aug 2020 21:48:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D7BC061786
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2020 18:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+qGvMQP3F82XWnhA2Z0T5CGUcknqttuEfe3H274ZaXQ=; b=CEeNyYKwgEXWghcU5/lmXcskC1
        4qrkVEYZ3nbXyRaVYgl2LFNKtufwOIsuNfGK5Xkjxekt+0kt+vUJT0qwN4NOzv3wwSoQ+PXE3mO9g
        0mFH2hQZOcJ00GxxF6hft10Nu1Yus1ncZNlq6dR0uGPYz/AVbIzyqBYy10OZSTxkG7dzm1G3mQhXj
        Yx7op7Bq0pmGzcUQGUgm8DI9/R5BzsnUJNELgbeTbQnCPZbXeuhC6dq52cE7b1hcA6V9C2aF93hjE
        0VWcUOYC41e6aI+FjEuQfeRsOaIQcxVAWuhnwLjvuLRgsUbvmDoYTpTyucQ8y7+G8dq8XcHMDK3DL
        pEIakH1g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k77n1-0002qj-M5; Sun, 16 Aug 2020 01:48:51 +0000
Date:   Sun, 16 Aug 2020 02:48:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/4] mm: Introduce and use page_cache_empty
Message-ID: <20200816014851.GE17456@casper.infradead.org>
References: <20200804161755.10100-1-willy@infradead.org>
 <20200804161755.10100-2-willy@infradead.org>
 <20200806232400.s7nhmnoi3tkk7p2r@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806232400.s7nhmnoi3tkk7p2r@box>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 02:24:00AM +0300, Kirill A. Shutemov wrote:
> On Tue, Aug 04, 2020 at 05:17:52PM +0100, Matthew Wilcox (Oracle) wrote:
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 484a36185bb5..a474a92a2a72 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -18,6 +18,11 @@
> >  
> >  struct pagevec;
> >  
> > +static inline bool page_cache_empty(struct address_space *mapping)
> > +{
> > +	return xa_empty(&mapping->i_pages);
> 
> What about something like
> 
> 	bool empty = xa_empty(&mapping->i_pages);
> 	VM_BUG_ON(empty && mapping->nrpages);
> 	return empty;

I tried this and it's triggered by generic/418.  The problem
is that it's called when the pagecache lock isn't held (by
invalidate_inode_pages2_range), so it's possible for xa_empty() to
return true, then a page be added to the page cache, and mapping->pages
be incremented to 1.  That seems to be what's happened here:

(gdb) p/x *(struct address_space *)0xffff88804b21b360
$2 = {host = 0xffff88804b21b200, i_pages = {xa_lock = {{rlock = {raw_lock = {{
              val = {counter = 0x0}, {locked = 0x0, pending = 0x0}, {
                locked_pending = 0x0, tail = 0x0}}}}}}, xa_flags = 0x21, 
*  xa_head = 0xffffea0001e187c0}, gfp_mask = 0x100c4a, i_mmap_writable = {
    counter = 0x0}, nr_thps = {counter = 0x0}, i_mmap = {rb_root = {
      rb_node = 0x0}, rb_leftmost = 0x0}, i_mmap_rwsem = {count = {
      counter = 0x0}, owner = {counter = 0x0}, osq = {tail = {counter = 0x0}}, 
    wait_lock = {raw_lock = {{val = {counter = 0x0}, {locked = 0x0, 
            pending = 0x0}, {locked_pending = 0x0, tail = 0x0}}}}, 
    wait_list = {next = 0xffff88804b21b3b0, prev = 0xffff88804b21b3b0}}, 
* nrpages = 0x1, writeback_index = 0x0, a_ops = 0xffffffff81c2ed60, 
  flags = 0x40, wb_err = 0x0, private_lock = {{rlock = {raw_lock = {{val = {
              counter = 0x0}, {locked = 0x0, pending = 0x0}, {
              locked_pending = 0x0, tail = 0x0}}}}}}, private_list = {
    next = 0xffff88804b21b3e8, prev = 0xffff88804b21b3e8}, private_data = 0x0}

(marked the critical lines with *)
