Return-Path: <linux-fsdevel+bounces-78184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA5LIbDmnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:45:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D849417FE90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E86D8315C5F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A959737FF5F;
	Mon, 23 Feb 2026 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3r+tKCz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FC937F8C5;
	Mon, 23 Feb 2026 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890250; cv=none; b=poaZQ6lM+k+qiVkvTrNMxJIT3iAJ6DffaO4aQ8KTATDIxIn6svIdVacT1bwN3eVWW62TENMj3PHyctEhiE1JWGOVpRGxxMYvnPxlba0Ms9gnEGwxREpmhDSd70o/97IrtQguTojGpG1MYc9kfHLvEAnPJFKWhT5chhnW96vEypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890250; c=relaxed/simple;
	bh=8Cwak69rpMbl8VI/O5IYVFu9get6FOU9zNxLmzHUDrg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3zbxbrKBJHxm3ay14lzwFwY7/3gSyveJX9rIdMBXRIC2r+dMIvJ0ounp07RGGFS9ivARvzKT/Co2GwWlGNcnyBumMOHzOwpWvgWyzXLMGi+74cb0S7wosEq4hzBogFHVM0TZQE0C7YHK/85VC8x97tlEoS+4yT+NRvvwT2JNGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3r+tKCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F79C116C6;
	Mon, 23 Feb 2026 23:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890249;
	bh=8Cwak69rpMbl8VI/O5IYVFu9get6FOU9zNxLmzHUDrg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=g3r+tKCz8TYVkvEq4E+naBwe4ssk5wqg2xlyzroko7e2LnyRkuI8n5exDsGxdZHo7
	 1uO6+MF+IOAjBvK/jkkUFOmap/FdKUDj0rwBTqDGmczUOLXs1ydN81CXPVu24z8FFd
	 4K/m+Lec3Fbgmn+FUqAuNCHeawq8Odh8q8atq5VONgT1bCPD3Yp/ejdcKKeS+flnfT
	 DaGHOUjdPe04mUDWQ8i9wM+sX935omHr9cjHhSi/zqnvAhugdNF/cLTz4NNtxnLLUB
	 jIoGiLkEbnXappe4DvDO8OxI36sWxXZvj56jIkbsOXXrW9dFX+E+9eJ+7Y26N2KlEQ
	 gkx9Pm+1GudKw==
Date: Mon, 23 Feb 2026 15:44:09 -0800
Subject: [PATCH 1/3] fuse2fs: enable caching of iomaps
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745511.3944453.6900210595156986351.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745484.3944453.12407213942915501693.stgit@frogsfrogsfrogs>
References: <177188745484.3944453.12407213942915501693.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78184-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: D849417FE90
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Cache the iomaps we generate in the kernel for better performance.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   31 +++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |   30 ++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 0f62d5a04fc4a4..d7238db25261dc 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -292,6 +292,8 @@ struct fuse4fs {
 #ifdef STATX_WRITE_ATOMIC
 	unsigned int awu_min, awu_max;
 #endif
+	/* options set by fuse_opt_parse must be of type int */
+	int iomap_cache;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -6890,6 +6892,30 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 	if (opflags & FUSE_IOMAP_OP_ATOMIC)
 		read.flags |= FUSE_IOMAP_F_ATOMIC_BIO;
 
+	/*
+	 * Cache the mapping in the kernel so that we can reuse them for
+	 * subsequent IO.
+	 */
+	if (ff->iomap_cache) {
+		ret = fuse_lowlevel_iomap_upsert_mappings(ff->fuse, fino, ino,
+							  &read, NULL);
+		if (ret) {
+			/*
+			 * Log the cache upsert error, but we can still return
+			 * the mapping via the reply.  EINVAL is the magic code
+			 * for the kernel declining to cache the mapping.
+			 */
+			if (ret != -ENOMEM && ret != -EINVAL)
+				translate_error(fs, ino, -ret);
+			goto out_unlock;
+		}
+
+		/* Tell the kernel to retry from cache */
+		read.type = FUSE_IOMAP_TYPE_RETRY_CACHE;
+		read.dev = FUSE_IOMAP_DEV_NULL;
+		read.addr = FUSE_IOMAP_NULL_ADDR;
+	}
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	if (ret)
@@ -7707,6 +7733,10 @@ static struct fuse_opt fuse4fs_opts[] = {
 #ifdef HAVE_CLOCK_MONOTONIC
 	FUSE4FS_OPT("timing",		timing,			1),
 #endif
+#ifdef HAVE_FUSE_IOMAP
+	FUSE4FS_OPT("iomap_cache",	iomap_cache,		1),
+	FUSE4FS_OPT("noiomap_cache",	iomap_cache,		0),
+#endif
 
 #ifdef HAVE_FUSE_IOMAP
 #ifdef MS_LAZYTIME
@@ -8119,6 +8149,7 @@ int main(int argc, char *argv[])
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
+		.iomap_cache = 1,
 #endif
 #ifdef HAVE_FUSE_LOOPDEV
 		.loop_fd = -1,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 58ea8e1f2f1e51..5a217b821c2d4a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -284,6 +284,8 @@ struct fuse2fs {
 #ifdef STATX_WRITE_ATOMIC
 	unsigned int awu_min, awu_max;
 #endif
+	/* options set by fuse_opt_parse must be of type int */
+	int iomap_cache;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -6444,6 +6446,29 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	if (opflags & FUSE_IOMAP_OP_ATOMIC)
 		read->flags |= FUSE_IOMAP_F_ATOMIC_BIO;
 
+	/*
+	 * Cache the mapping in the kernel so that we can reuse them for
+	 * subsequent IO.
+	 */
+	if (ff->iomap_cache) {
+		ret = fuse_fs_iomap_upsert(nodeid, attr_ino, read, NULL);
+		if (ret) {
+			/*
+			 * Log the cache upsert error, but we can still return
+			 * the mapping via the reply.  EINVAL is the magic code
+			 * for the kernel declining to cache the mapping.
+			 */
+			if (ret != -ENOMEM && ret != -EINVAL)
+				translate_error(fs, attr_ino, -ret);
+			goto out_unlock;
+		}
+
+		/* Tell the kernel to retry from cache */
+		read->type = FUSE_IOMAP_TYPE_RETRY_CACHE;
+		read->dev = FUSE_IOMAP_DEV_NULL;
+		read->addr = FUSE_IOMAP_NULL_ADDR;
+	}
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -7250,6 +7275,10 @@ static struct fuse_opt fuse2fs_opts[] = {
 #ifdef HAVE_CLOCK_MONOTONIC
 	FUSE2FS_OPT("timing",		timing,			1),
 #endif
+#ifdef HAVE_FUSE_IOMAP
+	FUSE2FS_OPT("iomap_cache",	iomap_cache,		1),
+	FUSE2FS_OPT("noiomap_cache",	iomap_cache,		0),
+#endif
 
 #ifdef HAVE_FUSE_IOMAP
 #ifdef MS_LAZYTIME
@@ -7530,6 +7559,7 @@ int main(int argc, char *argv[])
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
+		.iomap_cache = 1,
 #endif
 #ifdef HAVE_FUSE_LOOPDEV
 		.loop_fd = -1,


