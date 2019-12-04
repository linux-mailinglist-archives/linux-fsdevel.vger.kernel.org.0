Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91126113360
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 19:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfLDSK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 13:10:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731352AbfLDSK7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:10:59 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6928D20863;
        Wed,  4 Dec 2019 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483058;
        bh=yG8GPbqviAwiLRynbSvmgC1rPCu+1+hYU0TZYOzcVRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uo+6n7dswijeSvj+tjH/6tbQi5dTDjCVPCl/8FSzUf/8AFpcqT55fi0Cx9jp8St2u
         awX/6Ak65XXMqko9j7JyxF7fL8xOrZuq+hTtjoh5pT1o+RxRfENRBBK2voxf1kYK7G
         QhlpzYDGretUM3JHsS0ze0SDnzWZmbqvlw93JBJI=
Date:   Wed, 4 Dec 2019 10:10:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Vyacheslav Dubeyko <slava@dubeyko.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH] fs-verity: implement readahead for FS_IOC_ENABLE_VERITY
Message-ID: <20191204181056.GA4576@sol.localdomain>
References: <20191203193001.66906-1-ebiggers@kernel.org>
 <96a288281d9d84f11dcc06e62a1ff20e2bb2f776.camel@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96a288281d9d84f11dcc06e62a1ff20e2bb2f776.camel@dubeyko.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 10:53:50AM +0300, Vyacheslav Dubeyko wrote:
> > diff --git a/fs/verity/enable.c b/fs/verity/enable.c
> > index eabc6ac19906..f7eaffa60196 100644
> > --- a/fs/verity/enable.c
> > +++ b/fs/verity/enable.c
> > @@ -13,14 +13,44 @@
> >  #include <linux/sched/signal.h>
> >  #include <linux/uaccess.h>
> >  
> > -static int build_merkle_tree_level(struct inode *inode, unsigned int
> > level,
> > +/*
> > + * Read a file data page for Merkle tree construction.  Do
> > aggressive readahead,
> > + * since we're sequentially reading the entire file.
> > + */
> > +static struct page *read_file_data_page(struct inode *inode,
> > +					struct file_ra_state *ra,
> > +					struct file *filp,
> > +					pgoff_t index,
> > +					pgoff_t num_pages_in_file)
> > +{
> > +	struct page *page;
> > +
> > +	page = find_get_page(inode->i_mapping, index);
> > +	if (!page || !PageUptodate(page)) {
> > +		if (page)
> > +			put_page(page);
> 
> 
> It looks like that there is not necessary check here. If we have NULL
> pointer on page then we will not enter inside. But if we have valid
> pointer on page then we have double check inside. Am I correct? 
> 

I'm not sure what you mean.  This code does the page_cache_sync_readahead() and
read_mapping_page() if either the page is not in the pagecache at all *or* is
not up to date.  I know this is slightly different logic than
generic_file_buffered_read() uses, and is suboptimal since the use of
read_mapping_page() causes a redundant pagecache lookup.  But we don't need to
squeeze out every possible bit of performance here.

Hmm, maybe it should only call page_cache_sync_readahead() when page == NULL
though.  I'll check the readahead code again.

> 
> > +		page_cache_sync_readahead(inode->i_mapping, ra, filp,
> > +					  index, num_pages_in_file -
> > index);
> > +		page = read_mapping_page(inode->i_mapping, index,
> > NULL);
> > +		if (IS_ERR(page))
> > +			return page;
> 
> Could we recieve the NULL pointer here? Is callee ready to process theNULL return value? 
> 

No, read_mapping_page() returns either a valid page or an ERR_PTR().

- Eric
