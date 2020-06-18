Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172ED1FFADC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 20:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgFRSN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 14:13:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgFRSN7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:13:59 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B07B207DD;
        Thu, 18 Jun 2020 18:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592504038;
        bh=bwNYqgDUO017MhDp1XZiVpKnHtAB2QtXNRfOAYLMONc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nj44c8BDwdwmj65JkoVS7rOTVPn0mr7uCVkNf9JjQIUmN1TkxqZsq8p9c/xPrAllH
         1fQ5ghO5VRsv0ISAMty3/l8dm+CnP14pR6qAK5LfXlE8bhRsRzR7dUM1T+8sIbmv+w
         I3wY+qmuCvXhbP18xDxhx5u/HRrxT2uha+9wwD64=
Date:   Thu, 18 Jun 2020 11:13:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Satya Tangirala <satyat@google.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/4] f2fs: add inline encryption support
Message-ID: <20200618181357.GC2957@sol.localdomain>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-4-satyat@google.com>
 <5e78e1be-f948-d54c-d28e-50f1f0a92ab3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e78e1be-f948-d54c-d28e-50f1f0a92ab3@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chao,

On Thu, Jun 18, 2020 at 06:06:02PM +0800, Chao Yu wrote:
> > @@ -936,8 +972,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
> >  
> >  	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> >  
> > -	if (io->bio && !io_is_mergeable(sbi, io->bio, io, fio,
> > -			io->last_block_in_bio, fio->new_blkaddr))
> > +	if (io->bio &&
> > +	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
> > +			      fio->new_blkaddr) ||
> > +	     !f2fs_crypt_mergeable_bio(io->bio, fio->page->mapping->host,
> > +				       fio->page->index, fio)))
> 
> bio_page->index, fio)))
> 
> >  		__submit_merged_bio(io);
> >  alloc_new:
> >  	if (io->bio == NULL) {
> > @@ -949,6 +988,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
> >  			goto skip;
> >  		}
> >  		io->bio = __bio_alloc(fio, BIO_MAX_PAGES);
> > +		f2fs_set_bio_crypt_ctx(io->bio, fio->page->mapping->host,
> > +				       fio->page->index, fio, GFP_NOIO);
> 
> bio_page->index, fio, GFP_NOIO);
> 

We're using ->mapping->host and ->index.  Ordinarily that would mean the page
needs to be a pagecache page.  But bio_page can also be a compressed page or a
bounce page containing fs-layer encrypted contents.

Is your suggestion to keep using fio->page->mapping->host (since encrypted pages
don't have a mapping), but start using bio_page->index (since f2fs apparently
*does* set ->index for compressed pages, and if the file uses fs-layer
encryption then f2fs_set_bio_crypt_ctx() won't use the index anyway)?

Does this mean the code is currently broken for compression + inline encryption
because it's using the wrong ->index?  I think the answer is no, since
f2fs_write_compressed_pages() will still pass the first 'nr_cpages' pagecache
pages along with the compressed pages.  In that case, your suggestion would be a
cleanup rather than a fix?

It would be helpful if there was an f2fs mount option to auto-enable compression
on all files (similar to how test_dummy_encryption auto-enables encryption on
all files) so that it could be tested more easily.

- Eric
