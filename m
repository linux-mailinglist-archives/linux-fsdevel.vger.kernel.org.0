Return-Path: <linux-fsdevel+bounces-78090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBgwF53gnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:19:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A0217F2B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C7CC3006B41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD1837F746;
	Mon, 23 Feb 2026 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvsZr7+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B60037E307;
	Mon, 23 Feb 2026 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888794; cv=none; b=tYy3BA7jNvuDfFnU3Qut50vvrhflBwbH142kN8QRyBDYWM/hyeDGnxKYpMRKxD8G7T4P/LhavXXyJhGYFPZQZqXDtDrqQ7/zsL7XKlTPn+5M69w4RtwLPCi/Zaxom21TN7fQwVncXPcUj/oUxt24GDLpKlBz1EN+w+W82qOlvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888794; c=relaxed/simple;
	bh=PxnBPT3lVATjvUjGR5Uu9Jmhj6G1yu/SFl/DtNtPSQA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIOSeeIHC9VRClWFWM+ykLrzpE/lAd++sAW53Ys7jp61dnuuUk2FeZwnOJ3G/LKrRHfGnS2qdvmO6DriGrPVrpQFrX43cy2m2kuYqYwrck249m6bgqf5HV8jcDd1i8ioY3h1aOUYmTfXZRh2gqeOQqTxwN+Q64NGidLK9JSLw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvsZr7+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126F0C116C6;
	Mon, 23 Feb 2026 23:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888794;
	bh=PxnBPT3lVATjvUjGR5Uu9Jmhj6G1yu/SFl/DtNtPSQA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lvsZr7+nTRbR+DaHc1Fuc9XVpbpZ5UoJe4IeNWJLnMV6RLIBLa0LTPdkHJVVg+Zgt
	 sJSrejHHlHuBRxAli0HDOBeDK95Sxq/Q1trPMQ3BeBLmuw0LJYjp9XUAWHDxfV7jy5
	 VMH6TYSCkzSoWFBqG8d9esIX5bcQjESbyTsFEuS43NysThXzcaMUyc7afVM6xU0vLZ
	 dT5WP1p1Iq5Buqe5TF1/22yeYE6CpHmS9h141wXQzQ8AGVHRbQx962bCs6PLhdaj6n
	 nq3SYsbjxmlk+JLcPesMqDm8CG9vussvX0Se/pWZFNIJHS5nD33wrhU1KZ/3iCfQWQ
	 /9HVIcVru2/fg==
Date: Mon, 23 Feb 2026 15:19:53 -0800
Subject: [PATCH 7/9] fuse_trace: let the kernel handle KILL_SUID/KILL_SGID for
 iomap filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735675.3937167.17945823170576902491.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735474.3937167.17022266174919777880.stgit@frogsfrogsfrogs>
References: <177188735474.3937167.17022266174919777880.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78090-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 38A0217F2B3
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c        |    5 ++++
 2 files changed, 63 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 7136ecf25e1f2b..a6374d64a62357 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -208,6 +208,64 @@ DEFINE_EVENT(fuse_fileattr_class, name,		\
 DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_update_inode);
 DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_init);
 
+TRACE_EVENT(fuse_setattr_fill,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_setattr_in *inarg),
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(umode_t,		mode)
+		__field(uint32_t,		valid)
+		__field(umode_t,		new_mode)
+		__field(uint64_t,		new_size)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->mode		=	inode->i_mode;
+		__entry->valid		=	inarg->valid;
+		__entry->new_mode	=	inarg->mode;
+		__entry->new_size	=	inarg->size;
+	),
+
+	TP_printk(FUSE_INODE_FMT " mode 0%o valid 0x%x new_mode 0%o new_size 0x%llx",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->mode,
+		  __entry->valid,
+		  __entry->new_mode,
+		  __entry->new_size)
+);
+
+TRACE_EVENT(fuse_setattr,
+	TP_PROTO(const struct inode *inode,
+		 const struct iattr *inarg),
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(umode_t,		mode)
+		__field(uint32_t,		valid)
+		__field(umode_t,		new_mode)
+		__field(uint64_t,		new_size)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->mode		=	inode->i_mode;
+		__entry->valid		=	inarg->ia_valid;
+		__entry->new_mode	=	inarg->ia_mode;
+		__entry->new_size	=	inarg->ia_size;
+	),
+
+	TP_printk(FUSE_INODE_FMT " mode 0%o valid 0x%x new_mode 0%o new_size 0x%llx",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->mode,
+		  __entry->valid,
+		  __entry->new_mode,
+		  __entry->new_size)
+);
+
 #ifdef CONFIG_FUSE_BACKING
 #define FUSE_BACKING_FLAG_STRINGS \
 	{ FUSE_BACKING_TYPE_PASSTHROUGH,	"pass" }, \
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 069afade99d44f..4729137fddab30 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -8,6 +8,7 @@
 
 #include "fuse_i.h"
 #include "fuse_iomap.h"
+#include "fuse_trace.h"
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -2201,6 +2202,8 @@ static void fuse_setattr_fill(struct fuse_conn *fc, struct fuse_args *args,
 			      struct fuse_setattr_in *inarg_p,
 			      struct fuse_attr_out *outarg_p)
 {
+	trace_fuse_setattr_fill(inode, inarg_p);
+
 	args->opcode = FUSE_SETATTR;
 	args->nodeid = get_node_id(inode);
 	args->in_numargs = 1;
@@ -2482,6 +2485,8 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	if (!fuse_allow_current_process(get_fuse_conn(inode)))
 		return -EACCES;
 
+	trace_fuse_setattr(inode, attr);
+
 	if (!is_iomap &&
 	    (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))) {
 		attr->ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID |


