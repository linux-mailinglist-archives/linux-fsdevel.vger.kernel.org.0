Return-Path: <linux-fsdevel+bounces-56298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EE4B156C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 02:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A2B7AAD98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 00:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BFC16F265;
	Wed, 30 Jul 2025 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="DbsWvAkt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8435966
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753836731; cv=none; b=TZaOYBEeGoLj3wNEaOgB8bORm67kc01/940cExk5/DUsBjgVqcwl0sG0P9WvUXr7Mndf9cQlvX+EBo96bL6gPZBB8PsI1McOdiCKAL1kcws7tgMOWFZ5faCcMXuhVNBKUPmHm9OPUlV0qzUxPuoUHWE1J0Bycg6aC+QsJKnUpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753836731; c=relaxed/simple;
	bh=K55yfrmOAgZyuht6by9RhaCl9tnqxjffX2Sf34/XSXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMvAzbKJqGADR0ZRR3w2q6IXOboTuk4CvJaI66w+hHgGstLg+eBoDNa4jizZiVhpwCkHc1fF5fR9FPzQCKkU7MsOZLtODN7a6JwtTydqODNpn2GtWZaspbG7pKWLdTKXA/uC157C+RnYtzw44q2vicEkHv8eMNyA4/NWL6bIE+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=DbsWvAkt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24009eeb2a7so27480605ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 17:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1753836728; x=1754441528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3+0fPD4oAPKgGx3/6LlKQLIWFdF50ERDWtVLnGX0c4=;
        b=DbsWvAktSLQ1q9fV8KALw0+r98lpxiPmqf/2V1w4xB+PJREVmlF/M3lUOj3vb7id46
         MsXaONMIE2c814J8VQzYO9/8W30oHV1GNYDnUsSQ4mIpdrcSDN9W9bsEccKAiBL2LmHl
         41aubhn+Yqr6zsx9DcGCWkF1slzbkIFrFRr7vGXSFHuY6CGqfIe63Ljcn2dptkHBwvpp
         ItcV2cE1PpeaSj6Yq8T7X7/gf7lSV98OY+Xx9fVX9l6SgJPpQbwwpHAOp18Zv6es3X2v
         mVUw41y16xgZsT06zLEmkH12O0JZUpZVgy/+V7LKJv5rab1CLCrqilPq4FJN6cvq8qQL
         xQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753836728; x=1754441528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3+0fPD4oAPKgGx3/6LlKQLIWFdF50ERDWtVLnGX0c4=;
        b=OwFpKYUovzON8d5i1tZ7iJLoLn8uvgnx+PaBUXvv/FJaCyK+Q/bqsoX0sJ4mlB8BHX
         B43HtTjR8Yp7Zsq2rrOHSm2XU+KYhyB9CuEJytA7poeiBWv6lrOiFNvDfv3ijVUmLp7e
         flsPUBh+iV6hNrvqkexptjbMHYC1uEb+b3s8+aLTbZYJQ5dI9/xNFkI5n/CGF84iMYTB
         C4kJZclFrdJ5XA+y5Xufq0+DzS8ueRknXE9hDYiEBb+0Wf346RYvAHFgnDVipEZnZwGc
         jT4gAv//PWc36I0fibbO2CHHg08qUXULVQ6BYXvgNHmG0hngcHStMykuQ/QRtU8m3nf5
         Q8/w==
X-Forwarded-Encrypted: i=1; AJvYcCXNzyBKXafiNjoAUsVpXHOus+A/W9s4w/OgC6NOwxlxZ4MfLKugYnwfGJRDuo4KxNTHcqch9z13hh1OVs0j@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/We96KaOC18l2QgBaXRkRZTIyfqWL8MH/u2mqe5wC8kVGhGm3
	bBvemZApz2F5vOV20M3gO9uscFhq3kSryR//wVvgxf+eBCTznH+ERkmUQ7xwvZ9vSg4=
X-Gm-Gg: ASbGncsMJlrIY+2vtCPSG3/2O6orYvKcUt4qjLspvbx6Y3NByd7H8AFK/ao+HR0EfFS
	C2vN7WCmCx1vuTo2mu2cmqDcCYKPz9bdiKUdKjFB0G1dETRrQRl7cm/ycI5BzzFCHg5fStiwRdO
	XaKIzQOUQPptJ5rXac1cbepGUpJ9xuJC5ax5Tw9Ly4AxUE5ewvjGgXj3IhBbf/giUL6GUSKIr7g
	EWpoTH2fOvGPFBki+h9j2b0XD0rK0fB6c9/cD/cvnl8eYWj2B7rgIO0NlP52mzhOlAQ0NUerUBf
	PSUv+dWr9svoWc5W7rc0rj/mEIPUdSI1sn8KTZUyzOn3X9zi3ZvZ/qoOzhp+edcpiSaOPILdIjg
	nqiebP+ly0a4HFNy/16k0gJ/Ad/GkgXMQp9uD+D5EsytJrDtXjxVVO+F4RUO5eLG6ZgBRmyMbln
	Jg/x89rQOC
X-Google-Smtp-Source: AGHT+IHkORekrsc1P7gAq4NM+SMvbGxBMz8RFSwmBgPVjXtpoGecdqjtTizgxax0+6dsRPmU0LGDIQ==
X-Received: by 2002:a17:902:d482:b0:234:986c:66bf with SMTP id d9443c01a7336-24096a4f534mr17428045ad.11.1753836727661;
        Tue, 29 Jul 2025 17:52:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-64-170.pa.nsw.optusnet.com.au. [49.181.64.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fe648707asm76888805ad.135.2025.07.29.17.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 17:52:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1ugv36-0000000HNDV-0H38;
	Wed, 30 Jul 2025 10:52:04 +1000
Date: Wed, 30 Jul 2025 10:52:04 +1000
From: Dave Chinner <david@fromorbit.com>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-raid@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: align writeback to RAID stripe boundaries
Message-ID: <aIlstOWckYGw34rM@dread.disaster.area>
References: <55deda1d-967d-4d68-a9ba-4d5139374a37@cybernetics.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55deda1d-967d-4d68-a9ba-4d5139374a37@cybernetics.com>

On Tue, Jul 29, 2025 at 12:13:42PM -0400, Tony Battersby wrote:
> Improve writeback performance to RAID-4/5/6 by aligning writes to stripe
> boundaries.  This relies on io_opt being set to the stripe size (or
> a multiple) when BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE is set.

This is the wrong layer to be pulling filesystem write alignments
from.

Filesystems already have alignment information in their on-disk
formats. XFS has stripe unit and stripe width information in the
filesysetm superblock that is set by mkfs.xfs.

This information comes from the block device io-opt/io-min values
exposed to userspace at mkfs time, so the filesystem already knows
what the optimal IO alignment parameters are for the storage stack
underneath it.

Indeed, we already align extent allocations to these parameters, so
aligning filesystem writeback to the same configured alignment makes
a lot more sense than pulling random stuff from block devices during
IO submission...

> @@ -1685,81 +1685,118 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  		struct inode *inode, loff_t pos, loff_t end_pos,
>  		unsigned len)
>  {
> -	struct iomap_folio_state *ifs = folio->private;
> -	size_t poff = offset_in_folio(folio, pos);
> -	unsigned int ioend_flags = 0;
> -	int error;
> -
> -	if (wpc->iomap.type == IOMAP_UNWRITTEN)
> -		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
> -	if (wpc->iomap.flags & IOMAP_F_SHARED)
> -		ioend_flags |= IOMAP_IOEND_SHARED;
> -	if (folio_test_dropbehind(folio))
> -		ioend_flags |= IOMAP_IOEND_DONTCACHE;
> -	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
> -		ioend_flags |= IOMAP_IOEND_BOUNDARY;
> +	struct queue_limits *lim = bdev_limits(wpc->iomap.bdev);
> +	unsigned int io_align =
> +		(lim->features & BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE) ?
> +		lim->io_opt >> SECTOR_SHIFT : 0;

i.e. this alignment should come from the filesystem, not the block
device.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

