Return-Path: <linux-fsdevel+bounces-47133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD234A999DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 23:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0411B8141C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 21:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E1327054B;
	Wed, 23 Apr 2025 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is+4U9Ce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446501DFE8;
	Wed, 23 Apr 2025 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442352; cv=none; b=G7vP8TLMA3xw5US2JvpjV0c5nFSYkDpUoWg6HFToNpKb1qSoOdIk/18q7aEFWe6roQh45SkctnH3TShXqPih8+7EiqBAMHPHeCw36Y7lwZK35/LJMVAF5dRYMeDy8uwvn9tcB/i5HyJPUbabGIL7SBLeP/cMW613knBEPhss4Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442352; c=relaxed/simple;
	bh=6GgomoTqcxsuEbINY7I6CWSn0GXbkD5Th2M/o+l0ZGo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2YxrI5TH3a1rw3eMS017QnnVfpEnvdiytTP7ROKRpenxVEDjzlSnAyHQN/ldZlUJSgan93qfg4E0Q0fItW5xmYoJUpH9Y3N6BSndY7gjL0DY+SPjxOeKI0OOqNZ6wu2ydRlCJ9/D8ztUvK5CMoC90WwdxfK2B89PfgAXr61BJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is+4U9Ce; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c1efc4577so186908f8f.0;
        Wed, 23 Apr 2025 14:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745442348; x=1746047148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GgomoTqcxsuEbINY7I6CWSn0GXbkD5Th2M/o+l0ZGo=;
        b=Is+4U9Cefzi4DxbIXz7aG59KKgCFSjC213lGNilxctMGpnsUr8UWsMsrJ7CTOq0Nw5
         wBh08X3ZX1ngmVaS8C8ADq9BzY/kCSaST438NAyTOV4sQs/ge24gvLUd9VwBjVsXikFo
         1U076JWhHhu6wdQwTLWxiieg9ySovP4WXENIsM3TJJVNKRzPMrrrzzjdYYNNbP305hLJ
         b8sMqhKv11cITIbqnSvxBKa23Isgxk6uFWTgqY0xhVaqLM4HxZeYr7SaJ+rI/cBsIsv8
         lRZep7c9xZL8iJ5ryHwjF7zuNYGJU72fNmxNuhd38W5rlGyEpE2pn1wRBcCLXLsmpHVc
         VG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745442348; x=1746047148;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6GgomoTqcxsuEbINY7I6CWSn0GXbkD5Th2M/o+l0ZGo=;
        b=ChHgXYMqnaVC8BuKvBUk3Ypix2D8X7m9Fs9NkJ4j69i7LAR6H/jHZEOlRNKLh34Cji
         FoDFS/MYk/Yr75ozRdxkMWyrSpkA8UNJJIwQYDHwwfB/k1wPk/phSRIincdkzHzC2+tH
         4Me1INNj7v0zXJNHe1bYJCB8Czj+d6Jhxjzp2IZn9AjL/zWs+HkR9wbEF6WWHwr9FQzT
         5JkWTa+sirOoqGAbG101hIQUhlfR3FWxQDliiPTopc1BG0VtMZPHhGiMLUghy8BYH0uN
         /7pImD6tGzYAGEdUsiHGJBH3e0D+13tuffETGm7tE2fyzcTy9qYU0lgyQUOQOzVfUUGv
         4Gfg==
X-Forwarded-Encrypted: i=1; AJvYcCUarKGrKttqIT6CLatPUr+cQaEmP0L8KwryzqVOGsZwR+ghDdwPJhWnzfL+rlZM3E++du36NRQ/n9x1ZW877w==@vger.kernel.org, AJvYcCVd3x8KHIznn7pq8AQ35Ofvc4j0Zl1mOLCR0cwUntoInHqBrWiQTtEjYyyyKGfeeQio15eHzceOTCcRD0dqBQ==@vger.kernel.org, AJvYcCVtS9S2T26I9aDEjo8IFpi+5nlwTLpJbDxt7VtrYcce2RxXxC4lBAMknGXvaBMaSi6p4c+p5EVf/l0twMi9@vger.kernel.org
X-Gm-Message-State: AOJu0YxURqKig6nzIiqbEnbk7q7amiORIPc+e1IUqPnRov16cyf/lH7K
	fOb5ZvzHhWjeYrpcZZl1PNdZQPt/AJp99g1Hr4djJHpqklhZdSdtptpDGVHc9NWzRe3ljxTmuV6
	Xx67/8TDAsgfVpwhAN7wjv6PEhkQ=
X-Gm-Gg: ASbGnctaDSR2vygRetbNHVCi0+p4pYDwNUJvrPDT/cYeRD9iGKLuSmQ81bZGPowfSSi
	tFB4T18Ggmfw8kDMH2sYLi1eQOMTDESGs+c8+oD7yO2WPoZW3xyftvpXateBbdah7mXk6Av+1jg
	8jpYS5HB3ujEVeM/D+Bwk+KR2O5PM4oF7z+A==
X-Google-Smtp-Source: AGHT+IGUsLBPox/uWJmjVyGdZUaWrYeefwPGm1ePwVrDhg+0usyKnEvHQaxBIhl8yqvVIW79wshIanldFENL4YTbVZ8=
X-Received: by 2002:a5d:64a4:0:b0:39f:e37:1733 with SMTP id
 ffacd0b85a97d-3a06cf52369mr13252f8f.2.1745442348296; Wed, 23 Apr 2025
 14:05:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 14:05:47 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 14:05:47 -0700
From: Kane York <kanepyork@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <68089b8d.050a0220.36a438.000a.GAE@google.com>
References: <68089b8d.050a0220.36a438.000a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 14:05:47 -0700
X-Gm-Features: ATxdqUFZthFAklAVbjNKhw0GESMNNwLIui2BC5RgpHNS2pvWQzLydo6IzsEC7Q4
Message-ID: <CABeNrKXCcXxviXQPdCk2R+o-M0VmOsowtWkTddQ5+Tua9eCrQg@mail.gmail.com>
Subject: Re: [syzbot] [f2fs?] INFO: task hung in do_truncate (3)
To: syzbot+effe7da6578cd423f98f@syzkaller.appspotmail.com
Cc: brauner@kernel.org, chao@kernel.org, jack@suse.cz, jaegeuk@kernel.org, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This crash appears to entirely ignore the provided filesystem images and ju=
st
does tricky fallocate calls followed by a truncate, so it should be easier =
than
normal to diagnose.

The cwd is opened with O_DIRECT. (or this is EFAULT because path is nullptr=
?)

The victim file is created with O_NONBLOCK and O_SYNC; that fd is discarded=
.

The victim file is opened again with O_SYNC and FALLOC_FL_ZERO_RANGE is cal=
led
with a gargantuan size.

The victim file is opened again with O_APPEND (!) and FALLOC_FL_INSERT_RANG=
E is
called with a modest size.

Truncate is called midway through the just-inserted range.

Annotated calls below.

# https://syzkaller.appspot.com/bug?id=3D7d29d6d7a773d4f608a33cf6a7593faadb=
1b5803
# See https://goo.gl/kgGztJ for information about syzkaller reproducers.
#{"threaded":true,"repeat":true,"procs":5,"slowdown":1,"sandbox":"none","sa=
ndbox_arg":0,"tun":true,"netdev":true,"resetnet":true,"cgroups":true,"binfm=
t_misc":true,"close_fds":true,"usb":true,"vhci":true,"wifi":true,"ieee80215=
4":true,"sysctl":true,"swap":true,"tmpdir":true,"segv":true}
# mount file2
syz_mount_image$f2fs(&(0x7f0000000040),
&(0x7f00000000c0)=3D'./file2\x00', 0x0,
&(0x7f0000000300)=3D{[{@noinline_xattr}, {@noinline_dentry},
{@prjjquota=3D{'prjjquota', 0x3d, 'active_logs=3D4'}}, {@jqfmt_vfsv1},
{@noinline_data}, {@noheap}, {@checkpoint_diasble}, {@fastboot},
{@fsync_mode_strict}, {@discard_unit_section}]}, 0x21, 0x552d,
&(0x7f000000abc0)=3D"$[removed]")
# EBADF
pread64(0xffffffffffffffff, 0x0, 0x0, 0xfff)
# EBADF
openat$cgroup_freezer_state(0xffffffffffffffff, &(0x7f0000000080), 0x2, 0x0=
)
# openat(AT_FDCWD, nullptr, O_DIRECT, 0)
# EFAULT?
openat$nullb(0xffffffffffffff9c, 0x0, 0x4000, 0x0)
# mount 'bus'
syz_mount_image$ext4(&(0x7f0000000080)=3D'ext4\x00',
&(0x7f00000000c0)=3D'./bus\x00', 0x20081e,
&(0x7f0000000040)=3D{[{@nodelalloc}, {@orlov}, {@auto_da_alloc}]}, 0x1,
0x4ef, &(0x7f00000003c0)=3D"$[removed]")
# open file1
# O_RDWR | O_CREAT | O_NOCTTY | O_NONBLOCK | FASYNC | O_LARGEFILE | O_SYNC
# perm 0500
open(&(0x7f0000000080)=3D'./file1\x00', 0x10b942, 0x140)
# open file1
# O_RDWR | O_CREAT | O_LARGEFILE | O_SYNC
# perm 0210
r0 =3D open(&(0x7f0000000100)=3D'./file1\x00', 0x109042, 0x88)
# fallocate FALLOC_FL_ZERO_RANGE, offset 0, size 0x7000000
fallocate(r0, 0x10, 0x0, 0x7000000)
# openat(AT_FDCWD) file1
# O_WRONLY | O_CREAT | O_APPEND
# perm 0512
r1 =3D openat(0xffffffffffffff9c, &(0x7f0000000080)=3D'./file1\x00', 0x441,=
 0x14a)
# fallocate file1 FALLOC_FL_INSERT_RANGE, offset x4000, size x8000
# EPERM?
fallocate(r1, 0x20, 0x4000, 0x8000)
# truncate file1 size x8001
truncate(&(0x7f00000000c0)=3D'./file1\x00', 0x8001)

