Return-Path: <linux-fsdevel+bounces-56432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998A7B17433
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 17:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9CE3BB9AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36941E377F;
	Thu, 31 Jul 2025 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVs28GOi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB0F9EC
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977123; cv=none; b=kmri/iJmItzT1q4REOPma1Y0NVfDHdZYeDYB7y+lQZbVDFGAdMjIWMXcbvJgOnGAIK2ViqOmRpJO4mUl0N34tAr4x+Zd3hgHZD1GD+z/ctQFl2jD07N87zMlF6zC5IwEV66Qv2xffK5u4G/+eNmMVkI3zBWnMO+BCgV3q8Lyn0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977123; c=relaxed/simple;
	bh=SXwwxEK6AMrdC2IscdyeJoFvTFl2aU7EgWm5B/OMN/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEXSqy203Uc/tsRmLOCRUD3Ytux01NMYXv9ow6Ebjag8T7coxhcCxV95O4dY2NQf6t2wneHHvsVM7t7PsyvV3iJjexTAqEFQU0xyFgXN/brpUXBPZc6IRwa7LVcTW4Hex7jgimST86J8gwOXS0GtK1CIbhuQj3jriLY1zsW/8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVs28GOi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753977120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ChbRYNOhT+2RIMCJSiBUSspWW0N4Q9P2RJl6xk18zwc=;
	b=WVs28GOizthd3Ok7jKj6l0cd6/pHJazGK/7ek6kjr7MZgeE3T4GwjRV62eeieC/zL6yugP
	4VLHxqLVbtkfztR5xLWBChomrJMgkJwL0v1vz+qoS2OgdTAF0OLvDQXA4sdP1WxRoYDa3S
	MdCYPZ5HNtw9c/3pF/cjvmxm92Zn3yI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-jWyqD46kPPmeMY1wYjRPRA-1; Thu, 31 Jul 2025 11:51:56 -0400
X-MC-Unique: jWyqD46kPPmeMY1wYjRPRA-1
X-Mimecast-MFC-AGG-ID: jWyqD46kPPmeMY1wYjRPRA_1753977115
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-af8fd22707eso61148066b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 08:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753977115; x=1754581915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChbRYNOhT+2RIMCJSiBUSspWW0N4Q9P2RJl6xk18zwc=;
        b=ehm4AOqERJxvVtG/ZrTCtlHFQ2NuxCJI6IcfjIDIwDsykSwu24dT8oxsAHX1HlvN1X
         QkahV2zkgcsLYeV3SkhmncNv1GpkvY4PV1+IgW5xmwblde8V/gRs5YdbBa5yWyHfK//V
         ITQqSc+bsGnXovsWXyyJNpaUJCthjU4VWTfz6XDXrO93mtnOZ901Y9n+lHp1HQJvRNKO
         b2FzcqxqUg2+gCbbtfD3iWT2xKaiXXN8dnTF9aBRUHKCZyQRPWH25lqui0RjDa+ROOUh
         gusDM7OwbJqPmLRPRTBok/twg9dkO81ntyYhEepM0ffBgrBh9jNcrMk90/AFRivo1Ord
         WjBw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ97ccvP+Q1/onQM/MtRQmHs/grRugInTPWYZbNt+FhRYsaW4q13qk4AzoVyGuQVgLRTz51Monn1rEm6Oh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sUgDwgaF8EpvyZoJRhJbr8t9PonxE0FvRMCbQ8tDhwmDfg28
	14/oYN/UYM46OuuI9c9dEjqgcaUxM4TBf3a+f9HcBIlt/B78d4qChqLaCIZqrumMADNg2gxm4Vu
	VuEeLIayer6XKQCm6jy1P1nN0R647zcyiM2KaB+dfOgZ1jrEYd+xkQa5BAPum59+m3A==
X-Gm-Gg: ASbGnctw0D7oKP3UT78ZJMbxRIWIugowaYjR/hK0kLEm9p+quqeGVEay0zGhxVehrI9
	z553robz0pS1ieJ5KARC19/4aKj7Ir+xrcgjDhGMgb2lgRFDj9bYQLjjgyOi990S4PrVtCl+MEZ
	QgYOVWekE9d9z418di7Opk4eN9YdPRSwrSi8p1xvUWbXIGTRyg5SxSx5g7gVywkn1tVr9xwA4eg
	yJ3a44PrAwVML+EJi+rEnwF0TSGF6r9q/bzKPo/R5vhGJBrO9H8RkgJ/E5ig0HCdbgymBjxaNS6
	kz+nRuUf16Ysdi8DmIRdORmjF7CzDraOEFq79pqbdi947wO8h6cBYED52yk=
X-Received: by 2002:a17:907:7f29:b0:ae3:6390:6acc with SMTP id a640c23a62f3a-af8fd779571mr986407566b.27.1753977114880;
        Thu, 31 Jul 2025 08:51:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF75RdwUB5Y0b5EIVLpUAjKn3EhM+tBDodaLzdReHKR78DYWEIlQ4Ol/f4t/myF3IxMYEnKOQ==
X-Received: by 2002:a17:907:7f29:b0:ae3:6390:6acc with SMTP id a640c23a62f3a-af8fd779571mr986404766b.27.1753977114384;
        Thu, 31 Jul 2025 08:51:54 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2a448sm1303087a12.20.2025.07.31.08.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:51:53 -0700 (PDT)
Date: Thu, 31 Jul 2025 17:51:52 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org, hch@lst.de, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 02/29] iomap: introduce iomap_read/write_region
 interface
Message-ID: <7ncij2xi3fun32c4iv3icwii3vj7r2wnks6hbghjo4ls3hj3ap@os3bmt5fvcpy>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-2-9e5443af0e34@kernel.org>
 <20250729222252.GJ2672049@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729222252.GJ2672049@frogsfrogsfrogs>

On 2025-07-29 15:22:52, Darrick J. Wong wrote:
> On Mon, Jul 28, 2025 at 10:30:06PM +0200, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > Interface for writing data beyond EOF into offsetted region in
> > page cache.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  include/linux/iomap.h  | 16 ++++++++
> >  fs/iomap/buffered-io.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 114 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 4a0b5ebb79e9..73288f28543f 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -83,6 +83,11 @@ struct vm_fault;
> >   */
> >  #define IOMAP_F_PRIVATE		(1U << 12)
> >  
> > +/*
> > + * Writes happens beyound inode EOF
> > + */
> > +#define IOMAP_F_BEYOND_EOF	(1U << 13)
> > +
> >  /*
> >   * Flags set by the core iomap code during operations:
> >   *
> > @@ -533,4 +538,15 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
> >  
> >  extern struct bio_set iomap_ioend_bioset;
> >  
> > +struct ioregion {
> > +	struct inode *inode;
> > +	loff_t pos;				/* IO position */
> > +	const void *buf;			/* Data to be written (in only) */
> > +	size_t length;				/* Length of the date */
> 
> Length of the data ?

thanks!

> 
> > +	const struct iomap_ops *ops;
> > +};
> 
> This sounds like a kiocb and a kvec...
> 
> > +
> > +struct folio *iomap_read_region(struct ioregion *region);
> > +int iomap_write_region(struct ioregion *region);
> 
> ...and these sound a lot like filemap_read and iomap_write_iter.
> Why not use those?  You'd get readahead for free.  Though I guess
> filemap_read cuts off at i_size so maybe that's why this is necessary?
> 
> (and by extension, is this why the existing fsverity implementations
> seem to do their own readahead and reading?)
> 
> ((and now I guess I see why this isn't done through the regular kiocb
> interface, because then we'd be exposing post-EOF data hiding to
> everyone in the system))
> 
> >  #endif /* LINUX_IOMAP_H */
> > 
> > -- 
> > 2.50.0
> > 
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 7bef232254a3..e959a206cba9 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -321,6 +321,7 @@ struct iomap_readpage_ctx {
> >  	bool			cur_folio_in_bio;
> >  	struct bio		*bio;
> >  	struct readahead_control *rac;
> > +	int			flags;
> 
> What flags go in here?

IOMAP_F_BEYOND_EOF

> 
> >  };
> >  
> >  /**
> > @@ -387,7 +388,8 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
> >  	if (plen == 0)
> >  		goto done;
> >  
> > -	if (iomap_block_needs_zeroing(iter, pos)) {
> > +	if (iomap_block_needs_zeroing(iter, pos) &&
> > +	    !(iomap->flags & IOMAP_F_BEYOND_EOF)) {
> >  		folio_zero_range(folio, poff, plen);
> >  		iomap_set_range_uptodate(folio, poff, plen);
> >  		goto done;
> > @@ -2007,3 +2009,98 @@ iomap_writepages_unbound(struct address_space *mapping, struct writeback_control
> >  	return iomap_submit_ioend(wpc, error);
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_writepages_unbound);
> > +
> > +struct folio *
> > +iomap_read_region(struct ioregion *region)
> > +{
> > +	struct inode *inode = region->inode;
> > +	fgf_t fgp = FGP_CREAT | FGP_LOCK | fgf_set_order(region->length);
> > +	pgoff_t index = (region->pos) >> PAGE_SHIFT;
> > +	struct folio *folio = __filemap_get_folio(inode->i_mapping, index, fgp,
> > +				    mapping_gfp_mask(inode->i_mapping));
> > +	int ret;
> > +	struct iomap_iter iter = {
> > +		.inode		= folio->mapping->host,
> > +		.pos		= region->pos,
> > +		.len		= region->length,
> > +	};
> > +	struct iomap_readpage_ctx ctx = {
> > +		.cur_folio	= folio,
> > +	};
> > +
> > +	if (folio_test_uptodate(folio)) {
> > +		folio_unlock(folio);
> > +		return folio;
> > +	}
> > +
> > +	while ((ret = iomap_iter(&iter, region->ops)) > 0)
> > +		iter.status = iomap_read_folio_iter(&iter, &ctx);
> 
> Huh, we don't read into region->buf?  Oh, I see, this gets iomap to
> install an uptodate folio in the pagecache, and then later we can
> just hand it to fsverity.  Maybe?

yes

> 
> --D
> 
> > +
> > +	if (ctx.bio) {
> > +		submit_bio(ctx.bio);
> > +		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
> > +	} else {
> > +		WARN_ON_ONCE(ctx.cur_folio_in_bio);
> > +		folio_unlock(folio);
> > +	}
> > +
> > +	return folio;
> > +}
> > +EXPORT_SYMBOL_GPL(iomap_read_region);
> > +
> > +static int iomap_write_region_iter(struct iomap_iter *iter, const void *buf)
> > +{
> > +	loff_t pos = iter->pos;
> > +	u64 bytes = iomap_length(iter);
> > +	int status;
> > +
> > +	do {
> > +		struct folio *folio;
> > +		size_t offset;
> > +		bool ret;
> 
> Is balance_dirty_pages_ratelimited_flags need here if we're at the dirty
> thresholds?

Ah I see, missed that, I will add it, thanks!

> 
> > +
> > +		bytes = min_t(u64, SIZE_MAX, bytes);
> > +		status = iomap_write_begin(iter, &folio, &offset, &bytes);
> > +		if (status)
> > +			return status;
> > +		if (iter->iomap.flags & IOMAP_F_STALE)
> > +			break;
> > +
> > +		offset = offset_in_folio(folio, pos);
> > +		if (bytes > folio_size(folio) - offset)
> > +			bytes = folio_size(folio) - offset;
> > +
> > +		memcpy_to_folio(folio, offset, buf, bytes);
> > +
> > +		ret = iomap_write_end(iter, bytes, bytes, folio);
> > +		if (WARN_ON_ONCE(!ret))
> > +			return -EIO;
> > +
> > +		__iomap_put_folio(iter, bytes, folio);
> > +		if (WARN_ON_ONCE(!ret))
> > +			return -EIO;
> > +
> > +		status = iomap_iter_advance(iter, &bytes);
> > +		if (status)
> > +			break;
> > +	} while (bytes > 0);
> > +
> > +	return status;
> > +}
> 
> Hrm, stripped down version of iomap_write_iter without the isize
> updates.

yes, it probably can be merged with a flag to skip the i_size
updates, I can look into this if it make more sense

> 
> --D
> 
> > +
> > +int
> > +iomap_write_region(struct ioregion *region)
> > +{
> > +	struct iomap_iter iter = {
> > +		.inode		= region->inode,
> > +		.pos		= region->pos,
> > +		.len		= region->length,
> > +	};
> > +	ssize_t ret;
> > +
> > +	while ((ret = iomap_iter(&iter, region->ops)) > 0)
> > +		iter.status = iomap_write_region_iter(&iter, region->buf);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(iomap_write_region);
> 

-- 
- Andrey


