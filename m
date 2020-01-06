Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A9B131987
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 21:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAFUoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 15:44:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgAFUoB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:44:01 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BADC20731;
        Mon,  6 Jan 2020 20:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578343440;
        bh=GCDF90PxaFvkCGdMTp6cM9sEWuA1IASP7woryXiIkio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kxR3BbcmfEd73kXxSYAqfsOmgdQ2Fcysz9TiL5R0c3beHGBb4GmNNZQGIw8h8advw
         otmHqxecH+g51yMiinkK+sU1bLicbT7jDFfAd82yOqB1479nS8FFz1NO8GvTpKAp5Z
         Ti9u2rTBVrn+51T4bSV4dyCcTRYh59GowGLGVluc=
Date:   Mon, 6 Jan 2020 12:43:58 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Victor Hsieh <victorhsieh@google.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] fs-verity: implement readahead of Merkle tree pages
Message-ID: <20200106204357.GA254289@gmail.com>
References: <20191216181112.89304-1-ebiggers@kernel.org>
 <20200106181508.GA50058@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106181508.GA50058@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 06, 2020 at 10:15:08AM -0800, Jaegeuk Kim wrote:
> >  static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
> > -					       pgoff_t index)
> > +					       pgoff_t index,
> > +					       unsigned long num_ra_pages)
> >  {
> > +	struct page *page;
> > +
> >  	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
> >  
> > -	return read_mapping_page(inode->i_mapping, index, NULL);
> > +	page = find_get_page(inode->i_mapping, index);
> > +	if (!page || !PageUptodate(page)) {
> > +		if (page)
> > +			put_page(page);
> > +		else if (num_ra_pages > 1)
> > +			f2fs_merkle_tree_readahead(inode->i_mapping, index,
> > +						   num_ra_pages);
> > +		page = read_mapping_page(inode->i_mapping, index, NULL);
> > +		if (IS_ERR(page))
> > +			return page;
> 
> We don't need to check this, but can use the below return page?
> 

Indeed, I'll remove the unnecessary IS_ERR(page) check.

> > +	}
> 
> mark_page_accessed(page)?
> 
> > +	return page;
> >  }

Good idea, but read_mapping_page() already calls mark_page_accessed().  It's
just find_get_page() that doesn't.  So after this patch, mark_page_accessed() is
no longer called in the case where the page is already cached and Uptodate.
I'll change it to use:

	find_get_page_flags(inode->i_mapping, index, FGP_ACCESSED);

- Eric
