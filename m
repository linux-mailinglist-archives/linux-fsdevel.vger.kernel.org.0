Return-Path: <linux-fsdevel+bounces-37192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD26C9EF4C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CD91888503
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2733236F94;
	Thu, 12 Dec 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VagGSOPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910B23695A;
	Thu, 12 Dec 2024 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021964; cv=none; b=SxOwduQe7U3gTiijInju0PjntYkEh5ins9lwX8E852wvlTZyuTHXCMHV71xyGNpYJeZt5dnxl4rBHYAGKOj4etzV8FvajFiX2tASx9dmuQrE7srAMrGcWXATWxfgBlyCdVBbL3lfAPItqsVj/vbtVsEDbhYdBrDarVPhK+ipAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021964; c=relaxed/simple;
	bh=HlADCKvaOAXcxb8w0ypEdR1v7JeaSkex81KKxMkz1MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNZAT/SSOac4f9iPpHjccn0dFl3EC0K+HH5cvTp5+dHbWgFDNP6PVTLpGM/RfwJNLCYji7SWGqn6fgOGQJhZUxC7yPZEy9S2v0jrEv9YCag6hPvkyh4+FCRe4sfrw8xVYKa95mbk0Gpdl1W/yPBXbLcopqWT9M+8rXUBuqWPbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VagGSOPS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso543054a91.2;
        Thu, 12 Dec 2024 08:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734021962; x=1734626762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+SQ7TaX7WZ+52UKYXtXpaGJPN7h5YcD1VfWnOtMP8Zo=;
        b=VagGSOPS8W0MauAQHeeIh0ItFbQ1QPSNnKlrKICRJsh+AH8JCVvITLibAWMXkOpu2B
         xatY99+NMYKskANsoCNFCJsFrnuhxG7hSToze26GGDZI7z0JV0lGBPBX9lhPhd3kg9qZ
         YnFz0GXbaakrg7XPsQ9f2eR0SNvQDalEJUZ45+3YCO8uJbMrJoXIKNBi/+YdSTunTf8b
         iD30dXzg4Ec+sE6NrsSu7Nbxdogm5zSiZHXaT5Osz8B0rygwyHsED1HN0roylu137ECN
         4+nVpG0CrUXwOqZdxmLCKEftTrp7p2wsKYShInFKWaG4KOVJ6qeJ9RXiCK9uAbffXT/m
         T2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734021962; x=1734626762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SQ7TaX7WZ+52UKYXtXpaGJPN7h5YcD1VfWnOtMP8Zo=;
        b=uRI/PokoHkvWqGLZt0syElNlLPC+zinv9Mzj6pkDb/9zTAk/tEMfn0vsdHm1ARPZIm
         i0EZEy7R3VsofxRTxfsgP9xbJfZRstWiVa5OYhjY5izpURaylLuZ2qCdAlUXmvkpX9CT
         k6Uo0gl8mM8x8h585Wrl1M3ULabCh9aCtSTQPunyJOIrnYVyh2n8CLGgoPgPWB+T9w7h
         ymRPsRugpeckMHg27bER0LIJSTTLKf/WpMn5ifI11s9Nv0DmMXrs7HOwtUFE71vhSrm3
         Xd5aA5+BRz0xR0/ZCv/NM6J/OKrQDcm0r1XmmSkrlD5QxJX1fB0H4/b9hPrBxDq4TfyQ
         +h6g==
X-Forwarded-Encrypted: i=1; AJvYcCVisIC+Ur58chMLFtz2IGYlxDLefZAIuSC19ph0CIud7OhtuqjqupkHUjoLXr8yk3yMoySg75xEKXCvsMRg@vger.kernel.org, AJvYcCWdbNzSlitDq9V4h9E+tlfcM7OdqiIydxoyhyUyUkg/lpiIh0mwjDBigvw0TxeEbrMsist9nvMPPZ0xKJFF@vger.kernel.org
X-Gm-Message-State: AOJu0YwSULPNXUf4k5vgEDhKAiq6FOeJ4NqkdRe27MeLkh3PvbZsQjJN
	5jPd9zefRW6Ka2BCC+XTDM4kyl38JTUh6SSl4bT3DaqRnHfxkzmnrZHQNQ==
X-Gm-Gg: ASbGncuclxMDhrV3ufAlbU42OPqPlDqFHRSn40Aj3yhTtyZWHVixCPROXq5uPkXCjvh
	VpkT+vxw/AsXf/6TZaXB6snA8rwJGNhdq/tUpALokluJrsjIsWELXEOaLbT3trbO7G7B5TS7baT
	3H6wsVPyzfk+V5ODdPFFVLs3aM5anmfT78wL58jEuZpt5sQBsvyYAHTJEYRWKEH1veTwmQhiT8q
	Mbed34hC8KR/Z/w5DsNnjFAg+aOPcWdN1nq7jHk0yEek/V+nx76Z+Sgp9VQ/EEVT8Hr1eQ0iGUR
	QJGVaQ+bmrCmCnCTPOJIfTGkKcz1c/E=
X-Google-Smtp-Source: AGHT+IHun+rE/vu4gLOWafc+nPtZg39cy9jheqPZvW3TNo8G/wyamWMCBu8H6NUTUxBjpYJXQtvXFQ==
X-Received: by 2002:a17:90b:4c43:b0:2ee:d7d3:3019 with SMTP id 98e67ed59e1d1-2f1392940e9mr8435801a91.12.1734021961529;
        Thu, 12 Dec 2024 08:46:01 -0800 (PST)
Received: from carrot.. (i114-186-166-114.s41.a014.ap.plala.or.jp. [114.186.166.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142de78d7sm1488917a91.31.2024.12.12.08.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:46:00 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] nilfs2: fix buffer head leaks in calls to truncate_inode_pages()
Date: Fri, 13 Dec 2024 01:43:28 +0900
Message-ID: <20241212164556.21338-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When block_invalidatepage was converted to block_invalidate_folio,
the fallback to block_invalidatepage in folio_invalidate() if the
address_space_operations method invalidatepage (currently
invalidate_folio) was not set, was removed.

Unfortunately, some pseudo-inodes in nilfs2 use empty_aops set by
inode_init_always_gfp() as is, or explicitly set it to
address_space_operations.  Therefore, with this change,
block_invalidatepage() is no longer called from folio_invalidate(), and
as a result, the buffer_head structures attached to these pages/folios
are no longer freed via try_to_free_buffers().

Thus, these buffer heads are now leaked by truncate_inode_pages(), which
cleans up the page cache from inode evict(), etc.

Three types of caches use empty_aops: gc inode caches and the DAT shadow
inode used by GC, and b-tree node caches.  Of these, b-tree node caches
explicitly call invalidate_mapping_pages() during cleanup, which involves
calling try_to_free_buffers(), so the leak was not visible during normal
operation but worsened when GC was performed.

Fix this issue by using address_space_operations with invalidate_folio
set to block_invalidate_folio instead of empty_aops, which will ensure
the same behavior as before.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Fixes: 7ba13abbd31e ("fs: Turn block_invalidatepage into block_invalidate_folio")
Cc: stable@vger.kernel.org # v5.18+
---
Hi Andrew, please apply this as a bug fix.

This fixes buffer head memory leaks (seen by slabinfo and runtime
function call checks) that gets worse during GC.

Thanks,
Ryusuke Konishi

 fs/nilfs2/btnode.c  | 1 +
 fs/nilfs2/gcinode.c | 2 +-
 fs/nilfs2/inode.c   | 5 +++++
 fs/nilfs2/nilfs.h   | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 501ad7be5174..54a3fa0cf67e 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -35,6 +35,7 @@ void nilfs_init_btnc_inode(struct inode *btnc_inode)
 	ii->i_flags = 0;
 	memset(&ii->i_bmap_data, 0, sizeof(struct nilfs_bmap));
 	mapping_set_gfp_mask(btnc_inode->i_mapping, GFP_NOFS);
+	btnc_inode->i_mapping->a_ops = &nilfs_buffer_cache_aops;
 }
 
 void nilfs_btnode_cache_clear(struct address_space *btnc)
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index ace22253fed0..2dbb15767df1 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -163,7 +163,7 @@ int nilfs_init_gcinode(struct inode *inode)
 
 	inode->i_mode = S_IFREG;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
-	inode->i_mapping->a_ops = &empty_aops;
+	inode->i_mapping->a_ops = &nilfs_buffer_cache_aops;
 
 	ii->i_flags = 0;
 	nilfs_bmap_init_gc(ii->i_bmap);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index b7d4105f37bf..23f3a75edd50 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -276,6 +276,10 @@ const struct address_space_operations nilfs_aops = {
 	.is_partially_uptodate  = block_is_partially_uptodate,
 };
 
+const struct address_space_operations nilfs_buffer_cache_aops = {
+	.invalidate_folio	= block_invalidate_folio,
+};
+
 static int nilfs_insert_inode_locked(struct inode *inode,
 				     struct nilfs_root *root,
 				     unsigned long ino)
@@ -681,6 +685,7 @@ struct inode *nilfs_iget_for_shadow(struct inode *inode)
 	NILFS_I(s_inode)->i_flags = 0;
 	memset(NILFS_I(s_inode)->i_bmap, 0, sizeof(struct nilfs_bmap));
 	mapping_set_gfp_mask(s_inode->i_mapping, GFP_NOFS);
+	s_inode->i_mapping->a_ops = &nilfs_buffer_cache_aops;
 
 	err = nilfs_attach_btree_node_cache(s_inode);
 	if (unlikely(err)) {
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 45d03826eaf1..dff241c53fc5 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -401,6 +401,7 @@ extern const struct file_operations nilfs_dir_operations;
 extern const struct inode_operations nilfs_file_inode_operations;
 extern const struct file_operations nilfs_file_operations;
 extern const struct address_space_operations nilfs_aops;
+extern const struct address_space_operations nilfs_buffer_cache_aops;
 extern const struct inode_operations nilfs_dir_inode_operations;
 extern const struct inode_operations nilfs_special_inode_operations;
 extern const struct inode_operations nilfs_symlink_inode_operations;
-- 
2.43.0


