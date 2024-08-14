Return-Path: <linux-fsdevel+bounces-25991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9102D9524A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 23:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D6E1C22745
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7031C8240;
	Wed, 14 Aug 2024 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jVibL81K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B67E1BE241
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670767; cv=none; b=YXsrJu2tPG2X7dW+3OrapA89Sl5myR8plTHSb7Km/gC2DWsvJmoAAuAqGPsMfc7F/QZL4wrlckX4HrFxSNeTBEEjO2PYIqRRMfKv1y2/TDxkZ/PE9616JgSpKw9Zl8iR8DX4eivcuAoP0UfP+v88V+P7TtUOBSgliL1pTZCSw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670767; c=relaxed/simple;
	bh=GWaaaFa5p9YV8pWOdymeo3ub/M+DKWgxitUWjUW2hSU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g8bv2kutC/WVPVOxKFHIRySiYXTXSMlfXKm1AjXgbUMNTLgqcFgOu1juQBnFKQnOIVLC5xlUtIMRRNsSgXUAHpsjNhtuELItuvDFxUn+Uqj5Sh7cYc45wGooDPOpo9O8J16izkQHuZCCYs7xqlvMW0xkr4COWo6wQtszGtL7Kjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jVibL81K; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093d565310so217548a34.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670764; x=1724275564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pyau8aOJuyZnZfGNcIVxqfibv2avRjwgFV+ZdZpslNc=;
        b=jVibL81KoTI+z5PO2jZyD1uBfNfYwaUdOYs+fABzlNFmbGlJK7S5WiNg9ZcY6NG4h6
         uOdv57E9cSR89XoVQY8dFZ2h4F+7JTESMRwk1CtpO0oFHQlVcpicIkGWkQtwJyc/7uK+
         A4SeRwJv6z0PiAg659NHE2cMDGDPGbTkRSNkm7p9K9GqKf+lsk75y7t5jrpwFGBKv2DO
         0xRj9PqqeLGV4fe6/RsjDQLUgKonl77sPVmNz3vTRqDHLwaibilVWl0ocERXEDxRGJCW
         0sXjkk00e+mqXO99bQhaXIqGzagF9UrMqhE092QYmOzZUJp90tCTw8QNPG3u9usaZHwb
         3l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670764; x=1724275564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pyau8aOJuyZnZfGNcIVxqfibv2avRjwgFV+ZdZpslNc=;
        b=lfdGQB/zBnf+f4/cSc+RtiNIem2YNJJbN2C5yNnfnV1A0HTLnj6E03R9pQFKAHhNCK
         c5FKsI7WNmFzOfYdfPokaMzyH+rgJ33Ng64JQYZNp+5pqOKla+mJSpCPC2O4UfBUuxX1
         W6jtuezzNhrj50tBu1Ky0Y2EO2tADdTM9eSYQBBiIGfZ85A1TCCKCbQOanqg4HKm1i6z
         2Pmx6WoggTaHZk5kmSiSfG3lIarNiqNzEhXb+JjN8tUOIwk4TB6p0ZtVXKt++vKy/BQB
         my43BaoB2XSCSMoXdEusXvCiR8hNw8bMFwPs8WEa46AMjuuVsBMZrmNaJsqpcTF9TTbQ
         t8Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXoQCAd/nycq0dhNIWK/h8LgpSBCX/qgcUp7y77TyAw+wmOuifwF5ijOBgM4XczIL/4MhNNcIkmNl/uS7ZDlaWsp76fr8bFoEVRTq9ZtA==
X-Gm-Message-State: AOJu0Yx3V3M/aQ5QNE8c1Lyud2qDUydM43Vo8YArFAsUldyDMu5Rtr3T
	LGisRP2r30xhsfFnpV+xMiyKmCijXqeBej61jfse04dLuIrHGx9XlcQhq6g5XIQ=
X-Google-Smtp-Source: AGHT+IEJyMAMyA8U3woOzIEEj3JSvwjQmFqO5kjZauXzQokagOUrsDyTtU+QTE5PXpZ2YP7fpxx74w==
X-Received: by 2002:a05:6358:6f15:b0:1b1:a666:2bba with SMTP id e5c5f4694b2df-1b1aad5368dmr492206355d.24.1723670764131;
        Wed, 14 Aug 2024 14:26:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe06fdfsm642966d6.34.2024.08.14.14.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:03 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 00/16] fanotify: add pre-content hooks
Date: Wed, 14 Aug 2024 17:25:18 -0400
Message-ID: <cover.1723670362.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3: https://lore.kernel.org/linux-fsdevel/cover.1723228772.git.josef@toxicpanda.com/
v2: https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@toxicpanda.com/
v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/

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

Josef Bacik (8):
  fanotify: don't skip extra event info if no info_mode is set
  fanotify: add a helper to check for pre content events
  fanotify: disable readahead if we have pre-content watches
  mm: don't allow huge faults for files with pre content watches
  fsnotify: generate pre-content permission event on page fault
  bcachefs: add pre-content fsnotify hook to fault
  gfs2: add pre-content fsnotify hook to fault
  xfs: add pre-content fsnotify hook for write faults

 fs/bcachefs/fs-io-pagecache.c      |   4 +
 fs/gfs2/file.c                     |   4 +
 fs/namei.c                         |   9 ++
 fs/notify/fanotify/fanotify.c      |  32 ++++++--
 fs/notify/fanotify/fanotify.h      |  20 +++++
 fs/notify/fanotify/fanotify_user.c | 116 +++++++++++++++++++++-----
 fs/notify/fsnotify.c               |  14 +++-
 fs/xfs/xfs_file.c                  |   4 +
 include/linux/fanotify.h           |  20 +++--
 include/linux/fsnotify.h           |  54 ++++++++++--
 include/linux/fsnotify_backend.h   |  59 ++++++++++++-
 include/linux/mm.h                 |   1 +
 include/uapi/linux/fanotify.h      |  17 ++++
 mm/filemap.c                       | 128 +++++++++++++++++++++++++++--
 mm/memory.c                        |  22 +++++
 mm/readahead.c                     |  13 +++
 security/selinux/hooks.c           |   3 +-
 17 files changed, 469 insertions(+), 51 deletions(-)

-- 
2.43.0


