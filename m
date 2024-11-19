Return-Path: <linux-fsdevel+bounces-35163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B92A9D1C24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 01:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF43D282672
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 00:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB2F11CA0;
	Tue, 19 Nov 2024 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjepgakh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB03C8FF;
	Tue, 19 Nov 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731975063; cv=none; b=s1V5Can8ASw0xOvpLRu6oVy5pXJF1S3NgO8jvmnwET347SB15NgZqkLEzEgr8FXfALYjF533w3JP3sCcWg3inZKU6us3yGCYCmAZ0PmVhdUzKmJQxfiY3cPp51sx9m7ni2VanZGEMTPUZkyo5M57WXcr2+hR5SkJN3AqMsfXbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731975063; c=relaxed/simple;
	bh=A0Ap+tCZPda+zWvq3LT3lAWaJyJgNMoZc7tW/G691sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcB3ExZftVJaHUnSHx+jmxXYcembklgZVVwpzl5qE3elWzi3apMHb6XvP3MQOFAu9NbPYWAnKEhTxbKAOPUMh0rKNnCYb5DyNRDtaivLEsFw1dDFJeOVKzKFwAW0qJhyoj+OQpay6vFZ8ybYITXUPZZ/hvN5V8hZka1dn9CLDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yjepgakh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so22345495e9.3;
        Mon, 18 Nov 2024 16:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731975060; x=1732579860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0Ap+tCZPda+zWvq3LT3lAWaJyJgNMoZc7tW/G691sY=;
        b=Yjepgakh+KmMbwuwQYtXE3q7MMM98AcaavdVH1OBm/LcQqaRfl73El22AOrKhdnFgK
         /bMD4s2G1XCkrB0BnpCSABJsv7MaFHpw93RXM3s3B5gJlYc3BOrCWKnhf9xsu/uQEMVV
         jkEw7U4GpRd4DT0BBYXmKbLGgCdodKOE35tyfrFV9YWsIyfz487+9XszaBEwPXGtm6kk
         WvF/JFOZrZxo0QD/OeIBygjpInnfevCP76pczExNZuxZxyXif4qBzVyx61ILmM5SIvvG
         adGimucUx095tceOXBOtsK1NM7kTn8zKXywc9mwC8iXF/vlCFdUYx4nm5muaYuO7Pxa5
         rxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731975060; x=1732579860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0Ap+tCZPda+zWvq3LT3lAWaJyJgNMoZc7tW/G691sY=;
        b=RT6uTcYOC7qlKJw8R9KLLb0Q5waawQwPuD51fLoZGtPPN62O7/xLpalUFjgVtEFwFh
         Tuhkc9FP4p2i7jq8vFiTYOA3Tddu9TAOWgcmzkAdbW7V7SpPxQYQKjkqYo+iJAvIoOwI
         suXPSR26JqzjusciEo4EPOHxGIrxkn0j54LZV96er0RLbKkJqJ3StUjKTQYJYPljEWYb
         Yiqqhjap56vj2Q09b9ZPvH/2VIaOUzJSCN8+z7mjSv5unfbEl3TxTHBCaGCwy44MdsGL
         imcX1Q51Y7Cgwqzp7H7xMJj6gIM/9vKomMY46n/yrbb83zeAiAGEFvjYZgje3PMvkA4z
         tEyA==
X-Forwarded-Encrypted: i=1; AJvYcCUS01atyBuS25m80H6QcHoN6qNybWitp2NQdhierPJKDdqqqMjiJ4zbjHxHG3R8MM+GAxFk8OS2tf5uIim2@vger.kernel.org, AJvYcCV2H9I/Le02Q58EdE6ZRQHj34DevjvWwOuLJsd0AQG0YBPR7gRDWspA2vq93wsoB+KCRFen/5ffjwW4zDAWQCgziLzOQiDX@vger.kernel.org, AJvYcCVeMKhkc2DmFF+SkK82v0fRbYtNL4VKckzYILWt+it0mfCn4ztj5tYGsJifhzISMM/BqJM=@vger.kernel.org, AJvYcCWsIROZe5XHMCcqQd1KyAAhZKXJlkXqh1gs4VmJvHK+BJh2SGWqwWdhS27t7I2t0K2KtjTl+b6NeUdDgdMzyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Yigvyh+I3fVxQwopI8kfXFbGIWeRCbnoVsf9mYJjXnBeMjZt
	Z/PbWyLkjRzoezw6WWya+iM2VR8nX5Ac/WCPIGdPVBHAJ6ZFGjbF0FlYpB1TZdt3pJnJnaM9wMD
	PUW+seoQ23wNhrdb8UwqflLgbIQ8=
X-Google-Smtp-Source: AGHT+IFbKcAGeX9oW64nBsmy9scvBQQTJAqWNC31VE6QpX+sDVYU8zY8RFHlGMnLhwshWBMEpIEUlBFKw7tTwUJwZzo=
X-Received: by 2002:a05:6000:71d:b0:37d:45de:9dfb with SMTP id
 ffacd0b85a97d-38225acd2e4mr10716132f8f.46.1731975059636; Mon, 18 Nov 2024
 16:10:59 -0800 (PST)
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
In-Reply-To: <B3CE1128-B988-46FE-AC3B-C024C8C987CA@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 18 Nov 2024 16:10:48 -0800
Message-ID: <CAADnVQJtW=WBOmxXjfL2sWsHafHJjYh4NCWXT5Gnxk99AqBfBw@mail.gmail.com>
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

On Mon, Nov 18, 2024 at 12:51=E2=80=AFPM Song Liu <songliubraving@meta.com>=
 wrote:
>
>
>
> > On Nov 15, 2024, at 1:05=E2=80=AFPM, Song Liu <songliubraving@meta.com>=
 wrote:
>
> [...]
> >
> >>
> >> fsnotify_open_perm->fsnotify->send_to_group->fanotify_handle_event.
> >>
> >> is a pretty long path to call bpf prog and
> >> preparing a giant 'struct fanotify_fastpath_event'
> >> is not going to fast either.
> >>
> >> If we want to accelerate that with bpf it needs to be done
> >> sooner with negligible overhead.
> >
> > Agreed. This is actually something I have been thinking
> > since the beginning of this work: Shall it be fanotify-bpf
> > or fsnotify-bpf. Given we have more materials, this is a
> > good time to have broader discussions on this.
> >
> > @all, please chime in whether we should redo this as
> > fsnotify-bpf. AFAICT:
> >
> > Pros of fanotify-bpf:
> > - There is existing user space that we can leverage/reuse.
> >
> > Pros of fsnotify-bpf:
> > - Faster fast path.
> >
> > Another major pros/cons did I miss?
>
> Adding more thoughts on this: I think it makes more sense to
> go with fanotify-bpf. This is because one of the benefits of
> fsnotify/fanotify over LSM solutions is the built-in event
> filtering of events. While this call chain is a bit long:
>
> fsnotify_open_perm->fsnotify->send_to_group->fanotify_handle_event.
>
> There are built-in filtering in fsnotify() and
> send_to_group(), so logics in the call chain are useful.

fsnotify_marks based filtering happens in fsnotify.
No need to do more indirect calls to get to fanotify.

I would add the bpf struct_ops hook right before send_to_group
or inside of it.
Not sure whether fsnotify_group concept should be reused
or avoided.
Per inode mark/mask filter should stay.

> struct fanotify_fastpath_event is indeed big. But I think
> we need to pass these information to the fastpath handler
> either way.

Disagree.
That was the old way of hooking bpf bits in.
uapi/bpf.h is full of such "context" structs.
xpd_md, bpf_tcp_sock, etc.
They pack fields into one struct only because
old style bpf has one input argument: ctx.
struct_ops doesn't have this limitation.
Pass things like path/dentry/inode/whatever pointers directly.
No need to pack into fanotify_fastpath_event.

> Overall, I think current fastpath design makes sense,
> though there are things we need to fix (as Amir and Alexei
> pointed out). Please let me know comments and suggestions
> on this.

On one side you're arguing that extra indirection for
inode local storage due to inode->i_secruity is needed
for performance,
but on the other side you're not worried about the deep
call stack of fsnotify->fanotify and argument packing
which add way more overhead than i_security hop.

