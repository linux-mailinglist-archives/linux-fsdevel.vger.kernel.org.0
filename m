Return-Path: <linux-fsdevel+bounces-14778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D54087F2EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 23:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B823DB22706
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 22:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C2259B74;
	Mon, 18 Mar 2024 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="LiHA1EIG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562E58AAF
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799586; cv=none; b=iy1SWrJ5qP/d6ILOgLb6aKAVOGJKb236gBUFhxOFHUOCT/XE+Pth2lUyHExR9+Ngo7tXdX+ePjH1sxnw/3ojJ+YtaCNUiB6Evq9nuyBrLK6HmkEBYMG3jjhhXzZKFSblevF1x4bqkqV0budezDqYgBF1RSbsKO/qfceZ0KQwmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799586; c=relaxed/simple;
	bh=CvSnN2pJwsOSQXujT8XZ9VJyh8AUAgmfw6DLEt9dVbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7PRrkN8nTiswBUZ9VplgRtcaj7YG195mHNbn9VTAb6stm+juxb9pVsduPhYeZEufxiPwI5jj72VAePVjQGh7RogqqRxWqoJjqHhhkhdHAKGDUnu0i/F7x2Ic4+lJSAZmHWSZYnN9aVo5LFRVFzZ7pldHqvfTxUQXbwhzg4Fcr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=LiHA1EIG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso2035820b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 15:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710799583; x=1711404383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=llAqtHkUM+V9LtUAaqPShx3V52b3OEOB72SlFUiDPMI=;
        b=LiHA1EIG65jEZ20eQBAF8QBtmaAx2ASmeM2VbcQiZAaGosVVYVRgqSEPK935xjp4yB
         puKExNmKQKOTzW119VDtT0jGwNlaWFHJ5hHJjeencS2LLXcde7oJuIOqlVwLlJb6O4W/
         m4dsp2mmDz/0vEh4bh2Qn++rYyNm+Wv7MPYU60VwOke2jcPtH00f0bEOjdX7ftlAduYz
         ddjMePXgflm+cahAkWnlvtJvf2iVA/K+93J7MLqLRSH89mVzk4PDL8ED5U49fBDvYb4+
         Uxm9rxlTW1b5UikhPl7KKLyxtJxLe4hVE6v6pDOb6Ra8EzfVQzgXzIg0wAtP1LoseXuI
         4qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710799583; x=1711404383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llAqtHkUM+V9LtUAaqPShx3V52b3OEOB72SlFUiDPMI=;
        b=ttoePeCarQBlOE7DrqPBsdqMsAna9XPAnBQe2G8XB8kFQMfdt5D2TQcp53uly9eieY
         qFWtin4y0mqA9DAgRnTP11t+3IQBZZhwGOYfJg4oTUFAGjbCs9wkYvGHZPksVNL7lpNA
         6mSq8WItBOIjSljUgYQl8iDa6RL+fLJkaZC5AlsyB+4059euzgVvhoigkCqM5rv+goB2
         3NyCNkMMWAN1JrQoQV8R1zOdrs88bevNNYrMyvQ5vHQ1o3CaaoHGyDvVe7IxU/1bY+y8
         iFT9C2tktDeuRCNexXqjk23n7XYHQrrokSgNmodoWx5fPxhlpUKIgxoyEkR4FdAG221l
         8qzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjkXw15QKnD7XSGyiDfYoimQE/yJoVJenkkPx8ER7ezP4n7BJKw1Ww146gkGvFHzE82RISWxwwY5qAyWI/OC6rhNdJcvmJ8huzQ+VxTA==
X-Gm-Message-State: AOJu0YwIMFQnCkgrJ8s/I2ZeHOCyi0QE23Bk5zDVxY13JNlpi5ewHKiq
	0/pLMti8ygmRC7aSvisDJYs9ezR5OIRmFw7J/IotaB4YI3HHUN7XKc19cfmmnm8=
X-Google-Smtp-Source: AGHT+IEX+h044MfpqNpkLVsLecdp4wnCcyoIYE7wCAC9v+H0v8x4GY/sXmA+5pqrxgSYsgSaIlZMYQ==
X-Received: by 2002:a05:6a00:a11:b0:6e6:451c:a519 with SMTP id p17-20020a056a000a1100b006e6451ca519mr13751257pfh.5.1710799582154;
        Mon, 18 Mar 2024 15:06:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-185-123.pa.nsw.optusnet.com.au. [49.180.185.123])
        by smtp.gmail.com with ESMTPSA id s26-20020a65691a000000b005e838b99c96sm3923546pgq.80.2024.03.18.15.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 15:06:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rmL7a-003nIG-2D;
	Tue, 19 Mar 2024 09:06:18 +1100
Date: Tue, 19 Mar 2024 09:06:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	Leah Rumancik <leah.rumancik@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem testing
Message-ID: <Zfi62v5FWDeajwLq@dread.disaster.area>
References: <87h6h4sopf.fsf@doe.com>
 <87cyrre5po.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyrre5po.fsf@mailhost.krisman.be>

On Mon, Mar 18, 2024 at 02:48:51PM -0400, Gabriel Krisman Bertazi wrote:
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
> 
> > Leah Rumancik <leah.rumancik@gmail.com> writes:
> >
> >> Last year we covered the new process for backporting to XFS. There are
> >> still remaining pain points: establishing a baseline for new branches
> >> is time consuming, testing resources aren't easy to come by for
> >> everyone, and selecting appropriate patches is also time consuming. To
> >> avoid the need to establish a baseline, I'm planning on converting to
> >> a model in which I only run failed tests on the baseline. I test with
> >> gce-xfstests and am hoping to automate a relaunch of failed tests.
> >> Perhaps putting the logic to process the results and form new ./check
> >> commands could live in fstests-dev in case it is useful for other
> >> testing infrastructures.
> >
> > Nice idea. Another painpoint to add - 
> > 4k blocksize gets tested a lot but as soon as we switch to large block
> > size testing, either with LBS, or on a system with larger pagesize...
> > ...we quickly starts seeing problems. Most of them could be testcase
> > failure, so if this could help establish a baseline, that might be helpful.
> >
> >
> > Also if could collborate on exclude/known failures w.r.t different
> > test configs that might come handy for people who are looking to help in
> > this effort. In fact, why not have different filesystems cfg files and their
> > corresponding exclude files as part of fstests repo itself?  
> > I know xfstests-bld maintains it here [1][2][3]. And it is rather
> > very convinient to point this out to anyone who asks me of what test
> > configs to test with or what tests are considered to be testcase
> > failures bugs with a given fs config.
> >
> > So it will very helpful if we could have a mechanism such that all of
> > this fs configs (and it's correspinding excludes) could be maintained in
> > fstests itself, and anyone who is looking to test any fs config should
> > be quickly be able to test it with ./check <fs_cfg_params>. Has this
> > already been discussed before? Does this sound helpful for people who
> > are looking to contribute in this effort of fs testing?

Filesystem configs have already been implemented, yes? i.e. config
file sections.

We can do delta definitions like this in the config file:

RECREATE_TEST_DEV=true
TEST_MNT=/mnt/test
TEST_DEV=/dev/vda
SCRATCH_MNT=/mnt/scratch
SCRATCH_DEV=/dev/vdb
MKFS_OPTIONS=
MOUNT_OPTIONS=

[xfs_4k]
MKFS_OPTIONS="-m rmapbt=1"

[xfs_4k_quota]
MKFS_OPTIONS="-m rmapbt=1"
MOUNT_OPTIONS="-o uquota,gquota,pquota"

[xfs_1k]
MKFS_OPTIONS="-m rmapbt=1 -b size=1k"
MOUNT_OPTIONS=

[xfs_n64k]
MKFS_OPTIONS="-m rmapbt=1 -n size=64k"

....

And then simply run 'check -s xfs_n64k' or "-s xfs_4k_quota" or
"-s xfs_1k", etc to run the tests against a pre-defined filesystem
configuration.

The actual per-system customised part of the config file is the
initial device and mount definitions, all the fs config definitions
are fixed and never really change. So we could ship a config file
like the above as a template alongside config/example.config (e.g.
example.xfs.config) and then the test environment setup can simply
copy the file and use sed to rewrite the devices/mount points to
match what it is going to use...

IOWs, I think the fs config thing is already a solved problem, and
we already have precedent for shipping example config files...

As for excludes - unlike fs configs, these are not static across all
test environments. They are entirely dependent on what
kernel/userspace combination is being tested and the constraints the
test running is executing under (e.g.  runtime constraints). IOWs,
every external test runner has a different set of tests that it will
need to expunge...

As it is, it would be trivial to add a config file section variable
to define an expunge file for a given config section. That way
the test running could keep it's own expunge files and add them
to the relevant section when setting up the test VM environment,
same as it would do for the devices and mounts.

That way the expunge file isn't needed on the CLI, and so the test
runner could just do 'check -s xfs_4k -s xfs_1k -s xfs_4k_quota" and
get all those configs tested and have all the local expunges for the
different configs just work....

> > [1] [ext4]:
> > https://github.com/tytso/xfstests-bld/tree/master/test-appliance/files/root/fs/ext4/cfg
> 
> Looking at the expunge comments, I think many of those entries should
> just be turned into inline checks in the test preamble and skipped with
> _notrun.

This is the right thing to do - reduce the reliance on expunge
files, and hence get rid of the need for them in most cases
altogether. The best code is -no code-.

> The way I see it, expunged tests should be kept to a minimum,
> and the goal should be to eventually remove them from the list, IMO.
> They are tests that are known to be broken or flaky now, and can be safely
> ignored when doing unrelated work, but that will be fixed in the
> future. Tests that will always fail because the feature doesn't exist in
> the filesystem, or because it asks for an impossible situation in a
> specific configuration should be checked inline and skipped, IMO.

> +1 for the idea of having this in fstests.  Even if we
> lack the infrastructure to do anything useful with it in ./check,
> having them in fstests will improve collaboration throughout
> different fstests wrappers (kernelci, xfstests-bld, etc.)

Except that this places the maintenance burden on fstests, in
an environment where we can do -nothing- to validate the correctness
of these lists, nor have any idea of when tests should or
shouldn't be placed in these lists.

i.e. If your test runner needs to expunge tests for some reason,
either keep the expunge lists with the test runner, or add detection
to the test that automatically _notrun()s the test in enviroments
where it shouldn't be run....

I'd much prefer the improvement of _notrun detection over spreading
the expunge file mess further into fstests. THis helps remove the
technical debt (lack of proper checking in the test) rather than
kicking it down the road for someone else to have to deal with in
future.

Centralisation of third party expunge file management is not the
answer.  We should be trying to reduce our reliance on expunges and
the maintenance overhead they require, not driving that expunge file
maintaintenance overhead into fstests itself...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

