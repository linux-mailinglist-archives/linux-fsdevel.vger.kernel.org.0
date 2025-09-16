Return-Path: <linux-fsdevel+bounces-61577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48340B589F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BDE87A4676
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F5518C03F;
	Tue, 16 Sep 2025 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0IdxQ31"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DC482EB
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983573; cv=none; b=kC+pabtkRV/9qoEpoKwyr09EalLtvEvWzHi0Rl6ZbSNnvE518T3hbnQ5g5xBiyibTCmDYiCDS5MjKIeLa1DHpR5KOVuAeLnnzK9HjW9YoZNNMNLki/81UPCM5v+tW4lZMqu/M9E/PS/lMfXT1QhPUm+ly95vXwRenF4MBJrnB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983573; c=relaxed/simple;
	bh=y839EwTFe2rJMd+dYdkDbebsCm4571+FQGrFJb10pm4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkEFtg+OX6VwnKL7BRC5/OEgtFI5beLowSHDrn5Slmdq+schhZj7LH8zko+Osg2lEEYwUiC1zHHeJd20F43MiOBHArdOy4g9mQYfO5+L2P4EVUL5fskLmNc9gAeRtXsYAzri7h46awH0xNLk3zG5Us81UPnQGF118lf8C16YsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0IdxQ31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFC2C4CEF1;
	Tue, 16 Sep 2025 00:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983573;
	bh=y839EwTFe2rJMd+dYdkDbebsCm4571+FQGrFJb10pm4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=f0IdxQ31G0BlOO7FtpxNAncukdx70UZz7KFG8qPMzTbxNXMLWU35xDP1OVLn16CjT
	 h2EQ6wqVcAtf8nZzy10AcziaLFcXO2eKMXz+u2pMy3fskPey93fuI2FLGEd2F3+atE
	 7lz/2tj414wcVTH6lLF9kevM284owROtZvommYWrUfSc8g1de3udIpERZ8F7O28DS0
	 Yg3AbIquzhmarDvteOqbxE/0UYw8iGCkqMWvCWqNKf9MzsETvTpwJy3ygFnLzJnxMP
	 LxtKtJwQrQRp4hOW0KTIV7rHEK2mV9kYH6ELkfTQHJyRW1UNuw/AEorSb/MyfPADeQ
	 MVfwxBPC3ZedQ==
Date: Mon, 15 Sep 2025 17:46:12 -0700
Subject: [PATCH 17/18] libfuse: add upper-level API to invalidate parts of an
 iomap block device
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154815.386924.6780194188520190652.stgit@frogsfrogsfrogs>
In-Reply-To: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
References: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Wire up the upper-level wrappers to
fuse_lowlevel_iomap_invalidate_device.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h         |   10 ++++++++++
 lib/fuse.c             |    9 +++++++++
 lib/fuse_versionscript |    1 +
 3 files changed, 20 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 74b86e8d27fb35..e53e92786cea08 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1422,6 +1422,16 @@ int fuse_fs_iomap_device_add(int fd, unsigned int flags);
  */
 int fuse_fs_iomap_device_remove(int device_id);
 
+/**
+ * Invalidate any pagecache for the given iomap (block) device.
+ *
+ * @param device_id device index as returned by fuse_lowlevel_iomap_device_add
+ * @param offset starting offset of the range to invalidate
+ * @param length length of the range to invalidate
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_fs_iomap_device_invalidate(int device_id, off_t offset, off_t length);
+
 /**
  * Decide if we can enable iomap mode for a particular file for an upper-level
  * fuse server.
diff --git a/lib/fuse.c b/lib/fuse.c
index 177c524eff736b..1c813ec5a697a0 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2917,6 +2917,15 @@ int fuse_fs_iomap_device_remove(int device_id)
 	return fuse_lowlevel_iomap_device_remove(se, device_id);
 }
 
+int fuse_fs_iomap_device_invalidate(int device_id, off_t offset, off_t length)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	return fuse_lowlevel_iomap_device_invalidate(se, device_id, offset,
+						     length);
+}
+
 static int fuse_fs_iomap_ioend(struct fuse_fs *fs, const char *path,
 			       uint64_t nodeid, uint64_t attr_ino, off_t pos,
 			       size_t written, uint32_t ioendflags, int error,
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index d268471ae5bd38..a275b53c6f9f1a 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -235,6 +235,7 @@ FUSE_3.99 {
 		fuse_lowlevel_discover_iomap;
 		fuse_reply_iomap_config;
 		fuse_lowlevel_iomap_device_invalidate;
+		fuse_fs_iomap_device_invalidate;
 } FUSE_3.18;
 
 # Local Variables:


