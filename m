Return-Path: <linux-fsdevel+bounces-78127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDd1CufinGnrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:29:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F93917F74B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A3713047037
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E032037F8A6;
	Mon, 23 Feb 2026 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H11gTJ4D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC637E300;
	Mon, 23 Feb 2026 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889372; cv=none; b=L8zMGHg+TWq/at814UI9QJRjL9XAx9th9i3eT0/VzBQOqy5itlm0oonX10BRTICD54OnAH1tUlVcJUN75jAIhCHOXK8qIQ3G1BSoooO9YQSHPuINNOYtR6TE8Eq4V1iSB8Ynd7vMlcloJMEuSnFJ0zoZH/W+I8HW3mIqeldIC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889372; c=relaxed/simple;
	bh=x3qd/zzR+E0ZNK8/Ds77fhNECH4VgmM3XFEbEapDD7g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTt6hkoUJTXeJPdE1bVZ4je8mEBDKl/YdEqtmHC1jj65GoxMCAzt0bnBmeSAnVrzIg4K6V3m9NA5SDD85GXgGcB9/aDEF7n8yaX4YANYI2ln3tvilGj1Z9qLVVWe/CUmgbd1GcBN1nxoySVa/guCSMh/tBl1e3+azsdIc3D3JgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H11gTJ4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E05DC116C6;
	Mon, 23 Feb 2026 23:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889372;
	bh=x3qd/zzR+E0ZNK8/Ds77fhNECH4VgmM3XFEbEapDD7g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=H11gTJ4DjWyPFaFjkLKsMLy6gINBJIHTFPr/x78z8GDyCqOCt4075eFd4i6jo2sYu
	 xeN4TqMIx6BCQx9QRn6BlryrOhTEUfVOmjWc17jz3GQ/KP9+Pm4KAEJxhAFcassW1w
	 ViveP7U4BVihkL4B8eiYekCK3nvjr5L4eQHHaaYspf0KzjoeeKjo8EyCmbmXSQ99xV
	 y6u951DkWAuU9nAYqi5UXt/Vc/V5DUr0dfxZoD3e3VLGtUmqcUaNOq/bR6CQusltsa
	 jGYLh3N5DklIiJNaeebQsN9IkknSQwlFLjL6mRNfDF+Sv+dwjz1J7vEnsn06M1SOgr
	 wSmLisokDLP7A==
Date: Mon, 23 Feb 2026 15:29:31 -0800
Subject: [PATCH 16/25] libfuse: add lower level iomap_config implementation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740221.3940670.13170101605049635687.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78127-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F93917F74B
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add FUSE_IOMAP_CONFIG helpers to the low level fuse library.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |   31 ++++++++++++++++++
 include/fuse_kernel.h   |   31 ++++++++++++++++++
 include/fuse_lowlevel.h |   27 +++++++++++++++
 lib/fuse_lowlevel.c     |   82 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    1 +
 5 files changed, 172 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index cce263aa62f5d0..2f6672fc14d90d 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1235,6 +1235,37 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 /* use iomap for this inode */
 #define FUSE_IFLAG_IOMAP		(1U << 2)
 
+/* Which fields are set in fuse_iomap_config_out? */
+#define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
+#define FUSE_IOMAP_CONFIG_UUID		(1 << 1ULL)
+#define FUSE_IOMAP_CONFIG_BLOCKSIZE	(1 << 2ULL)
+#define FUSE_IOMAP_CONFIG_MAX_LINKS	(1 << 3ULL)
+#define FUSE_IOMAP_CONFIG_TIME		(1 << 4ULL)
+#define FUSE_IOMAP_CONFIG_MAXBYTES	(1 << 5ULL)
+
+struct fuse_iomap_config{
+	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
+
+	char s_id[32];		/* Informational name */
+	char s_uuid[16];	/* UUID */
+
+	uint8_t s_uuid_len;	/* length of s_uuid */
+
+	uint8_t s_pad[3];	/* must be zeroes */
+
+	uint32_t s_blocksize;	/* fs block size */
+	uint32_t s_max_links;	/* max hard links */
+
+	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
+	uint32_t s_time_gran;
+
+	/* Time limits for c/m/atime in seconds */
+	int64_t s_time_min;
+	int64_t s_time_max;
+
+	int64_t s_maxbytes;	/* max file size */
+};
+
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
  * ----------------------------------------------------------- */
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 95c6c179a4398a..897d996a0ce60d 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -246,6 +246,7 @@
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
+ *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  */
 
 #ifndef _LINUX_FUSE_H
@@ -677,6 +678,7 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_IOMAP_CONFIG	= 4092,
 	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
@@ -1390,4 +1392,33 @@ struct fuse_iomap_ioend_out {
 	uint64_t newsize;	/* new ondisk size */
 };
 
+struct fuse_iomap_config_in {
+	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
+	int64_t maxbytes;	/* max supported file size */
+	uint64_t padding[6];	/* zero */
+};
+
+struct fuse_iomap_config_out {
+	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
+
+	char s_id[32];		/* Informational name */
+	char s_uuid[16];	/* UUID */
+
+	uint8_t s_uuid_len;	/* length of s_uuid */
+
+	uint8_t s_pad[3];	/* must be zeroes */
+
+	uint32_t s_blocksize;	/* fs block size */
+	uint32_t s_max_links;	/* max hard links */
+
+	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
+	uint32_t s_time_gran;
+
+	/* Time limits for c/m/atime in seconds */
+	int64_t s_time_min;
+	int64_t s_time_max;
+
+	int64_t s_maxbytes;	/* max file size */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index f31f250f13a965..a00b6d5a7fa0b6 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1425,6 +1425,20 @@ struct fuse_lowlevel_ops {
 			     uint64_t attr_ino, off_t pos, uint64_t written,
 			     uint32_t ioendflags, int error, uint32_t dev,
 			     uint64_t new_addr);
+
+	/**
+	 * Configure the filesystem geometry for iomap mode
+	 *
+	 * Valid replies:
+	 *   fuse_reply_iomap_config
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param flags FUSE_IOMAP_CONFIG_* flags that can be passed back
+	 * @param maxbytes maximum supported file size
+	 */
+	void (*iomap_config) (fuse_req_t req, uint64_t flags,
+			      uint64_t maxbytes);
 };
 
 /**
@@ -1927,6 +1941,19 @@ int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_file_iomap *read,
  */
 int fuse_reply_iomap_ioend(fuse_req_t req, off_t newsize);
 
+/**
+ * Reply with iomap configuration
+ *
+ * Possible requests:
+ *   iomap_config
+ *
+ * @param req request handle
+ * @param cfg iomap configuration
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_iomap_config(fuse_req_t req,
+			    const struct fuse_iomap_config *cfg);
+
 /* ----------------------------------------------------------- *
  * Notification						       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 4f3585f9a6841d..19f292c0cb8ee3 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2835,6 +2835,86 @@ static void do_iomap_ioend(fuse_req_t req, const fuse_ino_t nodeid,
 	_do_iomap_ioend(req, nodeid, inarg, NULL);
 }
 
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
+
+#define FUSE_IOMAP_CONFIG_V1 (FUSE_IOMAP_CONFIG_SID | \
+			      FUSE_IOMAP_CONFIG_UUID | \
+			      FUSE_IOMAP_CONFIG_BLOCKSIZE | \
+			      FUSE_IOMAP_CONFIG_MAX_LINKS | \
+			      FUSE_IOMAP_CONFIG_TIME | \
+			      FUSE_IOMAP_CONFIG_MAXBYTES)
+
+#define FUSE_IOMAP_CONFIG_ALL (FUSE_IOMAP_CONFIG_V1)
+
+static ssize_t iomap_config_reply_size(const struct fuse_iomap_config *cfg)
+{
+	if (cfg->flags & ~FUSE_IOMAP_CONFIG_ALL)
+		return -EINVAL;
+
+	return offsetofend(struct fuse_iomap_config_out, s_maxbytes);
+}
+
+int fuse_reply_iomap_config(fuse_req_t req, const struct fuse_iomap_config *cfg)
+{
+	struct fuse_iomap_config_out arg = {
+		.flags = cfg->flags,
+	};
+	const ssize_t reply_size = iomap_config_reply_size(cfg);
+
+	if (reply_size < 0)
+		fuse_reply_err(req, -reply_size);
+
+	if (cfg->flags & FUSE_IOMAP_CONFIG_BLOCKSIZE)
+		arg.s_blocksize = cfg->s_blocksize;
+
+	if (cfg->flags & FUSE_IOMAP_CONFIG_SID)
+		memcpy(arg.s_id, cfg->s_id, sizeof(arg.s_id));
+
+	if (cfg->flags & FUSE_IOMAP_CONFIG_UUID) {
+		arg.s_uuid_len = cfg->s_uuid_len;
+		if (arg.s_uuid_len > sizeof(arg.s_uuid))
+			arg.s_uuid_len = sizeof(arg.s_uuid);
+		memcpy(arg.s_uuid, cfg->s_uuid, arg.s_uuid_len);
+	}
+
+	if (cfg->flags & FUSE_IOMAP_CONFIG_MAX_LINKS)
+		arg.s_max_links = cfg->s_max_links;
+
+	if (cfg->flags & FUSE_IOMAP_CONFIG_TIME) {
+		arg.s_time_gran = cfg->s_time_gran;
+		arg.s_time_min = cfg->s_time_min;
+		arg.s_time_max = cfg->s_time_max;
+	}
+
+	if (cfg->flags & FUSE_IOMAP_CONFIG_MAXBYTES)
+		arg.s_maxbytes = cfg->s_maxbytes;
+
+	return send_reply_ok(req, &arg, reply_size);
+}
+
+static void _do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
+		      const void *op_in, const void *in_payload)
+{
+	(void)nodeid;
+	(void)in_payload;
+	const struct fuse_iomap_config_in *arg = op_in;
+
+	if (req->se->op.iomap_config)
+		req->se->op.iomap_config(req,
+					 arg->flags & FUSE_IOMAP_CONFIG_ALL,
+					 arg->maxbytes);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
+			    const void *inarg)
+{
+	_do_iomap_config(req, nodeid, inarg, NULL);
+}
+
 static bool want_flags_valid(uint64_t capable, uint64_t want)
 {
 	uint64_t unknown_flags = want & (~capable);
@@ -3821,6 +3901,7 @@ static struct {
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_SYNCFS]	   = { do_syncfs,      "SYNCFS"      },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
+	[FUSE_IOMAP_CONFIG]= { do_iomap_config, "IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
 	[FUSE_IOMAP_IOEND] = { do_iomap_ioend,	"IOMAP_IOEND" },
@@ -3881,6 +3962,7 @@ static struct {
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_SYNCFS]		= { _do_syncfs,		"SYNCFS" },
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
+	[FUSE_IOMAP_CONFIG]	= { _do_iomap_config,	"IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
 	[FUSE_IOMAP_IOEND]	= { _do_iomap_ioend,	"IOMAP_IOEND" },
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index f16698f3c4dbfa..14c59928ca9f00 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -245,6 +245,7 @@ FUSE_3.99 {
 		fuse_fs_can_enable_iomap;
 		fuse_fs_can_enable_iomapx;
 		fuse_lowlevel_discover_iomap;
+		fuse_reply_iomap_config;
 } FUSE_3.19;
 
 # Local Variables:


