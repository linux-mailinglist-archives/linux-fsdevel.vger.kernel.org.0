Return-Path: <linux-fsdevel+bounces-40685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C383EA2677D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 00:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD7E7A3517
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8CF212FA8;
	Mon,  3 Feb 2025 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ21Lo7M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A525212B3A;
	Mon,  3 Feb 2025 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623784; cv=none; b=vEA8A3OEjyA0p/kxYFOvcV5Fn6kPAhaFL/k62HdeWXdmPtqcCun8OKjJk5ekZ0uvlbXe0p+vLvVNKF6kxWuh7VzBRo6edMcBRESgL/9LZziGVhJpfya8roBnbyx4S8qe8gOzttY84YVc4yMOWXCLtmiyXshX8NfP7+KszA4S7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623784; c=relaxed/simple;
	bh=EjOexnXMgQJzxYHOLu3OeempPRS8bOp4JLgbpD0HMsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wslg4hCULt/oM0BqXghHibx0L8DAlI2sYJs+34P+d1Fuuv3EOnejZXV8wICIbyCbjG5djEIkY5+qY+uHTYeouypt/4m9j6GMuJcy4mIkZCzHqAWn/31k1zkVc5pT8t2MeiVoMcP4540MhpMNMX3aTqhPYFeVBUTVADs7zFezm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ21Lo7M; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso7102368a12.0;
        Mon, 03 Feb 2025 15:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738623776; x=1739228576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBdmQ5wtRHJ8W3Dokaw4p9hk2ntwY4Hw01yfpGgGPh4=;
        b=NZ21Lo7MAVI7/0nJ6I3NyNLWbZxoJ2fXWlrubAlHF/vBTZJfX3LOa0TPeoNMuySG9u
         0D2LjDGPRj9ZZeJlxbLZ1OQ2A9yzVkKkhuI/8vOW7jrU65p9Ljy2tJeMIKFoEi3i1WIX
         9PVRffVDSpztjCJGcetiem3o+7ZHPOfzLpKOIAwbaZ/1xoF3IuYl4U89ZO3RxZAjfXZY
         Cj5jGfCHKCwRStEIyJnLktTxKd9cUYSRb+vhpkKbG/F9HqGxp3Ro7qIQJ6l8Rp/Zy83O
         sW9shQVScNIDnYbQSdY8Cha+XcL2eAFGqKMkpfxRsaSW15n03yWzjrxcx/cLfpgMwm2Y
         ek/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738623776; x=1739228576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBdmQ5wtRHJ8W3Dokaw4p9hk2ntwY4Hw01yfpGgGPh4=;
        b=gabDpctxJM7qvUP9QAcrOxt2XdmpRXpVoVMOAMg1Z1QG9vKfafp5SwbW7W4gbIZdFM
         Qyc2OTu7+Mk8PBRDzytJGv7HU/6uDNjIRFnUB7w0KBWxbIYgie3rn+9bhd93edONzHhv
         SpbWP8OmMVl3OcjGWf6Yb+d+lK7xwl5Vao0FviEnNNngUS04mNblMFclZaC2BFjuPmQg
         lCyVkLamAZGbuBEHCCFj4GdrSJvHSOLCZOs/xE9w5FZ/3cIoGV3KVn1P0ZR5HxyIzSgd
         v/E9EoKCRJgeD2iY+oPwPRdpCnG6eRsEbvJsrd7qmh9ja44OJfJQgb6ALbi6XwIDdlR/
         rseg==
X-Forwarded-Encrypted: i=1; AJvYcCW2sJH2Mpvo1u6SBOT15JTHKkHa3Sf+fxzEDESGROL8If1iiH25xBfLpK3JjDKggz4px9hTg2OiAda5@vger.kernel.org, AJvYcCXQ4lvwSvFw7RE1lN18NZEO3s6pcypSEyOslgZvGPbv8kubaa0j/jFci3qhZaBlZpoFQ40EF3EF9r9Tx6yBdg==@vger.kernel.org, AJvYcCXW/ecjcjqpCAVF+3hmlnNkYcH7/B3Lb9nBBA4Oul+d9CCLzN56kPI0y9PfHAEdU4mBkvtXJ8LImQr6LFUg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/E2VJS6ot8UPCnvfCRXHvT0kLKPDGTtU00Rljfefod3AeXDt
	r90ts7hbZSnm6tgR+qksSugxdkFy+x6kSGiJqr6kZe/AE+DoHuj7rR01ae5HMhCyQ8b/KHPav3f
	klCKSIGceCnAQsSZcwh0Q+CLmJgg=
X-Gm-Gg: ASbGncs2HlrfKIrTK9edlUW7JKzOnMVLUaSa6NmydlGk/uYgu5bFFiNM/R4P31zED1u
	7t7ypIchcTRxaXvYRvzF73CzxYE0YsuqsjKbJGf1VtxWxPveyaVZJfnzjAGabHgfLxZXSZu8k
X-Google-Smtp-Source: AGHT+IGgP4sJZkbGL8t2nWMqhmaVSSoUQdeHG+eSyBSt3KQAtZyiCq3bIwAca8RXUKXL88AmRHbSP8gtBq5IrmNLFpA=
X-Received: by 2002:a05:6402:a001:b0:5dc:7374:261d with SMTP id
 4fb4d7f45d1cf-5dc737427bfmr36454533a12.7.1738623775777; Mon, 03 Feb 2025
 15:02:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114215350.gkc2e2kcovj43hk7@pali> <CAN05THSXjmVtvYdFLB67kKOwGN5jsAiihtX57G=HT7fBb62yEw@mail.gmail.com>
 <20250114235547.ncqaqcslerandjwf@pali> <20250114235925.GC3561231@frogsfrogsfrogs>
 <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com>
 <20250117173900.GN3557553@frogsfrogsfrogs> <CAOQ4uxhh1LDz5zXzqFENPhJ9k851AL3E7Xc2d7pSVVYX4Fu9Jw@mail.gmail.com>
 <20250117185947.ylums2dhmo3j6hol@pali> <20250202152343.ahy4hnzbfuzreirz@pali>
 <CAOQ4uxgjbHTyQ53u=abWhyQ81ATL4cqSeWKDfOjz-EaR0NGmug@mail.gmail.com> <20250203221955.bgvlkp273o3wnzmf@pali>
In-Reply-To: <20250203221955.bgvlkp273o3wnzmf@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Feb 2025 00:02:44 +0100
X-Gm-Features: AWEUYZnOwZ4U1beNz39Ac2tUKLBO7cnKL8_kgLUmUrLVb43HdIN1Xm7feEx8ftQ
Message-ID: <CAOQ4uxhkB6oTJm7DvQxFbxkQ1u_KMUFEL0eWKVYf39hnuYrnfQ@mail.gmail.com>
Subject: Re: Immutable vs read-only for Windows compatibility
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 11:20=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> On Monday 03 February 2025 22:59:46 Amir Goldstein wrote:
> > On Sun, Feb 2, 2025 at 4:23=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org=
> wrote:
> > > And there is still unresolved issue with FILE_ATTRIBUTE_READONLY.
> > > Its meaning is similar to existing Linux FS_IMMUTABLE_FL, just
> > > FILE_ATTRIBUTE_READONLY does not require root / CAP_LINUX_IMMUTABLE.
> > >
> > > I think that for proper support, to enforce FILE_ATTRIBUTE_READONLY
> > > functionality, it is needed to introduce new flag e.g.
> > > FS_IMMUTABLE_FL_USER to allow setting / clearing it also for normal
> > > users without CAP_LINUX_IMMUTABLE. Otherwise it would be unsuitable f=
or
> > > any SMB client, SMB server or any application which would like to use
> > > it, for example wine.
> > >
> > > Just to note that FreeBSD has two immutable flags SF_IMMUTABLE and
> > > UF_IMMUTABLE, one settable only by superuser and second for owner.
> > >
> > > Any opinion?
> >
> > For filesystems that already support FILE_ATTRIBUTE_READONLY,
> > can't you just set S_IMMUTABLE on the inode and vfs will do the correct
> > enforcement?
> >
> > The vfs does not control if and how S_IMMUTABLE is set by filesystems,
> > so if you want to remove this vfs flag without CAP_LINUX_IMMUTABLE
> > in smb client, there is nothing stopping you (I think).
>
> Function fileattr_set_prepare() checks for CAP_LINUX_IMMUTABLE when
> trying to change FS_IMMUTABLE_FL bit. This function is called from
> ioctl(FS_IOC_SETFLAGS) and also from ioctl(FS_IOC_FSSETXATTR).
> And when function fileattr_set_prepare() fails then .fileattr_set
> callback is not called at all. So I think that it is not possible to
> remove the IMMUTABLE flag from userspace without capability for smb
> client.
>

You did not understand what I meant.

You cannot relax the CAP_LINUX_IMMUTABLE for setting FS_IMMUTABLE_FL
and there is no reason that you will need to relax it.

The vfs does NOT enforce permissions according to FS_IMMUTABLE_FL
The vfs enforces permissions according to the S_IMMUTABLE in-memory
inode flag.

There is no generic vfs code that sets S_IMMUTABLE inode flags, its
the filesystems that translate the on-disk FS_IMMUTABLE_FL to
in-memory S_IMMUTABLE inode flag.

So if a filesystem already has an internal DOSATTRIB flags set, this
filesystem can set the in-memory S_IMMUTABLE inode flag according
to its knowledge of the DOSATTRIB_READONLY flag and the
CAP_LINUX_IMMUTABLE rules do not apply to the DOSATTRIB_READONLY
flag, which is NOT the same as the FS_IMMUTABLE_FL flag.

> And it would not solve this problem for local filesystems (ntfs or ext4)
> when Samba server or wine would want to set this bit.
>

The Samba server would use the FS_IOC_FS[GS]ETXATTR ioctl
API to get/set dosattrib, something like this:

struct fsxattr fsxattr;
ret =3D ioctl_get_fsxattr(fd, &fsxattr);
if (!ret && fsxattr.fsx_xflags & FS_XFLAG_HASDOSATTR) {
    fsxattr.fsx_dosattr |=3D FS_DOSATTRIB_READONLY;
    ret =3D ioctl_set_fsxattr(fd, &fsxattr);
}

For ntfs/ext4, you will need to implement on-disk support for
set/get the dosattrib flags.

I can certainly not change the meaning of existing on-disk
flag of FS_IMMUTABLE_FL to a flag that can be removed
without CAP_LINUX_IMMUTABLE. that changes the meaning
of the flag.

If ext4 maintainers agrees, you may be able to reuse some
old unused on-disk flags (e.g.  EXT4_UNRM_FL) as storage
place for FS_DOSATTRIB_READONLY, but that would be
quite hackish.

> > How about tackling this one small step at a time, not in that order
> > necessarily:
> >
> > 1. Implement the standard API with FS_IOC_FS[GS]ETXATTR ioctl
> >     and with statx to get/set some non-controversial dosattrib flags on
> >     ntfs/smb/vfat
> > 2. Wire some interesting dosattrib flags (e.g. compr/enrypt) to local
> >     filesystems that already support storing those bits
> > 3. Wire network servers (e.g. Samba) to use the generic API if supporte=
d
> > 4. Add on-disk support for storing the dosattrib flags to more local fs
> > 5. Update S_IMMUTABLE inode flag if either FS_XFLAG_IMMUTABLE
> >     or FS_DOSATTRIB_READONLY are set on the file
> >
> > Thoughts?
> >

Anything wrong with the plan above?
It seems that you are looking for shortcuts and I don't think that
it is a good way to make progress.

Thanks,
Amir.

