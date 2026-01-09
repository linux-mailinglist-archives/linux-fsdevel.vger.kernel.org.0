Return-Path: <linux-fsdevel+bounces-73081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 742F9D0BD4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 19:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BDB430319DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 18:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B13D369238;
	Fri,  9 Jan 2026 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="eRX5T5zK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ED0368295;
	Fri,  9 Jan 2026 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767983240; cv=none; b=UBha72+Jcv2YPQHIh5bibT0pc3C8i41YZoOXPhIwgkZxYphZxpyZZI1l9uIKF57ZNsxek7azrQ6Pb8Wki6Gf2kWoEnwete2M+XcZu9Ou73ACiKmtYUHZezNiO2ugdWDEB87FEVekD4AAFmxtLJQRJJGCirs9VIqUDntp/11KuKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767983240; c=relaxed/simple;
	bh=9XfoZlR7RMZjQ1UPbGfMYcB3+CdY04U6bx6NDkzoIk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVzglZLRO9kEmvA2ZRmKsrrYA+HttZprd0/g1Hg8lEFSv2HFFLgvKrl3vQwpPOSWCRoFKiKruQ6FfbRRcug4YNZryw4net2KGAfaz/2FvHAHALjIzHrN4EUHXpA/tjk15n5gL/vCpaHb6xjQL/mbB3eSjW4vTT3HM1upmkEWHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=eRX5T5zK; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Received: from [127.0.1.1] (049-102-000-128.ip-addr.inexio.net [128.0.102.49])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 049AEE0214;
	Fri,  9 Jan 2026 19:27:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1767983229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cy8LGj4OUZMCQj7CBFMdH306bwkDHHxsxHmesfmRs/w=;
	b=eRX5T5zKfywyQWtEOr1+M6KTOm8YGCJtVhhyuoaEyp0FJORr8m4qIaHiE5yum58NT9gIsR
	pc7RJRBDemkzm4xlZhBmoF92zObMO3C6gmqYCSQSWDYc4iXP+UGCfiI72j86QQuHb4+V/X
	DGaeGwDVbj9KKniNqC8OunK1V9/aZniIiEfLYB/w70f7PwpxUvNvHH6rNaHTUuM7UG4KaG
	vl7T2zBOlio6aZcKdhpgbrhdxQfcqE83nVrpFkAf/2SdE8q725GCPCZoSCdLCV5fr1fNxm
	4QhnIZh/TrRR+PkzYQPtd3zAeJMqLOSuV9r5tJYuJ59oF48tZDk/GllUcjRe9g==
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Date: Fri, 09 Jan 2026 19:27:00 +0100
Subject: [PATCH v4 2/3] fuse: create helper functions for filling in fuse
 args for open and getattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-fuse-compounds-upstream-v4-2-0d3b82a4666f@ddn.com>
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
In-Reply-To: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
 Joanne Koong <joannelkoong@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767983227; l=3897;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=HDrL8KiO1FuGwP0s1BR0III0doQji3syVR6q/bqPCRc=;
 b=QZ07sEbv6UkeR39qY+ehjLw6iOxlFQI0+X4RDH319Sovewf4NNsY9FfEZbwobzwcBJ8Ojk5/p
 8OOH8Mn0OotDZt+R4R9rUerxKejsjMZeMPUbfpKZuLuU4wQMmnMBI2I
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

From: Horst Birthelmer <hbirthelmer@ddn.com>

create fuse_getattr_args_fill() and fuse_open_args_fill() to fill in
the parameters for the open and getattr calls.

This is in preparation for implementing open+getattr and does not
represent any functional change.

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
 fs/fuse/dir.c    |  9 +--------
 fs/fuse/file.c   | 42 ++++++++++++++++++++++++++++++++++--------
 fs/fuse/fuse_i.h |  8 ++++++++
 3 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4b6b3d2758ff..ca8b69282c60 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1493,14 +1493,7 @@ static int fuse_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
 		inarg.getattr_flags |= FUSE_GETATTR_FH;
 		inarg.fh = ff->fh;
 	}
-	args.opcode = FUSE_GETATTR;
-	args.nodeid = get_node_id(inode);
-	args.in_numargs = 1;
-	args.in_args[0].size = sizeof(inarg);
-	args.in_args[0].value = &inarg;
-	args.out_numargs = 1;
-	args.out_args[0].size = sizeof(outarg);
-	args.out_args[0].value = &outarg;
+	fuse_getattr_args_fill(&args, get_node_id(inode), &inarg, &outarg);
 	err = fuse_simple_request(fm, &args);
 	if (!err) {
 		if (fuse_invalid_attr(&outarg.attr) ||
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..53744559455d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -23,6 +23,39 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/iomap.h>
 
+/*
+ * Helper function to initialize fuse_args for OPEN/OPENDIR operations
+ */
+void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
+			 struct fuse_open_in *inarg, struct fuse_open_out *outarg)
+{
+	args->opcode = opcode;
+	args->nodeid = nodeid;
+	args->in_numargs = 1;
+	args->in_args[0].size = sizeof(*inarg);
+	args->in_args[0].value = inarg;
+	args->out_numargs = 1;
+	args->out_args[0].size = sizeof(*outarg);
+	args->out_args[0].value = outarg;
+}
+
+/*
+ * Helper function to initialize fuse_args for GETATTR operations
+ */
+void fuse_getattr_args_fill(struct fuse_args *args, u64 nodeid,
+			     struct fuse_getattr_in *inarg,
+			     struct fuse_attr_out *outarg)
+{
+	args->opcode = FUSE_GETATTR;
+	args->nodeid = nodeid;
+	args->in_numargs = 1;
+	args->in_args[0].size = sizeof(*inarg);
+	args->in_args[0].value = inarg;
+	args->out_numargs = 1;
+	args->out_args[0].size = sizeof(*outarg);
+	args->out_args[0].value = outarg;
+}
+
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
 			  struct fuse_open_out *outargp)
@@ -40,14 +73,7 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 		inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
 	}
 
-	args.opcode = opcode;
-	args.nodeid = nodeid;
-	args.in_numargs = 1;
-	args.in_args[0].size = sizeof(inarg);
-	args.in_args[0].value = &inarg;
-	args.out_numargs = 1;
-	args.out_args[0].size = sizeof(*outargp);
-	args.out_args[0].value = outargp;
+	fuse_open_args_fill(&args, nodeid, opcode, &inarg, outargp);
 
 	return fuse_simple_request(fm, &args);
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6dddbe2b027b..98ea41f76623 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1179,6 +1179,14 @@ struct fuse_io_args {
 void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
 			 size_t count, int opcode);
 
+/*
+ * Helper functions to initialize fuse_args for common operations
+ */
+void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
+			 struct fuse_open_in *inarg, struct fuse_open_out *outarg);
+void fuse_getattr_args_fill(struct fuse_args *args, u64 nodeid,
+			    struct fuse_getattr_in *inarg,
+			    struct fuse_attr_out *outarg);
 
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release);
 void fuse_file_free(struct fuse_file *ff);

-- 
2.51.0


