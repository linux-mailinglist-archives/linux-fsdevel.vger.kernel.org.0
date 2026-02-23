Return-Path: <linux-fsdevel+bounces-78060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCfzNuTenGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:12:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E24817EFDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DBB43056B59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561B937F729;
	Mon, 23 Feb 2026 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWwFu9iI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A037C0F1;
	Mon, 23 Feb 2026 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888323; cv=none; b=TCejoJJngk7S9sNPf8XgmaTl9dy0iinvVqtbFxxxRQqLuF4Xds+HLFIDOJLFESyK63XB1GMvaUfiAPaWVCBI+4D/brNY1i1y7rw5+tRyausICxoJYrN6fTMX4Vqlo2GFYthgfGCwOyeUGnU7pEgG7JsUC8nj4hUvxYPBmbcX398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888323; c=relaxed/simple;
	bh=aoAVzwqJBSEZZkD3iyaUdNDfhY+4PgASCD+pmjVEzYs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sP/FWlgnUmB77Enu6ldrNmpP1ws28LATBsJWJUUntgOvvQ1P8F1PnM7mgXopSdqwFvNEgju+h3jfDUgF2xAlHHCzbjnaubwqqw/5WpvJ0y5A4bZ/G1KNSfqHt/S++N0MK00Kw/DtM7FggLhLlsfhk9i//bJBkbJtgvzYyQuwrRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWwFu9iI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9700C19421;
	Mon, 23 Feb 2026 23:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888323;
	bh=aoAVzwqJBSEZZkD3iyaUdNDfhY+4PgASCD+pmjVEzYs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nWwFu9iI1SEzrz/cKrTdKL3VGOeGeOmPMfl/baS5EZxaoGKkXN0cv5ImJxTcMFTDn
	 X3fv+bhMTGgN0MtIv63mqi6NotKO12N+tvNqoIN7CTfFuJqJ4+6dtSn5hR/md4mom6
	 KR4vyKy2BUg4Sj8mVtc7zC14Bmcng49nRwYuvDMwzwWNglqRiwWqUPsH8T7Wghvq1n
	 n/AEvFvlL16rnu/6QWRe6Sn36Oi4nxvxVhV09FcNfi8uatPIWt2jcEAE9tKlT6gugP
	 /hWxyml1s5KRrxZ+MHfzMTrWfd5QZ6yYWpKKF4XwYqDdDhzqQqZBZLMN0s7lbxbd69
	 ie5iauAoac1zw==
Date: Mon, 23 Feb 2026 15:12:03 -0800
Subject: [PATCH 13/33] fuse_trace: implement basic iomap reporting such as
 FIEMAP and SEEK_{DATA,HOLE}
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734523.3935739.7340978860882926386.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78060-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E24817EFDB
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    4 ++++
 2 files changed, 50 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index fac981e2a30df0..730ab8bce44450 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -532,6 +532,52 @@ DEFINE_EVENT(fuse_inode_state_class, name,	\
 	TP_ARGS(inode))
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
+
+TRACE_EVENT(fuse_iomap_fiemap,
+	TP_PROTO(const struct inode *inode, u64 start, u64 count,
+		unsigned int flags),
+
+	TP_ARGS(inode, start, count, flags),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned int,		flags)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	start;
+		__entry->length		=	count;
+		__entry->flags		=	flags;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT("fiemap") " flags 0x%x",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->flags)
+);
+
+TRACE_EVENT(fuse_iomap_lseek,
+	TP_PROTO(const struct inode *inode, loff_t offset, int whence),
+
+	TP_ARGS(inode, offset, whence),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(loff_t,			offset)
+		__field(int,			whence)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->whence		=	whence;
+	),
+
+	TP_printk(FUSE_INODE_FMT " offset 0x%llx whence %d",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->offset,
+		  __entry->whence)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 32ddf2fa6bdf78..be922888ae9e8a 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -693,6 +693,8 @@ int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
+	trace_fuse_iomap_fiemap(inode, start, count, fieinfo->fi_flags);
+
 	inode_lock_shared(inode);
 	error = iomap_fiemap(inode, fieinfo, start, count, &fuse_iomap_ops);
 	inode_unlock_shared(inode);
@@ -720,6 +722,8 @@ loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
+	trace_fuse_iomap_lseek(inode, offset, whence);
+
 	switch (whence) {
 	case SEEK_HOLE:
 		offset = iomap_seek_hole(inode, offset, &fuse_iomap_ops);


