Return-Path: <linux-fsdevel+bounces-78103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEQGBpXhnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:24:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CFE17F486
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07890303B7FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9A337F752;
	Mon, 23 Feb 2026 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdGmulIf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC5537C11B;
	Mon, 23 Feb 2026 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888997; cv=none; b=SRGc+A3IFex5ScFCH1zQGDiBk/gAsgl/CGGKREwvQ6cHX3alg9WjTZNLQCvrB97E14N2cYx+NmEW0Ii2RJywnMepdxQxRKF27gbdXksweUqLaiNWQS7HAyUNh/ZCo0yFhgc0QvqP6wdedQAljmzhWDxepRCnFmE3YYBtO81kM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888997; c=relaxed/simple;
	bh=mG3iPizIOmrw7jJfApiSc8snaCtOdT0X6oiHDKjYkEI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opf0otLabMm5m+0soYX+ZijbKB5ZpClY1tA05qOTfzT6pikABGeBsJA9+7vZaQQ1ufNp+ZgxZIho4u+kxVkIyk5CEXjGH9Q4KwsvQDcDapUlGNrY1cDlPgdYIodJCzl0X+YdXQJok5kz46Ye/dbkQh/hi3BohaCo/HKor/RK5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdGmulIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3749BC19421;
	Mon, 23 Feb 2026 23:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888997;
	bh=mG3iPizIOmrw7jJfApiSc8snaCtOdT0X6oiHDKjYkEI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cdGmulIfkIxqtrRHFKoLN862z4xYJXfojKmHn/nYGRohOAm4kVBjfp/QT7te86+fS
	 6AoI+zpc7yZFHnCcke5pMCsoQyHbVoSfYip2V2i26PE9yx1hWnSDTN/3eLhDU81Y12
	 K17LcMQ7U7RLCWdON0TMqkx8S1XxV2f58NDKyckMr3D/OcEHyKk7J5cOLa0eqytO3v
	 UlnqzM7xqb00QLkyRVZD6+dyZbR3X/DTXIfCJdmxzF2/djG+AQo/jnXkCbKSQCCAGE
	 WGvRSLvBTKlb5xjEzDUE+UJVVEz+6uOpZ86i5f7RpcKIfJIDfz5NEdLhcpj4iTeQf+
	 YFz5KxJuGeCHw==
Date: Mon, 23 Feb 2026 15:23:16 -0800
Subject: [PATCH 11/12] fuse_trace: constrain iomap mapping cache size
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736263.3937557.16005914923210569843.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735954.3937557.841478048197856035.stgit@frogsfrogsfrogs>
References: <177188735954.3937557.841478048197856035.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78103-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63CFE17F486
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h       |   31 +++++++++++++++++++++++++++++--
 fs/fuse/fuse_iomap_cache.c |    4 +++-
 2 files changed, 32 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 09da9bce61b98c..aa2d5ca88c9d40 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -320,6 +320,7 @@ struct iomap_ioend;
 struct iomap;
 struct fuse_iext_cursor;
 struct fuse_iomap_lookup;
+struct fuse_iext_root;
 
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
@@ -1157,6 +1158,8 @@ TRACE_EVENT(fuse_iomap_config,
 		__field(int64_t,		time_max)
 		__field(int64_t,		maxbytes)
 		__field(uint8_t,		uuid_len)
+
+		__field(uint32_t,		cache_maxbytes)
 	),
 
 	TP_fast_assign(
@@ -1170,14 +1173,15 @@ TRACE_EVENT(fuse_iomap_config,
 		__entry->time_max	=	outarg->s_time_max;
 		__entry->maxbytes	=	outarg->s_maxbytes;
 		__entry->uuid_len	=	outarg->s_uuid_len;
+		__entry->cache_maxbytes	=	outarg->cache_maxbytes;
 	),
 
-	TP_printk("connection %u root_ino 0x%llx flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
+	TP_printk("connection %u root_ino 0x%llx flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u cache_maxbytes %u",
 		  __entry->connection, __entry->root_nodeid,
 		  __print_flags(__entry->flags, "|", FUSE_IOMAP_CONFIG_STRINGS),
 		  __entry->blocksize, __entry->max_links, __entry->time_gran,
 		  __entry->time_min, __entry->time_max, __entry->maxbytes,
-		  __entry->uuid_len)
+		  __entry->uuid_len, __entry->cache_maxbytes)
 );
 
 TRACE_EVENT(fuse_iomap_dev_inval,
@@ -1395,6 +1399,29 @@ DEFINE_IEXT_ALT_UPDATE_EVENT(fuse_iext_del_mapping_got);
 DEFINE_IEXT_ALT_UPDATE_EVENT(fuse_iext_add_mapping_left);
 DEFINE_IEXT_ALT_UPDATE_EVENT(fuse_iext_add_mapping_right);
 
+TRACE_EVENT(fuse_iomap_cache_cleanup,
+	TP_PROTO(const struct inode *inode, unsigned int iodir,
+		 struct fuse_iext_root *ir),
+	TP_ARGS(inode, iodir, ir),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		FUSE_IOMAP_IODIR_FIELD
+		__field(unsigned long long,	bytes)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->iodir		=	iodir;
+		__entry->bytes		=	ir->ir_bytes;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() FUSE_IOMAP_IODIR_FMT " bytes 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  FUSE_IOMAP_IODIR_PRINTK_ARGS,
+		  __entry->bytes)
+);
+
 TRACE_EVENT(fuse_iomap_cache_remove,
 	TP_PROTO(const struct inode *inode, unsigned int iodir,
 		 loff_t offset, uint64_t length, unsigned long caller_ip),
diff --git a/fs/fuse/fuse_iomap_cache.c b/fs/fuse/fuse_iomap_cache.c
index b9e6083a18ce63..7f79ea4197e676 100644
--- a/fs/fuse/fuse_iomap_cache.c
+++ b/fs/fuse/fuse_iomap_cache.c
@@ -1672,8 +1672,10 @@ fuse_iomap_cache_cleanup(
 	struct fuse_mount	*fm = get_fuse_mount(inode);
 	struct fuse_iext_root	*ir = fuse_iext_root_ptr(fi->cache, iodir);
 
-	if (ir && ir->ir_bytes > fm->fc->iomap_conn.cache_maxbytes)
+	if (ir && ir->ir_bytes > fm->fc->iomap_conn.cache_maxbytes) {
+		trace_fuse_iomap_cache_cleanup(inode, iodir, ir);
 		fuse_iext_destroy(ir);
+	}
 }
 
 int


