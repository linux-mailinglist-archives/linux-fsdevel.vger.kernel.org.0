Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B7E56AA47
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 20:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiGGSNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiGGSNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:13:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BA62183;
        Thu,  7 Jul 2022 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FNOFDdZ7i64oXBfTFYFEfabLTj+Om4xFUb105cJ275o=; b=iO0AfDWKY40RJq2sVTLm5U7qUR
        bUwHFVWe1ZzcKgo/B3UkA4NDW8r3pxv+6qItz19CG1ugfQPL2yzdYNuWoCvncvyt47ywlgqOg09Vg
        YTjHc2sWGq/THcQp3Mignka53pzTm6dD4peT6Kk3FwLxDqG4cktWpE3hFS4rdyAPPziqtaNgmLEF/
        Nr+qeVParE3TTiV0gVljIEM7DlDKcsKv2WXbkMXx82MH9MSws/toNNNdEVQ+2XrMwkzRHzwlENWDA
        UtwXdXec2UkM3JzY5OTWO3lCl86WpwsyAl0QqIEC1j0J8SMfZCvK1zQS/+FgkWXCIKz5OGEnZVR9T
        RgSm68fA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9W0D-002nZ6-Fw; Thu, 07 Jul 2022 18:13:25 +0000
Date:   Thu, 7 Jul 2022 19:13:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [RFC] Convert ceph_page_mkwrite to use a folio
Message-ID: <YsciRdDHndyiDz6o@casper.infradead.org>
References: <YsbzAoGAAZtlxsrd@casper.infradead.org>
 <763ba47fb850282b62c36eca6084c446a0952336.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <763ba47fb850282b62c36eca6084c446a0952336.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 07, 2022 at 01:48:48PM -0400, Jeff Layton wrote:
> On Thu, 2022-07-07 at 15:51 +0100, Matthew Wilcox wrote:
> > There are some latent bugs that I fix here (eg, you can't call
> > thp_size() on a tail page), but the real question is how Ceph in
> > particular (and FS in general) want to handle mkwrite in a world
> > of multi-page folios.
> > 
> > If we have a multi-page folio which is occupying an entire PMD, then
> > no question, we have to mark all 2MB (or whatever) as dirty.  But
> > if it's being mapped with PTEs, either because it's mapped misaligned,
> > or it's smaller than a PMD, then we have a choice.  We can either
> > work in 4kB chunks, marking each one dirty (and storing the sub-folio
> > dirty state in the fs private data) like a write might.  Or we can
> > just say "Hey, the whole folio is dirty now" and not try to track
> > dirtiness on a per-page granularity.
> > 
> > The latter course seems to have been taken, modulo the bugs, but I
> > don't know if any thought was taken or whether it was done by rote.
> > 
> 
> Done by rote, I'm pretty sure.
> 
> If each individual page retains its own dirty bit, what does
> folio_test_dirty return when its pages are only partially dirty? I guess
> the folio is still dirty even if some of its pages are clean?

ah, each *PTE* retains its own dirty bit.  So we can track which pages
within the folio are actually dirty.  But the folio as a whole has a
single dirty bit (filesystems, of course, are welcome to keep track of
sub-folio dirtiness at whatever granularity makes sense for them).

> Ceph can do a vectored write if a folio has disjoint dirty regions that
> we need to flush. Hashing out an API to handle that with the netfs layer
> is going to be "interesting" though.

Yes; I'm sure Dave has ideas about that ...

> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 6dee88815491..fb346b929f65 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1503,8 +1503,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
> >  	struct ceph_inode_info *ci = ceph_inode(inode);
> >  	struct ceph_file_info *fi = vma->vm_file->private_data;
> >  	struct ceph_cap_flush *prealloc_cf;
> > -	struct page *page = vmf->page;
> > -	loff_t off = page_offset(page);
> > +	struct folio *folio = page_folio(vmf->page);
> > +	loff_t pos = folio_pos(folio);
> >  	loff_t size = i_size_read(inode);
> >  	size_t len;
> >  	int want, got, err;
> > @@ -1521,50 +1521,50 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
> >  	sb_start_pagefault(inode->i_sb);
> >  	ceph_block_sigs(&oldset);
> >  
> > -	if (off + thp_size(page) <= size)
> > -		len = thp_size(page);
> > +	if (pos + folio_size(folio) <= size)
> > +		len = folio_size(folio);
> >  	else
> > -		len = offset_in_thp(page, size);
> > +		len = offset_in_folio(folio, size);
> >  
> >  	dout("page_mkwrite %p %llx.%llx %llu~%zd getting caps i_size %llu\n",
> > -	     inode, ceph_vinop(inode), off, len, size);
> > +	     inode, ceph_vinop(inode), pos, len, size);
> >  	if (fi->fmode & CEPH_FILE_MODE_LAZY)
> >  		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
> >  	else
> >  		want = CEPH_CAP_FILE_BUFFER;
> >  
> >  	got = 0;
> > -	err = ceph_get_caps(vma->vm_file, CEPH_CAP_FILE_WR, want, off + len, &got);
> > +	err = ceph_get_caps(vma->vm_file, CEPH_CAP_FILE_WR, want, pos + len, &got);
> >  	if (err < 0)
> >  		goto out_free;
> >  
> >  	dout("page_mkwrite %p %llu~%zd got cap refs on %s\n",
> > -	     inode, off, len, ceph_cap_string(got));
> > +	     inode, pos, len, ceph_cap_string(got));
> >  
> > -	/* Update time before taking page lock */
> > +	/* Update time before taking folio lock */
> >  	file_update_time(vma->vm_file);
> >  	inode_inc_iversion_raw(inode);
> >  
> >  	do {
> >  		struct ceph_snap_context *snapc;
> >  
> > -		lock_page(page);
> > +		folio_lock(folio);
> >  
> > -		if (page_mkwrite_check_truncate(page, inode) < 0) {
> > -			unlock_page(page);
> > +		if (folio_mkwrite_check_truncate(folio, inode) < 0) {
> > +			folio_unlock(folio);
> >  			ret = VM_FAULT_NOPAGE;
> >  			break;
> >  		}
> >  
> > -		snapc = ceph_find_incompatible(page);
> > +		snapc = ceph_find_incompatible(&folio->page);
> >  		if (!snapc) {
> > -			/* success.  we'll keep the page locked. */
> > -			set_page_dirty(page);
> > +			/* success.  we'll keep the folio locked. */
> > +			folio_mark_dirty(folio);
> >  			ret = VM_FAULT_LOCKED;
> >  			break;
> >  		}
> >  
> > -		unlock_page(page);
> > +		folio_unlock(folio);
> >  
> >  		if (IS_ERR(snapc)) {
> >  			ret = VM_FAULT_SIGBUS;
> > @@ -1588,7 +1588,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
> >  	}
> >  
> >  	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %x\n",
> > -	     inode, off, len, ceph_cap_string(got), ret);
> > +	     inode, pos, len, ceph_cap_string(got), ret);
> >  	ceph_put_cap_refs_async(ci, got);
> >  out_free:
> >  	ceph_restore_sigs(&oldset);
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
