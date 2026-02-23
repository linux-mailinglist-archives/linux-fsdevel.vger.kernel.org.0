Return-Path: <linux-fsdevel+bounces-78074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLtoFMrgnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:20:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E43B717F305
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30D9430E6C9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBB237F72D;
	Mon, 23 Feb 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE0YrQu7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4829E2749CF;
	Mon, 23 Feb 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888544; cv=none; b=dDXzsktpDF660LmU/eKPuzlaTfy/QjzvOOe4oXynoc3MYm0fvEj8xfA4UWrqA7JGqh7JbcCxdsGSMX3eEXXtBUC5GhtZo3ykMwe+am3MyDzY9v+6bh51oIfaDQUCt6P0M046/yGxrav/jdj9KBKG4DNiJIolF274Go8rNslWhGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888544; c=relaxed/simple;
	bh=Ct1ajVT8434NNmahoDJoCVghHagMeTbPvpydTEctfsg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzVszMhqNJPFrngQcZON8F+cfPjKlO9x5ywWPkxS6bqNoMyEBECeUdLdj93JoJGl43iqelyrxaOhCqdQ56Y1VG8sBdjcGJdV0M3JJVfoye/NFVmHAlqXmFWfPoyOfy9Jn1ZchCg68zEG2CFPNcaw3CfBrYI02Srk2JbRDEjcluM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE0YrQu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A49C116C6;
	Mon, 23 Feb 2026 23:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888544;
	bh=Ct1ajVT8434NNmahoDJoCVghHagMeTbPvpydTEctfsg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nE0YrQu7ko0injgrHFIKdsZXqztsOCIcppmsT066Y6NyFBd5apnoyrz3fTm0iiaz/
	 8bzh2O2WbbhKpCBHLfBb4Z7vzI+63kGdnJd4MGo0YcPVPjGS1RAToOSlyduAsVx3Yg
	 UIpLC13KWzl/3yksB2zTdxnDhCRNFdYD5TaSYXDbEoK90ngFHsYxDD7yi3I5rjxoPt
	 D3U80WzvkaJOfJn6dta7uBK8bOSQIkkuM1ljf9FEgfBh9uA9qJg9Pggdz7yA1Y7b1G
	 hBgMnxHAEsaex1eSdaI0P3B1zARTarvcovXtzXuIkTsvDA0jh/LksLHaaqDfWtA4q7
	 VMo9phHyWx2jA==
Date: Mon, 23 Feb 2026 15:15:43 -0800
Subject: [PATCH 27/33] fuse_trace: implement inline data file IO via iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734823.3935739.695254314492267481.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78074-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: E43B717F305
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    7 +++++++
 2 files changed, 52 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 0e4be645802055..d3352e75fa6bdf 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -230,6 +230,7 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 struct iomap_writepage_ctx;
 struct iomap_ioend;
+struct iomap;
 
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
@@ -1079,6 +1080,50 @@ TRACE_EVENT(fuse_iomap_dev_inval,
 		  __entry->offset,
 		  __entry->length)
 );
+
+DECLARE_EVENT_CLASS(fuse_iomap_inline_class,
+	TP_PROTO(const struct inode *inode, loff_t pos, uint64_t count,
+		 const struct iomap *map),
+	TP_ARGS(inode, pos, count, map),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		FUSE_IOMAP_MAP_FIELDS(map)
+		__field(bool,			has_buf)
+		__field(uint64_t,		validity_cookie)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	pos;
+		__entry->length		=	count;
+
+		__entry->mapdev		=	FUSE_IOMAP_DEV_NULL;
+		__entry->mapaddr	=	map->addr;
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+
+		__entry->has_buf	=	map->inline_data != NULL;
+		__entry->validity_cookie=	map->validity_cookie;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() FUSE_IOMAP_MAP_FMT() " has_buf? %d cookie 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map),
+		  __entry->has_buf,
+		  __entry->validity_cookie)
+);
+#define DEFINE_FUSE_IOMAP_INLINE_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_inline_class, name,	\
+	TP_PROTO(const struct inode *inode, loff_t pos, uint64_t count, \
+		 const struct iomap *map), \
+	TP_ARGS(inode, pos, count, map))
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_read);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 1c3d99f11634d2..6230819d0962a2 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -435,6 +435,8 @@ static int fuse_iomap_inline_read(struct inode *inode, loff_t pos,
 		return -EFSCORRUPTED;
 	}
 
+	trace_fuse_iomap_inline_read(inode, pos, count, iomap);
+
 	args.opcode = FUSE_READ;
 	args.nodeid = fi->nodeid;
 	args.in_numargs = 1;
@@ -480,6 +482,8 @@ static int fuse_iomap_inline_write(struct inode *inode, loff_t pos,
 	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
 		return -EFSCORRUPTED;
 
+	trace_fuse_iomap_inline_write(inode, pos, count, iomap);
+
 	args.opcode = FUSE_WRITE;
 	args.nodeid = fi->nodeid;
 	args.in_numargs = 2;
@@ -541,6 +545,9 @@ static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
 			return err;
 	}
 
+	trace_fuse_iomap_set_inline_iomap(inode, pos, count, iomap);
+	trace_fuse_iomap_set_inline_srcmap(inode, pos, count, srcmap);
+
 	return 0;
 }
 


