Return-Path: <linux-fsdevel+bounces-8204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07284830ECB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 22:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B19EB2575B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 21:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710EB2868D;
	Wed, 17 Jan 2024 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KrSyzp3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554AA2557E
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528302; cv=none; b=LuLzoRnaOKw3W2zadz4qGlmskHWjfxhhSKzaxFGj6xYlebio10m8cy7mmVyh/6yBJ9Bebf/Q5+S16tI9p01eqj9Lk26UQ9pICm7MB6ntXlXbuY52uOUsjObLFIqgUacFz+FndTdXHIWY1sCI19bBSt9U0AuzJHWnMQHjpdJaV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528302; c=relaxed/simple;
	bh=+sYdn1TYu2tGHcp/A1BrZtQI1EBapoKO6YrKs/F84h0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=mNQLXhTH5HOc3GFSa3tc0McHQwdf7XnBEbliVlZ1hkQSY3xtc/BTJHMp0fmTY55dZEPdJvtSdHpd7WyycepBL75qs5a/TBK/RXAHt8++F/9q+MRBS9+tLWzayWb/DtbQrViEd+NmARbf7eSKXGdfpHegtgaz+Aft3gHlZ9HtAQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KrSyzp3B; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bd72353d9fso3490660b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 13:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705528300; x=1706133100; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LLeFnk3Q55H1BPBw4YoBu7toGUDI6gBA877Kx/ZWOrU=;
        b=KrSyzp3BoIJpk7vgXhCD+rsQm6gFnIkzVcXPLAT5BCHXBk+l9bunQE+Q/vr+S9EXXy
         xKpxghI+4oMWPxkdbfZl2/56MF904010J33WHaUP2aFPB96RwGDx0SyoXY7iRl/6DqyS
         OM4c9nvKF6Vj4M6R1ZISmYZV6ZQ8HNXJ5LB0AqJLu1wQE94wq7D+GLpNJU71V0VNhd4y
         vHC8ilzWvBuHy1kkiZFN5nTWROBqGXBlmQ8EWp6uMSNGZRmHV/8lkDqqhBwNZ0x0un4G
         mAJPYJLYQgC7qs/HCXWHtcXg5nUmA6dh4F99okJ+gdhO/BifnofQG/dLWn1PZnISpubH
         85Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705528300; x=1706133100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLeFnk3Q55H1BPBw4YoBu7toGUDI6gBA877Kx/ZWOrU=;
        b=tjEMq093e3QAEunMSGTF4sICJ96Ty5CD70NYAhZ37ALHE5CoqTzsm3fXwYIf8dY7cB
         RN0E20YmAZBoST+/1NpMOQFajrK9VdHmgop2FtdN5PpM1jvkVGPEx9SzbMOru/boriOw
         1gB2w3R4hgATTJ2CrZjr8mJmA6wKC1pNuW8GhmmaF6Lxauce3AcFhcRtjoaNNNCEK1zw
         pcJyEBcdaZMF71OLpIHJJPejNNqR+Zvs1rbYkfr9DEsMQ/BWOSCgcMbeqb+cgnRJS37C
         hz7x54cD4j88lu1MH8brgHdUcaV+JWgtL5yqq0Qv/EFDpl6RtmREqAzQ+cc5uOcjdIqL
         lyQQ==
X-Gm-Message-State: AOJu0YzIWqQBp22S1EblIOuWoaWwV9lyu1pSf1V+ROPHpQeS19upSGau
	2qnXBf5xt5/5+MbVRhGYrvmWtjmNPZtRVw==
X-Google-Smtp-Source: AGHT+IGESx3XdAVciQo32JGzL/U/9t/1OLisSeEzkhwKrP6ShbUuF6hJSrsKjUR/tdf3Tqk5GRjSUA==
X-Received: by 2002:a05:6808:f8e:b0:3bd:986e:23 with SMTP id o14-20020a0568080f8e00b003bd986e0023mr1186949oiw.2.1705528300428;
        Wed, 17 Jan 2024 13:51:40 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id z14-20020a62d10e000000b006d9b38f2e75sm2009134pfg.32.2024.01.17.13.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:51:39 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rQDov-00BkQF-2K;
	Thu, 18 Jan 2024 08:51:37 +1100
Date: Thu, 18 Jan 2024 08:51:37 +1100
From: Dave Chinner <david@fromorbit.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	lsf-pc@lists.linux-foundation.org,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, slava@dubeiko.com,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
Message-ID: <ZahL6RKDt/B8O2Jk@dread.disaster.area>
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
 <20240115084631.152835-1-slava@dubeyko.com>
 <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
 <86106963-0E22-46D6-B0BE-A1ABD58CE7D8@dubeyko.com>
 <20240117115812.e46ihed2qt67wdue@ArmHalley.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240117115812.e46ihed2qt67wdue@ArmHalley.local>

On Wed, Jan 17, 2024 at 12:58:12PM +0100, Javier González wrote:
> On 16.01.2024 11:39, Viacheslav Dubeyko wrote:
> > > On Jan 15, 2024, at 8:54 PM, Javier González <javier.gonz@samsung.com> wrote:
> > > > How FDP technology can improve efficiency and reliability of
> > > > kernel-space file system?
> > > 
> > > This is an open problem. Our experience is that making data placement
> > > decisions on the FS is tricky (beyond the obvious data / medatadata). If
> > > someone has a good use-case for this, I think it is worth exploring.
> > > F2FS is a good candidate, but I am not sure FDP is of interest for
> > > mobile - here ZUFS seems to be the current dominant technology.
> > > 
> > 
> > If I understand the FDP technology correctly, I can see the benefits for
> > file systems. :)
> > 
> > For example, SSDFS is based on segment concept and it has multiple
> > types of segments (superblock, mapping table, segment bitmap, b-tree
> > nodes, user data). So, at first, I can use hints to place different segment
> > types into different reclaim units.
> 
> Yes. This is what I meant with data / metadata. We have looked also into
> using 1 RUH for metadata and rest make available to applications. We
> decided to go with a simple solution to start with and complete as we
> see users.

XFS has an abstract type definition for metadata that is uses to
prioritise cache reclaim (i.e. classifies what metadata is more
important/hotter) and that could easily be extended to IO hints
to indicate placement.

We also have a separate journal IO path, and that is probably the
hotest LBA region of the filesystem (circular overwrite region)
which would stand to have it's own classification as well.

We've long talked about making use of write IO hints for separating
these things out, but requiring 10+ IO hint channels just for
filesystem metadata to be robustly classified has been a show
stopper. Doing nothing is almost always better than doing placement
hinting poorly.

> > Technically speaking, any file system can place different types of metadata in
> > different reclaim units. However, user data is slightly more tricky case. Potentially,
> > file system logic can track “hotness” or frequency of updates of some user data
> > and try to direct the different types of user data in different reclaim units.

*cough*

We already do this in the LBA space via the filesytsem allocators.
It's often configurable and generally called "allocation policies".

> > But, from another point of view, we have folders in file system namespace.
> > If application can place different types of data in different folders, then, technically
> > speaking, file system logic can place the content of different folders into different
> > reclaim units. But application needs to follow some “discipline” to store different
> > types of user data (different “hotness”, for example) in different folders.

Yup, XFS does this "physical locality is determined by parent
directory" separation by default (the inode64 allocation policy).
Every new directory inode is placed in a different allocation group
(LBA space) based on a rotor mechanism. All the files within that
directory are kept local to the directory (i.e. in the same AG/LBA
space) as much as possible.

Most filesystems have LBA locality policies like this because it is
highly efficient on physical seek latency limited storage hardware.
i.e. the storage hardware we've mostly been using since the early
1980s.

We could make allocation groups have different reclaim units,
but then we are talking about needing an arbitrary number of
different IO hints - XFS supports ~2^31 AGs if the filesystem is
large enough, and there's no way we're going to try to support that
many IO hints (software or hardware) in the foreseeable future.

IF devices want to try to classify related data themselves, then
using LBA locality internally to classify relationships below the
level of IO hints, then that would be a much closer match to how
filesystems have traditionally structured the data and metadata on
disk. Related data and metadata tends to get written to the same LBA
regions because that's the fastest way to access related and
metadata on seek-limited hardware.

Yeah, I know that these are SSDs we are talking about and they
aren't seek limited, but when we already have filesystem
implementations that try to clump related things to nearby LBA
spaces, it might be best to try to leverage this behaviour rather
than try to rely on kernel and userspace to correctly provide hints
about their data patterns.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

