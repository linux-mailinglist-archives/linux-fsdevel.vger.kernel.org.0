Return-Path: <linux-fsdevel+bounces-49477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88823ABCE7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 07:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B8F1782F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 05:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DE625C711;
	Tue, 20 May 2025 05:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fmRsB82G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350BD25B1DA
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 05:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718176; cv=none; b=rp7f+P+M0PPlVk3O9YSccl/KSXwDxx+Tn3QgX06W/J9PTwLwq4HTfezLKM/ET2/nKxpTgU/2C2bI+HKAPXlaUS+CVrl8ynv8budum76KfvcXDgMia4FhKXGnpV+hp74bcW2DxkkbV/hP1XD0mbskPhM+lku3m86NeiHttOVrxGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718176; c=relaxed/simple;
	bh=01omtfy4X5jE3LXfqVXbJmQ6mr3USqlmpq4zi+mvzFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cn1aP+pGYaXL/1XXZ/v1hQhHgFDXieui18OMQ/PfIFL9urXTmlTKNzJH4DiJRUVI3H+yXByp3C8wTwiviyx/Pf4FBbo+KVgbmq4XCl/WOrhqSkEzu4SQVRi48b9U6moi2ReWAR4L4ufGr/YDWIqL/F2bWLEbH9HuTQi3H8HS/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fmRsB82G; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747718172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+htYYKrqbHWauEKNKRRY4W/ntjUCZcSdjtiG28wmDtA=;
	b=fmRsB82Ghtc8jo1wrGIJAilW8J61sUqjXEr6sxY8wCTQwC5s66I7kTyEDQFNlE3j/sKJGh
	ZszCInCgvKY6hUlYPAYTzhhGtnvtPV8FgCYCUi1+h8KeavkOVBZAvaW9PnsIeoRs31lB/W
	usxJmMSTtCdEDn4C/eK67q8K9DOJdDM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 3/6] fs: SB_CASEFOLD
Date: Tue, 20 May 2025 01:15:55 -0400
Message-ID: <20250520051600.1903319-4-kent.overstreet@linux.dev>
In-Reply-To: <20250520051600.1903319-1-kent.overstreet@linux.dev>
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a new flag indicating that a filesystem supports casefolding.

This is better than overlayfs's current method of checking for
sb->s_encoding, which isn't reliable - XFS implements ASCII casefolding,
so it won't be set there.

It's needed for overlayfs and the new dcache exclusion code to check
"should we allow union mounts on this filesystem even though the dcache
hash/compare ops are set? and do we need the new exclusion?".

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/libfs.c         | 1 +
 include/linux/fs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 6393d7c49ee6..d9f6ed6ec4ea 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1952,6 +1952,7 @@ void generic_set_sb_d_ops(struct super_block *sb)
 {
 #if IS_ENABLED(CONFIG_UNICODE)
 	if (sb->s_encoding) {
+		sb->s_flags |= SB_CASEFOLD;
 		sb->s_d_op = &generic_ci_dentry_ops;
 		return;
 	}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..ba942cd2fea1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1228,6 +1228,7 @@ extern int send_sigurg(struct file *file);
 #define SB_SYNCHRONOUS  BIT(4)	/* Writes are synced at once */
 #define SB_MANDLOCK     BIT(6)	/* Allow mandatory locks on an FS */
 #define SB_DIRSYNC      BIT(7)	/* Directory modifications are synchronous */
+#define SB_CASEFOLD	BIT(8)	/* Superblock supports casefolding */
 #define SB_NOATIME      BIT(10)	/* Do not update access times. */
 #define SB_NODIRATIME   BIT(11)	/* Do not update directory access times */
 #define SB_SILENT       BIT(15)
-- 
2.49.0


