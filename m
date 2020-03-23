Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5A718F5E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 14:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgCWNkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 09:40:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgCWNkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xeL4pdKAp0mTyh3NpDDsg0EYns7Kpa3HrGnpwseCeuE=; b=Z2eabrHdQ19iSdbIX2UmsQoRkh
        vdA/XH9oYjXT9PKVf1LWeAImS+mMRDT8o50VrotsxVFBPWcLplY+lZJlaZfAygkSwdNxcMIvb8BNO
        YjqCdEFWMKZfet6X7mygBBLEsfwHkAzKj/HJkZlX0+sUN43PeyESWCNtrL8uKCUr7qYzq57Z4efKd
        YcC1N5IlYhxj3VP929pcEfe2HvuC1YAfp0UynSXh7gTDwwbslK8lV2nea7mdWl7RoeJv1hsSWuRFU
        aOf/oQNtLAqV10VdovSQ6n/2A034ea3XmIkT7iYjLyE0FgWDl5goyjB3b0zNa4Oxblkk8yTHiRnGn
        pgkbJOyA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGNJg-0005RG-B0; Mon, 23 Mar 2020 13:40:32 +0000
Date:   Mon, 23 Mar 2020 06:40:32 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Do not use GFP_NORETRY to allocate BIOs
Message-ID: <20200323134032.GH4971@bombadil.infradead.org>
References: <20200323131244.29435-1-willy@infradead.org>
 <20200323132052.GA7683@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323132052.GA7683@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 23, 2020 at 06:20:52AM -0700, Christoph Hellwig wrote:
> On Mon, Mar 23, 2020 at 06:12:44AM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > If we use GFP_NORETRY, we have to be able to handle failures, and it's
> > tricky to handle failure here.  Other implementations of ->readpages
> > do not attempt to handle BIO allocation failures, so this is no worse.
> 
> do_mpage_readpage tries to use it, I guess that is wher I copied it
> from..

Oh, I see that now.  It uses readahead_gfp_mask(), and I was grepping for
GFP_NORETRY so I didn't spot it.  It falls back to block_read_full_page()
which we can't do.  That will allocate smaller BIOs, so there's an argument
that we should do the same.  How about this:

+++ b/fs/iomap/buffered-io.c
@@ -302,6 +302,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
        if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {
                gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
+               gfp_t orig_gfp = gfp;
                int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
                if (ctx->bio)
@@ -310,6 +311,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
                if (ctx->is_readahead) /* same as readahead_gfp_mask */
                        gfp |= __GFP_NORETRY | __GFP_NOWARN;
                ctx->bio = bio_alloc(gfp, min(BIO_MAX_PAGES, nr_vecs));
+               if (!ctx->bio)
+                       ctx->bio = bio_alloc(orig_gfp, 1);
                ctx->bio->bi_opf = REQ_OP_READ;
                if (ctx->is_readahead)
                        ctx->bio->bi_opf |= REQ_RAHEAD;

