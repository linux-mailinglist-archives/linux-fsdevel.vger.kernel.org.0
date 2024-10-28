Return-Path: <linux-fsdevel+bounces-33093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13439B3E51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 00:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0491F230E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 23:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A161F7081;
	Mon, 28 Oct 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="3RAmAuTh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2E1CCB57
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730157242; cv=none; b=OcgaeZkiLDqz0h2sx5sQUIIm6bRlRBEr1GGOjUYZGj7ezLC8sShnXb1QFFpoSPueoNvVRlTb5tACUbN4d7MKOORKWt8zLGw1zAOAz2ColvwmI8tbeb7zADi2pDSHft/fyot33mr/MOYvBOoZhEtNx1zfRdppM1TTYuTgE/2KhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730157242; c=relaxed/simple;
	bh=tu7v26i2JtqQ76K4P5euoorWyDdw9X0DNikmEhAJje8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3Zzm+jXKu1Jk+bU2py7LuruLEgGHXzqOj0WZVcavjJazww8+DVnbjhcO4z5BXIfSrfg+8J+EaDNlQyGDUHlyPfY4l9Z1PLaoyINhLkdi4T6uIObrfzJaTPUOY/iRHawVsQJPOc11+rgyUG/KyHgBxYpYZpLZBrcDLOCUTkjQPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=3RAmAuTh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20e6981ca77so51963425ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 16:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1730157239; x=1730762039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjohkZCWItx1P1zaOWN8RLXGPxIli/Tp9Ueq+8PbQ1c=;
        b=3RAmAuThYc4kwWVUfpMRLB+yXCYpUuu/xtbjpuliRlVq4pLYN964U1aPFjy7QfUQWs
         DJnyHIMsvwTw8n9a7WSVKxkgT55tF0fvKzI+vDemvwPAErejZYN1ecFjj1ge8eWwKjan
         I0DKWRYhWbtBfDTJ70kmwTJukd7cJXnZpwSn9pINgGftwQIuzyuAhElEEYxukJMCab9n
         G+xGW35x9e49+4AKudDq0wIPLVEO95hRvkEw4GjyJTyIArzWSK03bbVQkq9ttbG6/94r
         lAWjv9/km0P8bIagwy+SAK2+4ReNf78Qp55JgX2uI4Coug4yXPjs32DR0IvJqcIyAzDT
         GvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730157239; x=1730762039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjohkZCWItx1P1zaOWN8RLXGPxIli/Tp9Ueq+8PbQ1c=;
        b=tLmc5nnULBrxoWI5K5fdIXU/2eGDfi10G3HwkTh0d2vH4OtfRBfDN5gbRxVAn99P/0
         EwuwhCG+HXZ+BDshAkUSefx67QCXDQgaNpAmCZd/4ck4ixb26ypsKr1lslZEnY/rt6Bv
         ASjkJ6INfGj53Fm8n1UVOaPm/G60LeGrFfp8MGKVFQUjRa6Xl80ix/vLatN+V5nvW/Wd
         LN1KOA7I+KgTn0fLAcylLCStEN3YHMcSeLJ1EurMTeUSqzeNVvSaD/+w6oH72uCQZkNa
         Gj2C/SwCbZKT7pZC+lhVgCWBMvaq//6B080Y3HraHs/wPC+sDUS3NhSscKwhkZhOUtNl
         dUGg==
X-Forwarded-Encrypted: i=1; AJvYcCU9/8/izk04SkIWgu/miUYitGUuZ/NCFQQSIVwlGC5Fyo2cNXlrWgPcCdlWaIv4YS5td11EeIDsQafJu2W+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtc1zPwppyc92gkDSrKmR8y7Co2JCP4NEcrxMcunhRT6sLO2st
	Lwq5UlWSBQHJmmg8d2wMXg1jXKftPvk7YDspwFaO4B7D3cra5lkNuSnOUQ3quvA=
X-Google-Smtp-Source: AGHT+IEKpYnlOXgqoRWlMC1TKuOxB2Oot8ftK1XXczcsnr8MX6gARhSGfX3uywNSPm6kipDP7tJ1wQ==
X-Received: by 2002:a17:902:d2d2:b0:20b:6d71:4140 with SMTP id d9443c01a7336-210c6c7354cmr111713295ad.44.1730157239473;
        Mon, 28 Oct 2024 16:13:59 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc89f2a2fsm6351987a12.73.2024.10.28.16.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 16:13:58 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t5Yvr-0077C6-14;
	Tue, 29 Oct 2024 10:13:55 +1100
Date: Tue, 29 Oct 2024 10:13:55 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, sandeen@redhat.com
Subject: Re: lots of fstests cases fail on overlay with util-linux 2.40.2
 (new mount APIs)
Message-ID: <ZyAasz2RBpMpGV8T@dread.disaster.area>
References: <20241026180741.cfqm6oqp3frvasfm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241028-eigelb-quintessenz-2adca4670ee8@brauner>
 <20241028192804.axbj2onyoscgzvwi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028192804.axbj2onyoscgzvwi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Tue, Oct 29, 2024 at 03:28:04AM +0800, Zorro Lang wrote:
> On Mon, Oct 28, 2024 at 01:22:52PM +0100, Christian Brauner wrote:
> > On Sun, Oct 27, 2024 at 02:07:41AM +0800, Zorro Lang wrote:
> > > Hi,
> > > 
> > > Recently, I hit lots of fstests cases fail on overlayfs (xfs underlying, no
> > > specific mount options), e.g.
> > > 
> > > FSTYP         -- overlay
> > > PLATFORM      -- Linux/s390x s390x-xxxx 6.12.0-rc4+ #1 SMP Fri Oct 25 14:29:18 EDT 2024
> > > MKFS_OPTIONS  -- -m crc=1,finobt=1,rmapbt=0,reflink=1,inobtcount=1,bigtime=1 /mnt/fstests/SCRATCH_DIR
> > > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /mnt/fstests/SCRATCH_DIR /mnt/fstests/SCRATCH_DIR/ovl-mnt
> > > 
> > > generic/294       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/294.out.bad)
> > >     --- tests/generic/294.out	2024-10-25 14:38:32.098692473 -0400
> > >     +++ /var/lib/xfstests/results//generic/294.out.bad	2024-10-25 15:02:34.698605062 -0400
> > >     @@ -1,5 +1,5 @@
> > >      QA output created by 294
> > >     -mknod: SCRATCH_MNT/294.test/testnode: File exists
> > >     -mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
> > >     -touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
> > >     -ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
> > >     +mount: /mnt/fstests/SCRATCH_DIR/ovl-mnt: fsconfig system call failed: overlay: No changes allowed in reconfigure.
> > >     +       dmesg(1) may have more information after failed mount system call.
> > 
> > In the new mount api overlayfs has been changed to reject invalid mount
> > option on remount whereas in the old mount api we just igorned them.
> 
> Not only g/294 fails on new mount utils, not sure if all of them are from same issue.
> If you need, I can paste all test failures (only from my side) at here.
> 
> > If this a big problem then we need to change overlayfs to continue
> > ignoring garbage mount options passed to it during remount.
> 
> Do you mean this behavior change is only for overlayfs, doesn't affect other fs?

We tried this with XFS years ago, and reverted back to the old
behaviour of silently ignoring mount options we don't support in
remount. The filesystem code has no idea what mount API
userspace is using for remount - it can't assume that it is ok to
error out on unknown/unsupported options because it uses
the fsreconfigure API internally....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

