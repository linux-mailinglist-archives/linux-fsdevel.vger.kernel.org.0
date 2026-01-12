Return-Path: <linux-fsdevel+bounces-73241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCE7D13639
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5043B304353B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277562BEFFB;
	Mon, 12 Jan 2026 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vo5iT1hB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n5EtrRwo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199E42BDC32
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229392; cv=none; b=ddEUSI3qPehIq1o1rKIlnKeES/Erg0UI6hr+RsdiPRKjyuUYknIzms3F6obmKEwRQHG2OR5XjqEppNFvHlrYOo1xyFiQ2gyJP6mMGKNVLPW9GJT0Qx0/DQwiBYyZeVrvHnur7Igg3Jz0FAbLWMuwmuZw6icLt2gwJ5vPgb6EaLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229392; c=relaxed/simple;
	bh=KR0cTxHaJS3TcZGRenZGtFBXNangwhA2X4UcgUh+yz4=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JgxOd7Z+rYIzcwINPFuX5wAftrUtCmWYd6fZfTNFcxhVTtYVG+1vfuL9ptPQNRnKxA+5M8+k+UBP4/IuqkKetRsR6b7zTtjkJ8cTmDQiKv2W9juxPdPnSMb2+4+vCmh98pnbuucGFkELfESIHMQ4Ga100lPpHue33o0qXbUJd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vo5iT1hB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n5EtrRwo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JtQ4ZpPQA3h2q2Fz6cxHWY8WGs2l4npsNwLGIggSgs8=;
	b=Vo5iT1hBv4xOyOQ6dWHNb+FvsO4hTNFUYBqbTk/Kwnb37YswByUHVscDQH7ECSyVaOmp85
	OUBkz3rCWo35kuVZzuyWYMP0wueXwgEtN/a9PD45/UqD5RLdgy9mgX1d1iiwnd7xXL9ALD
	DDfA4XSqGNAmwkuafkdDXfP7nPZyUiY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-acWEUSikNuS7mj0WCOec7Q-1; Mon, 12 Jan 2026 09:49:48 -0500
X-MC-Unique: acWEUSikNuS7mj0WCOec7Q-1
X-Mimecast-MFC-AGG-ID: acWEUSikNuS7mj0WCOec7Q_1768229386
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b807c651eefso935152166b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229386; x=1768834186; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtQ4ZpPQA3h2q2Fz6cxHWY8WGs2l4npsNwLGIggSgs8=;
        b=n5EtrRwowlfN7Y69e2VE2te5kSfFqVKETfqCjJpgf7vV/WiaPtBzuVqRrFeGVgvNO6
         G3H+cJ/GA8aAySYh7oHqd4LRlLQ7E3vd0WJ4VD1lI2E0j1/8qfrpOsxInVgpIAx53NJ/
         4TM+bQB3s2+MbnL3RxRlYLO7+OSdunU4KN4JEDNPMdnUGlw7NBP0t3XegrCw0kln/Yy6
         g24Ax+CxRQ3NUgiusvbQBCvIlJvrBWB2SYx4RWE2PKyO91BHqmDvbzZxjfCzZIJV9RSU
         R9nu4eHmBcuhCnC9glNeczKuxhT9yP+h3fNUkJdigCztUZbI5d2SF+44H07D2opeA/oH
         f0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229386; x=1768834186;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtQ4ZpPQA3h2q2Fz6cxHWY8WGs2l4npsNwLGIggSgs8=;
        b=fIewtF+lGLsyM4Q4ElCNH3XgqTiE/UEjkbrciuW6yYDtJnCW3vT/tICAjwrl/kgAD5
         xECBgHMbdVGHAe/OTlvUK6v8d+OAl94OJtFBFHK1vd1xd//NLBuhD1Yk2jBTJE42h3rI
         XOHtT1YCmxlznf3tdlV8omt+bBxSAWLM3tUHero+w5uXmWd7FEKs2IO/bmBm75wN0P5g
         NZZA+Z/mSx1C83fOM/NnXv8RhdJwaCJ0tj9drc6ucY4E8W+DhIevoCyYRk3/yZdBH2J0
         luPeoqbHqzZwue+uNX0gSH5zyYjnBhpTF+GfVPQWS8/QRbGK9uBN01dE4+U+HIFPjk26
         fvtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZmejlTMUElAE7yDilTzWou6vw+TQvkc4SCJO36YRrksVPRcs1mIc3BGWt6qQA7+4DavY+uY/pCXdsG/4u@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6mh9D+ZzEfD/aaklXYA39sEY+GKi/dE8Jtnsl+aVY9/bQhdQv
	+ndF6JRQqNVi3DuR8fgfCyPgOLAuzq2NTyYOf9CiMBCmF+3zA1r+CUNuA+tsQ+y12xzOGzL71xP
	qSM6Mi+DU9MkqbB1RoWMAlMU2TVz4nV+3e8ccSDL2OS9M1wElFNKFc/emieKufgdGvA==
X-Gm-Gg: AY/fxX5gBWp2Yj2zfJSFEz4gb8g5+g4UtaqYjqtciDo/WYbnrxep3JiJ/3e6TO48J/A
	Utea1peCsQ7gJ4RjJGX9Y3og7nKBgl/MSRCcFBeVBI5YsIe7M5btcKUPcr7bR9WUSCO6M2GYbr/
	XBDlz4YiAwFi6OyvK0y3Ttlin7fK1NvQHQ0QZktA2gkfTxOz6giK1sZeSL08LGBlk1LEgZqu2IW
	Yv7TJmbZttF4cix7TSNBg0IYQyvGeqJiHY8sKKyv0QVwADmAYdClagDCDlTICyFpROcOwnwoQt0
	z8Szg9+PMv4CN+cwd+4yBVfHWNiD037q+nHgzE0ypDVwYpRbUVIdtThJU8vKhWgHDOk6eON59QY
	=
X-Received: by 2002:a17:906:fe4c:b0:b73:826a:9102 with SMTP id a640c23a62f3a-b8444fd0a3dmr1812182866b.49.1768229386372;
        Mon, 12 Jan 2026 06:49:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEJfpQO2bUi21cHmaMt6C52aF3UlwMys3fAQFJkDRHMGLFiJve64PAQ/gKcqGFmeCzVUIjhw==
X-Received: by 2002:a17:906:fe4c:b0:b73:826a:9102 with SMTP id a640c23a62f3a-b8444fd0a3dmr1812179366b.49.1768229385851;
        Mon, 12 Jan 2026 06:49:45 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4484sm18054453a12.7.2026.01.12.06.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:49:45 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:49:44 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 0/23] fs-verity support for XFS with post EOF merkle tree
Message-ID: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

This patch series adds fs-verity support for XFS. This version stores
merkle tree beyond end of the file, the same way as ext4 does it. The
verity descriptor is stored at the tail of the merkle tree.

The patchset starts with a few fs-verity preparation patches. Then, a few
patches to allow iomap to work in post EOF region. The XFS fs-verity
implementation follows.

Preallocations. The preallocations are disabled for fs-verity files. If
inode is fs-verity one the allocation size is set to zero. This is fine
as the only writing happening is merkle tree data and descriptor. It
would be nice to allocate tree size on first write, this could be
improved in the future.

The tree is read by iomap into page cache at offset 1 << 53. This is far
enough to handle any supported file size.

Testing. The -g verity is passing for 1k, 8k and 4k with/without quota,
the tests include different merkle tree block size.

Feedback is welcomed :)

xfsprogs:
https://github.com/alberand/xfsprogs/tree/b4/fsverity

xfstests:
https://github.com/alberand/xfstests/tree/b4/fsverity

Cc: fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org

Cc: david@fromorbit.com
Cc: djwong@kernel.org
Cc: ebiggers@kernel.org
Cc: hch@lst.de


Andrey Albershteyn <aalbersh@kernel.org>:
  fsverity: expose ensure_fsverity_info()
  iomap: introduce IOMAP_F_BEYOND_EOF
  iomap: allow iomap_file_buffered_write() take iocb without file
  iomap: integrate fs-verity verification into iomap's read path
  xfs: add fs-verity ro-compat flag
  xfs: add inode on-disk VERITY flag
  xfs: initialize fs-verity on file open and cleanup on inode destruction
  xfs: don't allow to enable DAX on fs-verity sealed inode
  xfs: disable direct read path for fs-verity files
  xfs: add verity info pointer to xfs inode
  xfs: introduce XFS_FSVERITY_CONSTRUCTION inode flag
  xfs: introduce XFS_FSVERITY_REGION_START constant
  xfs: disable preallocations for fsverity Merkle tree writes
  xfs: add writeback and iomap reading of Merkle tree pages
  xfs: add fs-verity support
  xfs: add fs-verity ioctls
  xfs: add fsverity traces
  xfs: enable ro-compat fs-verity flag
Darrick J. Wong <djwong@kernel.org>:
  fsverity: report validation errors back to the filesystem
  xfs: advertise fs-verity being available on filesystem
  xfs: check and repair the verity inode flag state
  xfs: report verity failures through the health system

Diffstat:
  fs/iomap/bio.c                  |  66 +++++++++++++++++++++++++---
  fs/iomap/buffered-io.c          |  31 ++++++++++---
  fs/iomap/ioend.c                |  41 ++++++++++++++++-
  fs/iomap/trace.h                |   3 +-
  fs/verity/open.c                |   4 +-
  fs/verity/verify.c              |   4 +
  fs/xfs/Makefile                 |   1 +
  fs/xfs/libxfs/xfs_format.h      |  13 +++--
  fs/xfs/libxfs/xfs_fs.h          |  24 ++++++++++
  fs/xfs/libxfs/xfs_health.h      |   4 +-
  fs/xfs/libxfs/xfs_inode_buf.c   |   8 +++
  fs/xfs/libxfs/xfs_inode_util.c  |   2 +
  fs/xfs/libxfs/xfs_sb.c          |   4 +
  fs/xfs/scrub/attr.c             |   7 +++
  fs/xfs/scrub/common.c           |  53 +++++++++++++++++++++++
  fs/xfs/scrub/common.h           |   2 +
  fs/xfs/scrub/inode.c            |   7 +++
  fs/xfs/scrub/inode_repair.c     |  36 +++++++++++++++
  fs/xfs/xfs_aops.c               |  20 +++++++-
  fs/xfs/xfs_bmap_util.c          |   7 +++
  fs/xfs/xfs_file.c               |  23 ++++++++--
  fs/xfs/xfs_fsverity.c           | 395 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  fs/xfs/xfs_fsverity.h           |  12 +++++
  fs/xfs/xfs_health.c             |   1 +
  fs/xfs/xfs_icache.c             |   3 +
  fs/xfs/xfs_inode.h              |  11 ++++
  fs/xfs/xfs_ioctl.c              |  16 +++++++
  fs/xfs/xfs_iomap.c              |  28 ++++++++++--
  fs/xfs/xfs_iops.c               |   4 +
  fs/xfs/xfs_message.c            |   4 +
  fs/xfs/xfs_message.h            |   1 +
  fs/xfs/xfs_mount.h              |   2 +
  fs/xfs/xfs_super.c              |  16 +++++++
  fs/xfs/xfs_trace.h              |  46 ++++++++++++++++++++
  include/linux/fsverity.h        |  16 +++++++
  include/linux/iomap.h           |  16 +++++++
  include/trace/events/fsverity.h |  19 ++++++++
  37 files changed, 924 insertions(+), 26 deletions(-)

-- 
- Andrey


