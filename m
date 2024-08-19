Return-Path: <linux-fsdevel+bounces-26301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6539B9572E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0178DB24361
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01C18A930;
	Mon, 19 Aug 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HI3D85ER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB63018A926;
	Mon, 19 Aug 2024 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091492; cv=none; b=i4Juhm6ua9wViyccDrAaBms++CmtF3UW4n1cu30gF/oVm/QL1uH2oHj6yCnc4Cb8bLl5HhLt+gghUDc5PX8+VGy73iMdS4Tr98hwMZ1//MEfgc86T8n6ET/hkEO5mpAwUkMYK2IJgoGRoRdVQzhjaUtqlIt7ae13/z4WxioZ7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091492; c=relaxed/simple;
	bh=qmXxHYkAdwf8qjcIR3nGO4xhNDso/NdmI/3A86EOP3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krDLFMU8n5Zaw+PMTKlSJ8V0EDcRGY/2iE/wbyGNKfip0XajK0mH2p3NEnyElum44PzKgdJm+6cBd0/TiRnaFT1qmYdaEAmjjA9k4KZDvEXp/VFuqvXgdG5BpV9IshILrf/TomZfWGXJZne5bCqYAlbITI2CwDImxto7kVS/oJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HI3D85ER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A4BC4AF0F;
	Mon, 19 Aug 2024 18:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091492;
	bh=qmXxHYkAdwf8qjcIR3nGO4xhNDso/NdmI/3A86EOP3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HI3D85ER8l+Bm+luANxaur27jDlRXGWIMv248iFBY9NTlOenyvkGTqvwvy+e1hcr0
	 0NUsx8v3DRR7IRf3NEBpgETB8BkM84f1qChs4mT+67IZBbFtQwd16B9Bp+DElkHzn3
	 8GaeIXs0y3GEQm6ZZSRP/cpGJbQCwqDO+yvwqRtWU+pITzOBkL2LuBesSFGItRqcte
	 W6/U0bDQCB22dPaZf8mKv3iroAttsqdQgIFHLmRA274sXkXRrL8xeo0mYWIQi3y1OF
	 dCSG/SM2yMi/GZS7n4FQTEkwp4PulvBAAmJBVpt42KUafg0O7ZcgNGYZ+Pi1FsIQSu
	 SDjmcHD6HCTIA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 15/24] nfs: enable localio for non-pNFS IO
Date: Mon, 19 Aug 2024 14:17:20 -0400
Message-ID: <20240819181750.70570-16-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819181750.70570-1-snitzer@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
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
index c4160edd377e..1bd0224f7ee8 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -958,6 +958,12 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 	nfs_pgheader_init(desc, hdr, nfs_pgio_header_free);
 	ret = nfs_generic_pgio(desc, hdr);
 	if (ret == 0) {
+		struct nfs_client *clp = NFS_SERVER(hdr->inode)->nfs_client;
+
+		struct file *filp = nfs_local_file_open(clp, hdr->cred,
+							hdr->args.fh,
+							hdr->args.context);
+
 		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
 			task_flags = RPC_TASK_MOVEABLE;
 		ret = nfs_initiate_pgio(NFS_CLIENT(hdr->inode),
@@ -967,7 +973,7 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 					desc->pg_rpc_callops,
 					desc->pg_ioflags,
 					RPC_TASK_CRED_NOREF | task_flags,
-					NULL);
+					filp);
 	}
 	return ret;
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 8bc807a3e041..6436db54b2fc 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1795,6 +1795,7 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 		struct nfs_commit_info *cinfo)
 {
 	struct nfs_commit_data	*data;
+	struct file *filp;
 	unsigned short task_flags = 0;
 
 	/* another commit raced with us */
@@ -1811,9 +1812,12 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 	nfs_init_commit(data, head, NULL, cinfo);
 	if (NFS_SERVER(inode)->nfs_client->cl_minorversion)
 		task_flags = RPC_TASK_MOVEABLE;
+
+	filp = nfs_local_file_open(NFS_SERVER(inode)->nfs_client, data->cred,
+				   data->args.fh, data->context);
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how,
-				   RPC_TASK_CRED_NOREF | task_flags, NULL);
+				   RPC_TASK_CRED_NOREF | task_flags, filp);
 }
 
 /*
-- 
2.44.0


