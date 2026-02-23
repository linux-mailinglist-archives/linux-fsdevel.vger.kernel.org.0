Return-Path: <linux-fsdevel+bounces-78152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJruIBLlnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:38:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A79CA17FAEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39FE1305D52C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACB637F8D5;
	Mon, 23 Feb 2026 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wqtbk8B1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5886E37F74C;
	Mon, 23 Feb 2026 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889763; cv=none; b=ES73ltQ51cLHBLXZcAiJjJUeEswofGCn32KgelB1ApH5glmRgfyAX6dYC+H3vXiGugTHsSeBArFoxoiBVVL+SVTqmN/1RE27adp6cYxDSv73TfVcRsvP3me25nttOEGUSVF6HFsclMKxrVxJfS5gO5mIQt93KTRH5kdcbljBs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889763; c=relaxed/simple;
	bh=oS2kaUkigRulX+GayJ4cuwaMnSZklZ1CobGvN5ipmwg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEGFAaxmmm6CZcHtMJVkZZp8eOJcE/oUvDAJEZORq77yI4MEOXg3S9iSW4cjL/vv5+BZBppwSf6TvhmVeuCXYgfWybtQ3OTr8yDmYe7gdraeptTP7aBDO7WXrPoLHq63Rrixm2WGeFrMOC3AvicTHdYotZC1ITeQtMJ2KqY33hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wqtbk8B1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD362C116C6;
	Mon, 23 Feb 2026 23:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889762;
	bh=oS2kaUkigRulX+GayJ4cuwaMnSZklZ1CobGvN5ipmwg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Wqtbk8B1vVHdD433F8rpAccKRGlxXB3PXrf5nIO+QcXOP9TVN//zLRlLIxlV3MF+U
	 gIiM7vJNxeAzfEIKjbmdXxsJX8ceMZXUCyg6rifQcaIaKx8FeTbX1GK5zvIl6utBHw
	 bnpbLN2LtLpy7pEGsTvsXs0OfMsZvXCbTRtsSvOhOK/M2+ltybmgLAuQrhHALcGmnj
	 +fhJ8BKHRmh+SWNl15wuJp1dmCs2iPlMRHIOWF/jhu3nxUE4gAsPYxH0qphCkiV8y0
	 9ect2K4kuwhMrI6+GfpH1qC3Vi/fb3xkOdCPhio5Ui5mzBxVeYOmdW7Y5ac/no5sgE
	 9488ZRO2QG42w==
Date: Mon, 23 Feb 2026 15:36:02 -0800
Subject: [PATCH 3/3] libfuse: make fuse_inode opaque to iomap bpf programs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, john@groves.net, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188741658.3942368.331389220194328774.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,groves.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-78152-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A79CA17FAEE
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Introduce an opaque type (and some casting helpers) for struct
fuse_inode.  This tricks BTF/BPF into thinking that the "inode" object
we pass to BPF programs is an empty structure, which means that the BPF
program cannot even look at the contents.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_iomap_bpf.h |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)


diff --git a/include/fuse_iomap_bpf.h b/include/fuse_iomap_bpf.h
index 1ff8f1831e12f6..ec2c3a1e5655af 100644
--- a/include/fuse_iomap_bpf.h
+++ b/include/fuse_iomap_bpf.h
@@ -164,12 +164,15 @@ enum fuse_iomap_bpf_ret {
 	FIB_HANDLED = 1,
 };
 
+/* opaque structure for calling bpf kfuncs */
+struct fuse_bpf_inode { };
+
 struct fuse_iomap_bpf_ops {
 	/**
 	 * @iomap_begin: override iomap_begin.  See FUSE_IOMAP_BEGIN for
 	 * details.
 	 */
-	enum fuse_iomap_bpf_ret (*iomap_begin)(struct fuse_inode *fi,
+	enum fuse_iomap_bpf_ret (*iomap_begin)(struct fuse_bpf_inode *fbi,
 			uint64_t pos, uint64_t count, uint32_t opflags,
 			struct fuse_iomap_begin_out *outarg);
 
@@ -177,7 +180,7 @@ struct fuse_iomap_bpf_ops {
 	 * @iomap_end: override iomap_end.  See FUSE_IOMAP_END for
 	 * details.
 	 */
-	enum fuse_iomap_bpf_ret (*iomap_end)(struct fuse_inode *fi,
+	enum fuse_iomap_bpf_ret (*iomap_end)(struct fuse_bpf_inode *fbi,
 			uint64_t pos, uint64_t count, int64_t written,
 			uint32_t opflags);
 
@@ -185,7 +188,7 @@ struct fuse_iomap_bpf_ops {
 	 * @iomap_ioend: override iomap_ioend.  See FUSE_IOMAP_IOEND for
 	 * details.
 	 */
-	enum fuse_iomap_bpf_ret (*iomap_ioend)(struct fuse_inode *fi,
+	enum fuse_iomap_bpf_ret (*iomap_ioend)(struct fuse_bpf_inode *fbi,
 			uint64_t pos, int64_t written, uint32_t ioendflags,
 			int error, uint32_t dev, uint64_t new_addr,
 			struct fuse_iomap_ioend_out *outarg);
@@ -213,19 +216,19 @@ struct fuse_iomap_bpf_ops {
 /* Macros to handle creating iomap_ops override functions */
 #define FUSE_IOMAP_BEGIN_BPF_FUNC(name) \
 SEC("struct_ops.s/iomap_begin") \
-enum fuse_iomap_bpf_ret BPF_PROG(name, struct struct fuse_inode *fi, \
+enum fuse_iomap_bpf_ret BPF_PROG(name, struct fuse_bpf_inode *fbi, \
 		uint64_t pos, uint64_t count, uint32_t opflags, \
 		struct fuse_iomap_begin_out *outarg)
 
 #define FUSE_IOMAP_END_BPF_FUNC(name) \
 SEC("struct_ops.s/iomap_end") \
-enum fuse_iomap_bpf_ret BPF_PROG(name, struct struct fuse_inode *fi, \
+enum fuse_iomap_bpf_ret BPF_PROG(name, struct fuse_bpf_inode *fbi, \
 		uint64_t pos, uint64_t count, int64_t written, \
 		uint32_t opflags)
 
 #define FUSE_IOMAP_IOEND_BPF_FUNC(name) \
 SEC("struct_ops.s/iomap_ioend") \
-enum fuse_iomap_bpf_ret BPF_PROG(name, struct struct fuse_inode *fi, \
+enum fuse_iomap_bpf_ret BPF_PROG(name, struct fuse_bpf_inode *fbi, \
 		uint64_t pos, int64_t written, uint32_t ioendflags, int error, \
 		uint32_t dev, uint64_t new_addr, \
 		struct fuse_iomap_ioend_out *outarg)
@@ -247,11 +250,14 @@ struct fuse_iomap_bpf_ops ops_name = { \
 }
 
 /* kfuncs; these require __ksym to link correctly! */
-int __ksym fuse_bpf_iomap_inval_mappings(struct fuse_inode *fi,
+int __ksym fuse_bpf_iomap_inval_mappings(struct fuse_bpf_inode *fbi,
 		const struct fuse_range *read__nullable,
 		const struct fuse_range *write__nullable);
-int __ksym fuse_bpf_iomap_upsert_mappings(struct fuse_inode *fi,
+int __ksym fuse_bpf_iomap_upsert_mappings(struct fuse_bpf_inode *fbi,
 		const struct fuse_iomap_io *read__nullable,
 		const struct fuse_iomap_io *write__nullable);
 
+uint64_t __ksym fuse_bpf_inode_nodeid(const struct fuse_bpf_inode *fbi);
+uint64_t __ksym fuse_bpf_inode_orig_ino(const struct fuse_bpf_inode *fbi);
+
 #endif /* FUSE_IOMAP_BPF_H_ */


