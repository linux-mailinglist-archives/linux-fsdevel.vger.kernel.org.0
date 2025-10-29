Return-Path: <linux-fsdevel+bounces-66090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90D8C17C41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5999D1C840C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070A12D7DE1;
	Wed, 29 Oct 2025 01:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfsMbME1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45A16EB42;
	Wed, 29 Oct 2025 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700075; cv=none; b=HebFLpRx73yv7V1v4qWEUzO8jUw6DzJtlvrmkLhROc+EJcbeLswnfO2x+PFkgPNnEcFI4NR6KY/YiwsbWq3UvpV1snoQdolER4ae4Zl35bAckbsifMyVkuwnhGOw0CMXNIF+rPmGQtPl94clplfDYhBPthXNCsUzl/OVNwGvleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700075; c=relaxed/simple;
	bh=pV3BCtoIr7+WjsqX7jHeyfWLkzVi1TJwaZkIkiTDlWA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4pCJxMo2VJfdb4qJ00Bp0yoK+DhFxJ1ngqOsusN/Q+6HOs/oE85GFswB7fh4IXDMP1krNfsD9tKadax8xHWa1M0XGAb3WQdsAoUVrAKJiIstFOiN/Jh2A1t2eSUKzbGFdEblCFMkzft4rbzNvXv1EfCbkOW+NWxv7t7lFjuGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfsMbME1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD78AC4CEE7;
	Wed, 29 Oct 2025 01:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700074;
	bh=pV3BCtoIr7+WjsqX7jHeyfWLkzVi1TJwaZkIkiTDlWA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AfsMbME1nCjK7BNx+isqgrYslMw7B35img1gab9FL1AK5YMy61Ha9CXZRbXchgUOv
	 RbUvnh4P0e7zVfX14TKndPD/SIePQ4bb2CNNYE3QgdJQ9btJpclmZjhkloN6gCt6Wj
	 M7Wu/AxXxsvrCc2PO2LNfG385XCP+JaKgLo3WY7kPwj8i41ePMVYkbTWKZftGTErhx
	 QqTJEDcr2VhfhPs6mccBbS4nL6leM/K4nKEZ5qnUAcRDowjZyn/IsI2JuXZkdLW7gz
	 IJ6Tw9M4yMOxzE6s17+Vnua1TOktdn502wmcYP/I/iOgtMImvwDf9mumt+k5celWz6
	 YwtKzR27l9XHQ==
Date: Tue, 28 Oct 2025 18:07:54 -0700
Subject: [PATCH 3/5] libfuse: delegate iomap privilege from mount.service to
 fuse services
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814906.1428772.2925113261612522411.stgit@frogsfrogsfrogs>
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

Enable the mount.service helper to attach whatever privileges it might
have to enable iomap to a /dev/fuse fd before passing that fd to the
fuse server.  Assuming that the fuse service itself does not have
sufficient privilege to enable iomap on its own, it can now inherit that
privilege via the fd.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h       |    1 +
 include/fuse_lowlevel.h     |   11 +++++++
 include/fuse_service.h      |   11 +++++++
 include/fuse_service_priv.h |   10 +++++++
 lib/fuse_lowlevel.c         |    5 +++
 lib/fuse_service.c          |   49 +++++++++++++++++++++++++++++++++
 lib/fuse_versionscript      |    2 +
 util/mount_service.c        |   64 +++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 152 insertions(+), 1 deletion(-)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 10bdf276ef9b74..0638d774d36cbc 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1178,6 +1178,7 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 99)
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
 
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index d79b7e1902b331..a93f3e27f6ef6d 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2710,7 +2710,6 @@ bool fuse_req_is_uring(fuse_req_t req);
 int fuse_req_get_payload(fuse_req_t req, char **payload, size_t *payload_sz,
 			 void **mr);
 
-
 /**
  * Discover the kernel's iomap capabilities.  Returns FUSE_CAP_IOMAP_* flags.
  *
@@ -2720,6 +2719,16 @@ int fuse_req_get_payload(fuse_req_t req, char **payload, size_t *payload_sz,
  */
 uint64_t fuse_lowlevel_discover_iomap(int fd);
 
+/**
+ * Request that iomap capabilities be added to this fuse device.  This enables
+ * a privileged mount helper to convey the privileges that allow iomap usage to
+ * a completely unprivileged fuse server.
+ *
+ * @param fd open file descriptor to a fuse device
+ * @return 0 on success, -1 on failure with errno set
+ */
+int fuse_lowlevel_add_iomap(int fd);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/fuse_service.h b/include/fuse_service.h
index a852516feb39fb..47080a75bc9ab6 100644
--- a/include/fuse_service.h
+++ b/include/fuse_service.h
@@ -128,6 +128,17 @@ int fuse_service_receive_file(struct fuse_service *sf,
  */
 int fuse_service_finish_file_requests(struct fuse_service *sf);
 
+/**
+ * Attach iomap to the fuse connection.
+ *
+ * @param sf service context
+ * @param mandatory true if the server requires iomap
+ * @param error result of trying to enable iomap
+ * @return 0 on success, -1 on error
+ */
+int fuse_service_configure_iomap(struct fuse_service *sf, bool mandatory,
+				 int *error);
+
 /**
  * Ask the mount.service helper to mount the filesystem for us.  The fuse client
  * will begin sending requests to the fuse server immediately after this.
diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
index 042568e97e7e13..ce2e194ccf0be6 100644
--- a/include/fuse_service_priv.h
+++ b/include/fuse_service_priv.h
@@ -32,6 +32,7 @@ struct fuse_service_memfd_argv {
 #define FUSE_SERVICE_MNTPT_CMD		0x4d4e5450	/* MNTP */
 #define FUSE_SERVICE_MOUNT_CMD		0x444f4954	/* DOIT */
 #define FUSE_SERVICE_BYE_CMD		0x42594545	/* BYEE */
+#define FUSE_SERVICE_IOMAP_CMD		0x494f4d41	/* IOMA */
 
 /* mount.service sends replies to the fuse server */
 #define FUSE_SERVICE_OPEN_REPLY		0x46494c45	/* FILE */
@@ -72,6 +73,15 @@ static inline size_t sizeof_fuse_service_open_command(size_t pathlen)
 	return sizeof(struct fuse_service_open_command) + pathlen + 1;
 }
 
+#define FUSE_IOMAP_MODE_OPTIONAL	0x503F /* P? */
+#define FUSE_IOMAP_MODE_MANDATORY	0x5021 /* P! */
+
+struct fuse_service_iomap_command {
+	struct fuse_service_packet p;
+	__be16 mode;
+	__be16 padding;
+};
+
 struct fuse_service_string_command {
 	struct fuse_service_packet p;
 	char value[];
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 7eaa8e51f50129..51c609761494af 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4990,3 +4990,8 @@ uint64_t fuse_lowlevel_discover_iomap(int fd)
 
 	return ios.flags;
 }
+
+int fuse_lowlevel_add_iomap(int fd)
+{
+	return ioctl(fd, FUSE_DEV_IOC_ADD_IOMAP);
+}
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index f627bdb94d9b0f..48633640c1c41b 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -629,6 +629,55 @@ static int send_mount(struct fuse_service *sf, unsigned int flags, int *error)
 	return 0;
 }
 
+int fuse_service_configure_iomap(struct fuse_service *sf, bool mandatory,
+				 int *error)
+{
+	struct fuse_service_iomap_command cmd = {
+		.p.magic = ntohl(FUSE_SERVICE_IOMAP_CMD),
+		.mode = mandatory ? ntohs(FUSE_IOMAP_MODE_MANDATORY) :
+				    ntohs(FUSE_IOMAP_MODE_OPTIONAL),
+	};
+	struct fuse_service_simple_reply reply = { };
+	struct iovec iov = {
+		.iov_base = &cmd,
+		.iov_len = sizeof(cmd),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	ssize_t size;
+
+	size = sendmsg(sf->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		perror("fuse: send iomap command");
+		return -1;
+	}
+
+	iov.iov_base = &reply;
+	iov.iov_len = sizeof(reply);
+	size = recvmsg(sf->sockfd, &msg, MSG_TRUNC);
+	if (size < 0) {
+		perror("fuse: iomap command reply");
+		return -1;
+	}
+	if (size != sizeof(reply)) {
+		fprintf(stderr,
+ "fuse: wrong iomap command reply size %zd, expected %zd\n",
+			size, sizeof(reply));
+		return -1;
+	}
+
+	if (ntohl(reply.p.magic) != FUSE_SERVICE_SIMPLE_REPLY) {
+		fprintf(stderr,
+ "fuse: iomap command reply contains wrong magic!\n");
+		return -1;
+	}
+
+	*error = ntohl(reply.error);
+	return 0;
+}
+
 int fuse_service_mount(struct fuse_service *sf, struct fuse_session *se,
 		       const char *mountpoint)
 {
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 039150600fc556..2adab40e0eab1f 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -241,9 +241,11 @@ FUSE_3.99 {
 		fuse_lowlevel_notify_iomap_inval;
 		fuse_fs_iomap_upsert;
 		fuse_fs_iomap_inval;
+		fuse_lowlevel_add_iomap;
 
 		fuse_service_accept;
 		fuse_service_append_args;
+		fuse_service_configure_iomap;
 		fuse_service_destroy;
 		fuse_service_finish_file_requests;
 		fuse_service_mount;
diff --git a/util/mount_service.c b/util/mount_service.c
index dcaf055ae648f4..e3410d524167a4 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -62,6 +62,9 @@ struct mount_service {
 
 	/* fd for fsopen */
 	int fsopenfd;
+
+	/* did someone configure iomap already? */
+	int iomap_configured:1;
 };
 
 /* Filter out the subtype of the filesystem (e.g. fuse.Y -> Y) */
@@ -399,6 +402,22 @@ static int mount_service_send_file_error(struct mount_service *mo, int error,
 	return ret;
 }
 
+static int mount_service_config_iomap(struct mount_service *mo,
+				      bool mandatory)
+{
+	int ret;
+
+	mo->iomap_configured = 1;
+
+	ret = fuse_lowlevel_add_iomap(mo->fusedevfd);
+	if (ret && mandatory) {
+		perror("mount.service: adding iomap capability");
+		return -errno;
+	}
+
+	return 0;
+}
+
 static int mount_service_send_required_files(struct mount_service *mo,
 					     const char *fusedev)
 {
@@ -729,6 +748,13 @@ static int mount_service_regular_mount(struct mount_service *mo,
 		return -1;
 	}
 
+	/*
+	 * If nobody tried to configure iomap, try to enable it but don't
+	 * fail if we can't.
+	 */
+	if (!mo->iomap_configured)
+		mount_service_config_iomap(mo, false);
+
 	ret = mount(mo->source, mo->mountpoint, mo->fstype, ntohl(oc->flags),
 		    realmopts);
 	free(realmopts);
@@ -800,6 +826,41 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
 	return mount_service_send_reply(mo, 0);
 }
 
+static int mount_service_handle_iomap_cmd(struct mount_service *mo,
+					  struct fuse_service_packet *p)
+{
+	struct fuse_service_iomap_command *oc =
+			container_of(p, struct fuse_service_iomap_command, p);
+	bool mandatory = false;
+	int ret;
+
+	if (oc->padding) {
+		fprintf(stderr, "mount.service: invalid iomap command\n");
+		mount_service_send_reply(mo, EINVAL);
+		return -1;
+	}
+
+	switch (ntohs(oc->mode)) {
+	case FUSE_IOMAP_MODE_MANDATORY:
+		mandatory = true;
+		/* fallthrough */
+	case FUSE_IOMAP_MODE_OPTIONAL:
+		ret = mount_service_config_iomap(mo, mandatory);
+		break;
+	default:
+		fprintf(stderr, "mount.service: invalid iomap command mode\n");
+		ret = -1;
+	}
+
+	if (ret < 0) {
+		mount_service_send_reply(mo, -ret);
+		return -1;
+	}
+
+	mount_service_send_reply(mo, 0);
+	return 0;
+}
+
 static int mount_service_handle_mount_cmd(struct mount_service *mo,
 					  struct fuse_service_packet *p)
 {
@@ -942,6 +1003,9 @@ int mount_service_main(int argc, char *argv[])
 		case FUSE_SERVICE_MNTPT_CMD:
 			ret = mount_service_handle_mountpoint_cmd(&mo, p);
 			break;
+		case FUSE_SERVICE_IOMAP_CMD:
+			ret = mount_service_handle_iomap_cmd(&mo, p);
+			break;
 		case FUSE_SERVICE_MOUNT_CMD:
 			ret = mount_service_handle_mount_cmd(&mo, p);
 			break;


