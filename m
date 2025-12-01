Return-Path: <linux-fsdevel+bounces-70292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD5EC9603F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 08:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6A0F4E14AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 07:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A245A29B775;
	Mon,  1 Dec 2025 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeUR40Qv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A685276058
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764574364; cv=none; b=mf5hVHm07yXhvsAAxeLIrxcZ5PSUrzB8wcgKoZmSVal7i8eChNnf1kraipbNVFcxUXk0eUB9GDq2Y38P9zyVRFKyPZmxlfPEX4VAXYk+DePJBjnIewlU+IM4ZDet678zEHPiMn9s6v0h4OMV2/+2BTiG4B7g9tDezv2fRTgzSVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764574364; c=relaxed/simple;
	bh=2HcB0rmeLO9c2p/95fKpiNCYvyMjRskFUOWSbUC6AiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsbLdBF42/VvU/JkVHRieRv9Si18EsWGccer4XGteo5MnM+tRM4oWOdmIIanGOcVGSLRi5+jk2pKWoxAFsmqii9N9u9FfM5MnQ77Kj7tBwyMCHTOW6thGoLhY6Tq9/hx7RhOh++pttgn/uJOgL9lXRdFGwhhFZt3SqHDU13Pi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeUR40Qv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDA6C19422
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 07:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764574363;
	bh=2HcB0rmeLO9c2p/95fKpiNCYvyMjRskFUOWSbUC6AiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AeUR40QvAL/O3HkvK1hjGZdFkNezLR8UrMSDV6vVUOgAZCfgmXbXKgsBm3s0ql+TT
	 rmOyXs4MNHeMI31imeda9RdRFKJ5FeeQTcBXVD/xOV9wJlmGR/PSqSVtS0XhM2+jLF
	 g2Ox5zDSGtv4U6aFp3+qR/A1brHsfYl9kN+UPXpkfW6Og3bChq0x35aY96SRBF+OnG
	 D4+6tqRLoH3G+hNXlTrVdqgqsKcL6G2FjmSOYeLUhWl/YC8roD9FgDoHCFFNwj1pvn
	 FeZnr+uRPnZwzaQJ9xi7obeMAhyhnQhvoGeDecO0WHtn26kTRLrvHrDvh8Boc/Tn/C
	 bfqlnphLAAzFA==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2d32b9777so489245485a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Nov 2025 23:32:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzLMYtRts4VyS55lDdn0d1hOHrN8EpwBRtKGMg2qm4I/pjR61+yltfIPbrtfIgvDl7Vwj7JZEi4J3Pda6p@vger.kernel.org
X-Gm-Message-State: AOJu0YziOLik1mRkyM3WHPFx9ccYwKRxp8xpxwP/Xm8X/gv8h/MQ5eN4
	jKF9GDFdSz7ZN55rVEzW5XWV0dZfIcAdB9jacsCSsU9v5WEwkJsVdUZk/ZBOh7O9vM+YlnrdR6h
	yXUXRgphxXnOff5pGVs8QG8jaDwgKimg=
X-Google-Smtp-Source: AGHT+IFglr+eAJ6/kpiLpwoQ4bMfZ9GpJBhTlxQ0IjIkbOlY5rRNSu1dxm2OscHjOPnfjbC59lRnQV3K560qMn+WRYw=
X-Received: by 2002:a05:620a:199b:b0:8b1:426d:2b87 with SMTP id
 af79cd13be357-8b33d22a4damr4793296685a.21.1764574362574; Sun, 30 Nov 2025
 23:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127005011.1872209-1-song@kernel.org> <20251127005011.1872209-3-song@kernel.org>
 <20251130042357.GP3538@ZenIV> <CAPhsuW69nUeMf+89vwsBrwo4sv3P8xOypSfhafEu12HJKqAb+w@mail.gmail.com>
 <20251130064609.GR3538@ZenIV>
In-Reply-To: <20251130064609.GR3538@ZenIV>
From: Song Liu <song@kernel.org>
Date: Sun, 30 Nov 2025 23:32:30 -0800
X-Gmail-Original-Message-ID: <CAPhsuW671wnZTzqAPUGH6Qic0Gw70B0t3Z7oLV82+-zvERyP-g@mail.gmail.com>
X-Gm-Features: AWmQ_bmPQ3Cm1vwPQQahNc4xHN3w1dYaZYDEgTSAIdzpu6R6JPMJ3tN6rcRFOrc
Message-ID: <CAPhsuW671wnZTzqAPUGH6Qic0Gw70B0t3Z7oLV82+-zvERyP-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_kern_path and bpf_path_put kfuncs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, kernel-team@meta.com, brauner@kernel.org, jack@suse.cz, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	Shervin Oloumi <enlightened@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 10:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Sat, Nov 29, 2025 at 09:57:43PM -0800, Song Liu wrote:
>
> > > Your primitive is a walking TOCTOU bug - it's impossible to use safel=
y.
> >
> > Good point. AFAICT, the sample TOCTOU bug applies to other LSMs that
> > care about dev_name in sb_mount, namely, aa_bind_mount() for apparmor
> > and tomoyo_mount_acl() for tomoyo.
>
> sb_mount needs to be taken out of its misery; it makes very little sense
> and it's certainly rife with TOCTOU issues.
>
> What to replace it with is an interesting question, especially considerin=
g
> how easy it is to bypass the damn thing with fsopen(), open_tree() and fr=
iends.
>
> It certainly won't be a single hook; multiplexing thing aside, if
> you look at e.g. loopback you'll see that there are two separate
> operations involved - one is cloning a tree (that's where dev_name is
> parsed in old API; the corresponding spot in the new one is open_tree()
> with OPEN_TREE_CLONE in flags) and another - attaching that tree to
> destination (move_mount(2) in the new API).

We currently have security_move_mount(), security_sb_remount(), and
security_sb_kern_mount(), so most things are somewhat covered.

> The former is "what", the latter - "where".  And in open_tree()/move_moun=
t()
> it literally could be done by different processes - there's no problem
> with open_tree() in one process, passing the resulting descriptor to
> another process that will attach it.

For open_tree, security_file_open() can cover the "what" part of it.

>
> Any checks you do sb_mount (or in your mount_loopback) would have
> to have equivalent counterparts in those, or you get an easy way to
> bypass them.
>
> That's a very unpleasant can of worms; if you want to open it, be my
> guest, but I would seriously suggest doing that after the end of merge
> window - and going over the existing LSMs to see what they are trying to
> do in that area before starting that thread.

I very much support fixing it properly, and I don't plan to rush into a
half broken workaround. I am not very optimistic about whether
we can bring everyone to the same page, but I think it is worth a try.

> And yes, that's an example
> of the reasons why I'm very sceptical about out-of-tree modules in
> that area - with API in that state, we have no realistic way to promise
> any kind of stability, with obvious consequences for everyone we can't
> even see.

I am not sure what you mean by "with API in that state". Which API
sets are you talking about: the LSM hooks, the BPF kfuncs in
bpf_fs_kfuncs.c, or all the exported symbols that are available to in-tree
and out-of-tree LSMs? And how would you suggest we make these
APIs into a better state?

Thanks,
Song

