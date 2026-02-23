Return-Path: <linux-fsdevel+bounces-78147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHPrJxrknGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:34:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE1A17F99C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 936B13035F4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D5837F8D7;
	Mon, 23 Feb 2026 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufOeJnqZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30FD37F8BF;
	Mon, 23 Feb 2026 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889685; cv=none; b=anSeopS6WHCjHwkXjKrLSSUUcRypGJGOphRRFrP+lRlLqllEBKaGtRAVENCIPndbDD4YGYRwPjI8ZUd5bVS9sQMJ4Dde7t76s8aca1eIMcYSv3RNJyTxTI25wQeq6rJlMqtEpnSQwMKpQe6aLsqtOM0A/fRoEB4oudE01tZHe78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889685; c=relaxed/simple;
	bh=F5BqDyiYl0dE99KglsN1JDS/tTfU0p0ew12mEWQWYBg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWP+niAPwc/Nhlcv3vV/50nsOmLOcihxhv37Hrcj4Fv11NGjVagjLPmQbKni2hK+YsjIx7eZiYcCXC4ypHzb4rk0tO1a1z40MNlDf+mwX13kkZei8Kz1rdnsvEAVNg0iGVkh5zzAOjp43xdLnz9fXYsYUMmxqwDCC8FDfQu3sG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufOeJnqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4A4C116C6;
	Mon, 23 Feb 2026 23:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889684;
	bh=F5BqDyiYl0dE99KglsN1JDS/tTfU0p0ew12mEWQWYBg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ufOeJnqZ9JTV6V90MLJ2B7aGt/jlnaEiW9MuQjD0lta6jiFuobMc8tePNJ991liAl
	 aMs7PlKPEGeKKVUImGUJh4WoUB2NWPYs3cnX8yqwHhuYBs6s6dLPC+j7KCwM9k6caG
	 lAXTFJJrox5kAVXP+caMDMdnYzIZDHqv6DScK/Isa14t75tQ4hhRYfqr8ERN/XZcKp
	 w+pTTj/Wa/fUn8MLhbrbD6/xyZ9M7GdTO+ka0FRXJhzxfLI1kEIQoNsjmPdVglxl4Z
	 nZOhheFsd9cmWKjeqoD1/NNhHbVadEiHQ1sTnulSdC/NupV8x0chRenaCb8TKDq/2r
	 LipFFNQ9k5vsA==
Date: Mon, 23 Feb 2026 15:34:44 -0800
Subject: [PATCH 3/5] libfuse: delegate iomap privilege from mount.service to
 fuse services
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188741369.3942122.8308556331657757266.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78147-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BE1A17F99C
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Enable the mount.service helper to attach whatever privileges it might
have to enable iomap to a /dev/fuse fd before passing that fd to the
fuse server.  Assuming that the fuse service itself does not have
sufficient privilege to enable iomap on its own, it can now inherit that
privilege via the fd.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h       |    1 +
 include/fuse_lowlevel.h     |   10 +++++++
 include/fuse_service.h      |   11 +++++++
 include/fuse_service_priv.h |   10 +++++++
 lib/fuse_lowlevel.c         |    5 +++
 lib/fuse_service.c          |   49 +++++++++++++++++++++++++++++++++
 lib/fuse_versionscript      |    2 +
 util/mount_service.c        |   64 +++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 152 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 8149657ac44cb9..417f1d42b0618d 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1193,6 +1193,7 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
 #define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
+#define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 101)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 77fc623386ce20..eefc69360b8aa8 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2799,6 +2799,16 @@ uint64_t fuse_lowlevel_discover_iomap(int fd);
  */
 int fuse_lowlevel_disable_fsreclaim(struct fuse_session *se, int val);
 
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
index d3a3a4a4237380..a88173a0e4c227 100644
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
index 4df323097c2470..f755710863c766 100644
--- a/include/fuse_service_priv.h
+++ b/include/fuse_service_priv.h
@@ -32,6 +32,7 @@ struct fuse_service_memfd_argv {
 #define FUSE_SERVICE_MNTPT_CMD		0x4d4e5450	/* MNTP */
 #define FUSE_SERVICE_MOUNT_CMD		0x444f4954	/* DOIT */
 #define FUSE_SERVICE_BYE_CMD		0x42594545	/* BYEE */
+#define FUSE_SERVICE_IOMAP_CMD		0x494f4d41	/* IOMA */
 
 /* mount.service sends replies to the fuse server */
 #define FUSE_SERVICE_OPEN_REPLY		0x46494c45	/* FILE */
@@ -87,6 +88,15 @@ static inline size_t sizeof_fuse_service_open_command(size_t pathlen)
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
index 714c26385c044f..4f27603400f2da 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -5349,3 +5349,8 @@ int fuse_lowlevel_disable_fsreclaim(struct fuse_session *se, int val)
 {
 	return ioctl(se->fd, FUSE_DEV_IOC_SET_NOFS, &val);
 }
+
+int fuse_lowlevel_add_iomap(int fd)
+{
+	return ioctl(fd, FUSE_DEV_IOC_ADD_IOMAP);
+}
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index 40763143946c83..a9fce8b022c005 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -649,6 +649,55 @@ static int send_mount(struct fuse_service *sf, unsigned int flags, int *error)
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
index 935eaec820c7a7..334a0f7cf3a096 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -254,8 +254,10 @@ FUSE_3.99 {
 		fuse_lowlevel_iomap_inval_mappings;
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
index 642d4a19c443c4..241f47822deaa6 100644
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
@@ -413,6 +416,22 @@ static int mount_service_send_file_error(struct mount_service *mo, int error,
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
@@ -743,6 +762,13 @@ static int mount_service_regular_mount(struct mount_service *mo,
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
@@ -814,6 +840,41 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
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
@@ -956,6 +1017,9 @@ int mount_service_main(int argc, char *argv[])
 		case FUSE_SERVICE_MNTPT_CMD:
 			ret = mount_service_handle_mountpoint_cmd(&mo, p);
 			break;
+		case FUSE_SERVICE_IOMAP_CMD:
+			ret = mount_service_handle_iomap_cmd(&mo, p);
+			break;
 		case FUSE_SERVICE_MOUNT_CMD:
 			ret = mount_service_handle_mount_cmd(&mo, p);
 			break;


