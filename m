Return-Path: <linux-fsdevel+bounces-73423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8346D18B14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 13:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D9CA3069D77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDFD38F237;
	Tue, 13 Jan 2026 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuU0G5mk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4hupmd2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E5346AF7
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306993; cv=none; b=B0+pAFaKgORdHfynDGL63j6hb/vzj4Faor2covQQ0VUUazda6E7LUYk0QM86jBsFY8lijr/PEvfFZweEnXH1h+bFPLWX34JpYONAkdT7kAvS0Mr1m2CGldhIQ6t2THA0n7ZdQ6utg9dPAEQ/gbiAl8zlNdYqKnA0d49XbAiAxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306993; c=relaxed/simple;
	bh=Tg/j/+VkXSR2euQ1Kk7x1AhIGsUY+p/+rckmcuTxqY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVYjnEqIABh62y4iWTxyVnME0I17bzGao8XEnVkACxf+8uRkUcY7BVymaVNIwAdYQKNoPgb3K5ntY6i3JCaHsi+KZ+PGpBowBE6n6+IE54VRq08+06yDA6HdhikwnEC42Rp8ia9N1alHQjEMen2fBOTQfDJRCMOViMJrJn7p+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RuU0G5mk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4hupmd2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768306991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/TuVoqMaQZ1pYUPaWYEfmSsILrC0krVKandDz6n8dcw=;
	b=RuU0G5mkYIQaF+stY9Ynsp5kskAIzvxwXiPI7n3DWx29pcSCQfSeyfsvdDC5TRznKSqTek
	1aadw+cKQ99icJbV9MhN+nixhAD1qmRstSoaGklFhG/OGaZ0HGEQmTGEsH0+8r3TYTpJBS
	zSVrM/SvPV2536iriqdrWVC1RE3cEnA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-p5Ll9UvrN8CEzMDcjr2mNQ-1; Tue, 13 Jan 2026 07:23:09 -0500
X-MC-Unique: p5Ll9UvrN8CEzMDcjr2mNQ-1
X-Mimecast-MFC-AGG-ID: p5Ll9UvrN8CEzMDcjr2mNQ_1768306988
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso33198045e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 04:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768306988; x=1768911788; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/TuVoqMaQZ1pYUPaWYEfmSsILrC0krVKandDz6n8dcw=;
        b=F4hupmd2A58xwE+7th8f+rw7Kl3fmtKnCy6/j9HDMF64XD9T4y8hl1tuxgzTa83KNA
         /SjJjNy6Uiz5nfOcl9srkDmtYGpjGe0QUT88Vx8eBAAzFCD2s/IRh6YrAJ4L72fQkTcY
         pmdquOSz0L9reOLv4U6h8gpFVL54sSR/YSUraBkoERbaU6069diIzqFFAim1/zt2go1c
         QJr5HVpnjbNzEWmI/MvR4q2GI7E64u+guop4a0tvl4wTl/Vavm8ufJsBq3NU6fBz92Ud
         JRGW/8LZOqWwGpM5nGAaxzH0jfFVJW2S6Sj8W89fCJoLGVYB9bKoP0cD7tsWT2fYuJMK
         ke4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306988; x=1768911788;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TuVoqMaQZ1pYUPaWYEfmSsILrC0krVKandDz6n8dcw=;
        b=imWMMam4FFU+GFPqrN3aE5JuRE9eFQeJhSNOz3HGPxzu7BqFJQsIIrwk/1RLOtKQ11
         4qfpUKISiCW2vDo0ssPl8IXdonxvoskRBVLXvyfuZk+88yu38N/bvrScp41DJhkKmAvC
         5Kd1T39matr2y5SSbtvVZ8LHc1mhsmR2Cv9j0jUmp11G8c/0ZCp9Ot15xfxtxIXpCPTA
         Kjsn1DDKfco8m6u2sZl8Q0p9eMAH49AG3AczyIIgbSR3g85tx+HiB4Kc07cJ6XI1fW4/
         +jaepUPawwycnH5AcqUCVUysvHI37tAHd/ibRsbfNx7dOSnawcX9+tYHVisepTZcaMg7
         r7zg==
X-Forwarded-Encrypted: i=1; AJvYcCVgPX7zTASk9XY7X27vNkOCX4Z539CfsnY4V8H5R0ACmRqPoEpLkaV+oVWQjYM1SywmuqyQFbtRExlwiX0f@vger.kernel.org
X-Gm-Message-State: AOJu0YyZSzfcMbpRAwuiJ81V9gDg/FKwzkX66ny0OppOB+qInE3GmAZ5
	l3Dyv1DdK0VBjKPSsKxRsAyjquXJ41NQbCpNCW274mvyGDENPKT0AqpLlAH99IjMHDDlChzfREW
	jyVIriHrb7o5ADmn+Q/W8IbvbtJHtTLCFlJI217sVF50THidtYNNJftruPLaD65f70w==
X-Gm-Gg: AY/fxX6R3Gu9o/Mqpc+o6OSb83ZKfIF1Azrv9rgIQF0VHs3cU/I9PIBecUY2lwEcxT/
	CRQm38FBNx0A0bSWSmDWm8mUWV5TA+91h9bqqfyi3L5IMbeAMWuKJ0aJiPzRp5pQiUeKwlxDzYr
	6D0isSLQLsSLQjJGuhntmjWnNGGywLhjiA+MVK3TDR0etKwKs3VrwKTf+45B4qoL6ofYx7aFKK1
	hMWSHGoQ8RpkgAsUpmN9j6eySBPeSJbHcBvfy4P5ZNsdonIZRSyKGN2OQ2N4slGbR3yuOIcKPtm
	zL3BzweVy8rIPJvrsCCS6NCGUX6cuLrGI01gdkDtHOekeD1MC7r4EpPc62NBHXzPgqpZuVS1zEU
	=
X-Received: by 2002:a05:600c:c48f:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-47ed7bfd511mr35482135e9.4.1768306988358;
        Tue, 13 Jan 2026 04:23:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr0RACpmZBlMe7kT+6LC1QjSW7gAHd8MZ6pSzcyVRIgTjA8m3UJl2GbG2kQczOY+RVn3cfeA==
X-Received: by 2002:a05:600c:c48f:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-47ed7bfd511mr35481655e9.4.1768306987799;
        Tue, 13 Jan 2026 04:23:07 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm43942503f8f.29.2026.01.13.04.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:23:07 -0800 (PST)
Date: Tue, 13 Jan 2026 13:23:06 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 13/22] xfs: introduce XFS_FSVERITY_REGION_START
 constant
Message-ID: <5ax7476dl472kpg3djnlojoxo2k4pmfbzwzsw4mo4jnaoqumeh@t3l4aesjfhwz>
References: <cover.1768229271.patch-series@thinky>
 <qwtd222f5dtszwvacl5ywnommg2xftdtunco2eq4sni4pyyps7@ritrh57jm2eg>
 <20260112224631.GO15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112224631.GO15551@frogsfrogsfrogs>

On 2026-01-12 14:46:31, Darrick J. Wong wrote:
> On Mon, Jan 12, 2026 at 03:51:25PM +0100, Andrey Albershteyn wrote:
> > This constant defines location of fsverity metadata in page cache of
> > an inode.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/xfs/libxfs/xfs_fs.h | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+), 0 deletions(-)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> > index 12463ba766..b73458a7c2 100644
> > --- a/fs/xfs/libxfs/xfs_fs.h
> > +++ b/fs/xfs/libxfs/xfs_fs.h
> > @@ -1106,4 +1106,26 @@
> >  #define BBTOB(bbs)	((bbs) << BBSHIFT)
> >  #endif
> >  
> > +/* Merkle tree location in page cache. We take memory region from the inode's
> 
> Dumb nit: new line after opening the multiline comment.
> 
> /*
>  * Merkle tree location in page cache...
> 
> also, isn't (1U<<53) the location of the Merkle tree ondisk in addition
> to its location in the page cache?

yes, it's file offset

> 
> That occurs to me, what happens on 32-bit systems where the pagecache
> can only address up to 16T of data?  Maybe we just don't allow fsverity
> on 32-bit xfs.

hmm right, check in begin_enable() will be probably enough

> 
> > + * address space for Merkle tree.
> > + *
> > + * At maximum of 8 levels with 128 hashes per block (32 bytes SHA-256) maximum
> > + * tree size is ((128^8 − 1)/(128 − 1)) = 567*10^12 blocks. This should fit in 53
> > + * bits address space.
> > + *
> > + * At this Merkle tree size we can cover 295EB large file. This is much larger
> > + * than the currently supported file size.
> > + *
> > + * For sha512 the largest file we can cover ends at 1 << 50 offset, this is also
> > + * good.
> > + *
> > + * The metadata is stored on disk as follows:
> > + *
> > + *	[merkle tree...][descriptor.............desc_size]
> > + *	^ (1 << 53)     ^ (block border)                 ^ (end of the block)
> > + *	                ^--------------------------------^
> > + *	                Can be FS_VERITY_MAX_DESCRIPTOR_SIZE
> > + */
> > +#define XFS_FSVERITY_REGION_START (1ULL << 53)
> 
> Is this in fsblocks or in bytes?  I think the comment should state that
> explicitly.

sure, will add it

-- 
- Andrey


