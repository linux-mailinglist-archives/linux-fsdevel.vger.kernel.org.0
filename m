Return-Path: <linux-fsdevel+bounces-27733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A952A963777
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCF61C21CF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A451BF2B;
	Thu, 29 Aug 2024 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzQe37TJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427CD1C2A3;
	Thu, 29 Aug 2024 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893493; cv=none; b=BMUwqRZo4x1+fQTOG1Nki7dG7LnxVobJOvD55d39UPrmLkpbD0VGoflwPp5IN7iFEbGhxNXVUD9IzWG1rTKngTU6Vb7Id5omV0lnF0LEsNThTKSizVU0TI/zOjPeYwigK/Nqt2o3Zw0Wv8Y/IKAdM65HhqIhvzQooQefF+TSQb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893493; c=relaxed/simple;
	bh=ASfrnxZ+s4ELZO05ifUJqo/INsQRU+rD0AIlj6ZiV6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqWwdlsmE5QkMiTFrfC5Rs5DwFo0VaWB1r3Dw6x77khALxs9/F3K/rNAGLTyd+MbXGIGcMMANw9auiuEVMe/rg1LEBIiBmGXyVKgmvhHgpkG/WN18Z53VfX9pdsJK2ppR9jSUnoX6gqk99gnhSKHgkLixYYX42Rm0q4wv7Oii84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzQe37TJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DD3C4CEC0;
	Thu, 29 Aug 2024 01:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893492;
	bh=ASfrnxZ+s4ELZO05ifUJqo/INsQRU+rD0AIlj6ZiV6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HzQe37TJ3Dn70ELJEJi1+s4beGCnbBaVOlkGJSnu1JPBrP+mZ5A+KmQam8btI0vRg
	 JOH31/3BXmZvB05+mB/3/41O2hJmCI1/psmUOOuVw6WqAz96imb8BNCQQVZ6CCP0xR
	 VrAchvkVMT5dsJWJsl603HZyvfKHUexw/HVRtqxMkdHEUQGgi0OCaATDb/jGHgHWaT
	 04XE5J0sy6Mto5vH8EroodIOIfpDnyCm2CuvtBJKaeUpsZHPUFNOHwomlK1b4OUQoS
	 qw32ovYmCwMlPlFFJnAqnztU/NsUNiwpYmBfY/U5SVDwKY7NgrjX2aGGCVd/uVAxwR
	 uK8G+PxyU6J9Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 20/25] nfs: enable localio for non-pNFS IO
Date: Wed, 28 Aug 2024 21:04:15 -0400
Message-ID: <20240829010424.83693-21-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240829010424.83693-1-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
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
index cf68c0a61b7d..1ea5d079ab8c 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -958,6 +958,12 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 	nfs_pgheader_init(desc, hdr, nfs_pgio_header_free);
 	ret = nfs_generic_pgio(desc, hdr);
 	if (ret == 0) {
+		struct nfs_client *clp = NFS_SERVER(hdr->inode)->nfs_client;
+
+		struct nfs_localio_ctx *localio =
+			nfs_local_open_fh(clp, hdr->cred,
+					  hdr->args.fh, hdr->args.context->mode);
+
 		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
 			task_flags = RPC_TASK_MOVEABLE;
 		ret = nfs_initiate_pgio(NFS_CLIENT(hdr->inode),
@@ -967,7 +973,7 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 					desc->pg_rpc_callops,
 					desc->pg_ioflags,
 					RPC_TASK_CRED_NOREF | task_flags,
-					NULL);
+					localio);
 	}
 	return ret;
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 8bbbe8dace3b..b8e8d5d0bc47 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1795,6 +1795,7 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 		struct nfs_commit_info *cinfo)
 {
 	struct nfs_commit_data	*data;
+	struct nfs_localio_ctx *localio;
 	unsigned short task_flags = 0;
 
 	/* another commit raced with us */
@@ -1811,9 +1812,12 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 	nfs_init_commit(data, head, NULL, cinfo);
 	if (NFS_SERVER(inode)->nfs_client->cl_minorversion)
 		task_flags = RPC_TASK_MOVEABLE;
+
+	localio = nfs_local_open_fh(NFS_SERVER(inode)->nfs_client, data->cred,
+				    data->args.fh, data->context->mode);
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how,
-				   RPC_TASK_CRED_NOREF | task_flags, NULL);
+				   RPC_TASK_CRED_NOREF | task_flags, localio);
 }
 
 /*
-- 
2.44.0


