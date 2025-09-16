Return-Path: <linux-fsdevel+bounces-61506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5ABB5894E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A652A4AAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AF51AA7BF;
	Tue, 16 Sep 2025 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNksD2Qa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE02C19EEC2;
	Tue, 16 Sep 2025 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982464; cv=none; b=ZkOeH+N3bC/i6V7JjjxEOloTwRVHErYTsSWE6ibgkwYo4I3ku1Kli/cHqnKANrTYEUDqC6ZBfScu79jAIEB+bATb0s16/WqVXe0J9iPpHs89KmrQskacjmuAKeo3us2zopUp5SsUtdtZaERO2ryeHMBVpozU4kL/UUqmWYuGKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982464; c=relaxed/simple;
	bh=6jUD3sytMsMYDBoNXJXmk7N91wL3yH093Th4YYOYO1Y=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxlgQKIzV/Eh/7y/fR6ZetUhPF2gkYMsUyxlay89NDVbbRiIoS00xUaAdadEn8KExC+BLD8hUBClgGpzxFEAbbz7OO861IzyLcQpfZorqCgoy/uKhDi8WOe01RvSed0tpccRb6XN5QLOWe9NvqU5tW6HGYof4QFc2g2GV7uVxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNksD2Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B66DC4CEF1;
	Tue, 16 Sep 2025 00:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982463;
	bh=6jUD3sytMsMYDBoNXJXmk7N91wL3yH093Th4YYOYO1Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kNksD2Qa8Pu0e8kh5ZNNxdKNGzQn+fHRHTixgOTiba3P+3UhlM/PY/TzJZqVtwGo1
	 pkQsrfQs0fRp8sotq1DJp2eRyttS2Bi8rNqZJFUZKRcBlbrufwB1ErG1gAXOjDw3f4
	 FBSjvRag8F8T1mqj2Dno4lbFgPVULeTw+zb4FrPVQpwuoFeZbukxEdqRGskSR3fQTb
	 s0cmrEpqnEo+OOxR7qYTBO+n6cbwqcUArTdWpYyEIEW1j83WzW20PZso9HPMwkcGqj
	 cCtQfqlkB2msHtAUB5OoecnVnNo/IFEAaKLP/AKIc3CCCwIzugeVao0mP6BP/YevHo
	 PIGSDYH1F8b/g==
Date: Mon, 15 Sep 2025 17:27:43 -0700
Subject: [PATCH 4/5] fuse_trace: move the passthrough-specific code back to
 passthrough.c
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798150795.382479.17399486562438456769.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs>
References: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs>
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
index da0dff288396ed..229c101ab46b0e 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -71,6 +71,7 @@ static int fuse_backing_id_free(int id, void *p, void *data)
 
 	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
 
+	trace_fuse_backing_close((struct fuse_conn *)data, id, fb);
 	fuse_backing_free(fb);
 	return 0;
 }
@@ -144,6 +145,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 		fb = NULL;
 		goto out;
 	}
+
+	trace_fuse_backing_open(fc, res, fb);
 out:
 	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
 
@@ -193,6 +196,8 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 	if (err)
 		goto out_fb;
 
+	trace_fuse_backing_close(fc, backing_id, fb);
+
 	err = -ENOENT;
 	test_fb = fuse_backing_id_remove(fc, backing_id);
 	if (!test_fb)


