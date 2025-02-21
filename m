Return-Path: <linux-fsdevel+bounces-42277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425F0A3FD13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 18:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD98E175B15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8472624CEC4;
	Fri, 21 Feb 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuvSmPgK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6421D5AA1;
	Fri, 21 Feb 2025 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157920; cv=none; b=S1qH0gGt/vwmIlU82coZNmfrn3fsr6ruV/rAfdojc942/RspAbY2+naL0+6UTznfir8Vs0OE4JTIJ58giEVdHnXgiQNjnGGJ81gM29Zo8FAPCa2GzOKxaJlGJlrgRM4hvEAZuUODzTm6fBGC+hpO3A1zxzNjVdnGoLnUFx7b+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157920; c=relaxed/simple;
	bh=nwN6myzfeyIu2xvXyDF1QCWzIO4vL9sS/N1DnP0YTS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MogKtYQT0yiHm1LWsSC9PHL+qFiLS1qy1eivCT88HaFaBZ7hcZzvmRqn+t1Aa1ui8khTfbFTSaoWkQuiuzGCpsfbLwJLnIuVbXviE9kEuD6Na3dlItrfy3o9UQrk8PnfcvFgOjqObqBuCDDgauMs1PTYLBq9o6lb0STlbMX3YUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuvSmPgK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so4311103a12.3;
        Fri, 21 Feb 2025 09:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740157916; x=1740762716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VvZjEAicGEAu2V/A+Vr/ZR3hBpruFRXAWv6NQYbDAw=;
        b=SuvSmPgKwds9g3lO8FxDYmg5PiIXE6Gs6zTVCb+uyHmvU3gkmvE8IuBkSe3fDHnZ/F
         E5xlMIu6FOwPYmo7i4vH6hlUFiYkEXBDP2b2ABN6iazYFYheUCJUU45sLx76aPCPokIT
         1K62JY882WzQ15I3zxE9PJdq0fuWgLJiJBL50QWmocyqeB75Ifd5VjtIE4VdjwczDRAo
         ASkWjQNN+V1MaxeVoVrOofTwRreMbdRA+j+q9CPS7Mv3DWtRfSXhPi+uGtr9CaiyXj4g
         yzDJ1ym8XUhcly/dP9eQ7ZBeURiDjpYMRUpIDOOI2NiFe/MwOwTaCjBkZt8GAPWUJ0Yi
         lxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740157916; x=1740762716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VvZjEAicGEAu2V/A+Vr/ZR3hBpruFRXAWv6NQYbDAw=;
        b=goKz2789eBzj+TGRJoDQZT2E5/VsYBORQJU2MnOMTz+YSITab6DSO3h+5AzQfA06m8
         6ifPRRYqgQU2mx/ZmnBfaGdnQuBR799WPCkW8iYEEIrIPkgAl1XTlkyi9Q0eRpmoyLJ6
         LoGZrf7aClpwpeQCBNAvYORRPzVizuc7btIgzJOMLX9IdWEHlDSB5qzyf3y3XzwHQ9+U
         7+Smq1iTflgt9XiKoZlVj2CAGNwozxY9R+QBGEQEFbyc1Ud2QQCkwmocuXw6baY5cJzp
         CJIFHza3UaQ23fVa1lq+KhiVjZX/r7sOWnpoEkE9If5FxVPU7S22L7H7n7OFpRtybsix
         YJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOrZWOfvpBSpnR1AXYTx8zZWplwvzni1Gfbe+95/gx/q0rK7VoeGpulXe/HrxzSmgnMGmxm0xLzcspa8ILWg==@vger.kernel.org, AJvYcCXBuADTMqF0gkJAYJTvOSU1uyEwX7XfXQMGEyWXgI6gmNOWs7pFirzrUL9rxm54pueXuhfBAHM79m4AoKt9@vger.kernel.org, AJvYcCXudhtCvEig1aKhP4ibu2QEctbct1HiTSOiihbO4799aVwuWkvAQ/7yW9i169W4Iwe6C90ub90uz/m/@vger.kernel.org
X-Gm-Message-State: AOJu0YxBX95Be+rwpwik9i7Gs/J1eZKtc2XiD9eGF+CeXe8T4VOzcgYy
	3A0cSbF/nRhvx9xH3iEPBcl6MXGDXv366yK0kquvYcZ/oszkjeFZlpAYrXp0NNlDWSxaKH8kRWo
	GRPfd5kkyWtR7+T4iN21b86ymffk=
X-Gm-Gg: ASbGncuBZKuvQgfCqgjyrucDIc0+wdXGbr/RBAg7ZqetyE8zTg7pg2aMt9cRNRESSmd
	wSmijuG6bdJ4c680PuWUr8ksj1FmOrkNLi90uoPGIXSIQL/f/q9QmLz5BfJQTYLQlgzIUuzMGvm
	3nMYKBzw4=
X-Google-Smtp-Source: AGHT+IFWIDr9r3hSZMmkqGn1WnTi6P53MVW1MS+O28ff7DJk8k15sH3EeM0ny5DKuivC72nAqqnR7Z0bXLshzgHIgjY=
X-Received: by 2002:a17:907:6e91:b0:abb:eaf3:a815 with SMTP id
 a640c23a62f3a-abc0d9e8682mr366028966b.22.1740157915841; Fri, 21 Feb 2025
 09:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216183432.GA2404@sol.localdomain> <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali> <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <Z7Pjb5tI6jJDlFZn@dread.disaster.area> <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
 <20250218192701.4q22uaqdyjxfp4p3@pali> <Z7UQHL5odYOBqAvo@dread.disaster.area>
 <20250218230643.fuc546ntkq3nnnom@pali> <CAOQ4uxiAU7UorH1FLcPgoWMXMGRsOt77yRQ12Xkmzcxe8qYuVw@mail.gmail.com>
 <20250221163443.GA2128534@mit.edu>
In-Reply-To: <20250221163443.GA2128534@mit.edu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 21 Feb 2025 18:11:43 +0100
X-Gm-Features: AWEUYZlLQE04n-q8OHJUG8ZupYGW8TujYyP8PV2Kh7KAz62EJ87h72ZaT7vwdHU
Message-ID: <CAOQ4uxjwQJiKAqyjEmKUnq-VihyeSsxyEy2F+J38NXwrAXurFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 5:34=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> I think a few people were talking past each other, because there are two
> fileds in struct fileattr --- flags, and fsx_xflags.  The flags field
> is what was originally used by FS_IOC_EXT2_[GS]ETFLAGS, which later
> started getting used by many other file systems, starting with
> resierfs and btrfs, and so it became FS_IOC_[GS]ETFLAGS.  The bits in
> that flags word were both the ioctl ABI and the on-disk encoding, and
> because we were now allowing multiple file systems to allocate bits,
> and we needed to avoid stepping on each other (for example since btrfs
> started using FS_NOCOW_FL, that bit position wouldn't be used by ext4,
> at least not for a publically exported flag).
>
> So we started running out of space in the FS_FLAG_*_FL namespace, and
> that's why we created FS_IOC_[GS]ETXATTR and the struct fsxattr.  The
> FS_XFLAG_*_FL space has plenty of space; there are 14 unassigned bit
> positions, by my count.
>
> As far as the arguments about "proper interface design", as far as
> Linux is concerned, backwards compatibility trumps "we should have
> done if it differently".  The one and only guarantee that we have that
> FS_IOC_GETXATTR followed by FS_IOC_SETXATTR will work.  Nothing else.
>
> The use case of "what if a backup program wants to backup the flags
> and restore on a different file system" is one that hasn't been
> considered, and I don't think any backup programs do it today.  For
> that matter, some of the flags, such as the NODUMP flag, are designed
> to be instructions to a dump/restore system, and not really one that
> *should* be backed up.  Again, the only semantic that was guaranteed
> is GETXATTR or GETXATTR followed by SETXATTR.
>

Thanks for chiming in, Ted!
Notes from the original author of FS_IOC_EXT2_[GS]ETFLAGS
are valuable.

> We can define some new interface for return what xflags are supported
> by a particular file system.  This could either be the long-debated,
> but never implemented statfsx() system call.  Or it could be extending
> what gets returned by FS_IOC_GETXATTR by using one of the fs_pad
> fields in struct fsxattr.  This is arguably the simplest way of
> dealing with the problem.
>

That is also what I think.
fsx_xflags_mask semantics for GET are pretty clear
and follows the established pattern of  stx_attributes_mask
Even if it is not mandatory for userspace, it can be useful.

I asked Dave if he objects to fsx_xflags_mask and got silence,
so IMO, if Pali wants to implement fsx_xflags_mask for the API
I see no reason to resist it.

> I suppose the field could double as the bitmask field when
> FS_IOC_SETXATTR is called, but that just seems to be an overly complex
> set of semantics.  If someone really wants to do that, I wouldn't
> really complain, but then what we would actually call the field
> "flags_supported_on_get_bitmask_on_set" would seem a bit wordy.  :-)

If we follow the old rule of SET after GET should always work
then fsx_xflags_mask will always be a superset of fsx_xflags,
so I think it would be sane to return -EINVAL in the case
of (fsx_xflags_mask && fsx_xflags & ~fsx_xflags_mask),
which is anyway the correct behavior for filesystems when the
user is trying to set flags that the filesystem does not support.

As far as I could see, all in-tree filesystems behave this way
when the user is trying to set unsupported flags either via
FS_IOC_SETFLAGS or via FS_IOC_SETXATTR
except xfs, which ignores unsupported fsx_xflags from
FS_IOC_SETXATTR.

Changing the behavior of xfs to return -EINVAL for unsupported
fsx_xflags if fsx_xflags_mask is non zero is NOT going to break UAPI,
because as everyone keeps saying, the only guarantee from
FS_IOC_SETXATTR was that FS_IOC_SETXATTR after
FS_IOC_GETXATTR works and that guarantee will not be broken.

Thanks,
Amir.

