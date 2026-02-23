Return-Path: <linux-fsdevel+bounces-78136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PzuH+DjnGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:33:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB27517F94B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F2CA3007AF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08AD37F8CA;
	Mon, 23 Feb 2026 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enuP1ePa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1C737F739;
	Mon, 23 Feb 2026 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889513; cv=none; b=ZJrOq9xmsDe9izvDnYeCVTZYDtKCgtTc0Vpr/f/hZ+qC64i/e+G6LRmAm2hpuJwZLADTEcwyV+9nzzbOodA76LRY7B9ZYxUFnXNT61Oii5o5JpCKvPyFW1J10vM4tjHYIiG7y60J1G2pthSe1U6C5tOab0lPU+HDxXji3D9PSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889513; c=relaxed/simple;
	bh=h16x1XzjVSXNQ2WiwJZY34R1NW+M+Z0Yma6RETO4iFM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntywIFV//8S/JPCjufg5Wv202S60D0uWVSrHS/ixHIvXrCW3cu/8Bluum8je74pPuZ2DCw5pHCVyo7dyD0mHq42aGfZ+yetPb3GFMVOiP7yWI/Yw18em+YjFW4nPYOlNmZQ1eTgiRi4uDJQ5ekhm6r48j9JwU/ZzI7r/gAdR0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enuP1ePa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C858EC116C6;
	Mon, 23 Feb 2026 23:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889512;
	bh=h16x1XzjVSXNQ2WiwJZY34R1NW+M+Z0Yma6RETO4iFM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=enuP1ePaoOHXmUnX16v5V7NyEfFXvbvY9VggM1nSYtvhIbwoYIqVP3fEcf0+CRWfu
	 GIOPGddGdVNDrtP8iTqdF1Xp+LAIDykmsKXnJZm0kAMpl3yRbCyyzD257Vfe26x0vs
	 MoHeZPmqhAPWwf4Bv51ONOxrngEfoDvtAwEYLdn+EHHv7vyo/sFlBOHfpJtTAd1NjV
	 EBW2o0JBNXMJCTjHajw4gg1xgCyXQzcg2dGKsBaq3D+x4WuZg1Nv6ZtkTz5CxOvBqd
	 hKT85FD8mg1VEKJzRQDP5ZF6YQfkSviqSUcBLDj7pA+7a3x0xpB0/95kwI202Bx9CD
	 WrtryVGc4HRlg==
Date: Mon, 23 Feb 2026 15:31:52 -0800
Subject: [PATCH 25/25] libfuse: add upper-level filesystem freeze, thaw,
 and shutdown events
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740380.3940670.14838037135179850381.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78136-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: AB27517F94B
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Pass filesystem freeze, thaw, and shutdown requests from the low level
library to the upper level library so that those fuse servers can handle
the events.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |   15 +++++++++
 lib/fuse.c     |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index db4281e3f330c6..2f73d42672acdd 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -925,6 +925,21 @@ struct fuse_operations {
 	 */
 	int (*iomap_config) (uint64_t supported_flags, off_t maxbytes,
 			     struct fuse_iomap_config *cfg);
+
+	/**
+	 * Freeze the filesystem
+	 */
+	int (*freezefs) (const char *path, uint64_t unlinked_files);
+
+	/**
+	 * Thaw the filesystem
+	 */
+	int (*unfreezefs) (const char *path);
+
+	/**
+	 * Shut down the filesystem
+	 */
+	int (*shutdownfs) (const char *path, uint64_t flags);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 022888c475cb3d..2969e0f332045f 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2980,6 +2980,38 @@ static int fuse_fs_iomap_config(struct fuse_fs *fs, uint64_t flags,
 	return fs->op.iomap_config(flags, maxbytes, cfg);
 }
 
+static int fuse_fs_freezefs(struct fuse_fs *fs, const char *path,
+			    uint64_t unlinked)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.freezefs)
+		return -ENOSYS;
+	if (fs->debug)
+		fuse_log(FUSE_LOG_DEBUG, "freezefs[%s]\n", path);
+	return fs->op.freezefs(path, unlinked);
+}
+
+static int fuse_fs_unfreezefs(struct fuse_fs *fs, const char *path)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.unfreezefs)
+		return -ENOSYS;
+	if (fs->debug)
+		fuse_log(FUSE_LOG_DEBUG, "unfreezefs[%s]\n", path);
+	return fs->op.unfreezefs(path);
+}
+
+static int fuse_fs_shutdownfs(struct fuse_fs *fs, const char *path,
+			      uint64_t flags)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.shutdownfs)
+		return -ENOSYS;
+	if (fs->debug)
+		fuse_log(FUSE_LOG_DEBUG, "shutdownfs[%s]\n", path);
+	return fs->op.shutdownfs(path, flags);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4879,6 +4911,66 @@ static void fuse_lib_iomap_config(fuse_req_t req, uint64_t flags,
 	fuse_reply_iomap_config(req, &cfg);
 }
 
+static void fuse_lib_freezefs(fuse_req_t req, fuse_ino_t ino, uint64_t unlinked)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path(f, ino, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_freezefs(f->fs, path, unlinked);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, ino, path);
+	reply_err(req, err);
+}
+
+static void fuse_lib_unfreezefs(fuse_req_t req, fuse_ino_t ino)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path(f, ino, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_unfreezefs(f->fs, path);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, ino, path);
+	reply_err(req, err);
+}
+
+static void fuse_lib_shutdownfs(fuse_req_t req, fuse_ino_t ino, uint64_t flags)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path(f, ino, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_shutdownfs(f->fs, path, flags);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, ino, path);
+	reply_err(req, err);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4981,6 +5073,9 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.statx = fuse_lib_statx,
 #endif
 	.syncfs = fuse_lib_syncfs,
+	.freezefs = fuse_lib_freezefs,
+	.unfreezefs = fuse_lib_unfreezefs,
+	.shutdownfs = fuse_lib_shutdownfs,
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
 	.iomap_ioend = fuse_lib_iomap_ioend,


