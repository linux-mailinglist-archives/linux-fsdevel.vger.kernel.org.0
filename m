Return-Path: <linux-fsdevel+bounces-77444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEpyJBb4lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:21:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED434151D69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DA96306146A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318F52F39A3;
	Tue, 17 Feb 2026 23:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alPWjTK9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF0296BA9;
	Tue, 17 Feb 2026 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370449; cv=none; b=OPdROF1OfmKMXpqF8oUrtVLsCP1XeLpA2FYAXVrOLRCFR0sqCE8j4+HqYAtIHrOffj7Eg4+4JHjGJ18j84nZ5WJOVoSs40K6U5zs3+NFVvmqWt3ARYfxBIU8S+Ft9lrqW6qQ3R6i7rZCGHSyU2qeezP3WKBT++jk5YcQL+cCOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370449; c=relaxed/simple;
	bh=qQBvMwYz4tTYdcpeO/q2O6IB2uqWdtO9oIMWTNGDwhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkfYFoIpO6RU3VHSE5e+lWD7xp7PbzLJQqdMYUzAJEhZeb7ZhnLduEvXm5pEcr9z904dO0jtEQlq7k/LAPKQe9/mHiiRCQD8vldZvMNcsqxIaUhovhulfy+5XV6NNhj4Kc2NH4oyIFiwPqbz+38k43eMVBTA9HBqx7+NXxM6kIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alPWjTK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3E7C19421;
	Tue, 17 Feb 2026 23:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370448;
	bh=qQBvMwYz4tTYdcpeO/q2O6IB2uqWdtO9oIMWTNGDwhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=alPWjTK95IRIPDze/frXYtjcbUV9gA7Gi8CPXKaViM+VZNOjntiwkGs/tCiu44kQD
	 EWKmx+e13/DTpeAtuMSQIXQmvlst8rAIJPZymJspOoPybMv8QzGJJaMXpnr0nk5dgX
	 mg4KU9uLnirivaWaHADCgHqQhuzj+peclVEQ6aBAnqhoUOVSSPqVtZEQe+fLLruvXw
	 qybnO0ryZ7Pr5Dj8tPz/XV4JII1/1iRlNLoClDZe8+BvFzjwEFBEGFM3qMxZirz6F4
	 3YFsIIF5ZTbxpTls3gRyTwq1JlrHdgWAVaLF70vPO0JMJqdq/KmEKp8AvhkmVwLX/G
	 7l/Bt6J6mpxAw==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 07/35] iomap: introduce IOMAP_F_FSVERITY
Date: Wed, 18 Feb 2026 00:19:07 +0100
Message-ID: <20260217231937.1183679-8-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260217231937.1183679-1-aalbersh@kernel.org>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77444-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED434151D69
X-Rspamd-Action: no action

Flag to indicate to iomap that write is happening beyond EOF and no
isize checks/update is needed.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 8 +++++---
 fs/iomap/trace.h       | 3 ++-
 include/linux/iomap.h  | 5 +++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ee7b845f5bc8..4cf9d0991dc1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -533,7 +533,8 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			return 0;
 
 		/* zero post-eof blocks as the page may be mapped */
-		if (iomap_block_needs_zeroing(iter, pos)) {
+		if (iomap_block_needs_zeroing(iter, pos) &&
+		    !(iomap->flags & IOMAP_F_FSVERITY)) {
 			folio_zero_range(folio, poff, plen);
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
@@ -1130,13 +1131,14 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 		 * unlock and release the folio.
 		 */
 		old_size = iter->inode->i_size;
-		if (pos + written > old_size) {
+		if (pos + written > old_size &&
+		    !(iter->iomap.flags & IOMAP_F_FSVERITY)) {
 			i_size_write(iter->inode, pos + written);
 			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
 		}
 		__iomap_put_folio(iter, write_ops, written, folio);
 
-		if (old_size < pos)
+		if (old_size < pos && !(iter->iomap.flags & IOMAP_F_FSVERITY))
 			pagecache_isize_extended(iter->inode, old_size, pos);
 
 		cond_resched();
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 532787277b16..5252051cc137 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -118,7 +118,8 @@ DEFINE_RANGE_EVENT(iomap_zero_iter);
 	{ IOMAP_F_ATOMIC_BIO,	"ATOMIC_BIO" }, \
 	{ IOMAP_F_PRIVATE,	"PRIVATE" }, \
 	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }, \
-	{ IOMAP_F_STALE,	"STALE" }
+	{ IOMAP_F_STALE,	"STALE" }, \
+	{ IOMAP_F_FSVERITY,	"FSVERITY" }
 
 
 #define IOMAP_DIO_STRINGS \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f0e3ed8ad6a6..94cf6241b37f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -87,6 +87,11 @@ struct vm_fault;
 #define IOMAP_F_INTEGRITY	0
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+/*
+ * IO happens beyound inode EOF, fsverity metadata is stored there
+ */
+#define IOMAP_F_FSVERITY	(1U << 10)
+
 /*
  * Flag reserved for file system specific usage
  */
-- 
2.51.2


