Return-Path: <linux-fsdevel+bounces-42884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD56A4AB1D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 14:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3B01894BBA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 13:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE521DF25E;
	Sat,  1 Mar 2025 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnutx6CF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447F71E4AB;
	Sat,  1 Mar 2025 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740834607; cv=none; b=KD4AKCTkJ7kJB0yRWGGgNoVL0duum09HYFt+EaobeSrVmJSmsZeQxm4BW6q5YlpXTbV70tAjk0SxPW4Nbs66eZR6FtiufMHwyBzGvb4zCGHAvBfy9IzhlW+a0feE2UJjzKgjuZB90USFu8mgLR2FKf/otICdZCOeCKWuO0o7LL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740834607; c=relaxed/simple;
	bh=vJ2YX+ZHs91ZGVc7XHXVgcQDcnfgqcXHvUvMvhpfFrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c7vtbgBprb2IUBf6Av2xiZ67acF6u28pneZ+b3wfenThRksQrmyvsVJhnGWOpOcrlJik5ZbSO0F+EJSfmpdKUhFxdO5MHxqMzG+SSquLUfHT6OoHuPELK43aOpssraPRPvRxfD0Vc79edHWZk+spzbKzGdbL+qU4ElETLldRtGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnutx6CF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22328dca22fso48618155ad.1;
        Sat, 01 Mar 2025 05:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740834604; x=1741439404; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOQ5e1blzzwQFLxKKdRkWwyQV9xLcVz3UTYRw1WyUOs=;
        b=gnutx6CFLsHFUBp4MqvCXA44ttZn8GUet0/CbWGMZds2QLFe1sFJJXJwCMcI795KWB
         gInVoepwKmWpyf3+HYZUPX/HqlIDQpWl+jPEC+m+976Lb+DRY+FYb8ZcxjBOsuQW7Z+l
         OFWj2+1WIgfknZS4cyAMymIYSdIZ/uTMNy1ldfVAEq2N0R0yvo/eSXqesH2Ze/EjAoUX
         wa3OFgifawX0drFEFT3E4boN3YBGjBXtuYGSoQvbKWpn4V+8vEDlUDPRdm4Py/LGB1Kr
         orFYLz1HQZVeqVTuSVJoJtHIJBUSKTeU41Zg7DsW3OWY8F228LYV8Tv7EpGzr4tzqhfN
         4tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740834604; x=1741439404;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOQ5e1blzzwQFLxKKdRkWwyQV9xLcVz3UTYRw1WyUOs=;
        b=cEygi/3v3DjKmLWUsz95GAGKOK8O5nJQg304CC8XSaoWouH5J5ZXrTIfwMh7TUQ9lK
         UEwxcp0xNx9Xb0HRAd0QNdJ3+0f2MG6ox3YPyDRrzweuQduR7oYuN4QZptKntTXM3jlU
         3Vrv6PQ939qnkjwSMmwgQ4flqNUHnXL79AfuKJVK1paAKcH/58U3ZZ/M7+pd4x6CJzr2
         lnE7MUPtlB8B4aSwR/AwG8t9MLIUDA30teS2xdCExhdl5EvaP5Jh9hddh+GUthCX+GX+
         1XlwyWXJX6t84AJ1HNFiIYp7WzNISdyBf6H+YehwUfSQR2zJc1OUIHgjiHTb0Gpg7PLK
         m+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0RGpZpzz64tpBLuBfU4KMffTby9VZsr2YPfCNgf3hHQAd8NOfKoTmyaIKiOqgUaXWm2sRgy1xjNFr@vger.kernel.org, AJvYcCXHDdw6Hb6WnqFJ+pIV1NPwGU0vRirm9mZm6D00iHONmxygoIMYAPEP2h9Bq7Eg85jzDfB2uNgoH/aw@vger.kernel.org, AJvYcCXSVsgiuyYukQAdqwmfQnjVByjIzWbPb+I1NtivPHlyyegbWvhkzKJsvTczSbEIMHVIsXrTOkkFq4jFdt/t7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNxgDvVCTyVStdSxpCscp3ZLTqWJJZHCVWxb46F93RI5IB7lFN
	OVgwvmDXyWkrUjkaD3LkyiUpsEcai8ntVdYrcda2PjKdB2AwyHdISPl22g==
X-Gm-Gg: ASbGnctTZF7fKEBXUO++Jpz5QExWL9F20QG0zhcMg0ttiwRTCQkbJkG6zLgP/jnfBCx
	8wtQq88kJD/3OALrQikEkQuZTD1uceT8NrWa+BxTiR3pFGxU0HQuHJZMYUeCuXPhAiaIxRTyGIJ
	Zc+rF/5WO4U/F+iGRrtbPuJRjuEee9gPYnkwccubDfDhzqZh3tXgZ3cA7Lvc2ITz/mlTmKPqh1r
	QjcohJue1Or+ZqlhD70yaASKNiT6XOmSnyid2N3wLSDEyABFVZu04w+uv3IwIDBMudZio3TJpxS
	Y30cznmFoK04QtfoDBjtf4VQ55vYaAOFAaJFkA==
X-Google-Smtp-Source: AGHT+IFty00BUCyNtw6lA1kqq+Z5ennLILAodmmXh6/jZR4+9JoXGKcR88SDOqe5YxQzZ2h3fdmWCA==
X-Received: by 2002:a05:6a00:1808:b0:730:74f8:25b6 with SMTP id d2e1a72fcca58-734ac3628c2mr11116571b3a.6.1740834604252;
        Sat, 01 Mar 2025 05:10:04 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73638e4ab93sm1197989b3a.103.2025.03.01.05.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 05:10:03 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
 lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, djwong@kernel.org, dchinner@redhat.com,
 jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
 nirjhar.roy.lists@gmail.com, zlang@kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] xfstests: Centralizing filesystem configs
 and device configs
In-Reply-To: <Z6KRJ3lcKZGJE9sX@dread.disaster.area>
References: <Z55RXUKB5O5l8QjM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <Z6FFlxFEPfJT0h_P@dread.disaster.area> <87ed0erxl3.fsf@gmail.com>
 <Z6KRJ3lcKZGJE9sX@dread.disaster.area>
Date: Sat, 01 Mar 2025 18:39:57 +0530
Message-ID: <87plj0hp7e.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Dave,

Sorry about the delayed response on this. We gave some thoughts to this
and we believe, we could come to an agreement if we could extend the
current section approach itself. 

Dave Chinner <david@fromorbit.com> writes:

> On Tue, Feb 04, 2025 at 12:44:00PM +0530, Ritesh Harjani wrote:
>> Dave Chinner <david@fromorbit.com> writes:
>> 
>> > On Sat, Feb 01, 2025 at 10:23:29PM +0530, Ojaswin Mujoo wrote:
>> >> Greetings,
>> >> 
>> >> This proposal is on behalf of Me, Nirjhar and Ritesh. We would like to submit
>> >> a proposal on centralizing filesystem and device configurations within xfstests
>> >> and maybe a further discussion on some of the open ideas listed by Ted here [3].
>> >> More details are mentioned below.
>> >> 
>> >> ** Background ** 
>> >> There was a discussion last year at LSFMM [1] about creating a central fs-config
>> >> store, that can then be used by anyone for testing different FS
>> >> features/configurations. This can also bring an awareness among other developers
>> >> and testers on what is being actively maintained by FS maintainers. We recently
>> >> posted an RFC [2] for centralizing filesystem configuration which is under
>> >> review. The next step we are considering is to centralize device configurations
>> >> within xfstests itself. In line with this, Ted also suggested a similar idea (in
>> >> point A) [3], where he proposed specifying the device size for the TEST and
>> >> SCRATCH devices to reduce costs (especially when using cloud infrastructure) and
>> >> improve the overall runtime of xfstests.
>> >> 
>> >> Recently Dave introduced a feature [4] to run the xfs and generic tests in
>> >> parallel. This patch creates the TEST and SCRATCH devices at runtime without
>> >> requiring them to be specified in any config file. However, at this stage, the
>> >> automatic device initialization appears to be somewhat limited. We believe that
>> >> centralizing device configuration could help enhance this functionality as well.
>> >
>> > Right, the point of check-parallel is to take away the need to
>> > specify devices completely.  I've already added support for the
>> > LOGWRITES_DEV, and I'm in the process of adding LOGDEV and RTDEV
>> > support for both test and scratch devices. At this point, the need
>> > for actual actual device specification in the config files goes
>> > away.
>> >
>> > What I am expecting to need is a set of fields that specify the
>> > *size* of the devices so that the hard-coded image file sizes in
>> > the check-parallel script go away.
>> >
>> > From there, I intend to have check-parallel iterate config file run
>> > sections itself, rather than have it run them internally to check.
>> > That way check is only ever invoked by check-parallel with all the
>> > devices completely set up.
>> 
>> Yes, this sounds good. This is what we were anticipating too.
>> Thanks for sharing.
>> 
>> >
>> > Hence a typical host independent config file would look like:
>> 
>> The work being proposed by us here was to make this config file
>> centralized within xfstests itself for both fsconfig and device-config.
>> This saves us from defining each of this section within local.config file
>> and can be used by passing cmdling arguments to invoke a given section
>> directly. 
>> 
>> e.g.
>> 
>>     ./check -c configs/xfs/64k -g auto
>
> This strikes me as re-implementing config sections with a different
> file format.
>
>> There have been cases where testers and others have requested info to
>> know about - 
>> - What different FS config options to test,
>> - What gets tested by the Maintainers,  
>> - Is there a common place where I can find MKFS and MOUNT options which
>>   I should be testing for my FS/feature testing. 
>
> Those are questions that documentation should answer - they are not
> a reason for changing config file formats.
>
>> That is the reason, I think, centralizing fsconfig option can be
>> helpful. I remember bringing this idea in our last LSFMM-2024, where you
>> mentioned that - let's see the RFC [1] and maybe then we can discuss more :).
>> Here is the RFC for the same. There are some additional improvements in
>> that series, but it mainly adds fsconfig option.
>> 
>> [1]: https://lore.kernel.org/fstests/cover.1736496620.git.nirjhar.roy.lists@gmail.com/
>
> Yeah, that's just making a tiny config file per config section, and
> having to add a heap of parsing code to do that.
>
> I find it much easier to manage a single config file where each
> config is maybe only one or two lines than it is to have to find the
> needle in a haystack of hundreds of tiny files that are almost all
> alike.
>
>> > TEST_DEV_SIZE=10g
>> > TEST_RTDEV_size=10g
>> > TEST_LOGDEV_SIZE=128m
>> > SCRATCH_DEV_SIZE=20g
>> > SCRATCH_RTDEV_size=20g
>> > SCRATCH_LOGDEV_SIZE=512m
>> > LOGWRITES_DEV_SIZE=2g
>> >
>> 
>> For centralizing device-configs idea, I was hoping we could mention above
>> in "configs/devices/loop" config file. This can be picked up by ./check
>> too if local.config hasn't been provided with these options.
>
> Great. How do you specify where the image files are going to be
> hosted when no devices have been configured?
>
> These sorts of zero-conf chicken/egg problems have already been
> solved by check-parallel - I'm really not convinced that we need
> to make check itself try to solve these. I designed check-parallel
> the way I did because making check itself solve these problems is
> .... convoluted and difficult.
>
> If we need zero-conf, just use ./check-parallel....
>
>> > [xfs]
>> > FSTYP=xfs
>> > MKFS_OPTIONS="-b size=4k"
>> > TEST_FS_MOUNT_OPTIONS=
>> > MOUNT_OPTIONS=
>> > USE_EXTERNAL=
>> >
>> > [xfs-rmapbt]
>> > MKFS_OPTIONS="-b size=4k -m rmapbt=1"
>> >
>> > [xfs-noreflink]
>> > MKFS_OPTIONS="-b size=4k -m reflink=0"
>> >
>> > [xfs-n64k]
>> > MKFS_OPTIONS="-b size=4k -n size=64k"
>> >
>> > [xfs-ext]
>> > MKFS_OPTIONS="-b size=4k"
>> > USE_EXTERNAL=yes
>> >
>> > [ext4]
>> > FSTYP="ext4"
>> > MKFS_OPTIONS=
>> > USE_EXTERNAL=
>> >
>> > [btrfs]
>> > FSTYP="btrfs"
>> > .....
>> 
>> Above all fs configs could be added to configs/{ext4|xfs|btrfs}/... 
>> Than this can be used in 2 ways.. 
>> 
>> 1. ./check -c configs/xfs/4k,configs/xfs/rmapbt,configs/ext4/4k ... 
>
> Can't say I like using relative paths to specify the config we
> should use. It's not an interface I'd choose over:
>
> 	./check -s xfs -g auto
>
> Especially as the existing config section implementation does
> exactly the same thing as the proposed config file farm....
>
>> 2. Or we may still pass fsconfig via local.config file.. e.g. 
>> 
>> # both configs/xfs/4k or xfs/4k can be used here
>> [xfs]
>> FS_CONFIG_OPTION=configs/xfs/4k
>> 
>> [xfs-rmapbt]
>> FS_CONFIG_OPTION=xfs/rmapbt
>> 
>> [xfs-noreflink]
>> FS_CONFIG_OPTION=xfs/noreflink
>> 
>> [xfs-n64k]
>> FS_CONFIG_OPTION=xfs/64k
>> 
>> [xfs-ext]
>> FS_CONFIG_OPTION=xfs/4k
>> USE_EXTERNAL=yes
>> 
>> [ext4]
>> FS_CONFIG_OPTION=ext4/4k
>
> How is that an improvement on the section setup we have right now?
> Abstracting the config section options into a separate file is the
> worst of both worlds - now I have to look up the section to find the
> file and the section options, then lookup the file to see the
> options that file contains.
>
> It's like you've decided that the solution to centralised management
> of configs must be "one config per file", and so every other way of
> managing options needs to be reframed for that solution....
>
>> > IOWs, all that is different from system to system is the device size
>> > setup. The actual config sections under test (e.g. [xfs]) never need
>> > to change from host to host, nor environment to environment. i.e.
>> > "xfs-n64k" runs the same config filesystem test on every system,
>> > everywhere...
>> 
>> Right. So it's also useful if those configs can stay in configs/<fs>/**
>> as well.
>
> Why is having hundreds of tiny single-config-only files
> better than having all the configs in a single file that is
> easily browsed and searched?
>
> Honestly, I really don't see any advantage to re-implementing config
> sections as a "file per config" object farm. Yes, you can store
> information that way, but that doesn't make it an improvement over a
> single file...
>
> All that is needed is for the upstream repository to maintain a
> config file with all the config sections defined that people need.
> We don't need any new infrastructure to implement a "centralised
> configs" feature - all we need is an agreement that upstream will
> ship an update-to-date default config file instead of the ancient,
> stale example.config/localhost.config files....
>

If we can create 1 config for every filesystem instead of creating a lot
of smaller config files. i.e.  
- configs/ext4/config.ext4
- configs/xfs/config.xfs

Each of above can contain sections like (e.g.)

[xfs-b4k]
MKFS_OPTIONS="-b size=4k"
ddUNT_OPTIdd    d=""dd

[xfs-b64k]
MKFS_OPTIONS="-b size=64k"
MOUNT_OPTIONS=""


Then during make we can merge all these configs into a common config file
i.e. configs/.all-section-configs. We can update the current check script to
look for either local.config file or configs/.all-section-configs file
for location the section passed in the command line. 

This will help solve all the listed problems:
1. We don't have to add a new parsing logic for configs
2. We don't need to create 1 file per config
3. We still can get all sections listed in one place under which check
script can parse.
4. Calling different filesystem sections from a common config file can work.

So as you mentioned calling something like below should work. 

./check -s xfs_4k -s ext4_4k -g quick

Hopefully this will require minimal changes to work. Does this sound
good to you?

It's better if we discuss device config later once the central config
feature design is agreed by then. 

Thanks a lot for your review!
-ritesh



>> > I don't really see a need for a new centralised config setup. With
>> > the above, we can acheived a "zero-config" goal with the existing
>> > config file formats and infrastructure. All that we need to do is
>> > update the default config file in the repo to contain a section for
>> > each of the "standard" test configs we want to define....
>> 
>> Could you please take look at the shared RFC [1] once? I believe it will
>> be useful to have this central to xfstests for reasons I mentioned
>> above. This also gets us to zero-config setup with almost no need to
>> configure anything.
>
> [1]: https://lore.kernel.org/fstests/cover.1736496620.git.nirjhar.roy.lists@gmail.com/
>
> There's nothing in that which provides zero-config. It still
> requires all the devices to be specified by the user...
>
>> This helps other testers & subsystem maintainers to
>> know what configs are being tested by maintainers, which they can use
>> for their FS feature testing too.
>> We can than directly issue -
>> 
>>            ./check -c <fs>/<config> -g quick
>
> As I've already said: this functionality already exists - they are
> called config sections!
>
>> >> Additionally, we would like to thank Ted for listing several features he uses in
>> >> his custom kvm-xfstests and gce-xfstests [3]. If there is an interest in further
>> >> reducing the burden of maintaining custom test scripts and wrappers around
>> >> xfstests, we can also discuss essential features that could be integrated
>> >> directly into xfstests, whether from Ted's list or suggestions from others.
>> >
>> > On of my goals with check-parallel is to completely remove the need
>> > for end users to configure fstests. i.e. all you need to do is point
>> > it at a directory, tell it which filesystem to test, and it "just
>> > runs" with all the defaults that come direct from the fstests
>> > repository...
>> >
>> 
>> Right. Centralizing fsconfigs & device configs is also doing the same.
>> In fact once we have configs/devices/loop config file, then we don't
>> need to even create local.config file (for most cases I believe).
>> 
>> ./check and ./check_parallel can be passed these config files and
>> xfstests infra will create loop devices, run the tests and later do the
>> cleanups.
>
> Please, no.
>
> check-parallel already provides the external zero-conf
> infrastructure that check needs to run without config. It solves the
> chicken/egg problems that check itself has (e.g. how do you specify
> the location of the loop device image files it needs to create for
> zero-conf), and it does it without needing check or it's internal
> infrastructure to be modified in any way.
>
> I've already outlined how we can use check-parallel to run check in
> it's traditional serial form, so there is absolutely no need to try
> to make check jump through hoops to do zero-conf internally.
>
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

