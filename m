Return-Path: <linux-fsdevel+bounces-78100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDUkEzLinGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:26:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A495A17F5AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11A18316013F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1B137F742;
	Mon, 23 Feb 2026 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji5dlhyc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C863E37F74A;
	Mon, 23 Feb 2026 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888950; cv=none; b=CNV11R7ZTBHGee8+lDZUuF3COmjz4pgv6HJRz0iNfEtqrRSTgmL8wrl+3mKJ3Ez3NjcXmWFDd7U0MDdpipdA23BTVRH39cf99jm0/SWVmm+aGN0hCCkJUjO0G5CfQKk1tfp7HqgRVdtQMED9KEqOeukC0luvj6HKdb/uWzgRCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888950; c=relaxed/simple;
	bh=ZZZQazSgOR4OJkMb3zCKdMA24tfbzJXbIKU0w0EWFd0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+24SHG8FdH4fDAaFPkY3UjxxSff7dc6FpeCzxjulc5tpZb5HuM+Ftz9VIrU9qYbXOUSwWn5TXomDtAGpXp6pvq7KKUOtiCdPzVueKisfMVugvZpROd7xsS2IBVCvVkWYRPZvOA92zz/8NUKfArWa5B/HsLsqVAfJjRNp46YqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji5dlhyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF2BC116C6;
	Mon, 23 Feb 2026 23:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888950;
	bh=ZZZQazSgOR4OJkMb3zCKdMA24tfbzJXbIKU0w0EWFd0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Ji5dlhycn4aNnx2UeJzvrWozcaLZUU7xWW3HEPjjt4xK3JqQo1M4Xp8DFBI/Qbspw
	 Hpp9+jFGGw1VQLC4Ga2S9Mn4jL4/yL+zTNHlDWDlGEpQeHHNwHNmpzD8rIZihx+wUj
	 kDDA6tNJSwA2auvrINDSI5oH9QLrdkjTQlLNSAwEiBpG+1t4p/dXDkeW7q1/d86INZ
	 HP1bsY8buFcaDWOJMhhtfHqudnSpwY++rF7RQZXi3WK8IIzuaid/VxuzU50HaiaTHo
	 3O0bHsbs0TAuR6HAO2XlfxEhWALcmDjJOBkAXaiqqgqG8W7VPSq6bstDivIvSUU7Vi
	 sQA8oKiLT0lCg==
Date: Mon, 23 Feb 2026 15:22:29 -0800
Subject: [PATCH 08/12] fuse_trace: enable iomap cache management
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736199.3937557.17450789819615606834.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78100-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: A495A17F5AD
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    4 +++
 2 files changed, 71 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index ddcbefd33a4024..09da9bce61b98c 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -405,6 +405,7 @@ struct fuse_iomap_lookup;
 #define FUSE_IOMAP_TYPE_STRINGS \
 	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
 	{ FUSE_IOMAP_TYPE_RETRY_CACHE,		"retry" }, \
+	{ FUSE_IOMAP_TYPE_NOCACHE,		"nocache" }, \
 	{ FUSE_IOMAP_TYPE_HOLE,			"hole" }, \
 	{ FUSE_IOMAP_TYPE_DELALLOC,		"delalloc" }, \
 	{ FUSE_IOMAP_TYPE_MAPPED,		"mapped" }, \
@@ -1563,6 +1564,72 @@ TRACE_EVENT(fuse_iomap_invalid,
 		  __entry->old_validity_cookie,
 		  __entry->validity_cookie)
 );
+
+TRACE_EVENT(fuse_iomap_upsert_mappings,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_upsert_mappings_out *outarg),
+	TP_ARGS(inode, outarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(uint64_t,		attr_ino)
+
+		FUSE_IOMAP_MAP_FIELDS(read)
+		FUSE_IOMAP_MAP_FIELDS(write)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->attr_ino	=	outarg->attr_ino;
+		__entry->readoffset	=	outarg->read.offset;
+		__entry->readlength	=	outarg->read.length;
+		__entry->readaddr	=	outarg->read.addr;
+		__entry->readtype	=	outarg->read.type;
+		__entry->readflags	=	outarg->read.flags;
+		__entry->readdev	=	outarg->read.dev;
+		__entry->writeoffset	=	outarg->write.offset;
+		__entry->writelength	=	outarg->write.length;
+		__entry->writeaddr	=	outarg->write.addr;
+		__entry->writetype	=	outarg->write.type;
+		__entry->writeflags	=	outarg->write.flags;
+		__entry->writedev	=	outarg->write.dev;
+	),
+
+	TP_printk(FUSE_INODE_FMT " attr_ino 0x%llx" FUSE_IOMAP_MAP_FMT("read") FUSE_IOMAP_MAP_FMT("write"),
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->attr_ino,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(read),
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(write))
+);
+
+TRACE_EVENT(fuse_iomap_inval_mappings,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_inval_mappings_out *outarg),
+	TP_ARGS(inode, outarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(uint64_t,		attr_ino)
+
+		FUSE_FILE_RANGE_FIELDS(read)
+		FUSE_FILE_RANGE_FIELDS(write)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->attr_ino	=	outarg->attr_ino;
+		__entry->readoffset	=	outarg->read.offset;
+		__entry->readlength	=	outarg->read.length;
+		__entry->writeoffset	=	outarg->write.offset;
+		__entry->writelength	=	outarg->write.length;
+	),
+
+	TP_printk(FUSE_INODE_FMT " attr_ino 0x%llx" FUSE_FILE_RANGE_FMT("read") FUSE_FILE_RANGE_FMT("write"),
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->attr_ino,
+		  FUSE_FILE_RANGE_PRINTK_ARGS(read),
+		  FUSE_FILE_RANGE_PRINTK_ARGS(write))
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 478c11b90ad4aa..2e428b6e6b0ce6 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -2781,6 +2781,8 @@ int fuse_iomap_upsert_mappings(struct fuse_conn *fc,
 		goto out_sb;
 	}
 
+	trace_fuse_iomap_upsert_mappings(inode, outarg);
+
 	fi = get_fuse_inode(inode);
 	if (BAD_DATA(fi->orig_ino != outarg->attr_ino)) {
 		ret = -EINVAL;
@@ -2868,6 +2870,8 @@ int fuse_iomap_inval_mappings(struct fuse_conn *fc,
 		goto out_sb;
 	}
 
+	trace_fuse_iomap_inval_mappings(inode, outarg);
+
 	fi = get_fuse_inode(inode);
 	if (BAD_DATA(fi->orig_ino != outarg->attr_ino)) {
 		ret = -EINVAL;


