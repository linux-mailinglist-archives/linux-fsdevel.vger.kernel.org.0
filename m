Return-Path: <linux-fsdevel+bounces-78128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Hv6HVPjnGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:31:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A20BE17F813
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 890383017A9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C6037F8B8;
	Mon, 23 Feb 2026 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN6X7TYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3437F728;
	Mon, 23 Feb 2026 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889388; cv=none; b=gMGSe8waAQsE/eN4vJEXl7xmsojwM9maqWIw7h759dk1tAbpJ+w5KI8QlNi43N5GpgYx9txUyyqKYgZ612xVbxMdDG6R5BJBYVd+KRyhneNLn7BOoT58GLapgmEcOzoaqVzMFuYYMkt8257BBFgYeb6wdQfQSgDrIsyFgnoCHxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889388; c=relaxed/simple;
	bh=gM3TePHJe+zFkamUmZu9cXxleEBbAth1KXFmz9i5pF4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iq7+0f3ohcsAFGfwBlfeEZCPZGrNDmBjbYghH1PTurSNZ0fNO/OYKi92CDmrr9fTYzKvvD8M8pxVXaP0Xj52H4dW2Tqx0rJdnZW9qedatxPF2hOzfHE8F37h8tKRk1GRjYGNgeS1nO/o6Yp6A9MGbU5tlJvkUuWai20abWWOdGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN6X7TYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEC4C116C6;
	Mon, 23 Feb 2026 23:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889387;
	bh=gM3TePHJe+zFkamUmZu9cXxleEBbAth1KXFmz9i5pF4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lN6X7TYRkAIR0QUZ7PAvpBKHyWWlxmkL1aujSPNo7Sn+4uWWfMzzPi4/20lC/EONt
	 a5aVObMnwmugZkxYSh1an+owA6TKi6ckMD4ptHsoQZvfKUHHmLB3fFjjmKRB1z+cUO
	 G0iPQiZDv6rxd6fhiBiVb5wWvt3pyarnSIlbMq35HvjGPDl6CFcgAEEDaNEWSx12pU
	 pJMlkiPUjYypo/H73nM5vbjHHhG00GDXLqJ+QsQFwrOZX1tYaTncvsrSS++yDwuGh0
	 MrUGIspGtKiwalcsRWvLPewjbowKNLUtxqF3joqwk4xh8LtuzliVeCq1sG4ec5Ag3a
	 wYh5GHUmVdb5g==
Date: Mon, 23 Feb 2026 15:29:47 -0800
Subject: [PATCH 17/25] libfuse: add upper level iomap_config implementation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740239.3940670.16287074551625853221.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78128-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: A20BE17F813
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add FUSE_IOMAP_CONFIG helpers to the upper level fuse library.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    7 +++++++
 lib/fuse.c     |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 817b3cf6c419c4..9f0ac44295e46f 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -918,6 +918,13 @@ struct fuse_operations {
 	 */
 	int (*getattr_iflags) (const char *path, struct stat *buf,
 			       unsigned int *iflags, struct fuse_file_info *fi);
+
+	/**
+	 * Configure the filesystem geometry that will be used by iomap
+	 * files.
+	 */
+	int (*iomap_config) (uint64_t supported_flags, off_t maxbytes,
+			     struct fuse_iomap_config *cfg);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 5d9acbc177a177..5301e34901bb3e 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2954,6 +2954,23 @@ static int fuse_fs_iomap_ioend(struct fuse_fs *fs, const char *path,
 				  ioendflags, error, dev, new_addr, newsize);
 }
 
+static int fuse_fs_iomap_config(struct fuse_fs *fs, uint64_t flags,
+				uint64_t maxbytes,
+				struct fuse_iomap_config *cfg)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_config)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_config flags 0x%llx maxbytes %lld\n",
+			 (unsigned long long)flags, (long long)maxbytes);
+	}
+
+	return fs->op.iomap_config(flags, maxbytes, cfg);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4834,6 +4851,25 @@ static void fuse_lib_iomap_ioend(fuse_req_t req, fuse_ino_t nodeid,
 	fuse_reply_iomap_ioend(req, newsize);
 }
 
+static void fuse_lib_iomap_config(fuse_req_t req, uint64_t flags,
+				  uint64_t maxbytes)
+{
+	struct fuse_iomap_config cfg = { };
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	int err;
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_config(f->fs, flags, maxbytes, &cfg);
+	fuse_finish_interrupt(f, req, &d);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_reply_iomap_config(req, &cfg);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4939,6 +4975,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
 	.iomap_ioend = fuse_lib_iomap_ioend,
+	.iomap_config = fuse_lib_iomap_config,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)


