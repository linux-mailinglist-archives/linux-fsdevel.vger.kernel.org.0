Return-Path: <linux-fsdevel+bounces-78149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IqwOPHknGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:38:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA7917FAAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F34A53056B20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88FE37F8DF;
	Mon, 23 Feb 2026 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5+1XUvu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334321E9B1A;
	Mon, 23 Feb 2026 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889716; cv=none; b=mVgkdaLGNfCzsKisQDLYR/c+YSUJsNXPbvcdVF13J/rLxrIMVjVVYfanJ8ndHbg5W4a+BdWEEVtmaiJyA0D4IC/6DWl6PX6qsu1tZOJuxLxYk4v7RWDn9Agcztgde1alXxIXEujQ97enMwsPM8A+xrZGzPaWazS40/tbcTKt5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889716; c=relaxed/simple;
	bh=z0riPJoUoqMNuTnjyMrldV0sNmOvWPXz1YFq2+puY+g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+eL1yfLsNFT7iZqYLdcLVHC8J838DV1QDQyKWX18U0/haWPxgWMVC6CsdBvXKWuw0B0pquWiQfbj6sduXi/mn4x1KyVj3F3S2eRIxXHiOEWhIKv8/yaWGfqu1bd9X2Accs71HeqVYPhRcqgxIni3+cpq26KYk31dyvUbQVx3wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5+1XUvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F46C116C6;
	Mon, 23 Feb 2026 23:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889716;
	bh=z0riPJoUoqMNuTnjyMrldV0sNmOvWPXz1YFq2+puY+g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=A5+1XUvuzwFqNdFKvQkvrAJ5qubb1SfbPMD9/QtjjBuDvDHooJYPTKUaRCnfI9Y96
	 AOtJi1svNF3VBN1CxS6sZn0mHpfHecpyhEKN8ql4nKDOILBcgj4/CjYblY/HPXKbar
	 vy+6gCU6BPo46de3YxJL41RvuzQqVIBWOcYFCUT6t2ZQlswdEt/6vjw5zd2IeegkTO
	 D2FsgANnvNKUXXPmjaD09OB6thS3pQEQMcL0hTxa1FwX84L/wEF4Tk6lvJcHZJXPt2
	 3qOVz+aGUcMt0gF/V2gpEtgwfrhC4PmKKW1fH1dVFJKzQP9gY6m6q2I1jiOf04Ka5h
	 YnLPBiYxT4wmA==
Date: Mon, 23 Feb 2026 15:35:15 -0800
Subject: [PATCH 5/5] fuservicemount: create loop devices for regular files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188741404.3942122.2674145107833313403.stgit@frogsfrogsfrogs>
In-Reply-To: <177188741298.3942122.15899633653835028664.stgit@frogsfrogsfrogs>
References: <177188741298.3942122.15899633653835028664.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78149-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EA7917FAAF
X-Rspamd-Action: no action

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
index a88173a0e4c227..035ea57873e536 100644
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
index f755710863c766..e8b6da260b089e 100644
--- a/include/fuse_service_priv.h
+++ b/include/fuse_service_priv.h
@@ -73,7 +73,8 @@ static inline size_t sizeof_fuse_service_requested_file(size_t pathlen)
 	return sizeof(struct fuse_service_requested_file) + pathlen + 1;
 }
 
-#define FUSE_SERVICE_OPEN_FLAGS		(0)
+#define FUSE_SERVICE_OPEN_TRYLOOP	(1U << 0)
+#define FUSE_SERVICE_OPEN_FLAGS		(FUSE_SERVICE_OPEN_TRYLOOP)
 
 struct fuse_service_open_command {
 	struct fuse_service_packet p;
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index a9fce8b022c005..bcab6913809dfd 100644
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
index 241f47822deaa6..f1e2fc4c52092d 100644
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
@@ -556,6 +561,35 @@ static int mount_service_handle_open_cmd(struct mount_service *mo,
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


