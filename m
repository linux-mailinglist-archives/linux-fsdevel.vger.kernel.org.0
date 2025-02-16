Return-Path: <linux-fsdevel+bounces-41795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B84A37602
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 17:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5E63A7696
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F030819E967;
	Sun, 16 Feb 2025 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VjgOO79O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F00450FE;
	Sun, 16 Feb 2025 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724636; cv=none; b=qZQNyKrpYfxuCGG1KtRzpTUst6qh0kIfU2T/I5OVJYNKJlZ3bA7hoDmqQt+yL0FS+qp8faYlOtVQpuATqPv4SA/7COKe0pke+FTSpuC++x6dDrNBcPy3r/IOaIR+ncsMJL/+cymUgr5KthPJ3sjwpj6g1qwm6Ao7Fa2gx6BSgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724636; c=relaxed/simple;
	bh=O+xf4Pjh0FmkOANa2TdynZ4baqKl4IxACwdRgqvC/gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5164bMbKE+bCDpeuN5mqu/jEFMJA2EsVvuKje9mMm+JbQ+JrytpPj5wyJtTkPAvu5gq/ZZf1cuFKDifE+teFc2/oOK42Wucz3E/DB+0zeukxmKEPpiTkxH710KdqFmB1VaCgbJeU1Lh/IX6iHIrlfHV6ABDGcAAWxDyNrJZ9BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VjgOO79O; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ndDFacYqo5RlTSgmq7eZGeOr8WEe1xcV2iL6qYnhkrE=; b=VjgOO79O9dV3jmyYmrxcyFKIzx
	ZZsgTTEktk+7JOZ2gQPmpUmzDtszyHdRfl+cW2yGNpgmlkTQuwS//AD7dx2fgR8b1fjFXgZ62nwC8
	opA5jNImvhrvDsk6V2O96fFuDvojeNt1wGPIYrmHisaIZ4t8QtQ9RoNNYzRExb7/vq8TFR8MHYlkO
	+eMjeEAm/tNuf60ca5jO1zDzSy0a1KeUW9D+khJDevmhE+hJoD1atZLKakcxe+1Mtz+v/ZJfK2A73
	sd60MvpYswXDFuO6s1aUCuWxQhKn4E3tH1vQPzjxcjvEp5IM919pkhchG2Kc5PhtAWRwe5D6SODul
	/7Gu9Njg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tjhqO-005FJp-JW; Sun, 16 Feb 2025 17:50:18 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH v5 1/2] vfs: export invalidate_inodes()
Date: Sun, 16 Feb 2025 16:50:07 +0000
Message-ID: <20250216165008.6671-2-luis@igalia.com>
In-Reply-To: <20250216165008.6671-1-luis@igalia.com>
References: <20250216165008.6671-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/inode.c         | 1 +
 fs/internal.h      | 1 -
 include/linux/fs.h | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 5587aabdaa5e..88387ecb2c34 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -939,6 +939,7 @@ void invalidate_inodes(struct super_block *sb)
 
 	dispose_list(&dispose);
 }
+EXPORT_SYMBOL(invalidate_inodes);
 
 /*
  * Isolate the inode from the LRU in preparation for freeing it.
diff --git a/fs/internal.h b/fs/internal.h
index e7f02ae1e098..7cb515cede3f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -207,7 +207,6 @@ bool in_group_or_capable(struct mnt_idmap *idmap,
  * fs-writeback.c
  */
 extern long get_nr_dirty_inodes(void);
-void invalidate_inodes(struct super_block *sb);
 
 /*
  * dcache.c
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2c3b2f8a621f..ff016885646e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3270,6 +3270,7 @@ extern void discard_new_inode(struct inode *);
 extern unsigned int get_next_ino(void);
 extern void evict_inodes(struct super_block *sb);
 void dump_mapping(const struct address_space *);
+extern void invalidate_inodes(struct super_block *sb);
 
 /*
  * Userspace may rely on the inode number being non-zero. For example, glibc

