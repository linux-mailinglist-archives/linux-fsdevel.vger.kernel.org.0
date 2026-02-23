Return-Path: <linux-fsdevel+bounces-78096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI6RKS3hnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:22:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF2317F3A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E6C930288D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0137F74F;
	Mon, 23 Feb 2026 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6GwRIcb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B3837F743;
	Mon, 23 Feb 2026 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888888; cv=none; b=UsJeP9vmGddrEGE9yUB/MWvkmdAXe+Ic3QIbcUwcQOMOtQVUnWxe/oee/dlUunUuBAb+feP8Jt64GPbsIZjApQAjmQWNfaub+did4I3uJzcSgH3MFfNo/EiGnOQkI2dUmw6CPcCgv9bnFbEEnPdoivucOdHb/Szr0kN2dQoYOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888888; c=relaxed/simple;
	bh=D4QwgUjo++CUF0ezRu4D2B6YXQGYhR7Nw/61KbT3EsI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFjtBpVJO/ydy20SYrYw3Sg3d5Xct3tcr8LnQoarPiBkKzIViSMkaOFabY4tWKmLDMIXJSjtmYnKnlahtLmBk3oTjQdeb9tfZneJZgk9OoJXcgezlG1k9uPj7sc7hWfKu/skum0SRx7gkyL47ANMZ5q6GWFESKTBIqxejCOxLQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6GwRIcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED55DC116C6;
	Mon, 23 Feb 2026 23:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888888;
	bh=D4QwgUjo++CUF0ezRu4D2B6YXQGYhR7Nw/61KbT3EsI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=g6GwRIcbYB+ZdKLqcgSYW8kUirzCgh0Vdm7LrInsrEasy6qd6FJmqzSphEIQuu9Hx
	 Ao4j4EOg5CFY//T6hFYgPxCf8bJUD6FBaDXIHngnvIJH6AeJt0WTUGA97+vSZZb6pK
	 UhvhVw4lwBFcfU5tgdT6LDYqsVPv4tVl6kM2y3IKxoaALJKe0vDDIWdJvOBwAmhbIn
	 CV2uQzks3kFpTf3EWUFRKJuio7+x7DhIzgq3+084i2MWs5vODcXOtKJx4g6ooM6Wda
	 hcqHBEfhvlp2AbUX4iwS4mK1zdDqExN52NrR3Wj+Zprjm3FYbhs/l0OLPnN37rGPWv
	 aEKbwp3NR8X4w==
Date: Mon, 23 Feb 2026 15:21:27 -0800
Subject: [PATCH 04/12] fuse_trace: use the iomap cache for iomap_begin
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736112.3937557.17441402759595587551.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78096-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEF2317F3A7
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   34 ++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    7 ++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 697289c82d0dad..bf47008e50920a 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -404,6 +404,7 @@ struct fuse_iomap_lookup;
 
 #define FUSE_IOMAP_TYPE_STRINGS \
 	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
+	{ FUSE_IOMAP_TYPE_RETRY_CACHE,		"retry" }, \
 	{ FUSE_IOMAP_TYPE_HOLE,			"hole" }, \
 	{ FUSE_IOMAP_TYPE_DELALLOC,		"delalloc" }, \
 	{ FUSE_IOMAP_TYPE_MAPPED,		"mapped" }, \
@@ -1509,6 +1510,39 @@ TRACE_EVENT(fuse_iomap_cache_lookup_result,
 		  FUSE_IOMAP_MAP_PRINTK_ARGS(got),
 		  __entry->validity_cookie)
 );
+
+TRACE_EVENT(fuse_iomap_invalid,
+	TP_PROTO(const struct inode *inode, const struct iomap *map,
+		 uint64_t validity_cookie),
+	TP_ARGS(inode, map, validity_cookie),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		FUSE_IOMAP_MAP_FIELDS(map)
+		__field(uint64_t,		old_validity_cookie)
+		__field(uint64_t,		validity_cookie)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+		__entry->mapaddr	=	map->addr;
+		__entry->mapdev		=	FUSE_IOMAP_DEV_NULL;
+
+		__entry->old_validity_cookie=	map->validity_cookie;
+		__entry->validity_cookie=	validity_cookie;
+	),
+
+	TP_printk(FUSE_INODE_FMT FUSE_IOMAP_MAP_FMT() " old_cookie 0x%llx new_cookie 0x%llx",
+		  FUSE_INODE_PRINTK_ARGS,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map),
+		  __entry->old_validity_cookie,
+		  __entry->validity_cookie)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index b87ccc63ac81ed..59a2481f89626d 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1576,7 +1576,12 @@ static bool fuse_iomap_revalidate(struct inode *inode,
 		return true;
 
 	validity_cookie = fuse_iext_read_seq(fi->cache);
-	return iomap->validity_cookie == validity_cookie;
+	if (unlikely(iomap->validity_cookie != validity_cookie)) {
+		trace_fuse_iomap_invalid(inode, iomap, validity_cookie);
+		return false;
+	}
+
+	return true;
 }
 
 static const struct iomap_write_ops fuse_iomap_write_ops = {


