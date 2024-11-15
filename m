Return-Path: <linux-fsdevel+bounces-34858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E82D9CD4B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 01:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CCF1F2288D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 00:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B441AAC;
	Fri, 15 Nov 2024 00:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp8OcZDJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD01096F;
	Fri, 15 Nov 2024 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731631308; cv=none; b=W0+4661+UtOem0DQXkxC2Yg9MK8TQlVTlTw7k0sqludLaiHzMbpX4+xqaY22yZVpRF5rzHE9zq7ooQQjST2Wgprd/tweMRrZjzxZ9vXBZTq76X2kqzl2/mfQmalHmuJoGGtj7rH4OaCDuaEwdpEC5QvlacmnrdPydrkjaEr56NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731631308; c=relaxed/simple;
	bh=0eGjTFcYgGoj8hPrqRlT0CDvGF5RbC0bBVnopIte/c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szCmJlNVYzCoc8s0b+SWF5MPKdnuX7vDL38ZSUTNAHnBTf4vB8/a37oM5IQkl0EMSfrFW/7sKODi/jF82328pKMFqd4rUcIvz6WdBKHn6fvGgsT43mU9FOWO6TUu0+8NWseHHf5G37w2K87RTZgK6TwfGRSeL3el/dXKCk5b8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp8OcZDJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38222245a86so489712f8f.1;
        Thu, 14 Nov 2024 16:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731631305; x=1732236105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ch4TFbpDEuiX+VexPStq204AKlKumcG/xHw5pvpktQ=;
        b=hp8OcZDJfWv9Jsm9SsTvcrCJsXQS5uTWFIxznqOON6/0wRYGM+DMV+/fU45yCPOPz2
         gxZJqYpC+6UyN9lF+Cok1aCL0r7BSp7elFjagEVFR9xiozFmGyt1ij71vxDSk1IDMm7F
         EHlQLcv8/oZcnhTG+JC1LupQYNgOGDdyfMlLGhHxC2vWQ5TxolqXCgk3LinIWDQ73BMO
         yl4DNkBitCpDcshuFbouAT5Tnv1fuGBzul2YOb4qSfblNb736iZLeKpnF+30t2IUji4H
         7TovwiOP6qkgXCbHxGqX/AKql9DJzzOGp3qXTrCsF3/R9S13b20JObYZCyVcF4+ZHaVm
         Islw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731631305; x=1732236105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ch4TFbpDEuiX+VexPStq204AKlKumcG/xHw5pvpktQ=;
        b=FDBVsCU3Uk3u4BA1pIAQHuJTP0BpFwKnHrR/TkKiB3hEOYlaBt6ZIjgH5uFACI9rPq
         GhgENRqFvp0oDZ9J01JqctVl0kFBNUKuCOk5p8srkqe2y2sOH940qgJRojdjnTziqttv
         uU6J1mJFXiKjEvlQxHjjzQsHuzxiIgOPtQmidwTdFhnH/QZFpdefgPlBSlUiOLCZWLUV
         sncIt9a4NtGH+MmBMZz3DrnideOsZ/9uO0Z2xnmCdPrmipRDJXzdwQ8+X+A/90TdSg6+
         9gxowN2JDohUJWZIGrfLvrl1aAy8f66H+J9zRM+N64/afQ3aF3UcgISi4YY+mq3V8K2P
         emQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU49ZppMSycDFZwUH6aFkjpyJCjIosEoChq5tXnIS0Vw+qWofB9iOs6HFIG7nsk51+OFeIJ1hcsEXbSYIylmQ==@vger.kernel.org, AJvYcCV6MSoeAoHPO21dYDosB7nQGFpE2VhaX6+WowSudoyj64pcYXxYdeqWsrUUYKLJwTP8txej2McPvBEucm+M@vger.kernel.org, AJvYcCXBeQOaLbe/bwMbJniPBzdGv3Ft1dyVlh7coEqQ5rV7N19kqZBnz0G5IhhjM3d9xKOTzxPSGZspotQSNWtkHxFdp5cD9rdk@vger.kernel.org, AJvYcCXtrVToO2wAcxX7S0l0hEcGaLJfMRbzDRaIzRNMZMckYTFrwfQtg6iwsZH2ft84cz4xDyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/Mxl5JGjbynXYUD5x7uZ6We+l7YilBDHElF09h41uT8/8b2h
	SM3BIxD5bHKs1uOsUQyoutyx8cvHKXmQGyCJrym+o1ApozmSiV1CFyZlxjNBwcKaQtofzHaW76d
	NzQVZU25fF0CYUnssyL3mhm8bryk=
X-Google-Smtp-Source: AGHT+IFE8xhBVAHiZKN085M2hxkV87sb2WFKPHHYgfTzwJpNlqX6EqQovyrHUJuSHWalozXNtjynuL9sDH7REuPinfg=
X-Received: by 2002:a5d:5c12:0:b0:381:f443:21d0 with SMTP id
 ffacd0b85a97d-38225ab4464mr589953f8f.59.1731631304689; Thu, 14 Nov 2024
 16:41:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114084345.1564165-1-song@kernel.org> <20241114084345.1564165-8-song@kernel.org>
 <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com> <E5457BFD-F7B9-4077-9EAC-168DA5C271E4@fb.com>
In-Reply-To: <E5457BFD-F7B9-4077-9EAC-168DA5C271E4@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Nov 2024 16:41:33 -0800
Message-ID: <CAADnVQJ1um9u4cBpAEw83CS8xZJN=iP8WXdG0Ops5oTP-_NDFg@mail.gmail.com>
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

On Thu, Nov 14, 2024 at 3:02=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
>
>
>
> > On Nov 14, 2024, at 12:14=E2=80=AFPM, Alexei Starovoitov <alexei.starov=
oitov@gmail.com> wrote:
> >
> > On Thu, Nov 14, 2024 at 12:44=E2=80=AFAM Song Liu <song@kernel.org> wro=
te:
> >>
> >> +
> >> +       if (bpf_is_subdir(dentry, v->dentry))
> >> +               ret =3D FAN_FP_RET_SEND_TO_USERSPACE;
> >> +       else
> >> +               ret =3D FAN_FP_RET_SKIP_EVENT;
> >
> > It seems to me that all these patches and feature additions
> > to fanotify, new kfuncs, etc are done just to do the above
> > filtering by subdir ?
> >
> > If so, just hard code this logic as an extra flag to fanotify ?
> > So it can filter all events by subdir.
> > bpf programmability makes sense when it needs to express
> > user space policy. Here it's just a filter by subdir.
> > bpf hammer doesn't look like the right tool for this use case.
>
> Current version is indeed tailored towards the subtree
> monitoring use case. This is mostly because feedback on v1
> mostly focused on this use case. V1 itself actually had some
> other use cases.

like?

> In practice, fanotify fastpath can benefit from bpf
> programmability. For example, with bpf programmability, we
> can combine fanotify and BPF LSM in some security use cases.
> If some security rules only applies to a few files, a
> directory, or a subtree, we can use fanotify to only monitor
> these files. LSM hooks, such as security_file_open(), are
> always global. The overhead is higher if we are only
> interested in a few files.
>
> Does this make sense?

Not yet.
This fanotify bpf filtering only reduces the number of events
sent to user space.
How is it supposed to interact with bpf-lsm?

Say, security policy applies to /usr/bin/*
so lsm suppose to act on all files and subdirs in there.
How fanotify helps ?

