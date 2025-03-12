Return-Path: <linux-fsdevel+bounces-43830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6DBA5E4CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 20:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2789F7AA084
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97DA25BAB1;
	Wed, 12 Mar 2025 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="tQak4WAb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6439125A349
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809125; cv=none; b=TmWGMb7OX5NS+5PnilndYa4/D5WDkWQticdUnCPFgifHV6aOwU8I5VTL68SijVGxaeIAr0rZ+JJ4QYWCxE2CvsRayKYOGmLYObJz2+qb0dJwTK/bGgsnm37sk/ZPwOPev5BVuXFMF2x+nSPEd75IGfLM2Id4QawJuFReT+4tyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809125; c=relaxed/simple;
	bh=9nCebzwQcT7vsmLoqvflspQkiwpll02VlnYPMm4lKOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCnQ6JmbuDjK5DOOElJkzYUtVOnlhG8zaxCiFRBq9x9vFjrqgQHkOQof1BOvX4MhNfuSG8wxrgc1BfsA9gFvXpJZi7wiF9wrVoB5/Aq+nV+BfSo6ZoHXaD/fNBuCtdkdQ3UhKcgg8CqcXMNCj9K4uh03gC2xIdtHCRlHO5V0A88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=tQak4WAb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223fb0f619dso4670055ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741809122; x=1742413922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZXks1yCL59Hzx10jJaOlAET0rV27Iyc9SiIzk3nPyM=;
        b=tQak4WAbEgPG4nUKoNes1ONPbE2D41On46VqD8YIFyHeMxccDJck1qIWhNnnq6AuyP
         BotEZTS9HHuTvSnegsfY7KrD0/pxxWNxM8a6KV/EsmEHtZLsweHQJyrzNKrcbJwXvKC7
         5GMObXcuy/kpdOOjq2y7f4pFFHP51TbWcsxw8VzVh5qwQrpGjqZwfWnuO+TdyBCZhjeS
         EGKkQiD4FzbXGY+Ng8ARqfhCbAsZvy09NSRVA+lkGF4AxN6Uc+TZR+l0vuvZB95Y7CXm
         pMgzBRZBb0yNMUy+UdRi5eSip3zeg4cgO44pVSqdcJ1/zX8dZy8DJb1CY130uKRY/SgR
         pbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809123; x=1742413923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZXks1yCL59Hzx10jJaOlAET0rV27Iyc9SiIzk3nPyM=;
        b=LGdtlSCyU/ombHFzzxZspneINqWnE1MMZ5/qsWrz3r/qVxxM4AwICCCMFWjdOaelkv
         /bYzWhhyqmqvelmM1oIJDNEByyoveiuYG6rHsCW10EQYEoJtmGsIOD6dz/7oUw2v1j78
         u/PCKZp0BmLFaRL40RDD0WuyVTpyrzuKTlkf8YLYe5TZa5lIE+kM9U7fWXnk4E6dP0X/
         ftRu8Htt+D9yzSSfRkP9Bn5X4Muuf4oSZZI1vFQPof3AxUb1GcsE4MBnk3v3yLQbQpHe
         q/PESkmjsM9NijFNHz7LkV9CcjsZXpws1DJhPJFHe909KHchWwEA8A/wY8f8xISqiYXr
         Gvug==
X-Forwarded-Encrypted: i=1; AJvYcCXA+Cwtehp/pxlFal4IWmWnfOkpbKIsMjaGDSAMoHbtQvDOqIghqJVRTqdKf2UAaCapGEO3OQfCy0X9miO/@vger.kernel.org
X-Gm-Message-State: AOJu0YyygxDwgdSW3j3o64aRpRqMLM8niraK9SLuyi98yd+5WvapyEc/
	UBBaFcbJfuFKcuPF9DKCYXR/uGUepLiKYtlLjNHPT+rsjo2UNQ67UO4IiebQUK0=
X-Gm-Gg: ASbGncv1xfIC8J5r7S/v8yV/cYV4ehvR5S0eY56G98W+osmN/zfuMlrO7NuFkihepte
	STKTlv9OXXDyPaHIEeb9s5oGd8j6KBRR1SZP/eBXTUJ4VZSy6JWVRlErf549Y8aRUPymunU1Cm+
	NrbNAvydjiYi6rx00HEYJYyHgIbNPm2It5GMR0lp3GHTg9RIq3pvMsWzzfRsHl0Jiln7e5FA3O+
	n0hQ7UPeb3k7Z9FgH9O44pHS/hSR6jVq/3IF7q8I3gtfihwc1leaX5PfJnf+sSHvOW6L0kW2CR4
	qC1ioaGyifrSHsSYLa5xMgL3v0truDN2lrJWWnzddgTVEFxkDlJjggLzD+Q27zgqt1Q8wX3SI3C
	ZIJFf9PY9u7iyXA68joi9
X-Google-Smtp-Source: AGHT+IEE2EJW9ndEG7Y/L7HAyUCKmqOhXbnMCG+N60tA8rq5IwDA5m81XvtvYTp7j4ChVG457AtQ1g==
X-Received: by 2002:a17:903:228e:b0:224:b60:3cd3 with SMTP id d9443c01a7336-22592e2d676mr134144265ad.19.1741809122629;
        Wed, 12 Mar 2025 12:52:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm120190275ad.91.2025.03.12.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:52:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tsS7T-0000000CHVL-0aXe;
	Thu, 13 Mar 2025 06:51:59 +1100
Date: Thu, 13 Mar 2025 06:51:59 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 12/12] xfs: Allow block allocator to take an alignment
 hint
Message-ID: <Z9Hl39cS-V2r-5mY@dread.disaster.area>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <20250303171120.2837067-13-john.g.garry@oracle.com>
 <Z84QRx_yEDEDUxr5@dread.disaster.area>
 <ad152fa0-0767-45cb-921e-c3e9f5eac110@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad152fa0-0767-45cb-921e-c3e9f5eac110@oracle.com>

On Mon, Mar 10, 2025 at 12:10:44PM +0000, John Garry wrote:
> On 09/03/2025 22:03, Dave Chinner wrote:
> > On Mon, Mar 03, 2025 at 05:11:20PM +0000, John Garry wrote:
> > > diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
> > > index 4b721d935994..e6baa81e20d8 100644
> > > --- a/fs/xfs/libxfs/xfs_bmap.h
> > > +++ b/fs/xfs/libxfs/xfs_bmap.h
> > > @@ -87,6 +87,9 @@ struct xfs_bmalloca {
> > >   /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
> > >   #define XFS_BMAPI_NORMAP	(1u << 10)
> > > +/* Try to align allocations to the extent size hint */
> > > +#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
> > 
> > Don't we already do that?
> > 
> > Or is this doing something subtle and non-obvious like overriding
> > stripe width alignment for large atomic writes?
> > 
> 
> stripe alignment only comes into play for eof allocation.
> 
> args->alignment is used in xfs_alloc_compute_aligned() to actually align the
> start bno.
> 
> If I don't have this, then we can get this ping-pong affect when overwriting
> atomically the same region:
> 
> # dd if=/dev/zero of=mnt/file bs=1M count=10 conv=fsync
> # xfs_bmap -vp mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..20479]:      192..20671        0 (192..20671)     20480 000000
> # /xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0525 sec (1.190 MiB/sec and 19.0425 ops/sec)
> # xfs_bmap -vp mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..127]:        20672..20799      0 (20672..20799)     128 000000
>   1: [128..20479]:    320..20671        0 (320..20671)     20352 000000
> # /xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0524 sec (1.191 MiB/sec and 19.0581 ops/sec)
> # xfs_bmap -vp mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..20479]:      192..20671        0 (192..20671)     20480 000000
> # /xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0524 sec (1.191 MiB/sec and 19.0611 ops/sec)
> # xfs_bmap -vp mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..127]:        20672..20799      0 (20672..20799)     128 000000
>   1: [128..20479]:    320..20671        0 (320..20671)     20352 000000
> 
> We are never getting aligned extents wrt write length, and so have to fall
> back to the SW-based atomic write always. That is not what we want.

Please add a comment to explain this where the XFS_BMAPI_EXTSZALIGN
flag is set, because it's not at all obvious what it is doing or why
it is needed from the name of the variable or the implementation.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

