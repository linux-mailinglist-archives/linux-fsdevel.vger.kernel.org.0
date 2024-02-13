Return-Path: <linux-fsdevel+bounces-11484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD588853EF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57EF6B27446
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0242D627EE;
	Tue, 13 Feb 2024 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="EgHPKu9v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10262177
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864283; cv=none; b=eJXD5rE+H4gzpidxs8rGZA5r8BVJ5/8E7SZ8/BRRP3RgPr7hTs/FHiVsS71CtB6MFJN8bsw8cFDo1ZPP/w1Sb3rz957/JWUrMRZyxXUub9JRRp3gV+jj2y4oqW4vdmGEZ+zYw3myF7i5AWyYwMMbCylP3kCvE9FjfKvyTJVfr/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864283; c=relaxed/simple;
	bh=DkHZ2mjgTqxGFzmhJ0GZhDKs3oxoxJfE7ld+YCwH9JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCn4d88MUnMYQFBmHJXVzf6JCxy0d+wqGj/2RZtRqA1kdff73PMtqX4M/gkYqkisT3SKJolY2gYwxabvuuHeEXB5S28O658hUvmv83LCoP2MRTx1HvboM7zzhZoaUqktszoR9kmi9nhmNSEO9kUVTJYjVPDeRRpswrALRypAzAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=EgHPKu9v; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e104196e6eso685789b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 14:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707864281; x=1708469081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1sKZkLPjgDOF5m3bXTmn29vEuAR6iiKektHF/NRrR0=;
        b=EgHPKu9v+3GFnsl3y1lZDHpxZEqIkFI3reDPwhM/EoRbCPzmOnwM7TiWaFvDZI9Y5a
         Ub/vcCcluRTyabDkZB+B2wBAueSpYutmxH/02kgOIuQRV/MYKjwGButoFmo5/uY0y7Ii
         z4GWE0GYfTlrb8dWegen/WU0CXPceZR5JTJIABZGnCkDwZd6a2ivA+rNSr4xTnJpxxw1
         z+BrcV/xIQpqx4bl64J9mDEbH88SRw4F5R8NsODSUT5NKaMaqMXqzTleJTgJTJbFlb6n
         ZJwonTn9vVKV28O2U4JEnrgt97QNqiNMKkf6BcWs+H+qoND5JYrisqBjAV4M1hPthqnR
         4qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864281; x=1708469081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1sKZkLPjgDOF5m3bXTmn29vEuAR6iiKektHF/NRrR0=;
        b=cwUkoaRWAVAncKf4HivDxcsF40AzxJh2hAxd23s64cUcPSagEG665pikcs/8aDEsSe
         eOPPdwo6Ou+DfSakZH4QmRjMNsGEnOYmX45qjIt7cB41O+3pwMvRnT7Gk5FEgoWkPaIe
         97RRtsqwHCCPLiniaCuuMRojkreb5Bjjn16+xNP+CYz02aEmQ4kzqZ0j6TuS+AwKNLcE
         HTOQIIil4yhqMn9V1wQV5BM/v22mQQVk+hQo2Fs/xWauy4NizuX3up94kggFJ0VFeuS/
         brlyEoBCicgVMkIvZJtSeOvasn5dYWiAbC+aRzgQCLlk5iPhp7uIr4h7u4qB10+bXy4x
         0DDA==
X-Forwarded-Encrypted: i=1; AJvYcCWH7IoBECrgv7QoB08vT3aVDs7m8GxWgsLUJBd+XsMDrKc8xtGDfqP9Hv+XZPKgwdU3EbSIiAKGxu3L0uwxbDOLpvfzd8v2VILeUbUtMQ==
X-Gm-Message-State: AOJu0YxqSqnwddfObwTSYgwRC+GtuXqk8vTy5ceooABgyGfEdiQWZuky
	ZZMHL7twjyLxAvCboHsyyhFS0glkfm5er75/G1OYoKUYDXeVIBU4I9hUiclNpOE=
X-Google-Smtp-Source: AGHT+IEEfZk2QvJm0SnvWBUF2nizLOAjdHL84kGnsQEnz4ta77+jkalKGer0Gupu4/rPGedCeEooAA==
X-Received: by 2002:a05:6a20:d809:b0:19e:ba40:83e9 with SMTP id iv9-20020a056a20d80900b0019eba4083e9mr1461948pzb.17.1707864281250;
        Tue, 13 Feb 2024 14:44:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLIL+5HbWfGdrbIFKF29jZ7ekgxR3Cem75R2GxM2SCb2adZY4DmlDpHJDBxWhw5qcwpLxmaOOHL13+l7ewRF6slNN34C0Dtmv4tppu8BPbrWlpYoN/mBus0eEZiBc1GirGPpePLR0PlbCqHsiYq5lvQJXhvVqnSMv2vAaToodBoUu2x2ERjz0mmPTt5yMJJjIW3/heHmiJ/lzYRKmcpK/r91qVHRI999G5V14FkT+8zJ+jaFFRJG4d7vnpV2knDFWXhjsAZNapkWUR2hOeNE/U/hnSnjXPepPqJ0c4o4+0UWNP0k/LhCAb4F3qrPFni1SK8Oudg3w4mRVLSxOXM5nqMmjP/ZzTEydIiaMjBGttWrNbAx19Rdby6PC1gqcsA5JQlSFLhjCotVJgdF61kXdSTJfD7PdXFJ8Z70zB8WBzOBfyvw==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id n8-20020aa78a48000000b006e06936c7a6sm7948075pfa.200.2024.02.13.14.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:44:40 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ra1W2-0068M2-0u;
	Wed, 14 Feb 2024 09:44:38 +1100
Date: Wed, 14 Feb 2024 09:44:38 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
	gost.dev@samsung.com, akpm@linux-foundation.org, kbusch@kernel.org,
	chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org
Subject: Re: [RFC v2 12/14] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <Zcvw1rrE4CiVzkmc@dread.disaster.area>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-13-kernel@pankajraghav.com>
 <20240213162611.GP6184@frogsfrogsfrogs>
 <loupixsa7jfjuhry2vm7o6j4k3qsdq6yvupcrbbum2m3hpuxau@5n72zpj5vrjh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loupixsa7jfjuhry2vm7o6j4k3qsdq6yvupcrbbum2m3hpuxau@5n72zpj5vrjh>

On Tue, Feb 13, 2024 at 10:48:17PM +0100, Pankaj Raghav (Samsung) wrote:
> On Tue, Feb 13, 2024 at 08:26:11AM -0800, Darrick J. Wong wrote:
> > On Tue, Feb 13, 2024 at 10:37:11AM +0100, Pankaj Raghav (Samsung) wrote:
> > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > 
> > > Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
> > > make the calculation generic so that page cache count can be calculated
> > > correctly for LBS.
> > > 
> > > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > > ---
> > >  fs/xfs/xfs_mount.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> > > index aabb25dc3efa..bfbaaecaf668 100644
> > > --- a/fs/xfs/xfs_mount.c
> > > +++ b/fs/xfs/xfs_mount.c
> > > @@ -133,9 +133,13 @@ xfs_sb_validate_fsb_count(
> > >  {
> > >  	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
> > >  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
> > > +	unsigned long mapping_count;
> > 
> > Nit: indenting
> > 
> > 	unsigned long		mapping_count;
> 
> I will add this in the next revision.
> > 
> > > +	uint64_t bytes = nblocks << sbp->sb_blocklog;
> > 
> > What happens if someone feeds us a garbage fs with sb_blocklog > 64?
> > Or did we check that previously, so an overflow isn't possible?
> > 
> I was thinking of possibility of an overflow but at the moment the 
> blocklog is capped at 16 (65536 bytes) right? mkfs refuses any block
> sizes more than 64k. And we have check for this in xfs_validate_sb_common()
> in the kernel, which will catch it before this happens?

The sb_blocklog is checked in the superblock verifier when we first read in the
superblock:

	    sbp->sb_blocksize < XFS_MIN_BLOCKSIZE                       ||
            sbp->sb_blocksize > XFS_MAX_BLOCKSIZE                       ||
            sbp->sb_blocklog < XFS_MIN_BLOCKSIZE_LOG                    ||
            sbp->sb_blocklog > XFS_MAX_BLOCKSIZE_LOG                    ||
            sbp->sb_blocksize != (1 << sbp->sb_blocklog)                ||

#define XFS_MAX_BLOCKSIZE_LOG 16

However, we pass mp->m_sb.sb_dblocks or m_sb.sb_rblocks to this
function, and they are validated by the same verifier as invalid
if:

	    sbp->sb_dblocks > XFS_MAX_DBLOCKS(sbp)

#define XFS_MAX_DBLOCKS(s) ((xfs_rfsblock_t)(s)->sb_agcount *
                                             (s)->sb_agblocks)

Which means as long as someone can corrupt some combination of
sb_dblocks, sb_agcount and sb_agblocks that allows sb_dblocks to be
greater than 2^48 on a 64kB fsb fs, then that the above code:

	uint64_t bytes = nblocks << sbp->sb_blocklog;

will overflow.

I also suspect that we can feed a huge rtdev to this new code
and have it overflow without needing to corrupt the superblock in
any way....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

