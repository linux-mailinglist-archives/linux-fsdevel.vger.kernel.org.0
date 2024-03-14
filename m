Return-Path: <linux-fsdevel+bounces-14417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D1F87C3DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 20:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC2F1C22550
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 19:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419C475817;
	Thu, 14 Mar 2024 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhACOGk4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B174BE8;
	Thu, 14 Mar 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446165; cv=none; b=pYP8g86iXNUr56UqvfqWu/9RcFvfN1aC/PwQspALIf2bX4saqhXc2O19rKZyCvdTByk6G6J8Co5aQabqIiVtT1HsaECnPfV61t76tGPfnW/CDwP0X2oPoPjRgG8+NBrm0UnfTtZfWZ9cWALRYkpzla11ghDA1QCXWmhxr6JeqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446165; c=relaxed/simple;
	bh=dMtdr+z4geWEk1nGxP9DZ1xFcbrcm4t9EL/q1iF77rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDjzAQWVYB9T3ZLkBM+1PEfY7UhKlRgQMCMDGnHrefQCG+7MKsiudEyC7jljDRnAM7b7tdrodOFWaH5GKiKQ/8mWNofRu9JrvJADjPKL3o1jlFDfuQogDB/kp0T+Ma8tsFNLmGDr3y8wawPwfu00i5ooC0RiAv3AYRc6SXvn4lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhACOGk4; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513d4559fb4so1032029e87.3;
        Thu, 14 Mar 2024 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710446162; x=1711050962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmU5kHfUbvawQJQeqNyzZ92DSbRivWiIURaaWWNvTq0=;
        b=hhACOGk4kNkVMdShtb6IDPmfV5idflHYDAkLrKsbt9G0xWvLfVqr226pUilH6Ig1wW
         oodm39SfrPNyYHe96Jgsqe85SWj/2jmmC4sa69RR4xUI4YV95+/av/O+4LwLu/6UwpSF
         6uZ9/IYsZsZQWuqxSuJc3IX0tgbt0Fsp9+m38NZ231EqKoUiRb6+RQY4L+NC8h1iO3+k
         +hJI1owALr9BpQMY/XwVXIYxVvhzWkej/pXtKneVan2ZRIbM4y0bwfmout4/Lp0ME5wD
         5IL9pNu+qetg9xMuzHj63VCMNNRp6oGnV/ncXxnUkshrI+C8qaIjTRtwB/PonhlYEQZy
         2IUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710446162; x=1711050962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmU5kHfUbvawQJQeqNyzZ92DSbRivWiIURaaWWNvTq0=;
        b=aPegjSnqmFX3tzx5e0SRrD7Q7Gwr06AZ+tQc1ETzqpWH483w5MhNrtaqRLpuSq7Rkw
         qvUEbo90RTzAa53hY68+gwtXExbxnckTbl66KD7PHZNHJIqQtDJFLatPv3XlV9u9o1Vu
         NNVo/n54f0PQuoivT6DKWtbGPTcXJV1xc0wt17fPSxNaW35X6F0s2Gl6bNwGuEO7O5bC
         uqYB62d4hqT617EZHP26/qTU19nIecYr5whan0uwn9tw1BccLSu5RGzkk026+qkXROua
         b30iqA/LRB06gJRes8uuD+CJXQADv41BjTsJ7PGDh7jDT21vjOcpCvnZAoQxQSZ5Xxv6
         gLtg==
X-Forwarded-Encrypted: i=1; AJvYcCVw8twsV9P8vUU/YBMAZ50vtH2zuVHtWX4hUw0TgMTstU9EDQNDZJMCMmL1uQwzztGvC0AEG0xX18a+PePzGHe6XrIWRzUaXXlZ/N9RAyAcuw7Z/dFchZ2tCoT4P3nGkJYKewR5NIbaCAk=
X-Gm-Message-State: AOJu0YyJ2Qs7+N2w5coQuj7Oa8yzIK3AXLPFVgDF095F153fbn+FIik7
	0CsN09K2rQe2RgmNaNxm6NRoK3/3v3Z7qm198FnwDpVanfbrEbS2NSqmvlz9g5Gna4fSaNDRfVg
	FlE14UQhdSzgOLtBYKrQfGVLWdQc=
X-Google-Smtp-Source: AGHT+IHVjuQkZFwa6Zwnan4Px4We41FJXhl7ioG9TTa71PGzxxVT7QOjctjDO9GawpmgI5YMmim5zZ1OQ0sDuixZmk0=
X-Received: by 2002:a05:6512:469:b0:513:c9de:ee30 with SMTP id
 x9-20020a056512046900b00513c9deee30mr2228965lfd.17.1710446161749; Thu, 14 Mar
 2024 12:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308-vfs-uuid-f917b2acae70@brauner>
In-Reply-To: <20240308-vfs-uuid-f917b2acae70@brauner>
From: Steve French <smfrench@gmail.com>
Date: Thu, 14 Mar 2024 14:55:50 -0500
Message-ID: <CAH2r5mvXYwLJbKJhAVd34zyDcM4YNM5_n4G-aUNjrjG3VT5KQQ@mail.gmail.com>
Subject: Fwd: [GIT PULL] vfs uuid
To: Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Do you have sample programs for these programs (or even better
mini-xfstest programs) that we can use to make sure this e.g. works
for cifs.ko (which has similar concept to FS UUID for most remote
filesystems etc.)?

---------- Forwarded message ---------
From: Christian Brauner <brauner@kernel.org>
Date: Fri, Mar 8, 2024 at 4:19=E2=80=AFAM
Subject: [GIT PULL] vfs uuid
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>


Hey Linus,

/* Summary */
This adds two new ioctl()s for getting the filesystem uuid and
retrieving the sysfs path based on the path of a mounted filesystem. The
bcachefs pull request should include a merge of this as well as it
depends on the two new ioctls. Getting the filesystem uuid has been
implemented in filesystem specific code for a while it's now lifted as a
generic ioctl.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.8-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d=
:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.uui=
d

for you to fetch changes up to 01edea1bbd1768be41729fd018a82556fa1810ec:

  Merge series "filesystem visibility ioctls" of
https://lore.kernel.org/r/20240207025624.1019754-1-kent.overstreet@linux.de=
v
(2024-02-12 13:14:21 +0100)

Please consider pulling these changes from the signed vfs-6.9.uuid tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.9.uuid

----------------------------------------------------------------
Christian Brauner (1):
      Merge series "filesystem visibility ioctls" of
https://lore.kernel.org/r/20240207025624.1019754-1-kent.overstreet@linux.de=
v

Kent Overstreet (6):
      fs: super_set_uuid()
      ovl: convert to super_set_uuid()
      fs: FS_IOC_GETUUID
      fat: Hook up sb->s_uuid
      fs: add FS_IOC_GETFSSYSFSPATH
      xfs: add support for FS_IOC_GETFSSYSFSPATH

 Documentation/userspace-api/ioctl/ioctl-number.rst |  3 +-
 fs/ext4/super.c                                    |  2 +-
 fs/f2fs/super.c                                    |  2 +-
 fs/fat/inode.c                                     |  3 ++
 fs/gfs2/ops_fstype.c                               |  2 +-
 fs/ioctl.c                                         | 33 ++++++++++++++
 fs/kernfs/mount.c                                  |  4 +-
 fs/ocfs2/super.c                                   |  4 +-
 fs/overlayfs/util.c                                | 18 +++++---
 fs/ubifs/super.c                                   |  2 +-
 fs/xfs/xfs_mount.c                                 |  4 +-
 include/linux/fs.h                                 | 52 ++++++++++++++++++=
++++
 include/uapi/linux/fs.h                            | 25 +++++++++++
 mm/shmem.c                                         |  4 +-
 14 files changed, 141 insertions(+), 17 deletions(-)



--
Thanks,

Steve

