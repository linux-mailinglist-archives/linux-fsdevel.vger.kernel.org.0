Return-Path: <linux-fsdevel+bounces-34495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BB99C5F94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47761F22E7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EAD215C4F;
	Tue, 12 Nov 2024 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jXJjs3/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC78215007
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434191; cv=none; b=HSkj+z6Y3S/aNeOD1oRFAF7ki0O3ucTzXB3HcF2kyjGxaHezMbbde/KxKoFz2i82ccEm36WDR5Af2AI6pWCjcuKMwRBZ8caSjUStshRjaX5//S+RMUVIUuqmBoXxB4UhYxmM6TS/+3LO+/HxbQ6PwVaBqnnhSU6kWPjkt7bLu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434191; c=relaxed/simple;
	bh=esdaILa7AKbxpOU9tYwViCla+kycTwZVmfRFoeCuTbc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KD6lxSFTglJLkNFew79alftbqB+AbCWIV40PwMzzDqGoeegwC9abbwcELKuiFA8AULAXwK+5NspnOp89PWRLhY2ZnW0dnxFEgafucn1+/xHqDGMipJRSOOWTaBaSVqjejomcFAFhVFTxxJgyXLPLPd0U3KbawW3kohUyhoUK+tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jXJjs3/J; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e9f8dec3daso46169917b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434187; x=1732038987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g48wmOGZabKsmMEfPaYhGe4dtOd9ozHYTrWY8XD5r2k=;
        b=jXJjs3/JH2+IHUofpAGDd/ER77BXeXxFTIaFQ2KZI/fccpVkpLuwAv/Rfrf7rze+Ls
         qkUQoIkYC1B6mUCDwp0AFMjgvyAwVZl/Sd4exzZaP5GwRqVLQawWIdj/FFp12OTB24bi
         QW2R+zCla6MKFz3j8yh6PxubErEDbAIsCDffxF9EpNeKpcIwfK/kOcJq8wgCtrTM8Ifx
         SndTZGOPpZUWM3WmhAcBeUGPMjidpq4LFotZ2RkX2LioHr0Qrn7dJXhCzBtJaqb5RUqh
         RPYmf5F8UVIqhpbZmRiSPZLrxXKK2nSsXQb1YTe80NJ0ZZqLs9Er8sCIhugET0rUIgJa
         K9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434187; x=1732038987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g48wmOGZabKsmMEfPaYhGe4dtOd9ozHYTrWY8XD5r2k=;
        b=SrDzhiiT/i/pjdXBa82OQK40dOlQ4+Kq/DsiyVymohnt2WvivN72OKcq9TALbPHaC1
         D0Rq9uAR84v4aGRqaIzgExr0nS1/qa1EGpUOPSiaLNoLWC/VPpMtkwi9nH1OudUwWObN
         AlSQz6KC7pKXyq6YhDyKkf2l2dh8aDXi/caawfigc1u4nq14ey0vLZQ2xEYdp5nn6ylJ
         LUEbTnPHDmewHkuJn3pvTDy2t2dlbsRVlnfsj877I5bAmbzkeTFIj5+UWvnLc5icxnYS
         M+QAMiDfO868OC3yRPmX00Nqas02RqF7ITFwfcsEswg3OaIDISBq6WmdkrG93hmiVhC6
         PNow==
X-Forwarded-Encrypted: i=1; AJvYcCXxx9bllGq6WsAkedIUvnNVRXe2lUjq4Txm/Zs1gLh80zHgEH7B+aela0XB+JeHxzPWWPlor6t0dnREVB1u@vger.kernel.org
X-Gm-Message-State: AOJu0YwfVsF0VULzEerr7GNEO2hsOMlr1Ue7gYYowkJDiPDDhZUDJVCB
	qlXsXH3LX+0xT2pt5e3lmg5zii3Ug9vIChRBGw1zC78FOKvuU27A/n9GsI4WZ9k=
X-Google-Smtp-Source: AGHT+IGENyk2mAziIYhZQg41cfzA0HPYUllNcDo1wflc5oTm5yw6vvf+phT1j0QUEo4365Asvd+k2g==
X-Received: by 2002:a05:690c:6f92:b0:6ea:8556:1cd6 with SMTP id 00721157ae682-6eaddf84222mr180166387b3.30.1731434187543;
        Tue, 12 Nov 2024 09:56:27 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb7b34fsm26786047b3.115.2024.11.12.09.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:26 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v7 00/18] fanotify: add pre-content hooks
Date: Tue, 12 Nov 2024 12:55:15 -0500
Message-ID: <cover.1731433903.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v6: https://lore.kernel.org/linux-fsdevel/cover.1731355931.git.josef@toxicpanda.com/
v5: https://lore.kernel.org/linux-fsdevel/cover.1725481503.git.josef@toxicpanda.com/
v4: https://lore.kernel.org/linux-fsdevel/cover.1723670362.git.josef@toxicpanda.com/
v3: https://lore.kernel.org/linux-fsdevel/cover.1723228772.git.josef@toxicpanda.com/
v2: https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@toxicpanda.com/
v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/

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

Amir Goldstein (11):
  fsnotify: opt-in for permission events at file_open_perm() time
  fanotify: don't skip extra event info if no info_mode is set
  fanotify: rename a misnamed constant
  fanotify: reserve event bit of deprecated FAN_DIR_MODIFY
  fsnotify: introduce pre-content permission events
  fsnotify: pass optional file access range in pre-content event
  fsnotify: generate pre-content permission event on open
  fsnotify: generate pre-content permission event on truncate
  fanotify: introduce FAN_PRE_ACCESS permission event
  fanotify: report file range info with pre-content events
  fanotify: allow to set errno in FAN_DENY permission response

Josef Bacik (7):
  fanotify: add a helper to check for pre content events
  fanotify: disable readahead if we have pre-content watches
  mm: don't allow huge faults for files with pre content watches
  fsnotify: generate pre-content permission event on page fault
  xfs: add pre-content fsnotify hook for write faults
  btrfs: disable defrag on pre-content watched files
  fs: enable pre-content events on supported file systems

 fs/btrfs/ioctl.c                   |   9 +++
 fs/btrfs/super.c                   |   2 +-
 fs/ext4/super.c                    |   3 +
 fs/namei.c                         |  10 ++-
 fs/notify/fanotify/fanotify.c      |  33 ++++++--
 fs/notify/fanotify/fanotify.h      |  15 ++++
 fs/notify/fanotify/fanotify_user.c | 120 +++++++++++++++++++++++------
 fs/notify/fsnotify.c               |  14 +++-
 fs/open.c                          |  31 +++++---
 fs/xfs/xfs_file.c                  |   4 +
 fs/xfs/xfs_super.c                 |   2 +-
 include/linux/fanotify.h           |  19 +++--
 include/linux/fs.h                 |   4 +-
 include/linux/fsnotify.h           | 120 ++++++++++++++++++++++++-----
 include/linux/fsnotify_backend.h   |  71 ++++++++++++++++-
 include/linux/mm.h                 |   1 +
 include/uapi/linux/fanotify.h      |  18 +++++
 mm/filemap.c                       |  90 ++++++++++++++++++++++
 mm/memory.c                        |  22 ++++++
 mm/readahead.c                     |  13 ++++
 security/selinux/hooks.c           |   3 +-
 21 files changed, 532 insertions(+), 72 deletions(-)

-- 
2.43.0


