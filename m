Return-Path: <linux-fsdevel+bounces-70288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E400C95A62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 04:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3112B3A1CA0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 03:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8961CDFCA;
	Mon,  1 Dec 2025 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="XEFgMNEW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3C1C84DE
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764560177; cv=none; b=ODpObJ7+GpaEXL++rUYH1mSyNmGCeT2vzLcZv7C9xEaq3H6mucgOnUEhpdyKMIXjlF7KaQpYWDaczr9AFMXisIw7k/CWSy13YSNYyIVP1yDHcD3gyuMhkWcTK3CfFKzU/BEB+KgNxIOxDhZalTweVBVIwQys3vDQfU045p316/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764560177; c=relaxed/simple;
	bh=tJLa5AM6oAqmVof+aEsmAnJCxRcblueQF0lj4DahY9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=mK8MwJ+FtnkAMPElR1BT3AmggOSir/QAfYdWP/ocqWRUe9E5sW/PgLayJFYPFp4yamxBW4oRJyhzalIDWlIH4XDDLix8DpONDvrs7jqhqLW+mOoKlYHRB2fZv3UrgTEqulr19waiD6RdmIdWhkS8ARa+1CiFuQq6imj79ZrPi2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=XEFgMNEW; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6420c08f886so4371419d50.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Nov 2025 19:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1764560174; x=1765164974; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cOP1H9oHt1UwbiTbZmsfdp8TbrLEbMJnMs3NEd7hiw=;
        b=XEFgMNEWY9TU4mVm2TPHCfFSlXfZnjMC8anijSqKtyzeBxdNtz8B6Hpd1mzJmFm00J
         WxPepz1/0UxkT6HTNVGfhQSZ4r20FNWqlqGZSnzh8tBDla1TvvRZ4G2E0qFgM0yq8PqA
         7cUgXZmZP0l1Fk8LLbE9yzF1a43ohLGRTT6DDAFbRdW3qw3P0lp7T+RXBlvG0ntL30uh
         mAcpe/5gfgKmFJBIWX1gup3mQvpicjdGCu+/xVlL6X+quTSL7tGuT3eZCMToKRs/KHSg
         eFO7NTr5pZBli2o1al/ueHL+YEka/lANvQtQXc0jbdbHghavHoTBbdNfjqK7RiSh68LQ
         OY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764560174; x=1765164974;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cOP1H9oHt1UwbiTbZmsfdp8TbrLEbMJnMs3NEd7hiw=;
        b=cgMpXa/yU6FKGFX7PcgJDCTFcFRDoup1EyfInmf1ons6bXawxnyvcth91CJhVWi+We
         LcJnlnd9FAa5EBmHXklh4SjmGIpdivczO66WJn1Osm24CA0g/UzgL1qZUZXYbnN/sgNm
         Kkh+nnewkm8IFjKsDHz/8FtDODzekrINieTD5YIYNvDGUFs8miqfCkzh3lb1HAworFfy
         ijIfTytTsyY2fspGg2XeFx8rQpX4s44s9cf9amzJ8ofr7/ZQf+smdM6HMW8YsW85n5ad
         Lmlgryum9bNYQwAk3wvPOnj0+uLIn2Smx7xbFMAm/M5jyBeF9qV1HZjqjVSagJJGEC6n
         dccA==
X-Gm-Message-State: AOJu0Yxe8laocSc4CdMTMarBXbopkd4ESekOQ4HwiwAKh78zisWlG29h
	5Fx3xOFAW+t3Mz1f7MB+xxmkWoFiNd29OSiRThDD0o3tTY9SU1yxggryNtcsYR9PUaW9hifKT6J
	iw5x6
X-Gm-Gg: ASbGncvCOamQYjUC95mjRRqg0HHERbAfbfiXPyJ0jCV0oqOVKizTd9YY0rRdhicn4XA
	XsJ2g5noXhVxdgBVYkZtp61s+fB++BlovztdEqRFeolXn2AOzUZjusnZIaOyPpveCTILOLylQLE
	NemasV71f+enzCmNVXLfnMOlLIo9X6ToAxT4KGNUsRAHKmPP1ppNqXA0aHE/agEUkKn52SE3mqF
	bM3nNRrK6yx5geMKS8P+q3IiPN8l8QsJdeoS8Xj7G7BVI6Wh+Ex7x0sM3zsKaY3360raDrzpSES
	STAd2A4s+03EyMCg+AVnQ319pmYqkHismHGV0kKLewxjhxLPigioq6O7qxjwXIpTmCggYw57IYa
	BZbFbFWz/uJ2ThaPoQGimgrt0TeHpWOYvRF40B5g1UgXIFXyuzXuukAlwzJa3hj9RsxOaQuIgAy
	2p+MDpfHmtDZgJA8qbqOtP0zOw4rFLvNmxODi3WFZ9QsY5PFucz6tP4mTKBWU=
X-Google-Smtp-Source: AGHT+IEGIeaQf/pn9Adm5tm+gtUMFp+L1iSaoyO8s9DJil7tKzkc/RC/iVXwsXuuLYrri5jPMgzs3w==
X-Received: by 2002:a05:690c:6186:b0:787:ec83:5d0e with SMTP id 00721157ae682-78a8b568053mr321853237b3.60.1764560174434;
        Sun, 30 Nov 2025 19:36:14 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:e276:f0e2:e720:695d? ([2600:1700:6476:1430:e276:f0e2:e720:695d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad1044f9esm43693827b3.56.2025.11.30.19.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 19:36:13 -0800 (PST)
Message-ID: <dd3e422fdf1624d4275723eb14935400b002f031.camel@dubeyko.com>
Subject: [GIT PULL] hfs/hfsplus changes for 6.19-rc1
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: torvalds@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, dan.carpenter@linaro.org, 
	penguin-kernel@I-love.SAKURA.ne.jp, yang.chenzhi@vivo.com
Date: Sun, 30 Nov 2025 19:36:12 -0800
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Linus,

This pull request contains several fixes of syzbot reported
issues, HFS/HFS+ fixes of xfstests failures, Kunit-based unit-tests
introduction, and code cleanup.

Dan Carpenter has fixed the potential use-after-free issue
in hfs_correct_next_unused_CNID() method. Tetsuo Handa has made
nice fix of syzbot reported issue related to incorrect
inode->i_mode management if volume has been corrupted somehow.
Yang Chenzhi has made really good fix of potential race
condition in __hfs_bnode_create() method for HFS+ file system.

Several patches fix the xfstests failures. Particularly, generic/070,
generic/073, and generic/101 test-cases can be finished successfully
for the case of HFS+ file system right now.

HFS and HFS+ drivers share multiple structures of on-disk layout
declarations. Some structures are used without any change. However,
we had two independent declarations of the same structures in
HFS and HFS+ drivers. The on-disk layout declarations have been moved
into include/linux/hfs_common.h with the goal to exclude the
declarations duplication and to keep the HFS/HFS+ on-disk layout
declarations in one place. Also, this patch prepares
the basis for creating a hfslib that can aggregate common
functionality without necessity to duplicate the same code
in HFS and HFS+ drivers.

HFS/HFS+ really need unit-tests because of multiple xfstests
failures. The first two patches introduce Kunit-based unit-tests
for the case string operations in HFS/HFS+ file system drivers.

The following changes since commit
3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
tags/hfs-v6.19-tag1

for you to fetch changes up to
ec95cd103c3a1e2567927014e4a710416cde3e52:

  hfs/hfsplus: move on-disk layout declarations into hfs_common.h
(2025-11-25 15:16:03 -0800)

----------------------------------------------------------------
hfs/hfsplus updates for v6.19

- hfs/hfsplus: move on-disk layout declarations into hfs_common.h
- hfsplus: fix volume corruption issue for generic/101
- hfsplus: introduce KUnit tests for HFS+ string operations
- hfs: introduce KUnit tests for HFS string operations
- hfsplus: fix volume corruption issue for generic/073
- hfsplus: Verify inode mode when loading from disk
- hfsplus: fix volume corruption issue for generic/070
- hfs/hfsplus: prevent getting negative values of offset/length
- hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_create
- hfs: fix potential use after free in hfs_correct_next_unused_CNID()

----------------------------------------------------------------
Dan Carpenter (1):
      hfs: fix potential use after free in
hfs_correct_next_unused_CNID()

Tetsuo Handa (1):
      hfsplus: Verify inode mode when loading from disk

Viacheslav Dubeyko (7):
      hfs/hfsplus: prevent getting negative values of offset/length
      hfsplus: fix volume corruption issue for generic/070
      hfsplus: fix volume corruption issue for generic/073
      hfs: introduce KUnit tests for HFS string operations
      hfsplus: introduce KUnit tests for HFS+ string operations
      hfsplus: fix volume corruption issue for generic/101
      hfs/hfsplus: move on-disk layout declarations into hfs_common.h

Yang Chenzhi (1):
      hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_create

 fs/hfs/.kunitconfig        |    7 +
 fs/hfs/Kconfig             |   15 +
 fs/hfs/Makefile            |    2 +
 fs/hfs/bfind.c             |    2 +-
 fs/hfs/bnode.c             |   52 +-
 fs/hfs/brec.c              |    2 +-
 fs/hfs/btree.c             |    2 +-
 fs/hfs/btree.h             |  113 +---
 fs/hfs/catalog.c           |    2 +-
 fs/hfs/hfs.h               |  269 +-------
 fs/hfs/hfs_fs.h            |   89 +--
 fs/hfs/inode.c             |    3 +-
 fs/hfs/string.c            |    5 +
 fs/hfs/string_test.c       |  133 ++++
 fs/hfsplus/.kunitconfig    |    8 +
 fs/hfsplus/Kconfig         |   15 +
 fs/hfsplus/Makefile        |    3 +
 fs/hfsplus/bfind.c         |    2 +-
 fs/hfsplus/bnode.c         |   64 +-
 fs/hfsplus/brec.c          |    2 +-
 fs/hfsplus/btree.c         |    2 +-
 fs/hfsplus/dir.c           |    7 +-
 fs/hfsplus/hfsplus_fs.h    |   41 +-
 fs/hfsplus/hfsplus_raw.h   |  394 +----------
 fs/hfsplus/inode.c         |   41 +-
 fs/hfsplus/super.c         |   87 ++-
 fs/hfsplus/unicode.c       |   16 +-
 fs/hfsplus/unicode_test.c  | 1579
++++++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/xattr.c         |   22 +-
 include/linux/hfs_common.h |  633 ++++++++++++++++++
 30 files changed, 2698 insertions(+), 914 deletions(-)
 create mode 100644 fs/hfs/.kunitconfig
 create mode 100644 fs/hfs/string_test.c
 create mode 100644 fs/hfsplus/.kunitconfig
 create mode 100644 fs/hfsplus/unicode_test.c

