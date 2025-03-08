Return-Path: <linux-fsdevel+bounces-43508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24279A57845
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 05:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C26C174C8C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 04:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74198166F0C;
	Sat,  8 Mar 2025 04:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0sx3WHZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6494CBE65;
	Sat,  8 Mar 2025 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741407529; cv=none; b=OVkdhSsWcOkjobgliIOnZvqOAU0rUkyrtib2OSMiRsSqsCn8roJQ7r2FkI2JFILHpDTLyhkS91lD+f6EGhk1Z0mbUNKr0zfychio/v6KHU5iACmKafaDX+VokvmTIlx1oBRXsvjjmyUkixbzniefIZL4+Ga3rbZIVyV6kUeaqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741407529; c=relaxed/simple;
	bh=fq/vmxK7kUnvxdQgJy3AKbjll80ZSovmctzyNl4dL+g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=osG6sdLD52F0lpSbUHEPZBrSdwKVyDe6x9gc02wKuc8DMhhg4wTCX+p3P+i/05+jzV18MjH8B39PBWFCp0bWl9shhNFUwRiDuy1cidPoPCoK1Tdv8wA53ey5j3ZaSTc9I/KMMYxef1Sy/e3fE2pKX9JIJMNRTiujkt6jbjDMH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0sx3WHZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22548a28d0cso4939915ad.3;
        Fri, 07 Mar 2025 20:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741407527; x=1742012327; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ons/p7cr5+Fjz5AVE1klUNKI3fX4+WAHRYBCxq6uPE8=;
        b=X0sx3WHZ1JmBW1nmIdqWNutQQMfZpyJdntAktQh95q8ZG52/7XodYabgczzO2K3Dsg
         qArfLPACha5eXdkulJNihrS7YdhPGdbcCdDuFChXxB0X07KUh6j6X7uURrx2zoaF7wdh
         wmzZI+sAkobxSDGqpZ03/BQe7nRkKN6y3UhrnCIfMntYFQx/BjJ0hdODAWKssQEgGNHD
         UbJpJXUfF90FE3IHtFhXxPTl+KQ/+H7AY/Fey8bYkJFK7HipyxtqEdQgPq6pgItH7BnN
         hJpzOHKCQBGKg6KQGjRoU+5wK1Y8HJMEeEfAJQCnIR36hP+KCFFktcuJK5mei7ndFwc4
         yf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741407527; x=1742012327;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ons/p7cr5+Fjz5AVE1klUNKI3fX4+WAHRYBCxq6uPE8=;
        b=hCJLV/0OSQNoTJDfNQa1uVZD9nFBv19sNSziEDwiVvd+NfsDvRx9OaIbHv6Veyc+Dr
         W3VZjNhCcItdpS0Ri4aF4YqZTh0qrHnCJVVUD1KCn9Ca9KQCj5Evf/58r4jvc0t2uA41
         HQ1UXSq1HFDIJlpTwb1qIBrEztldXVwJPFeuAvtvTa4UoT5GrfINHh/MduXA/TmC9JE2
         vV4PHwDSWOZdRI+lAeXNAqAjjqIhz2QwtfKyQgoJSTYvvQGkbYbQCKYfk+vBpG4iYA+/
         LQsis/hud4K+5Jq+CjNAdaQ1wXKQEFJjP5Mm4zUk8PqRxpv1bStDdUHl41cpFiozma5V
         BqbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOZG6kAbz5QKi2mwxThFwSTaisyIJ294mqd9GSSiRN4cExMbI32UuoI7AeMGfUdKOg2JK35M8O9+Hl@vger.kernel.org, AJvYcCURc/C0VFsGskYLaLMtoJSbE+XqMVe492fQaVaxpMqTUi9u25de8MdcBTusqDKBvJ96nGigOHhNDWqlr+EhsQ==@vger.kernel.org, AJvYcCWXiwAKKV2Zwh76b5+Mb2qIQdIjjc8XrLth/F34L01HlK2NQaacCJAkSI6KsAh45rI8rDVNNZnX2jQR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7I9o3HbeFUB5VgH0Dd8uw6G3dciHUGNs/eu5QYuFY5APIZ46x
	hGUk7nBipPnbS9CzPdZnJFCuv7HZTtXTScZXdHMt08ZeSqRURE/XmeIOwA==
X-Gm-Gg: ASbGncvtt0pfHqIsqhEhNks8fRNBy7RRr5pYpZ3Q0caiJ5Bx7yM8ydxQm1KJgB5HHPC
	lhNItkerUWx2/fWxlL0fcHjgz41jZZ6l9Go3gOK4oWyCkZFM0bsoNPVI4EJkPyi9utF+Jv1K9lP
	dqChFD26eCm/r1zowUUebM7UUKbpNdplt/T5t7plNhdnHuMFld7ijLI1KCY3CmcIrBuvL5fNI8g
	ujMyYkS9JEuNEQkyAU/LWizQDC6xrUdxILSSrjgDC+TFDY+l9e5gVyec0S0nDeFVze0seQdm5sh
	PjQFnj77j4AmHtOmafMCg7sr3hhfwgu5ZQs=
X-Google-Smtp-Source: AGHT+IEdJIqwmSpruBoATua7U3ivFNKNt4+b0GZ++qJabm1+78Az6Fe4tNaw+rvp2q77VAN3MXGXNA==
X-Received: by 2002:a17:902:ea07:b0:21d:dfae:300c with SMTP id d9443c01a7336-22428880270mr88782495ad.3.1741407527510;
        Fri, 07 Mar 2025 20:18:47 -0800 (PST)
Received: from dw-tp ([171.76.82.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddfc7sm38606285ad.22.2025.03.07.20.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 20:18:46 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com, jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org, nirjhar.roy.lists@gmail.com, zlang@kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] xfstests: Centralizing filesystem configs and device configs
In-Reply-To: <20250306182217.GB2803730@frogsfrogsfrogs>
Date: Sat, 08 Mar 2025 09:35:59 +0530
Message-ID: <8734fo6uag.fsf@gmail.com>
References: <Z55RXUKB5O5l8QjM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <20250306182217.GB2803730@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

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
>> 
>> ** Proposal ** 
>> We would like to propose a discussion at LSFMM on two key features: central
>> fsconfig and central device-config within xfstests. We can explore how the
>> fsconfig feature can be utilized, and by then, we aim to have a PoC for central
>> device-config feature, which we think can also be discussed in more detail. At
>> this point, we are hoping to get a PoC working with loop devices by default. It
>> will be good to hear from other developers, maintainers, and testers about their
>> thoughts and suggestions on these two features.
>> 
>> Additionally, we would like to thank Ted for listing several features he uses in
>> his custom kvm-xfstests and gce-xfstests [3]. If there is an interest in further
>> reducing the burden of maintaining custom test scripts and wrappers around
>> xfstests, we can also discuss essential features that could be integrated
>> directly into xfstests, whether from Ted's list or suggestions from others.
>> 
>> Thoughts and suggestions are welcome.
>
> Considering all the questions downthread, I'm wondering, are you just
> going to stuff all the known configs into a single configs/default file
> and then modify known_hosts() to set HOST_OPTIONS to that?

In the last approach that's what we were doing. However since check
script only consider 1 exclusive config file for looking into into the
device settings and sections, that forces the users to pass device
settings separately. Not an elegant solution.

>
> 	[ -f /etc/xfsqa.config ]             && export HOST_OPTIONS=/etc/xfsqa.config
> 	[ -f $HOST_CONFIG_DIR/default ]      && export HOST_OPTIONS=$HOST_CONFIG_DIR/default
> 	[ -f $HOST_CONFIG_DIR/$HOST ]        && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST
> 	[ -f $HOST_CONFIG_DIR/$HOST.config ] && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST.config
>
> Then configs/default contains things like:
>
> [xfs_nocrc]
> MKFS_OPTIONS="-m crc=0"
>
> Would that work for running configurations in this manner:
>
> 	./check -s xfs_nocrc -g all
>
> ?

I am discussing another approach in my last response to Dave. i.e. Let's
maybe define 1 config file for all fs sections e.g. configs/all-fs.config. 
We then need to modify the check script to continue allowing the use of the
HOST_OPTIONS provided config file while also supporting an additional
config file passed via the -c option via cmdline.

That way users can continue to use their local.config file as is but can
also find additional sections to test if they pass 
-c configs/all-fs.config file.

i.e. 

     ./check -c configs/all-fs.config -s xfs_nocrc -g all

where all-fs.config would have defined the [xfs_nocrc] section.

>
> (I am completely ignorant of config files and never use them.)
>

So you have your custom local.config file defined somewhere which you
always use for testing? What's your setup like in terms of different fs
& device configurations to test?
(both your local setup for fstests testing and ci setup which you use)

> --D
>

Thanks Darrick for looking into this :)

-ritesh

>> 
>> ** References **
>> [1] https://lore.kernel.org/all/87h6h4sopf.fsf@doe.com/
>> [2] https://lore.kernel.org/all/9a6764237b900f40e563d8dee2853f1430245b74.1736496620.git.nirjhar.roy.lists@gmail.com/
>> [3] https://lore.kernel.org/all/20250110163859.GB1514771@mit.edu/
>> [4] https://lore.kernel.org/all/20241127045403.3665299-1-david@fromorbit.com/
>> 

