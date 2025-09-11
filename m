Return-Path: <linux-fsdevel+bounces-60879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38A1B527ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 06:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888F268791B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 04:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85269261B9E;
	Thu, 11 Sep 2025 04:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpoWkJsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418D8241667;
	Thu, 11 Sep 2025 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757566584; cv=none; b=EieDSvYHc2zncc7OCn54ogsIBfmeGLsl9ID9yVgy7PSA+DUPRwFhnO6UZlgxGQ/kWryl0EilLb4OoYFQzjijgwhnKtDmLmeYj2s/JfsPygXBeyQu7BupqUp0vt66a9gbQvIl0lMrKigW14M7xho/05oNfEof9i15xCvdQkXIHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757566584; c=relaxed/simple;
	bh=JO5giDKBppn8ILM5ZWrjc0lbAskJpJIP9qCd4xFFN7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n61HNLCmBL/YaupUXMazLsZqSxKal6xCRJZ2Qkn+nEFmUuGwAClKcQwHK1ao0Be907n4s47a5Ddt972cqvyxJQ3N4rJXB8YqKMTUckxLCIRdGjsCWQwjS1mLZR/96lzChmIeKpu3OZBPg2cO2saFgd4Wi3NV0C9EwgMwzWmuCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpoWkJsS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so1396285e9.0;
        Wed, 10 Sep 2025 21:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757566578; x=1758171378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjq2LJVJwKrWUziF/OxOScoVsYSkB66pSBu/byH8I3U=;
        b=XpoWkJsSHRCTd/ntBhlR2TGzfWVe2rVmygJSpqlbhPLv6PMEERG9HlvbgPJTs7d2jr
         w0plYbASpSGD1764QxvPXM4D2zkblGEprYR45xSt6B18NOIjS5/YBRFkZPt6o5y34DFp
         DHKvnSFD9++WTupNscCJUbBBIqOe6VEOym1Z4UIHzwam+DbAEfryXMo79XKoJzIZTd7K
         gUFhrhpGPq6AX/OdYywA+aCZ7WKOU3PSoYFaGEr1JKJyXALBrF77Tet8+aYK2eWzcqG4
         pQu8Z+d6VeM/ggCzwoP+LupHb7UDmFNrET0pI6yh5/JYiljQkwOSO/DYGjxsMhLhmH3j
         pkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757566578; x=1758171378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjq2LJVJwKrWUziF/OxOScoVsYSkB66pSBu/byH8I3U=;
        b=t22pjdlNix9srOXrhhsYGH3EU239rNqMHlubYwkbcc2QmyUf1zIUwtCko5htIvD6xt
         Q76gh8FlGolZvrBk8U3z8lOnnB6bf0z88d7g7TRovKLT+uFEglu9Q/RBDEHAmJsmA0vU
         Dfgxlo46nOZCFo0CZp73y33r5x75kGQt+cjohGBES3kSZrunaYx7v8EBY+sxtt+sXujG
         OCknvgoWTo0lC49xqd3WdRPsTOCBHVFr2xjAZkJiN7QbvNkPRPPzPblXaMrEh2DOhWyj
         GFv4m0Pd88c2Aju8vED0DqNnww6duQUDDdpLzh4Bur06Vz8mc7BLmt9Vh2HzWnLUyjwT
         dRbw==
X-Forwarded-Encrypted: i=1; AJvYcCVBJAq/i/0zU0wFmZEzLIB1ijrJfPK5paBTbbgawojOW/UTTqtQHJdd0APVfvEur+zuU2QC6GwpyWSQdrMzJg==@vger.kernel.org, AJvYcCVwkZOduoW9G2CMFGVlcWj77aCYRYa8XuXkb9RNx44g7K3bHKOHwTwHCvi5ED3aAqotgPk86owCuSZYNxsy@vger.kernel.org, AJvYcCWI4FVg8s7UQlz7iEM6NOp19tTMzm3yXN7ItRhRnXZK7rlN8ubvQxZ2p6cMsPuTI6DwJkVyOrcnQcO10Q==@vger.kernel.org, AJvYcCWNsuJZWv9TE2JhdQWztURduy8nQ6p/BdMaZnIo/RGVdBsiUswE3lnhkBUepwW9cG0G7gzr0LPlLv6WSg==@vger.kernel.org, AJvYcCWbVjKitaNIDMreoIGjdbs3dndAlFlg1b5MOTDd2DLawAXkVt3HACRjq+VsIA74WXm7Uyt5BEP0dgZl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy273421dZ2XWaxmDAbpnYRxkeICeVD6+MCXoqoU1qMrY6CVRZ9
	ZsI69w8aN7juHtZ1MGUiMgEASQto03vMPepKpm64tVg60qgyxwfuhIiy
X-Gm-Gg: ASbGncuUSs6QPq0SxuRFyCbvzpvdE+FpdIs9fNkQp5SkCGADfuL2c5YD1VaQ36vX6Tb
	04i1vDfwVhGUjmFHMkyP8jYljdh2111t9XBsZtD7Z2pIDx9BmqbD8SOYSxe9FcNEfq39FFvm9cW
	WdSIVgevOP2nPKVbWe48Hm48sYz1SgydZ/1uqGpuB6GPeg2sD0s2YIyBTLZTO45KXrrsV7FiOO6
	sxH9RuTf+cSx5yUiEl16UqpPoO+2Cb4ctaLEwscq91fQ1uodW3NMBtFgo/++LVXl6ZgvssXN0YZ
	iDuHYRgZ9vp4/lispUnXBwzTwNbR4Bgsbo7AffHDFK0x8b7SMbFWatbOruigFbgFRXHmsFTpue+
	5qM4+LdLXoTERYOh6wMYc4yUs4GkXvxv/uQl/OpIO
X-Google-Smtp-Source: AGHT+IHthNQc/EOPDTuhX9KOz0bcRC4rLwVFnJG9gf4eVDly6EZaTwDP4ODwBYRXG4WQ7J922CNEig==
X-Received: by 2002:a05:600c:45d4:b0:45b:9a76:ebea with SMTP id 5b1f17b1804b1-45dddeeee4cmr165080575e9.20.1757566577056;
        Wed, 10 Sep 2025 21:56:17 -0700 (PDT)
Received: from f.. (cst-prg-67-222.cust.vodafone.cz. [46.135.67.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e9e6asm889419f8f.62.2025.09.10.21.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:56:16 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 3/4] convert all filesystems to use the new ->i_state accessors
Date: Thu, 11 Sep 2025 06:55:56 +0200
Message-ID: <20250911045557.1552002-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911045557.1552002-1-mjguzik@gmail.com>
References: <20250911045557.1552002-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

this will be one patch per fs in the actual submission

commits:

bcachefs: use the new ->i_state accessors

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

9p: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

affs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

afs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

befs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

bfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

btrfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

ceph: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

coda: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

cramfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

ecryptfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

efs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

erofs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

ext2: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

ext4: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

f2fs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

freevxfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

fuse: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

gfs2: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

hfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

hfsplus: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

hostfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

hpfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

isofs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

jffs2: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

jfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

kernfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

minix: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

netfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

nfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

nfsd: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

nilfs2: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

ntfs3: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

ocfs2: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

omfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

openpromfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

orangefs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

overlayfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

qnx4: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

qnx6: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

romfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

smb: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

squashfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

ubifs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

udf: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

ufs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

xfs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

zonefs: use the new ->i_state accessors

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/9p/vfs_inode.c            |  2 +-
 fs/9p/vfs_inode_dotl.c       |  2 +-
 fs/affs/inode.c              |  2 +-
 fs/afs/dynroot.c             |  6 +++---
 fs/afs/inode.c               |  8 ++++----
 fs/bcachefs/fs.c             |  7 +++----
 fs/befs/linuxvfs.c           |  2 +-
 fs/bfs/inode.c               |  2 +-
 fs/btrfs/inode.c             | 10 +++++-----
 fs/ceph/cache.c              |  2 +-
 fs/ceph/crypto.c             |  4 ++--
 fs/ceph/file.c               |  4 ++--
 fs/ceph/inode.c              | 28 ++++++++++++++--------------
 fs/coda/cnode.c              |  4 ++--
 fs/cramfs/inode.c            |  2 +-
 fs/ecryptfs/inode.c          |  6 +++---
 fs/efs/inode.c               |  2 +-
 fs/erofs/inode.c             |  2 +-
 fs/ext2/inode.c              |  2 +-
 fs/ext4/inode.c              | 10 +++++-----
 fs/ext4/orphan.c             |  4 ++--
 fs/f2fs/data.c               |  2 +-
 fs/f2fs/inode.c              |  2 +-
 fs/f2fs/namei.c              |  4 ++--
 fs/f2fs/super.c              |  2 +-
 fs/freevxfs/vxfs_inode.c     |  2 +-
 fs/fuse/inode.c              |  4 ++--
 fs/gfs2/file.c               |  2 +-
 fs/gfs2/glops.c              |  2 +-
 fs/gfs2/inode.c              |  4 ++--
 fs/gfs2/ops_fstype.c         |  2 +-
 fs/hfs/btree.c               |  2 +-
 fs/hfs/inode.c               |  2 +-
 fs/hfsplus/super.c           |  2 +-
 fs/hostfs/hostfs_kern.c      |  2 +-
 fs/hpfs/dir.c                |  2 +-
 fs/hpfs/inode.c              |  2 +-
 fs/isofs/inode.c             |  2 +-
 fs/jffs2/fs.c                |  4 ++--
 fs/jfs/file.c                |  4 ++--
 fs/jfs/inode.c               |  2 +-
 fs/jfs/jfs_txnmgr.c          |  2 +-
 fs/kernfs/inode.c            |  2 +-
 fs/minix/inode.c             |  2 +-
 fs/netfs/misc.c              |  8 ++++----
 fs/netfs/read_single.c       |  6 +++---
 fs/nfs/inode.c               |  2 +-
 fs/nfs/pnfs.c                |  2 +-
 fs/nfsd/vfs.c                |  2 +-
 fs/nilfs2/cpfile.c           |  2 +-
 fs/nilfs2/dat.c              |  2 +-
 fs/nilfs2/ifile.c            |  2 +-
 fs/nilfs2/inode.c            | 10 +++++-----
 fs/nilfs2/sufile.c           |  2 +-
 fs/ntfs3/inode.c             |  2 +-
 fs/ocfs2/dlmglue.c           |  2 +-
 fs/ocfs2/inode.c             | 10 +++++-----
 fs/omfs/inode.c              |  2 +-
 fs/openpromfs/inode.c        |  2 +-
 fs/orangefs/inode.c          |  2 +-
 fs/orangefs/orangefs-utils.c |  6 +++---
 fs/overlayfs/dir.c           |  2 +-
 fs/overlayfs/inode.c         |  6 +++---
 fs/overlayfs/util.c          | 10 +++++-----
 fs/qnx4/inode.c              |  2 +-
 fs/qnx6/inode.c              |  2 +-
 fs/romfs/super.c             |  2 +-
 fs/smb/client/cifsfs.c       |  2 +-
 fs/smb/client/inode.c        | 14 +++++++-------
 fs/squashfs/inode.c          |  2 +-
 fs/ubifs/file.c              |  2 +-
 fs/ubifs/super.c             |  2 +-
 fs/udf/inode.c               |  2 +-
 fs/ufs/inode.c               |  2 +-
 fs/xfs/scrub/common.c        |  2 +-
 fs/xfs/scrub/inode_repair.c  |  2 +-
 fs/xfs/scrub/parent.c        |  2 +-
 fs/xfs/xfs_bmap_util.c       |  2 +-
 fs/xfs/xfs_health.c          |  4 ++--
 fs/xfs/xfs_icache.c          |  6 +++---
 fs/xfs/xfs_inode.c           |  6 +++---
 fs/xfs/xfs_inode_item.c      |  4 ++--
 fs/xfs/xfs_iops.c            |  2 +-
 fs/xfs/xfs_reflink.h         |  2 +-
 fs/zonefs/super.c            |  4 ++--
 85 files changed, 158 insertions(+), 159 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 399d455d50d6..1af7d6518e19 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -422,7 +422,7 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode, st);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 	/*
 	 * initialize the inode with the stat info
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 5b5fda617b80..d08a7f5ae4b0 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -112,7 +112,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode_dotl, st);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 	/*
 	 * initialize the inode with the stat info
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 0210df8d3500..6dfe02bac56c 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -29,7 +29,7 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	pr_debug("affs_iget(%lu)\n", inode->i_ino);
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 8c6130789fde..3b9594b568a4 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -64,7 +64,7 @@ static struct inode *afs_iget_pseudo_dir(struct super_block *sb, ino_t ino)
 
 	vnode = AFS_FS_I(inode);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		netfs_inode_init(&vnode->netfs, NULL, false);
 		simple_inode_init_ts(inode);
 		set_nlink(inode, 2);
@@ -258,7 +258,7 @@ static struct dentry *afs_lookup_atcell(struct inode *dir, struct dentry *dentry
 
 	vnode = AFS_FS_I(inode);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		netfs_inode_init(&vnode->netfs, NULL, false);
 		simple_inode_init_ts(inode);
 		set_nlink(inode, 1);
@@ -383,7 +383,7 @@ struct inode *afs_dynroot_iget_root(struct super_block *sb)
 	vnode = AFS_FS_I(inode);
 
 	/* there shouldn't be an existing inode */
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		netfs_inode_init(&vnode->netfs, NULL, false);
 		simple_inode_init_ts(inode);
 		set_nlink(inode, 2);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index e9538e91f848..65b04f0ad06c 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -427,7 +427,7 @@ static void afs_fetch_status_success(struct afs_operation *op)
 	struct afs_vnode *vnode = vp->vnode;
 	int ret;
 
-	if (vnode->netfs.inode.i_state & I_NEW) {
+	if (inode_state_read_unstable(&vnode->netfs.inode) & I_NEW) {
 		ret = afs_inode_init_from_status(op, vp, vnode);
 		afs_op_set_error(op, ret);
 		if (ret == 0)
@@ -579,7 +579,7 @@ struct inode *afs_iget(struct afs_operation *op, struct afs_vnode_param *vp)
 	       inode, vnode->fid.vid, vnode->fid.vnode, vnode->fid.unique);
 
 	/* deal with an existing inode */
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_unstable(inode) & I_NEW)) {
 		_leave(" = %p", inode);
 		return inode;
 	}
@@ -639,7 +639,7 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 
 	_debug("GOT ROOT INODE %p { vl=%llx }", inode, as->volume->vid);
 
-	BUG_ON(!(inode->i_state & I_NEW));
+	BUG_ON(!(inode_state_read_unstable(inode) & I_NEW));
 
 	vnode = AFS_FS_I(inode);
 	vnode->cb_v_check = atomic_read(&as->volume->cb_v_break);
@@ -748,7 +748,7 @@ void afs_evict_inode(struct inode *inode)
 
 	if ((S_ISDIR(inode->i_mode) ||
 	     S_ISLNK(inode->i_mode)) &&
-	    (inode->i_state & I_DIRTY) &&
+	    (inode_state_read_unstable(inode) & I_DIRTY) &&
 	    !sbi->dyn_root) {
 		struct writeback_control wbc = {
 			.sync_mode = WB_SYNC_ALL,
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 687af0eea0c2..c3477dd334a1 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -347,7 +347,7 @@ static struct bch_inode_info *bch2_inode_hash_find(struct bch_fs *c, struct btre
 			spin_unlock(&inode->v.i_lock);
 			return NULL;
 		}
-		if ((inode->v.i_state & (I_FREEING|I_WILL_FREE))) {
+		if ((inode_state_read(&inode->v) & (I_FREEING|I_WILL_FREE))) {
 			if (!trans) {
 				__wait_on_freeing_inode(c, inode, inum);
 			} else {
@@ -411,7 +411,7 @@ static struct bch_inode_info *bch2_inode_hash_insert(struct bch_fs *c,
 		 * only insert fully created inodes in the inode hash table. But
 		 * discard_new_inode() expects it to be set...
 		 */
-		inode->v.i_state |= I_NEW;
+		inode_state_add_unchecked(&inode->v, I_NEW);
 		/*
 		 * We don't want bch2_evict_inode() to delete the inode on disk,
 		 * we just raced and had another inode in cache. Normally new
@@ -2224,8 +2224,7 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, snapshot_id_list *s)
 		if (!snapshot_list_has_id(s, inode->ei_inum.subvol))
 			continue;
 
-		if (!(inode->v.i_state & I_DONTCACHE) &&
-		    !(inode->v.i_state & I_FREEING) &&
+		if (!(inode_state_read_unstable(&inode->v) & (I_DONTCACHE | I_FREEING)) &&
 		    igrab(&inode->v)) {
 			this_pass_clean = false;
 
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 8f430ff8e445..9b556f7e7b1c 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -307,7 +307,7 @@ static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	befs_ino = BEFS_I(inode);
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 1d41ce477df5..3d1fc8387764 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -42,7 +42,7 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	if ((ino < BFS_ROOT_INO) || (ino > BFS_SB(inode->i_sb)->si_lasti)) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5bcd8e25fa78..c61ab26f4d2c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3856,7 +3856,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 		ASSERT(ret != -ENOMEM);
 		return ret;
 	} else if (existing) {
-		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
+		WARN_ON(!(inode_state_read_unstable(&existing->vfs_inode) & (I_WILL_FREE | I_FREEING)));
 	}
 
 	return 0;
@@ -5317,7 +5317,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct rb_node *node;
 
-	ASSERT(inode->i_state & I_FREEING);
+	ASSERT(inode_state_read_unstable(inode) & I_FREEING);
 	truncate_inode_pages_final(&inode->i_data);
 
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
@@ -5745,7 +5745,7 @@ struct btrfs_inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->vfs_inode.i_state & I_NEW))
+	if (!(inode_state_read_unstable(&inode->vfs_inode) & I_NEW))
 		return inode;
 
 	ret = btrfs_read_locked_inode(inode, path);
@@ -5769,7 +5769,7 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->vfs_inode.i_state & I_NEW))
+	if (!(inode_state_read_unstable(&inode->vfs_inode) & I_NEW))
 		return inode;
 
 	path = btrfs_alloc_path();
@@ -7435,7 +7435,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	u64 page_start = folio_pos(folio);
 	u64 page_end = page_start + folio_size(folio) - 1;
 	u64 cur;
-	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
+	int inode_evicting = inode_state_read_unstable(&inode->vfs_inode) & I_FREEING;
 
 	/*
 	 * We have folio locked so no new ordered extent can be created on this
diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 930fbd54d2c8..ed3b12f7752b 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -26,7 +26,7 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
 		return;
 
 	/* Only new inodes! */
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return;
 
 	WARN_ON_ONCE(ci->netfs.cache);
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 7026e794813c..cbedf4b5a746 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -329,7 +329,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 out:
 	kfree(cryptbuf);
 	if (dir != parent) {
-		if ((dir->i_state & I_NEW))
+		if ((inode_state_read_unstable(dir) & I_NEW))
 			discard_new_inode(dir);
 		else
 			iput(dir);
@@ -438,7 +438,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	fscrypt_fname_free_buffer(&_tname);
 out_inode:
 	if (dir != fname->dir) {
-		if ((dir->i_state & I_NEW))
+		if ((inode_state_read_unstable(dir) & I_NEW))
 			discard_new_inode(dir);
 		else
 			iput(dir);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index c02f100f8552..e42e0a92e94f 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -744,7 +744,7 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 		      vino.ino, ceph_ino(dir), dentry->d_name.name);
 		ceph_dir_clear_ordered(dir);
 		ceph_init_inode_acls(inode, as_ctx);
-		if (inode->i_state & I_NEW) {
+		if (inode_state_read_unstable(inode) & I_NEW) {
 			/*
 			 * If it's not I_NEW, then someone created this before
 			 * we got here. Assume the server is aware of it at
@@ -907,7 +907,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 				new_inode = NULL;
 				goto out_req;
 			}
-			WARN_ON_ONCE(!(new_inode->i_state & I_NEW));
+			WARN_ON_ONCE(!(inode_state_read_unstable(new_inode) & I_NEW));
 
 			spin_lock(&dentry->d_lock);
 			di->flags |= CEPH_DENTRY_ASYNC_CREATE;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 480cb3a1d639..55df06186b27 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -86,7 +86,7 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
 			goto out_err;
 	}
 
-	inode->i_state = 0;
+	inode_state_set_unchecked(inode, 0);
 	inode->i_mode = *mode;
 
 	err = ceph_security_init_secctx(dentry, *mode, as_ctx);
@@ -155,7 +155,7 @@ struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino,
 
 	doutc(cl, "on %llx=%llx.%llx got %p new %d\n",
 	      ceph_present_inode(inode), ceph_vinop(inode), inode,
-	      !!(inode->i_state & I_NEW));
+	      !!(inode_state_read_unstable(inode) & I_NEW));
 	return inode;
 }
 
@@ -182,7 +182,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 		goto err;
 	}
 
-	if (!(inode->i_state & I_NEW) && !S_ISDIR(inode->i_mode)) {
+	if (!(inode_state_read_unstable(inode) & I_NEW) && !S_ISDIR(inode->i_mode)) {
 		pr_warn_once_client(cl, "bad snapdir inode type (mode=0%o)\n",
 				    inode->i_mode);
 		goto err;
@@ -215,7 +215,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 		}
 	}
 #endif
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		inode->i_op = &ceph_snapdir_iops;
 		inode->i_fop = &ceph_snapdir_fops;
 		ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
@@ -224,7 +224,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 
 	return inode;
 err:
-	if ((inode->i_state & I_NEW))
+	if ((inode_state_read_unstable(inode) & I_NEW))
 		discard_new_inode(inode);
 	else
 		iput(inode);
@@ -698,7 +698,7 @@ void ceph_evict_inode(struct inode *inode)
 
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
-	if (inode->i_state & I_PINNING_NETFS_WB)
+	if (inode_state_read_unstable(inode) & I_PINNING_NETFS_WB)
 		ceph_fscache_unuse_cookie(inode, true);
 	clear_inode(inode);
 
@@ -967,7 +967,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	      le64_to_cpu(info->version), ci->i_version);
 
 	/* Once I_NEW is cleared, we can't change type or dev numbers */
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		inode->i_mode = mode;
 	} else {
 		if (inode_wrong_type(inode, mode)) {
@@ -1044,7 +1044,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 #ifdef CONFIG_FS_ENCRYPTION
 	if (iinfo->fscrypt_auth_len &&
-	    ((inode->i_state & I_NEW) || (ci->fscrypt_auth_len == 0))) {
+	    ((inode_state_read_unstable(inode) & I_NEW) || (ci->fscrypt_auth_len == 0))) {
 		kfree(ci->fscrypt_auth);
 		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
 		ci->fscrypt_auth = iinfo->fscrypt_auth;
@@ -1638,13 +1638,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			pr_err_client(cl, "badness %p %llx.%llx\n", in,
 				      ceph_vinop(in));
 			req->r_target_inode = NULL;
-			if (in->i_state & I_NEW)
+			if (inode_state_read_unstable(in) & I_NEW)
 				discard_new_inode(in);
 			else
 				iput(in);
 			goto done;
 		}
-		if (in->i_state & I_NEW)
+		if (inode_state_read_unstable(in) & I_NEW)
 			unlock_new_inode(in);
 	}
 
@@ -1830,11 +1830,11 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
 			pr_err_client(cl, "inode badness on %p got %d\n", in,
 				      rc);
 			err = rc;
-			if (in->i_state & I_NEW) {
+			if (inode_state_read_unstable(in) & I_NEW) {
 				ihold(in);
 				discard_new_inode(in);
 			}
-		} else if (in->i_state & I_NEW) {
+		} else if (inode_state_read_unstable(in) & I_NEW) {
 			unlock_new_inode(in);
 		}
 
@@ -2046,7 +2046,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			pr_err_client(cl, "badness on %p %llx.%llx\n", in,
 				      ceph_vinop(in));
 			if (d_really_is_negative(dn)) {
-				if (in->i_state & I_NEW) {
+				if (inode_state_read_unstable(in) & I_NEW) {
 					ihold(in);
 					discard_new_inode(in);
 				}
@@ -2056,7 +2056,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			err = ret;
 			goto next_item;
 		}
-		if (in->i_state & I_NEW)
+		if (inode_state_read_unstable(in) & I_NEW)
 			unlock_new_inode(in);
 
 		if (d_really_is_negative(dn)) {
diff --git a/fs/coda/cnode.c b/fs/coda/cnode.c
index 62a3d2565c26..6fc0d072cbd0 100644
--- a/fs/coda/cnode.c
+++ b/fs/coda/cnode.c
@@ -70,7 +70,7 @@ struct inode * coda_iget(struct super_block * sb, struct CodaFid * fid,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		cii = ITOC(inode);
 		/* we still need to set i_ino for things like stat(2) */
 		inode->i_ino = hash;
@@ -148,7 +148,7 @@ struct inode *coda_fid_to_inode(struct CodaFid *fid, struct super_block *sb)
 
 	/* we should never see newly created inodes because we intentionally
 	 * fail in the initialization callback */
-	BUG_ON(inode->i_state & I_NEW);
+	BUG_ON(inode_state_read_unstable(inode) & I_NEW);
 
 	return inode;
 }
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index b002e9b734f9..0397754dc852 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -95,7 +95,7 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
 	inode = iget_locked(sb, cramino(cramfs_inode, offset));
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	switch (cramfs_inode->mode & S_IFMT) {
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 72fbe1316ab8..5699ef841d4d 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -95,7 +95,7 @@ static struct inode *__ecryptfs_get_inode(struct inode *lower_inode,
 		iput(lower_inode);
 		return ERR_PTR(-EACCES);
 	}
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		iput(lower_inode);
 
 	return inode;
@@ -106,7 +106,7 @@ struct inode *ecryptfs_get_inode(struct inode *lower_inode,
 {
 	struct inode *inode = __ecryptfs_get_inode(lower_inode, sb);
 
-	if (!IS_ERR(inode) && (inode->i_state & I_NEW))
+	if (!IS_ERR(inode) && (inode_state_read_unstable(inode) & I_NEW))
 		unlock_new_inode(inode);
 
 	return inode;
@@ -373,7 +373,7 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 		}
 	}
 
-	if (inode->i_state & I_NEW)
+	if (inode_state_read_unstable(inode) & I_NEW)
 		unlock_new_inode(inode);
 	return d_splice_alias(inode, dentry);
 }
diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 462619e59766..095ab7388edf 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -62,7 +62,7 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 	inode = iget_locked(super, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	in = INODE_INFO(inode);
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 9a2f59721522..456f59099cc4 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -297,7 +297,7 @@ struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		int err = erofs_fill_inode(inode);
 
 		if (err) {
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index e10c376843d7..5355008eb5bc 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1398,7 +1398,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	ei = EXT2_I(inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ed54c4d0f2f9..b3373b1c1596 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -425,7 +425,7 @@ void ext4_check_map_extents_env(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) ||
 	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
 	    is_special_ino(inode->i_sb, inode->i_ino) ||
-	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) ||
+	    (inode_state_read_unstable(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    ext4_verity_in_progress(inode))
 		return;
@@ -3473,7 +3473,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	/* Any metadata buffers to write? */
 	if (!list_empty(&inode->i_mapping->i_private_list))
 		return true;
-	return inode->i_state & I_DIRTY_DATASYNC;
+	return inode_state_read_unstable(inode) & I_DIRTY_DATASYNC;
 }
 
 static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
@@ -4581,7 +4581,7 @@ int ext4_truncate(struct inode *inode)
 	 * or it's a completely new inode. In those cases we might not
 	 * have i_rwsem locked because it's not necessary.
 	 */
-	if (!(inode->i_state & (I_NEW|I_FREEING)))
+	if (!(inode_state_read_unstable(inode) & (I_NEW | I_FREEING)))
 		WARN_ON(!inode_is_locked(inode));
 	trace_ext4_truncate_enter(inode);
 
@@ -5239,7 +5239,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_unstable(inode) & I_NEW)) {
 		ret = check_igot_inode(inode, flags, function, line);
 		if (ret) {
 			iput(inode);
@@ -5570,7 +5570,7 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
 	if (inode_is_dirtytime_only(inode)) {
 		struct ext4_inode_info	*ei = EXT4_I(inode);
 
-		inode->i_state &= ~I_DIRTY_TIME;
+		inode_state_del(inode, I_DIRTY_TIME);
 		spin_unlock(&inode->i_lock);
 
 		spin_lock(&ei->i_raw_lock);
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 7c7f792ad6ab..2fdaaca613ba 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -107,7 +107,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal || is_bad_inode(inode))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode_state_read_unstable(inode) & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
 	/*
 	 * Inode orphaned in orphan file or in orphan list?
@@ -236,7 +236,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode_state_read_unstable(inode) & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
 	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE))
 		return ext4_orphan_file_del(handle, inode);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddfca3..da6d366583f4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4241,7 +4241,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	if (map.m_flags & F2FS_MAP_NEW)
 		iomap->flags |= IOMAP_F_NEW;
-	if ((inode->i_state & I_DIRTY_DATASYNC) ||
+	if ((inode_state_read_unstable(inode) & I_DIRTY_DATASYNC) ||
 	    offset + length > i_size_read(inode))
 		iomap->flags |= IOMAP_F_DIRTY;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8c4eafe9ffac..ffb79c976755 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -569,7 +569,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_unstable(inode) & I_NEW)) {
 		if (is_meta_ino(sbi, ino)) {
 			f2fs_err(sbi, "inaccessible inode: %lu, run fsck to repair", ino);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b882771e4699..7d977b80bae5 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -844,7 +844,7 @@ static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 		f2fs_i_links_write(inode, false);
 
 		spin_lock(&inode->i_lock);
-		inode->i_state |= I_LINKABLE;
+		inode_state_add(inode, I_LINKABLE);
 		spin_unlock(&inode->i_lock);
 	} else {
 		if (file)
@@ -1057,7 +1057,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto put_out_dir;
 
 		spin_lock(&whiteout->i_lock);
-		whiteout->i_state &= ~I_LINKABLE;
+		inode_state_del(whiteout, I_LINKABLE);
 		spin_unlock(&whiteout->i_lock);
 
 		iput(whiteout);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2045642cfe3b..d8db9a4084fa 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1747,7 +1747,7 @@ static int f2fs_drop_inode(struct inode *inode)
 	 *    - f2fs_gc -> iput -> evict
 	 *       - inode_wait_for_writeback(inode)
 	 */
-	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {
+	if ((!inode_unhashed(inode) && inode_state_read(inode) & I_SYNC)) {
 		if (!inode->i_nlink && !is_bad_inode(inode)) {
 			/* to avoid evict_inode call simultaneously */
 			__iget(inode);
diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
index 20600e9ea202..f522ff2b2d12 100644
--- a/fs/freevxfs/vxfs_inode.c
+++ b/fs/freevxfs/vxfs_inode.c
@@ -258,7 +258,7 @@ vxfs_iget(struct super_block *sbp, ino_t ino)
 	ip = iget_locked(sbp, ino);
 	if (!ip)
 		return ERR_PTR(-ENOMEM);
-	if (!(ip->i_state & I_NEW))
+	if (!(inode_state_read_unstable(ip) & I_NEW))
 		return ip;
 
 	vip = VXFS_INO(ip);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ecb869e895ab..5d1676766dab 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -161,7 +161,7 @@ static void fuse_evict_inode(struct inode *inode)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	/* Will write inode on close/munmap and in all other dirtiers */
-	WARN_ON(inode->i_state & I_DIRTY_INODE);
+	WARN_ON(inode_state_read_unstable(inode) & I_DIRTY_INODE);
 
 	if (FUSE_IS_DAX(inode))
 		dax_break_layout_final(inode);
@@ -506,7 +506,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	if (!inode)
 		return NULL;
 
-	if ((inode->i_state & I_NEW)) {
+	if ((inode_state_read_unstable(inode) & I_NEW)) {
 		inode->i_flags |= S_NOATIME;
 		if (!fc->writeback_cache || !S_ISREG(attr->mode))
 			inode->i_flags |= S_NOCMTIME;
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 72d95185a39f..712cf618a372 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -744,7 +744,7 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
 {
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
-	int sync_state = inode->i_state & I_DIRTY;
+	int sync_state = inode_state_read_unstable(inode) & I_DIRTY;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	int ret = 0, ret1 = 0;
 
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index fe0faad4892f..0aaa5dec57d2 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -394,7 +394,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	u16 height, depth;
 	umode_t mode = be32_to_cpu(str->di_mode);
 	struct inode *inode = &ip->i_inode;
-	bool is_new = inode->i_state & I_NEW;
+	bool is_new = inode_state_read_unstable(inode) & I_NEW;
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
 		gfs2_consist_inode(ip);
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8760e7e20c9d..daa10f8b0f34 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -127,7 +127,7 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 
 	ip = GFS2_I(inode);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		struct gfs2_sbd *sdp = GFS2_SB(inode);
 		struct gfs2_glock *io_gl;
 		int extra_flags = 0;
@@ -924,7 +924,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	gfs2_dir_no_add(&da);
 	gfs2_glock_dq_uninit(&d_gh);
 	if (!IS_ERR_OR_NULL(inode)) {
-		if (inode->i_state & I_NEW)
+		if (inode_state_read_unstable(inode) & I_NEW)
 			iget_failed(inode);
 		else
 			iput(inode);
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c770006f8889..2572ff9753b8 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1749,7 +1749,7 @@ static void gfs2_evict_inodes(struct super_block *sb)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) &&
+		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) &&
 		    !need_resched()) {
 			spin_unlock(&inode->i_lock);
 			continue;
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index e86e1e235658..22c286762035 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -42,7 +42,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	tree->inode = iget_locked(sb, id);
 	if (!tree->inode)
 		goto free_tree;
-	BUG_ON(!(tree->inode->i_state & I_NEW));
+	BUG_ON(!(inode_state_read_unstable(tree->inode) & I_NEW));
 	{
 	struct hfs_mdb *mdb = HFS_SB(sb)->mdb;
 	HFS_I(tree->inode)->flags = 0;
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index bf4cb7e78396..b47374d0a518 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -401,7 +401,7 @@ struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key, hfs_cat_
 		return NULL;
 	}
 	inode = iget5_locked(sb, cnid, hfs_test_inode, hfs_read_inode, &data);
-	if (inode && (inode->i_state & I_NEW))
+	if (inode && (inode_state_read_unstable(inode) & I_NEW))
 		unlock_new_inode(inode);
 	return inode;
 }
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 86351bdc8985..f41b35612d94 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -65,7 +65,7 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 01e516175bcd..c29d229d4eb7 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -581,7 +581,7 @@ static struct inode *hostfs_iget(struct super_block *sb, char *name)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		unlock_new_inode(inode);
 	} else {
 		spin_lock(&inode->i_lock);
diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index 49dd585c2b17..4452cea2edf9 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -247,7 +247,7 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 		result = ERR_PTR(-ENOMEM);
 		goto bail1;
 	}
-	if (result->i_state & I_NEW) {
+	if (inode_state_read_unstable(result) & I_NEW) {
 		hpfs_init_inode(result);
 		if (de->directory)
 			hpfs_read_inode(result);
diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index 34008442ee26..e95b1b6e3799 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -196,7 +196,7 @@ void hpfs_write_inode(struct inode *i)
 	parent = iget_locked(i->i_sb, hpfs_inode->i_parent_dir);
 	if (parent) {
 		hpfs_inode->i_dirty = 0;
-		if (parent->i_state & I_NEW) {
+		if (inode_state_read_unstable(parent) & I_NEW) {
 			hpfs_init_inode(parent);
 			hpfs_read_inode(parent);
 			unlock_new_inode(parent);
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6f0e6b19383c..eecdcb0aeb58 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1515,7 +1515,7 @@ struct inode *__isofs_iget(struct super_block *sb,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		ret = isofs_read_inode(inode, relocated);
 		if (ret < 0) {
 			iget_failed(inode);
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index d175cccb7c55..0f57b5675ce2 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -265,7 +265,7 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	f = JFFS2_INODE_INFO(inode);
@@ -373,7 +373,7 @@ void jffs2_dirty_inode(struct inode *inode, int flags)
 {
 	struct iattr iattr;
 
-	if (!(inode->i_state & I_DIRTY_DATASYNC)) {
+	if (!(inode_state_read_unstable(inode) & I_DIRTY_DATASYNC)) {
 		jffs2_dbg(2, "%s(): not calling setattr() for ino #%lu\n",
 			  __func__, inode->i_ino);
 		return;
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 2a4a288b821c..1d216764cec4 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -26,8 +26,8 @@ int jfs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		return rc;
 
 	inode_lock(inode);
-	if (!(inode->i_state & I_DIRTY_ALL) ||
-	    (datasync && !(inode->i_state & I_DIRTY_DATASYNC))) {
+	if (!(inode_state_read_unstable(inode) & I_DIRTY_ALL) ||
+	    (datasync && !(inode_state_read_unstable(inode) & I_DIRTY_DATASYNC))) {
 		/* Make sure committed changes hit the disk */
 		jfs_flush_journal(JFS_SBI(inode->i_sb)->log, 1);
 		inode_unlock(inode);
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index fcedeb514e14..2986168a2ef3 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -29,7 +29,7 @@ struct inode *jfs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	ret = diRead(inode);
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index be17e3c43582..4a5a7a032269 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -1286,7 +1286,7 @@ int txCommit(tid_t tid,		/* transaction identifier */
 		 * to verify this, only a trivial s/I_LOCK/I_SYNC/ was done.
 		 * Joern
 		 */
-		if (tblk->u.ip->i_state & I_SYNC)
+		if (inode_state_read_unstable(tblk->u.ip) & I_SYNC)
 			tblk->xflag &= ~COMMIT_LAZY;
 	}
 
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3c293a5a21b1..4be78ff5ab6c 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -251,7 +251,7 @@ struct inode *kernfs_get_inode(struct super_block *sb, struct kernfs_node *kn)
 	struct inode *inode;
 
 	inode = iget_locked(sb, kernfs_ino(kn));
-	if (inode && (inode->i_state & I_NEW))
+	if (inode && (inode_state_read_unstable(inode) & I_NEW))
 		kernfs_init_inode(kn, inode);
 
 	return inode;
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index df9d11479caf..50b81fd292fd 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -583,7 +583,7 @@ struct inode *minix_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	if (INODE_VERSION(inode) == MINIX_V1)
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 20748bcfbf59..358edd97b40e 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -147,10 +147,10 @@ bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (!fscache_cookie_valid(cookie))
 		return true;
 
-	if (!(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (!(inode_state_read_unstable(inode) & I_PINNING_NETFS_WB)) {
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_add(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
@@ -192,7 +192,7 @@ void netfs_clear_inode_writeback(struct inode *inode, const void *aux)
 {
 	struct fscache_cookie *cookie = netfs_i_cookie(netfs_inode(inode));
 
-	if (inode->i_state & I_PINNING_NETFS_WB) {
+	if (inode_state_read_unstable(inode) & I_PINNING_NETFS_WB) {
 		loff_t i_size = i_size_read(inode);
 		fscache_unuse_cookie(cookie, aux, &i_size);
 	}
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index fa622a6cd56d..d3894cece633 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -36,12 +36,12 @@ void netfs_single_mark_inode_dirty(struct inode *inode)
 
 	mark_inode_dirty(inode);
 
-	if (caching && !(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (caching && !(inode_state_read_unstable(inode) & I_PINNING_NETFS_WB)) {
 		bool need_use = false;
 
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_add(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b52805951856..eb1c5c764110 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -475,7 +475,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		goto out_no_inode;
 	}
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		struct nfs_inode *nfsi = NFS_I(inode);
 		unsigned long now = jiffies;
 
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a3135b5af7ee..f157d43d1312 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -317,7 +317,7 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 			WARN_ONCE(1, "NFS: BUG unfreed layout segments.\n");
 		pnfs_detach_layout_hdr(lo);
 		/* Notify pnfs_destroy_layout_final() that we're done */
-		if (inode->i_state & (I_FREEING | I_CLEAR))
+		if (inode_state_read(inode) & (I_FREEING | I_CLEAR))
 			wake_up_var_locked(lo, &inode->i_lock);
 		spin_unlock(&inode->i_lock);
 		pnfs_free_layout_hdr(lo);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 98ab55ba3ced..d207ca1d76bb 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1139,7 +1139,7 @@ static int wait_for_concurrent_writes(struct file *file)
 		dprintk("nfsd: write resume %d\n", task_pid_nr(current));
 	}
 
-	if (inode->i_state & I_DIRTY) {
+	if (inode_state_read_unstable(inode) & I_DIRTY) {
 		dprintk("nfsd: write sync %d\n", task_pid_nr(current));
 		err = vfs_fsync(file, 0);
 	}
diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index bcc7d76269ac..9eda63f0462e 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -1148,7 +1148,7 @@ int nilfs_cpfile_read(struct super_block *sb, size_t cpsize,
 	cpfile = nilfs_iget_locked(sb, NULL, NILFS_CPFILE_INO);
 	if (unlikely(!cpfile))
 		return -ENOMEM;
-	if (!(cpfile->i_state & I_NEW))
+	if (!(inode_state_read_unstable(cpfile) & I_NEW))
 		goto out;
 
 	err = nilfs_mdt_init(cpfile, NILFS_MDT_GFP, 0);
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index c664daba56ae..6e057627261c 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -506,7 +506,7 @@ int nilfs_dat_read(struct super_block *sb, size_t entry_size,
 	dat = nilfs_iget_locked(sb, NULL, NILFS_DAT_INO);
 	if (unlikely(!dat))
 		return -ENOMEM;
-	if (!(dat->i_state & I_NEW))
+	if (!(inode_state_read_unstable(dat) & I_NEW))
 		goto out;
 
 	err = nilfs_mdt_init(dat, NILFS_MDT_GFP, sizeof(*di));
diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index c4cd4a4dedd0..58494b1d4477 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -188,7 +188,7 @@ int nilfs_ifile_read(struct super_block *sb, struct nilfs_root *root,
 	ifile = nilfs_iget_locked(sb, root, NILFS_IFILE_INO);
 	if (unlikely(!ifile))
 		return -ENOMEM;
-	if (!(ifile->i_state & I_NEW))
+	if (!(inode_state_read_unstable(ifile) & I_NEW))
 		goto out;
 
 	err = nilfs_mdt_init(ifile, NILFS_MDT_GFP,
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 87ddde159f0c..6a6de2ee5d65 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -365,7 +365,7 @@ struct inode *nilfs_new_inode(struct inode *dir, umode_t mode)
 
  failed_after_creation:
 	clear_nlink(inode);
-	if (inode->i_state & I_NEW)
+	if (inode_state_read_unstable(inode) & I_NEW)
 		unlock_new_inode(inode);
 	iput(inode);  /*
 		       * raw_inode will be deleted through
@@ -562,7 +562,7 @@ struct inode *nilfs_iget(struct super_block *sb, struct nilfs_root *root,
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_unstable(inode) & I_NEW)) {
 		if (!inode->i_nlink) {
 			iput(inode);
 			return ERR_PTR(-ESTALE);
@@ -591,7 +591,7 @@ struct inode *nilfs_iget_for_gc(struct super_block *sb, unsigned long ino,
 	inode = iget5_locked(sb, ino, nilfs_iget_test, nilfs_iget_set, &args);
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	err = nilfs_init_gcinode(inode);
@@ -631,7 +631,7 @@ int nilfs_attach_btree_node_cache(struct inode *inode)
 				  nilfs_iget_set, &args);
 	if (unlikely(!btnc_inode))
 		return -ENOMEM;
-	if (btnc_inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(btnc_inode) & I_NEW) {
 		nilfs_init_btnc_inode(btnc_inode);
 		unlock_new_inode(btnc_inode);
 	}
@@ -686,7 +686,7 @@ struct inode *nilfs_iget_for_shadow(struct inode *inode)
 			       nilfs_iget_set, &args);
 	if (unlikely(!s_inode))
 		return ERR_PTR(-ENOMEM);
-	if (!(s_inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(s_inode) & I_NEW))
 		return inode;
 
 	NILFS_I(s_inode)->i_flags = 0;
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 330f269abedf..7fe97dec31e9 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -1226,7 +1226,7 @@ int nilfs_sufile_read(struct super_block *sb, size_t susize,
 	sufile = nilfs_iget_locked(sb, NULL, NILFS_SUFILE_INO);
 	if (unlikely(!sufile))
 		return -ENOMEM;
-	if (!(sufile->i_state & I_NEW))
+	if (!(inode_state_read_unstable(sufile) & I_NEW))
 		goto out;
 
 	err = nilfs_mdt_init(sufile, NILFS_MDT_GFP, sizeof(*sui));
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 37cbbee7fa58..a611e841c8fd 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -536,7 +536,7 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 		return ERR_PTR(-ENOMEM);
 
 	/* If this is a freshly allocated inode, need to read it now. */
-	if (inode->i_state & I_NEW)
+	if (inode_state_read_unstable(inode) & I_NEW)
 		inode = ntfs_read_mft(inode, name, ref);
 	else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
 		/*
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 92a6149da9c1..82d414eef927 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2487,7 +2487,7 @@ int ocfs2_inode_lock_full_nested(struct inode *inode,
 	 * which hasn't been populated yet, so clear the refresh flag
 	 * and let the caller handle it.
 	 */
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		status = 0;
 		if (lockres)
 			ocfs2_complete_lock_res_refresh(lockres, 0);
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..3ec269998bf2 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -152,8 +152,8 @@ struct inode *ocfs2_iget(struct ocfs2_super *osb, u64 blkno, unsigned flags,
 		mlog_errno(PTR_ERR(inode));
 		goto bail;
 	}
-	trace_ocfs2_iget5_locked(inode->i_state);
-	if (inode->i_state & I_NEW) {
+	trace_ocfs2_iget5_locked(inode_state_read_unstable(inode));
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		rc = ocfs2_read_locked_inode(inode, &args);
 		unlock_new_inode(inode);
 	}
@@ -1307,12 +1307,12 @@ int ocfs2_drop_inode(struct inode *inode)
 				inode->i_nlink, oi->ip_flags);
 
 	assert_spin_locked(&inode->i_lock);
-	inode->i_state |= I_WILL_FREE;
+	inode_state_add(inode, I_WILL_FREE);
 	spin_unlock(&inode->i_lock);
 	write_inode_now(inode, 1);
 	spin_lock(&inode->i_lock);
-	WARN_ON(inode->i_state & I_NEW);
-	inode->i_state &= ~I_WILL_FREE;
+	WARN_ON(inode_state_read(inode) & I_NEW);
+	inode_state_del(inode, I_WILL_FREE);
 
 	return 1;
 }
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 135c49c5d848..798bb88bfa76 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -212,7 +212,7 @@ struct inode *omfs_iget(struct super_block *sb, ino_t ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	bh = omfs_bread(inode->i_sb, ino);
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 26ecda0e4d19..9429bcba455e 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -236,7 +236,7 @@ static struct dentry *openpromfs_lookup(struct inode *dir, struct dentry *dentry
 	mutex_unlock(&op_mutex);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		simple_inode_init_ts(inode);
 		ent_oi = OP_I(inode);
 		ent_oi->type = ent_type;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index a01400cd41fd..3bf31fb0224b 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -1041,7 +1041,7 @@ struct inode *orangefs_iget(struct super_block *sb,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	error = orangefs_inode_getattr(inode, ORANGEFS_GETATTR_NEW);
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 0fdceb00ca07..9ab1119ebd28 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -247,7 +247,7 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	spin_lock(&inode->i_lock);
 	/* Must have all the attributes in the mask and be within cache time. */
 	if ((!flags && time_before(jiffies, orangefs_inode->getattr_time)) ||
-	    orangefs_inode->attr_valid || inode->i_state & I_DIRTY_PAGES) {
+	    orangefs_inode->attr_valid || inode_state_read(inode) & I_DIRTY_PAGES) {
 		if (orangefs_inode->attr_valid) {
 			spin_unlock(&inode->i_lock);
 			write_inode_now(inode, 1);
@@ -281,13 +281,13 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	spin_lock(&inode->i_lock);
 	/* Must have all the attributes in the mask and be within cache time. */
 	if ((!flags && time_before(jiffies, orangefs_inode->getattr_time)) ||
-	    orangefs_inode->attr_valid || inode->i_state & I_DIRTY_PAGES) {
+	    orangefs_inode->attr_valid || inode_state_read(inode) & I_DIRTY_PAGES) {
 		if (orangefs_inode->attr_valid) {
 			spin_unlock(&inode->i_lock);
 			write_inode_now(inode, 1);
 			goto again2;
 		}
-		if (inode->i_state & I_DIRTY_PAGES) {
+		if (inode_state_read(inode) & I_DIRTY_PAGES) {
 			ret = 0;
 			goto out_unlock;
 		}
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 70b8687dc45e..eb3419c25dfc 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -659,7 +659,7 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 		goto out_drop_write;
 
 	spin_lock(&inode->i_lock);
-	inode->i_state |= I_CREATING;
+	inode_state_add(inode, I_CREATING);
 	spin_unlock(&inode->i_lock);
 
 	inode_init_owner(&nop_mnt_idmap, inode, dentry->d_parent->d_inode, mode);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ecb9f2019395..3bc98184f632 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -1149,7 +1149,7 @@ struct inode *ovl_get_trap_inode(struct super_block *sb, struct dentry *dir)
 	if (!trap)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(trap->i_state & I_NEW)) {
+	if (!(inode_state_read_unstable(trap) & I_NEW)) {
 		/* Conflicting layer roots? */
 		iput(trap);
 		return ERR_PTR(-ELOOP);
@@ -1240,7 +1240,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 		inode = ovl_iget5(sb, oip->newinode, key);
 		if (!inode)
 			goto out_err;
-		if (!(inode->i_state & I_NEW)) {
+		if (!(inode_state_read_unstable(inode) & I_NEW)) {
 			/*
 			 * Verify that the underlying files stored in the inode
 			 * match those in the dentry.
@@ -1299,7 +1299,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	if (upperdentry)
 		ovl_check_protattr(inode, upperdentry);
 
-	if (inode->i_state & I_NEW)
+	if (inode_state_read_unstable(inode) & I_NEW)
 		unlock_new_inode(inode);
 out:
 	return inode;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index a33115e7384c..cfc7a7b00fba 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1019,8 +1019,8 @@ bool ovl_inuse_trylock(struct dentry *dentry)
 	bool locked = false;
 
 	spin_lock(&inode->i_lock);
-	if (!(inode->i_state & I_OVL_INUSE)) {
-		inode->i_state |= I_OVL_INUSE;
+	if (!(inode_state_read(inode) & I_OVL_INUSE)) {
+		inode_state_add(inode, I_OVL_INUSE);
 		locked = true;
 	}
 	spin_unlock(&inode->i_lock);
@@ -1034,8 +1034,8 @@ void ovl_inuse_unlock(struct dentry *dentry)
 		struct inode *inode = d_inode(dentry);
 
 		spin_lock(&inode->i_lock);
-		WARN_ON(!(inode->i_state & I_OVL_INUSE));
-		inode->i_state &= ~I_OVL_INUSE;
+		WARN_ON(!(inode_state_read(inode) & I_OVL_INUSE));
+		inode_state_del(inode, I_OVL_INUSE);
 		spin_unlock(&inode->i_lock);
 	}
 }
@@ -1046,7 +1046,7 @@ bool ovl_is_inuse(struct dentry *dentry)
 	bool inuse;
 
 	spin_lock(&inode->i_lock);
-	inuse = (inode->i_state & I_OVL_INUSE);
+	inuse = (inode_state_read(inode) & I_OVL_INUSE);
 	spin_unlock(&inode->i_lock);
 
 	return inuse;
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index e399e2dd3a12..8cc7a336bb44 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -290,7 +290,7 @@ struct inode *qnx4_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	qnx4_inode = qnx4_raw_inode(inode);
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 3310d1ad4d0e..96eb956a6ebc 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -521,7 +521,7 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	ei = QNX6_I(inode);
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 0addcc849ff2..3e5d09d6e4d7 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -302,7 +302,7 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos)
 	if (!i)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(i->i_state & I_NEW))
+	if (!(inode_state_read_unstable(i) & I_NEW))
 		return i;
 
 	/* precalculate the data offset */
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 3bd85ab2deb1..11f77e2cd69a 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -444,7 +444,7 @@ cifs_evict_inode(struct inode *inode)
 {
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
-	if (inode->i_state & I_PINNING_NETFS_WB)
+	if (inode_state_read_unstable(inode) & I_PINNING_NETFS_WB)
 		cifs_fscache_unuse_inode_cookie(inode, true);
 	cifs_fscache_release_inode_cookie(inode);
 	clear_inode(inode);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 211d5b8b42f4..7803d1f23149 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -101,7 +101,7 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 	cifs_dbg(FYI, "%s: revalidating inode %llu\n",
 		 __func__, cifs_i->uniqueid);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		cifs_dbg(FYI, "%s: inode %llu is new\n",
 			 __func__, cifs_i->uniqueid);
 		return;
@@ -146,7 +146,7 @@ cifs_nlink_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	 */
 	if (fattr->cf_flags & CIFS_FATTR_UNKNOWN_NLINK) {
 		/* only provide fake values on a new inode */
-		if (inode->i_state & I_NEW) {
+		if (inode_state_read_unstable(inode) & I_NEW) {
 			if (fattr->cf_cifsattrs & ATTR_DIRECTORY)
 				set_nlink(inode, 2);
 			else
@@ -167,12 +167,12 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
 	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 
-	if (!(inode->i_state & I_NEW) &&
+	if (!(inode_state_read_unstable(inode) & I_NEW) &&
 	    unlikely(inode_wrong_type(inode, fattr->cf_mode))) {
 		CIFS_I(inode)->time = 0; /* force reval */
 		return -ESTALE;
 	}
-	if (inode->i_state & I_NEW)
+	if (inode_state_read_unstable(inode) & I_NEW)
 		CIFS_I(inode)->netfs.zero_point = fattr->cf_eof;
 
 	cifs_revalidate_cache(inode, fattr);
@@ -194,7 +194,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
 	inode->i_gid = fattr->cf_gid;
 
 	/* if dynperm is set, don't clobber existing mode */
-	if (inode->i_state & I_NEW ||
+	if (inode_state_read_unstable(inode) & I_NEW ||
 	    !(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DYNPERM))
 		inode->i_mode = fattr->cf_mode;
 
@@ -236,7 +236,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
 
 	if (fattr->cf_flags & CIFS_FATTR_JUNCTION)
 		inode->i_flags |= S_AUTOMOUNT;
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unstable(inode) & I_NEW) {
 		cifs_set_netfs_context(inode);
 		cifs_set_ops(inode);
 	}
@@ -1638,7 +1638,7 @@ cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
 		cifs_fattr_to_inode(inode, fattr, false);
 		if (sb->s_flags & SB_NOATIME)
 			inode->i_flags |= S_NOATIME | S_NOCMTIME;
-		if (inode->i_state & I_NEW) {
+		if (inode_state_read_unstable(inode) & I_NEW) {
 			inode->i_ino = hash;
 			cifs_fscache_get_inode_cookie(inode);
 			unlock_new_inode(inode);
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index d5918eba27e3..408e3362fca4 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -82,7 +82,7 @@ struct inode *squashfs_iget(struct super_block *sb, long long ino,
 
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	err = squashfs_read_inode(inode, ino);
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index e75a6cec67be..e859646ecb70 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1323,7 +1323,7 @@ int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	inode_lock(inode);
 
 	/* Synchronize the inode unless this is a 'datasync()' call. */
-	if (!datasync || (inode->i_state & I_DIRTY_DATASYNC)) {
+	if (!datasync || (inode_state_read_unstable(inode) & I_DIRTY_DATASYNC)) {
 		err = inode->i_sb->s_op->write_inode(inode, NULL);
 		if (err)
 			goto out;
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index a0269ba96e3d..82019e0c8434 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -114,7 +114,7 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
 	inode = iget_locked(sb, inum);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 	ui = ubifs_inode(inode);
 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index f24aa98e6869..c7c90987ad88 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1962,7 +1962,7 @@ struct inode *__udf_iget(struct super_block *sb, struct kernel_lb_addr *ino,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_unstable(inode) & I_NEW)) {
 		if (UDF_I(inode)->i_hidden != hidden_inode) {
 			iput(inode);
 			return ERR_PTR(-EFSCORRUPTED);
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 8361c00e8fa6..1edd75c8e30d 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -655,7 +655,7 @@ struct inode *ufs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	ufsi = UFS_I(inode);
diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 2ef7742be7d3..e27cfbcfc5c9 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1249,7 +1249,7 @@ xchk_irele(
 		 * hits do not clear DONTCACHE, so we must do it here.
 		 */
 		spin_lock(&VFS_I(ip)->i_lock);
-		VFS_I(ip)->i_state &= ~I_DONTCACHE;
+		inode_state_del(VFS_I(ip), I_DONTCACHE);
 		spin_unlock(&VFS_I(ip)->i_lock);
 	}
 
diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index a90a011c7e5f..86a671d518d4 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -1933,7 +1933,7 @@ xrep_inode_pptr(
 	 * Unlinked inodes that cannot be added to the directory tree will not
 	 * have a parent pointer.
 	 */
-	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
+	if (inode->i_nlink == 0 && !(inode_state_read_unstable(inode) & I_LINKABLE))
 		return 0;
 
 	/* Children of the superblock do not have parent pointers. */
diff --git a/fs/xfs/scrub/parent.c b/fs/xfs/scrub/parent.c
index 3b692c4acc1e..42907000d559 100644
--- a/fs/xfs/scrub/parent.c
+++ b/fs/xfs/scrub/parent.c
@@ -915,7 +915,7 @@ xchk_pptr_looks_zapped(
 	 * Temporary files that cannot be linked into the directory tree do not
 	 * have attr forks because they cannot ever have parents.
 	 */
-	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
+	if (inode->i_nlink == 0 && !(inode_state_read_unstable(inode) & I_LINKABLE))
 		return false;
 
 	/*
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 06ca11731e43..f798ac597c16 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -514,7 +514,7 @@ xfs_can_free_eofblocks(
 	 * Caller must either hold the exclusive io lock; or be inactivating
 	 * the inode, which guarantees there are no other users of the inode.
 	 */
-	if (!(VFS_I(ip)->i_state & I_FREEING))
+	if (!(inode_state_read_unstable(VFS_I(ip)) & I_FREEING))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	/* prealloc/delalloc exists only on regular files */
diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index 7c541fb373d5..c765a28b4556 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -285,7 +285,7 @@ xfs_inode_mark_sick(
 	 * is not the case here.
 	 */
 	spin_lock(&VFS_I(ip)->i_lock);
-	VFS_I(ip)->i_state &= ~I_DONTCACHE;
+	inode_state_del(VFS_I(ip), I_DONTCACHE);
 	spin_unlock(&VFS_I(ip)->i_lock);
 }
 
@@ -309,7 +309,7 @@ xfs_inode_mark_corrupt(
 	 * is not the case here.
 	 */
 	spin_lock(&VFS_I(ip)->i_lock);
-	VFS_I(ip)->i_state &= ~I_DONTCACHE;
+	inode_state_del(VFS_I(ip), I_DONTCACHE);
 	spin_unlock(&VFS_I(ip)->i_lock);
 }
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 4cf7abe50143..a3f57466f6c4 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -334,7 +334,7 @@ xfs_reinit_inode(
 	dev_t			dev = inode->i_rdev;
 	kuid_t			uid = inode->i_uid;
 	kgid_t			gid = inode->i_gid;
-	unsigned long		state = inode->i_state;
+	unsigned long		state = inode_state_read_unstable(inode);
 
 	error = inode_init_always(mp->m_super, inode);
 
@@ -345,7 +345,7 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	inode->i_state = state;
+	inode_state_set_unchecked(inode, state);
 	mapping_set_folio_min_order(inode->i_mapping,
 				    M_IGEO(mp)->min_folio_order);
 	return error;
@@ -411,7 +411,7 @@ xfs_iget_recycle(
 	ip->i_flags |= XFS_INEW;
 	xfs_perag_clear_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
 			XFS_ICI_RECLAIM_TAG);
-	inode->i_state = I_NEW;
+	inode_state_set_unchecked(inode, I_NEW);
 	spin_unlock(&ip->i_flags_lock);
 	spin_unlock(&pag->pag_ici_lock);
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index df8eab11dc48..f019e9dfdf08 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1569,7 +1569,7 @@ xfs_iunlink_reload_next(
 	next_ip->i_prev_unlinked = prev_agino;
 	trace_xfs_iunlink_reload_next(next_ip);
 rele:
-	ASSERT(!(VFS_I(next_ip)->i_state & I_DONTCACHE));
+	ASSERT(!(inode_state_read_unstable(VFS_I(next_ip)) & I_DONTCACHE));
 	if (xfs_is_quotacheck_running(mp) && next_ip)
 		xfs_iflags_set(next_ip, XFS_IQUOTAUNCHECKED);
 	xfs_irele(next_ip);
@@ -2093,7 +2093,7 @@ xfs_rename_alloc_whiteout(
 	 */
 	xfs_setup_iops(tmpfile);
 	xfs_finish_inode_setup(tmpfile);
-	VFS_I(tmpfile)->i_state |= I_LINKABLE;
+	inode_state_add_unchecked(VFS_I(tmpfile), I_LINKABLE);
 
 	*wip = tmpfile;
 	return 0;
@@ -2319,7 +2319,7 @@ xfs_rename(
 		 * flag from the inode so it doesn't accidentally get misused in
 		 * future.
 		 */
-		VFS_I(du_wip.ip)->i_state &= ~I_LINKABLE;
+		inode_state_del_unchecked(VFS_I(du_wip.ip), I_LINKABLE);
 	}
 
 out_commit:
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 829675700fcd..4ae67c0a6f14 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -113,9 +113,9 @@ xfs_inode_item_precommit(
 	 * to log the timestamps, or will clear already cleared fields in the
 	 * worst case.
 	 */
-	if (inode->i_state & I_DIRTY_TIME) {
+	if (inode_state_read_unstable(inode) & I_DIRTY_TIME) {
 		spin_lock(&inode->i_lock);
-		inode->i_state &= ~I_DIRTY_TIME;
+		inode_state_del(inode, I_DIRTY_TIME);
 		spin_unlock(&inode->i_lock);
 	}
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 149b5460fbfd..6963c1d34e3f 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1419,7 +1419,7 @@ xfs_setup_inode(
 	bool			is_meta = xfs_is_internal_inode(ip);
 
 	inode->i_ino = ip->i_ino;
-	inode->i_state |= I_NEW;
+	inode_state_add_unchecked(inode, I_NEW);
 
 	inode_sb_list_add(inode);
 	/* make the inode look hashed for the writeback code */
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 36cda724da89..d5278c36caa0 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -17,7 +17,7 @@ xfs_can_free_cowblocks(struct xfs_inode *ip)
 {
 	struct inode *inode = VFS_I(ip);
 
-	if ((inode->i_state & I_DIRTY_PAGES) ||
+	if ((inode_state_read_unstable(inode) & I_DIRTY_PAGES) ||
 	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ||
 	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK) ||
 	    atomic_read(&inode->i_dio_count))
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 4dc7f967c861..4a293832e8ec 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -644,7 +644,7 @@ static struct inode *zonefs_get_file_inode(struct inode *dir,
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_unstable(inode) & I_NEW)) {
 		WARN_ON_ONCE(inode->i_private != z);
 		return inode;
 	}
@@ -683,7 +683,7 @@ static struct inode *zonefs_get_zgroup_inode(struct super_block *sb,
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_unstable(inode) & I_NEW))
 		return inode;
 
 	inode->i_ino = ino;
-- 
2.43.0


