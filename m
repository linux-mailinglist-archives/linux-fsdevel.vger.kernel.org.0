Return-Path: <linux-fsdevel+bounces-60423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443C9B46A8D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBC87BC8D1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491D52C0303;
	Sat,  6 Sep 2025 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lkntMUrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B088D2877DF
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149902; cv=none; b=K3wZKp2+Kkvnthne4AKVRENbxHrPRc1TMzqukOa7+qApp87g01GJDyaxpSZRv9Nk9LsVPbyEiMHdEBxtAGjiDeyfHBYSGQY+e8K4fxYY6lKVhT8ZmGW3UeDfHeG06wp0Mx9BXge00YCmJU0HIMR4fFOfAwJjhfheM0upWMhnIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149902; c=relaxed/simple;
	bh=xSns0h05vWo/G4FvA7I/4Rsp0XYXj5e5wR0/eYp6uT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUVnPxjQzjZZTgYC4x02JZS8nE52H4VybgFSjQyJ79aJplnHyhqK6w6Tzcbv1FkcfJ302ArYcfENoQ7rDOy30dLWp+dCun3Xfbi6lAE0d7O7JnH3g3hmcRu09CwSZ5zZyKM/wg5bIkc++QkNvZ3ZoxLDYX5W5fIZtrBC2gyaFDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lkntMUrB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qdxwPlOpNW4ZyDsrnwR0ZWhNI0VqYOES4rqPqQ4zF0U=; b=lkntMUrBb5hC0xMJsvLxFyqF4U
	nZ1pmTmM2DgzTeuvYVnL3apkeszgNBgHfRMWUrt35qTkY5mpAQutHgRnN5pZ4HPst5RgeqqiPzGDs
	tO5EXs6UO5vbTu6zUDD+AEWsJDBo+DfQnIO3OJ5T+dWF26ckpgHf7/ENYEUDF59BrS11f6BDQTwNq
	NhrAY5/QzuFYVBNX6B3lO0vs5fJ7UMmNCa6fTX4H2jYp4dFgWLfEN63BaRdmiLo8Ym4fBXieO8xFW
	HBt8g8yHuQctdBv6e565SXv9ZkaiHpKBjcUwBec36cDeuSeS0YKpUL4RXKvaiISIte1fq9t5niXKZ
	vjK0wbhA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxP-00000000OsS-0JAk;
	Sat, 06 Sep 2025 09:11:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 08/21] export_operations->open(): constify path argument
Date: Sat,  6 Sep 2025 10:11:24 +0100
Message-ID: <20250906091137.95554-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

for the method and its sole instance...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pidfs.c               | 2 +-
 include/linux/exportfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 108e7527f837..5af4fee288ea 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -847,7 +847,7 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
 	return 0;
 }
 
-static struct file *pidfs_export_open(struct path *path, unsigned int oflags)
+static struct file *pidfs_export_open(const struct path *path, unsigned int oflags)
 {
 	/*
 	 * Clear O_LARGEFILE as open_by_handle_at() forces it and raise
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index cfb0dd1ea49c..f43c83e0b8c5 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -270,7 +270,7 @@ struct export_operations {
 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
 			     int nr_iomaps, struct iattr *iattr);
 	int (*permission)(struct handle_to_path_ctx *ctx, unsigned int oflags);
-	struct file * (*open)(struct path *path, unsigned int oflags);
+	struct file * (*open)(const struct path *path, unsigned int oflags);
 #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
 #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
 #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */
-- 
2.47.2


