Return-Path: <linux-fsdevel+bounces-78141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFVYN8PjnGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:33:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E9817F8FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0779330935FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D4C37F8CE;
	Mon, 23 Feb 2026 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIhsfGAw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346C41E9B1A;
	Mon, 23 Feb 2026 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889591; cv=none; b=XnPHnSjjJw2rYCl4aici+1Hbc0FyPcZ31VZ7JnN9Cw0QpE7S+4BN9bNZzrwM33HE53DMpKCWMQKc5rer20Rsj3iLrtsOV5jRJS6hE7jjb8Pj7IZS2hCGVTJVTmyeIf4olb9gYV5BtCQanmHZMfy7p35g5Nnvy3cIfR8HdTJhuzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889591; c=relaxed/simple;
	bh=AThK0N6kkln2KBeZLMnhy+bTNC9Oevf8i1d3T2yu8gU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMD9uUpWBBls3baKRDe3xpP61ok+cRrF1wa75i5YAIKZTLElNh2J3Qp2dAAWh7Q89qgssvpHvNfY24ArYyh7tNpn5LHSDZBk82saAxijlr7u95RnBIS6eydkuK4rfbBQMtWDGsV+TdaimjfoB2RXLdrEFhEJyjMGTde6m1+wLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIhsfGAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7A8C116C6;
	Mon, 23 Feb 2026 23:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889590;
	bh=AThK0N6kkln2KBeZLMnhy+bTNC9Oevf8i1d3T2yu8gU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UIhsfGAwagkDVckJrlL48jPeRG+ptFP3llAPBcfgSSwMxlMaHc+MUXPpXC6fmRu5X
	 6rRXc6c/R3Fi692XYV7DnbiBCSPmfTC/xBwGjvXn71G9JZgSYHzd5xpnIypXux3ISg
	 aAA+YAY9pi0Ok9sYUVT3ZekbiyIUET5ZuX90VNqP3bDNa+WF3vKlHnXJfTOaknG61n
	 OyrrJ+uIfN9OkRzCevi2xX2hyNU1rDEo5UY8v+R2soEj7RmOEAAZzPTkfoIFIopjqD
	 dSQGrYMEqLbUAagc1zLnBBQFnFsmJa9rAq/utNH9o3OGdaysVElGZZ5bm7AF/AKlfw
	 ivv7EJCjs1Ndg==
Date: Mon, 23 Feb 2026 15:33:10 -0800
Subject: [PATCH 2/5] libfuse: add upper-level iomap cache management
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188741054.3941876.15302900261653757299.stgit@frogsfrogsfrogs>
In-Reply-To: <177188741001.3941876.16023909374412521929.stgit@frogsfrogsfrogs>
References: <177188741001.3941876.16023909374412521929.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78141-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40E9817F8FA
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Make it so that upper-level fuse servers can use the iomap cache too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h         |   31 +++++++++++++++++++++++++++++++
 lib/fuse.c             |   30 ++++++++++++++++++++++++++++++
 lib/fuse_versionscript |    2 ++
 3 files changed, 63 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 2f73d42672acdd..e54aa1368bbb6b 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1488,6 +1488,37 @@ bool fuse_fs_can_enable_iomap(const struct stat *statbuf);
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
index 2969e0f332045f..0fb1bc106514a1 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -3012,6 +3012,36 @@ static int fuse_fs_shutdownfs(struct fuse_fs *fs, const char *path,
 	return fs->op.shutdownfs(path, flags);
 }
 
+int fuse_fs_iomap_upsert(uint64_t nodeid, uint64_t attr_ino,
+			 const struct fuse_file_iomap *read,
+			 const struct fuse_file_iomap *write)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	return fuse_lowlevel_iomap_upsert_mappings(se, nodeid, attr_ino, read,
+						   write);
+}
+
+int fuse_fs_iomap_inval(uint64_t nodeid, uint64_t attr_ino,
+			loff_t read_off, uint64_t read_len,
+			loff_t write_off, uint64_t write_len)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+	struct fuse_file_range read = {
+		.offset = read_off,
+		.length = read_len,
+	};
+	struct fuse_file_range write = {
+		.offset = write_off,
+		.length = write_len,
+	};
+
+	return fuse_lowlevel_iomap_inval_mappings(se, nodeid, attr_ino, &read,
+						  &write);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index ed388f8ebdb558..60d5e1be50deaa 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -252,6 +252,8 @@ FUSE_3.99 {
 		fuse_loopdev_setup;
 		fuse_lowlevel_iomap_upsert_mappings;
 		fuse_lowlevel_iomap_inval_mappings;
+		fuse_fs_iomap_upsert;
+		fuse_fs_iomap_inval;
 } FUSE_3.19;
 
 # Local Variables:


