Return-Path: <linux-fsdevel+bounces-24709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B964943790
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 23:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0908D284774
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 21:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FF416B397;
	Wed, 31 Jul 2024 21:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFuWpSyn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C351BC40
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460279; cv=none; b=ox7NSKfSR3fPP0maN48Bg3UcjV/8uh05csG6zC03CCgKEskikjzyDhh/x0scsV4rjncbKDGmPS3FN15a1g97ThmrexOUvjjhuqC8PdnSPqUGG5qH9q93xOCr6F0kz1v+2x3AxF6qb2zBUKbBOFdY72WoAO5lcMZ3v9nCHMLWAsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460279; c=relaxed/simple;
	bh=q14k/3Dk3Qzpjm/hXWRK3baH1mucL2s3WcxFrBik7vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/2gw77ZV+C4nqDym+l72tCOIM9tSah/lCbvuzgXrWXjLTS89ge1DiJr7HGQwQ10LdC8MHnY8Z7jJwCSFQCLUmuvT/NLJXM6hrslBuSTx2DPLb0Nk/Xit0hQsg57ij6u659QJ7M6r/0MeewgRYeEVsIyR3G/o4zSAtTXJtKxzw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFuWpSyn; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-45006bcb482so30955351cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 14:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722460277; x=1723065077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8nvsJL4tDS4LFiSfHzeye4E9b0T3WDdZ2ihW8s1m68=;
        b=nFuWpSynprg7BzGGqq1OKcGCuzwln79VJUOaJ4Xklte/6K0ncrS8ra7Q/oFApD87S3
         n1+H8pUzV6VgNDHtF7fMZolgw1jyBtTLMmk431jIbYt4gCMrZNpT7vOoR/Fyg2qwU8Jo
         pQ7CG04edzWt8fk0mA/6Pmv5Akf98NIc/W+uAv8c2uQWkqzZi5AYK92+VVthgdU9QNBF
         Usnjfj7Qhq/Amfte/neO7TCvLPUYP9KQEYrSuSHcSfWMao5qY+d92fWI7h5oedaxja4d
         jvl7xVcCYG9vLt2myXUM6V0ftXQZrN5L5Bt1vQG8xOXtyY1S358ww5jNelUpnIvEzApP
         nN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722460277; x=1723065077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8nvsJL4tDS4LFiSfHzeye4E9b0T3WDdZ2ihW8s1m68=;
        b=hnUIGawM0UR0T+Yyrx6hXCy1+ZanI+kfexz7KIFNo7WIPCQL4Yr1NW8FHidbZ/saC9
         9Pu/QNZqL/oT9w3vB4SUdOMz/ZSm+KOLFgO5gbI8owRfYNuJyeHCjNw9Qfm+Xi8gDXYT
         sz44t2ZOOdAlKnn0xhJFObn3SUXZXea4TyV3/No4U3tvPM/Q+IrZ2nWA8OjBloMpi5aY
         vrJwovdnmwOcUWaXGU9oHBlqj4eD4UFAIaMnQxFU//E9i5SlZmtgadp+WoyNAXd2a6T9
         LSsd6CR7qqgR4FvNvBYq7Q5+dd4YuxtbiU1mqxvZbaemdqBQhe2b4PvbadU2p7aZqKcz
         mo+w==
X-Gm-Message-State: AOJu0Yzkz30kwflIkdHHhcNq9buzn+va1uUlmimjdZ7VXcMwEjlwMg9O
	LZnMH68QZDd0xo0ylbnWfRIHW5iWxIANNci7kS2jvtJLxHJ3d8ycxHvd/Sy2RYM53A7MxorcMxR
	2ssUNAQyEuPPDkE5fUu1eQhk/Ooo=
X-Google-Smtp-Source: AGHT+IH9EXaEmMoKX4JHzJkvDgGfW67WXCCHADJSDJ1QNC0Swx+7/KO6JmBwwiIkGwOn8FbA1iP6aiINGP1aHWAK+Dg=
X-Received: by 2002:a05:622a:13c7:b0:447:dc38:6942 with SMTP id
 d75a77b69052e-451567c7464mr5932431cf.36.1722460276536; Wed, 31 Jul 2024
 14:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAmZXru_m0B4EEbjNec8s6hNufdAA_+Vpm8DFvC_=EUS270pLw@mail.gmail.com>
In-Reply-To: <CAAmZXru_m0B4EEbjNec8s6hNufdAA_+Vpm8DFvC_=EUS270pLw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 31 Jul 2024 14:11:05 -0700
Message-ID: <CAJnrk1aqGhPKi3_9jXrJ2n_B_Ptb8CC1SecgxFcyCg_zQ8KFGA@mail.gmail.com>
Subject: Re: fuse: slow cp performance with writeback cache enabled
To: Frank Dinoff <fdinoff@google.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:38=E2=80=AFAM Frank Dinoff <fdinoff@google.com> =
wrote:
>
> I have a fuse filesystem with writeback cache enabled. We noticed a slow =
down
> when copying files to the fuse filesystem using cp. The slowdown seems to
> consistently trigger for the first copy but not later ones.
>
> Using passthrough_ll from https://github.com/libfuse/libfuse I was able t=
o
> reproduce the issue.
>
> # start the fuse filesystem
> $ git clone https://github.com/libfuse/libfuse
> $ git checkout fuse-3.16.2
> $ meson build && cd build && ninja
> $ mkdir /tmp/passthrough
> $ ./example/passthrough_ll -o writeback -o debug -f /tmp/passthrough
>
> In another terminal
> $ dd if=3D/dev/urandom of=3D/tmp/foo bs=3D1M count=3D4
> # run this multiple times
> $ time cp /tmp/foo /tmp/passthrough/tmp/foo2
>
> On my machine the first cp call takes between 0.4s and 1s. Repeated cp ca=
lls
> take 0.05s. If you wait long enough between attempts cp becomes slow agai=
n
>
Hi Frank,

I don't think this is an issue on the most up to date versions of the
kernel and libfuse. I'm on top of the fuse tree and libfuse, and I
don't see this slowdown for the first cp. Here's what I'm seeing:

[vmuser@myvm ~]$ dd if=3D/dev/urandom of=3D/tmp/foo bs=3D1M count=3D4
4+0 records in
4+0 records out
4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.0169003 s, 248 MB/s
[vmuser@myvm ~]$ time sudo cp /tmp/foo /tmp/passthrough/tmp/foo2
real    0m0.035s
user    0m0.006s
sys     0m0.008s
[vmuser@myvm ~]$ time sudo cp /tmp/foo /tmp/passthrough/tmp/foo2

real    0m0.026s
user    0m0.004s
sys     0m0.009s


ANd these are the corresponding daemon logs I see:
[vmuser@myvm build]$ sudo  ./example/passthrough_ll -o writeback -o
debug -f /tmp/passthrough
FUSE library version: 3.17.0
unique: 2, opcode: INIT (26), nodeid: 0, insize: 104, pid: 0
INIT: 7.40
flags=3D0x73fffffb
max_readahead=3D0x00020000
lo_init: activating writeback
   INIT: 7.40
   flags=3D0x4041f429
   max_readahead=3D0x00020000
   max_write=3D0x00100000
   max_background=3D0
   congestion_threshold=3D0
   time_gran=3D1
   unique: 2, success, outsize: 80
unique: 4, opcode: LOOKUP (1), nodeid: 1, insize: 44, pid: 658
lo_lookup(parent=3D1, name=3Dtmp)
  1/tmp -> 139767698164736
   unique: 4, success, outsize: 144
unique: 6, opcode: LOOKUP (1), nodeid: 139767698164736, insize: 45, pid: 65=
8
lo_lookup(parent=3D139767698164736, name=3Dfoo2)
   unique: 6, error: -2 (No such file or directory), outsize: 16
unique: 8, opcode: LOOKUP (1), nodeid: 139767698164736, insize: 45, pid: 65=
8
lo_lookup(parent=3D139767698164736, name=3Dfoo2)
   unique: 8, error: -2 (No such file or directory), outsize: 16
unique: 10, opcode: CREATE (35), nodeid: 139767698164736, insize: 61, pid: =
658
lo_create(parent=3D139767698164736, name=3Dfoo2)
  139767698164736/foo2 -> 139767832383168
   unique: 10, success, outsize: 160
unique: 12, opcode: GETXATTR (22), nodeid: 139767832383168, insize: 68, pid=
: 658
   unique: 12, error: -38 (Function not implemented), outsize: 16
unique: 14, opcode: WRITE (16), nodeid: 139767832383168, insize: 131152, pi=
d: 0
lo_write(ino=3D139767832383168, size=3D131072, off=3D0)
   unique: 14, success, outsize: 24
unique: 16, opcode: WRITE (16), nodeid: 139767832383168, insize: 1048656, p=
id: 0
lo_write(ino=3D139767832383168, size=3D1048576, off=3D131072)
   unique: 16, success, outsize: 24
unique: 18, opcode: WRITE (16), nodeid: 139767832383168, insize: 1048656, p=
id: 0
lo_write(ino=3D139767832383168, size=3D1048576, off=3D1179648)
   unique: 18, success, outsize: 24
unique: 20, opcode: WRITE (16), nodeid: 139767832383168, insize: 1048656, p=
id: 0
lo_write(ino=3D139767832383168, size=3D1048576, off=3D2228224)
unique: 22, opcode: WRITE (16), nodeid: 139767832383168, insize: 409680, pi=
d: 0
lo_write(ino=3D139767832383168, size=3D409600, off=3D3276800)
unique: 24, opcode: SETATTR (4), nodeid: 139767832383168, insize: 128, pid:=
 57
   unique: 24, success, outsize: 120
   unique: 22, success, outsize: 24
   unique: 20, success, outsize: 24
unique: 26, opcode: WRITE (16), nodeid: 139767832383168, insize: 507984, pi=
d: 0
lo_write(ino=3D139767832383168, size=3D507904, off=3D3686400)
   unique: 26, success, outsize: 24
unique: 28, opcode: FLUSH (25), nodeid: 139767832383168, insize: 64, pid: 6=
58
   unique: 28, success, outsize: 16
unique: 30, opcode: RELEASE (18), nodeid: 139767832383168, insize: 64, pid:=
 0
   unique: 30, success, outsize: 16
unique: 32, opcode: LOOKUP (1), nodeid: 1, insize: 44, pid: 664
lo_lookup(parent=3D1, name=3Dtmp)
  1/tmp -> 139767698164736
   unique: 32, success, outsize: 144
unique: 34, opcode: LOOKUP (1), nodeid: 139767698164736, insize: 45, pid: 6=
64
lo_lookup(parent=3D139767698164736, name=3Dfoo2)
  139767698164736/foo2 -> 139767832383168
   unique: 34, success, outsize: 144
unique: 36, opcode: OPEN (14), nodeid: 139767832383168, insize: 48, pid: 66=
4
lo_open(ino=3D139767832383168, flags=3D33281)
   unique: 36, success, outsize: 32
unique: 38, opcode: GETATTR (3), nodeid: 139767832383168, insize: 56, pid: =
664
   unique: 38, success, outsize: 120
unique: 40, opcode: WRITE (16), nodeid: 139767832383168, insize: 1048656, p=
id: 0
lo_write(ino=3D139767832383168, size=3D1048576, off=3D0)
unique: 42, opcode: WRITE (16), nodeid: 139767832383168, insize: 1048656, p=
id: 0
lo_write(ino=3D139767832383168, size=3D1048576, off=3D1048576)
   unique: 40, success, outsize: 24
unique: 44, opcode: WRITE (16), nodeid: 139767832383168, insize: 1048656, p=
id: 0
lo_write(ino=3D139767832383168, size=3D1048576, off=3D2097152)
   unique: 42, success, outsize: 24
unique: 46, opcode: WRITE (16), nodeid: 139767832383168, insize: 487504, pi=
d: 0
lo_write(ino=3D139767832383168, size=3D487424, off=3D3145728)
unique: 48, opcode: SETATTR (4), nodeid: 139767832383168, insize: 128, pid:=
 57
   unique: 44, success, outsize: 24
   unique: 46, success, outsize: 24
   unique: 48, success, outsize: 120
unique: 50, opcode: WRITE (16), nodeid: 139767832383168, insize: 561232, pi=
d: 0
lo_write(ino=3D139767832383168, size=3D561152, off=3D3633152)
   unique: 50, success, outsize: 24
unique: 52, opcode: FLUSH (25), nodeid: 139767832383168, insize: 64, pid: 6=
64
   unique: 52, success, outsize: 16
unique: 54, opcode: RELEASE (18), nodeid: 139767832383168, insize: 64, pid:=
 0
   unique: 54, success, outsize: 16

> The debug logs for the slow runs say that the write size is 32k (or small=
er).
> The fast runs have write sizes of 1M. strace says cp is doing writes in 1=
28k
> blocks.
>
> I think I'm running a kernel based on 6.6.15.
>
> Is this a known issue? Is there any fix for this?
>

