Return-Path: <linux-fsdevel+bounces-60230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA15B42E09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390005612E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F55433AD;
	Thu,  4 Sep 2025 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="mFpsO7eR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396312628D
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 00:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945056; cv=none; b=SNlt1LOdNChoj6pLhkO7KbK8lDFb7hbDzxTUfxq/+bPKRpan2RVA32KTF6755+PooUADUxHFt+c0tBfm+w5yqh4TPXfB1uiwl9I9ATqkXDH6nVrcOZnotaYZHL3qhWMltdN6Lc6XmJ81bUaS4pDyD1WtkXfsljoGs9iNWuOZvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945056; c=relaxed/simple;
	bh=+Fi2uDeyhW+e2OIJgl036DmHeMHMRRLbyOixENxCSAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7RzWKfWOZobcDLlUETUkgdUZ7Rg/FjejfMyVeLgpxkDut0aq+YjrN/o8r9/2iIzRzPE5+b12vdDFLCBf8gx1aSRLyEYl3ANrSGk665gQ+9S+h5vNsUfAyRJePVejQOab+ke0FjKvPjvkbDUa8raLttYHNYrK/XkyHu5dCXyN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=mFpsO7eR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-772301f8a4cso644094b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 17:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1756945053; x=1757549853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cu5bzd3f3USwYvB1CBG4A8cgDzrTBTPuzZz6N9qQq3o=;
        b=mFpsO7eRGWk02izioHjNb/R1upB7nSR5kQfJ179UhY8SXO0fCZCG2pX0631eHKX8im
         nPbVRyHI3rFmISfJXNMNGY4/DzSm9umN4FtU38GJhhVMVEphcisQu4HzOhStDFooPd95
         MBPBOdXM488/mK3pCm65RLlDPjuWDO2Vp82Yu3zpnX/ez4NrEquMwK672HDui7gsipRX
         7EfgyuhVrHXvcSofW+LsKQetRWryPDokeWvwoEsjgSlUlAALvbs0G9kMi611TzDoqYIr
         H/yMSwuiluqdF8r37tq0BiKv62RjAOjeeAjG46U9gD7c1Obcura3VmKMgy3sDRJl2eBc
         HQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945053; x=1757549853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cu5bzd3f3USwYvB1CBG4A8cgDzrTBTPuzZz6N9qQq3o=;
        b=mKAaPjgkEVp9V/L5vIM/OI71cATSaqvTjdt9DMSNd9ktATKfttEMdYzQI7eIk2hyod
         kH2Ope9enB7nbXyhFU2/F0HWBWfTCaOkOIHGZnEb13A2/D2D12LUB4c4OyFxx58h8xII
         3TZtu6z3sJ/Goc/RXiVEYpxEYvrNM/iqwjkUyOZ8bOjU7JewHNKLC9/6l8QgET/as9Ua
         A+ErgWxVTihDXIZw3id9CPipuJFFNRzg/A2PMIgkaEOb8P9caOoYiSVyNo84td23td/T
         jMJJw4JxU7eCAz/wQHXKyFR9rYpq8OdZnkEfEsogHgji7nh2rMMvYxx33TeAn7x1YliH
         5leQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMndXJ5RsgEPPuwYnElEKyPwRrYoGLiL7vsN72DZGiSjDIAV36X9WCAaghZtUqB3qWkiESAulNqAbp8OoX@vger.kernel.org
X-Gm-Message-State: AOJu0YxIoZUQLR6LCa6P+HyTECizxjw7hte7O4ivNPSpL3NVrR7lPgby
	bNt/xpilqWNx5M65OL73BPENcgDybh/tlk/Y8+m6Oqr9KNujMp0xJt4sJ0UgkZawAy/ZqWHoywL
	vKCMf
X-Gm-Gg: ASbGncv8mLQQQZ/MoNeKdzxJkzXz7LwXnSETG9UAKiujLQlvqorL7tAcL5FVUM+eKnk
	PLW5lfwRoPgaowepsGxshs1rs+N4ZoRxFgd7Divzdax613fq+ShV41woTRwsoJfFgitXHUlxX+J
	MJZ0QEmm/DR2xcUW8ceaII3pnYsBOZ4d+YU5ZymamfESQOo8OAPMR2t23ETaq7eNWsMvy6YlCtn
	xRJau2KSvjyUD3uShZZR7F53N9XHaW9AfmRnKPrZVHiETduNlLIO0FQ/Xdo+i9xv+cOevh/l4SU
	vDewIQOe1snvoJm4mFK/hgMIQSKUkG2H/zdDAzXKjEuDjEBjR0JtRbPQPMSGH8XCsEBio3a0HDP
	Y5wD2evwoPAlUY4gKXYg05wuWaOnjKCCigPMXF+i076elxRUbCLmGfqc2YFe3FMSVgeE8qUlvRA
	==
X-Google-Smtp-Source: AGHT+IHac/OU38oaL4SeRanD0IBJjpU5pK2pT9HBdMJYzjVzQBpxhyEWsS8S/dnE49bnlbnBzI69bQ==
X-Received: by 2002:a05:6a00:114b:b0:76b:42e5:fa84 with SMTP id d2e1a72fcca58-7723e21e9aamr18872098b3a.7.1756945053315;
        Wed, 03 Sep 2025 17:17:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2a0485sm17251479b3a.25.2025.09.03.17.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:17:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1utxfN-0000000EwBP-3gnB;
	Thu, 04 Sep 2025 10:17:29 +1000
Date: Thu, 4 Sep 2025 10:17:29 +1000
From: Dave Chinner <david@fromorbit.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHES v3][RFC][CFT] mount-related stuff
Message-ID: <aLjamdL8M7T-ZFOS@dread.disaster.area>
References: <20250825044046.GI39973@ZenIV>
 <20250828230706.GA3340273@ZenIV>
 <20250903045432.GH39973@ZenIV>
 <CAHk-=wgXnEyXQ4ENAbMNyFxTfJ=bo4wawdx8s0dBBHVxhfZDCQ@mail.gmail.com>
 <20250903181429.GL39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903181429.GL39973@ZenIV>

On Wed, Sep 03, 2025 at 07:14:29PM +0100, Al Viro wrote:
> On Wed, Sep 03, 2025 at 07:47:18AM -0700, Linus Torvalds wrote:
> > On Tue, 2 Sept 2025 at 21:54, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > If nobody objects, this goes into #for-next.
> > 
> > Looks all sane to me.
> > 
> > What was the issue with generic/475? I have missed that context..
> 
> At some point testing that branch has caught a failure in generic/475.
> Unfortunately, it wouldn't trigger on every run, so there was
> a possibility that it started earlier.  
> 
> When I went digging, I've found it with trixie kernel (6.12.38 in
> that kvm, at the time) rebuilt with my local config; the one used
> by debian didn't trigger that.  Bisection by config converged to
> PREEMPT_VOLUNTARY (no visible failures) changed to PREEMPT (failures
> happen with odds a bit below 10%).
> 
> There are several failure modes; the most common is something like
> ...
> echo '1' 2>&1 > /sys/fs/xfs/dm-0/error/fail_at_unmount
> echo '0' 2>&1 > /sys/fs/xfs/dm-0/error/metadata/EIO/max_retries
> echo '0' 2>&1 > /sys/fs/xfs/dm-0/error/metadata/EIO/retry_timeout_seconds
> fsstress: check_cwd stat64() returned -1 with errno: 5 (Input/output error)
> fsstress: check_cwd failure
> fsstress: check_cwd stat64() returned -1 with errno: 5 (Input/output error)
> fsstress: check_cwd failure
> fsstress: check_cwd stat64() returned -1 with errno: 5 (Input/output error)
> fsstress: check_cwd failure
> fsstress: check_cwd stat64() returned -1 with errno: 5 (Input/output error)
> fsstress: check_cwd failure
> fsstress killed (pid 10824)
> fsstress killed (pid 10826)
> fsstress killed (pid 10827)
> fsstress killed (pid 10828)
> fsstress killed (pid 10829)
> umount: /home/scratch: target is busy.
> unmount failed
> umount: /home/scratch: target is busy.
> umount: /dev/sdb2: not mounted.
> 
> in the end of output (that's mainline v6.12); other variants include e.g.
> quietly hanging udevadm wait (killable). 

Huh. I've been seeing that "udevadm wait hang" on DM devices issue
for a while now when using my check-parallel variant of fstests.

It sometimes reproduces every run, so it can be under 5 minutes to
reproduce on a 64-way concurrent test run.  It also affects most of
the tests that use DM devices (which all call udevadm wait), not
just generic/475.  Running 'pkill udevadm' is usually enough to get
everything unstuck and then the tests continue running.

However, I haven't been able to isolate the problem as running the
tests single threaded (ie. normal fstests behaviour) never
reproduced it, which is bloody annoying....

> It's bloody annoying to bisect -
> 100-iterations run takes about 2.5 hours and while usually a failure happens
> in the first 40 minutes or so or not at all...

That seems to be the case for me, too. If the default XFS config
completes (~8 minutes for auto group), then the rest of the configs
also complete (~2 hours for a dozen different mkfs/mount configs
to run through auto group tests).

> PREEMPT definitely is the main contributor to the failure odds...

My test kernels are built with PREEMPT enabled, so it may very
likely be a contributing factor:

CONFIG_PREEMPT_BUILD=y
CONFIG_ARCH_HAS_PREEMPT_LAZY=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_LAZY is not set
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y

> I'm doing
> a bisection between v6.12 and v6.10 at the moment, will post when I get
> something more useful...

check-parallel is relatively new so, unfortunately, I don't have any
idea when this behaviour might have been introduced.

FWIW, 'udevadm wait' is relatively new behaviour for both udev and
fstests. It was introduced into fstests for check-parallel to
replace 'udevadm settle'. i.e. wait for the specific device to
change to a particular state rather than waiting for the entire udev
queue to drain.  Check-parallel uses hundreds of block devices and
filesystems at the same time resulting in multiple mount/unmount
occurring every second. Hence waiting on the udev queue to drain
can take a -long- time, but maybe waiting on the device node state
chang itself is racy (i.e. might be a udevadm or DM bug) and PREEMPT
is opening up that window.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

