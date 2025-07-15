Return-Path: <linux-fsdevel+bounces-55027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B71B067AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 22:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4B07B306A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BAF2727EC;
	Tue, 15 Jul 2025 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEjiK8G2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69217BA1
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610963; cv=none; b=eDTfMYM14lcx4GLYCLJ0+qLMvnb8MKvsLPkFNID1QVONlpm6QKxKAj11eML36RueIpnTaHTM/ztiKPFRwc008BRvscZ14GJpE9fvj3uyC2VfD5RKNQNqxCT7eX+QscDNXkCyx1Lii0DHR5N+UwcIdnGftHwI3QG8z9etzyu5K0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610963; c=relaxed/simple;
	bh=Ch+CZx7TZ7F54FbyfZ/0+OKxokfAWGx8gsnf2OGTu+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7WnvKI8AaIg0zbslORokEM8uB68Phftw7OFPDEtpuaKmf41FAPyqk3EC0bGhsbbYrktCTsAdMsEAG51P1xoJ2E7tvF/PFKLSLPMRVlazpdwXaUBrdN6LscEsalCOrBSzzxdCFd0bpebTo5Zphl0RJ3ns60AYrEjToqH5YH1vhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEjiK8G2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso5012605b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752610961; x=1753215761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KagfI0pb+quhaXjh6/j/Ry9JkKH01hHj0kJW9rIFGJc=;
        b=YEjiK8G25CPuF9yOS9PyXXtOzVl59FRjnIFoqsK4AMDkyjoyWTF26733O6kfFUG7Pl
         tCw5jLGmsdyLJztwVz+fxmu2Jkhd+X0qaZofiNxJmWrL2x5zwifU7rpHaDPamo1aJ5yN
         KXqKWSHEVZFgVXYlzcA4wF0IJAwXntO7jq68Z/8eCB7YBaE2o6vIX66W6rzBv27XDBpw
         FkjaaQRbRceI0n5PCif4sbQB7CAN1XmGp9KGJIHeI7ZT0xrAO4f7uDpiXbbLSpmdAl4S
         p2AbtOdsVsJXVm0o5eFV9duQpLeexC7E57NTdV87ob5VOxu13uP0lBqweXvC2q7g4lUI
         zVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752610961; x=1753215761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KagfI0pb+quhaXjh6/j/Ry9JkKH01hHj0kJW9rIFGJc=;
        b=XzZXXwDzZklQBrdGWt7mc+uBpzWuN+l4972iqytHw3t/xInzeDaWSDu4yQ5ZbwD/Oa
         T3CyBicFol5XYAVZmSWIe/Bp2hRyea6ybdVOyV8z4W0pq7DSzv9LZU1hrjpWgsizPflM
         7jlGwK6fJZwKIqrIgDV17r3NTG+nfLBsxPYZVfs24U0sNgI99S/tLDMzbdMXJ7D+/SAb
         F9kEmVTh3LYDfTbfxYIXLvZKFw1+aIjSFes/11q/NDNw3XJF1H/t3KX4QAGnHH1uOF3C
         fRZmUwa3lZfzcjiVvSuZ3yTvgYmPnK8f44x5ONY2lYybuMYcV8L8KJUzCZelaGCYoQjY
         d5ZQ==
X-Gm-Message-State: AOJu0YyLLhyW2FK9jz09lrarxBOJC66oTYqDsuuAozIAcbVwFd/PUq4X
	s4rfAzK/6tnR4m5G1qkG41yphbOaz3bN6bNUnjm0oxHn4yVUX8N6LsF4SKX98w==
X-Gm-Gg: ASbGncsG6ak7waBcFhQ/oQT5Xad1dwZMCzag6fX9LiQLGRByhcbFEF5YMZkT2LwTmAS
	QeW6x7GziygoOUFYkK8ptlE3OWTEjOsD4GnnTzRRu/h/uCJQvCPMciWRAXQYyxt3A/HUjb6W3P+
	+6ExkUB158iOwv5TZe8X3AeCAk5oOh/6OEXavnK/KmlIPsuZKcxVcS0sL2nZPSkKdCCCpxU+s8C
	IF+UiCnvCwU30b6LJwoyJfV/sBT5ieY+vvljduE/2YF+Anqll543RYu18QjQagv1XpESYX7cQKu
	xSHYnmXyy3rsKoL7gePrsbAOTIvKToU2iJvFDjOAZmhKJ1Mb7xKyPi5zwA8JFN/MqwfOXJdSJyp
	D5k1vZtgQ+OeHWtOmuw==
X-Google-Smtp-Source: AGHT+IHJT43/Iyp23XQBBZ9jse5Q5+/2J2fxeADJc3PMNsJOl7nMuFT4IrPe+7NYhwdyNeWjD2UWpg==
X-Received: by 2002:a05:6a00:1a86:b0:748:3a1a:ba72 with SMTP id d2e1a72fcca58-756ea1d38ffmr906375b3a.20.1752610961304;
        Tue, 15 Jul 2025 13:22:41 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe579a70sm12536746a12.17.2025.07.15.13.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:22:40 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	kernel-team@meta.com
Subject: [PATCH v5 0/5] fuse: use iomap for buffered writes + writeback
Date: Tue, 15 Jul 2025 13:21:17 -0700
Message-ID: <20250715202122.2282532-1-joannelkoong@gmail.com>
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

This patchset is on top of Christoph's iomap patchset which is in his git
tree git://git.infradead.org/users/hch/misc.git iomap-writeback-refactor and
has been merged into the vfs tree.

The changes in this patchset can be found in this git tree, 
https://github.com/joannekoong/linux/commits/fuse_iomap/

Please note that this patchset does not enable large folios yet. That will be
sent out in a separate future patchset.

Thanks,
Joanne


Changeset
-------
v4 -> v5:
* Use PAGE_SHIFT instead of dividing by PAGE_SIZE (Darrick)
* Add comment about nr_bytes not overflowing
* Round number of pages up when comparing against max_pages (me)

v4: 
https://lore.kernel.org/linux-fsdevel/20250709221023.2252033-1-joannelkoong@gmail.com/

v3 -> v4:
* Get rid of writethrough goto (Miklos)
* Move iomap_start_folio_write call to after error check (Darrick)
* Tidy up args for fuse_writepage_need_send() (me)
v3:
https://lore.kernel.org/linux-fsdevel/20250624022135.832899-1-joannelkoong@gmail.com/

v2 -> v3:
* Fix up fuse patches to use iomap APIs from Christoph's patches
* Drop CONFIG_BLOCK patches
* Add patch to use iomap for invalidation and partial uptodateness check
* Add patch for refactoring fuse writeback to use iomap_writepage_ctx inode
v2:
https://lore.kernel.org/linux-fsdevel/20250613214642.2903225-1-joannelkoong@gmail.com/

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
v1:
https://lore.kernel.org/linux-fsdevel/20250606233803.1421259-1-joannelkoong@gmail.com/

Joanne Koong (5):
  fuse: use iomap for buffered writes
  fuse: use iomap for writeback
  fuse: use iomap for folio laundering
  fuse: hook into iomap for invalidating and checking partial
    uptodateness
  fuse: refactor writeback to use iomap_writepage_ctx inode

 fs/fuse/Kconfig |   1 +
 fs/fuse/file.c  | 345 +++++++++++++++++++++---------------------------
 2 files changed, 154 insertions(+), 192 deletions(-)

-- 
2.47.1


