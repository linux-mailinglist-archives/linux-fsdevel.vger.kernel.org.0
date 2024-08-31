Return-Path: <linux-fsdevel+bounces-28130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B69673C3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE501C20E27
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599E219007F;
	Sat, 31 Aug 2024 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc1U/VQ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D118FDD8;
	Sat, 31 Aug 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143903; cv=none; b=Ch/nftsbCXaw38El2Elg6aDWknEQ7k7L9Vmps3eBpK64d+h50az0W+NujkKV6pjmOwWWrs41EJX5Cj8JJqCF9TW6f05+zPKibEtXMf3YrFVlLzhJ8ta5+VYfjaT4SbBM9qTlC5KpTA6OmYr3f9zXPBcf2S93OauHd82bc5u6ryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143903; c=relaxed/simple;
	bh=cyb4dXp8y6v8xFHNGVCF2pLUXIq5d9rp5+7aaHSfH1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ie6R3BAv4iPzjK63gw+X4AiC5n1Ym1s7RD5Ab1/C2agsuZ2H9F82OK5A6DlHfh4/6AgkLBVmkadfjeBxFgdhJ+1L/KQohvK31l9fOHwd8PHRbXLzoI6+vx60TRlEFQkmMTbmGn32f1W62LOiiYLM6NBc+zhOK25LpjyNqbD2FCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc1U/VQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6ABC4CEC0;
	Sat, 31 Aug 2024 22:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143903;
	bh=cyb4dXp8y6v8xFHNGVCF2pLUXIq5d9rp5+7aaHSfH1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pc1U/VQ7QmkK1f1qC8rZJC1wW7zu6RW8PLgdoEB7ZVhUmuHy7nxt2JDwaF/5emrYO
	 p1zH/+am0aMcDN97/G6e9Dfklni0bnJac8Jz4TxrfDKdQDbVaruX1RssFcWOP5wxzo
	 6bI/RXVxwX3DYY/TDoxyVnELYgygG3cnIwNJKjC1wLsGs5NAUmTAYHXePlg7IPwQy5
	 IzGJ/XXfszAcYiuFAq1gfSmfjz0Q9AW/1gXEZ2S5N4u03iR5LTPG8/v7Xn4T9f56yY
	 MmXk4MD4EgNhALkHjx2qhm6WZI3hS6ROth+AUSEpdi1XBKBfdcSqtMfJcHWILsUKoC
	 ZKbKBMYdttTmg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 20/26] nfs: enable localio for non-pNFS IO
Date: Sat, 31 Aug 2024 18:37:40 -0400
Message-ID: <20240831223755.8569-21-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240831223755.8569-1-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
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
index 97d5524c379a..e27c07bd8929 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -958,6 +958,12 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 	nfs_pgheader_init(desc, hdr, nfs_pgio_header_free);
 	ret = nfs_generic_pgio(desc, hdr);
 	if (ret == 0) {
+		struct nfs_client *clp = NFS_SERVER(hdr->inode)->nfs_client;
+
+		struct nfsd_file *localio =
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
index 404cc5281e6a..de3cf5f971f4 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1795,6 +1795,7 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 		struct nfs_commit_info *cinfo)
 {
 	struct nfs_commit_data	*data;
+	struct nfsd_file *localio;
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


