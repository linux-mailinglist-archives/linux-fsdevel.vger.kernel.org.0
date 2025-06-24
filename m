Return-Path: <linux-fsdevel+bounces-52660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2197AE59C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE10F3B5ED9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F6204C36;
	Tue, 24 Jun 2025 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACEwRa3Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AED35942;
	Tue, 24 Jun 2025 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731780; cv=none; b=GJWXiHBoRKTB2Zd0yAd+G+TQ+jlfHtrKD1fEGS/TClfTX8pVpFD+ogj3tUUkkLAw4t3VmPYGtVmv+9UadVJrD1d8i2K6Hx31xinbCKM/tJGwUdfG4XVTyVkSHvarTRxA0gk/VfRsJtjHvueix1RdbyuSe3SlYuH3wMzvP8zgG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731780; c=relaxed/simple;
	bh=Zkxit9aDe3QDjV0avyWQyXjfEcdh3Izbfk6AaNlXSzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nyq0TqxZ64yd0nmR9a8WSwio2foQIb9RrntAUxcWr99kexPv9QChQN+lbv/gr0MVEkuA+lzfa/KjKfDLtjUahMG4HyHGhosjxZB0uenK3MEuSjqZokgAOCgzt4hmwUgn3lhC5+VEYqgcXVFfda1T49gjsiBSbIITVmW8hdcppMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACEwRa3Q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235ea292956so51436525ad.1;
        Mon, 23 Jun 2025 19:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731777; x=1751336577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8jUzS6DowcSpgl/rd8s76ozHCEh2xL61ewFyP0TWqmU=;
        b=ACEwRa3QKZkLyzIApK2+tNzcGXG1/KA1ygCN/YPWJ8XKHC64plnXbYGpgVGbyKqq+U
         e+3C11BLIYG6jMgqbTGix6V57/RE0t+3TbhV/kf8Q2SfP7ZiK4B43vDlut785SEeAWCH
         SNgkZtPSqCUAXONWvvgf9Pd9SHazqF6/8wfCqGSQ+ge5NmrojiVQi9bCL1D3cb/A4uLn
         ntONUYCFvTOmM7d3AZ7rOS4YAhfH1wd48c3wIqFyrKfboXJczG73rVB/TRorzwYDuKQn
         B3nZprsrxsbTdesaXeAM+7iZBFT5343hXK0oQ9GH5qW3h8YvCIK0BQJ5QPVbJgm5ik2B
         l9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731777; x=1751336577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jUzS6DowcSpgl/rd8s76ozHCEh2xL61ewFyP0TWqmU=;
        b=oemr2H4L0bGaUl+PkJE9sjkDKR+h/I5PtwnQNNV969KmLDqSlyGHv9TB0SX1g7KWlV
         Xlw8KF90lNGKMVmqNRYd3dO5BE4k03gxzlp+thC68bX0iI0R2ke6WD35IKshhcKpMA0I
         Hu/svijzttMRKmcUiPtsW3usZ4XRD/G17PieiM5KIpNOvhx5JKBMJyyuDmj/hqKMtfkB
         /tPIu1BceIgdLqU606TP02DHIbqMrWqOjBHNdf8BuFywZPGczfhX5GIv8lOpmJadDjoV
         js13z6Jzk2wmVllvoTGurXuz0dnY6IGNfHccUeZaLq/rhiM8jlA43kRFqwpGKqOyz9pB
         AfTw==
X-Forwarded-Encrypted: i=1; AJvYcCUCWApB1x4KOMl/nEh09HkHVlBP1QDywWQYCl79Cig2DaJzcgfwXqO9RTYKUYEK8J6RGI+4UgjW+40i@vger.kernel.org, AJvYcCUGEU7SfDmI1OI5k4bM6L0Rf3l/t6a4dQksA7O3dUEr9CC8uTeDNaukK6QYCv1MKFs7lh0dXbBXwih9+g==@vger.kernel.org, AJvYcCW8keCcv/1kG76Xfja5nLw8gRn1VU+zHOzuzrE2F/2XGqMZdTm8iOVH9rsC/uYreRwtujbzhOC368w1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk0Ijq12QMt/upry0O9CTzcF1tPrqlkDhvazgSsOCZQrVEvJN8
	kUZTiqdDpDMuxdNLb/jmTA+sZvK9IM1XxleSNE3EDFlcoFwktjdJ2pPxnRbvZA==
X-Gm-Gg: ASbGncs9IHAP9ScAuFfuXlMzjYtP0EitVwBX6MJJwraPLU2xdSXKcrwe06DyIjeyg7q
	5lYnfy8Qr9LWgbnSR1W6ass9/c/b4n1bPMzgKPp6ndERpMK6trZS3KCvAF3dzeuU/tpOUEojTY6
	RY+ifvvpYlac/SiwsITuGBF/VVZ3Jr/pi2DTFkbmvXvisi/4pVsnBPKWNL40akTfhksGhVOVIgn
	b8IjlFncxr/BibRQ7tFlLh4Q0WttRGFAC+3hK6EXRk3h4bzuwx3++I+xWEc7v22H5F0J+sFk1B0
	WbHMDOV8oRrzVlYUA6a8oChe34TxkXFDp26av3a+1hwPhvzYwbCkmh03
X-Google-Smtp-Source: AGHT+IHvoU587O1IfrDZ3oGsbMtevcv2Y/aQl7ISv9kHOlRxcRFEcp7DGfGYSrvCNryQwn+oKSH7Sg==
X-Received: by 2002:a17:902:ebc1:b0:234:8c64:7885 with SMTP id d9443c01a7336-237d9baeb72mr230304865ad.53.1750731777286;
        Mon, 23 Jun 2025 19:22:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8695195sm97070855ad.187.2025.06.23.19.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:22:57 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 00/16] fuse: use iomap for buffered writes + writeback
Date: Mon, 23 Jun 2025 19:21:19 -0700
Message-ID: <20250624022135.832899-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds fuse iomap support for buffered writes and dirty folio
writeback. This is needed so that granular uptodate and dirty tracking can
be used in fuse when large folios are enabled. This has two big advantages.
For writes, instead of the entire folio needing to be read into the page
cache, only the relevant portions need to be. For writeback, only the
dirty portions need to be written back instead of the entire folio.

This patchset is composed of two parts:
a) Christoph's iomap changes (patches 1 to 11) which are taken verbatim
   from [1]
b) fuse changes to use iomap (patches 12 to 16)

Please note the following:
* this patchset version temporarily drops the CONFIG_BLOCK iomap refactoring
  patches that will be needed to merge in the series. As of now, this breaks
  compilation for environments where CONFIG_BLOCK is not set, but the
  CONFIG_BLOCK iomap changes will be re-added back in once the core changes
  in this patchset are ready to go.
* this patchset does not enable large folios yet. That will be sent out in a
  separate future patchset.

This series is on top of commit 86731a2a6 ("Linux 6.16-rc3") in the linux
tree.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250617105514.3393938-1-hch@lst.de/


Changeset
-------
v2 -> v3:
* Fix up fuse patches to use iomap APIs from Christoph's patches
* Drop CONFIG_BLOCK patches
* Add patch to use iomap for invalidation and partial uptodateness check
* Add patch for refactoring fuse writeback to use iomap_writepage_ctx inode
v2: https://lore.kernel.org/linux-fsdevel/20250613214642.2903225-1-joannelkoong@gmail.com/

v1 -> v2:
* Drop IOMAP_IN_MEM type and just use IOMAP_MAPPED for fuse
* Separate out new helper functions added to iomap into separate commits
* Update iomap documentation
* Clean up iomap_writeback_dirty_folio() locking logic w/ christoph's
  recommendation 
* Refactor ->map_blocks() to generic ->writeback_folio()
* Refactor ->submit_ioend() to generic ->writeback_complete()
* Add patch for changing 'count' to 'async_writeback'
* Rebase commits onto linux branch instead of fuse branch
v1: https://lore.kernel.org/linux-fsdevel/20250606233803.1421259-1-joannelkoong@gmail.com/


Christoph Hellwig (7):
  iomap: pass more arguments using struct iomap_writepage_ctx
  iomap: refactor the writeback interface
  iomap: hide ioends from the generic writeback code
  iomap: move all ioend handling to ioend.c
  iomap: rename iomap_writepage_map to iomap_writeback_folio
  iomap: export iomap_writeback_folio
  iomap: replace iomap_folio_ops with iomap_write_ops

Joanne Koong (9):
  iomap: cleanup the pending writeback tracking in
    iomap_writepage_map_blocks
  iomap: add public helpers for uptodate state manipulation
  iomap: move folio_unlock out of iomap_writeback_folio
  iomap: add read_folio_range() handler for buffered writes
  fuse: use iomap for buffered writes
  fuse: use iomap for writeback
  fuse: use iomap for folio laundering
  fuse: hook into iomap for invalidating and checking partial
    uptodateness
  fuse: refactor writeback to use iomap_writepage_ctx inode

 Documentation/filesystems/iomap/design.rst    |   3 -
 .../filesystems/iomap/operations.rst          |  51 +-
 block/fops.c                                  |  37 +-
 fs/fuse/Kconfig                               |   1 +
 fs/fuse/file.c                                | 327 ++++++-------
 fs/gfs2/aops.c                                |   8 +-
 fs/gfs2/bmap.c                                |  48 +-
 fs/gfs2/bmap.h                                |   1 +
 fs/gfs2/file.c                                |   3 +-
 fs/iomap/buffered-io.c                        | 438 +++++-------------
 fs/iomap/internal.h                           |   1 -
 fs/iomap/ioend.c                              | 220 ++++++++-
 fs/iomap/trace.h                              |   2 +-
 fs/xfs/xfs_aops.c                             | 238 ++++++----
 fs/xfs/xfs_file.c                             |   6 +-
 fs/xfs/xfs_iomap.c                            |  12 +-
 fs/xfs/xfs_iomap.h                            |   1 +
 fs/xfs/xfs_reflink.c                          |   3 +-
 fs/zonefs/file.c                              |  40 +-
 include/linux/iomap.h                         |  81 ++--
 20 files changed, 775 insertions(+), 746 deletions(-)

-- 
2.47.1


