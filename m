Return-Path: <linux-fsdevel+bounces-24401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE293EC82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 06:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A72B217A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE9280C15;
	Mon, 29 Jul 2024 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmQu80WT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917512F5A;
	Mon, 29 Jul 2024 04:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722226624; cv=none; b=OolbDCxmM57lqnTxTpfRZ3VNBNUGXvOOrNTuy6dzNT0Z0m1bJqgdzue/2g9Mnhkbnqxi4A9SgfM19TP48A8livefM1qh+yuVT7CNWwofKYpneJHxIP3qQU4uAZajjQfuy/2VNx+NQmr2mflym1s1JsLVvQdQSRF89q+MMgKUnc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722226624; c=relaxed/simple;
	bh=RBRXap9AZd8LH2XsGENLNLD3CHvsgScRdJ1v6t+6JhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O53ojFmiZd4eSbPQVRDKm5DDIDi+l2ATTopgSFGpwyhlslZ/WZiLE0leYFFjjOI/5Qe15WmDzj+HbW6rX2E3nm0gLIE1DTuYpDt9ZROZSBQkw+qHcWN7MbcFXJLTY06lBS2Z0goSacVxITFiea29LJdO52aA/5ZtjwGrhEzgPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmQu80WT; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso37157901fa.1;
        Sun, 28 Jul 2024 21:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722226621; x=1722831421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyHOGRmNKmHe8l9zKgDQXc82VPvewqqtTpqW/jtcyNE=;
        b=lmQu80WTn0ACyDWFgtRvnNYdXRv/WLK9XCZxpvOJVoHPbbM3ffam+SC04GrI3oO222
         H8LKcG18JMmlGu8Yb0E76BUl5Q4fhYujtyYOr4j/v1swkQeMZztiUBPX0UPNW4055tiI
         rB8wRfGk39xwq8j59ea8yJqXkULGxmionWZ5y0C4hBCNWgRgQpVwIAFTLlMh4CIA51Uv
         JCiFZ9HObSuU83QWNWcwWGbLYSXXY6FbRVIM3/8jEECW5rB6pRUKUtEAGkAtKO5lLW2G
         8Rz0j4MlXWO+Qsc3A2TSkhMegAPn/wfRpMTxrQrqg5qhliQOaY3jIAELGxjVu0SCyJr3
         6Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722226621; x=1722831421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyHOGRmNKmHe8l9zKgDQXc82VPvewqqtTpqW/jtcyNE=;
        b=jqgdzWr8yEUxXCE0wE/8ZS8xl9PUKTs1rXegBtsPk+C6ZV7u14fU/ydFb9P368J1Uk
         XqKUH8tJf84/BJURO6X8VBVLwUF6DKnUdZTwM3ZYNZWbM8E+298Lr6ptmRPNfr9Iw4/J
         jDY4g5pRztVJ6CvqqDC7ND8vfoW/E1dtNv3cPSsX2FhBWD5KndQ+GOy1RiQsbX1zGIXq
         mEGgeqYsw4520hjN5sSoehp9rmnaFEHmZ83/YkTFAIgZX7kIe7m5iuMtl7BpWZlFljhO
         yIeH8ag0yMCAS8SnuLPRMfNWz2baejLSblIP10GBCRA4OQ+zy8HLobUckVOcNn1WA9Vx
         5FTg==
X-Forwarded-Encrypted: i=1; AJvYcCXX/jAanxxiYkLtOKUwgnmvgzVDFT0OSQpH4tlVVFbXJ6mTPwOmxTjs6rttxfK490HI8NvpSRwpSVpcUg33YAI8Z2OzexSPzEj9i8yTMBpnj0OqH+xU8kQgMRh2HQH1zejwQzzsS6V02g==
X-Gm-Message-State: AOJu0YyDFHreVzsqhgcsmjIPPmQ1nQxOu7MT3sTGAbRztqdiK2GteAyX
	8841QFbNLl16WAMW+31/GJ8LBnbrRKBD3WDPXfTx1d6KLq9kvw68k5xvdJYnWLO83FRrophc+MP
	FuAfbwHEtSgsVNC8qWtGMj6604JE=
X-Google-Smtp-Source: AGHT+IGDKS6BOTrX3Kytbfj4e3mBi2YdisqBuu4gC9PLP86P7Ov80iia63wyJJS0/M/A8vxechiRKrgcGokg2lv22pI=
X-Received: by 2002:a05:6512:1249:b0:52f:c14e:2533 with SMTP id
 2adb3069b0e04-5309b2dfe13mr4495361e87.48.1722226620220; Sun, 28 Jul 2024
 21:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5ms+vyNND3XPkBo+HYEj3-YMSwqZJup8BSt2B3LYOgPF+A@mail.gmail.com>
 <20240729000124.GH99483@ZenIV>
In-Reply-To: <20240729000124.GH99483@ZenIV>
From: Steve French <smfrench@gmail.com>
Date: Sun, 28 Jul 2024 23:16:49 -0500
Message-ID: <CAH2r5mvnpHS7Gs7wMCAYsNZCBte5=jkzvL_bAq84zZoh8-kX5A@mail.gmail.com>
Subject: Re: Why do very few filesystems have umount helpers
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 7:01=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sun, Jul 28, 2024 at 02:09:14PM -0500, Steve French wrote:
>
> > Since umount does not notify the filesystem on unmount until
> > references are closed (unless you do "umount --force") and therefore
> > the filesystem is only notified at kill_sb time, an easier approach to
> > fixing some of the problems where resources are kept around too long
> > (e.g. cached handles or directory entries etc. or references on the
> > mount are held) may be to add a mount helper which notifies the fs
> > (e.g. via fs specific ioctl) when umount has begun.   That may be an
> > easier solution that adding a VFS call to notify the fs when umount
> > begins.
>
> "references on the mount being held" is not something any userland
> helpers have a chance to help with.

I don't know the exact reasons why at least three filesystems have umount
helpers but presumably they can issue private ioctls (or equivalent)
to release resources, but I am very curious if their reasons would
overlap any common SMB3.1.1 network mount use cases.

> What exactly gets leaked in your tests?  And what would that userland
> helper do when umount happens due to the last process in given namespace
> getting killed, for example?  Any unexpected "busy" at umount(2) time
> would translate into filesystem instances stuck around (already detached
> from any mount trees) for unspecified time; not a good thing, obviously,
> and not something a userland helper had a chance to help with...
>
> Details, please.

There are three things in particular that got me thinking about how
other filesystems handle umount (and whether the umount helper
concept is a bad idea or a good idea for network fs)

1) Better resource usage: network filesystems often have cached
information due to
leases (or 'delegations' in NFS terminology) on files or directory
entries.  Waiting until kill_superblock (rather than when umount began) can
waste resources.  This cached information is not automatically released
when the file or directory is closed (note that "deferred close" of files c=
an
be a huge performance win for network filesystems which support safe
caching via leases/delegations) ... but these caches consume
resources that ideally would be freed when umount starts, but often have to
wait longer until kill_sb is invoked to be freed.  If "umount_begin"
were called always e.g. then (assuming this were not multiple mounts
from the same client that server share) cifs.ko could
  a) close all deferred network file handles (freeing up some resources)
  b) stop waiting for any pending network i/o requests
  c) mark the tree connection (connection to the server share) as "EXITING"
   so we don't have races sending new i/o operations on that share

2) fixing races between umount and mount:
There are some common test scenarios where we can run a series of
xfstests that will eventually fail (e.g. by the time xfstest runs gets
to 043 or 044
(to Samba server on localhost e.g.) they sometimes hit races which
cause this message:

     QA output created by 043
    +umount: /mnt-local-xfstest/scratch: target is busy.
    +mount error(16): Device or resource busy

but it works fine if delay is inserted between these tests.  I will
try some experiments to
see if changing xfstests to call force unmount which calls "umount_begin" (=
or
adding a umount wrapper to do the same) also avoids the problem. It
could be that
references may be being held by cifs.ko briefly that are causing the VFS to
think that files are open and not calling into cifs.ko to
kill_superblock. This needs
more investigation but "umount --force" (or equivalent) may help.

3) races in cleaning up directory cache information.  There was a
patch introduced for
periodically cleaning up the directory cache (this is only an issue to
servers like
Windows or NetApp etc. that support directory leases so you don't see
it to Samba
and various other common servers that don't enable directory leases)
that can cause
crashes in unmount (use after free).  I want to try to narrow it down
soon, but it was a little
tricky (and the assumption was that force unmount would avoid the
problem - ie the call to
"umount_begin").  Looks like this patch causes the intermittent umount
crash to Windows
servers:

commit d14de8067e3f9653cdef5a094176d00f3260ab20
Author: Ronnie Sahlberg <lsahlber@redhat.com>
Date:   Thu Jul 6 12:32:24 2023 +1000

    cifs: Add a laundromat thread for cached directories

    and drop cached directories after 30 seconds



Steve

