Return-Path: <linux-fsdevel+bounces-73250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDCED13633
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8357730464C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6AD2D94A1;
	Mon, 12 Jan 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ip1baVrB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVqzt6qd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F12D4B68
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229454; cv=none; b=GKsUbxdbVg55klNw9lPkocREamFT4cRIk9aBOQFibiq1Er3ydc/1BhTVUpI7U8m+Ru9eLQuoNkQvSv3zthrnesybtITfYAcZtLWTALRlMxxGsbqwnDHQsDeHKX7yPSOSWW3XUcmXmO7MUOA75xMUe4B8JigfmSAqu8uBZY8l1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229454; c=relaxed/simple;
	bh=zUe+u05Ji70egxnDu2vRJL+W32xXvgDxlQ06l0qTwQ0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0pd1vBGpiLY/DXdxxX8t38PqHqVvJT5kqt1gfr0PimSqYhjZ/poeTZteMJVPOrsiOkzK2d6mTpAk0oahYi6vD4s7ojg6j+fcS5XNlB6zZ5SBE5VKzX9bp22latb9gZOkcYhlSqGAHfr4ccDYhLILq/XFl8uVdNORqdiGakik7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ip1baVrB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVqzt6qd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFITs97XcCADGQCmQX9tBpBI7bVy5Dx+q3IqNAqa92M=;
	b=ip1baVrB71ZEa8AekAXmarMC1JAWN88/fi7FbmnUlpt8e2udG3jBUFFFN4JpNRAPxu30tU
	RHTn9Vbg/ASnXR3YVf3MTlA+bCl8efctSs9FL/qSdThT6maB8I1JPN9+T8CFFmaIYXFt5J
	EML1lOL26nof1s9xeTF7zLsdCGx+pZI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-MtwbsPCMPa-w3uKr-hY8Jg-1; Mon, 12 Jan 2026 09:50:50 -0500
X-MC-Unique: MtwbsPCMPa-w3uKr-hY8Jg-1
X-Mimecast-MFC-AGG-ID: MtwbsPCMPa-w3uKr-hY8Jg_1768229449
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64d18dbff2aso7952496a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229449; x=1768834249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFITs97XcCADGQCmQX9tBpBI7bVy5Dx+q3IqNAqa92M=;
        b=BVqzt6qdq1VQwNMv0UHYa++JLtR+bLFVpFpL4s6p5jHjCLqT9kunGqRyRaXpKKrXQl
         /pPSH6KfnWjeF0q4K41NrvxUSw9r9KC8xxH1D5fqBfYMlTJFegWxCvGkC5drQK+C4aav
         y+97nNf5uT7HlrA6yZpEo45t2oV0DF5NtOBeAnB1jVVdK2h8qnlLcgn0U6ft+DNcE33H
         Em92isrRKc+83/KQ4dj8F7QE/FKdpkwyqwQxZBEP76FNO8VqTOAk9KS+/eb7aHZoM3sf
         7/cVSLNfXKOEGbebyKSlqhKEDc0WIwX2kPyCYcT0Vxg/TQ3vG+9hs14XtGl7LwuQkRSv
         HA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229449; x=1768834249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFITs97XcCADGQCmQX9tBpBI7bVy5Dx+q3IqNAqa92M=;
        b=rc7p4F7gE5qLj4WqaFMt8xwtazXPhABYQ2HqxsHutXarkV/fdisiWowkN7BPAdzI38
         v+5dkR1+UcNDdyhUw11NIgK6/7rTmpiqEMx8JTBFBnlkcXz+XDLzRuIJZoOcPOpokYGj
         sQ8SFKud7aAXHSZrId0pErQBnoMaJEIM2uFOwTsG8g6Yok3FJAVwd7qWcpRrwjYrlJi0
         TcFdE40mCgj+C0UHOD5rEZ5l4j7kWSNzp9/ZrWxBrlHSCcvPf33OdoLr8E95B7X2wfZB
         z+zraCxmY5Ro5WJ2eNTCfvY/Wb8k+qM85IXXdhIvEhRh3xr7uPD0iq/fKNkrw0+7vnj2
         HbQA==
X-Forwarded-Encrypted: i=1; AJvYcCX4LlxEh7Xoi9DkYrTspSMomSvwWkURShzBUzkG0CEj8w01bbOy3BqIK687yjoSPi6tK0veHE3xYGbaFxqr@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkasWggmwc44EEfUcxnOq9nRp9Ajxs+XmKqOkpZyeonb8xYK2
	qqEiMP/K9CcG2zFHhnpGbB+XheFhL3wgqF8x7/ThmLemAo1aXnew11tG9E1T/AM/I8Bczbqj9WE
	+D3Rq9ME4mRcnchqa82Xcsg40YRj4fE/ihrzmUN4qi/ibd7a/xfULYPWS5omD8BLKIg==
X-Gm-Gg: AY/fxX7A50/QYaTkHlnjJf5FSOFebxbFqG/KxFRD7s66YqarIP7pj0XPVH9Mft4mNCy
	uRCJgGtAmQmxSf45L4qomUSTHjWnt/F2ckj38WWwWDoYg9QxcFVQO2QM/IHxLVj9lCyiFplh5uZ
	Z8ZtHRfHZOKHE7YfKqTeDax8Qw/ApKw+dTYYHo6+tXsP8S7DQvPzl7iB6bRxK2Uc4UpBnxf/tM+
	1aXufxbtW2EFicMg6sZAS7VOmhL6WC4UuTk3GAL6/aratuQf4xsqdBzUFfY/W3UJiDwxh0M5H3m
	FnSiaptCxIGIrv7pSmEbphbWPujd8nQ7zCF3BeCtGiVv0zks34OwINAWmmv3Y+WHcKImFv3RgDo
	=
X-Received: by 2002:a05:6402:4492:b0:650:8563:fdbe with SMTP id 4fb4d7f45d1cf-65097e5af32mr15189048a12.23.1768229448761;
        Mon, 12 Jan 2026 06:50:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFm1BBLk3K8B25WecjEZzInMYPlViDE/uDnc7pMiIiyegJFjXo23wj95dH4bSVilJP1fmQnQ==
X-Received: by 2002:a05:6402:4492:b0:650:8563:fdbe with SMTP id 4fb4d7f45d1cf-65097e5af32mr15189021a12.23.1768229448364;
        Mon, 12 Jan 2026 06:50:48 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4ed5sm17536558a12.11.2026.01.12.06.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:50:47 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:50:47 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 8/22] xfs: initialize fs-verity on file open and cleanup
 on inode destruction
Message-ID: <5rckitbnj3eqpeeiaw7u2jfvyk72lfkylg2r7mdtxmlu3qp7dx@t3pn5oelmkxe>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  | 8 ++++++++
 fs/xfs/xfs_super.c | 2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 7874cf745a..0c234ab449 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -36,6 +36,7 @@
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1604,11 +1605,18 @@
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
index bc71aa9dce..10c6fc8d20 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -53,6 +53,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -709,6 +710,7 @@
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
 

-- 
- Andrey


