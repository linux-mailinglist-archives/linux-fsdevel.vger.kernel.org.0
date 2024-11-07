Return-Path: <linux-fsdevel+bounces-33894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44AC9C03BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 12:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297B21F2218D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAC61F5833;
	Thu,  7 Nov 2024 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoDKCozQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E311F4723;
	Thu,  7 Nov 2024 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978414; cv=none; b=Qk4U1sTWtaCK0yzZp9qVIVfjItvOnkjR0ywsUuOmbNeF+SYetXMKeGQofE+X0XQ9osiXYtALdNES3iAhFXrDt3/Jk/QRlnACoR+oQIH0dmwMfqVSutfcwQUpj070budO1RPrlw4qVIwDg/9OmVmpvFjhMQwFNRj7i7ZyInf5V7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978414; c=relaxed/simple;
	bh=cKs3nGlKrYKwfxl2ze6Z47cN9UUOS6ICPa53w8GB5GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yf3max64mzSgOTFSodWVxWwocj8cZLULQThE+DGp+11D5nonwv+Sjj8IupLM/778kxR4glNwk8cphgNh1kTe+On0SlE+2V5ykAFdUFwFgP9MacI9yq4590pgnIKCrVIggrVMMVEGGhrLrH8lZlbccgtdMPpJ6a9n6F+QoFUMO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoDKCozQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cf04f75e1aso643999a12.1;
        Thu, 07 Nov 2024 03:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730978411; x=1731583211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKs3nGlKrYKwfxl2ze6Z47cN9UUOS6ICPa53w8GB5GU=;
        b=aoDKCozQvDpED4BBs3ACLRhe/RytwMFDTrrzWTU+h8ImcBnSSRumwPCvl9YiDiIypP
         2EL+0EbVJynkxqIaK3rXAIThE2MmzcXPa30TSE8AErbFJZJcWrfMnmt/bJ8QJnSsEkIV
         0948Bwh7e+ujE+V9cFmIMe0Djs3TfIOBY7ZH+t7P578v9KKX4B8zA3Nd1kUkrS+EeZku
         kXSrm7agbTgthzV/x2346udkehtjDlztXmwcoJ6lJzyN5tUqTx42/hr+LC15cuti0X0N
         rJb+BAdYQ/728fEEiH9kO9CT+RioAtu+WqTn6e0qmA5+r/L6s/Z4Y9UAobwCnzXEUT0R
         LoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730978411; x=1731583211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKs3nGlKrYKwfxl2ze6Z47cN9UUOS6ICPa53w8GB5GU=;
        b=kDqbgOGXWXtw9E7yZCSXMY1pggTqCFJKc6joKoIFRJaOGSqbNzXnpI4ddjzBC9El9W
         uEecjvhRP3WrIkIlha18bPyR3seYCZMFvdQW8XCZRA6PC2L7yQuF0vk6z31Z9OrUftf3
         VbqaqjT1bebStSMYisVDDK2QLDoCKwiwbl+vTsCuuajp3qQViG2ZWPipOHmbV3VNP4PA
         yAPZErt0o7xWrXaf4U4IV5/WwTEaWW1ktWPFS7iBsDeh99NROLZVLYfRZo3VeQ0xxkju
         3oHJ+7gWjOBKawVKkwwdUaT5614OVOriXIsgRI8k8DG8XJhQ7gg8bkIW7iy6bxxz0ABu
         dQnw==
X-Forwarded-Encrypted: i=1; AJvYcCUnm6X/oniBzz3n6Ds1BNBmR8kUtcsNEMTTl72YGw1x9S4if8XK4PeuLMsza2OiTzvbZZA=@vger.kernel.org, AJvYcCWAwy7mnGy5A4f/g/xD8siiiM55jEs0MODCxK9Y3An06bHCRAh+1XGLx+1v8a3ILBBAPjz/GAyHN4qIk3AM2g==@vger.kernel.org, AJvYcCWlvt+kAITmSqfCf0TnWlsXe4BbUrrcJ0M23haakkkOv7KnLdozCURET1n6U7NKkKwsAZTs7WJ66uzPNPcM@vger.kernel.org
X-Gm-Message-State: AOJu0YwNY1z5PTURn98Lb6VQpvg4+GoMeihPM3znuVRxARaM4flgCBhg
	GVuZUGybX2rICoE8IA0h4LM6wVM901PEvdLfnrCcIydjzesmF3j4VvkKAoMQhc0oL55zaY6pLTQ
	KOnUOUDRD533O0PySzeUxywVV0fw=
X-Google-Smtp-Source: AGHT+IEIV/Bzp+Gx4s/r67H6BJfcYRWGFvR6PRJ+8aViwXu1qLCvYuzb8jBBqyJmUmI5C6+T3ZbgJas44MxPHsQMe3o=
X-Received: by 2002:a17:907:e6c7:b0:a9e:d49e:c475 with SMTP id
 a640c23a62f3a-a9ed49ec528mr227318266b.26.1730978410528; Thu, 07 Nov 2024
 03:20:10 -0800 (PST)
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
Date: Thu, 7 Nov 2024 12:19:56 +0100
Message-ID: <CAOQ4uxgyC=h4+kXvem8nDf0Niu-HgswoamxYnFXz03K5dFe6Zw@mail.gmail.com>
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

IIUC, the BFP program example uses another API to configure the filter
(i.e. the inode map).

IMO, passing any single argument during setup time is not scalable
and any filter should have its own way to reconfigure its parameters
in runtime (i.e. add/remove watched subtree).

Assuming that the same module/bfp_prog serves multiple fanotify
groups and each group may have a different filter config, I think that
passing an integer arg to identify the config (be it fd or something else)
is the most we need for this minimal API.
If we need something more elaborate, we can extend the ioctl size
or add a new ioctl later.

Thanks,
Amir.

