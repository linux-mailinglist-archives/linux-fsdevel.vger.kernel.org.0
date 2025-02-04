Return-Path: <linux-fsdevel+bounces-40689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294A4A2692A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 01:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49387A1643
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 00:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7780778F2F;
	Tue,  4 Feb 2025 00:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="zXfHl8Md"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C513D984
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 00:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630635; cv=none; b=BWYGLkqkjAmrJJqYMeid+mN93saCWz3SlwNdT5KB+7VF/sPlhFj+MGoJ2D3vs385uOJHKePBh/sYfwRdJxzORl2yFF9fikB6waOmGQKbVxwX/r4aB1JhAugv7WLI41gzfdW5o6KuCfpVVnidHMZZ6NX6SdeXNJZKjm6437PQz/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630635; c=relaxed/simple;
	bh=oiLUKUDZOYvmK41Onre1RolRq53uGNsk5eGM+dMuVkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaRfNnulkOrAb0XLpndbL62jUgeCxnoEDioNpTepS/6bJYuPLP0dzpUfV+N+0p213zp89kIvhaAOZcMSS5ECddVR/6ZYNEDgXxJvuPobFtsi0rx70mcVT48XtrJ1RdpmMRjZsUvp0AfZY47vvt3kOiUBDiirn/2y/tDC2Mmc/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=zXfHl8Md; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215770613dbso67632045ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 16:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738630633; x=1739235433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z/aSNMvlIqXHjg/enZtzf9JO5T6sojygsT9ZaPe+Jqc=;
        b=zXfHl8Md/72t5xTuvA8SIOey+SY6yRc2qVPW8fhzItImiqo6FsPfLKiL7dRwkE316B
         ba28VtBvx1szOioIMgi5d3sxSruRPSG+wqzJxa++mTUGZr7Ttw1IDiI5OibDGxyz3d6X
         sANcNtdo51jH52al9yMN4bmvzUkCAj0p5f6TY8aRmCvoI91JaValqYKOqzfHBzNlPFDh
         I4z6YG5VEt0yJ8Zh9fo3qA3SgnrdmR3zSWsj+Bc3WBaGu6c/88FjDuAxHdIOArno7ony
         Z3qIgyLGZtnCguPJlhwGtpg3I3JZTMoE7JXKxNCsX7m4Y3dSSBhkJCp+YErpavFC+MJq
         CV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630633; x=1739235433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/aSNMvlIqXHjg/enZtzf9JO5T6sojygsT9ZaPe+Jqc=;
        b=ug9ZTG2NOf2hXXwczfUIiNPWVPIBUe16gj7MbUdNGJMiQTBJNSQDnnqkPrT9TEwGd6
         CKp4NNnfU3pVVanXqybXyvoTWcYKMukpo3W36BfBqABv5HY0kUEiCCh9PAjaF2m+8Y54
         4PLO/5JWPrUFDiO6Q/cSWJKtkjZ4kUhRMbiTNKY4BhNic4sgH3o1xYF0yZ01cc7wzVpB
         r6lfZMc03IuKFV8GW6gHAk6v8mqy0DjkdjnuYXU14IboBYBDMnK2stvYeMEKidfk7kqa
         d1iK37thLVUxBiGTbzk3xBRU28IXqSlv9IgWPeZWHY/ZvsU1F8BsPvOFISZKCOZgHVhk
         dTSw==
X-Forwarded-Encrypted: i=1; AJvYcCXVxy9serHYIDX+eo63pXt2YS3qR2bjyrJrAcx5HZHT1jii2SA0+2Z9X6KV/7LLzNtGXDp/B6zRwt8BrrIb@vger.kernel.org
X-Gm-Message-State: AOJu0YyA3lo6old1p1ksLsGAbMg3bizHApebF1/Ozfi09UAkY7dubaxu
	O1Sxk0UuTlHeohek9NuOsxOLjDYM7U2sEMvv8/twswQqjGatSC5uC19zYOOW2PKwnOmCeHVvv3O
	R
X-Gm-Gg: ASbGncvhRzrn3DCoXk5fUgut8oprQG9yQ6Haxxbq7MQt29KnhyW68DXORw2Z5g3eS+I
	7fcdyw8M8g7BBvSuWpJ+Gw0XST+pnBvZKIycEgZSwxcZPZ39TzvoPUWILLAeYBixlRUFofMNVAW
	nTqDTyauEMVwB3bxwZ0RxDUCb5S8oJje2rUSbyE+e6lQLM5EF3NjPV9EefoFlzTK+IuWytou0dZ
	Jg6Q/Vh3BQzBHZNfaiYBlk7+oIrFYrUOoWfnXq59/G6ejDGacaMB4ABN1pAjL1yC0QXu9eMq4PW
	XZqx6+5ptKjBPh21pXuXoqdaMN6qSBSu32v63MH8uGOUajD72SfIe4EGVSqKY10RRLg=
X-Google-Smtp-Source: AGHT+IHES6u10uKUEyRLGEWDG4tJBqjgtlZY1nM9P9+XMAhDrYC4VEpjMERxvGrlDGS9+8t2q0rhXA==
X-Received: by 2002:a17:902:cf01:b0:215:7446:2151 with SMTP id d9443c01a7336-21dd7c4c15dmr437012955ad.4.1738630633051;
        Mon, 03 Feb 2025 16:57:13 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31edcd3sm83865535ad.46.2025.02.03.16.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:57:12 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tf7FV-0000000EJTJ-3Euk;
	Tue, 04 Feb 2025 11:57:09 +1100
Date: Tue, 4 Feb 2025 11:57:09 +1100
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Boris Burkov <boris@bur.io>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, fstests <fstests@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Long Duration Stress Testing Filesystems
Message-ID: <Z6Fl5d34STRzC3K2@dread.disaster.area>
References: <20250203185519.GA2888598@zen.localdomain>
 <CAOQ4uxjiYQHUVkYnv5owPHHvs6BP128Zvuf_LGciENjyJkLa6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjiYQHUVkYnv5owPHHvs6BP128Zvuf_LGciENjyJkLa6w@mail.gmail.com>

On Mon, Feb 03, 2025 at 08:12:59PM +0100, Amir Goldstein wrote:
> CC fstests
> 
> On Mon, Feb 3, 2025 at 7:54 PM Boris Burkov <boris@bur.io> wrote:
> >
> > At Meta, we currently primarily rely on fstests 'auto' runs for
> > validating Btrfs as a general purpose filesystem for all of our root
> > drives. While this has obviously proven to be a very useful test suite
> > with rich collaboration across teams and filesystems, we have observed a
> > recent trend in our production filesystem issues that makes us question
> > if it is sufficient.
> >
> > Over the last few years, we have had a number of issues (primarily in
> > Btrfs, but at least one notable one in Xfs) that have been detected in
> > production, then reproduced with an unreliable non-specific stressor
> > that takes hours or even days to trigger the issue.
> > Examples:
> > - Btrfs relocation bugs
> > https://lore.kernel.org/linux-btrfs/68766e66ed15ca2e7550585ed09434249db912a2.1727212293.git.josef@toxicpanda.com/
> > https://lore.kernel.org/linux-btrfs/fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com/
> > - Btrfs extent map merging corruption
> > https://lore.kernel.org/linux-btrfs/9b98ba80e2cf32f6fb3b15dae9ee92507a9d59c7.1729537596.git.boris@bur.io/
> > - Btrfs dio data corruptions from bio splitting
> > (mostly our internal errors trying to make minimal backports of
> > https://lore.kernel.org/linux-btrfs/cover.1679512207.git.boris@bur.io/
> > and Christoph's related series)
> > - Xfs large folios
> > https://lore.kernel.org/linux-fsdevel/effc0ec7-cf9d-44dc-aee5-563942242522@meta.com/
> >
> > In my view, the common threads between these are that:
> > - we used fstests to validate these systems, in some cases even with
> >   specific regression tests for highly related bugs, but still missed
> >   the bugs until they hit us during our production release process. In
> >   all cases, we had passing 'fstests -g auto' runs.

Have you considered the 'soak' test group with a long SOAK_DURATION
and then increasing the load using LOAD_FACTOR? Also there is a
'stress' group that TIME_FACTOR acts on.

For XFS, there's also bunch of fuzzing tests (in the
dangerous_fuzzers group) that use the same SOAK_DURATION
infrastructure via common/fuzzy.


> > - were able to reproduce the bugs with a predictable concoction of "run
> >   a workload and some known nasty btrfs operations in parallel". The most
> >   common form of this was running 'fsstress' and 'btrfs balance', but it
> >   wasn't quite universal. Sometimes we needed reflink threads, or
> >   drop_caches, or memory pressure, etc. to trigger a bug.

That's pretty much what check-parallel does to a system. Loads of
tests run things like drop_caches, memory compaction, CPU hotplug,
etc. check-parallel essentially exposes every test to these sorts
of background perturbations rather than just the one test that is
running that perturbation. IOWs, even the most basic correctness
test now gets exercised while cpu hotplug and memory compaction are
going on in the background....

Eventually, I plan to implement these background perturbations as
separate control tasks for check-parallel so we don't need specific
tests that run a background perturbation whilst the rest of the
system is under test.

> > - The relatively generic stressing reproducers took hours or days to
> >   produce an issue then the investigating engineer could try to tweak and
> >   tune it by trial and error to bring that time down for a particular bug.
> >
> > This leads me to the conclusion that there is some room for improvement in
> > stress testing filesystems (at least Btrfs).
> >
> > I attempted to study the prior art on this and so far have found:
> > - fsstress/fsx and the attendant tests in fstests/. There are ~150-200
> >   tests using fsstress and fsx in fstests/. Most of them are xfs and
> >   btrfs tests following the aforementioned pattern of racing fsstress
> >   with some scary operations. Most of them tend to run for 30s, though
> >   some are longer (and of course subject to TIME_FACTOR configuration)

As per above, SOAK_DURATION.

> > - Similar duration error injection tests in fstests (e.g. generic/475)
> > - The NFSv4 Test Project
> >   https://www.kernel.org/doc/ols/2006/ols2006v2-pages-275-294.pdf
> >   A choice quote regarding stress testing:
> >   "One year after we started using FSSTRESS (in April 2005) Linux NFSv4
> >   was able to sustain the concurrent load of 10 processes during 24
> >   hours, without any problem. Three months later, NFSv4 reached 72 hours
> >   of stress under FSSTRESS, without any bugs. From this date, NFSv4
> >   filesystem tree manipulation is considered to be stable."
> >
> >
> > I would like to discuss:
> > - Am I missing other strategies people are employing? Apologies if there
> >   are obvious ones, but I tried to hunt around for a few days :)

check-parallel.

> > - What is the universe of interesting stressors (e.g., reflink, scrub,
> >   online repair, balance, etc.)

memory compaction, cpu hotplug, random reflinks of the underlying
loop device image files to simulate dynamic VM image file snapshots,
etc.

> > - What is the universe of interesting validation conditions (e.g.,
> >   kernel panic, read only fs, fsck failure, data integrity error, etc.)

All of them. That's the point of check-parallel - it uses simple,
existing filesystem correctness tests to generate a massively
stressful load on the system...

> > - Is there any interest in automating longer running fsstress runs? Are
> >   people already doing this with varying TIME_FACTOR configurations in
> >   fstests?

At least for XFS, Darrick is already doing that, and I think Carlos
may be as well.

> > - There is relatively less testing with fsx than fsstress in fstests.
> >   I believe this creates gaps for data corruption bugs rather than
> >   "feature logic" issues that the fsstress feature set tends to hit.
> > - Can we standardize on some modular "stressors" and stress durations
> >   to run to validate file systems?

I think we already have that with the "soak" and "stress" groups...

> > In the short term, I have been working on these ideas in a separate
> > barebones stress testing framework which I am happy to share, but isn't
> > particularly interesting in and of itself. It is basically just a
> > skeleton for concurrently running some concurrent "stressors" and then
> > validating the fs with some generic "validators". I plan to run it
> > internally just to see if I can get some useful results on our next few
> > major kernel releases.

check-parallel is effectively a massive concurrent stress workload
for the system. It does this by running many individual correctness
tests concurrently.

Run it on a 64p system or larger, and it will hammer both the test
filesystems and base filesystem that all the loop device image files
are laid out on.  I'm seeing it generate 5-6GB/s of IO load, 40-50GB
of memory usage, and consistently use >90% of the CPU in the system
stress the scheduler at over half a million context switches/s.

> > And of course, I would love to discuss anything else of interest to
> > people who like stress testing filesystems!

Filesystem stress testing by itself isn't really interesting to me.
Using filesystem correctness tests to create massively stressful
workloads, OTOH, attacks the problem from multiple angles and
exercises the system well outside the bounds of just filesystem
code.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

