Return-Path: <linux-fsdevel+bounces-78120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACHqIbTinGnrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:28:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3A417F6D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54C77306413B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B506637F8CD;
	Mon, 23 Feb 2026 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbOHiXmP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3890237F8B7;
	Mon, 23 Feb 2026 23:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889263; cv=none; b=onrxK7M4FCWhiirYc6Orj0VB67Iva7UqSSHNulBM3ODJNdWza+khdIntAWbfCuApWUsvWOV8ZC7ARXRfuHqtDsvvB7mIvXrLRVSvsGMCmpw53kVMHBfQtEeMtrTHwTjIvOLqzbciS68ZPdYF+MHuBdXBahCh/VYPuZyJM4eUAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889263; c=relaxed/simple;
	bh=YMkxKUGYw3NSf3Cgmi5KrYkB6tPANcdoHxkvJPGmcWQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lL2KuBZPm9SZy9X6NvHAYw0nqQjkbYaU9eXv493snDA0QYwQVSqcxkXiphd7++CorfywczyNeiDRwyCnbgzRYe6Z8nmoVzb67QudW/QIS2vOR55hEtUWbXRgpz9j7Soe1pkLB/v0KXN+MNc2gfjSn+g3LAM9Kzb5yxIY7bpa1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbOHiXmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C551CC19421;
	Mon, 23 Feb 2026 23:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889262;
	bh=YMkxKUGYw3NSf3Cgmi5KrYkB6tPANcdoHxkvJPGmcWQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QbOHiXmPS1E1x2bRLINBt1IffeCaIzNCqvEEHaDzsHcFeAg0pES/XQPGd/YDOusnw
	 jBj3jAmbQ2+Rw+UMdgglcJ1N2X4sU6rGnZb6zxQbpTl89JnjKuFNMbmWLJCNuy+741
	 sy+MDjga16TfXdYCXAmtZFIezYHNPzs4O90UgFo31zN/whXi7QCX60RTI83eJU9CiU
	 wiIelCDSz2kZsdXX18dGFk9Jp52JYxYOksRQyueOgkgvMWAVJ5l/6ad0jjn1QQb7dr
	 CwwDeFRrOjRc4NAaxCEjRPWlTdGImLSRuAQY/N5E8iOyYr2W0CGbWJq0BgBz39rJDz
	 pPVfBAsMgy4HA==
Date: Mon, 23 Feb 2026 15:27:42 -0800
Subject: [PATCH 09/25] libfuse: add upper level iomap ioend commands
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740097.3940670.13122204935155462362.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78120-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F3A417F6D9
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Teach the upper level fuse library about iomap ioend events, which
happen when a write that isn't a pure overwrite completes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    9 +++++++++
 lib/fuse.c     |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 23b6d3f7c93303..dc4b79e98f6cd0 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -902,6 +902,15 @@ struct fuse_operations {
 			  off_t pos_in, uint64_t length_in,
 			  uint32_t opflags_in, ssize_t written_in,
 			  const struct fuse_file_iomap *iomap);
+
+	/**
+	 * Respond to the outcome of a file IO operation.
+	 */
+	int (*iomap_ioend) (const char *path, uint64_t nodeid,
+			    uint64_t attr_ino, off_t pos_in,
+			    uint64_t written_in, uint32_t ioendflags_in,
+			    int error_in, uint32_t dev_in,
+			    uint64_t new_addr_in, off_t *newsize);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 9662d007746809..8d6d1686fc733c 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2863,6 +2863,28 @@ int fuse_fs_iomap_device_remove(int device_id)
 	return fuse_lowlevel_iomap_device_remove(se, device_id);
 }
 
+static int fuse_fs_iomap_ioend(struct fuse_fs *fs, const char *path,
+			       uint64_t nodeid, uint64_t attr_ino, off_t pos,
+			       uint64_t written, uint32_t ioendflags, int error,
+			       uint32_t dev, uint64_t new_addr, off_t *newsize)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_ioend)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_ioend[%s] nodeid %llu attr_ino %llu pos %llu written %zu ioendflags 0x%x error %d dev %u new_addr 0x%llx\n",
+			 path, (unsigned long long)nodeid,
+			 (unsigned long long)attr_ino, (unsigned long long)pos,
+			 written, ioendflags, error, dev,
+			 (unsigned long long)new_addr);
+	}
+
+	return fs->op.iomap_ioend(path, nodeid, attr_ino, pos, written,
+				  ioendflags, error, dev, new_addr, newsize);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4613,6 +4635,36 @@ static void fuse_lib_iomap_end(fuse_req_t req, fuse_ino_t nodeid,
 	reply_err(req, err);
 }
 
+static void fuse_lib_iomap_ioend(fuse_req_t req, fuse_ino_t nodeid,
+				 uint64_t attr_ino, off_t pos, size_t written,
+				 uint32_t ioendflags, int error, uint32_t dev,
+				 uint64_t new_addr)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	off_t newsize = 0;
+	int err;
+
+	err = get_path_nullok(f, nodeid, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_ioend(f->fs, path, nodeid, attr_ino, pos, written,
+				  ioendflags, error, dev, new_addr, &newsize);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, nodeid, path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_reply_iomap_ioend(req, newsize);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4717,6 +4769,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.syncfs = fuse_lib_syncfs,
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
+	.iomap_ioend = fuse_lib_iomap_ioend,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)


