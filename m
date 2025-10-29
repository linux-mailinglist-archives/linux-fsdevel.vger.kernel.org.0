Return-Path: <linux-fsdevel+bounces-66063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DE9C17B6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD39403AB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38162D73BC;
	Wed, 29 Oct 2025 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUJJkve6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6BD1386C9;
	Wed, 29 Oct 2025 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699653; cv=none; b=l6V0sz+del3S033IOrC4JdaQ3JMkopPFsWaIQXlvvJkHNzuNGq+z/Id5CK63bj17CA9r/rraurkyJd4nzo4g4XQwMzUaa86D+PdpLMPHN1C5VYyI4aw9I+bAgAfKZA6lL31uzzzfjroujcOYperYTtNXkJoYd/KWLWggjWNfebU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699653; c=relaxed/simple;
	bh=ViJ8jKsFOcXGBAO7/LkoutmLFvLVk6iU7btav/SwFBo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtKuAM++gnAor3iTM5s6iGYH4HEB0R537ygoqsWzpBrc6XzXlEv/vWF+go80Tw8MkjWqIBRG/4VuvBZqnxpHl+BaODIqAmOKZZ1d933IHlmoCgS9OynMv6zLEMkr+J61FJimXx1wugNGv7gnrZbmOgbVLpbSKW8bFdmt8PMhcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUJJkve6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA4DC4CEE7;
	Wed, 29 Oct 2025 01:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699652;
	bh=ViJ8jKsFOcXGBAO7/LkoutmLFvLVk6iU7btav/SwFBo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qUJJkve6fpgfdlYzdJbVVBXihhknUPVbEtPoH6ilKCydBMEST+ZaRFh9l/BumQG9Z
	 iTx1jeckAdTnXgMX/LslgNq7nwxwmtHV6GEtYTqf+4fEyMf6TH2/3MUYsdq+SOu73h
	 AyoxfUaA3J1rMhZzOtXNxJJodHsvcuC1vS9GFTuL4Jn6c9d6v+npAH8batiBtQCaKz
	 NIYH7SbmJDGoLXT5uQZBuIatYMTU9Q3lZTPoTL1TMUE+g/Y7uHoS8lo2KDpvcmaYqW
	 1NZzA2kKTLtv8glhE6rw7dKEmVcwTceF7jso88lUeg0TTl6NG7MumEFsBTlObF1RjB
	 toRmi8K2e3tVA==
Date: Tue, 28 Oct 2025 18:00:52 -0700
Subject: [PATCH 06/22] libfuse: add upper-level iomap add device function
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813641.1427432.4373717443417893238.stgit@frogsfrogsfrogs>
In-Reply-To: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
References: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make it so that the upper level fuse library can add iomap devices too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h         |   19 +++++++++++++++++++
 lib/fuse.c             |   16 ++++++++++++++++
 lib/fuse_versionscript |    2 ++
 3 files changed, 37 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 958034a539abe6..524b77b5d7bbd0 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1381,6 +1381,25 @@ void fuse_fs_init(struct fuse_fs *fs, struct fuse_conn_info *conn,
 		struct fuse_config *cfg);
 void fuse_fs_destroy(struct fuse_fs *fs);
 
+/**
+ * Attach an open file descriptor to a fuse+iomap mount.  Currently must be
+ * a block device.
+ *
+ * @param fd file descriptor of an open block device
+ * @param flags flags for the operation; none defined so far
+ * @return positive nonzero device id on success, or negative errno on failure
+ */
+int fuse_fs_iomap_device_add(int fd, unsigned int flags);
+
+/**
+ * Detach an open file from a fuse+iomap mount.  Must be a device id returned
+ * by fuse_lowlevel_iomap_device_add.
+ *
+ * @param device_id device index as returned by fuse_lowlevel_iomap_device_add
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_fs_iomap_device_remove(int device_id);
+
 int fuse_notify_poll(struct fuse_pollhandle *ph);
 
 /**
diff --git a/lib/fuse.c b/lib/fuse.c
index 6f86edb07ba5d2..0d9dfe83608e1e 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2836,6 +2836,22 @@ static int fuse_fs_iomap_end(struct fuse_fs *fs, const char *path,
 				written, iomap);
 }
 
+int fuse_fs_iomap_device_add(int fd, unsigned int flags)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	return fuse_lowlevel_iomap_device_add(se, fd, flags);
+}
+
+int fuse_fs_iomap_device_remove(int device_id)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	return fuse_lowlevel_iomap_device_remove(se, device_id);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index e796100c5ee414..c42fae5d4a3c50 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -224,6 +224,8 @@ FUSE_3.99 {
 		fuse_reply_iomap_begin;
 		fuse_lowlevel_iomap_device_add;
 		fuse_lowlevel_iomap_device_remove;
+		fuse_fs_iomap_device_add;
+		fuse_fs_iomap_device_remove;
 } FUSE_3.18;
 
 # Local Variables:


