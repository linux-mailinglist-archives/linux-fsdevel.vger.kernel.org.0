Return-Path: <linux-fsdevel+bounces-26973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C576D95D50D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047671C21312
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2252A194083;
	Fri, 23 Aug 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q016LlP/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82720193430;
	Fri, 23 Aug 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436884; cv=none; b=GCgh2iMl6JKpfsZ3vnuotQXLZgfSWxIyKXiEeN84QX4N3oD78qL+QynrFH4fJvX8CEAqnRQDHVtBwBsrdwbFKmEsFLIWfwZpY5agVZLYgbf28J8WQe7iGShv3Mr2xPawbu1/K2ydqccICuvnOUSWahhnhZmWZD6uichkjiuIWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436884; c=relaxed/simple;
	bh=TjHwTw4ml7BW9QW/OtxXp7ox5LW8mjsW8tpkB8xgLOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeGw37GBWseN9WOLJA6ouzoDxtqFCGaLerjerTMaF2g3QjXusRd/h2qgSEkR3/mEWhDsH39shoKGgA9R1enAbD/MBd5OqCvzY54bZor59arH/eN9CHfw+VkVb2tVIULSfVnYJN2khm6boi1zDuEl7kbP/jEkNffuqGyRKyeuwBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q016LlP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A27C4AF10;
	Fri, 23 Aug 2024 18:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436884;
	bh=TjHwTw4ml7BW9QW/OtxXp7ox5LW8mjsW8tpkB8xgLOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q016LlP/2RX9nAZam7NP2gFkEdd9D9XpUU3Xm6tR/9r95ISwwoWhzCRIyOxMYvGf2
	 ia9Z2ic8kFsza6/r9JNv8yHxcnVt5leVPu9jNqX6v++7fzPOd09IDJnvAFLeUBWUgK
	 mgT0xsml/ob1rF04jdoj4QFDlzEzw6IAPxk68iXapva13PLPFeXlLLLwgMOJyxPukO
	 DxT/IJHx4y8s7//kSlR3C5PCFW0vPDlSA4gPgOAW6qg6fO7apD4eSzlYO7zudItyX/
	 CYD7Wfcq4WDnpLksMEVub/mJbVpFB3vKafXGyfb7HzB+WPKftLWbIIRzt/cLWcacvs
	 2KzHFyVT+mqZg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 14/19] nfs: enable localio for non-pNFS IO
Date: Fri, 23 Aug 2024 14:14:12 -0400
Message-ID: <20240823181423.20458-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240823181423.20458-1-snitzer@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Try a local open of the file being written to, and if it succeeds,
then use localio to issue IO.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/pagelist.c | 8 +++++++-
 fs/nfs/write.c    | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 97d5524c379a..6f836b66ef79 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -958,6 +958,12 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 	nfs_pgheader_init(desc, hdr, nfs_pgio_header_free);
 	ret = nfs_generic_pgio(desc, hdr);
 	if (ret == 0) {
+		struct nfs_client *clp = NFS_SERVER(hdr->inode)->nfs_client;
+
+		struct nfsd_file *nf = nfs_local_file_open(clp, hdr->cred,
+							   hdr->args.fh,
+							   hdr->args.context);
+
 		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
 			task_flags = RPC_TASK_MOVEABLE;
 		ret = nfs_initiate_pgio(NFS_CLIENT(hdr->inode),
@@ -967,7 +973,7 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 					desc->pg_rpc_callops,
 					desc->pg_ioflags,
 					RPC_TASK_CRED_NOREF | task_flags,
-					NULL);
+					nf);
 	}
 	return ret;
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 404cc5281e6a..89a49a08bc90 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1795,6 +1795,7 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 		struct nfs_commit_info *cinfo)
 {
 	struct nfs_commit_data	*data;
+	struct nfsd_file *nf;
 	unsigned short task_flags = 0;
 
 	/* another commit raced with us */
@@ -1811,9 +1812,12 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 	nfs_init_commit(data, head, NULL, cinfo);
 	if (NFS_SERVER(inode)->nfs_client->cl_minorversion)
 		task_flags = RPC_TASK_MOVEABLE;
+
+	nf = nfs_local_file_open(NFS_SERVER(inode)->nfs_client, data->cred,
+				 data->args.fh, data->context);
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how,
-				   RPC_TASK_CRED_NOREF | task_flags, NULL);
+				   RPC_TASK_CRED_NOREF | task_flags, nf);
 }
 
 /*
-- 
2.44.0


