Return-Path: <linux-fsdevel+bounces-66002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC49BC179C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0671C67AC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30ED2D3220;
	Wed, 29 Oct 2025 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngxY0UE/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814D27B34F;
	Wed, 29 Oct 2025 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698698; cv=none; b=bOHksTpE5lcUbOr5mYwqlRSTDchRD/O1Q/fFOjQqN2WYA2V/GS3+hgt7+4Si/sSnv7RFo9XWxjZ4jlRgyLqbVXB4qkGscKOteYTVBy58J/ELmXohN/uLd/5JJ2FMbOoDSZAXk8Wg1kVJYFy3bgt70LkVRja4jHweh+UNkfnq8Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698698; c=relaxed/simple;
	bh=Eu4ngZFJ4JS+V40o8n1BI+FbwqxvEnyp/WWVJaumswE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVV+el+Gy5R54p75G8FzRbNDsdfiTjP5RqsUrwyhWEtCfYBqrRWe4bNlQUCW04W3osm8LnverTdb+kejbj/eCsgTjeVpngR3w3xEj8+AiOuWP9YzsUD0pt9NmnN5ODwgPhjurmfc95ajGAD/QUFXapgzIDP6//9vOHfoLcPxaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngxY0UE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE8FC4CEE7;
	Wed, 29 Oct 2025 00:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698697;
	bh=Eu4ngZFJ4JS+V40o8n1BI+FbwqxvEnyp/WWVJaumswE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ngxY0UE/ZZPT7QrRPHkAiAb4ZEjeaW5i+99/Cwus3jireb/WpuO/U2RXLrNNSxL/R
	 Ns/noP/K2ZeQ0qSiwALwd5LOR9Kk6dDVHXRa2MKc28eJvGQeZdverADq67dAWl6zVP
	 itG1YQFWt5WihSnzqcWhvvdjNY5jTo2DbFtL8hB4VEcM4Alp8e9A2H1i3ldGsyNnsm
	 x/xthSBM0625qnUBOYUKSZwO/1IcFGUeRDggu6exkwSPnns/UngsP1W6GyFFGZEti6
	 aTuHy10q+Xv7/GxtBt82wm6srD9eNqQflzrb56hUEliWEjQtMDf21yL0mg12UIjahW
	 aH/dWfzg+d0GA==
Date: Tue, 28 Oct 2025 17:44:57 -0700
Subject: [PATCH 2/2] fuse_trace: move the passthrough-specific code back to
 passthrough.c
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169809851.1424693.14006418302806790576.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809796.1424693.4820699158982303428.stgit@frogsfrogsfrogs>
References: <176169809796.1424693.4820699158982303428.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   35 +++++++++++++++++++++++++++++++++++
 fs/fuse/backing.c    |    5 +++++
 2 files changed, 40 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index bbe9ddd8c71696..286a0845dc0898 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -124,6 +124,41 @@ TRACE_EVENT(fuse_request_end,
 		  __entry->unique, __entry->len, __entry->error)
 );
 
+#ifdef CONFIG_FUSE_BACKING
+TRACE_EVENT(fuse_backing_class,
+	TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
+		 const struct fuse_backing *fb),
+
+	TP_ARGS(fc, idx, fb),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(unsigned int,		idx)
+		__field(unsigned long,		ino)
+	),
+
+	TP_fast_assign(
+		struct inode *inode = file_inode(fb->file);
+
+		__entry->connection	=	fc->dev;
+		__entry->idx		=	idx;
+		__entry->ino		=	inode->i_ino;
+	),
+
+	TP_printk("connection %u idx %u ino 0x%lx",
+		  __entry->connection,
+		  __entry->idx,
+		  __entry->ino)
+);
+#define DEFINE_FUSE_BACKING_EVENT(name)		\
+DEFINE_EVENT(fuse_backing_class, name,		\
+	TP_PROTO(const struct fuse_conn *fc, unsigned int idx, \
+		 const struct fuse_backing *fb), \
+	TP_ARGS(fc, idx, fb))
+DEFINE_FUSE_BACKING_EVENT(fuse_backing_open);
+DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
+#endif /* CONFIG_FUSE_BACKING */
+
 #endif /* _TRACE_FUSE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index f5efbffd0f456b..b83a3c1b2dff7a 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -72,6 +72,7 @@ static int fuse_backing_id_free(int id, void *p, void *data)
 
 	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
 
+	trace_fuse_backing_close((struct fuse_conn *)data, id, fb);
 	fuse_backing_free(fb);
 	return 0;
 }
@@ -145,6 +146,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 		fb = NULL;
 		goto out;
 	}
+
+	trace_fuse_backing_open(fc, res, fb);
 out:
 	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
 
@@ -194,6 +197,8 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 	if (err)
 		goto out_fb;
 
+	trace_fuse_backing_close(fc, backing_id, fb);
+
 	err = -ENOENT;
 	test_fb = fuse_backing_id_remove(fc, backing_id);
 	if (!test_fb)


