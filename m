Return-Path: <linux-fsdevel+bounces-34983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDE79CF572
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 21:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB491F23DBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 20:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9694F1E2315;
	Fri, 15 Nov 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAkHYuqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F501E2007;
	Fri, 15 Nov 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701057; cv=none; b=iDPd/NW2bIQQ+TRW1QjaAzBtw2kVHIqd1qkquBO9yeKGMnTyLe4sboQQPDayWJA8zzN7qpztCOcazOmf4llXv3h1vkGgkJL7pOwjbcGDStNKIzgS29NSJuQChHhQss6Jz/8zAt9GE+n8q5usygjxxDbbk+IntsO/AjSUx88ik6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701057; c=relaxed/simple;
	bh=GNNsgXZz94lF3I3Pz1DGMTj1jbKzkiOuGPGsVCeAhFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lld1csml+Ui3uPxqnmSHlG8/Gjnhb+VWjbulXnMpBrAXmQSHMO6AnO3fV3OU6sUfid9lJEAdWwItF8Hu2h8rjbEYuJUQT/2FRdfCPSJuqHb2tq22rqcVnVIyhWK9yXVOpaRkeyVk41chBvBKY4xiQ9QbIkyUqKGKczDQCayY78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAkHYuqJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d49a7207cso1315454f8f.0;
        Fri, 15 Nov 2024 12:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731701054; x=1732305854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwYXMR7UIXp9uh4TDepTdI8MR5u6vSz3D5tn0WWpGys=;
        b=LAkHYuqJHnuYpdBrxUxTPHHieOvXnzn+27AfqGWj9sygN4bCGMhNgki1LPFfSPBvbw
         sdBMpkPrS4WchCLR/Jedggdx+0kP78V0fqOWjF7xJ2NtA9ri8IENyHMA/qIPtdcLw0Ww
         XuGZhpW+ncCCVFP7dEOX4gW2mpMqb+R5Y96AIN26gvEkXr2RrMqLAOWZohcQuwSE5C3Y
         stM7lni0TffsoVqgFhqkB/t+oKEfjmC0DB7BKMzUkN/e/1LPFjgSgFXYWEaZHsY5cbDi
         LztRuci+S/P2CGZPBq9DThV/zBUNL32nciiEVi6pxtQNl0TIgGrqrcnPL3G0/0cQIlhV
         PMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701054; x=1732305854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwYXMR7UIXp9uh4TDepTdI8MR5u6vSz3D5tn0WWpGys=;
        b=MSEFHkR+Lo3SVewUZWyFwSzwoOArShaNMKsHwsxFFVqYvI5THz1fffIbsGuYYoMRkR
         d8ygrqfSl4yrd/IgP4KFAAULNV1YVylJpPkjoYMKRYS0PGo8HRIJhT/PcVxxSIRGWLv4
         Zaj8tWLLNP84TCDFYnS3cHZMo6hMdzff4tASOO20gZbnTZCgkU2crw60byBZXC96e8av
         tJSJDTkPER18xvsrfNEwEE8EllbuGY5hIeBzlo80RmGuUeCt2YnwDuTmhYyqypWdQ16O
         1lrOtdDVqyqvrxcN1hJ+003lDS0w3on9nhiauyVMCIsgv1Z6/gcPJN9lv4ALmiBDg7KJ
         YLnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1gk799GzJ4vjb3vqHpRVIfcZGQ8ijXlA/84tYFTh9U8cxpvnlWNFF0I0/eOEr6ynxd8o79jZudzLkdcJtHpBQFusKSHnd@vger.kernel.org, AJvYcCVfoCOLW2piAWTxa6OK4Ea5/lw+qYvGJcMHwNm9Kt4MjfBERn7S+D+cB/SoCALYt4wvnHSUNOi0BDUhhyevpQ==@vger.kernel.org, AJvYcCWjw9lbVfwVqCbb1tyrEZxwoDmvL9QE1Jl7b6KurObyiME70cKCVQvbZR2KhClOIpGmJ+cGzSs3+wu7HLfP@vger.kernel.org, AJvYcCXaLMh0IwW6r3/pcT0CcyJNdx/PCMCpdUQFmqs5xNa4yRxZtMwwXV/SmG4n8Sz3Ub+lQyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNprNqY+R8aCFBndG9Qb+2ca8cXgD7grAebujq9kDqB4xWorX
	qRNN4YYcMU44gCk6BmxxCtLag3AGCLm3yDw5mwrEy8l2GIvtSPsnqYcSkbBt4csgwzRWxLvDC5i
	RRtdFACpbE4KtLePmsiTBQhvcEp8=
X-Google-Smtp-Source: AGHT+IGO8SZPf2XiKcxVV0GNc5Ely/yXtW0TWMw9NpRXJ0GMX7rOaWzJom9SfnTAG8X01LKFbW/sS2hvsUM4LOOCHNk=
X-Received: by 2002:a05:6000:1845:b0:37d:4eeb:7375 with SMTP id
 ffacd0b85a97d-382259058dfmr3348693f8f.16.1731701053372; Fri, 15 Nov 2024
 12:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114084345.1564165-1-song@kernel.org> <20241114084345.1564165-8-song@kernel.org>
 <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com> <CAOQ4uxhnBRs2Wtr7QsEzxHrkqOtkh9+xxDuNRHxxFY0ih-543g@mail.gmail.com>
In-Reply-To: <CAOQ4uxhnBRs2Wtr7QsEzxHrkqOtkh9+xxDuNRHxxFY0ih-543g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Nov 2024 12:04:02 -0800
Message-ID: <CAADnVQ+nzeyitBVgz2a0K=kSMi5HOSVwxBuuHMqSqmT6H+oqnw@mail.gmail.com>
Subject: Re: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for
 BPF based fanotify fastpath handler
To: Amir Goldstein <amir73il@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, "repnop@google.com" <repnop@google.com>, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 11:26=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Thu, Nov 14, 2024 at 9:14=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Nov 14, 2024 at 12:44=E2=80=AFAM Song Liu <song@kernel.org> wro=
te:
> > >
> > > +
> > > +       if (bpf_is_subdir(dentry, v->dentry))
> > > +               ret =3D FAN_FP_RET_SEND_TO_USERSPACE;
> > > +       else
> > > +               ret =3D FAN_FP_RET_SKIP_EVENT;
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
> Good question.
>
> Speaking as someone who has made several attempts to design
> efficient subtree filtering in fanotify, it is not as easy as it sounds.
>
> I recently implemented a method that could be used for "practical"
> subdir filtering in userspace, not before Jan has questioned if we
> should go directly to subtree filtering with bpf [1].
>
> This is not the only filter that was proposed for fanotify, where bpf
> filter came as an alternative proposal [2], but subtree filtering is by f=
ar
> the most wanted filter.

Interesting :)
Thanks for the links. Long threads back then.
Looks like bpf filtering was proposed 2 and 4 years ago and
Song's current attempt is the first real prototype that actually
implements what was discussed for so long?
Cool. I guess it has legs then.

> The problem with implementing a naive is_subtree() filter in fanotify
> is the unbounded cost to be paid by every user for every fs access
> when M such filters are installed deep in the fs tree.

Agree that the concern is real.
I just don't see how filtering in bpf vs filtering in the kernel
is going to be any different.
is_subdir() is fast, so either kernel or bpf prog calling it
on every file_open doesn't seem like a big deal.
Are you saying that 'naive is_subdir' would call is_subdir
M times for every such filter ?
I guess it can be optimized. When these M filters are installed
the kernel can check whether they're subdirs of each other
and filter a subset of M filters with a single is_subdir() call.
Same logic can be in either bpf prog or in the kernel.

> Making this more efficient then becomes a matter of trading of
> memory (inode/path cache size) and performance and depends
> on the size and depth of the watched filesystem.
> This engineering decision *is* the userspace policy that can be
> expressed by a bpf program.
>
> As you may know, Linux is lagging behind Win and MacOS w.r.t
> subtree filtering for fs events.
>
> MacOS/FreeBSD took the userspace approach with fseventsd [3].
> If you Google "fseventsd", you will get results with "High CPU and
> Memory Usage" for as far as the browser can scroll.

Yeah. Fun.

Looking at your 2 year old attempt it seems the key part was to
make sure inodes are not pinned for filtering purpose?
How would you call is_subdir() then if parent dentry is not dget() ?
Or meaning of 'pinning' is different?

> I hope the bpf-aided early subtree filtering technology would be
> able to reduce some of this overhead to facilitate a better engineering
> solution, but that remains to be proven...

Sure. Let's explore this further.

> Thanks,
> Amir.
>
> [1] https://lore.kernel.org/linux-fsdevel/20220228140556.ae5rhgqsyzm5djbp=
@quack3.lan/
> [2] https://lore.kernel.org/linux-fsdevel/20200828084603.GA7072@quack2.su=
se.cz/
> [3] https://developer.apple.com/library/archive/documentation/Darwin/Conc=
eptual/FSEvents_ProgGuide/TechnologyOverview/TechnologyOverview.html#//appl=
e_ref/doc/uid/TP40005289-CH3-SW1

