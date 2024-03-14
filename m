Return-Path: <linux-fsdevel+bounces-14405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 117FE87C08B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 16:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA5C284B67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFED71B3C;
	Thu, 14 Mar 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="COYmSUbX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5E71723
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430867; cv=none; b=fV+HLFqO1kraWnGW1l300x472uCzfhztNuaPUoasCMC47uwqp5yXPkgBUnWrq0MUoZJptfiTXj4WfFZS1u9NQnHDkTmDKZm8hn4RCVXHT/y+BYJdiOqQB+XLJKBLFoRcnazA/0HtKkhS8EqaBgkT/I/o5X3yBFZohWJc0JuLOS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430867; c=relaxed/simple;
	bh=myByUEhYch6CQhdrpmC4r6CMq78FabyygvunZPUZQGM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Xp8mKw1JzJ2+LG/SwOR3bsSlBQpzIyIoR/16ANvuZ8vqr0LR4bygJMAvYLtodftOXRv+95r08IqKPdPc7az7QqZVRQbEN4bZrC6rZ3XcWO1T3ovVNe1McGzS62Gw/4HRRCryeslBPcpuhHOtWD8gaVdzz0zRd+rLvQfoDOxJigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=COYmSUbX; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a466fc8fcccso108946266b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710430863; x=1711035663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJxAnGHqdudgFubRv83aDZanvuy3oP/f6CUVh38DB2c=;
        b=COYmSUbXMkWsPwrpZT4TH/2UTd/yFexdiZvJfZmMrJCzH/PpbeFN0lOWjxn3CZT6ET
         C91Mt/xoOOb5iJa8u7aeUJAKl/K04SFkZiynFYq1fF/Prawf2V2GS0zloUsfbsKeGXtl
         FBuQ80YfXxecEqHXm6QWR4gw6ZpJNvWgpPHnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430863; x=1711035663;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJxAnGHqdudgFubRv83aDZanvuy3oP/f6CUVh38DB2c=;
        b=HypPf4PMr/NWtYiDLlAf2hXZvqu20kWpE3l9dVIMmVnKfnvjGrGGzFcldzg4RqyM44
         bwXVflIBNfzwBWGY7rA5YNKk/UxpvUSKiFC3046AzhcWV2tKlH7baw/6/vIIr57RXyX8
         pPF2sYK/wmoas7nvMW3uYd0ickiQlHhJfSsUdf433NdRxh5UgX24J16+W0wTpJ8HI3S3
         rLWWXTPseQ/v6nZ5B9rN5ktDSifK8ry49bBV3ffe9Y7oN5nwk9zIjVETwXkRCKvZdXcE
         JsoY7eP0TyhEvn196vsCwnRNXTeIaQIr+Ue1w/n+8kCk+ZOPT8lIC91fDhe1jbwM8zh1
         /IFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY7+y2/+KsY8JQua3B9CrFrYVDaKkC/WTWMNrxlpO5Wt3zyZ4pFNUVwHKT07PmqFlYulXuutf76YNi+ORXDyDriEaMi5hYTeKf45ZbVQ==
X-Gm-Message-State: AOJu0YwzesVRsVwHb1541iFG8vDrZubHxZz1jpoG1sTpiN+uW1tEauxk
	KkwQb8p4FcAgxtXjQmj8dHEcT01t7shZFhjrChfzOyAuY7OLD8Le1jEzRdyTa/IKMu9lA8jFcBc
	T/4QYa66wWfGtC1c9rmifTB4MwvlbOfy7YpRpAlfDJb9yaUR7Hx0=
X-Google-Smtp-Source: AGHT+IF1OehoWcgf5en6SfEzrgWomRDzET+/crPEJD7LgDqzJMfM3C0km2yuM5I+ogRx8MHNLAKyKzze8pHLL3ti+MI=
X-Received: by 2002:a17:907:cbc4:b0:a46:5ac:dce2 with SMTP id
 vk4-20020a170907cbc400b00a4605acdce2mr2029445ejc.51.1710430862614; Thu, 14
 Mar 2024 08:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Mar 2024 16:40:50 +0100
Message-ID: <CAJfpegsZoLMfcpBXBPr7wdAnuXfAYUZYyinru3jrOWWEz7DJPQ@mail.gmail.com>
Subject: [GIT PULL] fuse update for 6.9
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fadc420613a0b7f9"

--000000000000fadc420613a0b7f9
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-6.9

- Add passthrough mode for regular file I/O.  This allows performing
read and write (also via memory maps) on a backing file without
incurring the overhead of roundtrips to userspace.  For now this is
only allowed to privileged servers, but this limitation will go away
in the future.  (Amir Goldstein)

- Fix interaction of direct I/O mode with memory maps (Bernd Schubert)

- Export filesystem tags through sysfs for virtiofs (Stefan Hajnoczi)

- Allow resending queued requests for server crash recovery (Zhao Chen)

- Misc fixes and cleanups

There's a conflict in fs/fuse/inode.c.  The resolution (attached) is
to leave the fuse_backing_files_free() call in fuse_conn_put(), before
call_rcu().

Thanks,
Miklos

---
Alexander Mikhalitsyn (2):
      fuse: fix typo for fuse_permission comment
      fuse: __kuid_val/__kgid_val helpers in fuse_fill_attr_from_inode()

Amir Goldstein (14):
      fuse: factor out helper fuse_truncate_update_attr()
      fuse: allocate ff->release_args only if release is needed
      fuse: break up fuse_open_common()
      fuse: prepare for failing open response
      fuse: introduce inode io modes
      fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP
      fuse: factor out helper for FUSE_DEV_IOC_CLONE
      fuse: introduce FUSE_PASSTHROUGH capability
      fuse: implement ioctls to manage backing files
      fuse: prepare for opening file in passthrough mode
      fuse: implement open in passthrough mode
      fuse: implement read/write passthrough
      fuse: implement splice read/write passthrough
      fuse: implement passthrough for mmap

Bernd Schubert (3):
      fuse: fix VM_MAYSHARE and direct_io_allow_mmap
      fuse: create helper function if DIO write needs exclusive lock
      fuse: add fuse_dio_lock/unlock helper functions

Jiachen Zhang (1):
      fuse: remove an unnecessary if statement

Jingbo Xu (1):
      fuse: add support for explicit export disabling

Kemeng Shi (1):
      fuse: remove unneeded lock which protecting update of congestion_threshold

Lei Huang (1):
      fuse: Fix missing FOLL_PIN for direct-io

Li RongQing (1):
      virtio_fs: remove duplicate check if queue is broken

Matthew Wilcox (Oracle) (2):
      fuse: Remove fuse_writepage
      fuse: Convert fuse_writepage_locked to take a folio

Miklos Szeredi (5):
      fuse: replace remaining make_bad_inode() with fuse_make_bad()
      fuse: fix root lookup with nonzero generation
      fuse: don't unhash root
      fuse: use FUSE_ROOT_ID in fuse_get_root_inode()
      fuse: get rid of ff->readdir.lock

Stefan Hajnoczi (4):
      virtiofs: forbid newlines in tags
      virtiofs: export filesystem tags through sysfs
      virtiofs: emit uevents on filesystem events
      virtiofs: drop __exit from virtio_fs_sysfs_exit()

Zhao Chen (2):
      fuse: Introduce a new notification type for resend pending requests
      fuse: Use the high bit of request ID for indicating resend requests

Zhou Jifeng (1):
      fuse: Track process write operations in both direct and writethrough modes

---
 Documentation/ABI/testing/sysfs-fs-virtiofs |  11 +
 fs/fuse/Kconfig                             |  11 +
 fs/fuse/Makefile                            |   2 +
 fs/fuse/control.c                           |   6 +-
 fs/fuse/dev.c                               | 156 ++++++++--
 fs/fuse/dir.c                               |  55 +++-
 fs/fuse/file.c                              | 457 +++++++++++++++++-----------
 fs/fuse/fuse_i.h                            | 153 ++++++++--
 fs/fuse/inode.c                             |  55 +++-
 fs/fuse/iomode.c                            | 254 ++++++++++++++++
 fs/fuse/passthrough.c                       | 355 +++++++++++++++++++++
 fs/fuse/readdir.c                           |   4 -
 fs/fuse/virtio_fs.c                         | 141 +++++++--
 include/uapi/linux/fuse.h                   |  39 ++-
 14 files changed, 1422 insertions(+), 277 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-virtiofs
 create mode 100644 fs/fuse/iomode.c
 create mode 100644 fs/fuse/passthrough.c

--000000000000fadc420613a0b7f9
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-update-6.9.merge.diff"
Content-Disposition: attachment; filename="fuse-update-6.9.merge.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ltreas4l0>
X-Attachment-Id: f_ltreas4l0

ZGlmZiAtLWNjIGZzL2Z1c2UvaW5vZGUuYwppbmRleCA1MTZlYTI5NzlhOTAsMDI4NjllZGY3MmYz
Li4zYTVkODg4NzgzMzUKLS0tIGEvZnMvZnVzZS9pbm9kZS5jCisrKyBiL2ZzL2Z1c2UvaW5vZGUu
YwpAQEAgLTk1NCw3IC05NTksOSArOTY2LDkgQEBAIHZvaWQgZnVzZV9jb25uX3B1dChzdHJ1Y3Qg
ZnVzZV9jb25uICpmYwogIAkJCVdBUk5fT04oYXRvbWljX3JlYWQoJmJ1Y2tldC0+Y291bnQpICE9
IDEpOwogIAkJCWtmcmVlKGJ1Y2tldCk7CiAgCQl9CisgCQlpZiAoSVNfRU5BQkxFRChDT05GSUdf
RlVTRV9QQVNTVEhST1VHSCkpCisgCQkJZnVzZV9iYWNraW5nX2ZpbGVzX2ZyZWUoZmMpOwogLQkJ
ZmMtPnJlbGVhc2UoZmMpOwogKwkJY2FsbF9yY3UoJmZjLT5yY3UsIGRlbGF5ZWRfcmVsZWFzZSk7
CiAgCX0KICB9CiAgRVhQT1JUX1NZTUJPTF9HUEwoZnVzZV9jb25uX3B1dCk7Cg==
--000000000000fadc420613a0b7f9--

