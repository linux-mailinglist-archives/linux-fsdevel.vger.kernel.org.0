Return-Path: <linux-fsdevel+bounces-13539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CCF870A5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079181C21D82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794FD7BB14;
	Mon,  4 Mar 2024 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7HQ5JFu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FCC7D081
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579552; cv=none; b=lQyxKUi6o+xPt/y+5a551FbDODM4Wm1QO+nD8yYXk8FzxuoTEtcY+8NRkpxMNzBXmR62cisnBhOdLHdKMQOmP7O0o04TSLpk/t+qV5MhFe4bCuAqbAR2IVT0uoEe5Wkrvxx1fXuh9T++HukRs7BAILU1t3ivjxnjse8PIYRT6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579552; c=relaxed/simple;
	bh=ERtzRFPdr2VH0zZPj8RxD5cx+rKCLFPSdsv147J2+aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLZ+o0OhHSbbcajKgm7nGT/M7jXrGNw+SjuthgHFfQM6V9jL+8u9ALMymICDn9QiZ/t0GPRQ2QVI8/QTjpYzQm+LKJIM6AhVI/HCEAlQbKm0EYue8FFoSdSoSYcSqjoUuaaeFI6uiRQQbpKASsQHkcH9Vy8ZceQylqOUBcpYJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7HQ5JFu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krPybzmQrqI1Dp7C5c3ykOUeWIJQjCMl72CpYY79DB8=;
	b=G7HQ5JFuKYrWivOqPYBk4FM3Dbm5D5jTRfsLkXQtGlc0Jj1ZGiVakh+QlRG1LEr7Kh1fbp
	uQ4tpmqVWvVV+/r0d2TUCTgNmPD5HiHpz9ypvVBdI6oxM/9CeoodTr5Dd4lOrDEQ5cZBxS
	1e8+jjTprQEY0RhDDhsLBJ8vhVfcSPE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-rp9OXLJnPbaLLXSXfgJo6Q-1; Mon, 04 Mar 2024 14:12:28 -0500
X-MC-Unique: rp9OXLJnPbaLLXSXfgJo6Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a45190fd2fcso103236166b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579547; x=1710184347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krPybzmQrqI1Dp7C5c3ykOUeWIJQjCMl72CpYY79DB8=;
        b=XcWIxb1onELRzmwzvZODYE66wgoQlWyatAFp5LBXXSenRc6uFe2c12L/6gwZVngVl/
         jJXc4WNX4nmmqvPA7J5oOIbGe3z08qBOosjHaJEy3Gs+sLeBGhKpD8QSugY/cKhIY66d
         +d1ilBe+kw+qZXeBHXL8LDOdONpYxGoC7ypa1qlI2l89h0+PQXCngu5e9aBvX5pAWBOw
         /gg08cMtIReFnWeMm46rkK8waa6GMqRt0Rd240ucFlZLpTmUd5nOxJcPqHxw/9V9KAu7
         DDkVbvpH4XStmdsDw7c+VZgvX5wxc1ritvAXXwgWhxNVniyvY94me34nMeJAk6tX+fbG
         DDcg==
X-Forwarded-Encrypted: i=1; AJvYcCXZLFdXN8MsyK8gu0aaLAs89ZA03Ds1GfJI3tix0jrXm4BDPW+7LPS4AvtIC1NlK4d6Klb4EcE+SuoU02LzHLPkY1de2fkGvJb0UyefVQ==
X-Gm-Message-State: AOJu0Ywo6zWkE8PgB2jTNhd6rkpYSzWaULyYM7OavqOmykJl4DV0lD5y
	CX9zuB+fRM0DN+WX+wE6PjQB3s7KdawgpuWt+AK65rv3xNDw/Dd1DRb7oUC7cRgRR5dGVPb7Kf3
	5mgetktv4hRi/MXwIyBD1dt+OHE+6QX5tsa1UVHL7MT6si1cMecYJ45wOpb7oQA==
X-Received: by 2002:a17:906:ce26:b0:a44:415d:fa3a with SMTP id sd6-20020a170906ce2600b00a44415dfa3amr7056578ejb.40.1709579547468;
        Mon, 04 Mar 2024 11:12:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcAC+lTxlNi6h7UWuTBi4wKvqOw70WGSF/a8p/9kdmtD66jYKFg2m1eW60qx48UVYaEc8wIg==
X-Received: by 2002:a17:906:ce26:b0:a44:415d:fa3a with SMTP id sd6-20020a170906ce2600b00a44415dfa3amr7056572ejb.40.1709579547287;
        Mon, 04 Mar 2024 11:12:27 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:27 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 18/24] xfs: initialize fs-verity on file open and cleanup on inode destruction
Date: Mon,  4 Mar 2024 20:10:41 +0100
Message-ID: <20240304191046.157464-20-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_file.c  | 8 ++++++++
 fs/xfs/xfs_super.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 632653e00906..17404c2e7e31 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -31,6 +31,7 @@
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1228,10 +1229,17 @@ xfs_file_open(
 	struct inode	*inode,
 	struct file	*file)
 {
+	int		error = 0;
+
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC |
 			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
+
+	error = fsverity_file_open(inode, file);
+	if (error)
+		return error;
+
 	return generic_file_open(inode, file);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index afa32bd5e282..9f9c35cff9bf 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -49,6 +49,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -663,6 +664,7 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
 
-- 
2.42.0


