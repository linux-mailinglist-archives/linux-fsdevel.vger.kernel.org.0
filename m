Return-Path: <linux-fsdevel+bounces-43744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A691A5D31E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 00:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31251780D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 23:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126591D6DBB;
	Tue, 11 Mar 2025 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRd28xlM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD71EF087;
	Tue, 11 Mar 2025 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735423; cv=none; b=CfdjuenIL3yk4b/cWu7Yc/vrMVc6tdmG1LcAHDuCLA4cJc3kGm+aSjBoSVCoMJ523lENb2wVGEbHwdCr3gZgZZyLQz1pstUy9sYKSo8w1J60FSN1obos5hVvmi9BeqaV26wPyN95HVOOQQjtmIN0QKKH3F6bivyEkwakJiGwyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735423; c=relaxed/simple;
	bh=1c4nORsM3kHkHPY3YDwsODM3vgceCesqpOnjPI4HjSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlaYVdDi7DSeeUqmRNfgaZeiFnOLVIN5UfXjdvijqKrt9fAugF0KQYFtaR12hgQlUOM/e0J8nmecHJaAT9jXdWZ8c191j+hSt78TGTjdY6mH28a6XVFHdDP5xVF4sZafar9kYsYmoX//NWUWbt432lweziirri2gVo//97VJZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRd28xlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EABC4CEEF;
	Tue, 11 Mar 2025 23:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741735422;
	bh=1c4nORsM3kHkHPY3YDwsODM3vgceCesqpOnjPI4HjSY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RRd28xlM/3XWqa5EKMacWeDb6zTqIKJvWIe7lwk3F+gwNV3StpKVAguGWCmT+/s7P
	 Z4t5YHLSk4jR3VcsKAiRLxAPHZ/9DTIGQF9QJYsYUzgXXD2vxcpNyHzL9edhhuzrj7
	 fr/pQ1eq0oFZBRFehpvB2k1/96K7QoHypROryHvGPOpiHY41SrxEwY3Gpjf9Nc4uBw
	 TSIRoF7YWEjm4tmQWkZy5gTdG1pItA59FaCqstUg/rZ+YTouxTOX83p8+oRK9KsSHY
	 pwilBoBe7UL1bAt5GrVBznUcwrTig01MExqF/wru2yi3oqJzbMTiYBYK6RlAoaI1O6
	 XVPH7TDA0gxxA==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d439f01698so1282715ab.1;
        Tue, 11 Mar 2025 16:23:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOhRFNG7lnj71z1v4Aa/6SZN89BINS1p8UkNRq3OVsSKfv13UugdhQqs1ni8mHmAqHozabJV7I0zv1JYC0@vger.kernel.org, AJvYcCWU0mR3RitwYjOVPvpIjWmSo7APJrf4jvVblhwHB1IWj12sBYur/lmOL/YGziAj+3h+WcNV7XuCuoiEXN4QmEZfFqlsL34t@vger.kernel.org
X-Gm-Message-State: AOJu0YwskhIUMFW0FVBvcT44b58baU1R1BpKOUBOJPaAtlXpA4YVmyMf
	jeIRPuxXtoMvsjk//PaxDp54nx6lrWXJtqahFfRX4JTign/K+4zpWMBb+2meYsPl7pI8faKTiHt
	jQy5Rxu/4iQKnRhUkcdq2+nTJf/c=
X-Google-Smtp-Source: AGHT+IE2KY686o1GqGq2o0w9GqRc5dcso+bwdKxvv7E3OPoQZojU8H8Kb+hWWrp5C2i0/sqayJbZU6KTxpQCNQvoiI4=
X-Received: by 2002:a05:6e02:2207:b0:3d3:f15e:8e23 with SMTP id
 e9e14a558f8ab-3d4691b938cmr65752745ab.10.1741735422249; Tue, 11 Mar 2025
 16:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741047969.git.m@maowtm.org> <20250304.Choo7foe2eoj@digikod.net>
 <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org> <CAOQ4uxjz4tGmW3DH3ecBvXEnacQexgM86giXKqoHFGzwzT33bA@mail.gmail.com>
 <1e009b28-1e6b-4b8c-9934-b768cde63c2b@maowtm.org> <20250311.Ti7bi9ahshuu@digikod.net>
 <CAPhsuW4YXGFY___8x7my4tUbgyp5N4FHSQpJpKgEDK6r0vphAA@mail.gmail.com> <c6e67ee5-9f85-44f4-a27c-97e10942ff57@maowtm.org>
In-Reply-To: <c6e67ee5-9f85-44f4-a27c-97e10942ff57@maowtm.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Mar 2025 16:23:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5XNE67LoRjX335iFwCSnZ_QLYCwMxbZtj_cSn=0xMy6Q@mail.gmail.com>
X-Gm-Features: AQ5f1Jp_HbBeztuuPTCMHnqFDUncNRHhbQysJhpo1jC6a0hrlpxzjXUpqnT-soQ
Message-ID: <CAPhsuW5XNE67LoRjX335iFwCSnZ_QLYCwMxbZtj_cSn=0xMy6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
To: Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Jan Kara <jack@suse.cz>, 
	linux-security-module@vger.kernel.org, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>, 
	Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Paul Moore <paul@paul-moore.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 3:03=E2=80=AFPM Tingmao Wang <m@maowtm.org> wrote:
[...]
> >
> > I think there is a fundamental difference between LSM hooks and fsnotif=
y,
> > so putting fsnotify behind some LSM hooks might be weird. Specifically,
> > LSM hooks are always global. If a LSM attaches to a hook, say
> > security_file_open, it will see all the file open calls in the system. =
On the
> > other hand, each fsnotify rule only applies to a group, so that one fan=
otify
> > handler doesn't touch files watched by another fanotify handler. Given =
this
> > difference, I am not sure how fsnotify LSM hooks should look like.
> >
> > Does this make sense?
>
> To clarify, I wasn't suggesting that we put one hook _behind_ another
> ("behind" in the sense of one calling the other), just that the place
> that calls the new fsnotify_name_perm/fsnotify_rename_perm hook (in
> Amir's WIP branch) could also be made to call some new LSM hooks in
> addition to fsnotify (i.e. security_pathname_create/delete/rename).
>
> My understanding of the current code is that VFS calls security_... and
> fsnotify_... unconditionally, and the fsnotify_... functions figure out
> who needs to be notified.

Yes, VFS calls security_* and fsnotify_* unconditionally. In this sense,
fsnotify can be implemented as a LSM. But fsnotify also supports some
non-security use cases. So it will be weird to implement it as a LSM.

Thanks,
Song

[...]

