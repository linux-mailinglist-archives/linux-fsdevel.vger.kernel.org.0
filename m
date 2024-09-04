Return-Path: <linux-fsdevel+bounces-28633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B296C85E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2797528728F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47B2149C7B;
	Wed,  4 Sep 2024 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="hMVDxt2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE9147C71
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481758; cv=none; b=sO4uZUPQ+ziTGwEkJj479EwdyUXTqmcaFc9Qz5S4FmhGLdWNoweuaz6dYjB0yeNg+Y8D1GA8BAt86TahWbV8Mec9Ecv7sbfje++JGp/XluP15AwN6dVlGCHrhvM6bM4K8ijruNXkhL+GHM89pbl6nvoSL+R3dYhpuYdDkkMWBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481758; c=relaxed/simple;
	bh=X/+7n7wsj5xpe1PdRF9BB/jHscCZj22UtqdZAg/JuoA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DXV/FNP3gUG6jzcKqEljTKiM177bUhPr8YYuHU8vcMgRj2cgbTODISB9J9/JyOvfhu/N9z6q1awn9Cn3oPn++Codiw5pNGACqmacKvthufaUxHrjqamJ5peHO/FFXJu/ZvBjVvYTAto8FEcu1jdNeunEDcjn4NRhwR0nrf+N2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=hMVDxt2k; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3df04219e31so731354b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481754; x=1726086554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TwI5ZE+LxT3KOam/eAsyKw/n5tLnh1lq4qUNxruKGbU=;
        b=hMVDxt2ko6i/1bohPZsNKSrb0tM/HywRSQN1nI4H2pvo5NeNSoTQJYpsb7blvQwy70
         Z1Zjq+GX/oNNm53uLgAxhNYHplffcwm7lYY6tv1LDKYEJvi50PG3twZo4ZHJvIhTeRTK
         bwyDnxM0pz9mDZ8Yuf/ZbOieWBCw3Kg6VF9D1/dvvwS7gBwUXTOwuxHNX8rJ4Z/En/EZ
         ESosX7tK++2ANo2CejIU+GYwV94+tU7hDmhzzZ4aUOmm9IkQyog9tWzr0KcVj+ubMsM4
         pzLwmI0Z//dQ8U5l4bBP5u/0DBCiEM9AjIbx445zwxBNpBWRF+eR/5PJK3IXn5M0CYNn
         uRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481754; x=1726086554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TwI5ZE+LxT3KOam/eAsyKw/n5tLnh1lq4qUNxruKGbU=;
        b=moNpl9C5Rdzj/Ytd4YbG9+J6MlDov7x2jKdQAk7SY90IHf3TmyHqd4pwAF3YVXrcX/
         YGdqsABHC0nOckngzXLRSPMf9gkjgHuVMz9iMRovSo8Bms7Db8ZM88JhgVfB6TxcjqRu
         /lyabV922X90wLtdAiaj2TMGYgJmwrWNje9PsXRluKrZCfOW+n21HCrRAkBQ1gyiosZ7
         mB3VbyCRfwTEfQwrl6cQ1W3vnG33Bix6AU8dL6P23LW5JK0B9VNAkgU2H/7frZu3nTdW
         rsVFqkyFFvZ35roWYTWla7+njfH+esdaWTWAblNgRrplaL3lBmkYDo7/oDYwxeSEbEaj
         QPxw==
X-Forwarded-Encrypted: i=1; AJvYcCU6EMh9bOOI8l/jbxxMD3/iYmgZDk2YiRHSEYijhS0yR8U/UH0zJyoJr+tpay1RV1RMp3e7MUMlX2D5L6AH@vger.kernel.org
X-Gm-Message-State: AOJu0YwfxKDKBArhZp5OaSYou5z6YbHqMvAzsG0S2t/nBvUXQi9XtL+a
	f6nn4IH0/wzQMPR/rZnsNrUNQ5sCvA6QafbRMoYRfR4egoWUarsW70JEmqd/n9o=
X-Google-Smtp-Source: AGHT+IFmCKTcgpMbWnOZWSrhQNjNJKeds3Qcec7gu/SaeTJ7YoWz86ymksmS0VUDnwj3EKHmpboMHg==
X-Received: by 2002:a05:6808:14d2:b0:3d9:2319:48ac with SMTP id 5614622812f47-3df05c2fa79mr25098859b6e.9.1725481754097;
        Wed, 04 Sep 2024 13:29:14 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801dce63esm1429311cf.95.2024.09.04.13.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:13 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 00/18] fanotify: add pre-content hooks
Date: Wed,  4 Sep 2024 16:27:50 -0400
Message-ID: <cover.1725481503.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4: https://lore.kernel.org/linux-fsdevel/cover.1723670362.git.josef@toxicpanda.com/
v3: https://lore.kernel.org/linux-fsdevel/cover.1723228772.git.josef@toxicpanda.com/
v2: https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@toxicpanda.com/
v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/

v4->v5:
- Cleaned up the various "I'll fix it on commit" notes that Jan made since I had
  to respin the series anyway.
- Renamed the filemap pagefault helper for fsnotify per Christians suggestion.
- Added a FS_ALLOW_HSM flag per Jan's comments, based on Amir's rough sketch.
- Added a patch to disable btrfs defrag on pre-content watched files.
- Added a patch to turn on FS_ALLOW_HSM for all the file systems that I tested.
- Added two fstests (which will be posted separately) to validate everything,
  re-validated the series with btrfs, xfs, ext4, and bcachefs to make sure I
  didn't break anything.

v3->v4:
- Trying to send a final verson Friday at 5pm before you go on vacation is a
  recipe for silly mistakes, fixed the xfs handling yet again, per Christoph's
  review.
- Reworked the file system helper so it's handling of fpin was a little less
  silly, per Chinner's suggestion.
- Updated the return values to not or in VM_FAULT_RETRY, as we have a comment
  in filemap_fault that says if VM_FAULT_ERROR is set we won't have
  VM_FAULT_RETRY set.

v2->v3:
- Fix the pagefault path to do MAY_ACCESS instead, updated the perm handler to
  emit PRE_ACCESS in this case, so we can avoid the extraneous perm event as per
  Amir's suggestion.
- Reworked the exported helper so the per-filesystem changes are much smaller,
  per Amir's suggestion.
- Fixed the screwup for DAX writes per Chinner's suggestion.
- Added Christian's reviewed-by's where appropriate.

v1->v2:
- reworked the page fault logic based on Jan's suggestion and turned it into a
  helper.
- Added 3 patches per-fs where we need to call the fsnotify helper from their
  ->fault handlers.
- Disabled readahead in the case that there's a pre-content watch in place.
- Disabled huge faults when there's a pre-content watch in place (entirely
  because it's untested, theoretically it should be straightforward to do).
- Updated the command numbers.
- Addressed the random spelling/grammer mistakes that Jan pointed out.
- Addressed the other random nits from Jan.

--- Original email ---

Hello,

These are the patches for the bare bones pre-content fanotify support.  The
majority of this work is Amir's, my contribution to this has solely been around
adding the page fault hooks, testing and validating everything.  I'm sending it
because Amir is traveling a bunch, and I touched it last so I'm going to take
all the hate and he can take all the credit.

There is a PoC that I've been using to validate this work, you can find the git
repo here

https://github.com/josefbacik/remote-fetch

This consists of 3 different tools.

1. populate.  This just creates all the stub files in the directory from the
   source directory.  Just run ./populate ~/linux ~/hsm-linux and it'll
   recursively create all of the stub files and directories.
2. remote-fetch.  This is the actual PoC, you just point it at the source and
   destination directory and then you can do whatever.  ./remote-fetch ~/linux
   ~/hsm-linux.
3. mmap-validate.  This was to validate the pagefault thing, this is likely what
   will be turned into the selftest with remote-fetch.  It creates a file and
   then you can validate the file matches the right pattern with both normal
   reads and mmap.  Normally I do something like

   ./mmap-validate create ~/src/foo
   ./populate ~/src ~/dst
   ./rmeote-fetch ~/src ~/dst
   ./mmap-validate validate ~/dst/foo

I did a bunch of testing, I also got some performance numbers.  I copied a
kernel tree, and then did remote-fetch, and then make -j4

Normal
real    9m49.709s
user    28m11.372s
sys     4m57.304s

HSM
real    10m6.454s
user    29m10.517s
sys     5m2.617s

So ~17 seconds more to build with HSM.  I then did a make mrproper on both trees
to see the size

[root@fedora ~]# du -hs /src/linux
1.6G    /src/linux
[root@fedora ~]# du -hs dst
125M    dst

This mirrors the sort of savings we've seen in production.

Meta has had these patches (minus the page fault patch) deployed in production
for almost a year with our own utility for doing on-demand package fetching.
The savings from this has been pretty significant.

The page-fault hooks are necessary for the last thing we need, which is
on-demand range fetching of executables.  Some of our binaries are several gigs
large, having the ability to remote fetch them on demand is a huge win for us
not only with space savings, but with startup time of containers.

There will be tests for this going into LTP once we're satisfied with the
patches and they're on their way upstream.  Thanks,

Josef

Amir Goldstein (8):
  fsnotify: introduce pre-content permission event
  fsnotify: generate pre-content permission event on open
  fanotify: introduce FAN_PRE_ACCESS permission event
  fanotify: introduce FAN_PRE_MODIFY permission event
  fanotify: pass optional file access range in pre-content event
  fanotify: rename a misnamed constant
  fanotify: report file range info with pre-content events
  fanotify: allow to set errno in FAN_DENY permission response

Josef Bacik (10):
  fanotify: don't skip extra event info if no info_mode is set
  fs: add a flag to indicate the fs supports pre-content events
  fanotify: add a helper to check for pre content events
  fanotify: disable readahead if we have pre-content watches
  mm: don't allow huge faults for files with pre content watches
  fsnotify: generate pre-content permission event on page fault
  bcachefs: add pre-content fsnotify hook to fault
  xfs: add pre-content fsnotify hook for write faults
  btrfs: disable defrag on pre-content watched files
  fs: enable pre-content events on supported file systems

 fs/bcachefs/fs-io-pagecache.c      |   4 +
 fs/bcachefs/fs.c                   |   2 +-
 fs/btrfs/ioctl.c                   |   9 ++
 fs/btrfs/super.c                   |   3 +-
 fs/ext4/super.c                    |   6 +-
 fs/namei.c                         |   9 ++
 fs/notify/fanotify/fanotify.c      |  33 ++++++--
 fs/notify/fanotify/fanotify.h      |  15 ++++
 fs/notify/fanotify/fanotify_user.c | 119 ++++++++++++++++++++++-----
 fs/notify/fsnotify.c               |  17 +++-
 fs/xfs/xfs_file.c                  |   4 +
 fs/xfs/xfs_super.c                 |   2 +-
 include/linux/fanotify.h           |  20 +++--
 include/linux/fs.h                 |   1 +
 include/linux/fsnotify.h           |  58 +++++++++++--
 include/linux/fsnotify_backend.h   |  59 ++++++++++++-
 include/linux/mm.h                 |   1 +
 include/uapi/linux/fanotify.h      |  18 ++++
 mm/filemap.c                       | 128 +++++++++++++++++++++++++++--
 mm/memory.c                        |  22 +++++
 mm/readahead.c                     |  13 +++
 security/selinux/hooks.c           |   3 +-
 22 files changed, 489 insertions(+), 57 deletions(-)

-- 
2.43.0


