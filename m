Return-Path: <linux-fsdevel+bounces-24267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6D893C83E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 20:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0BA1F21ED4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 18:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EAE24B2A;
	Thu, 25 Jul 2024 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="AddOukWJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962B1F959
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931608; cv=none; b=n+fYv9GNXRIPPhUdk7EgG9FZMBEgh/t6qf/lGp0Dg/aFqAxyZdY29GEeUWyHcWVu2VKrVhFpSZXFPIwsuhO4fCZ4swpY/5MNZ/xM8CNo89zy/D7MzD2+Hg6WVKOSI27OStEHca8cYLwWeWOfaJSPwhLSeLv24yx3MD82DyoGVSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931608; c=relaxed/simple;
	bh=NjQmy1bwbiClBPDz43WadrqFRQx3SBd86x5mEZy490U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=V6inHT7yqPOa/ZuwsDERdFXqGeUZhgCfqjk95iOavS2532LMINLrOdWmJTtHcAzsPR9hodHdW3oxjKcrJXs7dkG/W0Ia+a6e8GgHYJjpPtztVjWinNo2hNXARGoFWONVPHKNuS9mPUARHXfTxcGYtSDEpMKV2GjBT77d05SKp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=AddOukWJ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b7a0ef0dfcso6569216d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721931605; x=1722536405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gtG9jyJTqAnVyMaXZTe/CHTxwyIGBl2L52MBmnPvjho=;
        b=AddOukWJReAsvqE9vlfxdMz9noVjjG+aKUlqM1oGq5ztqrvcvx9T+CcPmHKOZ0Sarg
         vyVD8UQkQBDS+g8J/TvmTB3txM5kpr/gA1tGxnTHmtViSsIfuUw+8cYZEEJxmui92zkU
         cFGW0vru1wCTnO6EoBCnNfg+gIw2YLrsGFNWKC3pp+emQBT40SiouvDL67gx1O3E1wrj
         8jGV93cGVskBL2LgFjG9cMDZg16B/vkSBjTtJITCnK7Ibrr4ek/Ng0BhhhQwysazCDff
         HXEW/tS+ObEZhNp+vED6RXUt70q4Yc4AOXImNMgtKCiR+Pb7wRApv3pXOtiJd3Nlbq0k
         ZFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931605; x=1722536405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtG9jyJTqAnVyMaXZTe/CHTxwyIGBl2L52MBmnPvjho=;
        b=gIE7pVPuI2z4EUKPdgtZ1SzH7RuBDPCGSuOOvZgxWHst0skGfMhCAfbZ9o9hj2MM5k
         c5X4MRB5theq/taexhFpwdCbiqXWXJX72n9qPZN2tvPqMEbv38g4KXkj1iY/CbCakgxL
         t7fKZrvocQAHtY55RtT4/gKa2Wp61z5/Dxjj8N7rkrCC86C+Fq7dai86X1a4wWHmYaSO
         ayoVmLF2teHKx8S6KeVRh9ZyRh5PEbx3AY7SMzeqaOEOBFinGsILsmj9SrLIrc0uAP99
         +6Te1mn+AZETOuj5iayZL+nyiBIlXueY9Cga2be4svhvG4LTNvlNIiprHkF6W5LrzMtU
         FeCA==
X-Forwarded-Encrypted: i=1; AJvYcCWKtySUB523gA7CozB1sHl+FdfIgRGkeFo6oxTCyDOc6CUedKkRny0NA9+LGVQnv+srBZMeoEW25QnZAqfZco5sjt314oZHYw7kgYY1nA==
X-Gm-Message-State: AOJu0Yx+KZCCyTVgcLnd+wZI+6Wo12dEzQLHsDETaAgHMfvWTIgdWEJa
	w/joLU0lNghAoc3RM0nib5kWsKADNVbiOrerJ0UrHHBuL2w5Cz0V6H5ZNgWcKXI=
X-Google-Smtp-Source: AGHT+IHHuA6aY+9tnwAuMt/CHte6b2v9GA3AXrVu5XwpsKo8s09j8oOIo8skP/JFQm2KyhA1SQgomg==
X-Received: by 2002:a05:6214:250a:b0:6b7:9b14:626e with SMTP id 6a1803df08f44-6bb3cb24574mr48470436d6.57.1721931605196;
        Thu, 25 Jul 2024 11:20:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8fb938sm9612376d6.47.2024.07.25.11.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:20:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org
Subject: [PATCH 00/10] fanotify: add pre-content hooks
Date: Thu, 25 Jul 2024 14:19:37 -0400
Message-ID: <cover.1721931241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Josef Bacik (2):
  fanotify: don't skip extra event info if no info_mode is set
  fsnotify: generate pre-content permission event on page fault

 fs/namei.c                         |   9 +++
 fs/notify/fanotify/fanotify.c      |  29 ++++++--
 fs/notify/fanotify/fanotify.h      |  10 +++
 fs/notify/fanotify/fanotify_user.c | 111 +++++++++++++++++++++++------
 fs/notify/fsnotify.c               |  15 +++-
 include/linux/fanotify.h           |  24 +++++--
 include/linux/fsnotify.h           |  54 ++++++++++++--
 include/linux/fsnotify_backend.h   |  59 ++++++++++++++-
 include/uapi/linux/fanotify.h      |  17 +++++
 mm/filemap.c                       |  50 +++++++++++--
 security/selinux/hooks.c           |   3 +-
 11 files changed, 335 insertions(+), 46 deletions(-)

-- 
2.43.0


