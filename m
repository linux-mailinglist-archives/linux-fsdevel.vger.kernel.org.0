Return-Path: <linux-fsdevel+bounces-36752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBA29E8E41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 10:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E82A2814B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F13217F2B;
	Mon,  9 Dec 2024 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbL8lFoa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD7216388;
	Mon,  9 Dec 2024 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734754; cv=none; b=H2fQr1P2Bj3gZQsRdT2XFrCu6kL7EoYVNsTPfmtjigCINijSZR0NhiIFbH4sL/d5jLCObHs86bkbcVGCg3ANnmyvZ/dBa/1yHkFfjE35J6gD4/8Z1dXdIkeGTu7Pya957mkLPNVhxxf6PYiAJ5hr1AA3TjJ3nmdYlB/pH1sp8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734754; c=relaxed/simple;
	bh=npytWJ14egtdb2VlDm9K3uiWjqdb48MwyRsQxkJ5tKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UskamZIzwTjx2uuXQmdWfGRaPO+4l7cYWP/kbwEHscSebV48nxIoEXNIspk7PjGt3XHZUCKKEG+Cn0emshbPmc3UI7nyNzwQCIhrCYEz70lLTnP1j6DzrIZ3tkzdIMZb64SbEIRnW/HrdrlwpmQslS4tgkuvE/aKPQEvCH78Ofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbL8lFoa; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso2121490a12.3;
        Mon, 09 Dec 2024 00:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733734750; x=1734339550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqsYvwOOYJqI0HxdPRE2Hj4F+6WdBcYKvH3M4THFPWw=;
        b=QbL8lFoaSzzOiLnHsYYIwNSOH5A+3+NpAXt7i76qjwvAA1VMMXpK8LmRrDbJ5xQaRM
         xQMIlaOHIBc7uPCHrCdGNLP/2R84KOjkPfuyV3+t4bK3fYgtWyO/pXJTQD5Kapbh8iCn
         GIrfgan04rgcJa/7s3nZ/8WO4/yXaXDQXSwlVnzkyNL3/wPR3UsWvVC0v8EPXYIeVSnZ
         +DGQnV9trZgtSa4+VSZccBT16WqNzauYxgXuubAyk7p83KfFmF13vNe6Td+Murn7Zvt0
         byDnhsnA54nyYav7CifsnXIm5ofFzTkJsitplaeA7sCypvYX6B/URbr4aOz+90nQ/cU0
         Q4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734750; x=1734339550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqsYvwOOYJqI0HxdPRE2Hj4F+6WdBcYKvH3M4THFPWw=;
        b=E6G1iZ3tXF6G11bUor6U8T33LCy2zmB2MpgkgxUySkq1c1HyAvcTKaqyYA1h13l3uQ
         CHMwesQnl/B5nUnPL9JEDDPGbouUX4SCTaB9Oao1SCGZTTPhhNJTi29k0ALq4pvipMRq
         A4aMnOliH2QO9lKF+1ZK9SFty4PP/Bog1EnmBHNyl3mq4gXlChSljsiafQW1UYsX3CFw
         TVdNyggwLbYl6rReUSOi9qnTPzx3ay4ldPkMdJLRs3CZNJJqD6P+Sp3Z1D+CWdUISjaK
         eTVtD3dMqqlw6AlE0IV2xiF0Hhkhz9THU89URnH07aIvMcAGkI8u7W22SS8zngt+H8GA
         XNMg==
X-Forwarded-Encrypted: i=1; AJvYcCUvEVoRXoiLhIQL374PlHXAsfToqrfOnTES+nZJoCVmLRiisIrQr0Efr5ozyUm6gD9FZdKcFaxlpwUWHV/N@vger.kernel.org, AJvYcCWMOgO2E/5l06gyMxQB0eX2rQj/4S4a271IeZANiSqRnSNqRUF+X6QQl3eRcrZ13VmXpcYJFvMwbmsb03XX@vger.kernel.org, AJvYcCXK/Oif9vFjGPTRSAsEOgauIe3AmD/MS6rmxz2n3o5eHFFv7wNUziVa9sI3MMce5shuMWZvcFJHDtGe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4w04w6DRTyNJsmyA1Acd3KKofGWGmnpXfTcIq5Frp4WNZidxv
	pcZQMfY46LMlgnV9Fs9JMB8khtW+akKvpjAoyreUzVjp0t6LonaOSHuNUDyuF6Sekjl8Yz07ALD
	9BGoCjP7GoI45pnK68hMaAgvP7oalrBoIvUQ=
X-Gm-Gg: ASbGnctzUcUA6Ba4GlNc4AXzve1TFgXKjeEC0QFdM8clw5lNk7lRA9Q1bP61RqXfEEU
	0XsAYhFvwU8KgRGL1p6Dr6DvFMlwjTfw=
X-Google-Smtp-Source: AGHT+IFbZMAd2GmlVtMCS3Zq6WbMuDHdX6/bNyqG2LoXdhZ7ENWQ474L+6RWee4ycIOKzYu+NcRnefPTUPpirQId6lg=
X-Received: by 2002:a05:6402:912:b0:5d0:ca51:e859 with SMTP id
 4fb4d7f45d1cf-5d3be71b9e8mr12468354a12.27.1733734750224; Mon, 09 Dec 2024
 00:59:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <Z1D2BE2S6FLJ0tTk@infradead.org> <CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>
 <20241206160358.GC7820@frogsfrogsfrogs> <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
 <Z1ahFxFtksuThilS@infradead.org>
In-Reply-To: <Z1ahFxFtksuThilS@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 9 Dec 2024 09:58:58 +0100
Message-ID: <CAOQ4uxiEnEC87pVBhfNcjduHOZWfbEoB8HKVbjNHtkaWA5d-JA@mail.gmail.com>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export operations
 as only supporting file handles
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Erin Shepherd <erin.shepherd@e43.eu>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable <stable@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:49=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Sat, Dec 07, 2024 at 09:49:02AM +0100, Amir Goldstein wrote:
> > > /* file handles can be used by a process on another node */
> > > #define EXPORT_OP_ALLOW_REMOTE_NODES    (...)
> >
> > This has a sound of security which is incorrect IMO.
> > The fact that we block nfsd export of cgroups does not prevent
> > any type of userland file server from exporting cgroup file handles.
>
> So what is the purpose of the flag?  Asking for a coherent name and
> description was the other bigger ask for me.
>
> > Maybe opt-out of nfsd export is a little less safer than opt-in, but
> > 1. opt-out is and will remain the rare exception for export_operations
> > 2. at least the flag name EXPORT_OP_LOCAL_FILE_HANDLE
> >     is pretty clear IMO
>
> Even after this thread I have absolutely no idea what problem it tries
> to solve.  Maybe that's not just the flag names fault, and not of opt-in
> vs out, but both certainly don't help.
>
> > Plus, as I wrote in another email, the fact that pidfs is SB_NOUSER,
> > so userspace is not allowed to mount it into the namespace and
> > userland file servers cannot export the filesystem itself.
> > That property itself (SB_NOUSER), is therefore a good enough indication
> > to deny nfsd export of this fs.
>
> So check SB_NOUSER in nfsd and be done with it?
>

That will work for the new user (pidfs).

I think SB_KERNMOUNT qualifies as well, because it signifies
a mount that does not belong to any user's mount namespace.

For example, tmpfs (shmem) can be exported via nfs, but trying to
export an anonymous memfd should fail.

To be clear, exporting pidfs or internal shmem via an anonymous fd is
probably not possible with existing userspace tools, but with all the new
mount_fd and magic link apis, I can never be sure what can be made possible
to achieve when the user holds an anonymous fd.

The thinking behind adding the EXPORT_OP_LOCAL_FILE_HANDLE flag
was that when kernfs/cgroups was added exportfs support with commit
aa8188253474 ("kernfs: add exportfs operations"), there was no intention
to export cgroupfs over nfs, only local to uses, but that was never enforce=
d,
so we thought it would be good to add this restriction and backport it to
stable kernels.

[CC patch authors]

I tried to look for some property of cgroupfs that will make it not eligibl=
e
for nfs such as the SB_KERNMOUNT and SB_NOUSER indicators, but
as far as I can see cgroups looks like any other non-blockdev filesystem.

Maybe we were wrong about the assumption that cgroupfs should be treated
specially and deny export cgroups over nfs??

Thanks,
Amir.

