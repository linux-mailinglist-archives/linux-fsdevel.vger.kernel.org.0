Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D535E6105
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 13:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiIVL3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 07:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiIVL3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:29:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E06513FAF;
        Thu, 22 Sep 2022 04:29:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0781521A54;
        Thu, 22 Sep 2022 11:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663846176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9k9bX/5slzDdRSkUKBx98w00GOC+8EEXB+oK3HF6E5Q=;
        b=T2VVCow1zNYZIiy/aEnPrWbsvg0XzllrQTYu6Y9KFZTd6Qbn2qh99JzI0IZqGDnbFWcuhj
        J4nvfKtyBOvKH3Lcy00HfiMF9eidbuN6wx2razfOyNI02HnacqQLI0yoSEnATKR95hDVWT
        /ya0yj4pvWs9AhgmIVxLNo5gi5ehsnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663846176;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9k9bX/5slzDdRSkUKBx98w00GOC+8EEXB+oK3HF6E5Q=;
        b=ZNhkQWahbJ8c3/2sKwYjFTJbr4peFr+RuXw/nULl9kpZhK6zN+w8VFJipp673C6Vg0J0Q/
        xq8pg4titNRGMRDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5F2013AA5;
        Thu, 22 Sep 2022 11:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HNohOB9HLGMTOwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Sep 2022 11:29:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5B522A0684; Thu, 22 Sep 2022 13:29:35 +0200 (CEST)
Date:   Thu, 22 Sep 2022 13:29:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <20220922112935.pep45vfqfw5766gq@quack3>
References: <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyvG+Oih2A37Grcf@ZenIV>
 <a6f95605-c2d5-6ec5-b85c-d1f3f8664646@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6f95605-c2d5-6ec5-b85c-d1f3f8664646@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 21-09-22 23:09:06, John Hubbard wrote:
> On 9/21/22 19:22, Al Viro wrote:
> > On Thu, Sep 15, 2022 at 10:16:25AM +0200, Jan Kara wrote:
> > 
> >>> How would that work?  What protects the area where you want to avoid running
> >>> into pinned pages from previously acceptable page getting pinned?  If "they
> >>> must have been successfully unmapped" is a part of what you are planning, we
> >>> really do have a problem...
> >>
> >> But this is a very good question. So far the idea was that we lock the
> >> page, unmap (or writeprotect) the page, and then check pincount == 0 and
> >> that is a reliable method for making sure page data is stable (until we
> >> unlock the page & release other locks blocking page faults and writes). But
> >> once suddently ordinary page references can be used to create pins this
> >> does not work anymore. Hrm.
> >>
> >> Just brainstorming ideas now: So we'd either need to obtain the pins early
> >> when we still have the virtual address (but I guess that is often not
> >> practical but should work e.g. for normal direct IO path) or we need some
> >> way to "simulate" the page fault when pinning the page, just don't map it
> >> into page tables in the end. This simulated page fault could be perhaps
> >> avoided if rmap walk shows that the page is already mapped somewhere with
> >> suitable permissions.
> > 
> > OK.  As far as I can see, the rules are along the lines of
> > 	* creator of ITER_BVEC/ITER_XARRAY is responsible for pages being safe.
> > 	  That includes
> > 		* page known to be locked by caller
> > 		* page being privately allocated and not visible to anyone else
> > 		* iterator being data source
> > 		* page coming from pin_user_pages(), possibly as the result of
> > 		  iov_iter_pin_pages() on ITER_IOVEC/ITER_UBUF.
> > 	* ITER_PIPE pages are always safe
> > 	* pages found in ITER_BVEC/ITER_XARRAY are safe, since the iterator
> > 	  had been created with such.
> > My preference would be to have iov_iter_get_pages() and friends pin if and
> > only if we have data-destination iov_iter that is user-backed.  For
> > data-source user-backed we only need FOLL_GET, and for all other flavours
> > (ITER_BVEC, etc.) we only do get_page(), if we need to grab any references
> > at all.
> 
> This rule would mostly work, as long as we can relax it in some cases, to
> allow pinning of both source and dest pages, instead of just destination
> pages, in some cases. In particular, bio_release_pages() has lost all
> context about whether it was a read or a write request, as far as I can
> tell. And bio_release_pages() is the primary place to unpin pages for
> direct IO.

Well, we already do have BIO_NO_PAGE_REF bio flag that gets checked in
bio_release_pages(). I think we can easily spare another bio flag to tell
whether we need to unpin or not. So as long as all the pages in the created
bio need the same treatment, the situation should be simple.

> > What I'd like to have is the understanding of the places where we drop
> > the references acquired by iov_iter_get_pages().  How do we decide
> > whether to unpin?  E.g. pipe_buffer carries a reference to page and no
> > way to tell whether it's a pinned one; results of iov_iter_get_pages()
> > on ITER_IOVEC *can* end up there, but thankfully only from data-source
> > (== WRITE, aka.  ITER_SOURCE) iov_iter.  So for those we don't care.
> > Then there's nfs_request; AFAICS, we do need to pin the references in
> > those if they are coming from nfs_direct_read_schedule_iovec(), but
> > not if they come from readpage_async_filler().  How do we deal with
> > coalescence, etc.?  It's been a long time since I really looked at
> > that code...  Christoph, could you give any comments on that one?
> > 
> > Note, BTW, that nfs_request coming from readpage_async_filler() have
> > pages locked by caller; the ones from nfs_direct_read_schedule_iovec()
> > do not, and that's where we want them pinned.  Resulting page references
> > end up (after quite a trip through data structures) stuffed into struct
> > rpc_rqst ->rc_recv_buf.pages[] and when a response arrives from server,
> > they get picked by xs_read_bvec() and fed to iov_iter_bvec().  In one
> > case it's safe since the pages are locked; in another - since they would
> > come from pin_user_pages().  The call chain at the time they are used
> > has nothing to do with the originator - sunrpc is looking at the arrived
> > response to READ that matches an rpc_rqst that had been created by sender
> > of that request and safety is the sender's responsibility.
> 
> For NFS Direct, is there any reason it can't be as simple as this
> (conceptually, that is--the implementation of iov_iter_pin_pages_alloc()
> is not shown here)? Here:
> 
> 
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 1707f46b1335..7dbc705bab83 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -142,13 +142,6 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
>  	return 0;
>  }
>  
> -static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
> -{
> -	unsigned int i;
> -	for (i = 0; i < npages; i++)
> -		put_page(pages[i]);
> -}
> -
>  void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
>  			      struct nfs_direct_req *dreq)
>  {
> @@ -332,7 +325,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
>  		size_t pgbase;
>  		unsigned npages, i;
>  
> -		result = iov_iter_get_pages_alloc2(iter, &pagevec,
> +		result = iov_iter_pin_pages_alloc(iter, &pagevec,
>  						  rsize, &pgbase);
>  		if (result < 0)
>  			break;
> @@ -362,7 +355,16 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
>  			pos += req_len;
>  			dreq->bytes_left -= req_len;
>  		}
> -		nfs_direct_release_pages(pagevec, npages);
> +
> +		/*
> +		 * iov_iter_pin_pages_alloc() calls pin_user_pages_fast() for
> +		 * the user_backed_iter() case (only).
> +		 */
> +		if (user_backed_iter(iter))
> +			unpin_user_pages(pagevec, npages);
> +		else
> +			release_pages(pagevec, npages);
> +

I don't think this will work. The pin nfs_direct_read_schedule_iovec()
obtains needs to be released once the IO is completed. Not once the IO is
submitted. Notice how nfs_create_request()->__nfs_create_request() gets
another page reference which is released on completion
(nfs_direct_read_completion->nfs_release_request->nfs_page_group_destroy->
nfs_free_request->nfs_clear_request). And we need to stop releasing the
obtained pin in nfs_direct_read_schedule_iovec() (and acquiring another
reference in __nfs_create_request()) and instead propagate it to
nfs_clear_request() where it can get released.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
