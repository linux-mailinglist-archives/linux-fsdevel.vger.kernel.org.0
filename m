Return-Path: <linux-fsdevel+bounces-56175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4DEB14324
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5588D163B86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4589B28150A;
	Mon, 28 Jul 2025 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0u6Vufw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE87D27FB2E
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734703; cv=none; b=g2TSxgKCJpa0WuZNY3ECAQdqm8tK9XtrT83zqCMrF9b0XnV2Ry33wsTZyzstT0EP/JwAxESst+GdJBHUXSHXaHiS5L/0FMkGlnp0fLIPX5D/hBMxIOkeq+NZv3WnlvPGYiH1ugRWh+biJKTnA7gM8Qs6D5hmIq1zbvrxhl1v4rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734703; c=relaxed/simple;
	bh=g2kUFE2cbPGJe3S5Il4ER1RFhvk8KicxvvkVs0nPlcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4SYNx7NsGEUWbfdMafoYw/9u1HlIQqlMuEQGe3O4kYgn14LXL0GJZiGolFtVai546aeZIUON4nnhzZ+UBN/lZOcbMBtZ2FhviCdj7pLbO+O71DACdSAMhIuCgg07lQ+FNvzT0NisYuDCPtTTnN6JZ9w7SdYMBvPBCy9b01P+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0u6Vufw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZXoaxTDjRg/a/jwd5LEvOIoGKVQe52rJ1WByCglYh4=;
	b=C0u6VufwI2wPMJDb7nv/gm/aSIhwB4IDFSCMsgko5rR2QOmEUkIuLUc1a0IgE6ML19j1Oj
	tDffrdXPtZhlhrDCHe7lH0mBlMANvHS6pXf+P8Q4L2aqcGjdYf18WXnS0jL1HO4hXeWMlC
	9SX4pG6KqROPTOmyZFU727Sg2AYeraI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-j4rfd3cSMxeotmjAFwl5ig-1; Mon, 28 Jul 2025 16:31:39 -0400
X-MC-Unique: j4rfd3cSMxeotmjAFwl5ig-1
X-Mimecast-MFC-AGG-ID: j4rfd3cSMxeotmjAFwl5ig_1753734698
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6153793df24so1665145a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734698; x=1754339498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZXoaxTDjRg/a/jwd5LEvOIoGKVQe52rJ1WByCglYh4=;
        b=Xvf9BpAH0XuynRhk1+s3Reku30eY3Ugt9wAiV6h+LLhqDeWM71vmbKVPcclGlCgx5i
         A/hvgU9hJE/jMjN7Y+BOMf68j1CsGW7LxjmPEed97aMNJ3f/Dv0uM+8yH3Y6FxNcBHSV
         hd1o7O3enwnp7HhjUPfyE5jti0Y9za9ziePYVrPvjypJaDD6LMXbSAtQV79TUknR6Qmt
         mcbfj2G6J1bzZR4jmB5QLm7iJziyXhq9XOSM2TDpONe4K/3DOA68yWM4RSZj8wlA0+2P
         Bi2JIrXzbkFFnwbq+XGO/j8p34ICaUmmInTk2/Bdeo9Cj2G/9czL0ef92zQ6ddhFusGK
         2aNw==
X-Forwarded-Encrypted: i=1; AJvYcCUeHFhNTmlKPg8r4z1yaHpe9032osS2Zny5PlT5Ak3ecDp4cSpqQKDDWKbApg1gGZ/vYoCP5svcltrkPmUd@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmPVwZiaYiHi8SiEsxH9cXCYcE10A0wbVDQIJT67xZaoGCdCp
	SOgXjRklh5mgOHSe6CqrsJUPSXIfbjj/P81heDcZGu8Hn5phratA2FseRK10q/vIIzHGBuyMrU/
	YrH2wrOQAuuOcd4AE95VzSaO97oWhInBkBoo32gl2W2dyQ6uZkbV7+FEvF8BX64G9aw==
X-Gm-Gg: ASbGncvopNkBofI6OQh6FJELAFfV/vYKC/vGZf6b3NcuS9ewHULxzA/13TpbEmHuKNN
	HReJSxoeSrYkBKGsHLBe2QV5krm9tPH8FqYXZ6Kp/qQG/FEU79nl9YakvdHas44FDnmarPaeFNA
	c5KAahf/OW6a/cZSntFeh2x5V9KWSSK/YDzRqxvqZ/PyQU6lYmGaFmObVk17Wpvw0ncIB57ScxI
	yB2opisKkI/ONh5XIF6CihXEyrfQCZlzFkvVZJ8cm9uMSiS+fYzjhWE9cm5jnpZ00LmIsXQgoEt
	pWsJl+DjQuagXW52M60TGL7j1PpTDJIxpGMkEvP+cjv+gQ==
X-Received: by 2002:a05:6402:42c8:b0:615:4244:8c46 with SMTP id 4fb4d7f45d1cf-61542449868mr4455392a12.28.1753734698102;
        Mon, 28 Jul 2025 13:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIdGe4USzRIJTcsB+22wY5Dcu9XUWv6bWITa5Ihoc1sZZDfH607srcXhtVlDoAzyIrl4/0yg==
X-Received: by 2002:a05:6402:42c8:b0:615:4244:8c46 with SMTP id 4fb4d7f45d1cf-61542449868mr4455370a12.28.1753734697628;
        Mon, 28 Jul 2025 13:31:37 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:37 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:21 +0200
Subject: [PATCH RFC 17/29] xfs: initialize fs-verity on file open and
 cleanup on inode destruction
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-17-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=mGQiXL42Qj1BBahuGJXihH0ERFZ0YR469i+3LjqufUY=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSdgvCnmWomy0fqqu4U75hki2q+/sPI6kbXqlV
 /vztqvWlBcdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJrLqNsN/t8ToqqUJzxzK
 hE76r8iQVn6hquGwuqmuoDJO6fr6iJdLGRm+fGe7bVoxZcrD7vnc9Q/bV5/6mJV04O/SE7PVO65
 cn1PLBgBfQ0re
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  | 8 ++++++++
 fs/xfs/xfs_super.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 0b41b18debf3..da13162925d9 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -34,6 +34,7 @@
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1555,11 +1556,18 @@ xfs_file_open(
 	struct inode	*inode,
 	struct file	*file)
 {
+	int		error;
+
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
 	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+
+	error = fsverity_file_open(inode, file);
+	if (error)
+		return error;
+
 	return generic_file_open(inode, file);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index bb0a82635a77..7b1ace75955c 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -53,6 +53,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -699,6 +700,7 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
 

-- 
2.50.0


