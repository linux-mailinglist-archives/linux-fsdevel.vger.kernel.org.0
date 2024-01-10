Return-Path: <linux-fsdevel+bounces-7727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45A7829E9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 17:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746221F251E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D5F4CB4E;
	Wed, 10 Jan 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKNe8sSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575264439B;
	Wed, 10 Jan 2024 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e461c1f5cso39369415e9.3;
        Wed, 10 Jan 2024 08:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704904145; x=1705508945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYhs5kBzLpHa7nfxElLc7f+8hwZgrm0a/n3jZ3lJWbI=;
        b=jKNe8sSY8IbZRu8GlEerTEFyrkxZB0aS1DVtyyF8clbe/24lEgYBsgQEThN3RgKwWF
         odutLepiq5YN79Ge1QXfAdvpJoS1UYdqWMusTdrxVjlywssNNDAjNOSTdEqTYQs8YFPe
         GIdVKE/6zlniXt8ctHfmE9KzxlBfJcU7L33MhbIT75SwbV1acWI1Y1PeO+GuFj3qXhL0
         kic/94kIK3Y2GlvzWTkIOfSw1XCnbr4DGHzO+SC/ao+tD4BctQm3/ZDdgUsLYd1FRvvh
         WqcpwkI8DzeSf7/Ngc98JL/MnG7RyMZlcsM6pWPT1mz7URJFAsap1O26yDyBE2RMawa7
         Mfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704904145; x=1705508945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYhs5kBzLpHa7nfxElLc7f+8hwZgrm0a/n3jZ3lJWbI=;
        b=hkF5QOHzlQ3gMEAyiZVrAneYkr9EMfY+AyCeCIPO+srM/XyG+SE3TpTvzgZEuPY8YB
         oU5nVQ3ToGaav88MI59lRZqkoFCj2kdsM72dZ5+DxiR8O+wO7zuVFev5q+7Zuwrx0NQy
         ghetnFZzqSofwaqbmjNRSh9ecJ3+Uv66Rej1JHX9C3h/8txrw6HN7Oqh9miUj2fEtVW0
         wQrQk6ySh1pGv27eCAzY6dWVsoZ3oh1Ax8gyrI8yQUEMJlZFGkuwsMzYwMcXwpjRz7Rj
         AE5On8E41yNulWUMz1Nu1IlJLifO+oCyU4aCmUQ7kj1JTsBCkqq7vHMQrDNd1X5gUtuA
         +D0g==
X-Gm-Message-State: AOJu0YyYb2sjTvKnhNxTJ8u5ug88TSWdAlOgpBPTZ/0Q+IraoKlSIUSV
	sL4qcd/hoF4sl2bkfeFZ89tcNL6ajgA=
X-Google-Smtp-Source: AGHT+IEeiu2Ep8vaqs2OqZuOyjc6PpxtgZTxdqYicHmlfPPueKR2XPXUAWsxTkHJtJDPnv16exLt1A==
X-Received: by 2002:a05:600c:54e3:b0:40e:55a5:85f0 with SMTP id jb3-20020a05600c54e300b0040e55a585f0mr522093wmb.87.1704904145171;
        Wed, 10 Jan 2024 08:29:05 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id s3-20020adff803000000b00336843ae919sm5215839wrp.49.2024.01.10.08.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 08:29:04 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs updates for 6.8
Date: Wed, 10 Jan 2024 18:29:00 +0200
Message-Id: <20240110162900.174626-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull overlayfs updates for 6.8.

This is a very small update with no bug fixes and no new features.

The larger update of overlayfs for this cycle, the re-factoring
of overlayfs code into generic backing_file helpers, was already
merged via a PR that I had sent Christian before the merge window.

This branch has been sitting in linux-next for a few weeks and
it has gone through the usual overlayfs test routines.

The branch merges cleanly with master branch of the moment.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.8

for you to fetch changes up to d17bb4620f90f81d8a8a45c3d025c679a1b5efcd:

  overlayfs.rst: fix ReST formatting (2023-12-15 12:31:36 +0200)

----------------------------------------------------------------
overlayfs updates for 6.8

- Simplify/clarify some code

  No bug fixes here, just some changes following questions from Al
  about overlayfs code that could be a little more simple to follow.

- Overlayfs documentation style fixes

  Mainly fixes for ReST formatting suggested by documentation developers.

----------------------------------------------------------------
Amir Goldstein (4):
      ovl: remove redundant ofs->indexdir member
      ovl: initialize ovl_copy_up_ctx.destname inside ovl_do_copy_up()
      overlayfs.rst: use consistent feature names
      overlayfs.rst: fix ReST formatting

 Documentation/filesystems/overlayfs.rst | 104 +++++++++++++++++---------------
 fs/overlayfs/copy_up.c                  |   8 ++-
 fs/overlayfs/export.c                   |   4 +-
 fs/overlayfs/namei.c                    |   4 +-
 fs/overlayfs/ovl_entry.h                |   5 +-
 fs/overlayfs/params.c                   |   2 -
 fs/overlayfs/readdir.c                  |   2 +-
 fs/overlayfs/super.c                    |  19 +++---
 fs/overlayfs/util.c                     |   2 +-
 9 files changed, 76 insertions(+), 74 deletions(-)

