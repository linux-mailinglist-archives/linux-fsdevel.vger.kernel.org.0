Return-Path: <linux-fsdevel+bounces-33820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160319BF775
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 20:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398361C250F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 19:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C02020FA8F;
	Wed,  6 Nov 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVEKi8hL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC1920F5D9;
	Wed,  6 Nov 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922064; cv=none; b=Nndn0nyC7Ld9lAA13Arh0qa36UTVgOuyGSgY7tezQP84sXxYdu+GhlsaLlEZuvzd4owLEuKwV/YBU17eqb1vhXuiaFBSiCC8uB1RhinH6X46jhcwHnJUvowMCDHVzovB0UxDj2n16a2oXKnChdLGu/fmHyCplEMegd15XBBl9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922064; c=relaxed/simple;
	bh=WpvKLOYWNlDsvlZTYzGRl6LdBizhhjwkrc3+YE1Js4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbXya44zNfxeF0gQYUonAY8VvuVwjp4TdyJNh34MOEeVp6mJwvD0db/mV7esNZecLcdIOnLnVkfEX9UHh7QgNj8pmbea+ShbydUzhdTqDh/2o2pCk8rApRLgnVLg9mLdEFJr0tIGKcog9FiRUubXmf+yTclOoJiitZUN3TrU154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVEKi8hL; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b15d330ce1so10305585a.1;
        Wed, 06 Nov 2024 11:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730922061; x=1731526861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpvKLOYWNlDsvlZTYzGRl6LdBizhhjwkrc3+YE1Js4U=;
        b=HVEKi8hLNw4w8+5FS+CLidm22e5sEHBPQm1Z7yhXeivlZ9MYpSGabalG/DdsStvc2L
         jnVeZwsjOaUVPWNU4u6B3yu+qh2GTRyF7L4f/5XMhwzDcwT8aw6RwpZaj/BET4PYo2Jk
         F78ICwvjrG4zINpfVVCl17FuVWIUevZ2TAxizMGFM6BhwG7qzj71hUc99kQTrm/vfFB4
         rs/coIT7GjVy2cgx+H+inJB9hjWK/5zOXIrDaW4q1rXRVfWV8hz9fKYdzwtwne7DzkKb
         aEhZZHkS/mYTOhWC/1hRD3hhIpJ3awJGX6lXs3Vbp7LN5uFf7aPhgg25M92cwWfOkGrI
         ewRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730922061; x=1731526861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpvKLOYWNlDsvlZTYzGRl6LdBizhhjwkrc3+YE1Js4U=;
        b=YjKpYT7S6yTDIALZmw2J8a/R6N/eEdFSGF5eL2q1Vmjj6VgvZR013BrW00S7kPTXsa
         vT0icz4g4YTxTXbnkOphwXSQmsZL7fDEhsJwtS/Sg9BM9iJD3X06qC5II7broKMq0fdC
         yXW4d26+p/ZFqMoMRPNUp3BGXfLQ7HftNKPdAdJ+oE9n2bCiea9rXmS4x+npPGx6/djs
         3ZB6+dnd5j/l+5kmU1+PWIqGJ7hfvnKPE90UikWqDHHDqDlu8Y9VoUNC+kBydkuhWR6s
         FhW+a2QQLchTsmHKRpKTq8p25H7DVQrjm3KlRWSK00H+u7swJa2Kgqn7FQ0hgdEDnx7J
         y7wg==
X-Forwarded-Encrypted: i=1; AJvYcCUk8fMqQeHa1zY0FIEZDM62KlqxEL+mWXIXupYVaE7PVug9nZl5gSGVwjK0CujwL8TJ+74=@vger.kernel.org, AJvYcCWad7rl5DJZrGu7EPJAIkwIF59j9ujZwG6PmAGVNVTpzwnCfsPY0c2mpMTiQcC7QnYYx9/rqEROj8IEw80Udg==@vger.kernel.org, AJvYcCXRb2XQ8N8pTudRMBQ/XWMnGolQuI3qdkZLhbAU3OATIiVhgZTdfnbGOaKmKbKjazCR861g81QKgzjJW54q@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8lzKCQ0Ytp+lFn28ezVqb1g6un+eJmdq3YaM9OaAEWkR0YOn
	vXKEMpIkq7YH3ygQ/WXEnPa3fSOOBaq0/V7WBkoZ/55R8RVBt/yb5PeGsWG7zu03QeLADbxms/F
	wSC+BE7Ysoq18VkQQjPU7Ug4jOPE=
X-Google-Smtp-Source: AGHT+IEPciyNUcY0fU46+3o9pOFbr+Y0MwiNxdVrhDGCfcYLdtZDl29KM0p1fREUkB206b5sKWEnrTQG7CVei1n5EYc=
X-Received: by 2002:a05:6214:5992:b0:6cb:e5e9:3182 with SMTP id
 6a1803df08f44-6d351ad52bemr333806266d6.29.1730922061322; Wed, 06 Nov 2024
 11:41:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029231244.2834368-1-song@kernel.org> <20241029231244.2834368-3-song@kernel.org>
 <5b8318018dd316f618eea059f610579a205c05db.camel@kernel.org>
 <D21DC5F6-A63A-4D94-A73D-408F640FD075@fb.com> <22c12708ceadcdc3f1a5c9cc9f6a540797463311.camel@kernel.org>
 <2602F1B5-6B73-4F8F-ADF5-E6DE9EAD4744@fb.com>
In-Reply-To: <2602F1B5-6B73-4F8F-ADF5-E6DE9EAD4744@fb.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 6 Nov 2024 20:40:50 +0100
Message-ID: <CAOQ4uxjyN-Sr4mV8EjhAJ9rvx4k4sSRSEFLF08RnT1ijvm2Y-g@mail.gmail.com>
Subject: Re: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
To: Song Liu <songliubraving@meta.com>
Cc: Jeff Layton <jlayton@kernel.org>, Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	"repnop@google.com" <repnop@google.com>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:52=E2=80=AFAM Song Liu <songliubraving@meta.com> =
wrote:
>
> Hi Jeff,
>
> > On Oct 30, 2024, at 5:23=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> w=
rote:
>
> [...]
>
> >> If the subtree is all in the same file system, we can attach fanotify =
to
> >> the whole file system, and then use some dget_parent() and follow_up()
> >> to walk up the directory tree in the fastpath handler. However, if the=
re
> >> are other mount points in the subtree, we will need more logic to hand=
le
> >> these mount points.
> >>
> >
> > My 2 cents...
> >
> > I'd just confine it to a single vfsmount. If you want to monitor in
> > several submounts, then you need to add new fanotify watches.
> >

Agreed.

> > Alternately, maybe there is some way to designate that an entire
> > vfsmount is a child of a watched (or ignored) directory?
> >
> >> @Christian, I would like to know your thoughts on this (walking up the
> >> directory tree in fanotify fastpath handler). It can be expensive for
> >> very very deep subtree.
> >>
> >
> > I'm not Christian, but I'll make the case for it. It's basically a
> > bunch of pointer chasing. That's probably not "cheap", but if you can
> > do it under RCU it might not be too awful. It might still suck with
> > really deep paths, but this is a sample module. It's not expected that
> > everyone will want to use it anyway.
>
> Thanks for the suggestion! I will try to do it under RCU.
>

That's the cost of doing a subtree filter.
Not sure how it could be avoided?

> >
> >> How should we pass in the subtree? I guess we can just use full path i=
n
> >> a string as the argument.
> >>
> >
> > I'd stay away from string parsing. How about this instead?
> >
> > Allow a process to open a directory fd, and then hand that fd to an
> > fanotify ioctl that says that you want to ignore everything that has
> > that directory as an ancestor. Or, maybe make it so that you only watch
> > dentries that have that directory as an ancestor? I'm not sure what
> > makes the most sense.
>
> Yes, directory fd is another option. Currently, the "attach to group"
> function only takes a string as input. I guess it makes sense to allow
> taking a fd, or maybe we should allow any random format (pass in a
> pointer to a structure. Let me give it a try.
>
> Thanks again!
>
> Song
>
> >
> > Then, when you get a dentry-based event, you just walk the d_parent
> > pointers back up to the root of the vfsmount. If one of them matches
> > the dentry in your fd then you're done. If you hit the root of the
> > vfsmount, then you're also done (and know that it's not a child of that
> > dentry).

Agreed.

Thanks,
Amir.

