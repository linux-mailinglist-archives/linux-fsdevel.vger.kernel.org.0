Return-Path: <linux-fsdevel+bounces-36755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93BA9E8F94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902FD162359
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B6E2165F1;
	Mon,  9 Dec 2024 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT+izL+P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A7213E86;
	Mon,  9 Dec 2024 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738556; cv=none; b=tWSeZAuXVBvY61TgiG+XYCNb6YLHj9qV+dzh2twhHKh6pbPG5/PufrDB41eDOSw8pfEMcTZ4fJms308Da50gR2vJWmpnRcMOz3La/TdNy+szcto2JeHmQ5/TCNOaWUTpDOu0Dqckva+rPg/bB4T5bcFXNq+7/IvnlJ16ldp17k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738556; c=relaxed/simple;
	bh=fGe1pCheSUZ3DVrySi+EYo023ft3GflGpElhlPuZzrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPXqMEWHa43sjcw6rSi5IBbTSXxOs6CkjwvfB9UnrpQKAZVAZl5MFbxu5hsMr0yugSon+MhaWJj49VcOAqehZXynLUd/a/YHmvSbSHWgcL3pTXKE8/ficPX8U9DwoBG+ooxvV+r3Gfeo8nPnDtV+i9xut/gxwmZIkUo2HGKjrc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT+izL+P; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0f6fa6f8bso5964882a12.0;
        Mon, 09 Dec 2024 02:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733738553; x=1734343353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlHlfiQuJu50AVWfAHvcIXpbhRtwKsPqA64U55n/Ml4=;
        b=TT+izL+P7+MhvY4VqBmvKW9ZIBU8gA4Od1wscIN/z+BwzqUA09ffYGhE2NGI8qJcCx
         0/q4H8rhETrFgtaXjeY5bdou+Tg1wvGlSb3lVdbT+T1q4yfFSTSVXBvbvV21UgmBWJRD
         90Vq2q3BR3ytnwA973cliQgAhfIJUyGbz1JkQL6Z65Bcv6aSJFpE72fazXjFsmcwi8oz
         loA2lfgqi6dF96dLWg+JJV3gb4IbOaHMVF33jZzSZNGSe3u5PV3xUqZRdkSr18W1BrO0
         KS2XfVYwyfjE7V//JIwzQybSLm/j4uMqjbA2hAIr2yEp72dXqqqz5WfMvBBaVBF7kDY9
         z8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738553; x=1734343353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlHlfiQuJu50AVWfAHvcIXpbhRtwKsPqA64U55n/Ml4=;
        b=uLOrdtKns/rh2v9EdRvJYXabg+gqvk2YXSrG1/dL5cjcmjGhNPqua0354uryEftUor
         9bMWPYpFrJBdN14tOdFRqQCIUu8hhniG+J/jMezI0IlexqSvLba9Ro26+9INOStFFrwQ
         GCUzwVj42ZfueKYA21qLhAfeVdSp5qW18MwBFGc8UUV/vEx42lHI96TEisJdjSnNOk8B
         pRIpCuRhk2fAiOn0bHDdoiQelAOKC0tyy0TCClbOhZ3iWh2raPU/R4DA0Bv0VTdNpkGF
         J56tw7fGIU3+W+poZGHKS60a0lgJ7JENJ5K6gOOf4FZcFg3jvwmw+nzQHJ5DrGI/pDLY
         QJ9w==
X-Forwarded-Encrypted: i=1; AJvYcCUPvwou0qhNPvqmJ6UFr0Oy6U1wp35SBWt3WyK3cqJsSjvgBhLfQaqQ0n3VV+rpYaDVRxoaCUVmzf9C0VgE@vger.kernel.org, AJvYcCVyQxZMX3dvsDJifjQE4QRq5wwppaCs63Sf8+cMVtSe7NqBbOQh0IXhjDE7kwdhZObqjodO6UZTyW6OUwkz@vger.kernel.org, AJvYcCW6gX7mLWE743AIyN/DWtNZq39FPdqHnzcrgn2G8dJZh2jJMa9+iO2ofo+RQzSXTdzh16vYdgeqTk0g@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6gQI/UGWn7zittjRcWHMX/Xtk0WZF/sdlpCEPdwwYumJmGGiu
	sALPj4cqK/8JyY1OYzugmzR6izlEhlnxTHKSkLbDcnwyzvHe4Aiq3+idPlBCF7S3KwcxJgbwQy/
	ohfcyaLUhKEoIK/m9IuW8b2S0iS4=
X-Gm-Gg: ASbGncvsxuAna0awBojmccP7glDV+lcYZzFUcznm7UxbsD1a9wutOmDSIT12FKJgwqN
	uWz7PqyM6npdRqrd3h107oLC71alNFuA=
X-Google-Smtp-Source: AGHT+IH+k5frZ6Zd+ETiTrl727WVSzP2zd7tKN4wKOOk0K556oX1luw3RsrNnRWNMfayt30yf+Q+KYOhO+K6wl9opMA=
X-Received: by 2002:a05:6402:5186:b0:5d1:fb79:c1b2 with SMTP id
 4fb4d7f45d1cf-5d3be677d39mr12150387a12.11.1733738552865; Mon, 09 Dec 2024
 02:02:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <Z1D2BE2S6FLJ0tTk@infradead.org> <CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>
 <20241206160358.GC7820@frogsfrogsfrogs> <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
 <Z1ahFxFtksuThilS@infradead.org> <CAOQ4uxiEnEC87pVBhfNcjduHOZWfbEoB8HKVbjNHtkaWA5d-JA@mail.gmail.com>
 <2024120942-skincare-flanking-ab83@gregkh>
In-Reply-To: <2024120942-skincare-flanking-ab83@gregkh>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 9 Dec 2024 11:02:21 +0100
Message-ID: <CAOQ4uxi-UezfebQ9-Hy0QLMx=Jn6P5+qAEZy_nuH29Hj4e0OrQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export operations
 as only supporting file handles
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Erin Shepherd <erin.shepherd@e43.eu>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stable <stable@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Shaohua Li <shli@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 10:16=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Dec 09, 2024 at 09:58:58AM +0100, Amir Goldstein wrote:
> > On Mon, Dec 9, 2024 at 8:49=E2=80=AFAM Christoph Hellwig <hch@infradead=
.org> wrote:
> > >
> > > On Sat, Dec 07, 2024 at 09:49:02AM +0100, Amir Goldstein wrote:
> > > > > /* file handles can be used by a process on another node */
> > > > > #define EXPORT_OP_ALLOW_REMOTE_NODES    (...)
> > > >
> > > > This has a sound of security which is incorrect IMO.
> > > > The fact that we block nfsd export of cgroups does not prevent
> > > > any type of userland file server from exporting cgroup file handles=
.
> > >
> > > So what is the purpose of the flag?  Asking for a coherent name and
> > > description was the other bigger ask for me.
> > >
> > > > Maybe opt-out of nfsd export is a little less safer than opt-in, bu=
t
> > > > 1. opt-out is and will remain the rare exception for export_operati=
ons
> > > > 2. at least the flag name EXPORT_OP_LOCAL_FILE_HANDLE
> > > >     is pretty clear IMO
> > >
> > > Even after this thread I have absolutely no idea what problem it trie=
s
> > > to solve.  Maybe that's not just the flag names fault, and not of opt=
-in
> > > vs out, but both certainly don't help.
> > >
> > > > Plus, as I wrote in another email, the fact that pidfs is SB_NOUSER=
,
> > > > so userspace is not allowed to mount it into the namespace and
> > > > userland file servers cannot export the filesystem itself.
> > > > That property itself (SB_NOUSER), is therefore a good enough indica=
tion
> > > > to deny nfsd export of this fs.
> > >
> > > So check SB_NOUSER in nfsd and be done with it?
> > >
> >
> > That will work for the new user (pidfs).
> >
> > I think SB_KERNMOUNT qualifies as well, because it signifies
> > a mount that does not belong to any user's mount namespace.
> >
> > For example, tmpfs (shmem) can be exported via nfs, but trying to
> > export an anonymous memfd should fail.
> >
> > To be clear, exporting pidfs or internal shmem via an anonymous fd is
> > probably not possible with existing userspace tools, but with all the n=
ew
> > mount_fd and magic link apis, I can never be sure what can be made poss=
ible
> > to achieve when the user holds an anonymous fd.
> >
> > The thinking behind adding the EXPORT_OP_LOCAL_FILE_HANDLE flag
> > was that when kernfs/cgroups was added exportfs support with commit
> > aa8188253474 ("kernfs: add exportfs operations"), there was no intentio=
n
> > to export cgroupfs over nfs, only local to uses, but that was never enf=
orced,
> > so we thought it would be good to add this restriction and backport it =
to
> > stable kernels.
> >
> > [CC patch authors]
> >
> > I tried to look for some property of cgroupfs that will make it not eli=
gible
> > for nfs such as the SB_KERNMOUNT and SB_NOUSER indicators, but
> > as far as I can see cgroups looks like any other non-blockdev filesyste=
m.
> >
> > Maybe we were wrong about the assumption that cgroupfs should be treate=
d
> > specially and deny export cgroups over nfs??
>
> Please don't export any of the "fake" kernel filesystems (configfs,
> cgroups, sysfs, debugfs, proc, etc) over nfs please.  That way lies
> madness and makes no sense.

Agreed. The problem is that when looking in vfs for a clear definition
of "fake" kernel filesystems, I cannot find an objective criteria, especial=
ly
for those "fake" fs that you listed.

The "pseudo" filesystems (that call init_pseudo()) which are clearly
marked with SB_NOUSER (except for nsfs)

The "internal" filesystems that use kern_mount() internal mount ns
are clearly marked with SB_KERNMOUNT.

One commonality that I found among most fs that have a known sysfs
mount point is that they use  get_tree_single() because they are "singleton=
"
filesystems. However, a singleton filesystem may not be fake (efivarfs,
openpromfs), so I am not sure this is a good indication for no nfs export
and in any case, this it not true for procfs, sysfs, cgroups (kernfs).

We are left with the fact that there is no clear criteria with the list of
"fake" filesystems that you mentioned and among that list, only cgroupfs
has implemented file handles, so I see two options:

1. Explicitly opt-out of nfs export for cgroups as the proposed patch set d=
oes
2. Clearly mark all "fake" filesystems, for whatever "fake" means with
    SB_<WHATEVER> and then let nfsd query the "fake" fs flag

#1 is pretty straightforward.
#2 means this discussion will go on for some time and that I may eventually
need to submit a "What is a fake filesystem?" topic to LSFMM ;)

Thanks,
Amir.

