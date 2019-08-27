Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0BFB13B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbfILR3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:12 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:6371 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387657AbfILR3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309350; x=1599845350;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=JMkvGmAhLWg/y+NV5rC4rx1Y69PlrlwOYvitXPDQCFU=;
  b=snpCTgDseER3rI6ezPMrFPdpHbpdE1a+v4zZ2bzlOePVmvf2QINxu39K
   8WdNGn6/Z+pBEr2iKxT3CKt9F2phJlvS23aQIF5qKPdwzYdgreQZVQIDN
   TzNdIp2Z8Ds0m1EI92APVOPjchFZSMqH/hLlRiNMVl7ip5wpjmZFQ4eV4
   c=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="702191779"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Sep 2019 17:28:58 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id A2E56C0837;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D14UEE001.ant.amazon.com (10.43.62.238) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D14UEE001.ant.amazon.com (10.43.62.238) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E3658C0557; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <ca85022779012228d7df42c5122c52b1afca1f8c.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Tue, 27 Aug 2019 16:01:06 +0000
Subject: [RFC PATCH 12/35] NFSv4.2: query the extended attribute access bits
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RFC 8276 defines seperate ACCESS bits for extended attribute checking.
Query them in nfs_do_access and opendata.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/dir.c      | 4 ++++
 fs/nfs/nfs4proc.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e7f4c25de362..78bc808addc9 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2498,6 +2498,10 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 	 * Determine which access bits we want to ask for...
 	 */
 	cache.mask = NFS_ACCESS_READ | NFS_ACCESS_MODIFY | NFS_ACCESS_EXTEND;
+	if (nfs_server_capable(inode, NFS_CAP_XATTR)) {
+		cache.mask |= NFS_ACCESS_XAREAD | NFS_ACCESS_XAWRITE |
+		    NFS_ACCESS_XALIST;
+	}
 	if (S_ISDIR(inode->i_mode))
 		cache.mask |= NFS_ACCESS_DELETE | NFS_ACCESS_LOOKUP;
 	else
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index dad22450546d..029b07fef37f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1313,6 +1313,12 @@ static struct nfs4_opendata *nfs4_opendata_alloc(struct dentry *dentry,
 				NFS4_ACCESS_MODIFY |
 				NFS4_ACCESS_EXTEND |
 				NFS4_ACCESS_EXECUTE;
+#ifdef CONFIG_NFS_V4_XATTR
+			if (server->caps & NFS_CAP_XATTR)
+				p->o_arg.access |= NFS4_ACCESS_XAREAD |
+				    NFS4_ACCESS_XAWRITE |
+				    NFS4_ACCESS_XALIST;
+#endif
 		}
 	}
 	p->o_arg.clientid = server->nfs_client->cl_clientid;
-- 
2.17.2

