Return-Path: <linux-fsdevel+bounces-20619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 897FE8D626E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D2FB229E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93163158DA8;
	Fri, 31 May 2024 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXffLcFe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DC1158A2D
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160975; cv=none; b=NQag9WB2bMDAnEU4S41sX4GdzoLeoJZtEWsDPt3AkI2hvi56ViqAMS1c355C85e2ws7foEpyB0CnO8Rj+e4UWUYGwv2X7xex0jbJHjuToZoKrRf273saYri+sqs0rtMHkR67pdo1cksBqSyNezOpBUYDz29OZ6nb3weL1RsyF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160975; c=relaxed/simple;
	bh=SPCfDlovBs05QadYCK+NknY578YWQmtFn0husjGBpDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+D2ZdzZphz4OEHsBlpyZwAramvgNmVS6Vo9ZF5hBxSB9pDZluOsxTHnQ0L0N8we6aeyNhSqUwVWlFOaNh4VAfNpHBMZNl8jp664oZubbUjaRYQA+vOtrEBpxOKmHI3eSA2rkfxx0kAUGnbMdtJKkliJug1sXdOg2t+67FkMF0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXffLcFe; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ad7a2f8715so18612046d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717160971; x=1717765771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpUW3f1Bdd9WhbU+HHykUaBhwPwQ2xDc3WpLb3JeTCk=;
        b=ZXffLcFe7Upt2nshkRP2I7iUzHrLcl/CN563b1HuzZYSp/EB8FK2sVBor+ltTajpvM
         Dz1BOKi3oel/8PdznhXn7UURwIKfJjSeqc5OX84R5BP114CHRZCe7DptaWDmL5ZK5FS3
         DxZhgnXJ0dlLIoBDFjUdEDDug1kbv+SAQdYe4w9BFKg7JjyppEeiXz4eHaAiWmnzVmPT
         S8QZSAmyBCpqlpgft0DduhUd2+CDnZLc5FRdv+rcmZDOdAtIa9Ae5aBtsZdZchRSgweg
         71Xd3GYoDKwL5xkckZiyT/mkAop24hrp9TwBG653pg90pDaq54wPJuHtPOd9Y3PpSQGy
         lTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717160971; x=1717765771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpUW3f1Bdd9WhbU+HHykUaBhwPwQ2xDc3WpLb3JeTCk=;
        b=RR85ESFBJoneHpvLe5Rmj6f1HDsfPzQUowmysgJ3FVU4SfgYH5evW2T1rJUKClPErm
         IllTRM59yJwhFsXU3Vg45o93uM9MJRWZKVLmDu9QmOnOCWbZa4B3qKw2RscOZygsZcbM
         9Va7o7POuDey04+BG3lzYJDgYKjbOch2I8fYK2nLw2P1G8RWLN/pdyIwQdQsoAQCTp9O
         B3d/h54USCz81QF2amLEREE0SRkn5iaND2WvMbfHZAusnEIQ9IGwUw8FXjBuqQTnxlJh
         jviGPA4d+ef1MZ8BRfDoFMAUdDTtTC2U84W61Hk2VNeFrQLaUMNMl24iBrK9r12Tlx34
         Q7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXgOvYtxnC4OK45R3TrIWYYJ2L65nyfMDsiZAzFKMTzpHyTv0TTeT5sVrrmO0nJndetqDdqRJtIB2vUdeYhfh+0vu7Z2QvHz2i12zOKJA==
X-Gm-Message-State: AOJu0YxwA6Xcz/xEshmTT6b3gY+eC/7RH9hIHm+r5g6KdcodWgV7vYKX
	MITCRkz9flBbhrCniAwkqEHJRwBKKP9jdxcKVQ/Iv3hX4lgM4+JPVDahO87A2JzqdZDKb0R8vEg
	GWrevZR9yWjIKzas6ZxhSHu1wYH4=
X-Google-Smtp-Source: AGHT+IGv9yF9ZXP19PhXSY4jx9GDXmJiDF7XU/UqX7Bi3Iccg1m4YwIso6NmRsdvq3PTpbpqbfcM7ZwMaLtiUKmypoI=
X-Received: by 2002:a05:6214:20cb:b0:6ab:7ab4:f309 with SMTP id
 6a1803df08f44-6ae0e768290mr83317166d6.1.1717160970945; Fri, 31 May 2024
 06:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>
 <20240530-atheismus-festland-c11c1d3b7671@brauner> <CAHk-=wg_rw5jNAQ3HUH8FeMvRDFKRGGiyKJ-QCZF7d+EdNenfQ@mail.gmail.com>
 <20240531-ausdiskutiert-wortgefecht-f90dca685f8c@brauner> <20240531-beheben-panzerglas-5ba2472a3330@brauner>
In-Reply-To: <20240531-beheben-panzerglas-5ba2472a3330@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 31 May 2024 16:09:17 +0300
Message-ID: <CAOQ4uxhCkK4H32Y8KQTrg0W3y4wpiiDBAfOs4TPLkRprKgKK3A@mail.gmail.com>
Subject: Re: [PATCH][RFC] fs: add levels to inode write access
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	david@fromorbit.com, hch@lst.de, Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 3:32=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, May 31, 2024 at 12:02:16PM +0200, Christian Brauner wrote:
> > On Thu, May 30, 2024 at 08:49:12AM -0700, Linus Torvalds wrote:
> > > On Thu, 30 May 2024 at 03:32, Christian Brauner <brauner@kernel.org> =
wrote:
> > > >
> > > > Ofc depends on whether Linus still agrees that removing this might =
be
> > > > something we could try.
> > >
> > > I _definitely_ do not want to see any more complex deny_write_access(=
).
> > >
> > > So yes, if people have good reasons to override the inode write
> > > access, I'd rather remove it entirely than make it some eldritch
> > > horror that is even worse than what we have now.
> > >
> > > It would obviously have to be tested in case some odd case actually
> > > depends on the ETXTBSY semantics, since we *have* supported it for a
> > > long time.  But iirc nobody even noticed when we removed it from
> > > shared libraries, so...
> > >
> > > That said, verity seems to depend on it as a way to do the
> > > "enable_verity()" atomically with no concurrent writes, and I see som=
e
> > > i_writecount noise in the integrity code too.

This one is a bit more challenging.
The IMA ima_bprm_check() LSM hook (called from exec_binprm() context)
may read the file (in ima_collect_measurement()) and record the signature
of the file to be executed, assuming that it cannot be modified.
Not sure how to deal with this expectation.

Only thing I could think of is that IMA would be allowed to
deny_write_access() and set FMODE_EXEC_DENY_WRITE
as a hint for do_close_execat() to allow_write_access(), but
it's pretty ugly, I admit.

> > >
> > > But maybe that's just a belt-and-suspenders thing?
> > >
> > > Because if execve() no longer does it, I think we should just remove
> > > that i_writecount thing entirely.
> >
> > deny_write_access() is being used from kernel_read_file() which has a
> > few wrappers around it and they are used in various places:
> >
> > (1) kernel_read_file() based helpers:
> >   (1.1) kernel_read_file_from_path()
> >   (1.2) kernel_read_file_from_path_initns()
> >   (1.3) kernel_read_file_from_fd()
> >
> > (2) kernel_read_file() users:
> >     (2.1) kernel/module/main.c:init_module_from_file()
> >     (2.2) security/loadpin/loadpin.c:read_trusted_verity_root_digests()
> >
> > (3) kernel_read_file_from_path() users:
> >     (3.1) security/integrity/digsig.c:integrity_load_x509()
> >     (3.2) security/integrity/ima/ima_fs.c:ima_read_busy()
> >
> > (4) kernel_read_file_from_path_initns() users:
> >     (4.1) drivers/base/firmware_loader/main.c:fw_get_filesystem_firmwar=
e()
> >
> > (5) kernel_read_file_from_fd() users:
> >     (5.1) kernel/kexec_file.c:kimage_file_prepare_segments()
> >
> > In order to remove i_writecount completely we would need to do this in
>
> Sorry, typo s/i_write_count/deny_write_access()/g
> (I don't think we can remove i_writecount itself as it's used for file
> leases and locks.)

Indeed, i_writecount (as does i_readcount) is used by fs/locks.c:
check_conflicting_open(), but not as a synchronization primitive.

>
> > multiple steps as some of that stuff seems potentially sensitive.
> >
> > The exec deny write mechanism can be removed because we have a decent
> > understanding of the implications and there's decent justification for
> > removing it.
> >
> > So I propose that I do various testing (LTP) etc. now, send the patch
> > and then put this into -next to see if anything breaks?

Wouldn't hurt to see what else we are missing.

Thanks,
Amir.

