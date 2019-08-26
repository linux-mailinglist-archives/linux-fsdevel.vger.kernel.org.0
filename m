Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDDFB13F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfILRqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:46:02 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27366 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfILRp7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568310358; x=1599846358;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=Sdt5sp1epC3sAI9zltSbPQ8rCuqhEozsr8NHZP3mUaI=;
  b=ObCje/ZqsByoQzSeiNw+ImIRRpxhbWKle285mzSRr4ikJwC8QO5YH07L
   9WhCFaxAevBJOIEOqmD1xeTseFlGoBMA2UcxtDFx6grE09afvL7tHVP0s
   FRqikm5AC1lyKd14jKBIzP+6ctokZKszIhJDghj5cysOQzmqV/hMzybHr
   E=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="831156454"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Sep 2019 17:28:54 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 6835AA1DD1;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D27UWB003.ant.amazon.com (10.43.161.195) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D27UWB003.ant.amazon.com (10.43.161.195) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E2D34C056B; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <ff05d2ee117ef26cb7337942afffe9305cba4857.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 26 Aug 2019 22:23:25 +0000
Subject: [RFC PATCH 06/35] NFSv4.2: define and set initial limits for extended
 attributes
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Set limits for extended attributes (attribute value size and listxattr
buffer size), based on the fs-independent limits (XATTR_*_MAX).

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/client.c           | 17 +++++++++++++++--
 include/linux/nfs_fs_sb.h |  5 +++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 30838304a0bf..4a988787049c 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -50,6 +50,7 @@
 #include "nfs.h"
 #include "netns.h"
 #include "sysfs.h"
+#include "nfs42.h"
 
 #define NFSDBG_FACILITY		NFSDBG_CLIENT
 
@@ -733,7 +734,7 @@ static int nfs_init_server(struct nfs_server *server,
 static void nfs_server_set_fsinfo(struct nfs_server *server,
 				  struct nfs_fsinfo *fsinfo)
 {
-	unsigned long max_rpc_payload;
+	unsigned long max_rpc_payload, raw_max_rpc_payload;
 
 	/* Work out a lot of parameters */
 	if (server->rsize == 0)
@@ -746,7 +747,9 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 	if (fsinfo->wtmax >= 512 && server->wsize > fsinfo->wtmax)
 		server->wsize = nfs_block_size(fsinfo->wtmax, NULL);
 
-	max_rpc_payload = nfs_block_size(rpc_max_payload(server->client), NULL);
+	raw_max_rpc_payload = rpc_max_payload(server->client);
+	max_rpc_payload = nfs_block_size(raw_max_rpc_payload, NULL);
+
 	if (server->rsize > max_rpc_payload)
 		server->rsize = max_rpc_payload;
 	if (server->rsize > NFS_MAX_FILE_IO_SIZE)
@@ -779,6 +782,16 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 	server->clone_blksize = fsinfo->clone_blksize;
 	/* We're airborne Set socket buffersize */
 	rpc_setbufsize(server->client, server->wsize + 100, server->rsize + 100);
+
+#ifdef CONFIG_NFS_V4_XATTR
+	/*
+	 * Defaults until limited by the session parameters.
+	 */
+	server->gxasize = min_t(unsigned, raw_max_rpc_payload, XATTR_SIZE_MAX);
+	server->sxasize = min_t(unsigned, raw_max_rpc_payload, XATTR_SIZE_MAX);
+	server->lxasize = min_t(unsigned, raw_max_rpc_payload,
+				nfs42_listxattr_xdrsize(XATTR_LIST_MAX));
+#endif
 }
 
 /*
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 290d1c521226..db190a139d26 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -160,6 +160,11 @@ struct nfs_server {
 	unsigned int		dtsize;		/* readdir size */
 	unsigned short		port;		/* "port=" setting */
 	unsigned int		bsize;		/* server block size */
+#ifdef CONFIG_NFS_V4_XATTR
+	unsigned int		gxasize;	/* getxattr size */
+	unsigned int		sxasize;	/* setxattr size */
+	unsigned int		lxasize;	/* listxattr size */
+#endif
 	unsigned int		acregmin;	/* attr cache timeouts */
 	unsigned int		acregmax;
 	unsigned int		acdirmin;
-- 
2.17.2

