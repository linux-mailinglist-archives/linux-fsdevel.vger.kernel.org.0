Return-Path: <linux-fsdevel+bounces-11154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE990851A6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A441C2247E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2873F9E5;
	Mon, 12 Feb 2024 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrYCtM4l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096F3F9D8
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757213; cv=none; b=XQZ8YgKSYCe/3ZrUNoUBiUcOj4t/ZahoeRnkfoF9Vz1sfjQzLWhi88ZmPJ8T8r600XHbqjcbZSxEa7cgMUzwX7k/sTWCfmkV//7BtjTgYlmKM5Kq1AgUVTJqthrax0ek+djVrQqiuSAAI2m+aN+KDSNTkUlBUMeFfzKTmsS73sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757213; c=relaxed/simple;
	bh=hmR+S5AY0nRCFeAH5bAxDWzUXlpVSiwnk6LNs/KSvyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQ20yY7+DHWL/7OHq4kLHsIr7qynqX3etkUcRNa3jHW3mFLydmy1LnRU6aSI7QRtDSpSWxut/G6wc6AopWfkyKGxg7f6NSU21NlVo3fdXWq1DXGK5fzXAdmaz6PzdcHyDatSEON+OGbvjSbNXWyIf5Haq7x9qAf0gvyERHjXBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrYCtM4l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmNNlJPhUFaXIob1BwyjdQcuVkHPCpZ8IwBssOpb1Po=;
	b=FrYCtM4lKcwYEvskBThWc3o7wv416CYKZ/KHzEDxd1+ZbJGOeWySPKvI0P25W0w35U/EeJ
	j+fOCLuFtQtRcDGbj0SnGQahlS4MC588ht1mJlIDzqFfd5k1b+4FHvlxfMqwnMWisKchby
	x99FbUTyqhHp8X4r+z1Y8PiefukKWCo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Fi652-xsOV-6SGKeX3FFZg-1; Mon, 12 Feb 2024 12:00:10 -0500
X-MC-Unique: Fi652-xsOV-6SGKeX3FFZg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-511535180b4so2586433e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757207; x=1708362007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmNNlJPhUFaXIob1BwyjdQcuVkHPCpZ8IwBssOpb1Po=;
        b=d+/eY1Fzhah4iu7oGrEzgdGlNNY4d69uGMUzTbEW1xvkDVSjLYxT6GS3weNdyu3ZTC
         mVB+/Mh2GY+WcpYTmuUcbbXdSTDo5FAUfrdki4Mm3KTJa6qBPor9MdLjNYgQvQSkJoAZ
         Jl3zCoNV1ARMRojy73mVyClThWmGX7uaUNlTTlss6HAp4pZmXR3otThO9ulONPSibmrr
         t2etqIqaJ/x3rVrDK1+LDLS+owvHh19b6SQrd5w0MaxrmQ1G4klM80xS+toJemt7nl/i
         DTsIxrmWV5OkuH8eR+5R2yKLqPFmN1z8pQAzvn0o0lkA5ZUWnjXV/pfba7biz32F+HhF
         RjVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc91NzEtEcQ3ElALn1Pni0rLCGZyhqMaiQZs+lWi7488OeAZmQfM5ZuvjQlfpWxJJb6vpIaKXynUQQX4Jl44Pjd48EX4BSTYaQ4uWaiA==
X-Gm-Message-State: AOJu0YwYfyIqkah95FZxydnjOVhAQ5nK1VR4QJi0bftKTF3mjupXv7oZ
	ofWo1sRI80x6G1Xg/mzKgxGGhuEvZsE6elGRcQk9fzV/siJXyFPjweGUtFn4kTV5tDkED29/f4E
	801y2ugwEfS6FNV50PSTLnwWMcyLl0d5L2fiyr6o7cfFUDsNxPpYsvrdzX1FKdw==
X-Received: by 2002:a05:651c:cf:b0:2d0:cf14:c190 with SMTP id 15-20020a05651c00cf00b002d0cf14c190mr4346982ljr.50.1707757207048;
        Mon, 12 Feb 2024 09:00:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyrud5wesvlVfmqztFwgue5DmNAK+DEbeWoNwqXMq50tEhnxQmKL0df6lGsY5NyQZ3shEGHw==
X-Received: by 2002:a05:651c:cf:b0:2d0:cf14:c190 with SMTP id 15-20020a05651c00cf00b002d0cf14c190mr4346969ljr.50.1707757206827;
        Mon, 12 Feb 2024 09:00:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJTI843yXTJ0emfk+epBVW2Le2UXrN5BlrF0Bou7qm6A8KahxOqRBQllpGfPzXBzdoSauxL9r6u49ZS1kbiVX9NrgbkiV5CEXwk+11AVv9RHcJQVy+m4zL/XoXw+eNTH+a9VZoNpjdQfgdrvg9ZwU+YsvEBTPGfZG1m0DDZnEv4O3CXY70pYIHx8DTC6DQG25L7O5IP5wjNRbPzB0pEw7YGYCtNqXRWlTA
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.09.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:00:06 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 13/25] xfs: introduce workqueue for post read IO work
Date: Mon, 12 Feb 2024 17:58:10 +0100
Message-Id: <20240212165821.1901300-14-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212165821.1901300-1-aalbersh@redhat.com>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As noted by Dave there are two problems with using fs-verity's
workqueue in XFS:

1. High priority workqueues are used within XFS to ensure that data
   IO completion cannot stall processing of journal IO completions.
   Hence using a WQ_HIGHPRI workqueue directly in the user data IO
   path is a potential filesystem livelock/deadlock vector.

2. The fsverity workqueue is global - it creates a cross-filesystem
   contention point.

This patch adds per-filesystem, per-cpu workqueue for fsverity
work.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_aops.c  | 15 +++++++++++++--
 fs/xfs/xfs_linux.h |  1 +
 fs/xfs/xfs_mount.h |  1 +
 fs/xfs/xfs_super.c |  9 +++++++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 7a6627404160..70e444c151b2 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -548,19 +548,30 @@ xfs_vm_bmap(
 	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
 }
 
+static inline struct workqueue_struct *
+xfs_fsverity_wq(
+	struct address_space	*mapping)
+{
+	if (fsverity_active(mapping->host))
+		return XFS_I(mapping->host)->i_mount->m_postread_workqueue;
+	return NULL;
+}
+
 STATIC int
 xfs_vm_read_folio(
 	struct file		*unused,
 	struct folio		*folio)
 {
-	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL);
+	return iomap_read_folio(folio, &xfs_read_iomap_ops,
+				xfs_fsverity_wq(folio->mapping));
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
+	iomap_readahead(rac, &xfs_read_iomap_ops,
+			xfs_fsverity_wq(rac->mapping));
 }
 
 static int
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index d7873e0360f0..9c76e025b5d8 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -64,6 +64,7 @@ typedef __u32			xfs_nlink_t;
 #include <linux/xattr.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/debugfs.h>
+#include <linux/fsverity.h>
 
 #include <asm/page.h>
 #include <asm/div64.h>
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 503fe3c7edbf..f64bf75f50d6 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -109,6 +109,7 @@ typedef struct xfs_mount {
 	struct xfs_mru_cache	*m_filestream;  /* per-mount filestream data */
 	struct workqueue_struct *m_buf_workqueue;
 	struct workqueue_struct	*m_unwritten_workqueue;
+	struct workqueue_struct	*m_postread_workqueue;
 	struct workqueue_struct	*m_reclaim_workqueue;
 	struct workqueue_struct	*m_sync_workqueue;
 	struct workqueue_struct *m_blockgc_wq;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5a2512d20bd0..b2b6c1f24c42 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -553,6 +553,12 @@ xfs_init_mount_workqueues(
 	if (!mp->m_unwritten_workqueue)
 		goto out_destroy_buf;
 
+	mp->m_postread_workqueue = alloc_workqueue("xfs-pread/%s",
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			0, mp->m_super->s_id);
+	if (!mp->m_postread_workqueue)
+		goto out_destroy_postread;
+
 	mp->m_reclaim_workqueue = alloc_workqueue("xfs-reclaim/%s",
 			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
 			0, mp->m_super->s_id);
@@ -586,6 +592,8 @@ xfs_init_mount_workqueues(
 	destroy_workqueue(mp->m_reclaim_workqueue);
 out_destroy_unwritten:
 	destroy_workqueue(mp->m_unwritten_workqueue);
+out_destroy_postread:
+	destroy_workqueue(mp->m_postread_workqueue);
 out_destroy_buf:
 	destroy_workqueue(mp->m_buf_workqueue);
 out:
@@ -601,6 +609,7 @@ xfs_destroy_mount_workqueues(
 	destroy_workqueue(mp->m_inodegc_wq);
 	destroy_workqueue(mp->m_reclaim_workqueue);
 	destroy_workqueue(mp->m_unwritten_workqueue);
+	destroy_workqueue(mp->m_postread_workqueue);
 	destroy_workqueue(mp->m_buf_workqueue);
 }
 
-- 
2.42.0


