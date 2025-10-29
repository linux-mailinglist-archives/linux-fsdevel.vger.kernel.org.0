Return-Path: <linux-fsdevel+bounces-66074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16207C17BA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24AC3A6C9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A5D2D7DC2;
	Wed, 29 Oct 2025 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXas2W3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85CD21A449;
	Wed, 29 Oct 2025 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699824; cv=none; b=KyiN61l4DdS0QIX9uIZJ6LMghxqwvJzsfvwbt8a3v6VXBe4xBMXBAHWlvj57zG0kqnZWCRn3TInNNM1+6rxV6tK1vavz3m7jdAsuChzBU2ExcLP4zZ4MVKKJYbYJt6dDCxnl0AQOKflVmeQZlfV1wCQowzzGIZ9C88cV4llLr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699824; c=relaxed/simple;
	bh=32yJoKvxCcjLMpUMpOa95BgyY+A67U/Sk0qt9+PEuP8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTOr19ACQZPsPmEeT8+4n0W8U+/8ZOpvLXttuGwF8P8nSa6TOHZzvA52xiwYCWIhks1GR+TswKByajpDZGzr1yIpN0m5x1KKdcbabFm3htl3uFHkOvzEnIq6/ym7thRq2y+pRpfsO5gkTx23oSQ7GkQDWpyrOSdWQSe4DGuOLRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXas2W3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2721C4CEE7;
	Wed, 29 Oct 2025 01:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699824;
	bh=32yJoKvxCcjLMpUMpOa95BgyY+A67U/Sk0qt9+PEuP8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UXas2W3zHhHJ5bIVQwvUS7CVsRHZqmhn7OKGGcIVrMzT/MBkRx1+gbIYJ29CwVln3
	 e32hXe/t/c0YMcSzY8EgqZMKmEX39ABBCoeAJ+o4EtAzvbviAoJomkhKF3K7Pmc2dC
	 dMPvxUf8qxbX0fkMiZKCviiSEn7xJiTSouPanSTi9p7rIW9dgH72jn5g7bbWqB+WJ/
	 g35uVJWLxrh7fHgPPzo89iytNKC+Ljz0R0dIgPTUSN1ALeik7UtV1W3KTsTTLpENi9
	 6s6fjXfzJzgAtB8WKvNY75iIE4iHiyHPpgbtvYBmOqCqdtva45csxu9+CQt+2urN4i
	 az+ywQyZE/2zg==
Date: Tue, 28 Oct 2025 18:03:44 -0700
Subject: [PATCH 17/22] libfuse: add upper-level API to invalidate parts of an
 iomap block device
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813840.1427432.11872191487359495335.stgit@frogsfrogsfrogs>
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
index 1fec6371b7bc81..ed2bd3da212743 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2921,6 +2921,15 @@ int fuse_fs_iomap_device_remove(int device_id)
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


