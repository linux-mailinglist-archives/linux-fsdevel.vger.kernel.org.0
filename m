Return-Path: <linux-fsdevel+bounces-78118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBIEOITinGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:28:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB4017F680
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FD8430185D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3AF37F75F;
	Mon, 23 Feb 2026 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyPq9JHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBEE37F736;
	Mon, 23 Feb 2026 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889232; cv=none; b=kcr87ZupaUoGY+QnZbMTe1U4kPuuSMLrmd/A365l0OStPRXS55IdrejQ8KBS8xer3L6U7W74nnf2ndv36R1g03KmHaeEb8E3LOpNh0WefPgTiwSgMW8wOz5GmFaC9neBB8629HZ1PdUsMkjRZ/2FzfqAl6g68DcaG6m4UgS/Pts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889232; c=relaxed/simple;
	bh=8UntqlKkpnBcXHuCSvFZyEtleWUJzUK6+divQhFpSkE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lurNrKhxQqgpcRGnel0FgdXx0SE3a8KmwlK8/otvAGvo/LQNY8YoMqXO0rtpNhPCVC5QWn9lCpd4/OFLvZUaYVfACYUHT0yQdZ6983pIjMunLpuuYYW9q4fZT9ahm5xSnJ+C8RmemrGntCptdgQ4IIbaNwpIU9J/x5AOfBi9G1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyPq9JHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC8EC116C6;
	Mon, 23 Feb 2026 23:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889231;
	bh=8UntqlKkpnBcXHuCSvFZyEtleWUJzUK6+divQhFpSkE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TyPq9JHsgSKPkJDg/n8Ze3DwSv+Q6P4aR572rPI/e9NoAamIZXdUPfGy44TunNSVm
	 K2GAsyZ72O+VLv917yt5D5bX0mXJdFhsryplGw3HPPZLlrNxnrp2rKQ/942r1BWMuA
	 +CVu1sl6d9YAGDSwfi8U75OfGSN9nq/q3Nd0cIvNa/nGvJK6gBj0YuJn3HsNRYn4FX
	 OlZsAqA9PM+QmpXdKjqjLzolwLK5NfuyL/EFoB+SPPK7i1BtZOZm50l39NU62fpWhL
	 /0dT/DU5F12z720TiAASsBWL/fUxO+U7MRfCPQDRH2EnqF/oQo31NAIVPBHpc3ZTpc
	 O67Y/OYsg8abw==
Date: Mon, 23 Feb 2026 15:27:11 -0800
Subject: [PATCH 07/25] libfuse: add upper-level iomap add device function
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740061.3940670.215263904553650984.stgit@frogsfrogsfrogs>
In-Reply-To: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
References: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78118-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 3AB4017F680
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Make it so that the upper level fuse library can add iomap devices too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h         |   19 +++++++++++++++++++
 lib/fuse.c             |   16 ++++++++++++++++
 lib/fuse_versionscript |    2 ++
 3 files changed, 37 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 1c8caf0c2ee034..23b6d3f7c93303 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1403,6 +1403,25 @@ void fuse_fs_init(struct fuse_fs *fs, struct fuse_conn_info *conn,
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
index ac325b1a3d9e82..9662d007746809 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2847,6 +2847,22 @@ static int fuse_fs_iomap_end(struct fuse_fs *fs, const char *path,
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
index bd9255f95d9948..5c4a7dc53b33f3 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -235,6 +235,8 @@ FUSE_3.99 {
 		fuse_reply_iomap_begin;
 		fuse_lowlevel_iomap_device_add;
 		fuse_lowlevel_iomap_device_remove;
+		fuse_fs_iomap_device_add;
+		fuse_fs_iomap_device_remove;
 } FUSE_3.19;
 
 # Local Variables:


