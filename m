Return-Path: <linux-fsdevel+bounces-43310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF32A53E54
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 00:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84AFE7A3A9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 23:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8DC206F37;
	Wed,  5 Mar 2025 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Au4ON27V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7214C1FCD07
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216811; cv=none; b=GU8zczuJjhBVojoLO2pJEMAkj/LmCEQSVdVoHLRkL+xBLkb1Tguzj2PthaO9o03+74aYus4OMiVqybisBCLWrWOp6j6MH+ciahn1Elo4pqsK4oTli59RGsE2nq6YAsf16VM7Q447em9aDPVpc1DeSsB05XguA4wYVpaF/R7BogA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216811; c=relaxed/simple;
	bh=IlczlvgLNWQUhWYGetchSJ6qS5PAxu5v8MHrjIz1jpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxijHPHUyTaE4ie+LyYGcsEtJI7uFrP8OPYWh+PZota1SX6P9Cl2EoMEghOpxh454f994dPkLZ+XIWKLrZV0g2BH+uiBcl4dB3RDymWx7i4YjOZ4L2Ks+z6ii1Lgir4pBBEHWprdDieyCui5XF/qzJA5xXlM4NlmbJIDm3h89ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Au4ON27V; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223594b3c6dso76115ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Mar 2025 15:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741216809; x=1741821609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4wlptahmQMs/Fb2ynK1XHee0MSysjPVZXnpqVnsk3s=;
        b=Au4ON27VfjBxW+kdNBCQgWqxxRxixMRxA0ICeXjGK3xzGnedst7m+GKFMkr6CHAACb
         r4nhCqSXwiJNto5/EQg3tKTtFhlOnpWz7uHIsHLfC+4ibFI6KKDh18cEOSC77NOj6+81
         tR6mv/7oF7zo3SGr6iBvxWOySytnZAoyIoJo77wbMUE3pjeoGhxztddYAUZJR7f6YYIu
         TMd1sGr0vrrqwLwwuuS85E+p0fjYxk+MdDCr8K1IqqE0leZ4qbpfPPq+aAQTwwFJ9V6h
         cLheZUHKbiRJiImwBmsISgeuMQ0SWckW2M/cQ4f9PZtp2RX0p4IPOlvEGmOGGKL9HJJW
         XUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741216809; x=1741821609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4wlptahmQMs/Fb2ynK1XHee0MSysjPVZXnpqVnsk3s=;
        b=BeeGPiE4gN+yNoPcd4gIdgaNV8SFDaVsDo7yE7+jPQpxk+NYjt1kqnFNQfk+uYBYKg
         JWKFSGzr//Hytk2gYi+g10VTG5UL26UPTq6dgLuYmgHM+2VqcpKtyHJzbIBD6e4lEo0U
         kTbSEJK7ksTBjabcblePsJO7gtYixs8mo5k4Y3o3MMH8yBSCLkzO+146iWVtvJYgblI3
         xW8R+UndBBpKMVYR3rKus/PCEJ0HqM3kjvNRpFRWVHYkWeXXKpt0XjxcsLx7ku2dbuQc
         cLvrCykARQSBR96vZOcucaOMfmVU20xHSTWkOUxXCdmZl6vvE+4xHC4kBgAUL9au0UfN
         CmUg==
X-Forwarded-Encrypted: i=1; AJvYcCXTBMWzlt7SDoxopVAmI0IBoaqTuYjApqkMkBZ7xkZ0nuhxVtZiJcWat7EVAvOoVojiS2QSIlFqjqzzVQiY@vger.kernel.org
X-Gm-Message-State: AOJu0YyUAOR2Zak/4Kk62ltN9qmYzCHZPePInj3eQbSm+OTAIvJWpIuf
	AiyOMYaxeI1msvHwuZYiW9fG7F/KOlN5p29AAyjMwsK3mOG4Q+5qTYFIYcoP6LA=
X-Gm-Gg: ASbGncsa9fWc+sQKN7u39KQ15fxr9xUCSqEsWhQN5WWb+otr8yNbkhS5/RG8r5x0zpD
	fXoXOnzhZRIzLK3mJ4J/pBwRFwX9oaqL/xy51rPcXz8Lw5R1e22QWFcFBqOpkSypN3T7nF4l8cR
	sq1wb+9vycwIGMpGRT7RkPVENePfEEH1h4/TstDZQ1/lfsMR1XcWZjAQFajGx7jzp39XmKX1QQC
	dx/BdPJbaATer+ZHAHcgHxUyWVlyDR5xIPhd0NiJxbPasL73pfYAJgNVcGXqP1km8MumK2+052Y
	1gqEN7lMCLxKLOQb5MyERkKMv9KG/fraF03hs+Vz0sw1rNK15l4sQx3QutUu4LFsWYBfRC/zWCR
	V/mVTmRQ/r0ZRzzIThMJX
X-Google-Smtp-Source: AGHT+IGHBcZzIWBD3p56bgNzihzorlBFnclCb3Cz6c4m2b1dMenf3yejL/jsPmxbml4Y6dWA23qHcg==
X-Received: by 2002:a05:6a00:cc7:b0:736:5725:59b4 with SMTP id d2e1a72fcca58-73682b5a0b6mr8413036b3a.3.1741216808683;
        Wed, 05 Mar 2025 15:20:08 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73648f97953sm7582654b3a.166.2025.03.05.15.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:20:07 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tpy21-00000009Mnj-1awC;
	Thu, 06 Mar 2025 10:20:05 +1100
Date: Thu, 6 Mar 2025 10:20:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org,
	dchinner@redhat.com, jack@suse.cz, tytso@mit.edu,
	linux-ext4@vger.kernel.org, nirjhar.roy.lists@gmail.com,
	zlang@kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] xfstests: Centralizing filesystem configs and
 device configs
Message-ID: <Z8jcJaUvNfPy_B1V@dread.disaster.area>
References: <Z55RXUKB5O5l8QjM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <Z6FFlxFEPfJT0h_P@dread.disaster.area>
 <87ed0erxl3.fsf@gmail.com>
 <Z6KRJ3lcKZGJE9sX@dread.disaster.area>
 <87plj0hp7e.fsf@gmail.com>
 <Z8d0Y0yvlgngKsgo@dread.disaster.area>
 <87frjs6t23.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frjs6t23.fsf@gmail.com>

On Wed, Mar 05, 2025 at 09:13:32AM +0530, Ritesh Harjani wrote:
> Dave Chinner <david@fromorbit.com> writes:
> 
> > On Sat, Mar 01, 2025 at 06:39:57PM +0530, Ritesh Harjani wrote:
> >> > Why is having hundreds of tiny single-config-only files
> >> > better than having all the configs in a single file that is
> >> > easily browsed and searched?
> >> >
> >> > Honestly, I really don't see any advantage to re-implementing config
> >> > sections as a "file per config" object farm. Yes, you can store
> >> > information that way, but that doesn't make it an improvement over a
> >> > single file...
> >> >
> >> > All that is needed is for the upstream repository to maintain a
> >> > config file with all the config sections defined that people need.
> >> > We don't need any new infrastructure to implement a "centralised
> >> > configs" feature - all we need is an agreement that upstream will
> >> > ship an update-to-date default config file instead of the ancient,
> >> > stale example.config/localhost.config files....

.....

> > You haven't explained why we need new infrastructure to do something
> > we can already do with the existing infrastructure. What problem are
> > you trying to solve that the current infrastructure does not handle?
> >
> > i.e. we won't need to change the global config file very often once the
> > common configs are defined in it; it'll only get modified when
> > filesystems add new features that need specific mkfs or mount option
> > support to be added, and that's fairly rare.
> >
> > Hence I still don't understand what new problem multiple config files
> > and new infrastructure to support them is supposed to solve...
> 
> 
> I will try and explain our reasoning here: 
> 
> 1. Why have per-fs config file i.e. configs/ext4.config or 
> configs/xfs.config...
.....
> 2. Why then add the infrastructure to create a new common
> configs/all-fs.config file during make?
.....

These aren't problems that need to be solved. These are "solutions"
posed as a questions.

Let's look at 1):

> Instead of 1 large config file it's easier if we have FS specific
> sections in their own .config file.  I agree we don't need configs/<fs>
> directories for each filesystem. But it's much easier if we have
> configs/<fs>.config with the necessary sections defined in it.

I disagree with both these "it is easier" assertions.

That same argument was made for splitting up MAINTAINERS in the
kernel tree, which sees far more concurrent changes than a test
config file would in fstests. The "split files are easier to
use/maintain" argument wasn't persuasive there, and I don't really
see that this is any different. We just aren't going to have a lot
of change to common test configs once the initial set is defined
and committed...

> That
> will be easy to maintain by their respective FS maintainers rather than
> maintaining all sections defined in 1 large common config file.

Again, it is no more difficult to add a new section config for a new
btrfs config to a configs/default.config file than it is to add it
to configs/default-btrfs.config.

The config sections are already namespaced by naming convention
(i.e. ["FSTYP"-"config description"]), so the argument that we need
to add a config namespace to an already namespaced config setup
to make it "easier to manage" isn't convincing - it's a subjective
opinion.

I'm saying subjective analysis is insufficient justification for a
change, because the subjective analysis of the situation done by
different people can result in (and often does) completely opposed
stances. Both subjective opinions are as valid as each other, so the
only way to address the situation is to look at the technical merits
of the proposal. The requires all parties to understand the problem
that needs to be solved.

I still don't know what problem is solved by shipping lots of config
files and additional code, build infrastructure and CLI interfaces
to address.  I'm probably still missing something important, but I'm
not going to learn what that might be from subjective opinion
statements like "X will be easier if ...."

> This is a combined configs/all-fs.config file which need not be
> maintained in git version control. It gets generated for our direct
> use. This is also needed to run different cross filesystem tests from a
> single ./check script. i.e. 
> 
>         ./check -s ext4_4k -s xfs_4k -g quick
> 
> (otherwise one cannot run ext4_4k and xfs_4k from a single ./check invocation)

Well, yes, and therein lies the problem with this approach. Where do
custom configs go? Are you proposing that everyone with custom
configs will be forced to run or manage fstests in some new,
different way?

> I don't think this is too much burden for "make" to generate this file.
> And it's easier than, for people to use configs/all-fs.config to run
> cross filesystem tests (as mentioned above).
>
> e.g. 
> 1. "make" will generate configs/all-fs.config
> 2. Define your devices.config in configs/devices.config
> 3. Then run 
>    (. configs/devices.config; ./check -s ext4_4k -s xfs_4k -g quick)

<looks at code providec>

Yup, and now this is all ignored and doesn't work because the test
machine has a custom config setup in <hostname>.config and that
overrides using configs/all-fs.config.

That is not ideal.

Of course, we could add a "configs/local.configs" file for local
configs that get included via the make rule.

However, now we need both a per-machine configs/local.config to be
exist or be distributed at the fstests source code update time (i.e.
before build), as well as also needing an additional static
per-machine configs/devices.config to be defined before fstests is
run.

This is much more convoluted that setting up in
configs/<hostname>.config once at machine setup time and almost
never having to touch it again. The build time requirement also
makes it hard to install packaged fstests (e.g. in a rpm or deb)
because now there's a configure and build step needed after package
installation...

Part of the problem is that you've treated the fstests-provided
section definitions as exclusive w.r.t. local custom config
definitions.  i.e. We can't have both fstest defined sections and
custom sections at the same time.

This restriction essentially forces anyone with a custom config to
have to copy the built config file into their custom config file so
that they can run both fstests provided and custom configs in the
same test run.

That is not ideal.

Maybe this is an oversight, but I still don't know what problem you
are trying to solve and so I can't make any judgement on whether it
is a simple mistake or intended behaviour...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

