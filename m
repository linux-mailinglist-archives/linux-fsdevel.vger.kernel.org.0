Return-Path: <linux-fsdevel+bounces-78098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBm6JB/hnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:22:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4447C17F391
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CAAF3027E11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3D237F750;
	Mon, 23 Feb 2026 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALgHzhmb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B237C11B;
	Mon, 23 Feb 2026 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888919; cv=none; b=ClmH8II/vmkSe7C9AU//kgZ0EF8XQnSXGtmmqv3XKTLKoJkp7E9UQGNQG+BVcl1j2f6bNXo4sijXGxSUoKTm0ZEKPG5+jrnMGxuzVTj2iHVNm6lbysUPtHkMA8DOetWUUnqerrG7LS8CvzyaNffXZUz/7tsvmQbdaJ6uv30+fqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888919; c=relaxed/simple;
	bh=QPuRVqOlCWk8giS5TGNNFPcU6Ccd8TtNCiu+PxL2PPE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihZh0ruHsLHotqqknYbUaTa0Ukcw47PaTMLDMy61cI6WRRO8RIfmFnL1+0Aos/bee4zXoBAnF5VCYYsjWGjIWe0Bnw+4kxzGx1Iwu7MUZy7Nc+s19xOF79J13q9kqYKMhNjl1FOMWvkVeRxQXw2PqGQ6ox4pWZGkjuz9k/BBLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALgHzhmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDC9C116C6;
	Mon, 23 Feb 2026 23:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888919;
	bh=QPuRVqOlCWk8giS5TGNNFPcU6Ccd8TtNCiu+PxL2PPE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ALgHzhmbcoCZpRkcggGLe8yc3HcAVn/ke2RuHcHRwcOxpbixKmcGx8v9pplqU8pHR
	 XgaoKM+oPoisMq8+6dmcj90dBcoYkDDQIqqbIX+s2YGL/QonmhwEQaqhO2x13XiZnv
	 rqcUQlaRwNkeBct9Uz9rOYjoM4PDLbrO7zFhAgwoILQY9RkzZRjSkMXIEOoToQKqvD
	 YOE1AhXGL6l2sgTthNad31+lvuBIGfFNNEyJdMVpo/jDKyWFZ09jUHt0gO+lbeCQE0
	 OLmmmI2vmon0VdrM09AlFiyIt9CvVNFGgNWdIu3v2HcDYf8YoTHaYF6THwfxkqPy17
	 KKUDSdzWrO6Cw==
Date: Mon, 23 Feb 2026 15:21:58 -0800
Subject: [PATCH 06/12] fuse_trace: invalidate iomap cache after file updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736155.3937557.10524653266467198313.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78098-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4447C17F391
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h       |   20 ++++++++++++++++++++
 fs/fuse/fuse_iomap.c       |    2 ++
 fs/fuse/fuse_iomap_cache.c |    2 ++
 3 files changed, 24 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index bf47008e50920a..ddcbefd33a4024 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -932,6 +932,7 @@ DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_up);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_down);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_punch_range);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_flush_unmap_range);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_cache_invalidate_range);
 
 TRACE_EVENT(fuse_iomap_end_ioend,
 	TP_PROTO(const struct iomap_ioend *ioend),
@@ -1248,6 +1249,25 @@ DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
 
+TRACE_EVENT(fuse_iomap_copied_file_range,
+	TP_PROTO(const struct inode *inode, loff_t offset,
+		 size_t written),
+	TP_ARGS(inode, offset, written),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	written;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
 DECLARE_EVENT_CLASS(fuse_iext_class,
 	TP_PROTO(const struct inode *inode, const struct fuse_iext_cursor *cur,
 		 int state, unsigned long caller_ip),
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 98e6db197a01d3..4bc2322a4ba796 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -2624,5 +2624,7 @@ void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 {
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_copied_file_range(inode, offset, written);
+
 	fuse_iomap_cache_invalidate_range(inode, offset, written);
 }
diff --git a/fs/fuse/fuse_iomap_cache.c b/fs/fuse/fuse_iomap_cache.c
index 4f30a27360b029..277311c7c0c4ea 100644
--- a/fs/fuse/fuse_iomap_cache.c
+++ b/fs/fuse/fuse_iomap_cache.c
@@ -1454,6 +1454,8 @@ int fuse_iomap_cache_invalidate_range(struct inode *inode, loff_t offset,
 	if (!fuse_inode_caches_iomaps(inode))
 		return 0;
 
+	trace_fuse_iomap_cache_invalidate_range(inode, offset, length);
+
 	aligned_offset = round_down(offset, blocksize);
 	if (length != FUSE_IOMAP_INVAL_TO_EOF) {
 		length += offset - aligned_offset;


