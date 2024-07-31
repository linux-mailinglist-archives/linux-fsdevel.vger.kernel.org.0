Return-Path: <linux-fsdevel+bounces-24711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08986943814
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 23:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4A11C21AC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 21:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F208016C6B0;
	Wed, 31 Jul 2024 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIRpDcLH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912212F37
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461734; cv=none; b=WaBnzPpkT48Q7DZeb11FiLKumLT77aZyc/SxnlblofeQZalIo/L87Q+4J69hMdt9za97QIHFKnHAeQcKEYzESVixMpaUwQutbktw768l6FBfzY8MHFe9j3xs7k7BTaQCMIeYIDSTUA2NavwgQIWjCtkgWKAsKvykrrE/yHhneFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461734; c=relaxed/simple;
	bh=kBpPtVn4WoIbogHJ58hVOQLkgI+5OR+avtjTyVFIqV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE55Qg56dSm3C5i//ZXwDhjp5qakAPnZLVTyQsGUeKVpjqaQAMYD/gGrG1KWMQOsZVHg3r8RT/rV957JeJjBTlw79TRW20of5tjG7ruDwMdfRLfmLxo55gsSR1VclOc/MeTSX5R/mNBhUxGSYBQUhAZib+3mpbejSJy6yUc176w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIRpDcLH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aac70e30dso771661266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722461730; x=1723066530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W12N6LHX7sIMZ/Pj0VYVgcfa6B2i8LosD2F9EKMiNOM=;
        b=ZIRpDcLH8ZHgBJLsyEm7NTOVRhgGSkT396Y6LWNIzkOJ15L/3/GRDZeZOUQny0B4JP
         Qk4fwTRjhBs6ZgBIh7xqwGT5k4VkGsF6I1j/dAqnbrsdG0KfDijc3r+95EiZOf7t5dzi
         id40BZVsy064XKE3qmCKaZhwngqURrrKKPdwBMj/ZZsct3vPvhyq0UtycEzWjkWVTWiA
         Fv+oLpJTWhBJQTIoOhp1NgAVZUZKFcloM+AJpSvOO2GqoYWmXcg9M52WyDvcQwX9EG9R
         YZsP3idi7x+Uu+9aK3qY130stahnW9jxOfh1hiIW5XiWUW3KCE+yMxllTCAIq5pyW/8h
         FHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722461730; x=1723066530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W12N6LHX7sIMZ/Pj0VYVgcfa6B2i8LosD2F9EKMiNOM=;
        b=NTNfeK6oF50Jk8qv2iYw6JrUr5xoaLzzRNKOqPmCRmNu9j0N1joCMPk9/dtD58+YDy
         sCNBD1i/SSAVImHlmByvPQg28zVK3LLRCeDASI4hkas0BHfDErcQNHLdWFjxv2Zpu+LA
         0QfEEXCH0af6l1M4NAV4DForjQyvwVS7hI6sCsT/KUTsNgJW6m5atlDkCy8VE4Ejisje
         3Q/fVFuwCTjUVClwLhzy7+y5YbuKyRcISsCAuGPwPsfLwQPBFwB0hQh1svgBcmyJzyl2
         Xa9mVEHDd5l6aJexm2FR5qCAq3Y9SeHVQ4rj9bNcPtvXk4KEWYG5Xd/fssRfja53Azwd
         biUQ==
X-Gm-Message-State: AOJu0YzsH3DGP8ZYMrpjhwFbG1HJzwsDemCYLetHvrcHfkrNkjTxTPwS
	Z/rIKxuq4HJrww2FQSwR2GjDwEez/Tr1mVNjiXQSV+5R3+CQV1kA7kn3JtCdiMiL9HnTAh/sSKk
	uXVmW5Z017M4Pv9rN8Kh6nVDtBIne6mU/g3Gaqx10jKnmAIjj9GsamdMMhosKPKFY4yqp/Elx4n
	O2LYc+g/T3w5hIVCsJ4lw/C50fG6mpzafH6XiT/ND/
X-Google-Smtp-Source: AGHT+IEyviaDUBvHfIwlNt/TbriWGdOMYYUe+u4Y3yeXdjDr50rxNJ+fjKy3syRXRpP/nCplOQrc03U1vXXuoIr+HFg=
X-Received: by 2002:a17:907:a686:b0:a7a:b977:4c9e with SMTP id
 a640c23a62f3a-a7daf537eb8mr27987666b.21.1722461729275; Wed, 31 Jul 2024
 14:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAmZXru_m0B4EEbjNec8s6hNufdAA_+Vpm8DFvC_=EUS270pLw@mail.gmail.com>
 <CAJnrk1aqGhPKi3_9jXrJ2n_B_Ptb8CC1SecgxFcyCg_zQ8KFGA@mail.gmail.com>
In-Reply-To: <CAJnrk1aqGhPKi3_9jXrJ2n_B_Ptb8CC1SecgxFcyCg_zQ8KFGA@mail.gmail.com>
From: Frank Dinoff <fdinoff@google.com>
Date: Wed, 31 Jul 2024 17:35:12 -0400
Message-ID: <CAAmZXrtnbX6Pb3hmEEL06cEQEswk-xsgs_2+NMNun8HS7MTZhQ@mail.gmail.com>
Subject: Re: fuse: slow cp performance with writeback cache enabled
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ccpol: medium

Great thanks for checking. I'll go figure out how to upgrade the kernel and=
 the
version of libfuse we are using.


On Wed, Jul 31, 2024 at 5:11=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Jul 31, 2024 at 11:38=E2=80=AFAM Frank Dinoff <fdinoff@google.com=
> wrote:
> >
> > I have a fuse filesystem with writeback cache enabled. We noticed a slo=
w down
> > when copying files to the fuse filesystem using cp. The slowdown seems =
to
> > consistently trigger for the first copy but not later ones.
> >
> > Using passthrough_ll from https://github.com/libfuse/libfuse I was able=
 to
> > reproduce the issue.
> >
> > # start the fuse filesystem
> > $ git clone https://github.com/libfuse/libfuse
> > $ git checkout fuse-3.16.2
> > $ meson build && cd build && ninja
> > $ mkdir /tmp/passthrough
> > $ ./example/passthrough_ll -o writeback -o debug -f /tmp/passthrough
> >
> > In another terminal
> > $ dd if=3D/dev/urandom of=3D/tmp/foo bs=3D1M count=3D4
> > # run this multiple times
> > $ time cp /tmp/foo /tmp/passthrough/tmp/foo2
> >
> > On my machine the first cp call takes between 0.4s and 1s. Repeated cp =
calls
> > take 0.05s. If you wait long enough between attempts cp becomes slow ag=
ain
> >
> Hi Frank,
>
> I don't think this is an issue on the most up to date versions of the
> kernel and libfuse. I'm on top of the fuse tree and libfuse, and I
> don't see this slowdown for the first cp. Here's what I'm seeing:
>
> [vmuser@myvm ~]$ dd if=3D/dev/urandom of=3D/tmp/foo bs=3D1M count=3D4
> 4+0 records in
> 4+0 records out
> 4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.0169003 s, 248 MB/s
> [vmuser@myvm ~]$ time sudo cp /tmp/foo /tmp/passthrough/tmp/foo2
> real    0m0.035s
> user    0m0.006s
> sys     0m0.008s
> [vmuser@myvm ~]$ time sudo cp /tmp/foo /tmp/passthrough/tmp/foo2
>
> real    0m0.026s
> user    0m0.004s
> sys     0m0.009s
>
>
> ANd these are the corresponding daemon logs I see:
> [vmuser@myvm build]$ sudo  ./example/passthrough_ll -o writeback -o
> debug -f /tmp/passthrough
> FUSE library version: 3.17.0
> unique: 2, opcode: INIT (26), nodeid: 0, insize: 104, pid: 0
> INIT: 7.40
> flags=3D0x73fffffb
> max_readahead=3D0x00020000
> lo_init: activating writeback
>    INIT: 7.40
>    flags=3D0x4041f429
>    max_readahead=3D0x00020000
>    max_write=3D0x00100000
>    max_background=3D0
>    congestion_threshold=3D0
>    time_gran=3D1
>    unique: 2, success, outsize: 80
> unique: 4, opcode: LOOKUP (1), nodeid: 1, insize: 44, pid: 658
> lo_lookup(parent=3D1, name=3Dtmp)
>   1/tmp -> 139767698164736
>    unique: 4, success, outsize: 144
> unique: 6, opcode: LOOKUP (1), nodeid: 139767698164736, insize: 45, pid: =
658
> lo_lookup(parent=3D139767698164736, name=3Dfoo2)
>    unique: 6, error: -2 (No such file or directory), outsize: 16
> unique: 8, opcode: LOOKUP (1), nodeid: 139767698164736, insize: 45, pid: =
658
> lo_lookup(parent=3D139767698164736, name=3Dfoo2)
>    unique: 8, error: -2 (No such file or directory), outsize: 16
> unique: 10, opcode: CREATE (35), nodeid: 139767698164736, insize: 61, pid=
: 658
> lo_create(parent=3D139767698164736, name=3Dfoo2)
>   139767698164736/foo2 -> 139767832383168
>    unique: 10, success, outsize: 160
> unique: 12, opcode: GETXATTR (22), nodeid: 139767832383168, insize: 68, p=
id: 658
>    unique: 12, error: -38 (Function not implemented), outsize: 16
> unique: 14, opcode: WRITE (16), nodeid: 139767832383168, insize: 131152, =
pid: 0
> lo_write(ino=3D139767832383168, size=3D131072, off=3D0)
>    unique: 14, success, outsize: 24
> unique: 16, opcode: WRITE (16), nodeid: 139767832383168, insize: 1048656,=
 pid: 0
> lo_write(ino=3D139767832383168, size=3D1048576, off=3D131072)
>    unique: 16, success, outsize: 24
> unique: 18, opcode: WRITE (16), nodeid: 139767832383168, insize: 1048656,=
 pid: 0
> lo_write(ino=3D139767832383168, size=3D1048576, off=3D1179648)
>    unique: 18, success, outsize: 24
> unique: 20, opcode: WRITE (16), nodeid: 139767832383168, insize: 1048656,=
 pid: 0
> lo_write(ino=3D139767832383168, size=3D1048576, off=3D2228224)
> unique: 22, opcode: WRITE (16), nodeid: 139767832383168, insize: 409680, =
pid: 0
> lo_write(ino=3D139767832383168, size=3D409600, off=3D3276800)
> unique: 24, opcode: SETATTR (4), nodeid: 139767832383168, insize: 128, pi=
d: 57
>    unique: 24, success, outsize: 120
>    unique: 22, success, outsize: 24
>    unique: 20, success, outsize: 24
> unique: 26, opcode: WRITE (16), nodeid: 139767832383168, insize: 507984, =
pid: 0
> lo_write(ino=3D139767832383168, size=3D507904, off=3D3686400)
>    unique: 26, success, outsize: 24
> unique: 28, opcode: FLUSH (25), nodeid: 139767832383168, insize: 64, pid:=
 658
>    unique: 28, success, outsize: 16
> unique: 30, opcode: RELEASE (18), nodeid: 139767832383168, insize: 64, pi=
d: 0
>    unique: 30, success, outsize: 16
> unique: 32, opcode: LOOKUP (1), nodeid: 1, insize: 44, pid: 664
> lo_lookup(parent=3D1, name=3Dtmp)
>   1/tmp -> 139767698164736
>    unique: 32, success, outsize: 144
> unique: 34, opcode: LOOKUP (1), nodeid: 139767698164736, insize: 45, pid:=
 664
> lo_lookup(parent=3D139767698164736, name=3Dfoo2)
>   139767698164736/foo2 -> 139767832383168
>    unique: 34, success, outsize: 144
> unique: 36, opcode: OPEN (14), nodeid: 139767832383168, insize: 48, pid: =
664
> lo_open(ino=3D139767832383168, flags=3D33281)
>    unique: 36, success, outsize: 32
> unique: 38, opcode: GETATTR (3), nodeid: 139767832383168, insize: 56, pid=
: 664
>    unique: 38, success, outsize: 120
> unique: 40, opcode: WRITE (16), nodeid: 139767832383168, insize: 1048656,=
 pid: 0
> lo_write(ino=3D139767832383168, size=3D1048576, off=3D0)
> unique: 42, opcode: WRITE (16), nodeid: 139767832383168, insize: 1048656,=
 pid: 0
> lo_write(ino=3D139767832383168, size=3D1048576, off=3D1048576)
>    unique: 40, success, outsize: 24
> unique: 44, opcode: WRITE (16), nodeid: 139767832383168, insize: 1048656,=
 pid: 0
> lo_write(ino=3D139767832383168, size=3D1048576, off=3D2097152)
>    unique: 42, success, outsize: 24
> unique: 46, opcode: WRITE (16), nodeid: 139767832383168, insize: 487504, =
pid: 0
> lo_write(ino=3D139767832383168, size=3D487424, off=3D3145728)
> unique: 48, opcode: SETATTR (4), nodeid: 139767832383168, insize: 128, pi=
d: 57
>    unique: 44, success, outsize: 24
>    unique: 46, success, outsize: 24
>    unique: 48, success, outsize: 120
> unique: 50, opcode: WRITE (16), nodeid: 139767832383168, insize: 561232, =
pid: 0
> lo_write(ino=3D139767832383168, size=3D561152, off=3D3633152)
>    unique: 50, success, outsize: 24
> unique: 52, opcode: FLUSH (25), nodeid: 139767832383168, insize: 64, pid:=
 664
>    unique: 52, success, outsize: 16
> unique: 54, opcode: RELEASE (18), nodeid: 139767832383168, insize: 64, pi=
d: 0
>    unique: 54, success, outsize: 16
>
> > The debug logs for the slow runs say that the write size is 32k (or sma=
ller).
> > The fast runs have write sizes of 1M. strace says cp is doing writes in=
 128k
> > blocks.
> >
> > I think I'm running a kernel based on 6.6.15.
> >
> > Is this a known issue? Is there any fix for this?
> >

