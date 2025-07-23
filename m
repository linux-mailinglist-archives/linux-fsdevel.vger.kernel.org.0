Return-Path: <linux-fsdevel+bounces-55886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2B9B0F874
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 18:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DCFAA3ADB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A1D1FFC5E;
	Wed, 23 Jul 2025 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLLGguco"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304A01DDA0E;
	Wed, 23 Jul 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289619; cv=none; b=aZ23OMIINgq4CLkr77Ff1O2RabBCu7hkSTFx0RaWite7kZrt6sZ3ujLUOgphp7wtuUMegs7G5bmn6j6wMNMp9GtA4+Gto0HmHtIw1mjhk9E0UAkUtUZwAEqkDNuk2LqJa7ZZGUYsfKCcdi9K4Dd2ezD0O/MKP286d10oFuhKimQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289619; c=relaxed/simple;
	bh=odouBHrCrUM6kF7xRgpvYowfqKdn1xtqvLBvlU3sXKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoJjGgBtfcQbEVLHAbXmZa7GygTJMpNBvm7jbCYiyz62cBQqBF48Hrm3auraKhNcp3jFNBWnkgrgR6jcJgcbNaAWzmewcCCPqUVH38a+xgMNnY2ZuuU5RQNqIn92lCcWWF/W+8Jw3p/sLrrVM4G1GVxJH5g9tttgplcplVxnLxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLLGguco; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so238763a12.1;
        Wed, 23 Jul 2025 09:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753289615; x=1753894415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odouBHrCrUM6kF7xRgpvYowfqKdn1xtqvLBvlU3sXKo=;
        b=fLLGgucoDfwok+KX2LKnma9GVzy+e0PNTrQskI3DfHs5/FMLzu5SRfMJp2VgCo/WgZ
         nPFRB23SIskxdIJaJetehMCzoOA53ZNh9wXhrfoXDDupfMuVd9cbSVVzxSbSZhBTdUgw
         9SLcz+fpSVsu8HwZZQ4LPxKvmbj93jlVtTUK3hYPLh95WEQHKL/GFKnxiRoKllDq7e3j
         iitW0lHXjz+6832bHNZF/J6SCtEIB1g6PZu4XKUxF+5NE4tte0L/cbfrd4HwG6Piie2T
         65gDmuLDVPlG+TGZtiwNqIFCqU01z9Wg1IR5vKPQAtAbS6j2rbsl7IWSlKBovUGlmAR1
         MC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753289615; x=1753894415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odouBHrCrUM6kF7xRgpvYowfqKdn1xtqvLBvlU3sXKo=;
        b=Get5gRKFVCdKhRgUILe3hSq/tKvGmbhT9gvPk0WUqb7YYC+LAghCGKoqP3C5Av2Qg1
         1bo+U1NdAEzrc0QagxhKsU2KNVhlTJBmjahTktK7oQTHfKYnWLIT1ZWgCjV6hmNUudpM
         Ci/dBJGq3NVazoqwbpuL8k1rbU0isMlIUjTUYA1UOxo6hOOP12it1jv7KbGjUgHsiJiP
         5IcB/i7PuzcZwBls7XMwn251bJNuFD+YzugG5SUzs2pc+hzLiXlzEc0FfdIFWkoRqz/m
         xauswKaaOfzVKk99dz1hOmOCrf0gDWUVKI5PCjeVd/tLxFdJiXu+0cO2Z62NXQTTQENy
         JepQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6viuVTZ3LNGNl9jLy9JYXqGrS6CJNAK5+6jrpT+hzyhmmgJUQJ1P3T1UBNKuTYg/d6AZ65AdkFcpKTNxS@vger.kernel.org, AJvYcCWmZik3Za60DWVtp6F/3tsWNopXZinq7TlNrlqlmE7FL53RX/kq34Hgi2SNu8rxxQscCFOWI43UJVAG4jA2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ZRnNyk1lnwccASjONuKetGnRIaLc3m9RcGxciM8A/eoyTBFb
	qhSorrXydYqZftv/oVIqxrXS1VK3yXNg1HYWumX/5VKliHdR7cKGSvnhrz2kpcrpEOKKUHIRsGc
	4drFiGMPAsjnVsaFaUNz5iPgMyax15Fs=
X-Gm-Gg: ASbGncvavnASN6HqjRcC2olcQOauOVZIg5N8buvxY7etviAbdbnEx74p2XxfIzOwnz1
	jU0nmC2CvPdBmQwSVXLemLtIVaD25+23bAD9Fo+XV8RbIUtylN04msrluM2dHSIaSLuNh6WiiFS
	VGRkHTdyEFg1JeRqlSQR+limrAcbFgsZkxMFGca8vmxNvi48wnk3FlDkVSseMq/YpEkSmLu8eTq
	babxCE=
X-Google-Smtp-Source: AGHT+IF7USQr+zSq41+QoRCJaFe5o2dfeYKWeZC2+LE1crhtHngNDrpLadVyu0GO6qCU3/w3g+aiExE6uOEWAcBhpIA=
X-Received: by 2002:a17:907:3d05:b0:ad5:1c28:3c4b with SMTP id
 a640c23a62f3a-af2f91727cbmr379403066b.52.1753289614870; Wed, 23 Jul 2025
 09:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com>
 <CAOQ4uxgaxkJexvUFOFDEAbm+vW4A1qkmvqZJEYkZGR5Mp=gtrg@mail.gmail.com>
 <CAL=UVf707OokQUuhzbvrweFziLVmiDD3TFs_WG2hRY0-snw7Wg@mail.gmail.com>
 <CAOQ4uxhUK6EeCUZ36+LhT7hVt7pH9BKYLpxF4bhU4MM0kT=mKg@mail.gmail.com>
 <CAOQ4uxjX1Cs-UYEKZfNtCz_31JiH74KaC_EdU07oxX-nCcirFQ@mail.gmail.com> <CAL=UVf5W9eJF4FL6aRG4e1VoFWg8jj4X4af=j-OGdU=QxmPuwA@mail.gmail.com>
In-Reply-To: <CAL=UVf5W9eJF4FL6aRG4e1VoFWg8jj4X4af=j-OGdU=QxmPuwA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 23 Jul 2025 18:53:21 +0200
X-Gm-Features: Ac12FXx1YPn0tonsz5K8kgBCWv4CyypV6BjeVwAbQDgp3Jf34XmD0U0MJbREea4
Message-ID: <CAOQ4uxgqS0cK6ovwjMjSFndiFBUP1Z9ZXdAoCJayeo4W00nGLg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RFC: Extend fuse-passthrough to directories
To: Paul Lawrence <paullawrence@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 11:13=E2=80=AFPM Paul Lawrence <paullawrence@google=
.com> wrote:
>
> I spent a little time with these patches. I wrote my own to set the
> backing file at lookup time by adding an optional second out struct.

FUSE_CREATE already returns two out args.
How were you planning to extend it?

> Is there a reason we should not do this? It seems the most natural
> solution.
>
> After a while, I began to wonder if what I was planning was actually
> the same as your vision. I decided to jot down my thoughts to see if
> you agree with them. Also I was confused as to why you were adding the
> ability to set backing files to GETATTR.

It is a demo. It demonstrates that passthrough can be set up sooner than
open time. It was not my intention to keep it this way.

> So here are my notes.
>
> Design of fuse passthrough for all operations
>
> Goal:
>
> When a fuse filesystem implements a stacking filesystem over an
> underlying file system, and a significant fraction of the calls will
> simply be passed to the underlying file system, provide a mechanism to
> pass those calls through without going to user space. This is
> primarily to enhance performance, though it might simplify the daemon
> somewhat too.
>
> Current state:
>
> Currently passthrough allows a backing file to be set at file open
> time. If a backing file is set, all read/write operations will be
> forwarded to the backing file.
>
> Design:
>
> Add ability to set backing file on the found inode in response to a
> positive lookup. This file might be opened with O_PATH for performance
> reasons. The lookup api would be modified to have an optional second
> out struct that contains the backing file id. Note that we will use
> the backing file ioctl to create this id to remove any security
> concerns.
>
> The ioctl will also take a 64-bit integer to define which operations
> will be passed through, the operations mask. This will have one bit
> for each of the existing FUSE_OPERATIONS, at least the ones that act
> on inodes/files.
>
> Then when fuse fs is considering calling out to the daemon with an
> opcode, fuse fs will check if the inode has a backing file and mask.
> If it does, and the specific opcode bit is set, fuse fs will instead
> call out to a kernel function in backing.c that can perform that
> operation on the backing file correctly.
>
> Details:
>
> Question: Will it be possible to change the mask/backing file after
> the initial setting? My feeling is that it might well be useful to be
> able to set the mask, the file not so much. Situations would be (for
> example) a caching file system that turns off read forwarding once the
> whole file is downloaded.
>

Generally, enabling passthrough from a point in time until the end of
inode lifetime is easier than turning it off, but also there are many
dependencies between passthrough ops and inode state so it will
require a lot of care to enable *some* operations mid inode lifetime.

> FUSE_OPEN will, if the backing file has been set, reopen it as a file
> (not a path) if needed. This is whether or not FUSE_OPEN is passed
> through.
>
> If FUSE_OPEN is passed through, user space will not get the chance to
> assign a file handle ID to the opened file. It will still be possible
> to pass FUSE_READ etc to the daemon - the daemon will still have the
> node id and be able to read data based on that.
>

Not sure I understand what you mean, but we do support per file opt-out of
passthrough with FOPEN_DIRECT_IO even when the inode is already
set up for passthrough.

> FUSE_LOOKUP can return a 0 node id, but only if *all* operations on
> that node as marked as passthrough.

Not sure why this is but I will be open to understanding.
Will need an elaborate design of the inode lifetime in this case.

>
> Suggestion: During FUSE_LOOKUP, if FUSE_GETATTR is set in the mask,
> ignore the passed in attributes and read them from the backing file.

My patches already implement that when GETATTR is in the mask.

>
> Random, non-exhastive list of considerations:
>
> FUSE_FORGET can only be marked passthrough if the node id is 0.
>
> FUSE_CREATE returns a new node id and file handle. It would need the
> ability to set backing files.
>
> If FUSE_LOOKUP is marked for passthrough, then looked up inodes will
> be prepopulated with a backing O_PATH file and a mask will all bits
> set.
>
> FUSE_RENAME takes two nodes and names, and moves one to the other. If
> one is passthrough and one is not, there is no obvious way of
> performing a rename. Either fall back to copy/delete or return EXDEV

Good question.

My patches were meant to provide you the basic infrastructure to enter
this playground and show that you do not need backing dentry/inode
beyond what is already available.

I hope this is enough for you to start experimenting and sending RFC patche=
s
with design doc!

Thanks,
Amir.

