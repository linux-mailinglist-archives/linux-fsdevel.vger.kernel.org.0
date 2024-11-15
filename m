Return-Path: <linux-fsdevel+bounces-34862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D49CD513
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 02:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C281F21C84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 01:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC257126C17;
	Fri, 15 Nov 2024 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsA6h/OI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC94E51016;
	Fri, 15 Nov 2024 01:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731634330; cv=none; b=eVlDdAdKpU5O2ePOJiyBA0JkuJ3Pbpy+gowj8t8SdTOkvxG8heqHH/s5g5++8TtrTRV28rZlKU6l1EM7WDlaf+uQRuVLpgNOLzGWm3lsWE5oZ2m375AfU8aWnmzuYNnsxDxYndQWuBca2a8PgLIByFSKDaYoDfgF7iCo5g0Kjc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731634330; c=relaxed/simple;
	bh=wdsKjtTWeXvXCOvgoaR1uz4PjxUsFXXGXkOYX+nuJYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elsx6Gzu+PbiLICdoDbFipJkhQOC3fl5wPtGWtRXqGrD/ynREQjkHExrIPfivldiyF0sQhSy5fq9FGQAwWQB1nGxfwcqnN+t7k24AYMJcVzhttIWJssZ1IqII8c4R8Zt9KU3lvhBizuntcRPAN15n5HVClz0OpUwYH5jfzIPtY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsA6h/OI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3821df9779eso687153f8f.2;
        Thu, 14 Nov 2024 17:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731634327; x=1732239127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBn3oSM5rTTUYeuYRMvyn8fthTqW9ihbYSDk5kFsjnM=;
        b=nsA6h/OIBFsrnyPYY0HkmXvDbFk/XojhODs4fbGek0uqy0jQy/PR74ObQJTjHvOEC4
         zg2OTgOWc7XZ974oqmR7wxPwm8TfduNIivin4rVfZ9tRSh0a+AgRbvNm7Nbm4ie5MVI4
         n/ZXwUUllkENjVJqS3GQkA+c5ExDeyI0cRJ2ce9Jm7qPhoG75W7dlZo3ePi8ctZi5N4u
         +R4O6ZfQHbsZ07p/hAUNB1PFyRXI+yFDC4pdDqrJZKDn9W/bVGG9Bku1BCztczz6RZYt
         +MpNBqv9++ixMV0q7R64zfOMsRgKKi8McD0eA17n9Z0fgXi6k5DjTCYVv715fI368MAK
         eddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731634327; x=1732239127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBn3oSM5rTTUYeuYRMvyn8fthTqW9ihbYSDk5kFsjnM=;
        b=Y8/7ovuonJl2sU+OoNK2BeZkkpnjHdY9vIK7DaEY+t8BOb9wgiBG3RA+pXwpDYhRfp
         BFbqq1IU7soacKLnHldSGD5fTj2c+Hm+9XBFAPLnbeeJg5+t8YYv56KQL+MG1mB6Y1pI
         MNBy/SQz/5+NRkBtXTUQhHFWdEak1pNhSrSOKxpST7ezM5vNbAyZ93y99pZBsedHdJDj
         sIQl9SmG99ajCBXgyMV25usnD6iRsCQXLx7Cmnjn/I/lCkGmfR18qYl4HlIIsgxShdCI
         9vyI1c7AUL1c5Mpss1rKtWG6MXpVyB5YlmFu0EFs6J859LYv6npYkgsZyv9CgU4hvJ67
         O4Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUIhiNGBqmJaF1V1BrSxvLYfLas+8albLtuWmSIeF6lEhVOPtQPl71Nx9HzSdmbZ0lMm4MSrCv9aNDExgU1Vg==@vger.kernel.org, AJvYcCUiMq6IJCTfJxFAzlotOugOV+pjDQGt4jI7SRv3lIBB6EMKuy18Z+4LqGYFHw04qWgPKCE=@vger.kernel.org, AJvYcCVwN9XfOh/uYrPFuuNGMETa69vPXVWdDDR9Ic5M8SGpiMcB9uw9wuCqb92a4i/tHIeli3Mz/JMVLSFIj1lNsK475WN6HIMp@vger.kernel.org, AJvYcCWl/CrDQ926egqN1CPumgDxE7Ald26yPz54N0rbupgMQhrE50K682VMak7Ozj1jXoJYQC3COBo9cVSgkFzu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7opTO451knar/VL12ETaSRianjuSlpEs49eQOifplxVmqUY9B
	lGZZBgH+6njtSDcuc/5jFuN07rrPRtg0dHktFUU0Rc2CyqSaZznqz5qX+dHUSHlGfE0shtvzHxJ
	X6l/tUnpFFiIE7pugAotdAmUv8Es=
X-Google-Smtp-Source: AGHT+IF96OxAtCHTV08AwKfipK9orJDO17SG25K7KV56bw4X4sclzdeWuyQdg1RUiJXt7kGS5+UC+4UShZvrKSi/jmQ=
X-Received: by 2002:a05:6000:a11:b0:381:d88b:272e with SMTP id
 ffacd0b85a97d-38225a68e7bmr638776f8f.18.1731634326860; Thu, 14 Nov 2024
 17:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114084345.1564165-1-song@kernel.org> <20241114084345.1564165-8-song@kernel.org>
 <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com>
 <E5457BFD-F7B9-4077-9EAC-168DA5C271E4@fb.com> <CAADnVQJ1um9u4cBpAEw83CS8xZJN=iP8WXdG0Ops5oTP-_NDFg@mail.gmail.com>
 <DCE25AB7-E337-4E11-9D57-2880F822BF33@fb.com>
In-Reply-To: <DCE25AB7-E337-4E11-9D57-2880F822BF33@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Nov 2024 17:31:55 -0800
Message-ID: <CAADnVQ+bRO+UakzouzR5OfmvJAcyOs7VqCJKiLsjnfW1xkPZOg@mail.gmail.com>
Subject: Re: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for
 BPF based fanotify fastpath handler
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, 
	"repnop@google.com" <repnop@google.com>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 5:10=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
>
>
>
> > On Nov 14, 2024, at 4:41=E2=80=AFPM, Alexei Starovoitov <alexei.starovo=
itov@gmail.com> wrote:
> >
> > On Thu, Nov 14, 2024 at 3:02=E2=80=AFPM Song Liu <songliubraving@meta.c=
om> wrote:
> >>
> >>
> >>
> >>> On Nov 14, 2024, at 12:14=E2=80=AFPM, Alexei Starovoitov <alexei.star=
ovoitov@gmail.com> wrote:
> >>>
> >>> On Thu, Nov 14, 2024 at 12:44=E2=80=AFAM Song Liu <song@kernel.org> w=
rote:
> >>>>
> >>>> +
> >>>> +       if (bpf_is_subdir(dentry, v->dentry))
> >>>> +               ret =3D FAN_FP_RET_SEND_TO_USERSPACE;
> >>>> +       else
> >>>> +               ret =3D FAN_FP_RET_SKIP_EVENT;
> >>>
> >>> It seems to me that all these patches and feature additions
> >>> to fanotify, new kfuncs, etc are done just to do the above
> >>> filtering by subdir ?
> >>>
> >>> If so, just hard code this logic as an extra flag to fanotify ?
> >>> So it can filter all events by subdir.
> >>> bpf programmability makes sense when it needs to express
> >>> user space policy. Here it's just a filter by subdir.
> >>> bpf hammer doesn't look like the right tool for this use case.
> >>
> >> Current version is indeed tailored towards the subtree
> >> monitoring use case. This is mostly because feedback on v1
> >> mostly focused on this use case. V1 itself actually had some
> >> other use cases.
> >
> > like?
>
> samples/fanotify in v1 shows pattern that matches file prefix
> (no BPF). selftests/bpf in v1 shows a pattern where we
> propagate a flag in inode local storage from parent directory
> to newly created children directory.
>
> >
> >> In practice, fanotify fastpath can benefit from bpf
> >> programmability. For example, with bpf programmability, we
> >> can combine fanotify and BPF LSM in some security use cases.
> >> If some security rules only applies to a few files, a
> >> directory, or a subtree, we can use fanotify to only monitor
> >> these files. LSM hooks, such as security_file_open(), are
> >> always global. The overhead is higher if we are only
> >> interested in a few files.
> >>
> >> Does this make sense?
> >
> > Not yet.
> > This fanotify bpf filtering only reduces the number of events
> > sent to user space.
> > How is it supposed to interact with bpf-lsm?
>
> Ah, I didn't explain this part. fanotify+bpf fastpath can
> do more reducing number of events sent to user space. It can
> also be used in tracing use cases. For example, we can
> implement a filetop tool that only monitors a specific
> directory, a specific device, or a specific mount point.
> It can also reject some file access (fanotify permission
> mode). I should have showed these features in a sample
> and/or selftest.

I bet bpf tracing can filetop already.
Not as efficient, but tracing isn't going to be running 24/7.

>
> > Say, security policy applies to /usr/bin/*
> > so lsm suppose to act on all files and subdirs in there.
> > How fanotify helps ?
>
> LSM hooks are always global. It is up to the BPF program
> to filter out irrelevant events. This filtering is
> sometimes expensive (match d_patch) and inaccurate
> (maintain a map of target inodes, etc.). OTOH, fanotify
> has built-in filtering before the BPF program triggers.
> When multiple BPF programs are monitoring open() for
> different subdirectories, fanotify based solution will
> not trigger all these BPF programs for all the open()
> in the system.
>
> Does this answer the questions?

No. Above is too much hand waving.

I think bpf-lsm hook fires before fanotify, so bpf-lsm prog
implementing some security policy has to decide right
at the moment what to do with, say, security_file_open().
fanotify with or without bpf fastpath is too late.

In general fanotify is not for security. It's notifying
user space of events that already happened, so I don't see
how these two can be combined.

