Return-Path: <linux-fsdevel+bounces-34928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F42209CF0EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 17:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E1DB2E945
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949331D6DBC;
	Fri, 15 Nov 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VHE0vNg3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40101D45EA
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684685; cv=none; b=kp994g+xQql0mPReCnznucQOzT3BR55TZ+MTz/3K2/60E/EPXA4DDSecBQL+5FWQNcp8wFc0neB6AGo3r0hwKdRc7nncqJUGopzdkpCcq5Q9UcAF+/Ce3TLYjDIDzyaGJn6WNB7CP0gsmT+5iLu6+zZbWfa5/TkHLGz4FlHSX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684685; c=relaxed/simple;
	bh=hp4usW8Ej11+8+PqZlhGZByHONHHqdNTmMAhepWwZC4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VB8Kh+4h5mSu7ukvrNL6MQdBBpAs5YvCGZmOcr/G5F2bZrb6+VqDu9mpzloF0gYKLyEOpZk//cx2VA5MQRHtmrm84RYRtOIR9rHD0DcSsl3lIRXthRkoiaKwOL3J5D/ZBbtmWv+ku+PkQ0Ab+BuKYocdwGivexReRctNjwxwGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VHE0vNg3; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ea1407e978so17533557b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684682; x=1732289482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUtk4+vV369ZskHbswJIOBkvN0frqjKE2l/5ygvxLAI=;
        b=VHE0vNg3j6b+b5EQ+4+I71Mh0M0knTrZycmHLOJsEHn6MKHXKOcFwZOJ70cZmKHxFA
         YPFwyq6w8VYHNcVC73W6vkWujCjOAK9f5NADW37dwVeqAhU+PCT5aAhgyI0ay7zKDYxK
         YtId3ROUzIiG2DBLDD78NF/SWWo3iDnC1CEN0GPCHsqnjbd0qgotYpEePRSDPZOvwblT
         5DBZCjM8cmTNmB/L6/dxnhK2RMryCir4460aMG6dbgDsIlUh/pFbcxJX56iBJ67TCMoK
         J2ztsAd2LDMGiYwWmIxiZ2vRMPaiIqn1Pfu1bRwKe0orUob5A4u1llWyUII7+o8BPuG2
         fSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684682; x=1732289482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUtk4+vV369ZskHbswJIOBkvN0frqjKE2l/5ygvxLAI=;
        b=nUSr6kZRYcb2XvTj98IX9a2L4gFEXtNDSRAzu5YJPa7u/f9WKroKT1leW8/8H8bg0C
         hMXf/Nr8DimKq79C70szglx9cE8Y0IQvURx8euTVgZXBvh7YYVvczPbH03NJrbFcR+/J
         TkwlFVrxjj0/Bk6odtQMXq+jP/RfaZkdYpHXZqdCViP8JJx7RIZj9tdCrhzh8iHOPy47
         Aijyuq4l3NQ3GuW/Fh2An3QnA352tWjpU32kJ4vRzE0lcRdQ5ISf6LoZ/z6tDLJf9Ma9
         CK4X2O76euA/IfyOPXrUdPwPpwFSGl7Se1BKrm4yAZt99zJVDzNEKPHlxEYaRY87HtGU
         Ctpw==
X-Forwarded-Encrypted: i=1; AJvYcCVKDSKLj/mUEEGI+oMO1VaQebL/dpOj0RiiW/k7lyJVUs/ijBOXVDZkIVE4FWl+qd4m8sjoodWjw7HdAkx1@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBceL4XziXp10b8FzShRsZzDIQX+cS+4rmMt+nTotCdrPCF3O
	Ypc1EcCdpYs73biyBJ5HGrQJDCh/5zOV+NnBukQYngANA53ZFCvniLuo3fl6LDQ=
X-Google-Smtp-Source: AGHT+IEtrgHfueknW4D9O6DxGEsrZzaExI8RD/i4XVu0Bk+G5X9g8sl2lzwD4VPcS/0dPBXA19z4iQ==
X-Received: by 2002:a05:690c:3348:b0:6e3:16da:e74 with SMTP id 00721157ae682-6ee55a709a1mr39043347b3.16.1731684681590;
        Fri, 15 Nov 2024 07:31:21 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee444477b5sm7768357b3.110.2024.11.15.07.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:21 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 00/19] fanotify: add pre-content hooks
Date: Fri, 15 Nov 2024 10:30:13 -0500
Message-ID: <cover.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v7: https://lore.kernel.org/linux-fsdevel/cover.1731433903.git.josef@toxicpanda.com/
v6: https://lore.kernel.org/linux-fsdevel/cover.1731355931.git.josef@toxicpanda.com/
v5: https://lore.kernel.org/linux-fsdevel/cover.1725481503.git.josef@toxicpanda.com/
v4: https://lore.kernel.org/linux-fsdevel/cover.1723670362.git.josef@toxicpanda.com/
v3: https://lore.kernel.org/linux-fsdevel/cover.1723228772.git.josef@toxicpanda.com/
v2: https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@toxicpanda.com/
v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/

v7->v8:
- A bunch of work from Amir to cleanup the fast path for the common case of no
  watches, which cascades through the rest of th series to update the helpers
  and the hooks to use the new helpers.
- A patch from Al to get rid of the __FMODE_NONOTIFY flag and cleanup the usage
  there, thanks Al!

v6->v7:
- As per Linus's suggestion, Amir added the file flag FMODE_NOTIFY_PERM that
  will be set at open time if the file has permission related watches (this is
  the original malware style permission watches and the new precontent watches).
  All of the VFS hooks and the page fault hooks use this flag to determine if
  they should generate a notification to allow for a much cheaper check in the
  common case.

v5->v6:
- Linus had problems with this and rejected Jan's PR
  (https://lore.kernel.org/linux-fsdevel/20240923110348.tbwihs42dxxltabc@quack3/),
  so I'm respinning this series to address his concerns.  Hopefully this is more
  acceptable.
- Change the page fault hooks to happen only in the case where we have to add a
  page, not where there exists pages already.
- Amir added a hook to truncate.
- We made the flag per SB instead of per fstype, Amir wanted this because of
  some potential issues with other file system specific work he's doing.
- Dropped the bcachefs patch, there were some concerns that we were doing
  something wrong, and it's not a huge deal to not have this feature for now.
- Unfortunately the xfs write fault path still has to do the page fault hook
  before we know if we have a page or not, this is because of the locking that's
  done before we get to the part where we know if we have a page already or not,
  so that's the path that is still the same from last iteration.
- I've re-validated this series with btrfs, xfs, and ext4 to make sure I didn't
  break anything.

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

Al Viro (1):
  fs: get rid of __FMODE_NONOTIFY kludge

Amir Goldstein (12):
  fsnotify: opt-in for permission events at file open time
  fsnotify: add helper to check if file is actually being watched
  fanotify: don't skip extra event info if no info_mode is set
  fanotify: rename a misnamed constant
  fanotify: reserve event bit of deprecated FAN_DIR_MODIFY
  fsnotify: introduce pre-content permission events
  fsnotify: pass optional file access range in pre-content event
  fsnotify: generate pre-content permission event on truncate
  fanotify: introduce FAN_PRE_ACCESS permission event
  fanotify: report file range info with pre-content events
  fanotify: allow to set errno in FAN_DENY permission response
  fanotify: add a helper to check for pre content events

Josef Bacik (6):
  fanotify: disable readahead if we have pre-content watches
  mm: don't allow huge faults for files with pre content watches
  fsnotify: generate pre-content permission event on page fault
  xfs: add pre-content fsnotify hook for write faults
  btrfs: disable defrag on pre-content watched files
  fs: enable pre-content events on supported file systems

 fs/btrfs/ioctl.c                   |   9 ++
 fs/btrfs/super.c                   |   2 +-
 fs/ext4/super.c                    |   3 +
 fs/fcntl.c                         |   4 +-
 fs/notify/fanotify/fanotify.c      |  33 +++++--
 fs/notify/fanotify/fanotify.h      |  15 +++
 fs/notify/fanotify/fanotify_user.c | 145 +++++++++++++++++++++++------
 fs/notify/fsnotify.c               |  56 +++++++++--
 fs/open.c                          |  62 +++++++++---
 fs/xfs/xfs_file.c                  |   4 +
 fs/xfs/xfs_super.c                 |   2 +-
 include/linux/fanotify.h           |  19 +++-
 include/linux/fs.h                 |  42 +++++++--
 include/linux/fsnotify.h           | 135 +++++++++++++++++++++++----
 include/linux/fsnotify_backend.h   |  60 +++++++++++-
 include/linux/mm.h                 |   1 +
 include/uapi/asm-generic/fcntl.h   |   1 -
 include/uapi/linux/fanotify.h      |  18 ++++
 mm/filemap.c                       |  90 ++++++++++++++++++
 mm/memory.c                        |  22 +++++
 mm/readahead.c                     |  13 +++
 security/selinux/hooks.c           |   3 +-
 22 files changed, 639 insertions(+), 100 deletions(-)

-- 
2.43.0


