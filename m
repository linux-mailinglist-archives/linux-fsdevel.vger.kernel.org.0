Return-Path: <linux-fsdevel+bounces-21795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1355890A1CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 03:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3525BB21B32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 01:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9FDDD7;
	Mon, 17 Jun 2024 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="pHFdfnjb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD0A79F0
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2024 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587788; cv=none; b=XxRY9rlm/sEyGm6z2b7siQMo7lycYsFSQW7csVfupM5a8W6Hoj8DVaVtPKOF8wVvA0LzGts9W0abAljZqu24yT9ckNlR/ItYhjLE2Bv486VOU7WIjIybmOU9HEjff14PuGgZGqVf5XWoNSrt/TFbc2Q76TqGAzroNLJlS+bauog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587788; c=relaxed/simple;
	bh=X5aRt+LPUsZLXEL4wr7fcShbnt/xSZ8e2tYNBbMPTdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jj1tD57twCLwSsrjLZCpjro0rymMN13f0Iaj9g7lOCGfQ0PdhUCR2l2s/cVN+ezplg2syKqvVIt84LhH2dghH5D2lKKJheQm9AJjTGo2oyMz0A03tkJr/wn794jYDyHRvtRGK4f4IMBV27BJrgRjMZwfioH31UF4k54kHW2/H1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=pHFdfnjb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f6c7cdec83so34199805ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jun 2024 18:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1718587786; x=1719192586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bqgWAO4mCWwupa+lR9NOrzfPSBggKHunYbwtSEV5JoQ=;
        b=pHFdfnjbc+3sN+PiTupOJiNyZtsOSJcwLnvUHU7H9GJ2EornD4YRHGpju5jH2MGAg/
         c4ZXQYisAo0tj6/L5aiQzDK8EwrJGd5PwNqlmiy3SHELphMmZ4iwTRkJcdqW/qN/2++P
         RPvjZ3h1wfMf7D4OFufbFOft2BKWCQZpwQpJYfUjbg/jJPSM74hpS0ULIFStNW8dpIle
         rRQtHJjS0bhI4Qw+8HqP/yPMI0mE56IRcfaxHl+Nep5C1XUSBEaLSfUxxVb6kMvT32pt
         Sn1EbCQq0VpyBO5F+T3S3d6mqqMEbgYTN5fycNJwEhQ8UiAQmvgV/rCcZa9UJulLF9tR
         g8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718587786; x=1719192586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqgWAO4mCWwupa+lR9NOrzfPSBggKHunYbwtSEV5JoQ=;
        b=Y2e29R+KqKilHRYpD1QTec88X6wQoXgFU385qrIGfuVgnjPFuYll39BSTSAE12STbM
         /wta22XO3vqaMAk5IJR6r1AtJeH5wSHlbRddjaJmKqVA5GfCh/ubH4Vmw+hEZbQLTDrP
         1kNg5T978aqeBcfkV8G38WY66cSM1ZSkgC4GpLPobptER2WvBZGbeQ9es0xLXd8VLi/m
         uTnTC7WbadGmCZbsA7Fvz0I9cZ42U2x+9mXsIIMy9z4v4hCz8XUDgEv75vpNX9+Zu8Az
         p52ke2ul5qjC1wkkfLm2ymAuAlc6YQKWj9k13X3FoQtg0dgrTQfLwO75WQ40GhdsKA17
         z87g==
X-Forwarded-Encrypted: i=1; AJvYcCUi/ecWNypqA760zlbLwyAPXusAQyFqzbKreIin13w3173OPRde2VmFukXahNP+QiYPyhottYYGctTo7XymDaFWctEYmU+Zr7yYoDaeIQ==
X-Gm-Message-State: AOJu0YzS8DH6HN0O++nIdUbEjo0bUzf9HlnVoI1WcxGIgsjnPqXPPevx
	wvFn/9cSdXpvZhbS4nBMwxDHB/VSuw5HLcC1y3DVWgCqpLMyLdIkUcoVi4uVTbY=
X-Google-Smtp-Source: AGHT+IH2yamUY2L+mg2sDf6W0MYe+fr1/6bICbKfZYn/cmrt+tr3TvVUeXggb8kPWxWwSK9lWhE1Zw==
X-Received: by 2002:a17:902:e88a:b0:1f6:d368:7dd7 with SMTP id d9443c01a7336-1f862b155e2mr101843335ad.45.1718587785415;
        Sun, 16 Jun 2024 18:29:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee80fesm69659525ad.124.2024.06.16.18.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 18:29:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sJ1Bm-00124e-1P;
	Mon, 17 Jun 2024 11:29:42 +1000
Date: Mon, 17 Jun 2024 11:29:42 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, djwong@kernel.org,
	chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 11/11] xfs: enable block size larger than page size
 support
Message-ID: <Zm+RhjG6DUoat7lO@dread.disaster.area>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-12-kernel@pankajraghav.com>
 <20240613084725.GC23371@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613084725.GC23371@lst.de>

On Thu, Jun 13, 2024 at 10:47:25AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 07, 2024 at 02:59:02PM +0000, Pankaj Raghav (Samsung) wrote:
> > --- a/fs/xfs/libxfs/xfs_ialloc.c
> > +++ b/fs/xfs/libxfs/xfs_ialloc.c
> > @@ -3019,6 +3019,11 @@ xfs_ialloc_setup_geometry(
> >  		igeo->ialloc_align = mp->m_dalign;
> >  	else
> >  		igeo->ialloc_align = 0;
> > +
> > +	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
> > +		igeo->min_folio_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;
> > +	else
> > +		igeo->min_folio_order = 0;
> >  }
> 
> The minimum folio order isn't really part of the inode (allocation)
> geometry, is it?

I suggested it last time around instead of calculating the same
constant on every inode allocation. We're already storing in-memory
strunct xfs_inode allocation init values in this structure. e.g. in
xfs_inode_alloc() we see things like this:

	ip->i_diflags2 = mp->m_ino_geo.new_diflags2;

So that we only calculate the default values for the filesystem once
instead of on every inode allocation. This isn't unreasonable
because xfs_inode_alloc() is a fairly hot path.

The only other place we might store it is the struct xfs_mount, but
given all the inode allocation constants are already in the embedded
mp->m_ino_geo structure, it just seems like a much better idea to
put it will all the other inode allocation constants than dump it
randomly into the struct xfs_mount....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

