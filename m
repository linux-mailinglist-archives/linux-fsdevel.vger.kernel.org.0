Return-Path: <linux-fsdevel+bounces-61585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA20FB58A04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A83D17A0FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA4919E99F;
	Tue, 16 Sep 2025 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neTarO3U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB783A1D2
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983698; cv=none; b=tyVwAuzpVfuP8x21AVlOZaf7gPIbDRzgkBYPElmtOuNjB24s8tjAAX6QLd93mHSkGEOO8bGUQFwmJ8+YgE7r5eEvWjGwuOKlESm8asVk6mvZnbfildVtPiXNGpsS3PEl9sKTx+kf9lRAEywjG8ar2W0zM+ChVJFEDpBQW0BbX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983698; c=relaxed/simple;
	bh=MQiKCL6n2IZ0wt9Hncma1xCZJnN2bEhk2gepEpcHwyM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHmifWMXsrQ0LqdrIkaZeYSsdGY+6CTb9SZYaFMiUECufDkleL6lNwqGDdUaTGeag2PDTD8K/ZORuhf2AQC+jvpRPGREVLtm1wRtcHp4BPk3g5UDsoHFwvq1VSbo4dRUy83ZuOzQucGUXPhOx9WCpX9zPMPYN651cMxjTqoKXbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neTarO3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344F9C4CEF1;
	Tue, 16 Sep 2025 00:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983698;
	bh=MQiKCL6n2IZ0wt9Hncma1xCZJnN2bEhk2gepEpcHwyM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=neTarO3UlIA/QA/JFla4ixe4G91JjZ1WEtTJwyb48w8atrU399Ib7q3lBRzXLKIVD
	 R5HNuFjzy+K0G/f+f/Lm/uE/uMnR3nEblJB6GFWhvhVEI1opedVCBkk4RL2mx1BaML
	 DjVBAQIqBvlgigXyEixxd+6UNnrKZi9/wnkeqgWkqr+GuWDVHMLdJgjTOZGRxjy4Iz
	 uVFpB5wdWNpZByvz/zqp1s7fUuHQvYe1aLcq3+xQsszRbczWTO+faLONLIYZ4et9zz
	 5Kw20mxM0RsxKmMW19suu7ym7qo8amIwg2U/1h5GVdx3xJaE0ejidIwLxUiYWByhtk
	 Ri8RlX6qNlmVg==
Date: Mon, 15 Sep 2025 17:48:17 -0700
Subject: [PATCH 2/3] libfuse: add upper-level iomap cache management
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155548.387947.10031903552737489168.stgit@frogsfrogsfrogs>
In-Reply-To: <175798155502.387947.1593770316300327637.stgit@frogsfrogsfrogs>
References: <175798155502.387947.1593770316300327637.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make it so that upper-level fuse servers can use the iomap cache too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h         |   31 +++++++++++++++++++++++++++++++
 lib/fuse.c             |   30 ++++++++++++++++++++++++++++++
 lib/fuse_versionscript |    2 ++
 3 files changed, 63 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 0b81a1259c4f09..baf7a2e90af5e7 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1455,6 +1455,37 @@ bool fuse_fs_can_enable_iomap(const struct stat *statbuf);
  */
 bool fuse_fs_can_enable_iomapx(const struct statx *statxbuf);
 
+/*
+ * Upsert some file mapping information into the kernel.  This is necessary
+ * for filesystems that require coordination of mapping state changes between
+ * buffered writes and writeback, and desirable for better performance
+ * elsewhere.
+ *
+ * @param nodeid the inode number
+ * @param attr_ino inode number as told by fuse_attr::ino
+ * @param read mapping information for file reads
+ * @param write mapping information for file writes
+ * @return zero for success, -errno for failure
+ */
+int fuse_fs_iomap_upsert(uint64_t nodeid, uint64_t attr_ino,
+			 const struct fuse_file_iomap *read,
+			 const struct fuse_file_iomap *write);
+
+/**
+ * Invalidate some file mapping information in the kernel.
+ *
+ * @param nodeid the inode number
+ * @param attr_ino inode number as told by fuse_attr::ino
+ * @param read_off start of the range of read mappings to invalidate
+ * @param read_len length of the range of read mappings to invalidate
+ * @param write_off start of the range of write mappings to invalidate
+ * @param write_len length of the range of write mappings to invalidate
+ * @return zero for success, -errno for failure
+ */
+int fuse_fs_iomap_inval(uint64_t nodeid, uint64_t attr_ino, loff_t read_off,
+			uint64_t read_len, loff_t write_off,
+			uint64_t write_len);
+
 int fuse_notify_poll(struct fuse_pollhandle *ph);
 
 /**
diff --git a/lib/fuse.c b/lib/fuse.c
index ac0206f6ed4544..372363f0089284 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2973,6 +2973,36 @@ static int fuse_fs_syncfs(struct fuse_fs *fs, const char *path)
 	return fs->op.syncfs(path);
 }
 
+int fuse_fs_iomap_upsert(uint64_t nodeid, uint64_t attr_ino,
+			 const struct fuse_file_iomap *read,
+			 const struct fuse_file_iomap *write)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	return fuse_lowlevel_notify_iomap_upsert(se, nodeid, attr_ino,
+						 read, write);
+}
+
+int fuse_fs_iomap_inval(uint64_t nodeid, uint64_t attr_ino, loff_t read_off,
+			uint64_t read_len, loff_t write_off,
+			uint64_t write_len)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+	struct fuse_iomap_inval read = {
+		.offset = read_off,
+		.length = read_len,
+	};
+	struct fuse_iomap_inval write = {
+		.offset = write_off,
+		.length = write_len,
+	};
+
+	return fuse_lowlevel_notify_iomap_inval(se, nodeid, attr_ino, &read,
+						&write);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 48918d94d822e0..db95fc6e7b1b41 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -238,6 +238,8 @@ FUSE_3.99 {
 		fuse_fs_iomap_device_invalidate;
 		fuse_lowlevel_notify_iomap_upsert;
 		fuse_lowlevel_notify_iomap_inval;
+		fuse_fs_iomap_upsert;
+		fuse_fs_iomap_inval;
 } FUSE_3.18;
 
 # Local Variables:


