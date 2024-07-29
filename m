Return-Path: <linux-fsdevel+bounces-24402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2F93EC94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 06:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F172811EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E2E824A1;
	Mon, 29 Jul 2024 04:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbzZewP+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7021E49E;
	Mon, 29 Jul 2024 04:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722227648; cv=none; b=n5CiGYRLNS7xSFQF3py0ELVzEbHc7RvN7gVlU1vAya7YRmMMak5oNT3gBVZLYgNWiWs5iqx4CQ2PDM4styKBtndtHwpBIOQfo3QDHe+/FWZMiZXici8nru7iy3EPkI6DcE1gO1VXr3BUaSHblxWbHJQMVRVLD7FUX3qtrPuwk2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722227648; c=relaxed/simple;
	bh=wPOrSwCjpDSy13KEQVzEyTgyx1I3kxm+wTPQYT6576w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNO3nFBk7zcEXIEWdv3eS3byJRBYMUxkFOO2+aj+YXFTThSIuajrY/do9Np6Fg8JpwpfEwH9w9yXFWTtVSFlFG6IkJUbwdRtDK44p57uy9fE6Y0PEaMR9siP+m5DwoYN5W/0PflA7Bcdskhp2IkWpbcgRIyBoZlTrtLZurOKESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbzZewP+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f01613acbso3526397e87.1;
        Sun, 28 Jul 2024 21:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722227645; x=1722832445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oIbCxnxwTULQpRIlaeyyJALU0PYXxpLmO2yiHQMnxo=;
        b=BbzZewP+xQtKBXYwJ6jrEsTy6R4h4eMZRfGeI8BcSvIFSp0VhdUzTdE40/nbpN3qip
         16X2hgros05qooGV1LR++P9NrAcYDRWqwAVNdnfhmDC/mnJVva9uWNvMq2sfi36M58cL
         PKocEnjpNs9Iyaf9m/M4m3tMtdwfeyDrr4AFTvO4blX2UFs1yquOfLR38/Qgcbj5K8Uf
         rgoEcgh4ZAjAZIEVXdo1M/LK6h6LTbUJmnMqWD3SiERoVjkovhJzlbLe7YmrROF9sUoU
         y7NXHNPPuzI2uc0uzLLu5lk6w41qPsCKOsQB07hVw4eCfPKJCFVTNzO87h8YCio73/ZX
         EUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722227645; x=1722832445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oIbCxnxwTULQpRIlaeyyJALU0PYXxpLmO2yiHQMnxo=;
        b=VwZNep/JxienGty/HfZWV13/F0J/MDJavTaUseWiwHjfDDYl+SFmQ9BFD47yq2J8Ay
         S+qq1VZ7CfTC8gUlxJjJg4BB3yA8dL8v8cl22vl4ranW7W8KJGGfAC/TkztT2+5ouOSJ
         SarqGX3wzRc9a2oTKREGxbFy8waqGvQ87f+xy619iTmxWEq6lDYRVJZKAjQTkDv4X20v
         te2oisIJ8rTuSi94v6/LiIXu/qh7VVBOQFbLbnHVk1tdAD+RVCLaEgEjEAf+4HoY9uNN
         E5rC4cGTF3ZRyj6iomzowBz5PXNPbytUPe2ZEchaUMI0xHoC0oXU0Q7JilPYjfYazHgu
         Xnfg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0nP5h1FUOwn3aUA8+6/yhos0SOWcXZEJG8zWLto2EovzTHtO1S+50ETplM7Fg5cjxW/EQGcM0lLGsQv5o2dUa3640WVzVaGIixdW1YDdek/2hQ5Iy4tnrGN0iwfNB8Dd158Ctxv+6Q==
X-Gm-Message-State: AOJu0YyW/WsfczKmnr4Wmd3NoDlm414t1K8Bc7u4fKvRqnuUg7X9ZEJc
	VunU1V90puZnB4UY1InSmO9WVxeK9/wFPpe1X61RGPGp1Q9dNTD9BbIctx/OVYMjZq+5pCWHlUR
	mG7UIWfCV9KkII4Xe0jvpbjSbfDE=
X-Google-Smtp-Source: AGHT+IHdLKFJ51Zrj6N3dzxnnx2YTN6LsLsjTG2quIjLUbY5NTA/QQ5rn1Lk57lzVL2vtY9EppNLUy+FGozK0ybX6PA=
X-Received: by 2002:a05:6512:4002:b0:52f:36a:f929 with SMTP id
 2adb3069b0e04-5309b6d2e9amr1670945e87.4.1722227644253; Sun, 28 Jul 2024
 21:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5ms+vyNND3XPkBo+HYEj3-YMSwqZJup8BSt2B3LYOgPF+A@mail.gmail.com>
 <20240729000124.GH99483@ZenIV> <CAH2r5mvnpHS7Gs7wMCAYsNZCBte5=jkzvL_bAq84zZoh8-kX5A@mail.gmail.com>
In-Reply-To: <CAH2r5mvnpHS7Gs7wMCAYsNZCBte5=jkzvL_bAq84zZoh8-kX5A@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Sun, 28 Jul 2024 23:33:53 -0500
Message-ID: <CAH2r5mu1KvG8xeYmrYg9_HYAiZF8Z0URrzEg+0ZKS7hSn7JyJA@mail.gmail.com>
Subject: Re: Why do very few filesystems have umount helpers
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

And here is a recent bugzilla related to umount issues (although this
could be distinct from the three other umount issues I mentioned
above)

https://bugzilla.kernel.org/show_bug.cgi?id=3D219097

On Sun, Jul 28, 2024 at 11:16=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
>
> On Sun, Jul 28, 2024 at 7:01=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
> >
> > On Sun, Jul 28, 2024 at 02:09:14PM -0500, Steve French wrote:
> >
> > > Since umount does not notify the filesystem on unmount until
> > > references are closed (unless you do "umount --force") and therefore
> > > the filesystem is only notified at kill_sb time, an easier approach t=
o
> > > fixing some of the problems where resources are kept around too long
> > > (e.g. cached handles or directory entries etc. or references on the
> > > mount are held) may be to add a mount helper which notifies the fs
> > > (e.g. via fs specific ioctl) when umount has begun.   That may be an
> > > easier solution that adding a VFS call to notify the fs when umount
> > > begins.
> >
> > "references on the mount being held" is not something any userland
> > helpers have a chance to help with.
>
> I don't know the exact reasons why at least three filesystems have umount
> helpers but presumably they can issue private ioctls (or equivalent)
> to release resources, but I am very curious if their reasons would
> overlap any common SMB3.1.1 network mount use cases.
>
> > What exactly gets leaked in your tests?  And what would that userland
> > helper do when umount happens due to the last process in given namespac=
e
> > getting killed, for example?  Any unexpected "busy" at umount(2) time
> > would translate into filesystem instances stuck around (already detache=
d
> > from any mount trees) for unspecified time; not a good thing, obviously=
,
> > and not something a userland helper had a chance to help with...
> >
> > Details, please.
>
> There are three things in particular that got me thinking about how
> other filesystems handle umount (and whether the umount helper
> concept is a bad idea or a good idea for network fs)
>
> 1) Better resource usage: network filesystems often have cached
> information due to
> leases (or 'delegations' in NFS terminology) on files or directory
> entries.  Waiting until kill_superblock (rather than when umount began) c=
an
> waste resources.  This cached information is not automatically released
> when the file or directory is closed (note that "deferred close" of files=
 can
> be a huge performance win for network filesystems which support safe
> caching via leases/delegations) ... but these caches consume
> resources that ideally would be freed when umount starts, but often have =
to
> wait longer until kill_sb is invoked to be freed.  If "umount_begin"
> were called always e.g. then (assuming this were not multiple mounts
> from the same client that server share) cifs.ko could
>   a) close all deferred network file handles (freeing up some resources)
>   b) stop waiting for any pending network i/o requests
>   c) mark the tree connection (connection to the server share) as "EXITIN=
G"
>    so we don't have races sending new i/o operations on that share
>
> 2) fixing races between umount and mount:
> There are some common test scenarios where we can run a series of
> xfstests that will eventually fail (e.g. by the time xfstest runs gets
> to 043 or 044
> (to Samba server on localhost e.g.) they sometimes hit races which
> cause this message:
>
>      QA output created by 043
>     +umount: /mnt-local-xfstest/scratch: target is busy.
>     +mount error(16): Device or resource busy
>
> but it works fine if delay is inserted between these tests.  I will
> try some experiments to
> see if changing xfstests to call force unmount which calls "umount_begin"=
 (or
> adding a umount wrapper to do the same) also avoids the problem. It
> could be that
> references may be being held by cifs.ko briefly that are causing the VFS =
to
> think that files are open and not calling into cifs.ko to
> kill_superblock. This needs
> more investigation but "umount --force" (or equivalent) may help.
>
> 3) races in cleaning up directory cache information.  There was a
> patch introduced for
> periodically cleaning up the directory cache (this is only an issue to
> servers like
> Windows or NetApp etc. that support directory leases so you don't see
> it to Samba
> and various other common servers that don't enable directory leases)
> that can cause
> crashes in unmount (use after free).  I want to try to narrow it down
> soon, but it was a little
> tricky (and the assumption was that force unmount would avoid the
> problem - ie the call to
> "umount_begin").  Looks like this patch causes the intermittent umount
> crash to Windows
> servers:
>
> commit d14de8067e3f9653cdef5a094176d00f3260ab20
> Author: Ronnie Sahlberg <lsahlber@redhat.com>
> Date:   Thu Jul 6 12:32:24 2023 +1000
>
>     cifs: Add a laundromat thread for cached directories
>
>     and drop cached directories after 30 seconds
>
>
>
> Steve



--=20
Thanks,

Steve

