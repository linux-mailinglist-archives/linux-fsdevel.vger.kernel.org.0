Return-Path: <linux-fsdevel+bounces-78203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMHNKELonGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:52:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF11800F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0015C31B2D5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968D53803CC;
	Mon, 23 Feb 2026 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlRbcpt2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A0C37FF70;
	Mon, 23 Feb 2026 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890547; cv=none; b=s0h+8NKdMTpaQ/mCzCCsdudaMGrU/ATCSY4vMv/SwHlqZxKSAevAFCRSxEydxN+vNKMoCizXqKfztYFUWMCQi6TS39DtsRkb55W3x7Ph5Rdqj2vOuaWX1H0LxFzumvPMCYrAmpZoIlN85JFZOROIwiH0/i6p6eF/vevzcoqLeUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890547; c=relaxed/simple;
	bh=RE/+s6SOHAE8+brfY1pFPVvbb0I9zwQJhjLk10COkAw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYPXLS6x4JMPciB5pps+UtZK4rPJqCO6rqxd35K2q0UCSjRggzfomaQYSQNODgN5GtvzplPbZIW0OCe8A9DzQ35MA6RSsLusweAX4YMxHD2IOovQN/L7YIYevlfBkueyh99ev3D338raY6UYSVv6tCWzRYZBIyyUYP9x46iSnNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlRbcpt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAE1C116C6;
	Mon, 23 Feb 2026 23:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890546;
	bh=RE/+s6SOHAE8+brfY1pFPVvbb0I9zwQJhjLk10COkAw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QlRbcpt2GBitVPAXdaY3B7yTPggzHjGCFeMkTp1kVT3rew3OdRbwV+FwACAWVM13S
	 u53pB5zlFIiIo7v9+1GV7vrjNJEpJcL5PZcsi3LRYTIiYWwt952i9nsANj5Q5i07tN
	 5fH/+wcK0G1vKL63GnaZAcgD+ujcbg4d7dYOLQ7rrozxPbhy9WtDKHOfjNR97p5tUe
	 5BJrKd/rKnrVfP/5JRGnjUeyjkwIucrpDPO1HHUBiuUtSl6WT5/G+u6tIlMxVHNcq6
	 KkEtdK99Cbc9VC2ltKiDQy537TVCXNoC2g1nRUvuu/M1qpC4kulO29l/72EtEUGlis
	 0bLNqLij1882g==
Date: Mon, 23 Feb 2026 15:49:06 -0800
Subject: [PATCH 3/4] fuse4fs: enable memory pressure monitoring with service
 containers
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188746289.3945260.10098153737399667981.stgit@frogsfrogsfrogs>
In-Reply-To: <177188746221.3945260.11225620337508354203.stgit@frogsfrogsfrogs>
References: <177188746221.3945260.11225620337508354203.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78203-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BAF11800F7
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Ask the fuse filesystem service mount helper to open the memory pressure
stall files because we cannot open them ourselves.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/psi.h |    9 +++++++
 fuse4fs/fuse4fs.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 lib/support/psi.c |   53 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 128 insertions(+), 5 deletions(-)


diff --git a/lib/support/psi.h b/lib/support/psi.h
index 675ebeb553da3e..916ebf15d17431 100644
--- a/lib/support/psi.h
+++ b/lib/support/psi.h
@@ -54,4 +54,13 @@ static inline bool psi_active(struct psi *psi)
 	return psi != NULL;
 }
 
+char *psi_system_path(enum psi_type type);
+ssize_t psi_cgroup_path(enum psi_type type, char *path, size_t pathsize);
+
+#define PSI_OPEN_FLAGS (O_RDWR | O_NONBLOCK)
+
+int psi_create_from(enum psi_type type, unsigned int psi_flags,
+		    uint64_t stall_us, uint64_t window_us, uint64_t timeout_us,
+		    int *system_fd, int *cgroup_fd, struct psi **psip);
+
 #endif /* __PSI_H__ */
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 87b17491beae13..4d48521fa8f763 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -327,6 +327,8 @@ struct fuse4fs {
 	char *svc_cmdline;
 	int bdev_fd;
 	int fusedev_fd;
+	int psi_sys_mem_fd;
+	int psi_cgroup_mem_fd;
 #endif
 	struct psi *mem_psi;
 	struct psi_handler *mem_psi_handler;
@@ -939,8 +941,16 @@ static int fuse4fs_psi_config(struct fuse4fs *ff)
 	 * Activate when there are memory stalls for 200ms every 2s; or
 	 * 5min goes by.  Unprivileged processes can only use 2s windows.
 	 */
-	err = psi_create(PSI_MEMORY, PSI_TRIM_HEAP, 20100, 2000000,
-			 5 * 60 * 1000000, &ff->mem_psi);
+#ifdef HAVE_FUSE_SERVICE
+	if (fuse4fs_is_service(ff))
+		err = psi_create_from(PSI_MEMORY, PSI_TRIM_HEAP, 202002,
+				      2000000, 5 * 60 * 1000000,
+				      &ff->psi_sys_mem_fd,
+				      &ff->psi_cgroup_mem_fd, &ff->mem_psi);
+	else
+#endif
+		err = psi_create(PSI_MEMORY, PSI_TRIM_HEAP, 202002, 2000000,
+				 5 * 60 * 1000000, &ff->mem_psi);
 	if (err) {
 		switch (errno) {
 		case ENOENT:
@@ -1564,6 +1574,14 @@ static int fuse4fs_service_finish(struct fuse4fs *ff, int ret)
 	close(ff->bdev_fd);
 	ff->bdev_fd = -1;
 
+	if (ff->psi_sys_mem_fd >= 0)
+		close(ff->psi_sys_mem_fd);
+	ff->psi_sys_mem_fd = -1;
+
+	if (ff->psi_cgroup_mem_fd >= 0)
+		close(ff->psi_cgroup_mem_fd);
+	ff->psi_cgroup_mem_fd = -1;
+
 	/*
 	 * If we're being run as a service, the return code must fit the LSB
 	 * init script action error guidelines, which is to say that we
@@ -1585,6 +1603,49 @@ static int fuse4fs_service_finish(struct fuse4fs *ff, int ret)
 	return EXIT_SUCCESS;
 }
 
+/* Open PSI control files */
+static int fuse_service_open_psi_controls(struct fuse4fs *ff)
+{
+	const char *psifile = psi_system_path(PSI_MEMORY);
+	char cgpath[PATH_MAX];
+	ssize_t cgpathlen;
+	int ret;
+
+	ret = fuse_service_request_file(ff->service, psifile, PSI_OPEN_FLAGS,
+					0, 0);
+	if (ret)
+		return ret;
+
+	ret = fuse_service_receive_file(ff->service, psifile,
+					&ff->psi_sys_mem_fd);
+	if (ret)
+		return ret;
+	if (ff->psi_sys_mem_fd < 0)
+		err_printf(ff, "%s %s: %s.\n",
+			   _("opening system memory pressure monitor"),
+			   psifile, strerror(errno));
+
+	cgpathlen = psi_cgroup_path(PSI_MEMORY, cgpath, sizeof(cgpath));
+	if (!cgpathlen || cgpathlen >= sizeof(cgpath))
+		return 0;
+
+	ret = fuse_service_request_file(ff->service, cgpath, PSI_OPEN_FLAGS,
+					0, 0);
+	if (ret)
+		return ret;
+
+	ret = fuse_service_receive_file(ff->service, cgpath,
+					&ff->psi_cgroup_mem_fd);
+	if (ret)
+		return ret;
+	if (ff->psi_cgroup_mem_fd < 0)
+		err_printf(ff, "%s %s: %s.\n",
+			   _("opening cgroup memory pressure monitor"),
+			   cgpath, strerror(errno));
+
+	return 0;
+}
+
 static int fuse4fs_service_get_config(struct fuse4fs *ff)
 {
 	double deadline = init_deadline(FUSE4FS_OPEN_TIMEOUT);
@@ -1620,6 +1681,10 @@ static int fuse4fs_service_get_config(struct fuse4fs *ff)
 		return -1;
 	}
 
+	ret = fuse_service_open_psi_controls(ff);
+	if (ret)
+		return ret;
+
 	ret = fuse_service_finish_file_requests(ff->service);
 	if (ret)
 		return ret;
@@ -8581,6 +8646,8 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_SERVICE
 		.bdev_fd = -1,
 		.fusedev_fd = -1,
+		.psi_sys_mem_fd = -1,
+		.psi_cgroup_mem_fd = -1,
 #endif
 	};
 	errcode_t err;
diff --git a/lib/support/psi.c b/lib/support/psi.c
index 26ce6ee1985641..531ae935701edf 100644
--- a/lib/support/psi.c
+++ b/lib/support/psi.c
@@ -54,7 +54,7 @@ struct psi {
 	enum psi_state state;
 };
 
-static const char *psi_system_path(enum psi_type type)
+char *psi_system_path(enum psi_type type)
 {
 	switch (type) {
 	case PSI_MEMORY:
@@ -300,7 +300,7 @@ void psi_destroy(struct psi **psip)
 
 static int psi_open_control(const char *path)
 {
-	return open(path, O_RDWR | O_NONBLOCK);
+	return open(path, PSI_OPEN_FLAGS);
 }
 
 static void psi_open_system_control(struct psi *psi)
@@ -309,7 +309,7 @@ static void psi_open_system_control(struct psi *psi)
 	psi->system_fd = psi_open_control(psi_system_path(psi->type));
 }
 
-static ssize_t psi_cgroup_path(enum psi_type type, char *path, size_t pathsize)
+ssize_t psi_cgroup_path(enum psi_type type, char *path, size_t pathsize)
 {
 	char cgpath[PATH_MAX];
 	char *p = cgpath;
@@ -485,6 +485,53 @@ int psi_create(enum psi_type type, unsigned int psi_flags, uint64_t stall_us,
 	return -1;
 }
 
+/*
+ * Same as psi_create, but you can specify the whole-system and per-cgroup
+ * monitoring fds.
+ */
+int psi_create_from(enum psi_type type, unsigned int psi_flags,
+		    uint64_t stall_us, uint64_t window_us, uint64_t timeout_us,
+		    int *system_fd, int *cgroup_fd, struct psi **psip)
+{
+	struct psi *psi;
+	int ret;
+
+	if (psi_flags & ~PSI_FLAGS) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	psi = psi_alloc(type, psi_flags, timeout_us);
+	if (!psi)
+		return -1;
+
+	psi->system_fd = *system_fd;
+	psi->cgroup_fd = *cgroup_fd;
+
+	*system_fd = -1;
+	*cgroup_fd = -1;
+
+	if (psi->system_fd < 0 && psi->cgroup_fd < 0 && !psi->timeout_us) {
+		errno = ENOENT;
+		goto out_fds;
+	}
+
+	ret = psi_config_fd(psi, psi->system_fd, stall_us, window_us);
+	if (ret)
+		goto out_fds;
+
+	ret = psi_config_fd(psi, psi->cgroup_fd, stall_us, window_us);
+	if (ret)
+		goto out_fds;
+
+	*psip = psi;
+	return 0;
+
+out_fds:
+	psi_destroy(&psi);
+	return -1;
+}
+
 /* Start monitoring for resource pressure stalls */
 int psi_start_thread(struct psi *psi)
 {


