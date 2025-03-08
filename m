Return-Path: <linux-fsdevel+bounces-43506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A9BA57839
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 05:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6465172353
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 04:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75E176242;
	Sat,  8 Mar 2025 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmJ4/ay1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E1717A2E1;
	Sat,  8 Mar 2025 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741406744; cv=none; b=VLFl+Ft0OsLbj559ISRlJjFwZ9z0dP+hksM1Nl0eljoIVgAK/BK4gjAhdQaME3H1L9IoDwUbJPdpRODmsFxurngTVuF4lKFqBpnIxNSB1SgxIDsnEfYZ7gXCIQ1Xne1zQ8oKPP5kUfYTItmN+EplSSRbG2YiZYe5AnNrDRAOmPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741406744; c=relaxed/simple;
	bh=HYefr4k5XyU7cfDSknDMDx3HKGQ8ox7nvqUGfndUsxY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=qPdKZziOGNMVcJhrlrbl8btE+UO25sQ90Spgw8MHioMQClshk9fnqcZs7IvjcltbKpv91mVoKZcIh+UoqMDQj9P76jq5yZwex6yxIYAKwhCLLwdl7B9zs9/D20jJZ1Mwu/BwJDnycg5PxPgOJvc8vUWj0St5Ut16iE0gFCjd36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmJ4/ay1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22355618fd9so48496775ad.3;
        Fri, 07 Mar 2025 20:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741406741; x=1742011541; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fWV+sekDRGDYiyLZsHUM3yuR7GPqEHNFn7Xp+X+661Y=;
        b=GmJ4/ay10eKtjPoqGCUOdxIqrnPnCAPbZZVL2w8mUONd9pbskqmT3Uaf64svGMRYcI
         vnPpoFiQ+Chwn3JB8aJPx/SAEioAaceaaWiT0lGmQBcedKxbXIWNO6qjNUHQP6TLoK51
         BhTtbOfm3y9iftvmwjGi3Xw+H5n7OaCHPjlabAKxaAf9kmeA30Xd8zOKQ8zPj9e3rIX9
         GYsvg0RxztlTqoUIagrbdJsN17poviezB8qhTn7LbHMOiQEzSFIhGE1jfM8QdRvhiQRo
         +DTCPLY4XcKDPuliQ1lBZ1tt1hu/nqH1iUYLqgbgxxS1X5DutAh600x8e2AJjJzA+89Y
         aAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741406741; x=1742011541;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWV+sekDRGDYiyLZsHUM3yuR7GPqEHNFn7Xp+X+661Y=;
        b=qErTAGGYNnXacMYQqdhLt1KJvKEkOl2PyxiYdGcWUsMdLnW4MbI793EIhn1mjbEFqi
         OuMLy81/9yLlkM4JHt2rJQp6iN2ICHj3BZ2KnbXpGCuXWR8ZY7pY5uaWRO/yYjL1AYmY
         bstvnLAPPZ4IOjj/2d2L/lB0Hf76TXUxipeG5Xf1Ome/Mq+AI9K0Bxjj2XIAPT7uBGM7
         OGyasJ+qK4W7XeQjc8Z9LOwFHM+cTsJhqXeFk8i8GRQqIJfomRfxyR649NFIY2P+AWhe
         KZFynDrIu7mE1hhqBIbDubogWK9Ak2SulQV8YdMy8HmVQVuusHi+kB+KFIKaNdK7KmgV
         ZWsw==
X-Forwarded-Encrypted: i=1; AJvYcCU9uynBcEHygxLMH4ShfKZMW1RGbsWuyJJokIxPqZGB22L1+GeE+1O8lDH/bDfEdkQGUQhrY9n4StXr@vger.kernel.org, AJvYcCXGCwo8ez/SfKxIrKhS5D4pL+4ZUzBfsTsxzZXBgk98RU81WrVUA/+CSgYRRXlpG62c6b42y4RrHhs6@vger.kernel.org, AJvYcCXNozAY/PgTrQkK/qGIo/wqwlAUQnyorbuJPAhwx/dArSdbKIsvZdBcbL5jmGxSKF3f7gGxni89NvoVG+NEUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQEtmhr6iaAuTMNr3kbfJowDBC0W2G94uh3tiCsRZRsJVJdpnL
	uoE0kb8iWyvB2vt1XFR6PEsf39jBqEgTnD0smTt/HGqxmOyCA9ZB
X-Gm-Gg: ASbGncsAq5P73Ze/8X5pBFwrXwObkpH0RPEqhl29v7Bp9V7C5OetYqXaOmvlaQJg7hm
	ghkd50nTNN5NMQ5XTPyuQVrF0Pd7CCmNDImmLPTvFm7BE81AEqv2n3/akXGeYavp9iPeVLALcz6
	8BBqD3NHNogAX1dLbtz7ldFa3UaPdhZS4StsBBY2GjHCwV4p9gA2LMFc0jKjJaSnRTqhY+JoO54
	I5ttPmHnLw1EmtJFjLlBAiJNE/QRnFAAycKE3sb8Lx2scgBhR/aZI4GLhR+hdJ/jjmRhWNWv8x1
	agLZrf+fdmQIlC57mjSXPPs1AusWgNqnbp0=
X-Google-Smtp-Source: AGHT+IHDmo3EFmu+rj7Fot7nL/Ky7sPpZnwpBkSsG6pm6IZPSspvMCOhzIbp+6ya1exoac+Kzc0Alg==
X-Received: by 2002:a17:903:283:b0:224:2201:84da with SMTP id d9443c01a7336-2242887ffa8mr84818645ad.6.1741406740920;
        Fri, 07 Mar 2025 20:05:40 -0800 (PST)
Received: from dw-tp ([171.76.82.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109eb4b0sm38517425ad.88.2025.03.07.20.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 20:05:40 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, djwong@kernel.org, dchinner@redhat.com, jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org, nirjhar.roy.lists@gmail.com, zlang@kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] xfstests: Centralizing filesystem configs and device configs
In-Reply-To: <Z8jcJaUvNfPy_B1V@dread.disaster.area>
Date: Sat, 08 Mar 2025 08:56:57 +0530
Message-ID: <874j046w3i.fsf@gmail.com>
References: <Z55RXUKB5O5l8QjM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <Z6FFlxFEPfJT0h_P@dread.disaster.area> <87ed0erxl3.fsf@gmail.com> <Z6KRJ3lcKZGJE9sX@dread.disaster.area> <87plj0hp7e.fsf@gmail.com> <Z8d0Y0yvlgngKsgo@dread.disaster.area> <87frjs6t23.fsf@gmail.com> <Z8jcJaUvNfPy_B1V@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> On Wed, Mar 05, 2025 at 09:13:32AM +0530, Ritesh Harjani wrote:
>> Dave Chinner <david@fromorbit.com> writes:
>> 
>> > On Sat, Mar 01, 2025 at 06:39:57PM +0530, Ritesh Harjani wrote:
>> >> > Why is having hundreds of tiny single-config-only files
>> >> > better than having all the configs in a single file that is
>> >> > easily browsed and searched?
>> >> >
>> >> > Honestly, I really don't see any advantage to re-implementing config
>> >> > sections as a "file per config" object farm. Yes, you can store
>> >> > information that way, but that doesn't make it an improvement over a
>> >> > single file...
>> >> >
>> >> > All that is needed is for the upstream repository to maintain a
>> >> > config file with all the config sections defined that people need.
>> >> > We don't need any new infrastructure to implement a "centralised
>> >> > configs" feature - all we need is an agreement that upstream will
>> >> > ship an update-to-date default config file instead of the ancient,
>> >> > stale example.config/localhost.config files....
>
> .....
>
>> > You haven't explained why we need new infrastructure to do something
>> > we can already do with the existing infrastructure. What problem are
>> > you trying to solve that the current infrastructure does not handle?
>> >
>> > i.e. we won't need to change the global config file very often once the
>> > common configs are defined in it; it'll only get modified when
>> > filesystems add new features that need specific mkfs or mount option
>> > support to be added, and that's fairly rare.
>> >
>> > Hence I still don't understand what new problem multiple config files
>> > and new infrastructure to support them is supposed to solve...
>> 
>> 
>> I will try and explain our reasoning here: 
>> 
>> 1. Why have per-fs config file i.e. configs/ext4.config or 
>> configs/xfs.config...
> .....
>> 2. Why then add the infrastructure to create a new common
>> configs/all-fs.config file during make?
> .....
>
> These aren't problems that need to be solved. These are "solutions"
> posed as a questions.
>
> Let's look at 1):
>
>> Instead of 1 large config file it's easier if we have FS specific
>> sections in their own .config file.  I agree we don't need configs/<fs>
>> directories for each filesystem. But it's much easier if we have
>> configs/<fs>.config with the necessary sections defined in it.
>
> I disagree with both these "it is easier" assertions.
>
> That same argument was made for splitting up MAINTAINERS in the
> kernel tree, which sees far more concurrent changes than a test
> config file would in fstests. The "split files are easier to
> use/maintain" argument wasn't persuasive there, and I don't really
> see that this is any different. We just aren't going to have a lot
> of change to common test configs once the initial set is defined
> and committed...
>

Ok. 1 central config file for all fs sections then.
Not really fond of the idea, but I see your point. Since there isn't
going to be much of the modifications to this, maybe 1 file should do.

>> That
>> will be easy to maintain by their respective FS maintainers rather than
>> maintaining all sections defined in 1 large common config file.
>
> Again, it is no more difficult to add a new section config for a new
> btrfs config to a configs/default.config file than it is to add it
> to configs/default-btrfs.config.
>
> The config sections are already namespaced by naming convention
> (i.e. ["FSTYP"-"config description"]), so the argument that we need
> to add a config namespace to an already namespaced config setup
> to make it "easier to manage" isn't convincing - it's a subjective
> opinion.
>
> I'm saying subjective analysis is insufficient justification for a
> change, because the subjective analysis of the situation done by
> different people can result in (and often does) completely opposed
> stances. Both subjective opinions are as valid as each other, so the
> only way to address the situation is to look at the technical merits
> of the proposal. The requires all parties to understand the problem
> that needs to be solved.
>
> I still don't know what problem is solved by shipping lots of config
> files and additional code, build infrastructure and CLI interfaces
> to address.  I'm probably still missing something important, but I'm
> not going to learn what that might be from subjective opinion
> statements like "X will be easier if ...."
>
>> This is a combined configs/all-fs.config file which need not be
>> maintained in git version control. It gets generated for our direct
>> use. This is also needed to run different cross filesystem tests from a
>> single ./check script. i.e. 
>> 
>>         ./check -s ext4_4k -s xfs_4k -g quick
>> 
>> (otherwise one cannot run ext4_4k and xfs_4k from a single ./check invocation)
>
> Well, yes, and therein lies the problem with this approach. Where do
> custom configs go? Are you proposing that everyone with custom
> configs will be forced to run or manage fstests in some new,
> different way?
>
>> I don't think this is too much burden for "make" to generate this file.
>> And it's easier than, for people to use configs/all-fs.config to run
>> cross filesystem tests (as mentioned above).
>>
>> e.g. 
>> 1. "make" will generate configs/all-fs.config
>> 2. Define your devices.config in configs/devices.config
>> 3. Then run 
>>    (. configs/devices.config; ./check -s ext4_4k -s xfs_4k -g quick)
>
> <looks at code providec>
>
> Yup, and now this is all ignored and doesn't work because the test
> machine has a custom config setup in <hostname>.config and that
> overrides using configs/all-fs.config.
>
> That is not ideal.

That was intentionally put to not break any of the existing users custom
config setup.

>
> Of course, we could add a "configs/local.configs" file for local
> configs that get included via the make rule.
>
> However, now we need both a per-machine configs/local.config to be
> exist or be distributed at the fstests source code update time (i.e.
> before build), as well as also needing an additional static
> per-machine configs/devices.config to be defined before fstests is
> run.
>
> This is much more convoluted that setting up in
> configs/<hostname>.config once at machine setup time and almost
> never having to touch it again. The build time requirement also
> makes it hard to install packaged fstests (e.g. in a rpm or deb)
> because now there's a configure and build step needed after package
> installation...
>
> Part of the problem is that you've treated the fstests-provided
> section definitions as exclusive w.r.t. local custom config
> definitions.  i.e. We can't have both fstest defined sections and
> custom sections at the same time.
>
> This restriction essentially forces anyone with a custom config to
> have to copy the built config file into their custom config file so
> that they can run both fstests provided and custom configs in the
> same test run.
>

The current solution faces this problem because we were using
HOST_OPTIONS method to define the config file. That in fstests forces to
use only 1 config file which can be either local.config or <host>.config
or use configs/all-fs.config.

So the problem then is where do the users define their device settings. 

> That is not ideal.
>

Yes, I see the problem. Could you please suggest a better alternative
then?

One approach which I am thinking is to provide a custom -c option to
pass the section config file. That might require some changes in check
script. But the idea is that fstests will use more than 1 defined config
file i.e. it  will first look into it's HOST_OPTIONS provided config
file and also take into account -c <all-fs.config-file>, if passed from
cmdline, to find the additional section definitions. i.e. 

./check -c <all-fs.config-file-path> -s ext4_4k -s xfs_4k -g quick

I guess that will allow the users to use local.config or host.config as
is to define their device settings and also be able to use -c config
file for testing any additional sections.

Thoughts? 

-ritesh


> Maybe this is an oversight, but I still don't know what problem you
> are trying to solve and so I can't make any judgement on whether it
> is a simple mistake or intended behaviour...
>
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

