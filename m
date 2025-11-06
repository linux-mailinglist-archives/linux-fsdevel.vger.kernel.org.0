Return-Path: <linux-fsdevel+bounces-67305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA3BC3B1BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 14:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30FD2504CA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 13:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3A033A011;
	Thu,  6 Nov 2025 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b="XCnvIaXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3BB338F56
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433988; cv=none; b=lJuK9BrDOb8dWbLgGUIHFCOm72wKoOgxpFZuwJMeBZ6hYGrVFVReXqr+7ZHJggudQd4HX2hSHCcKdy06xhaqWiCyTFIuYCFpEun90q9nX/D2hF2o3y+0TTNNs8ZisLLXs2GnsCHho+kmiYSD3QoHHPTAEfKXjhcPZMxpkDcqgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433988; c=relaxed/simple;
	bh=nGDu2A5rVbXVmYLIW2PMvtSEOjriMXzsvoo9MB/FQLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmUJpZeiYUAxYsEl6Sqwku8pa+Jr7ovZDWwS7mLm+GD5Z3rG3E2Ve3S3PNhrUbLiRsRU9c9ToMMKV6UWQp0Z/eMMwW3X9ERy0x3xyhqc1BGOYnEQW7ulVwtwpn2UucEwN4GkGwzl0AFvLzsqGgI4I+hYfTF3cnuk/112fDsMCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe; spf=pass smtp.mailfrom=snai.pe; dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b=XCnvIaXF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snai.pe
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so1350870a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 04:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snai.pe; s=snai.pe; t=1762433984; x=1763038784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nGDu2A5rVbXVmYLIW2PMvtSEOjriMXzsvoo9MB/FQLE=;
        b=XCnvIaXFgQsD8o6nwEn9wHLSmPlhCFxhlj+kzLFb0oazuVgzi1v4VZpwRPm/tM+5QJ
         ljoqVkY/LTB5mFopHu5ckeaw0Xz72u++IfWahhzFx2Tob86iTnkkc9N84YCNz69ToBzu
         32J17yi5z2bO3J7lpf3pn0bzGXIxR9ETQ+L3PhMUb9fcNGQTNRhI9jjz4x3xFM0NvWkn
         SJ4Te/Lm+Q4YEFnqN9xm7fkXJwFPiRqu6RpZPrV56FCjN8nys/wVPgnL7tnfoEDuOXTp
         b2G+z+Ng4IkZeS4GcEx6Hc+p72wHokp5F7onmQatKe5TFuO/DjRn2w2+/eE96lvp80oV
         VzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433984; x=1763038784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGDu2A5rVbXVmYLIW2PMvtSEOjriMXzsvoo9MB/FQLE=;
        b=g7hP0PjVRBDT2uOWN3QKd5ggOzkAi50PU61nvoyLpov1D65nKf/lFKWApzRUGtXFyy
         kcxlNgVhN0fgz3AA6pwgC/PyiNcIaevdnjZLBo2tuCXMg6x74W0nRGKf94+AgrLTYLT6
         cv2r2Awn4RUSHaJ0uoMLTHYu9k09FNjjs6O1ah6vQ4vPrdcLpFWj4sZ+2PjQGbtHtLsn
         3agnruIMRj5RQBmMxBm03CKqPWquRlIAnbbTlaLlpOOjqs1z4uLEHxIfU8O8T36Yg9Di
         l/ncmM4YKHi5MnSPFKiL9K5P1oFmeK+p699TcLbFMAwFcTFOP1ednLAtxzsCR45YU+GT
         jWgQ==
X-Gm-Message-State: AOJu0YwGhXFNrlobGGyyO5TpCOXjX624IrqTCoQ9PYv/uGJRl4+Rn23u
	Oo7Vmf8oILrhqrFyOaaOuROQfDxXum/ewYULahZ7OMO8NG5/AWt3u0taRXFk65sHIveqPzQ9w7P
	fVRMkPcDAEoSVu9dTLbYjVrrPmejSTsx8wcL9vbYbhg==
X-Gm-Gg: ASbGncvox4xmS5WzCsz5OIweU9dEbTuJlfo6kaIZEVdvvNEoEwkiDtSHU8ktip2j4Nt
	fIeNXTjSF9RFmMUw630TPXx8yhDt/lQ4njBBUAORmjWwVwVxJQCGRFy4c7eNGfkhmJ0txsR5ZZv
	NY76kMJpL+MyqBffzc1Zh65gmrKFxV+JDfF55J9Wv/Pu1XsgQ7TUqYmsw+r1oeGxeESeoymAncJ
	N2XHw1eKJqyuykPHJWpscrcR9uH1eW5xZ5UBHR37OdwNte/T0twsWD71lxmZ+MmaDtbDL4=
X-Google-Smtp-Source: AGHT+IEVlH32VombqCLpBjRg4Y4g4prA8J70P7usQ2bkdUG3rpRLH9CbMRLKYAd16kI+WKP5jTSNHL+zyW7VX0CPCo8=
X-Received: by 2002:a05:6402:4399:b0:639:f49b:9264 with SMTP id
 4fb4d7f45d1cf-641058b3290mr6558715a12.9.1762433983954; Thu, 06 Nov 2025
 04:59:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACyTCKhcoetvvokawDc4EsKwJcEDaLgmtXyb1gvqD59NNgh=_A@mail.gmail.com>
 <20251105-rotwild-wartung-e0c391fe559a@brauner>
In-Reply-To: <20251105-rotwild-wartung-e0c391fe559a@brauner>
From: Snaipe <me@snai.pe>
Date: Thu, 6 Nov 2025 13:59:06 +0100
X-Gm-Features: AWmQ_blN-e1fwaJamhmQNeZ--ntk3af56cGSR-9mCKLG0Efs8frQtOH1rhqgzzc
Message-ID: <CACyTCKjojw0M=9NEzTpASd+OhgaPxU4hFRV2c6GEDFLZ8K2bWw@mail.gmail.com>
Subject: Re: open_tree, and bind-mounting directories across mount namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/mixed; boundary="0000000000008e05000642eca3d5"

--0000000000008e05000642eca3d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 1:05=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Sat, Nov 01, 2025 at 12:01:38AM +0100, Snaipe wrote:
> > Hi folks,
> >
> > (Disclaimer: I'm not a kernel developer)
> >
> > I'm currently playing around with the new mount API, on Linux 6.17.6.
> > One of the things I'm trying to do is to write a program that unshares
> > its mount namespace and receives a directory file descriptor via an
> > unix socket from another program that exists in a different mount
> > namespace. The intent is to have a program that has access to data on
> > a filesystem that is not normally accessible to other unprivileged
> > programs, and have that program give access to select directories by
> > opening them with O_PATH and sending the fds over a unix socket.
> >
> > One snag I'm currently hitting is that once I call open_tree(fd, "",
> > OPEN_TREE_CLONE|AT_EMPTY_PATH|AT_RECURSIVE), the syscall returns
> > EINVAL; I've bpftraced it back to __do_loopback's may_copy_tree check
> > and it looks like it's impossible to do on dentries whose mount
> > namespace is different that the current task's mount namespace.
> >
> > I'm trying to understand the reasons this was put in place, and what
> > it would take to enable the kind of use-case that I have. Would there
> > be a security risk to relax this condition with some kind of open_tree
> > flag?
>
> In principle it's doable just like I made statmount() and listmount()
> allow you to operate across mount namespaces.
>
> If we do this I don't think we need a new flag as in your new example.
> We just need open_tree() to support being called on foreign mounts
> provided the caller is privileged over the target mount namespace and it
> needs a consistent permission model and loads of tests. So no flags
> needed imho.

To clarify: is the target mount ns here is the mount ns of the caller
of open_tree, or is it the mount namespace of the specified tree?

The former is what I'd expect already (and should be covered by the
current permission check); the latter would make it very difficult for
a process that has called unshare(CLONE_NEWUSER | CLONE_NEWNS) to
receive file descriptors from a parent process (or processes in other
mount namespaces) and mount them, since it would not hold privileges
over the other process' mount namespace.

I've attached an example program of what I'm looking for: a parent
forking a child, where the child unshares the user and mount ns,
receives a file descriptor (for /tmp) from the parent, and bind-mounts
(onto /mnt) it in its own namespace.

>
> I can start looking into this next week or you can give it your own
> shot.

Thanks Christian; I think you have more context than me to be able to
do something better here. I might give it a shot if I get more time on
this in a couple of weeks if you haven't already by that time.

--=20
Franklin "Snaipe" Mathieu

--0000000000008e05000642eca3d5
Content-Type: text/x-csrc; charset="US-ASCII"; name="test.c"
Content-Disposition: attachment; filename="test.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mhnfn8uo0>
X-Attachment-Id: f_mhnfn8uo0

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8ZXJyLmg+CiNpbmNsdWRlIDxmY250bC5oPgoj
aW5jbHVkZSA8bGludXgvcHJjdGwuaD4KI2luY2x1ZGUgPHNjaGVkLmg+CiNpbmNsdWRlIDxzdGRs
aWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL21vdW50Lmg+CiNpbmNsdWRl
IDxzeXMvcHJjdGwuaD4KI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUgPHN5cy93YWl0
Lmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCiNkZWZpbmUgT1BFTl9UUkVFX0NST1NTRlMgMgoKc3Rh
dGljIGludCByZWN2X2ZkKGludCBzb2NrZXQpCnsKCWNoYXIgYnVmWzFdOwoJc3RydWN0IGlvdmVj
IGlvID0gewoJCS5pb3ZfYmFzZSA9IGJ1ZiwKCQkuaW92X2xlbiA9IDEsCgl9OwoJdW5pb24gewoJ
CXN0cnVjdCBjbXNnaGRyIF9hbGlnbjsKCQljaGFyIGN0cmxbQ01TR19TUEFDRShzaXplb2YoaW50
KSldOwoJfSB1OwoKCXN0cnVjdCBtc2doZHIgbXNnID0gewoJCS5tc2dfY29udHJvbCA9IHUuY3Ry
bCwKCQkubXNnX2NvbnRyb2xsZW4gPSBzaXplb2YodS5jdHJsKSwKCQkubXNnX2lvdiA9ICZpbywK
CQkubXNnX2lvdmxlbiA9IDEsCgl9OwoKCXNzaXplX3QgcmVjdiA9IHJlY3Ztc2coc29ja2V0LCAm
bXNnLCAwKTsKCWlmIChyZWN2ID09IC0xKSB7CgkJZXJyKDEsICJyZWN2X2ZkOiByZWN2bXNnIik7
Cgl9CgoJc3RydWN0IGNtc2doZHIgKmNtc2cgPSBDTVNHX0ZJUlNUSERSKCZtc2cpOwoJcmV0dXJu
ICooKGludCopIENNU0dfREFUQShjbXNnKSk7Cn0KCnN0YXRpYyBpbnQgc2VuZF9mZChpbnQgc29j
a2V0LCBpbnQgZmQpCnsKCWNoYXIgYnVmWzFdID0gezB9OwoJc3RydWN0IGlvdmVjIGlvID0gewoJ
CS5pb3ZfYmFzZSA9IGJ1ZiwKCQkuaW92X2xlbiA9IDEsCgl9OwoJdW5pb24gewoJCXN0cnVjdCBj
bXNnaGRyIF9hbGlnbjsKCQljaGFyIGN0cmxbQ01TR19TUEFDRShzaXplb2YoaW50KSldOwoJfSB1
OwoJbWVtc2V0KCZ1LCAwLCBzaXplb2YodSkpOwoKCXN0cnVjdCBtc2doZHIgbXNnID0gewoJCS5t
c2dfY29udHJvbCA9IHUuY3RybCwKCQkubXNnX2NvbnRyb2xsZW4gPSBzaXplb2YodS5jdHJsKSwK
CQkubXNnX2lvdiA9ICZpbywKCQkubXNnX2lvdmxlbiA9IDEsCgl9OwoKCXN0cnVjdCBjbXNnaGRy
ICpjbXNnID0gQ01TR19GSVJTVEhEUigmbXNnKTsKCWNtc2ctPmNtc2dfbGVuID0gQ01TR19MRU4o
c2l6ZW9mKGludCkpOwoJY21zZy0+Y21zZ19sZXZlbCA9IFNPTF9TT0NLRVQ7CgljbXNnLT5jbXNn
X3R5cGUgPSBTQ01fUklHSFRTOwoJKigoaW50KikgQ01TR19EQVRBKGNtc2cpKSA9IGZkOwoKCWlm
IChzZW5kbXNnKHNvY2tldCwgJm1zZywgMCkgPCAwKSB7CgkJZXJyKDEsICJzZW5kX2ZkOiBzZW5k
bXNnIik7Cgl9Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKCWludCBzb2Nr
ZXRzWzJdOwoJaWYgKHNvY2tldHBhaXIoQUZfVU5JWCwgU09DS19TVFJFQU0sIDAsIHNvY2tldHMp
ID09IC0xKSB7CgkJZXJyKDEsICJzb2NrZXRwYWlyIik7Cgl9CgoJcGlkX3QgcGlkID0gZm9yaygp
OwoJaWYgKHBpZCA9PSAtMSkgewoJCWVycigxLCAiZm9yayIpOwoJfQoKCWlmIChwaWQpIHsKCQlp
bnQgZmQgPSBvcGVuKCIvdG1wIiwgT19QQVRIfE9fRElSRUNUT1JZLCAwKTsKCQlpZiAoZmQgPT0g
LTEpIHsKCQkJZXJyKDEsICJvcGVuIik7CgkJfQoJCXNlbmRfZmQoc29ja2V0c1swXSwgZmQpOwoK
CQlpZiAod2FpdHBpZChwaWQsIE5VTEwsIDApID09IC0xKSB7CgkJCWVycigxLCAid2FpdHBpZCIp
OwoJCX0KCQlyZXR1cm4gMDsKCX0KCglpZiAocHJjdGwoUFJfU0VUX1BERUFUSFNJRywgU0lHS0lM
TCkgPT0gLTEpIHsKCQllcnIoMSwgInByY3RsIik7Cgl9CglpZiAodW5zaGFyZShDTE9ORV9ORVdV
U0VSfENMT05FX05FV05TKSA9PSAtMSkgewoJCWVycigxLCAidW5zaGFyZSIpOwoJfQoKCWludCBm
bGFncyA9IE9QRU5fVFJFRV9DTE9ORXxBVF9FTVBUWV9QQVRIfEFUX1JFQ1VSU0lWRTsKCgljb25z
dCBjaGFyICpjcm9zc2ZzID0gZ2V0ZW52KCJDUk9TU0ZTIik7CglpZiAoY3Jvc3NmcyAmJiAhc3Ry
Y21wKGNyb3NzZnMsICIxIikpIHsKCQlmbGFncyB8PSBPUEVOX1RSRUVfQ1JPU1NGUzsKCX0KCglp
bnQgZmQxID0gcmVjdl9mZChzb2NrZXRzWzFdKTsKCWludCBmZDIgPSBvcGVuX3RyZWUoZmQxLCAi
IiwgZmxhZ3MpOwoJaWYgKGZkMiA9PSAtMSkgewoJCWVycigxLCAib3Blbl90cmVlIik7Cgl9CgoJ
aWYgKG1vdmVfbW91bnQoZmQyLCAiIiwgLTEsICIvbW50IiwgTU9WRV9NT1VOVF9GX0VNUFRZX1BB
VEgpID09IC0xKSB7CgkJZXJyKDEsICJtb3ZlX21vdW50Iik7Cgl9CgoJaWYgKGNsb3NlX3Jhbmdl
KDMsICh1bnNpZ25lZCktMSwgMCkgPT0gLTEpIHsKCQllcnIoMSwgImNsb3NlX3JhbmdlIik7Cgl9
CgoJaWYgKGFyZ2MgPT0gMSkgewoJCWV4ZWNscCgic2giLCAiLXNoIiwgTlVMTCk7CgkJZXJyKDEs
ICJleGVjbHAgc2giKTsKCX0gZWxzZSB7CgkJZXhlY3ZwKGFyZ3ZbMV0sICZhcmd2WzFdKTsKCQll
cnIoMSwgImV4ZWN2cCAlcyIsIGFyZ3ZbMV0pOwoJfQp9Cg==
--0000000000008e05000642eca3d5--

