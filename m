Return-Path: <linux-fsdevel+bounces-35177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7D59D2115
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 09:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A1A7B21779
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 07:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93AB195F28;
	Tue, 19 Nov 2024 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La32eARX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738231EA90;
	Tue, 19 Nov 2024 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003185; cv=none; b=Fl25YIkQ1ZlKVWOMikDcr7a2T+bhWIh29e6o8I7ihoMrbZ+hsp9yI2Kjkobt+r6ouZDRdtSh8ITOZpihIf0Adrjj66s9IWNW7nTsW8GTGJmw9vlV6aSug5Kq6lwvz463LZ3YwfJdudhwdnFOYwJtqFE0E5jaxlberzhASnYrjuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003185; c=relaxed/simple;
	bh=j4ScOirTDpbPjcCCL2zpAPwYNVwEozgBssf7fVm3QW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdCShtrQM4Y1FCxLxozVZizbYeW1TVS7MiL9zGvOfKzRk9ciix/BoEmbGZ8H5PYweaaJf/orrz0IDSDtpjdvazuN5A3vCqnbQSzC0cEgNyRCO52DMro5UKHQ+3e/MxFq8Ewo7iU1mjH0cBjLVmkU5ss6SAjcYhVRT25Tju+n2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La32eARX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9e44654ae3so646682766b.1;
        Mon, 18 Nov 2024 23:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732003182; x=1732607982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWJ3SElgo8sOubJ4quprJV0x1Yd1+NLGowZ3Af1cxUQ=;
        b=La32eARX0mTaUhZxW1F0MVygVXmps+N5JbeteeCXHv+RbjMkLMOxEuVjnyF+AIc61v
         N68nx39fxsQVnHx3fyIgS8qksJDvGQ8o3SlvbU1VJpLO8CKc6QaotjOBkA7AMXERqnuy
         HAuQ2Iav7Y/+DyZP5mh8SLgBFxX27AQMibXhUCI+Eryo62QPZeibarxCqn5ODZ/htRZY
         YOXgUyRBAcYi02hZ0dniHqAltte/5wcBcwjnnQhBrEFtuKmRpwqvGWcSFSRhzu5iGTs7
         83vwnZN2lQdeQUmlbzK+NVXyNCSkHb2GRaOev/S7BpZNXo/DumsxqibzTC1mlWP+ARPx
         GKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732003182; x=1732607982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWJ3SElgo8sOubJ4quprJV0x1Yd1+NLGowZ3Af1cxUQ=;
        b=dISlZf28MTfyBjI6rzRTq08ycOashGieeF7ivE4Ib9Rn/UurhWLvaJGJZ0Ei8QgfFg
         285laGSaGAmdBCHyJ3aPp8Mny2G2ee5UVpO+UWR9c9g4zSER1w31ZtJhI1wdRayJgv8N
         Cn1cDCUuVLLfUhr4FxEwRhiSzkcKx1pObPTup5NzWyF6e578uYvphbpZBprscvpw0EXc
         N8Y7nylKLDxJZ/9hb+t/Xthx6jR7NEBO5y/BXGY7oqBFADekxcjcCDEpW1cJcbm+fopV
         B5jxagBTCw1lFBh5YcMe/dpVhJ7PFgDW5AJOYeLddXgJS/oZOkk0qjK4hzDfco+5vRRe
         inGA==
X-Forwarded-Encrypted: i=1; AJvYcCVWhUbodpuZVFqVdkFfSnJs8U70RbEJmfTMf50oyJAE0MLXVYMYQ/rxoxjkUXA7u4nTBBf75kbUsyK7l96EU5fjZZuyCnQK@vger.kernel.org, AJvYcCW9xJMAUjW9yhdauQEPSIhZQHaDwoUGVymazM5R0fa6PhdtZYOywWAYzORFQo7LftpNKbWVo8jPjDRXagzl@vger.kernel.org, AJvYcCX0zJo4qM8dgNc9KfuE2YShAQP2uIp4RkZ/Bd6Lw9I5xKBqWh5+MKtypnhIlBr7Lob8g997k9PnXYwS0jiG5w==@vger.kernel.org, AJvYcCXd500RU1pUu6OITB7CmXBJncPUwItaCckK4VhydLXml8swwkNx66Zy2qMkzdhvjUCF3Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymd7MDyXOFHn0qbxOx5DT2xd5PXIyPBgXGqvAS2utKEtFas2eZ
	/Rvk2+XQTF9/JV2lPAwhKLBhw5ZLbWYd6egh/wXRXIYQ5k7AQD/f3osiRXb+TSeQiJR74Q3uk+F
	yRhKAKDRVThfesfifsEUckgu+dXE=
X-Google-Smtp-Source: AGHT+IFWrErUXGNLUOZofWwu2v82N54yoko0IyspMNmDzSfbaCAmQzlf/OwADp10rR2tqdm2OeLYBYLHzbL0fIpcr8E=
X-Received: by 2002:a17:907:1c21:b0:a9a:eeb:b263 with SMTP id
 a640c23a62f3a-aa48354d634mr1434295266b.58.1732003181391; Mon, 18 Nov 2024
 23:59:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114084345.1564165-1-song@kernel.org> <20241114084345.1564165-8-song@kernel.org>
 <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com>
 <E5457BFD-F7B9-4077-9EAC-168DA5C271E4@fb.com> <CAADnVQJ1um9u4cBpAEw83CS8xZJN=iP8WXdG0Ops5oTP-_NDFg@mail.gmail.com>
 <DCE25AB7-E337-4E11-9D57-2880F822BF33@fb.com> <CAADnVQ+bRO+UakzouzR5OfmvJAcyOs7VqCJKiLsjnfW1xkPZOg@mail.gmail.com>
 <C7C15985-2560-4D52-ADF9-C7680AF10E90@fb.com> <CAADnVQK2mhS0RLN7fEpn=zuLMT0D=QFMuibLAvc42Td0eU=eaQ@mail.gmail.com>
 <968F7C58-691D-4636-AA91-D0EA999EE3FD@fb.com> <B3CE1128-B988-46FE-AC3B-C024C8C987CA@fb.com>
 <CAADnVQJtW=WBOmxXjfL2sWsHafHJjYh4NCWXT5Gnxk99AqBfBw@mail.gmail.com> <C777E3FC-B3D4-4373-BE9E-52988728BD5E@fb.com>
In-Reply-To: <C777E3FC-B3D4-4373-BE9E-52988728BD5E@fb.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 19 Nov 2024 08:59:30 +0100
Message-ID: <CAOQ4uxga-iZtL+OsocdxwSyBqNKnGsgnq+OQ56Lm4neQ8kP82A@mail.gmail.com>
Subject: Re: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for
 BPF based fanotify fastpath handler
To: Song Liu <songliubraving@meta.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Song Liu <song@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
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

On Tue, Nov 19, 2024 at 2:10=E2=80=AFAM Song Liu <songliubraving@meta.com> =
wrote:
>
> Hi Alexei,
>
> > On Nov 18, 2024, at 4:10=E2=80=AFPM, Alexei Starovoitov <alexei.starovo=
itov@gmail.com> wrote:
> [...]
> >>>
> >>> Agreed. This is actually something I have been thinking
> >>> since the beginning of this work: Shall it be fanotify-bpf
> >>> or fsnotify-bpf. Given we have more materials, this is a
> >>> good time to have broader discussions on this.
> >>>
> >>> @all, please chime in whether we should redo this as
> >>> fsnotify-bpf. AFAICT:
> >>>
> >>> Pros of fanotify-bpf:
> >>> - There is existing user space that we can leverage/reuse.
> >>>
> >>> Pros of fsnotify-bpf:
> >>> - Faster fast path.
> >>>
> >>> Another major pros/cons did I miss?

Sorry, I forgot to address this earlier.

First and foremost, I don't like the brand name "fast path" for this
feature.  The word "fast" implies that avoiding an indirect call is
meaningful and I don't think this is the case here.

I would rather rebrand this feature as "fanotify filter program".
I am going to make a controversial argument:
I anticipate that in the more common use of kernel filter for fanotify
the filter will be *likely* to skip sending events to userspace,
for example, when watching a small subtree in a large filesystem.

In that case, the *likely* result is that a context switch to userspace
is avoided, hence, the addition of one indirect call is insignificant
in comparison.

If we later decide that my assumption is wrong and it is important
to optimize out the indirect call when skipping userspace, we could
do that - it is not a problem, but for now, this discussion seems
like premature optimization to me.

> >>
> >> Adding more thoughts on this: I think it makes more sense to
> >> go with fanotify-bpf. This is because one of the benefits of
> >> fsnotify/fanotify over LSM solutions is the built-in event
> >> filtering of events. While this call chain is a bit long:
> >>
> >> fsnotify_open_perm->fsnotify->send_to_group->fanotify_handle_event.
> >>
> >> There are built-in filtering in fsnotify() and
> >> send_to_group(), so logics in the call chain are useful.
> >
> > fsnotify_marks based filtering happens in fsnotify.
> > No need to do more indirect calls to get to fanotify.
> >
> > I would add the bpf struct_ops hook right before send_to_group
> > or inside of it.
> > Not sure whether fsnotify_group concept should be reused
> > or avoided.
> > Per inode mark/mask filter should stay.
>
> We still need fsnotify_group. It matches each fanotify
> file descriptor.
>

We need the filter to be per fsnotify_group.
Unlike LSM, fsnotify/fanotify is a pubsub service for many
fs event consumers (a.k.a groups).
The feature is a filter per event consumer, not a global filter
for all event consumers.

> Moving struct_ops hook inside send_to_group does save
> us an indirect call. But this also means we need to
> introduce the fastpath concept to both fsnotify and
> fanotify. I personally don't really like duplications
> like this (see the big BUILD_BUG_ON array in
> fanotify_handle_event).
>
> OTOH, maybe the benefit of one fewer indirect call
> justifies the extra complexity. Let me think more
> about it.
>

I need to explain something about fsnotify vs. fanotify
in order to argue why the feature should be "fanotify", but the
bottom line is that is should not be too hard to avoid the indirect
call even if the feature is introduced through fanotify API as I think
that it should be.

TLDR:
The fsnotify_backend abstraction has become somewhat
of a theater of abstraction over time, because the feature
distance between fanotify backend and all the rest has grew
quite large.

The logic in send_to_group() is *seemingly* the generic fsnotify
logic, but not really, because only fanotify has ignore masks
and only fanotify has mark types (inode,mount,sb).

This difference is encoded by the group->ops->handle_event()
operation that only fanotify implements.
All the rest of the backends implement the simpler ->handle_inode_event().

Similarly, the group->private union is always dominated by the size
of group->fanotify_data, so there is no big difference if we place
group->fp_hook (or ->filter_hook) outside of fanotify_data, so that
we can query and call it from send_to_group() saving the indirect call
to ->handle_event().

That still leaves the question if we need to call fanotify_group_event_mask=
()
before the filter hook.

fanotify_group_event_mask() does several things, but I think that
the only thing relevant before the filter hook is this line:
                /*
                 * Send the event depending on event flags in mark mask.
                 */
                if (!fsnotify_mask_applicable(mark->mask, ondir, type))
                        continue;

This code is related to the two "built-in fanotify filters", namely
FAN_ONDIR and FAN_EVENT_ON_CHILD.
These built-in filters are so lame that they serve as a good example
why a programmable filter is a better idea.
For example, users need to opt-in for events on directories, but they
cannot request events only on directories.

Historically, the "generic" abstraction in send_to_group() has dealt
with the non-generic fanotify ignore mask, but has not dealt with
these non-generic fanotify built-in filters.

However, since commit 31a371e419c8 ("fanotify: prepare for setting
event flags in ignore mask"), send_to_group() is already aware of those
fanotify built-in filters.

So unless I am missing something, if we align the marks iteration
loop in send_to_group() to look exactly like the marks iteration loop in
fanotify_group_event_mask(), there should be no problem to call
the filter hook directly, right before calling ->handle_event().

Hope this brain dump helps.

Thanks,
Amir.

