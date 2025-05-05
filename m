Return-Path: <linux-fsdevel+bounces-48099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF5EAA9605
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7054B189AD00
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296925A2AD;
	Mon,  5 May 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRCyz3xi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245E502BE
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456025; cv=none; b=rQNaoNsU2Fh9ozMpdyXoNWfkXaA/hWlCYUSXbRnLmMiokBLBCc9mnWly1dYxr19/CMRR+Cmmoqnj6hqamrW7b1kj1bbk38Majnk2vi8zNGiTjJBQGyLK+rvViBw6FfZ4xw/cLzT1SKHCbq1eqD50C9Deo7w10t8cUZyM9VNT3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456025; c=relaxed/simple;
	bh=a5JF1f3KSzc+8SDppr09G8LCqIOWerH9TfWyXIdpkR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5bcCrk+X3y1bzizB3i5sIY/pEveyvgLgGv26K2ho1jtPnIzGbzT26IgCyIQNdf0g0E0+rP05v5F7pHEHdTUL8cbKPkFeB6zWab+OWg8pdBv7EilGXC30GBI2zrLE/DmgJI6B31/QMHi7E8zclNqIDd9fD59rcOufnmxwPVQZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRCyz3xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27924C4CEE4;
	Mon,  5 May 2025 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746456025;
	bh=a5JF1f3KSzc+8SDppr09G8LCqIOWerH9TfWyXIdpkR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IRCyz3xiyQN0PkNhb4PgnjCJKB4xkUGwtNdX4wno0lzGzoTGJIvGc5tyIy/p36Z1h
	 wj+U85L5ayFyRGw4IpllwY0Zx0q112hB0SaOZT/RPSTrIn/kPTAU69dgTEYHt+J3E8
	 4bfEZwhQ6gEYbtNZlCIP62x2LenjIP5Us60gb7uD7AxKDDQRaofu95BZgsu20KGPN4
	 cyYTonCiiVpuQklAz/AClCu5kF1rGN1j87cId3wzQVeu4kvXCEdjXbhG3KPcXU6pvj
	 WmUTY1Ao7sZyNIAPhghJy0suBVojZ+gFiNPhmu/toqziyHL4pDPtMniHyZOnvj9RL3
	 T2nY02V92YD8w==
Date: Mon, 5 May 2025 07:40:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
	jefflexu@linux.alibaba.com, josef@toxicpanda.com,
	willy@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH v5 09/11] fuse: support large folios for readahead
Message-ID: <20250505144024.GK1035866@frogsfrogsfrogs>
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-10-joannelkoong@gmail.com>
 <007d07bf-4f0b-4f4c-af59-5be85c43fca3@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007d07bf-4f0b-4f4c-af59-5be85c43fca3@fastmail.fm>

On Sun, May 04, 2025 at 09:13:44PM +0200, Bernd Schubert wrote:
> 
> 
> On 4/26/25 02:08, Joanne Koong wrote:
> > Add support for folios larger than one page size for readahead.
> > 
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/fuse/file.c | 36 +++++++++++++++++++++++++++---------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 1d38486fae50..9a31f2a516b9 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -876,14 +876,13 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
> >  	fuse_io_free(ia);
> >  }
> >  
> > -static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
> > +static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
> > +				unsigned int count)
> >  {
> >  	struct fuse_file *ff = file->private_data;
> >  	struct fuse_mount *fm = ff->fm;
> >  	struct fuse_args_pages *ap = &ia->ap;
> >  	loff_t pos = folio_pos(ap->folios[0]);
> > -	/* Currently, all folios in FUSE are one page */
> > -	size_t count = ap->num_folios << PAGE_SHIFT;
> >  	ssize_t res;
> >  	int err;
> >  
> > @@ -918,6 +917,7 @@ static void fuse_readahead(struct readahead_control *rac)
> >  	struct inode *inode = rac->mapping->host;
> >  	struct fuse_conn *fc = get_fuse_conn(inode);
> >  	unsigned int max_pages, nr_pages;
> > +	struct folio *folio = NULL;
> >  
> >  	if (fuse_is_bad(inode))
> >  		return;
> > @@ -939,8 +939,8 @@ static void fuse_readahead(struct readahead_control *rac)
> >  	while (nr_pages) {
> >  		struct fuse_io_args *ia;
> >  		struct fuse_args_pages *ap;
> > -		struct folio *folio;
> >  		unsigned cur_pages = min(max_pages, nr_pages);
> > +		unsigned int pages = 0;
> >  
> >  		if (fc->num_background >= fc->congestion_threshold &&
> >  		    rac->ra->async_size >= readahead_count(rac))
> > @@ -952,10 +952,12 @@ static void fuse_readahead(struct readahead_control *rac)
> >  
> >  		ia = fuse_io_alloc(NULL, cur_pages);
> >  		if (!ia)
> > -			return;
> > +			break;
> >  		ap = &ia->ap;
> >  
> > -		while (ap->num_folios < cur_pages) {
> > +		while (pages < cur_pages) {
> > +			unsigned int folio_pages;
> > +
> >  			/*
> >  			 * This returns a folio with a ref held on it.
> >  			 * The ref needs to be held until the request is
> > @@ -963,13 +965,29 @@ static void fuse_readahead(struct readahead_control *rac)
> >  			 * fuse_try_move_page()) drops the ref after it's
> >  			 * replaced in the page cache.
> >  			 */
> > -			folio = __readahead_folio(rac);
> > +			if (!folio)
> > +				folio =  __readahead_folio(rac);
> > +
> > +			folio_pages = folio_nr_pages(folio);
> > +			if (folio_pages > cur_pages - pages)
> > +				break;
> > +
> 
> Hmm, so let's assume this would be a 2MB folio, but fc->max_pages is
> limited to 1MB - we not do read-ahead anymore?

It's hard for me to say without seeing the actual enablement patches,
but filesystems are supposed to call mapping_set_folio_order_range to
constrain the sizes of the folios that the pagecache requests.

--D

> Thanks,
> Bernd
> 
> 
> >  			ap->folios[ap->num_folios] = folio;
> >  			ap->descs[ap->num_folios].length = folio_size(folio);
> >  			ap->num_folios++;
> > +			pages += folio_pages;
> > +			folio = NULL;
> > +		}
> > +		if (!pages) {
> > +			fuse_io_free(ia);
> > +			break;
> >  		}
> > -		fuse_send_readpages(ia, rac->file);
> > -		nr_pages -= cur_pages;
> > +		fuse_send_readpages(ia, rac->file, pages << PAGE_SHIFT);
> > +		nr_pages -= pages;
> > +	}
> > +	if (folio) {
> > +		folio_end_read(folio, false);
> > +		folio_put(folio);
> >  	}
> >  }
> >  
> 
> 

