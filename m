Return-Path: <linux-fsdevel+bounces-17554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5658AFC1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3DC1C21D31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 22:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5641A2D047;
	Tue, 23 Apr 2024 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="jhwLaest"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DDA2C1AE
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912330; cv=none; b=IBHlmmP9DPxsIuGWACIWMbZjuXZzzI3Hs95JCEdmMzKGAXCqvDh4b44ZNjgt8udl/fF2IC8Vz3ghZzgMhGL+QexpgeCWPu9RHu4iRHjKcfFltfZGiBA3Ph1hoGrjO8Nb9yklBksZXmJuP07tUED0UmAMbA7PrsSyD9/IhRJx6r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912330; c=relaxed/simple;
	bh=4wPSvq4uoml6IQETlJJSgvvmf8imf+Sj3hXyV8OBGQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC7QK9L/VitwvcNf7sjD39/M0ix3bFapmM+O6L0p3j6BFtJT0J1PWgHqg/teoMfps43XSuvobrc0Yfz03Q0gUdSGiYk+C1To82dDKA1oZtmEmsc2aTePE1KgYpRbZT5MiKtXneE5G0+ELAgv3/h5f/yMnwjyTSoOLoM9O6OkYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=jhwLaest; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6eb848b5a2eso3449606a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 15:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1713912327; x=1714517127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UA9lpMfveSrhQUSlYO5eJyaEZ+zJ/nyHHnY8V0FZnLQ=;
        b=jhwLaest4aAtjCyDz5QONf56C/yoPS8KrgTXaek8uhCllAtXTL2d7FAyBbCaRfBjSY
         3/hoT/rKTFkbjgLv6rt6A0ch/hs7R68YAiym6e/btaP1LIKKSUr5TYt8YMgk++PDPEuT
         7uqkrNCoC406IgR8mCkyDNflfWzZvzDS8vFVz4hb7KNzLJWeB1yVNC4fOllf2WyytCuw
         uodlGontbq95n5CLNaeEgxCbB3olkTtGfqMJx4w2squlr5mkLgcOb9STK4JU15dA9Y2O
         1Bu8mrWUdeUxAXZblU4g2mmQXOcuk1Wbq/5EUCasL9bVJI8sWEk6uOCyiiApK/by8JBC
         0RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713912327; x=1714517127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UA9lpMfveSrhQUSlYO5eJyaEZ+zJ/nyHHnY8V0FZnLQ=;
        b=gI7vGYShr1Je6kx9Z5u8TEDRIth3kSAdCeZk0Lw3AmoxqB/ozARbwiwj1x6PO1TSC9
         ZTyD/SAfulmdsqz0R7pHrmO4dZNdiCCHi1Xu7d8V64IBugESaUDgnsUWPa/B+G45HN7b
         yebtZBhaAqtPAu7yPavNzzOAnz6g+uYR+KxDm3X9C9Kc6OISeOmDTFTaLySiFS3oDIxN
         l5SFr7Ir3L3szNzrwBcXNMhOdfyzHv9pJUQ5Il918vXp0Hg1pV5ySoNvjk7g2h2BV4Oj
         OzQFS9cWfZHPyPYkooVmjoauxuM1DTMAqHHqadEsONq+KPXuj8VQ0Gsf5PxZUWf58tpH
         laVw==
X-Forwarded-Encrypted: i=1; AJvYcCW+Zu8JZl+8hThE/+gLHJ5/GJvEvZF+pCngKyDZWNtHuHBMX/A40Zi8/P1TGwSihqWuF26wfUaFkRk/eA5PfY4WpHrylHg2zQ+Dg0G2bA==
X-Gm-Message-State: AOJu0YyqSbPmFRZZY1/XYQ9L2VqSNSDykOxt9krBGFMxeXiT7xR3b9WJ
	1VB3VImaRzxK1DHDFZek3mMiFboQELn//zaWGzlAlU/1vNr+kQYjlLrZC8AA/EM=
X-Google-Smtp-Source: AGHT+IEUw1ct44HEu5TG9qJi9IXPPfilAMrib95yoX7pRnmGEo3ghCva1ng9jx3ks5lU0S2axh2DKA==
X-Received: by 2002:a05:6870:5246:b0:22a:508a:66e6 with SMTP id o6-20020a056870524600b0022a508a66e6mr796229oai.17.1713912327154;
        Tue, 23 Apr 2024 15:45:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id j14-20020aa78dce000000b006eac9eb84besm10150852pfr.204.2024.04.23.15.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 15:45:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rzOt9-008acR-2b;
	Wed, 24 Apr 2024 08:45:23 +1000
Date: Wed, 24 Apr 2024 08:45:23 +1000
From: Dave Chinner <david@fromorbit.com>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 6a94b1acda7e
Message-ID: <Zig6A632L9PDK6Qp@dread.disaster.area>
References: <87bk60z8lm.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk60z8lm.fsf@debian-BULLSEYE-live-builder-AMD64>

On Tue, Apr 23, 2024 at 03:46:24PM +0530, Chandan Babu R wrote:
> Hi folks,
> 
> The for-next branch of the xfs-linux repository at:
> 
> 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> 
> has just been updated.
> 
> Patches often get missed, so please check if your outstanding patches
> were in this update. If they have not been in this update, please
> resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
> the next update.
> 
> The new head of the for-next branch is commit:
> 
> 6a94b1acda7e xfs: reinstate delalloc for RT inodes (if sb_rextsize == 1)

I've just noticed a regression in for-next - it was there prior to
this update, but I hadn't run a 1kB block size fstests run in a
while so I've only just noticed it. It is 100% reproducable, and may
well be a problem with the partial filter matches in the test rather
than a kernel bug...

SECTION       -- xfs_1k
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 test1 6.9.0-rc5-dgc+ #219 SMP PREEMPT_DYNAMIC Wed Apr 24 08:30:50 AEST 2024
MKFS_OPTIONS  -- -f -m rmapbt=1 -b size=1k /dev/vdb
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/vdb /mnt/scratch

xfs/348 19s ... - output mismatch (see /home/dave/src/xfstests-dev/results//xfs_1k/xfs/348.out.bad)
    --- tests/xfs/348.out       2022-12-21 15:53:25.579041081 +1100
    +++ /home/dave/src/xfstests-dev/results//xfs_1k/xfs/348.out.bad     2024-04-24 08:34:43.718525603 +1000
    @@ -2,7 +2,7 @@
     ===== Find inode by file type:
     dt=1 => FIFO_INO
     dt=2 => CHRDEV_INO
    -dt=4 => DIR_INO
    +dt=4 => PARENT_INO108928
     dt=6 => BLKDEV_INO
     dt=10 => DATA_INO
    ...
    (Run 'diff -u /home/dave/src/xfstests-dev/tests/xfs/348.out /home/dave/src/xfstests-dev/results//xfs_1k/xfs/348.out.bad'  to see the entire diff)
Failures: xfs/348
Failed 1 of 1 tests

xfsprogs version installed on this test VM is:

$ xfs_repair -V
xfs_repair version 6.4.0
$

-Dave.
-- 
Dave Chinner
david@fromorbit.com

