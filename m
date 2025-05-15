Return-Path: <linux-fsdevel+bounces-49180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A93AB9024
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2C13A3D72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37DF269B07;
	Thu, 15 May 2025 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkYge+4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAEC2222BB;
	Thu, 15 May 2025 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338671; cv=none; b=oeRFBOivgmO+lcCB0nHjKXTv+DxroqbWrC+QBaBFaEqlyY3I23oJNAUsvrjs2XIjkJGVIltoPLYoP4TIZD3wpNOTnULyxSBZ/yzHQRsE1cwVSyCkEV+T/faOcqM0dUlvJXCHK62ZlQlErnFBuqmLa7RrwOgEYS9hM5bzdInSXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338671; c=relaxed/simple;
	bh=8zWO0nKuJHyuY19P4C+gl+fN9bTE1bgyXr+ig07KTIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g/zHPGYydHeu2cEg+mxYltr8Q2tYVdbex8c7nxUmq85Z3ktKC1jlth5OCk/244Gn+tAwqLs01/l35RijHgnBR82wlcUKpObIlwLB8fzNoP4AJDQhqEZie0qQpbmcl8RyrtyF1eSapoKJd6HOLJ25WJShg9FlMfpaPx8ND5NxIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkYge+4o; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-afc857702d1so1059265a12.3;
        Thu, 15 May 2025 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747338668; x=1747943468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zxs9mEdD69SShrgx9NFel2fGCaImIkFf/eWEMXh924g=;
        b=YkYge+4odwWgXqcWRB3oEoSx0i2Ys1Sv5byDvmQXaJLfd480MUWc2kqh7/eM5yencl
         4++isx/r+S10GNHEu6wcR3VROkAlxUs41QEdMu3F8KFKiFFrb7vSpyBQTWCpbeCLztOB
         SdrHz5lIgdmuLNDDhL+UdceOI9BJhMNujBsmW2VPbgI2hMX1X/gRnWve+Dqi+oHmekrt
         kjRVSpwKHt+bZ7SnwGUPQWw2+z4joAszt0kE+sJT6wui4vWUEuhPvsQK4dwtkfvti0Jg
         rp8/oy2cbXYcrTd3Cxn4Centen1JZzkTCfAaSy3Ar7geSB+S2XdFq06BusWEQG1TAhdJ
         qApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747338668; x=1747943468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zxs9mEdD69SShrgx9NFel2fGCaImIkFf/eWEMXh924g=;
        b=N6Gw+1DZD35twcxbPprP4kacR4qKsgGtsTe2M6nRnxBXrLa91Q2mi9sTZ4l6jDi/G6
         wtOBGKvb4gFkOsfYmdYGSWq88Dn+RgYgWKLNn96QL2XuX03qWH7mTvhFn1kZxy09cSNG
         KPUkUScW2TkgT9dnJy1zN3KS/9QQU4SVdj1yqbAxEdFRgaeQrB8lMoD5P5yf55jAxk1y
         fUyhqBl5xO1rfqfqEDrmlnjMmWpQZxexyMWMJc5YL/ZyW+i+mw3ndyVqLbiP4h7bVeRg
         BR1YwC+SYl6Ls3xxzBLN0H6oKg4y5ayXVPcSfQYxjA6xwbcLwS2rWPy1u8AgZMIuDkG+
         bg+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6DFn38EYVr6zKP+evhdp8jJ//xIjSNWDomjFmGdok4j0CFyntSV00b4U9CPwW0HV8c7Les+1wxh1yY8UI@vger.kernel.org
X-Gm-Message-State: AOJu0YwND0QPW7mGVLCEM9dTjN2Fyz38gOVSu95XRhXtB6U1cCbp87aX
	9eB8Cwu2xGa1AMrU3XIfI37XxS+Fs7EZ5f/CfybS1cxfxKyWM5VdsOJK9zHO2Q==
X-Gm-Gg: ASbGncswSD7TrReYg2nfXfivvcEn8nyanNlEPAPy5JrdLk++qfJKgPBsLw2Pynv5Rw5
	imE476Uip6IfVVaINTi48ezBHiq3OLj0i7tdpEgH4RwSs3pdvTFYMfYkcYbdh+StfETvCP2N8AO
	Ytoqv1ABRIGgL4bT0F4+WQ+E1Zljkk8LfsJVMWWDGdrZK6KIVefRx+rd1UsMj9Z5B/cTIqR6tjt
	GlsRsPNyenmMJ8TmZ0Xao+IYT0exYoKhcZRr26FINuJ7DHgEO0740XmamB9p2TUbSMjs/lHsqde
	nhA8ckAF+ELgUAyZc8ncnCb11b/nVuJ9whQZx5KXsXJFNBo=
X-Google-Smtp-Source: AGHT+IEEobN/ph0UrTw1HKSXhckJbRXBdxx+SavBEw8fkJScZbUD7b4UE1lDrUunR5W/qFGSlRlAGA==
X-Received: by 2002:a05:6a21:502:b0:203:ca66:e30 with SMTP id adf61e73a8af0-216219edf88mr1081288637.37.1747338667987;
        Thu, 15 May 2025 12:51:07 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a9893sm280463a12.72.2025.05.15.12.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:51:07 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 0/7] ext4: Add multi-fsblock atomic write support with bigalloc
Date: Fri, 16 May 2025 01:20:48 +0530
Message-ID: <cover.1747337952.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds multi-fsblock atomic write support to ext4 using bigalloc. The major
chunk of the design changes are kept in Patch-4 & 5.

v4 -> v5:
=========
1. Addressed review comments and added Acked-by from Darrick.
2. Changed a minor WARN_ON(1) at one place to WARN_ON_ONCE(1) in patch-5 in
   ext4_iomap_begin(). Ideally we may never hit it.
3. Added force commit related info in the Documentation section where
   mixed mapping details are mentioned.
[v4]: https://lore.kernel.org/linux-ext4/cover.1747289779.git.ritesh.list@gmail.com/

v3 -> v4:
=========
1. Added force txn commit in ext4_iomap_alloc(), in case we ended up allocating
   and converting unwritten to written conversion during allocation time. This
   happens when the underlying region has mixed mapping [1].
2. Addressed review comments from Darrick and Ojaswin.
3. Ran few data integrity tests on actual nvme device supporting atomic writes.

[v2]: https://lore.kernel.org/linux-ext4/cover.1746734745.git.ritesh.list@gmail.com/
[1]: https://lore.kernel.org/linux-ext4/87msbfyqcm.fsf@gmail.com/T/#m9f6607cc0e65e9fd29e675c5c15b3a03ff02110e

v2 -> v3:
=========
1. Improved error handling at several places.
2. Further fixed some worst case journal credits estimation.
3. Added better checks in the slow path allocation loop for atomic writes.

v3 testing so far:
===============
- This has survived "quick" & "auto" group testing with bigalloc on x86 and Power.
- We have also tested atomic write related tests using fio and some data integrity
  tests with sudden power off during writes on scsi_debug module.
  (Will clean up these tests and try to post them out soon!)

Appreciate any review comments / feedback!

v1 -> v2:
==========
1. Handled review comments from Ojaswin to optimize the ext4_map_block() calls
   in ext4_iomap_alloc().
2. Fixed the journal credits calculation for both:
	- during block allocation in ext4_iomap_alloc()
	- during dio completion in ->end_io callback.
   Earlier we were starting multiple txns in ->end_io callback for unwritten to
   written conversion. But since in case of atomic writes, we want a single jbd2
   txn, hence made the necessary changes there.
[v2]: https://lore.kernel.org/linux-ext4/cover.1745987268.git.ritesh.list@gmail.com/


Ritesh Harjani (IBM) (7):
  ext4: Document an edge case for overwrites
  ext4: Check if inode uses extents in ext4_inode_can_atomic_write()
  ext4: Make ext4_meta_trans_blocks() non-static for later use
  ext4: Add support for EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS
  ext4: Add multi-fsblock atomic write support with bigalloc
  ext4: Enable support for ext4 multi-fsblock atomic write using bigalloc
  ext4: Add atomic block write documentation

 .../filesystems/ext4/atomic_writes.rst        | 225 +++++++++++++
 Documentation/filesystems/ext4/overview.rst   |   1 +
 fs/ext4/ext4.h                                |  26 +-
 fs/ext4/extents.c                             |  99 ++++++
 fs/ext4/file.c                                |   7 +-
 fs/ext4/inode.c                               | 315 ++++++++++++++++--
 fs/ext4/super.c                               |   7 +-
 7 files changed, 655 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/filesystems/ext4/atomic_writes.rst

--
2.49.0


