Return-Path: <linux-fsdevel+bounces-58498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66AB2EA08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586A57BC960
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945111E32D3;
	Thu, 21 Aug 2025 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzudeDP+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003465FEE6
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738442; cv=none; b=oVYwQacN8NPLw5wct+2th/4a9TXsll/Ly/8QxsoG9ux+NWc6J+jqNutlmxRH7YQhjnS6z6ocSulRH4snRh0lS+jZMPK8nJFU32wl1VGHiARikKj8pwLwuCul5NIkLprIkwgDp+g7+EY2/VuOklZMVmjCsCFMTeW2sDuFmP2daZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738442; c=relaxed/simple;
	bh=p/qlYUnyYwo6ybjtI34KGB0M9WsosmkUOvtfqFuHR0Y=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEFdBYlSjz+kbB5NWsZZjM8hF5DeuHn3plhDRNnlOtU1+6xQ5es/qkrRThnQy+XSsfp5ZbaLkpjKDY65ei+bDhRPP0kMSVWuo+WZ+h9YMbWum6DW0bBs4HHTotzvqAvDK/FpHqpvf+ms42mvPlnE3mW6YnjkT2EMPoeFiPtMr3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzudeDP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B298C4CEE7;
	Thu, 21 Aug 2025 01:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738441;
	bh=p/qlYUnyYwo6ybjtI34KGB0M9WsosmkUOvtfqFuHR0Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QzudeDP+yHywVFTVo8gDWji9RPsldxGXvASTg8Vxaylg7EdWFg0tfjJB08rBFkPEu
	 8T8FHIrGyjmNjHF3mGsgs5LaKqKFPCrx4adK5NK5eFUWVjEIjtle+zgV2FSRbay0y4
	 ZBbpJ6AGhc5L50nhrtj//MyYfRP4R2DP5XeWM+yLaOLdPOkCMi/Rbv05nlBn1DFr93
	 I0PgM34UuDDMnuhlI7GHk0u5hXHxpGNxJN941kPzcOV0yqZEdsbse79hOCrEy2THDW
	 c67TTyi4jrnk6bxwAKpz1SIIS29gzo+UuXNxojaBn+HbBMiZfqykIKnwz3xXVMklKX
	 Il2TgR1QnhCkg==
Date: Wed, 20 Aug 2025 18:07:21 -0700
Subject: [PATCH 2/2] libfuse: add upper-level iomap cache management
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711907.19984.5913525640876473699.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711864.19984.18094782290166570853.stgit@frogsfrogsfrogs>
References: <175573711864.19984.18094782290166570853.stgit@frogsfrogsfrogs>
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
index e53e92786cea08..f8a57154017a2a 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1450,6 +1450,37 @@ bool fuse_fs_can_enable_iomap(const struct stat *statbuf);
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
index 1c813ec5a697a0..7b28f848116abb 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2963,6 +2963,36 @@ static int fuse_fs_iomap_config(struct fuse_fs *fs, uint64_t flags,
 	return fs->op.iomap_config(flags, maxbytes, cfg);
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
index a83966b9e48018..9a4baed32bc477 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -237,6 +237,8 @@ FUSE_3.99 {
 		fuse_fs_iomap_device_invalidate;
 		fuse_lowlevel_notify_iomap_upsert;
 		fuse_lowlevel_notify_iomap_inval;
+		fuse_fs_iomap_upsert;
+		fuse_fs_iomap_inval;
 } FUSE_3.18;
 
 # Local Variables:


