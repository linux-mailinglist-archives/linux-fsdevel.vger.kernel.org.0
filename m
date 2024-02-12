Return-Path: <linux-fsdevel+bounces-11160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ED0851A7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649521C21CD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D473FE2C;
	Mon, 12 Feb 2024 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g102msEZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66E3FB2F
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757222; cv=none; b=VBpW7/Hdq/8WdGhfT77S/+bZFnj1qiMUE1H8DBhQvTmT648M14MA/w1ogdDk0MqY2WvbTSP0ikxR4dS0bKIeXlqXdGYwvXCIlqzXTbiwmNDUQdud7GHypdiCL66Swa7RryMMZraENsACDLPjwDBRvk2BPur6o1+4HnFNljohumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757222; c=relaxed/simple;
	bh=uRpqcFHztW6mv8ys9x1B06hDBwaQZHF8LlWlh4KeXNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7ooPe5GcOjSyQD/d4hXMdrSjW1Hmi77cZMAgbiD9Qltu1RJZBNt9oOOaNzkbuqmvbAx0i4mWSvAGjIR162ID52oJJAOGhdJInw6Ilnt0chSdEiTCE3S/NcQ+yd37fwNPBRm9ep6SjxS3U7L9PKFtT1PO11QBnW4WZAfbK/4hBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g102msEZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4IPa0qcdOfoZGhIk7o1SuO7zkizJ6265PJwpzaMwSg=;
	b=g102msEZB4hRAdgJUPM5KNYeyuJMPKnJCkywbU54e0GjXyDzK56OUGHfH+IsmxTPZP9d/f
	AA8kL0Q6B+ngOG3NMHtHnWFhEAu3eGSELDm7h0nggF6amn4UwMq1xya13MPLLY1vzxGza4
	1NvXqWDIyd+Lp0MJJ87sCNofQFU7L7g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-eiKsXQR-PPmO0WFBF76Efg-1; Mon, 12 Feb 2024 12:00:18 -0500
X-MC-Unique: eiKsXQR-PPmO0WFBF76Efg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-55fc2d46d14so1414675a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:00:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757217; x=1708362017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4IPa0qcdOfoZGhIk7o1SuO7zkizJ6265PJwpzaMwSg=;
        b=ekUyKrQRsx+4EmGi/P8ApH89+cWJ8g04xJdngd4jcLS1hd+dxtBXZhJIkU22vzqcRN
         z2qgF4bQG2l9noU1Quy7ahlNFFgg56DGYQXQ+zX7yf2aTlzMre/4rirjKI1wQCf6eaY/
         quuNFdxcfEKTPdgeYrQKWJ2l2E+VWFe5FdkyLdOQuclwlkMiYvADK9sovBD16M6BfMSL
         Rt0j+9j3a/XEI2clzWnDNKZJdSsVxs41XOh6Vbn0NizhdpWBKwN6kZx4p0W/3GbDkCkN
         /0TUAH3Y8u5/ThvI9NBK2rwQVmRXAEv8Rtz+wtoIpLh8bboLZ6yXoNL9NxJFznxiTD4O
         Bfqw==
X-Forwarded-Encrypted: i=1; AJvYcCVKRy64St5kYhe/kdOJqvnAhWw7o3LRiA8cdhoU4GZx8v/fDjRffsd7HyEtJ0xy3gbDG4NCwPg1M4XLJSx62JPrciOmPdfX8neCZpbCXw==
X-Gm-Message-State: AOJu0YyEOJz2b4NFJO3q3mz+uKi9V1L4cIdCfGHAvrGS7PTHQlFxuEXS
	oJJ368u1M/3ERvXL9SB2IBX/zHi09N7+nCVkOqkG1h3nZ5tcdZ8NS8fAf8Z2+HGjF9H2hSdhhGR
	ed2G9XpIQf6dCE9NiyN5RTOFNGT0BaMewgwqBx38ANgvHSyFvtTme+YVsBqGSd8JuSXHlsg==
X-Received: by 2002:aa7:c38d:0:b0:561:dd88:cffc with SMTP id k13-20020aa7c38d000000b00561dd88cffcmr465750edq.28.1707757217468;
        Mon, 12 Feb 2024 09:00:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHksA5ai7JOoS0uklOVKI1iGk/wOmBYywj8HWtXzARiX88G09MpjFmNbBH4phxpiPQJH/VdNw==
X-Received: by 2002:aa7:c38d:0:b0:561:dd88:cffc with SMTP id k13-20020aa7c38d000000b00561dd88cffcmr465738edq.28.1707757217252;
        Mon, 12 Feb 2024 09:00:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXR1m0bOpBoqPXPgXXYaM9xtNMBrhn4WE1Pg/SJk4bnMQdTF9h8ffsK3KWu15iaJi6Z23nltfiz5dIXnKMptfo4UjJ0x/eI7CWd4H2jF97ZLwCYDKHPNU2p2YlMAanXkf+nNaNF0xypLv5AaDh61uecKausA88SdVC6PnzrvLFKxQbUkiSyZ3hdYGSeHT4kr6p3yDrqqsiA5JLSxLyJaGGrWGufxilwbyNg
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.09.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:00:16 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 19/25] xfs: initialize fs-verity on file open and cleanup on inode destruction
Date: Mon, 12 Feb 2024 17:58:16 +0100
Message-Id: <20240212165821.1901300-20-aalbersh@redhat.com>
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

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_file.c  | 8 ++++++++
 fs/xfs/xfs_super.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e33e5e13b95f..ed36cd088926 100644
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
index b2b6c1f24c42..4737101edab9 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -48,6 +48,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -672,6 +673,7 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
 
-- 
2.42.0


