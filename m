Return-Path: <linux-fsdevel+bounces-62818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAFDBA1E1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 00:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE251C8169B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 22:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E6A2D837E;
	Thu, 25 Sep 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR4lgmZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1C4158545
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840333; cv=none; b=t1mVehUMbPqAc1beOiZVBNGfVr2/NlLbGuy/i7sQdH5bT0RVftdTeQjXVrAbMVxdOGY+cTgxJHJYYJG1ykJOST4AtKYLSGPNReJxC8vHJU7mfkN7SsmeA07WSuytPpAzWFSfxWr9vPdFYnwyeQlTh8n9m8dHn1WDeYKL1+hKNSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840333; c=relaxed/simple;
	bh=E47LAakMdkkXB0RutdLPauzigd+S94xmd7xXzPX9/Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMBvv6QEaQWcQDk8MtbTPNycssRhSpaq/MlKJEanW+sii1d/o665EuhRSCWXuQzdf6X6xmbyvqHyvC0I2rsUDe4bdKtLLkzzkbf+T1wNQCdFA/Q5RVILeJwguOR65EzCQLVrcjB7JHTUpXOrq7rVBgZxXQu/m7PtOQazFxEQcf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR4lgmZJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f343231fcso976782b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 15:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758840332; x=1759445132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idCjVw5RF3fd8WhtCN+GkoKfPh5DBfjRpnOC3Ua1fOE=;
        b=eR4lgmZJ4i0+BtckictTNA98Yrt6wbzdGRJEbs2SDe7LD4mtO7uwcSP9aNnsrszguT
         Qhy65XKCJXEArsqxwyvUuCLq88d15LpYBI1hV72uyGif50fuS7F4I1fXgtBamWux2yiy
         BUn6xYtv0MPR1etl17Sjj4/gtlKFIM9rpitdmnQ7/+Ki61gOq6ROKle3WYxHuKTNx+1D
         8swc3sXc+Um9W+/WYPZjO4D8VMBXc/nYCwN3Hq46NeFZbO8WR3b4D7GjdiD359B8IK7N
         s8+8falMZODRVr7vJxlpiFfGwmDRYOlY2qekK+2Gm8CDvHsRyHqd2jTELafi3N1V9Zhh
         5iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758840332; x=1759445132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idCjVw5RF3fd8WhtCN+GkoKfPh5DBfjRpnOC3Ua1fOE=;
        b=O7pUwfl2nXz3L5Mk+ZMwgjZJDz+unL7/nAESjqxSXm1dQssy1a85WpUfgo+Hq9BWC0
         FvuQe/r1/mMQ2kBE2AgPcVapaGRMbIckbebO+QeRTSgzWYuhQHq5u8+N5oPQ6RnGXBwO
         vRaGFFz+Bfbv79rD6UmE3c5/uSbR0QNrabsss15kpF5aVGrsS/icIiCkGAdR+SyrI3iI
         4sRLa6Z5igIh7JgeZ0glKJpNuZRi2XWiOFtTcpC5LrIZkvqGIiJurKdjhtztGdHY0krN
         UyiP5VhUavWLwVuUISI1rb/ORFLNSlE0Aoy+iXkqW2b5pPVxj1DEsT6ispD87QPoPJ8k
         x1Kw==
X-Gm-Message-State: AOJu0YzzIXwJkefGWKG9W9vrePPeul2jrultLekYTd52W1pH3g1izvzN
	2fp+TKRGthqk+BS8o3lVSkcuGcVRqaFyAnczpRihpq8hA28qK01xkdd+oNUmJQ==
X-Gm-Gg: ASbGnctqQnz3ZG2UE5NsgvqPtaIicqir0yCZ9v2Pd+HjVwKmd9qDmxsjdfspC/V6V/4
	a58xNdm29b0bAkT4zdMtImRjJPrV1TUGONauydyc905dvyjZg+30dT4+rgcZ01KzbmrrFyRPmc0
	zt5BTDNsyaEc2USZgvz35J5jxL4IiQe+kWTow1Yx8D+ZByrm2jeFlucnDBrZZ1/jP3ObJ5amGsG
	wbdly7OLhRkDx0q/1HPDbSji5RJ7L/20kt1bpWPJGZgNeJfMVQThGGPpwwbP5bRUepXk8QMXBn1
	++CWwUYCxNeS2HL6HjPSBi2lC55PjgF9i3JnJFVa0555AHcS3cifyLiyrH/xb0EyAcAdQ354MIs
	DXyg0Mcay0XPgyLA0E7TCm1fRgxPup53pi6BNZvLyAamrbkFa
X-Google-Smtp-Source: AGHT+IEASRbiKqvcwTcAJp5lDLsYP/NV3HQ/MZ7vWDGQ5nJ8T9sRLwKqJIcQUiIMUmEi/bzfzcNk0A==
X-Received: by 2002:a05:6a00:4652:b0:77f:d4c:d815 with SMTP id d2e1a72fcca58-780fcf12f08mr6290036b3a.32.1758840331524;
        Thu, 25 Sep 2025 15:45:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b2915csm2871816b3a.55.2025.09.25.15.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 15:45:31 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	osandov@fb.com,
	kernel-team@meta.com
Subject: [PATCH] fuse: fix readahead reclaim deadlock
Date: Thu, 25 Sep 2025 15:44:04 -0700
Message-ID: <20250925224404.2058035-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A deadlock can occur if the server triggers reclaim while servicing a
readahead request, and reclaim attempts to evict the inode of the file
being read ahead:

>>> stack_trace(1504735)
 folio_wait_bit_common (mm/filemap.c:1308:4)
 folio_lock (./include/linux/pagemap.h:1052:3)
 truncate_inode_pages_range (mm/truncate.c:336:10)
 fuse_evict_inode (fs/fuse/inode.c:161:2)
 evict (fs/inode.c:704:3)
 dentry_unlink_inode (fs/dcache.c:412:3)
 __dentry_kill (fs/dcache.c:615:3)
 shrink_kill (fs/dcache.c:1060:12)
 shrink_dentry_list (fs/dcache.c:1087:3)
 prune_dcache_sb (fs/dcache.c:1168:2)
 super_cache_scan (fs/super.c:221:10)
 do_shrink_slab (mm/shrinker.c:435:9)
 shrink_slab (mm/shrinker.c:626:10)
 shrink_node (mm/vmscan.c:5951:2)
 shrink_zones (mm/vmscan.c:6195:3)
 do_try_to_free_pages (mm/vmscan.c:6257:3)
 do_swap_page (mm/memory.c:4136:11)
 handle_pte_fault (mm/memory.c:5562:10)
 handle_mm_fault (mm/memory.c:5870:9)
 do_user_addr_fault (arch/x86/mm/fault.c:1338:10)
 handle_page_fault (arch/x86/mm/fault.c:1481:3)
 exc_page_fault (arch/x86/mm/fault.c:1539:2)
 asm_exc_page_fault+0x22/0x27

During readahead, the folio is locked. When fuse_evict_inode() is
called, it attempts to remove all folios associated with the inode from
the page cache (truncate_inode_pages_range()), which requires acquiring
the folio lock. If the server triggers reclaim while servicing a
readahead request, reclaim will block indefinitely waiting for the folio
lock, while readahead cannot relinquish the lock because it is itself
blocked in reclaim, resulting in a deadlock.

The inode is only evicted if it has no remaining references after its
dentry is unlinked. Since readahead is asynchronous, it is not
guaranteed that the inode will have any references at this point.

This fixes the deadlock by holding a reference on the inode while
readahead is in progress, which prevents the inode from being evicted
until readahead completes. Additionally, this also prevents a malicious
or buggy server from indefinitely blocking kswapd if it never fulfills a
readahead request.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reported-by: Omar Sandoval <osandov@fb.com>
---
 fs/fuse/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f1ef77a0be05..8e759061b843 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -893,6 +893,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	if (ia->ff)
 		fuse_file_put(ia->ff, false);
 
+	iput(inode);
 	fuse_io_free(ia);
 }
 
@@ -973,6 +974,12 @@ static void fuse_readahead(struct readahead_control *rac)
 		ia = fuse_io_alloc(NULL, cur_pages);
 		if (!ia)
 			break;
+		/*
+		 *  Acquire the inode ref here to prevent reclaim from
+		 *  deadlocking. The ref gets dropped in fuse_readpages_end().
+		 */
+		igrab(inode);
+
 		ap = &ia->ap;
 
 		while (pages < cur_pages) {
-- 
2.47.3


