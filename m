Return-Path: <linux-fsdevel+bounces-34976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD12B9CF525
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 20:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D82228C564
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 19:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5B1E1C08;
	Fri, 15 Nov 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3Eztt1G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAE91CEE97;
	Fri, 15 Nov 2024 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699711; cv=none; b=Ym3oBIRnkFLaeANFrf+JClyehcYIwiCtjs1XavASd3X5vW9801d/SrFmNqFnQCLWAjCur/SCFXexrYbR7dXl5IMj496LgoS9uptczf5O2/IAlwirMENOyK01AXwpPuGYSxf0aLKcu6oum3h9jr+6NaSwlP0OO+4KvCAZPNw2gNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699711; c=relaxed/simple;
	bh=11+JLjIDjOOyK0Aqas1540GH5ts0hbJToWK8RT6in2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RElvCZoHE2hNTmNZ7POSY/n2t0woe1LUByuRA8TTawuMTH7q4JFs5DTyHgUuUvSal6bgZlm3q9f0ALcQbjWJ2nsvMUbilppBKYuuwg5zL/KuIjQeyntnQw20gQYwEsbXo7AxIr0bPGP7qkuhmdlF4pSR9Nb2Ddq+WkMdfCztFpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3Eztt1G; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3821a905dbcso1384467f8f.0;
        Fri, 15 Nov 2024 11:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731699708; x=1732304508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOgoGVaGPGzqc8HLQFO0H9kyoYBMblQj8Truem6RMlg=;
        b=V3Eztt1GU5sGkaAu+0hIjjMiWDrFZguJSTyhXACLs+LDVYKqTr2ont3IUaMFRH6IHB
         0PNzqTwCvdo4EzhFX7Lz9mfj2y1aTTHbcKozAx3AlUz5Bgyeasndcu0IsfIUgwJ4rVeF
         gRr14a1yZxI9REaRvEVD3wHLrnU+MGlLI1GZR7CKQQxIz8iBTJfsCoegDh0DNK+Eg3Ie
         D9neFNnThzrKo84HQzT6S2XaKXCQF2DUsbn8pwzMp8R9a1S/5yPrMlVAEgTEMU4d0W3P
         jl8JIguQPOQKKrhFTIR+DDNvpzqvUKp+0yhShQ65rwf1ijQZ9LIfsBzH0bMdgWKiXOhz
         AaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699708; x=1732304508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOgoGVaGPGzqc8HLQFO0H9kyoYBMblQj8Truem6RMlg=;
        b=S7xMu3ufqWt4hiL57n8XOYXSlmMZ3aeZ15qsz73jOgDoraosvhT8BMK+zvpogCpkj7
         wG7yiSgxJjHu3lOkbM0CiDEG2ofX2TDcy1P+vvphlHHBs/2apuVF+Mc4lh+d01dRdVTf
         c5GMlo0wIV4XE2m9YyMyYYGwR9h9XeDMApPm/BYRm6kUJ2RgJOXq85ftS0/OB45+qAs4
         WH6Fqp/s05U5wS1Aaz7FWlZWEGs1syBWmjTJ0JGk9BzTI6SIbNatCBgZR7epuL+VNUl7
         aUZ0I0dTe559D1vpg/WZeTc/pjaWi3dBFQ61ndZoVkQvBF9LdmELBYr//rRYlJgoBlLU
         crOg==
X-Forwarded-Encrypted: i=1; AJvYcCUztC56waOTJ0rXottSRHRPXKjVfdDiFu63nu+AlFq06+iA+/93wVLhrf0txRmgDsvcQD8yOvI1AJN6K2SVfMjxFQu6adyG@vger.kernel.org, AJvYcCVNeAykylK1vGcWCDqQ8KoG3VBZXcB8jRgdwYIYn0iRILCzc0cwPKMng8x8q/vnp+11BrMKsB2hflZfTo4w@vger.kernel.org, AJvYcCWE/905eFDJiTAMXkX8zHklyu/zAWICPA/PVqBhlYeGK+DUJV0tMYr4eWWSu7yb9P6eVkcI3r687OUgh08XUw==@vger.kernel.org, AJvYcCXCnI5oKWH5ExIBFIdLWlUUJrZKyxzn+2x93BTQ4rS8u2KqBjDqmpphdBw7gz0Q3N6WNsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZa2//VFSA2l1WVvMBj3PM9RyiQuvSMA0g1XU24oYF6GoUFZ6f
	gHZyfmEgcqZeg1/YMtJBdtmA79Cq6DxvYxy3JdeDafILduzkAswubPdeOPTD3FD4BhPc+QnbXqU
	+h4RaPfigFNS+mn7dAUG+czvImuM=
X-Google-Smtp-Source: AGHT+IGHWSINqizwBrIJZlSoKrrg7DDQwkttX3kAOSa+kF7ZXNbLwGYJTiHnJ0AB6OJJOAogaGxA3sd8WRNWsXBj4wU=
X-Received: by 2002:a5d:47a4:0:b0:37d:4e74:684 with SMTP id
 ffacd0b85a97d-38225aa59f8mr3079318f8f.52.1731699707797; Fri, 15 Nov 2024
 11:41:47 -0800 (PST)
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
 <C7C15985-2560-4D52-ADF9-C7680AF10E90@fb.com>
In-Reply-To: <C7C15985-2560-4D52-ADF9-C7680AF10E90@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Nov 2024 11:41:36 -0800
Message-ID: <CAADnVQK2mhS0RLN7fEpn=zuLMT0D=QFMuibLAvc42Td0eU=eaQ@mail.gmail.com>
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

On Thu, Nov 14, 2024 at 11:01=E2=80=AFPM Song Liu <songliubraving@meta.com>=
 wrote:
>
> >
> > I think bpf-lsm hook fires before fanotify, so bpf-lsm prog
> > implementing some security policy has to decide right
> > at the moment what to do with, say, security_file_open().
> > fanotify with or without bpf fastpath is too late.
>
> Actually, fanotify in permission mode can stop a file open.

The proposed patch 1 did:

+/* Return value of fp_handler */
+enum fanotify_fastpath_return {
+ /* The event should be sent to user space */
+ FAN_FP_RET_SEND_TO_USERSPACE =3D 0,
+ /* The event should NOT be sent to user space */
+ FAN_FP_RET_SKIP_EVENT =3D 1,
+};

It looked like a read-only notification to user space
where bpf prog is merely a filter.

> In current upstream code, fsnotify hook fsnotify_open_perm
> is actually part of security_file_open(). It will be moved
> to do_dentry_open(), right after security_file_open(). This
> move is done by 1cda52f1b461 in linux-next.

Separating fsnotify from LSM makes sense.

> In practice, we are not likely to use BPF LSM and fanotify
> on the same hook at the same time. Instead, we can use
> BPF LSM hooks to gather information and use fanotify to
> make allow/deny decision, or vice versa.

Pick one.
If the proposal is changing to let fsnotify-bpf prog to deny
file_open then it's a completely different discussion.

In such a case make it clear upfront that fsnotify will
rely on CONFIG_FANOTIFY_ACCESS_PERMISSIONS and
bpf-lsm part of file access will not be used,
since interaction of two callbacks at file_open makes little sense.

> > In general fanotify is not for security. It's notifying
> > user space of events that already happened, so I don't see
> > how these two can be combined.
>
> fanotify is actually used by AntiVirus softwares. For
> example, CalmAV (https://www.clamav.net/) uses fanotify
> for its Linux version (it also supports Window and MacOS).

It's relying on user space to send back FANOTIFY_PERM_EVENTS ?

fsnotify_open_perm->fsnotify->send_to_group->fanotify_handle_event.

is a pretty long path to call bpf prog and
preparing a giant 'struct fanotify_fastpath_event'
is not going to fast either.

If we want to accelerate that with bpf it needs to be done
sooner with negligible overhead.

>
> I guess I didn't state the motivation clearly. So let me
> try it now.
>
> Tracing is a critical part of a security solution. With
> LSM, blocking an operation is straightforward. However,
> knowing which operation should be blocked is not always
> easy. Also, security hooks (LSM or fanotify) sit in the
> critical path of user requests. It is very important to
> optimize the latency of a security hook. Ideally, the
> tracing logic should gather all the information ahead
> of time, and make the actual hook fast.
>
> For example, if security_file_open() only needs to read
> a flag from inode local storage, the overhead is minimal
> and predictable. If security_file_open() has to walk the
> dentry tree, or call d_path(), the overhead will be
> much higher. fanotify_file_perm() provides another
> level of optimization over security_file_open(). If a
> file is not being monitored, fanotify will not generate
> the event.

I agree with motivation, but don't see this in the patches.
The overhead to call into bpf prog is big.
Even if prog does nothing it's still going to be slower.

> Security solutions hold higher bars for the tracing logic:
>
> - It needs to be accurate, as false positives and false
>   negatives can be very annoying and/or harmful.
> - It needs to be efficient, as security daemons run 24/7.
>
> Given these requirements of security solutions, I believe
> it is important to optimize tracing logic as much as
> possible. And BPF based fanotify fastpath handler can
> bring non-trivials benefit to BPF based security solutions.

Doing everything in the kernel is certainly faster than
going back and forth to user space,
but bpf-lsm should be able to do the same already.

Without patch 1 and only patches 4,5 that add few kfuncs,
bpf-lsm prog will be able to remember subtree dentry and
do the same is_subdir() to deny.
The patch 7 stays pretty much as-is. All in bpf-lsm.
Close to zero overhead without long chain of fsnotify callbacks.

> fanotify also has a feature that LSM doesn't provide.
> When a file is accessed, user space daemon can get a
> fd on this file from fanotify. OTOH, LSM can only send
> an ino or a path to user space, which is not always
> reliable.

That sounds useful, but we're mixing too many things.
If user space cares about fd it will be using the existing
mechanism with all accompanied overhead. fsnotify-bpf can
barely accelerate anything, since user space makes
ultimate decisions.
If user space is not in the driving seat then existing bpf-lsm
plus few kfuncs to remember dentry and call is_subdir()
will do the job and no need for patch 1.

