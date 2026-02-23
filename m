Return-Path: <linux-fsdevel+bounces-78110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBIoFoXinGnrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:28:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E517F681
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AE6B3173A8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FEF37F75B;
	Mon, 23 Feb 2026 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qECDZciX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAE2749CF;
	Mon, 23 Feb 2026 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889107; cv=none; b=WrprsZ6Xr57jIaCFlOtOscj3QdyY2plBu0gxQtof5ZSJ5SCUai08aLbdV0nNQnXUzmi/ExERcHM+STH02DfHFrkh9t3N7U1TPkqM17DhYqbzK7MprnRsTlLXF3CHlkFZBo7FRBBRfgtGnLLJIumM4TOqARk01DQIy1S6k75CMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889107; c=relaxed/simple;
	bh=wQWowouAFQMk5w6sCvGa/wihkeoEBOVM7T79u1LKwbU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fP9o4yNGPoS8HouU3faIhZGZbVW20DwFE8MekDfzSyc3ew0iT7HbPCnjHzpxLEv2OLd63B8v9RsRBxWMu/SWD+tpqC9KwaVDowJVfuSaAEEbtYZM8wE2xbzjsF91v5aM4+zhOoTZXSDCqvxA+3AskKH5D524+SCmRhO6I1ltpXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qECDZciX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC90C116C6;
	Mon, 23 Feb 2026 23:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889106;
	bh=wQWowouAFQMk5w6sCvGa/wihkeoEBOVM7T79u1LKwbU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qECDZciXyFFgQfwr9ZMgcGCMGxP+ODw9qi7+dqQWZFDuLOA3TCuyxTZwieqKA+CEe
	 UdOvKnGC+fgRJRCqBPXrtNluyBs4ikPYqXdocjJrUtsw0LlsRq5cq+VOBjI14ccVUV
	 AGORtBQcqdz8gqDmw6VW6IKHwGzU7DqyoWMIRJSkwMruOA+AcN8x4xUSCfbLd7P2Uk
	 wAPha5Sudr8AwvAObeqdzUkp8Nibii9tCjH5B1hWi2P4f4HMxCVORoMdivWlSU3LXA
	 ua5fMGp+L+JlBgb6+I+gP3pb4muoMdBct0lz5BB3pragTyo2FzRG0mg2nsiTQAfKb8
	 lETHQ7K4uGSBA==
Date: Mon, 23 Feb 2026 15:25:06 -0800
Subject: [PATCH 4/5] fuse: add kfuncs for iomap bpf programs to manage the
 cache
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, john@groves.net,
 bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <177188736880.3938194.6856727173434261882.stgit@frogsfrogsfrogs>
In-Reply-To: <177188736765.3938194.6770791688236041940.stgit@frogsfrogsfrogs>
References: <177188736765.3938194.6770791688236041940.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,groves.net,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78110-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outarg.read:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B22E517F681
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add a couple of kfuncs so that a BPF program that generates iomappings
can add them to the inode's mapping cache, thereby avoiding the need to
go into BPF program on the next access.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap_i.h   |    6 ++++
 fs/fuse/fuse_iomap.c     |    4 +-
 fs/fuse/fuse_iomap_bpf.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_iomap_i.h b/fs/fuse/fuse_iomap_i.h
index c37a7c5cfc862f..70c5a831dc9134 100644
--- a/fs/fuse/fuse_iomap_i.h
+++ b/fs/fuse/fuse_iomap_i.h
@@ -40,6 +40,12 @@ while (static_branch_unlikely(&fuse_iomap_debug)) {			\
 	unlikely(__cond);						\
 })
 #endif /* CONFIG_FUSE_IOMAP_DEBUG */
+
+int fuse_iomap_inval_inode(struct inode *inode,
+		const struct fuse_iomap_inval_mappings_out *outarg);
+int fuse_iomap_upsert_inode(struct inode *inode,
+		const struct fuse_iomap_upsert_mappings_out *outarg);
+
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_I_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 2e0c35e879ffcc..d2642eef59b779 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -2782,7 +2782,7 @@ fuse_iomap_upsert_validate_mappings(struct inode *inode,
 						  &outarg->write);
 }
 
-static int fuse_iomap_upsert_inode(struct inode *inode,
+int fuse_iomap_upsert_inode(struct inode *inode,
 		const struct fuse_iomap_upsert_mappings_out *outarg)
 {
 	int ret = fuse_iomap_upsert_validate_mappings(inode, outarg);
@@ -2877,7 +2877,7 @@ fuse_iomap_inval_validate_range(const struct inode *inode,
 	return true;
 }
 
-static int fuse_iomap_inval_inode(struct inode *inode,
+int fuse_iomap_inval_inode(struct inode *inode,
 		const struct fuse_iomap_inval_mappings_out *outarg)
 {
 	int ret = 0, ret2 = 0;
diff --git a/fs/fuse/fuse_iomap_bpf.c b/fs/fuse/fuse_iomap_bpf.c
index 13b5d4b96b66b5..71bfcddae7f5b7 100644
--- a/fs/fuse/fuse_iomap_bpf.c
+++ b/fs/fuse/fuse_iomap_bpf.c
@@ -6,9 +6,12 @@
  */
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
 
 #include "fuse_i.h"
 #include "fuse_dev_i.h"
+#include "fuse_iomap.h"
 #include "fuse_iomap_bpf.h"
 #include "fuse_iomap_i.h"
 #include "fuse_trace.h"
@@ -284,9 +287,82 @@ static struct bpf_struct_ops fuse_iomap_bpf_struct_ops = {
 	.owner		= THIS_MODULE,
 };
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int
+fuse_bpf_iomap_inval_mappings(struct fuse_inode *fi,
+			      const struct fuse_range *read__nullable,
+			      const struct fuse_range *write__nullable)
+{
+	struct fuse_iomap_inval_mappings_out outarg = {
+		.nodeid = fi->nodeid,
+		.attr_ino = fi->orig_ino,
+	};
+	struct inode *inode = &fi->inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (!fc->iomap)
+		return -EOPNOTSUPP;
+
+	if (read__nullable)
+		memcpy(&outarg.read, read__nullable, sizeof(outarg.read));
+	if (write__nullable)
+		memcpy(&outarg.write, write__nullable, sizeof(outarg.write));
+
+	trace_fuse_iomap_inval_mappings(inode, &outarg);
+
+	return fuse_iomap_inval_inode(inode, &outarg);
+}
+
+__bpf_kfunc int
+fuse_bpf_iomap_upsert_mappings(struct fuse_inode *fi,
+			       const struct fuse_iomap_io *read__nullable,
+			       const struct fuse_iomap_io *write__nullable)
+{
+	struct fuse_iomap_upsert_mappings_out outarg = {
+		.nodeid = fi->nodeid,
+		.attr_ino = fi->orig_ino,
+		.read.type = FUSE_IOMAP_TYPE_NOCACHE,
+		.write.type = FUSE_IOMAP_TYPE_NOCACHE,
+	};
+	struct inode *inode = &fi->inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (!fc->iomap)
+		return -EOPNOTSUPP;
+
+	if (read__nullable)
+		memcpy(&outarg.read, read__nullable, sizeof(outarg.read));
+	if (write__nullable)
+		memcpy(&outarg.write, write__nullable, sizeof(outarg.write));
+
+	trace_fuse_iomap_upsert_mappings(inode, &outarg);
+
+	return fuse_iomap_upsert_inode(inode, &outarg);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(fuse_iomap_kfunc_ids)
+BTF_ID_FLAGS(func, fuse_bpf_iomap_inval_mappings,
+	     KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, fuse_bpf_iomap_upsert_mappings,
+	     KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(fuse_iomap_kfunc_ids)
+
+static const struct btf_kfunc_id_set fuse_iomap_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &fuse_iomap_kfunc_ids,
+};
+
 /* Register the iomap bpf ops so that fuse servers can attach to it */
 int __init fuse_iomap_init_bpf(void)
 {
+	int ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+			&fuse_iomap_kfunc_set);
+	if (ret)
+		return ret;
+
 	return register_bpf_struct_ops(&fuse_iomap_bpf_struct_ops,
 				       fuse_iomap_bpf_ops);
 }


