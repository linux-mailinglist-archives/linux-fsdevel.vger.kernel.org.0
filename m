Return-Path: <linux-fsdevel+bounces-56427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABECB173AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419A816D4F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 15:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C61A5B99;
	Thu, 31 Jul 2025 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZy2WWft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04DEAC6
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974273; cv=none; b=Ei9rCVyAF+O5I2iJJ11fEJ1krHbmBBZcaSA8StARhVAI4F9Tsll3aDsU9zzrw8H7Ml/Ia/9aouQFLGM8QPaod1fZyvgAFtjrwJlIMpNKUsDF+mpCtRbnPxnvEgrotzMOw1lyfFyXckKngV9niVJy3JVyyRM/tClPzSmy6RHLudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974273; c=relaxed/simple;
	bh=l2A8KqcNihaR78kVgz4RRAisascIyaPt/Bghlwi1/UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKdYTeLrLux5PYKsoqkLwf2CDJOhCQlTbjx9ElF9v85VIxAKzmHYf9O1ABtjNWbAAweabH4kPvfMijV+yP4LrAIrJ8SqgCFxg23sszEdE1lW3QEbWzaXoijtUBAgMFjURheck5UF6QRbUflrhQ3Xt4rvWvNiud7LXyb/E5OBhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZy2WWft; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753974271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ITeDGbZ2O04OUGrMEksyGPJeLffXN0Jxej6Zs+oslg=;
	b=RZy2WWfteZPfiubd6vtsbFXPducxdblZo9ahfr3RnDZYlElbQBL8WVaYHXh/pyz7PdCpOP
	4DrvKCpG4Xnd7HcSh0xsv6NrvE4sBr8k6IIN6sA6Hz4r6wrfq8BGLqZhJKQrNFDacLCojC
	ToAAyit/O2pZ0ojGY1V1lzj7yz3fqZ4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624--2vw_f5zN-uxoTtWLLkOmg-1; Thu, 31 Jul 2025 11:04:29 -0400
X-MC-Unique: -2vw_f5zN-uxoTtWLLkOmg-1
X-Mimecast-MFC-AGG-ID: -2vw_f5zN-uxoTtWLLkOmg_1753974268
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-adb32dbf60bso90546266b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 08:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753974268; x=1754579068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ITeDGbZ2O04OUGrMEksyGPJeLffXN0Jxej6Zs+oslg=;
        b=XvgE3GBMhcdJaxRfFWNlgweNdEp926B3ul9ia2FrIiXPJ6vgjDNFyD73Ayoj1FphdM
         BPdcPTx9fu0BtFNnO1HSYtTaWiDAOoRhx36t2X4A6CKQKDmrgIQxQMSsTtfQI5lPzwKa
         ZIEazNFJApkx53S2pNClu4SBSTMoNkYgsaw/r0una1dUppl5yW3DC6YFaDX4ZgaNhrij
         GRT9A2OmzvxFYagLPKc69j0J+iaiwh++xZ2YxkERA+5jI4Hc2c4VvY5KR9S6ewjih3z3
         DrH31FAPFvMlxpCchMNWleYYyhXB1jgRxGqOOnc6+nVxqyoJI7yG7GDzduXuemCiUNV3
         FVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvSmQrLESNLqUSBaAmjj/xRxa1Q225x3z7bed+3tB8daUj15Yc0+VWp5zkcyGKfYTqMfm1aanPmH9mzxy5@vger.kernel.org
X-Gm-Message-State: AOJu0YwihSGhEzshX52QYkivl1EFc0Mdo2cdD1D6RgyGBglsUED832uA
	U+kuKXegSuaVUudSrHjU9x4jhy59FXnA3LyqXL0yBlL5BVkY/7yWbwkWxuKsMfutu86pF9hd9cM
	skcrSfjOdk+V2Kq+D5QgUfDSWIhgR1DJvKHyQl8Npgi4VoWoTiyS4XuzKQAOTezeslg==
X-Gm-Gg: ASbGncvRf2juNCcH9g180AHTr9sAMjaFwlRW0nDPE0MyP/2VbU4Wq52vEoAvzQuwpb6
	L+/Y1ecxBf/UyPdrv4em5ECbKeLXGZgaGSnXx3kVl7HrBjHqDWkWHsrQWhEGq5+z47KO1Oj0x9+
	q+c8XISeV7JbboU88dK+fQ2HqjO6StVjVa4avG2vxmee/pGJTzn4KLZjQ2l9gEj2qghKKT+R8Ff
	rH9Nai67u1u1PFGZKvHt/bqk8bsBQJUwpduDBFaFZoxlf32BrbAXG5yN2bw5VlvurG+CPksE2u0
	TVvepznQw/tNvoMK1pGGP1uN51WeFGzyxFqrdCmbPHaJfOsd5FLDbbU0sBo=
X-Received: by 2002:a17:907:7b86:b0:af9:29c1:1103 with SMTP id a640c23a62f3a-af929c113ccmr49447966b.55.1753974267469;
        Thu, 31 Jul 2025 08:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2H4LIPL12j3qW/yGGCCmOnDSbqpel+xd+fEj1NOlXlMnjHTd1aHsEE2cdwQmPhM7OdTqi5w==
X-Received: by 2002:a17:907:7b86:b0:af9:29c1:1103 with SMTP id a640c23a62f3a-af929c113ccmr49440766b.55.1753974266858;
        Thu, 31 Jul 2025 08:04:26 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0def2esm119318666b.61.2025.07.31.08.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:04:26 -0700 (PDT)
Date: Thu, 31 Jul 2025 17:04:25 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org, hch@lst.de, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 01/29] iomap: add iomap_writepages_unbound() to write
 beyond EOF
Message-ID: <b5mblbmz32iobfmsg2remrevgrb3fqzlg463mwycruzmxpjdrk@dm54azica6xr>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-1-9e5443af0e34@kernel.org>
 <20250729220743.GI2672049@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729220743.GI2672049@frogsfrogsfrogs>

On 2025-07-29 15:07:43, Darrick J. Wong wrote:
> On Mon, Jul 28, 2025 at 10:30:05PM +0200, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > Add iomap_writepages_unbound() without limit in form of EOF. XFS
> > will use this to write metadata (fs-verity Merkle tree) in range far
> > beyond EOF.
> 
> ...and I guess some day fscrypt might use it to encrypt merkle trees
> too?

Probably, then, the region offsets will need to be adjusted also.

> 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/iomap/buffered-io.c | 51 +++++++++++++++++++++++++++++++++++++++-----------
> >  include/linux/iomap.h  |  3 +++
> >  2 files changed, 43 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 3729391a18f3..7bef232254a3 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1881,18 +1881,10 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  	int error = 0;
> >  	u32 rlen;
> >  
> > -	WARN_ON_ONCE(!folio_test_locked(folio));
> > -	WARN_ON_ONCE(folio_test_dirty(folio));
> > -	WARN_ON_ONCE(folio_test_writeback(folio));
> > -
> > -	trace_iomap_writepage(inode, pos, folio_size(folio));
> > -
> > -	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> > -		folio_unlock(folio);
> > -		return 0;
> > -	}
> >  	WARN_ON_ONCE(end_pos <= pos);
> >  
> > +	trace_iomap_writepage(inode, pos, folio_size(folio));
> > +
> >  	if (i_blocks_per_folio(inode, folio) > 1) {
> >  		if (!ifs) {
> >  			ifs = ifs_alloc(inode, folio, 0);
> > @@ -1956,6 +1948,23 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  	return error;
> >  }
> >  
> > +/* Map pages bound by EOF */
> > +static int iomap_writepage_map_eof(struct iomap_writepage_ctx *wpc,
> 
> iomap_writepage_map_within_eof ?

sure

> 
> > +		struct writeback_control *wbc, struct folio *folio)
> > +{
> > +	int error;
> > +	struct inode *inode = folio->mapping->host;
> > +	u64 end_pos = folio_pos(folio) + folio_size(folio);
> > +
> > +	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> > +		folio_unlock(folio);
> > +		return 0;
> > +	}
> > +
> > +	error = iomap_writepage_map(wpc, wbc, folio);
> > +	return error;
> > +}
> > +
> >  int
> >  iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
> >  		struct iomap_writepage_ctx *wpc,
> > @@ -1972,9 +1981,29 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
> >  			PF_MEMALLOC))
> >  		return -EIO;
> >  
> > +	wpc->ops = ops;
> > +	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
> > +		WARN_ON_ONCE(!folio_test_locked(folio));
> > +		WARN_ON_ONCE(folio_test_dirty(folio));
> > +		WARN_ON_ONCE(folio_test_writeback(folio));
> > +
> > +		error = iomap_writepage_map_eof(wpc, wbc, folio);
> > +	}
> > +	return iomap_submit_ioend(wpc, error);
> > +}
> > +EXPORT_SYMBOL_GPL(iomap_writepages);
> > +
> > +int
> > +iomap_writepages_unbound(struct address_space *mapping, struct writeback_control *wbc,
> 
> Might want to leave a comment here explaining what's the difference
> between the two iomap_writepages exports:
> 
> /*
>  * Write dirty pages, including any beyond EOF.  This is solely for use
>  * by files that allow post-EOF pagecache, which means fsverity.
>  */

sure, thanks!

> 
> > +		struct iomap_writepage_ctx *wpc,
> > +		const struct iomap_writeback_ops *ops)
> > +{
> > +	struct folio *folio = NULL;
> > +	int error;
> > +
> 
> ...and you might want a:
> 
> 	WARN_ON(!IS_VERITY(wpc->inode));
> 
> to keep it that way.

yup, make sense, thanks!

> 
> --D
> 
> >  	wpc->ops = ops;
> >  	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
> >  		error = iomap_writepage_map(wpc, wbc, folio);
> >  	return iomap_submit_ioend(wpc, error);
> >  }
> > -EXPORT_SYMBOL_GPL(iomap_writepages);
> > +EXPORT_SYMBOL_GPL(iomap_writepages_unbound);
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 522644d62f30..4a0b5ebb79e9 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -464,6 +464,9 @@ void iomap_sort_ioends(struct list_head *ioend_list);
> >  int iomap_writepages(struct address_space *mapping,
> >  		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
> >  		const struct iomap_writeback_ops *ops);
> > +int iomap_writepages_unbound(struct address_space *mapping,
> > +		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
> > +		const struct iomap_writeback_ops *ops);
> >  
> >  /*
> >   * Flags for direct I/O ->end_io:
> > 
> > -- 
> > 2.50.0
> > 
> > 
> 

-- 
- Andrey


