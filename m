Return-Path: <linux-fsdevel+bounces-78151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBD0HBPlnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:38:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D5917FAFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85FD03043AE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D0B37F8D3;
	Mon, 23 Feb 2026 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMp2gDkl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A2037BE9E;
	Mon, 23 Feb 2026 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889747; cv=none; b=O6AJWcQMi4hMsW5ylR4ufZxTHpj7/ineUoNZesFZ7Soy6cOsYIIhgZFtcdz8gZ+KQLpNLb0nR7GDxGWykqPq9zGAvuYz/qiB/7513SXu+JM2JdQKDkrB29ecd/k9ICmM26x6LrkRfqvsKIbOtdruOsfsl/M1kUJJfQaK3ZwsqaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889747; c=relaxed/simple;
	bh=h6tvK5T1dfhGuF62h6l4P20wwH40vraJC/qPo7MFVsI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+8q57T82xdPPFREDP2FN/uZYifQelgAyEM6ruQefSn1NElKQOI0eEqPjLbxdjUi4VEiQuCYUhDbEziPcpKRmvlpUxcu2HRueZeMyDyEsQm7J7Y/ObG90I3R+JsGB9Mx5mKqAGKgjCuHqHJI3DddaSV1CPl5eroQNynhzk6yqR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMp2gDkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A5BC116C6;
	Mon, 23 Feb 2026 23:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889747;
	bh=h6tvK5T1dfhGuF62h6l4P20wwH40vraJC/qPo7MFVsI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pMp2gDkl2D+LsSf7aMtfvdgqqX39E/iAVcd7yho2KbO8jkU6k6EvEhpwdXPPq6mLd
	 AvQKhZxiau7cU5yCylETErNDnvoi+4ShUBdBX9A7sUDxy5uMELTqeMogP6dTdzPh6D
	 A8tazkR1k16fdBRnJKZiXydpOzyXN21dpynKaqgIQ7GCeMeh6HlNNHru4wF1o0itZm
	 Q6dErSJaxgHtxTVgP7hIT4Q6QfCEC3FYXbGgY0vIDsc+Kal2wfWNtcdBdjftXX/pJW
	 Pzy+xW9GRl/SK1eHXUEGYOBcSRnBQjMEcv/sn93y8Bts653YX+Pvyesc6R+apVCOIW
	 /rXOaGY5wswzA==
Date: Mon, 23 Feb 2026 15:35:46 -0800
Subject: [PATCH 2/3] libfuse: add kfuncs for iomap bpf programs to manage the
 cache
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, john@groves.net, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188741641.3942368.9921708733362886047.stgit@frogsfrogsfrogs>
In-Reply-To: <177188741597.3942368.18114094782378370092.stgit@frogsfrogsfrogs>
References: <177188741597.3942368.18114094782378370092.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,groves.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-78151-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35D5917FAFB
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add a couple of kfuncs so that a BPF program that generates iomappings
can add them to the inode's mapping cache, thereby avoiding the need to
go into BPF program on the next access.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_iomap_bpf.h |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)


diff --git a/include/fuse_iomap_bpf.h b/include/fuse_iomap_bpf.h
index 3e69fb33cbdd7c..1ff8f1831e12f6 100644
--- a/include/fuse_iomap_bpf.h
+++ b/include/fuse_iomap_bpf.h
@@ -149,6 +149,14 @@ fuse_iomap_begin_pure_overwrite(struct fuse_iomap_begin_out *outarg)
 	outarg->write.dev = FUSE_IOMAP_DEV_NULL;
 }
 
+struct fuse_range {
+	uint64_t offset;
+	uint64_t length;
+};
+
+/* invalidate all cached iomap mappings up to EOF */
+#define FUSE_IOMAP_INVAL_TO_EOF		(~0ULL)
+
 enum fuse_iomap_bpf_ret {
 	/* fall back to fuse server upcall */
 	FIB_FALLBACK = 0,
@@ -204,20 +212,20 @@ struct fuse_iomap_bpf_ops {
 
 /* Macros to handle creating iomap_ops override functions */
 #define FUSE_IOMAP_BEGIN_BPF_FUNC(name) \
-SEC("struct_ops/iomap_begin") \
-enum fuse_iomap_bpf_ret BPF_PROG(name, struct fuse_inode *fi, \
+SEC("struct_ops.s/iomap_begin") \
+enum fuse_iomap_bpf_ret BPF_PROG(name, struct struct fuse_inode *fi, \
 		uint64_t pos, uint64_t count, uint32_t opflags, \
 		struct fuse_iomap_begin_out *outarg)
 
 #define FUSE_IOMAP_END_BPF_FUNC(name) \
-SEC("struct_ops/iomap_end") \
-enum fuse_iomap_bpf_ret BPF_PROG(name, struct fuse_inode *fi, \
+SEC("struct_ops.s/iomap_end") \
+enum fuse_iomap_bpf_ret BPF_PROG(name, struct struct fuse_inode *fi, \
 		uint64_t pos, uint64_t count, int64_t written, \
 		uint32_t opflags)
 
 #define FUSE_IOMAP_IOEND_BPF_FUNC(name) \
-SEC("struct_ops/iomap_ioend") \
-enum fuse_iomap_bpf_ret BPF_PROG(name, struct fuse_inode *fi, \
+SEC("struct_ops.s/iomap_ioend") \
+enum fuse_iomap_bpf_ret BPF_PROG(name, struct struct fuse_inode *fi, \
 		uint64_t pos, int64_t written, uint32_t ioendflags, int error, \
 		uint32_t dev, uint64_t new_addr, \
 		struct fuse_iomap_ioend_out *outarg)
@@ -238,4 +246,12 @@ struct fuse_iomap_bpf_ops ops_name = { \
 	.name		= fancy_name, \
 }
 
+/* kfuncs; these require __ksym to link correctly! */
+int __ksym fuse_bpf_iomap_inval_mappings(struct fuse_inode *fi,
+		const struct fuse_range *read__nullable,
+		const struct fuse_range *write__nullable);
+int __ksym fuse_bpf_iomap_upsert_mappings(struct fuse_inode *fi,
+		const struct fuse_iomap_io *read__nullable,
+		const struct fuse_iomap_io *write__nullable);
+
 #endif /* FUSE_IOMAP_BPF_H_ */


