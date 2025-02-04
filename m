Return-Path: <linux-fsdevel+bounces-40786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC455A278B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 18:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4513A1751
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787BB217704;
	Tue,  4 Feb 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qwz1b2hT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B61A21764F;
	Tue,  4 Feb 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690591; cv=none; b=kk7WgP6QIUYvLEJvNry6tyL2CJ2l20nHTLmCxml8oKnCupnPPTQbXwa4sbDJY36bPAZGLyfwLHOWmIUSu1lNZ5s2m90Xf9Hyi6iiK2CZHFKWpPn/5exIWXo5lhsAxiv1QIE15RlWRxrcaR7jdqh85IkDAkIEoHA5MkiJnC/3LEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690591; c=relaxed/simple;
	bh=mJoRNT/c0ha8OMPTHba0V8u4uxTClqTRzrhJOlFH2Pc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=deaQ3Ddzknk+9RCxE/70LfNHC3SAdrG+mTHThTfT5W1fSWghnNhANH7rAIXW3OcnU3EcAsAgs/kWWYN6NYTUUyXVYK1usRDpyc0I1913II3xugROVALIHgM3C8LWGid2SA52fgZstaD+IOXzoFG5eiXQ9DMh6F75nRvpdt5WaG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qwz1b2hT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21619108a6bso99672425ad.3;
        Tue, 04 Feb 2025 09:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738690589; x=1739295389; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fBTd+QKws5bL0u6aVraqPtVTxCvfaWJHWL05QjdevL8=;
        b=Qwz1b2hTuINduJRw7PyPChNK3Dyty+US5mf/JB1xaDSAeHD6+3iwVC37rB2eJJWUZJ
         Ac8PMG5UGBMiQ3a0Y4PPmiTE/sg0llKxscBJGEgZAjdMY9RqyhmllevH57qQPrw7KyWW
         HzfzMgJHQnMP8GsgE5QCMJhJyJE2w9zk1KwXFCZEGLhWR+k8WF8NqXzX/jxNZUrug0B2
         95Vtm+kiZBeyS9J8jh1fG9V4VDkTQiRjaELHc25zbZdneZlObsX6OtGwkxJUjXscPyrM
         1ZQEZ4f6e2LzsF9Uud38t08vrD2WBnEv3mL5i7eRXc3CUAmJiSkRd77DeeJSwadMTYAH
         msaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738690589; x=1739295389;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBTd+QKws5bL0u6aVraqPtVTxCvfaWJHWL05QjdevL8=;
        b=ehQ9kmzk3bQIp/Nwb6NUxQx1Uqh/TRfL9TEJsJGlRNs7z0FgraFF0vKQR/BCm4DbF8
         38c1dHXM2Bhlrg4B4TRwXzlXy4AHj1rOySKuPrX0DhiUGo6yqt3JmJsqWPzr35HkwwaC
         4N/WWG2gODzLaQHIsVHda79eOrKfMkbAdE4vRZZzZxhLROo0zjYgCqjzD6m2LGIdvo9U
         E/q996Q481C8nMDgsaCvAWKIgnL/5ZImGajBPAbvK7ALMyZfdA4Q24CWOyqKGYM+59Q4
         uw2lrodwV2pOQyPZ4jRvWv48pL1Xbh+mYSPKZ3+Gh1sTEu7SWuZXfjqxJ7QCiaPCvTgD
         6LzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzBLLnkPNGKoCWXXP7pGZs3Lgd5PuLxU1rqeT1gzS6JD9nuY1sOBjw1edufgrh0sMXTr4uTPQswjMBBWk+Zg==@vger.kernel.org, AJvYcCXI7mJUB8MKeUzKnd4QBWkJyFQwIZFCk9W2EPkR4C2Zayb2o2OykT9z8/h0mWIq23jmYFfha6rYLR+U@vger.kernel.org, AJvYcCXLGK3okx5KyKodHGCi/xvssuvLcdXSbBZq4UE/ptq/nosxAzfbeZZ5VPzZnMgmIT4ZszrhIyMkfK0z@vger.kernel.org
X-Gm-Message-State: AOJu0YxKZoNTBiB08N6EcW60gXyuPwlzZJw13OKVRH0jKeIFLrA+Vhal
	FFzkis5GR6ng45PyDYnDlByGxiaXNSNiRj27z38Qu3UO/ZPbzd67
X-Gm-Gg: ASbGncuVwyLE3O5mw2CDFqdE7U3AIrW6qniVcKW5NFwgkge6iing/d79WDg/Q6oH5o1
	3f0ezUmk4VCxFAOFZZ8rTrHl/OYogyKYwWDENwBjxkouEtBh9B0fCFzw95UzpTX46KBb01duHgT
	uRvolfLH5HbuPfAn1VaVT8IK2i26AI2pFOW0nw01aK1NTHUy9XRa1JUcIVk/uUCzHe8uINPPVHy
	IW9Adk+Hm2SS5ROdFY3KWQxGRHMPkjy7QBHYFZig2yVbqlHR3yENWKHgXPBfGXadSSSiHaN3cIp
	9U7PWwcz
X-Google-Smtp-Source: AGHT+IFt+GHa7BXc/6mtnMTCsNzN7apr1kW66uEGf5H/QpgvNqot84o+EjiUboQmXI8W5ZHtrZT/8w==
X-Received: by 2002:a17:902:e742:b0:215:a97a:c6bb with SMTP id d9443c01a7336-21dd7c65891mr432206515ad.12.1738690589126;
        Tue, 04 Feb 2025 09:36:29 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f5f4esm100365155ad.69.2025.02.04.09.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:36:28 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, djwong@kernel.org, dchinner@redhat.com, jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org, nirjhar.roy.lists@gmail.com, zlang@kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] xfstests: Centralizing filesystem configs and device configs
In-Reply-To: <Z6FFlxFEPfJT0h_P@dread.disaster.area>
Date: Tue, 04 Feb 2025 12:44:00 +0530
Message-ID: <87ed0erxl3.fsf@gmail.com>
References: <Z55RXUKB5O5l8QjM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <Z6FFlxFEPfJT0h_P@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> On Sat, Feb 01, 2025 at 10:23:29PM +0530, Ojaswin Mujoo wrote:
>> Greetings,
>> 
>> This proposal is on behalf of Me, Nirjhar and Ritesh. We would like to submit
>> a proposal on centralizing filesystem and device configurations within xfstests
>> and maybe a further discussion on some of the open ideas listed by Ted here [3].
>> More details are mentioned below.
>> 
>> ** Background ** 
>> There was a discussion last year at LSFMM [1] about creating a central fs-config
>> store, that can then be used by anyone for testing different FS
>> features/configurations. This can also bring an awareness among other developers
>> and testers on what is being actively maintained by FS maintainers. We recently
>> posted an RFC [2] for centralizing filesystem configuration which is under
>> review. The next step we are considering is to centralize device configurations
>> within xfstests itself. In line with this, Ted also suggested a similar idea (in
>> point A) [3], where he proposed specifying the device size for the TEST and
>> SCRATCH devices to reduce costs (especially when using cloud infrastructure) and
>> improve the overall runtime of xfstests.
>> 
>> Recently Dave introduced a feature [4] to run the xfs and generic tests in
>> parallel. This patch creates the TEST and SCRATCH devices at runtime without
>> requiring them to be specified in any config file. However, at this stage, the
>> automatic device initialization appears to be somewhat limited. We believe that
>> centralizing device configuration could help enhance this functionality as well.
>
> Right, the point of check-parallel is to take away the need to
> specify devices completely.  I've already added support for the
> LOGWRITES_DEV, and I'm in the process of adding LOGDEV and RTDEV
> support for both test and scratch devices. At this point, the need
> for actual actual device specification in the config files goes
> away.
>
> What I am expecting to need is a set of fields that specify the
> *size* of the devices so that the hard-coded image file sizes in
> the check-parallel script go away.
>
> From there, I intend to have check-parallel iterate config file run
> sections itself, rather than have it run them internally to check.
> That way check is only ever invoked by check-parallel with all the
> devices completely set up.

Yes, this sounds good. This is what we were anticipating too.
Thanks for sharing.

>
> Hence a typical host independent config file would look like:

The work being proposed by us here was to make this config file
centralized within xfstests itself for both fsconfig and device-config.
This saves us from defining each of this section within local.config file
and can be used by passing cmdling arguments to invoke a given section
directly. 

e.g.

    ./check -c configs/xfs/64k -g auto

There have been cases where testers and others have requested info to
know about - 
- What different FS config options to test,
- What gets tested by the Maintainers,  
- Is there a common place where I can find MKFS and MOUNT options which
  I should be testing for my FS/feature testing. 

That is the reason, I think, centralizing fsconfig option can be
helpful. I remember bringing this idea in our last LSFMM-2024, where you
mentioned that - let's see the RFC [1] and maybe then we can discuss more :).
Here is the RFC for the same. There are some additional improvements in
that series, but it mainly adds fsconfig option.

[1]: https://lore.kernel.org/fstests/cover.1736496620.git.nirjhar.roy.lists@gmail.com/

>
> TEST_DEV_SIZE=10g
> TEST_RTDEV_size=10g
> TEST_LOGDEV_SIZE=128m
> SCRATCH_DEV_SIZE=20g
> SCRATCH_RTDEV_size=20g
> SCRATCH_LOGDEV_SIZE=512m
> LOGWRITES_DEV_SIZE=2g
>

For centralizing device-configs idea, I was hoping we could mention above
in "configs/devices/loop" config file. This can be picked up by ./check
too if local.config hasn't been provided with these options.

> [xfs]
> FSTYP=xfs
> MKFS_OPTIONS="-b size=4k"
> TEST_FS_MOUNT_OPTIONS=
> MOUNT_OPTIONS=
> USE_EXTERNAL=
>
> [xfs-rmapbt]
> MKFS_OPTIONS="-b size=4k -m rmapbt=1"
>
> [xfs-noreflink]
> MKFS_OPTIONS="-b size=4k -m reflink=0"
>
> [xfs-n64k]
> MKFS_OPTIONS="-b size=4k -n size=64k"
>
> [xfs-ext]
> MKFS_OPTIONS="-b size=4k"
> USE_EXTERNAL=yes
>
> [ext4]
> FSTYP="ext4"
> MKFS_OPTIONS=
> USE_EXTERNAL=
>
> [btrfs]
> FSTYP="btrfs"
> .....

Above all fs configs could be added to configs/{ext4|xfs|btrfs}/... 
Than this can be used in 2 ways.. 

1. ./check -c configs/xfs/4k,configs/xfs/rmapbt,configs/ext4/4k ... 

2. Or we may still pass fsconfig via local.config file.. e.g. 

# both configs/xfs/4k or xfs/4k can be used here
[xfs]
FS_CONFIG_OPTION=configs/xfs/4k

[xfs-rmapbt]
FS_CONFIG_OPTION=xfs/rmapbt

[xfs-noreflink]
FS_CONFIG_OPTION=xfs/noreflink

[xfs-n64k]
FS_CONFIG_OPTION=xfs/64k

[xfs-ext]
FS_CONFIG_OPTION=xfs/4k
USE_EXTERNAL=yes

[ext4]
FS_CONFIG_OPTION=ext4/4k


>
>
> IOWs, all that is different from system to system is the device size
> setup. The actual config sections under test (e.g. [xfs]) never need
> to change from host to host, nor environment to environment. i.e.
> "xfs-n64k" runs the same config filesystem test on every system,
> everywhere...
>

Right. So it's also useful if those configs can stay in configs/<fs>/**
as well.


>> ** Proposal ** 
>> We would like to propose a discussion at LSFMM on two key features: central
>
> I'm not going to be at LSFMM, so please discuss this on the list via
> email as we'd normally do so. LSFMM discussions are exclusionary
> whilst, OTOH, the mailing list is inclusive...
>

Sure I am happy to discuss this on mailing list too! It will be good to
know from others as well, who do FS testing from time to time, on whether
having a central fsconfig store makes their life easy or not? 
And from other FS maintainers, on whether adding their test fsconfigs to
configs/<fs>/** will save them from maintaining it in their custom CI
wrappers or not? 

>> fsconfig and central device-config within xfstests. We can explore how the
>> fsconfig feature can be utilized, and by then, we aim to have a PoC for central
>> device-config feature, which we think can also be discussed in more detail. At
>> this point, we are hoping to get a PoC working with loop devices by default. It
>> will be good to hear from other developers, maintainers, and testers about their
>> thoughts and suggestions on these two features.
>
> I don't really see a need for a new centralised config setup. With
> the above, we can acheived a "zero-config" goal with the existing
> config file formats and infrastructure. All that we need to do is
> update the default config file in the repo to contain a section for
> each of the "standard" test configs we want to define....
>

Could you please take look at the shared RFC [1] once? I believe it will
be useful to have this central to xfstests for reasons I mentioned
above. This also gets us to zero-config setup with almost no need to
configure anything. This helps other testers & subsystem maintainers to
know what configs are being tested by maintainers, which they can use
for their FS feature testing too.
We can than directly issue -

           ./check -c <fs>/<config> -g quick

[1]: https://lore.kernel.org/fstests/cover.1736496620.git.nirjhar.roy.lists@gmail.com/


>> Additionally, we would like to thank Ted for listing several features he uses in
>> his custom kvm-xfstests and gce-xfstests [3]. If there is an interest in further
>> reducing the burden of maintaining custom test scripts and wrappers around
>> xfstests, we can also discuss essential features that could be integrated
>> directly into xfstests, whether from Ted's list or suggestions from others.
>
> On of my goals with check-parallel is to completely remove the need
> for end users to configure fstests. i.e. all you need to do is point
> it at a directory, tell it which filesystem to test, and it "just
> runs" with all the defaults that come direct from the fstests
> repository...
>

Right. Centralizing fsconfigs & device configs is also doing the same.
In fact once we have configs/devices/loop config file, then we don't
need to even create local.config file (for most cases I believe).

./check and ./check_parallel can be passed these config files and
xfstests infra will create loop devices, run the tests and later do the
cleanups.

e.g. maybe something like this... 
      ./check -c configs/<fs>/config>,configs/devices/loop -g quick

OR
      ./check -c <fs>/config>,devices/loop -g quick
    


> It is also worth keeping in mind that check-parallel can be run with
> a single runner thread, in which case a single check instance runs
> all tests serially. i.e. we can make check-parallel emulate existing
> check behaviour exactly, except it uses all the
> auto-config/auto-setup stuff that comes along with check-parallel...
>

Sure thanks Dave for the review.

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

