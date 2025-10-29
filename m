Return-Path: <linux-fsdevel+bounces-66092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A453C17C4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E8A1A2408C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EE82D8767;
	Wed, 29 Oct 2025 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJgBlTy0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F02D6630;
	Wed, 29 Oct 2025 01:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700106; cv=none; b=NRpwew8lpRcWiAwFoAusWTx61XGnDScJ2ZWTuou13NTPN/YJrHbS8faElxhUm67RIJ6cm/I1ncmVYLTrZudsnzgGxgYoRDKqQC0Lged8weuCVYO2hQDan7C506OQaqWK9VJmJ7orqM6l32zII3udNpKC7ZvjmLjtOtT2lXlZO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700106; c=relaxed/simple;
	bh=W0BSAq0kch4ETggpujxawJCbgCplZSSE9k0VO+TgaIk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vA8IfIP9tjLBhFtEg2vJ813fAmG2j19p3Z22CdgxdYor0vFi2DHVBomrzi7+s35m1GLuvfuA2sIz4T2TA/2hdRBVAUTtCOuxttjehEO9sjFMlQKoVH2YSxTbxiiC6/vY+Slps4pUktYPr3GdMthpcsvQZlTfMXYPK1UXBwZ9wiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJgBlTy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CBBC4CEE7;
	Wed, 29 Oct 2025 01:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700106;
	bh=W0BSAq0kch4ETggpujxawJCbgCplZSSE9k0VO+TgaIk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HJgBlTy0oV9SfhiIXsJ4Vq8TBjJWhfpL/ladUZK8UioxRUFd0UC3+RaeIl9vKYR2I
	 ugN/N7b53CiCliiEzL3jV4Z6+SZ3lLZLGPPNHBeBWguWVTdroub7YrZBr440FCCGDc
	 G72dwx8tzaW1ryFA6ZBGvxSgovoe1LXWNzSRmoCPHCgD5jBM2+WUF9ugeVgiTdYFps
	 7ab7Glc9GYFQiwgh+Hw/HOYTxECXVtq16GgOd1NLUFnqSKDk3CW2fTAHZa/or0CYRj
	 CvIGnIS5GwL8r6xn3xpkFfDu7J0OF/Qox5cF94qgJhyT9y+CJ4mTU42pRDbNyLO1Rs
	 QkfS8w9rhJjIQ==
Date: Tue, 28 Oct 2025 18:08:25 -0700
Subject: [PATCH 5/5] fuservicemount: create loop devices for regular files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814940.1428772.13665592936257476002.stgit@frogsfrogsfrogs>
In-Reply-To: <176169814833.1428772.4461258885999504499.stgit@frogsfrogsfrogs>
References: <176169814833.1428772.4461258885999504499.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If a fuse server asks fuservicemount to open a regular file, try to
create an auto-clear loop device so that the fuse server can use iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_service.h      |    6 ++++++
 include/fuse_service_priv.h |    3 ++-
 lib/fuse_service.c          |    5 ++++-
 util/mount_service.c        |   34 ++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 2 deletions(-)


diff --git a/include/fuse_service.h b/include/fuse_service.h
index 47080a75bc9ab6..906f36434d2243 100644
--- a/include/fuse_service.h
+++ b/include/fuse_service.h
@@ -95,6 +95,12 @@ int fuse_service_take_fusedev(struct fuse_service *sfp);
 int fuse_service_parse_cmdline_opts(struct fuse_args *args,
 				    struct fuse_cmdline_opts *opts);
 
+/**
+ * If the file opened is a regular file, try to create a loop device for it.
+ * If successful, the loop device is returned; if not, the regular file is.
+ */
+#define FUSE_SERVICE_REQUEST_FILE_TRYLOOP	(1U << 0)
+
 /**
  * Ask the mount.service helper to open a file on behalf of the fuse server.
  *
diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
index ce2e194ccf0be6..6fc7d59c363ea8 100644
--- a/include/fuse_service_priv.h
+++ b/include/fuse_service_priv.h
@@ -58,7 +58,8 @@ static inline size_t sizeof_fuse_service_requested_file(size_t pathlen)
 	return sizeof(struct fuse_service_requested_file) + pathlen + 1;
 }
 
-#define FUSE_SERVICE_OPEN_FLAGS		(0)
+#define FUSE_SERVICE_OPEN_TRYLOOP	(1U << 0)
+#define FUSE_SERVICE_OPEN_FLAGS		(FUSE_SERVICE_OPEN_TRYLOOP)
 
 struct fuse_service_open_command {
 	struct fuse_service_packet p;
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index 48633640c1c41b..af23ec06ac60a1 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -152,7 +152,7 @@ int fuse_service_receive_file(struct fuse_service *sf, const char *path,
 	return recv_requested_file(sf->sockfd, path, fdp);
 }
 
-#define FUSE_SERVICE_REQUEST_FILE_FLAGS	(0)
+#define FUSE_SERVICE_REQUEST_FILE_FLAGS	(FUSE_SERVICE_REQUEST_FILE_TRYLOOP)
 
 int fuse_service_request_file(struct fuse_service *sf, const char *path,
 			      int open_flags, mode_t create_mode,
@@ -177,6 +177,9 @@ int fuse_service_request_file(struct fuse_service *sf, const char *path,
 		return -1;
 	}
 
+	if (request_flags & FUSE_SERVICE_REQUEST_FILE_TRYLOOP)
+		rqflags |= FUSE_SERVICE_OPEN_TRYLOOP;
+
 	cmd = calloc(1, iov.iov_len);
 	if (!cmd) {
 		perror("fuse: alloc service file request");
diff --git a/util/mount_service.c b/util/mount_service.c
index e3410d524167a4..e62183800043e8 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -25,15 +25,20 @@
 #include <limits.h>
 #include <sys/stat.h>
 #include <arpa/inet.h>
+#ifdef HAVE_STRUCT_LOOP_CONFIG_INFO
+# include <linux/loop.h>
+#endif
 
 #include "mount_util.h"
 #include "util.h"
 #include "fuse_i.h"
 #include "fuse_service_priv.h"
+#include "fuse_loopdev.h"
 #include "mount_service.h"
 
 #define FUSE_KERN_DEVICE_ENV	"FUSE_KERN_DEVICE"
 #define FUSE_DEV		"/dev/fuse"
+#define LOOPCTL			"/dev/loop-control"
 
 struct mount_service {
 	/* alleged fuse subtype based on -t cli argument */
@@ -542,6 +547,35 @@ static int mount_service_handle_open_cmd(struct mount_service *mo,
 		return mount_service_send_file_error(mo, error, oc->path);
 	}
 
+	if (request_flags & FUSE_SERVICE_OPEN_TRYLOOP) {
+		int loop_fd = -1;
+
+		ret = fuse_loopdev_setup(fd, ntohl(oc->open_flags), oc->path,
+					 5, &loop_fd, NULL);
+		if (ret) {
+			/*
+			 * If the setup function returned EBUSY, there is
+			 * already a loop device backed by this file, so we
+			 * must return an error.  For any other type of error
+			 * we'll send back the first file we opened.
+			 */
+			if (errno == EBUSY) {
+				ret = mount_service_send_file_error(mo, errno,
+						oc->path);
+				close(fd);
+				return ret;
+			}
+		} else if (loop_fd >= 0) {
+			/*
+			 * Send back the loop device instead of the file.
+			 */
+			ret = mount_service_send_file(mo, oc->path, loop_fd);
+			close(loop_fd);
+			close(fd);
+			return ret;
+		}
+	}
+
 	ret = mount_service_send_file(mo, oc->path, fd);
 	close(fd);
 	return ret;


