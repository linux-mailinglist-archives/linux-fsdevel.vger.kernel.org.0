Return-Path: <linux-fsdevel+bounces-25557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE5B94D687
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 20:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3AB1F22B26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E26155CBD;
	Fri,  9 Aug 2024 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TzhFPzmn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F883629E4
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229095; cv=none; b=VM8QPdUaSZjxYL93C7LfBwyYcunQ332MaXs7CZkKfNnRfEBxuLna1nmqMB2BItPKeX50Lk7rlYEQtqyIrgeixcci2R+cxYGcktDHbPRASq7z/F9Hoim9W42rYBkU36vHTzlXSMdx6Ixw4JUSLDxPfEXLj1sd0uXWozKz7jW/3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229095; c=relaxed/simple;
	bh=5TGwiTQjNXlGePzR5Q/mJD0pdX/O9bNYb4K7xod+MjI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=epWwHsJe1JvIWEW4gsLQzWDN05ludZ7ftxoYDCp45AgSIuHb7E5xAkECoHL9UiKOw6kdKNZqITvO2vpRhSd9MmtcxZQgwxHWSbu908pkihgyIf+0CJaIyFZPlxY4/tfV5eOzlKRa4HsQ6MGcMoVtqsNei9sF7ouzHjsJTjhaFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=TzhFPzmn; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bd777e6623so5310666d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 11:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229093; x=1723833893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d1PZznfHxR4p21j9WCsE102uMWDO9dI2o6sLe8vY6Nc=;
        b=TzhFPzmnb5oCMSZr3YMzMO4ErevoD8JHT5jg+G2HhvwH7ib5vwiuz1TCWp5Z2PMjYF
         8/9oRngpccsEC5GY0XtHqwAI7wIfEcxHMkpwP0q56UFd4cHjsUBqMgEW3FlgK3DL/PdI
         X57oVjVlSEguURLWdFmkJp51mE6cAh+e7OXDvXwSj/fUAlnyik/r5l4gumdTRkivX4WT
         bpWhX0Hu5cq7REeYMU4e0w5WdagjH6YFVZ0Spaco00fjuaMOGMZTVrruVX1JmsKhBhwK
         xxfGryUG3s3np2/miDsc80UWyZPGAjy2ZmiyRpALW+PBb1Q8TNB2+EgvzmBPahzJn3Rd
         niWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229093; x=1723833893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1PZznfHxR4p21j9WCsE102uMWDO9dI2o6sLe8vY6Nc=;
        b=nGUhx1oLbVF5NcHS7FmvRytojMfsDQlY+wRNAsxUMUUp/484JXgRzH6dweypKidWpJ
         Ahie8ccMtoQg9yo7bY4ZmwGrsi9A4HdUMhd70jyZnI3bAQgt+YL3i+EH0ObhikKvQpW+
         ohMpd+4XBn5gxwVvQy+xBlcQToPRa+o0ZCshuntDiJBBpsIHUwkXloOUJr/4zpi1X8/M
         sUcoJ98YdrE97rRC8xx3MZcU01zV0+W7pEgF0HqMgQrxjUcuCdlt6zts68X6vE1NJq05
         12ddxyV8v4Xb2SQVdiLjfh45l0X7pSfZHzole9LKVFITvU6JwPAucZP9qegrr5h48pbZ
         UGmw==
X-Forwarded-Encrypted: i=1; AJvYcCUa3iy4JpOQEtP7oFWlTYsQMEt9lylo5wCuuxLSeFr6d+gA0e6U0+czYs8cc8mhhZsqgcAdVP7azDgF4BdFWnPzRq1XeyKc/Ppb9FjKug==
X-Gm-Message-State: AOJu0Yx6coErXQxkRjbUbLB7GebQaZcYdErYiJsqK/rDnnbmVjhnJ3T6
	NJGidVkla7VWa18fuPvFuzuKJLdz+KZuiMLt+5Uyeqy4Mz9OC2o0EP3XiUkl+4I=
X-Google-Smtp-Source: AGHT+IFCcjPOlhBGCaWxyvOvSFsmzbg18+aGJmls0mZABl+rwgLrcJr3kubzK0fWN3U917IWZZunow==
X-Received: by 2002:a05:6214:419c:b0:6b5:d9ef:d56d with SMTP id 6a1803df08f44-6bd78d22066mr25219086d6.21.1723229092962;
        Fri, 09 Aug 2024 11:44:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e2f53asm612216d6.96.2024.08.09.11.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:44:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 00/16] fanotify: add pre-content hooks
Date: Fri,  9 Aug 2024 14:44:08 -0400
Message-ID: <cover.1723228772.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@toxicpanda.com/
v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/

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
 fs/notify/fanotify/fanotify.c      |  32 +++++--
 fs/notify/fanotify/fanotify.h      |  20 +++++
 fs/notify/fanotify/fanotify_user.c | 116 ++++++++++++++++++++-----
 fs/notify/fsnotify.c               |  14 ++-
 fs/xfs/xfs_file.c                  |   9 +-
 include/linux/fanotify.h           |  20 +++--
 include/linux/fsnotify.h           |  54 ++++++++++--
 include/linux/fsnotify_backend.h   |  59 ++++++++++++-
 include/linux/mm.h                 |   1 +
 include/uapi/linux/fanotify.h      |  17 ++++
 mm/filemap.c                       | 134 +++++++++++++++++++++++++++--
 mm/memory.c                        |  22 +++++
 mm/readahead.c                     |  13 +++
 security/selinux/hooks.c           |   3 +-
 17 files changed, 478 insertions(+), 53 deletions(-)

-- 
2.43.0


