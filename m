Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB413B13E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfILRp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:45:56 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27357 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfILRp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568310354; x=1599846354;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=NmLTBSFSfN0Kc14Lq4ABT6agbmoEVyoUOQdFuD+onXs=;
  b=ZsGcIYUuuKnZ50D4k7UWEUiwvnwlKDW7pgEdscsvLonOGK6ANKE6BsEi
   ojSMX1BP+sM48DSyuAOpWl8xIrIuSmdqcCAjtnPhpg+PY9hFSU3oyhIeI
   FmZptlcddp/aNYBLKcGKCWsfiaWK25er5aWN08SAAXsr+PpNah5TbeQVA
   c=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="831156427"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 6E710A2132;
        Thu, 12 Sep 2019 17:28:51 +0000 (UTC)
Received: from EX13D19UEB003.ant.amazon.com (10.43.60.143) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.96) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D19UEB003.ant.amazon.com (10.43.60.143) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:50 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:50 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E10D8C056A; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <e7521ce2a3da3acde14fc54fa6ca4e4596b0e51b.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Fri, 30 Aug 2019 22:56:03 +0000
Subject: [RFC PATCH 15/35] nfs: make the buf_to_pages_noslab function
 available to the nfs code
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make the buf_to_pages_noslab function available to the rest of the NFS
code. Rename it to nfs4_buf_to_pages_noslab to be consistent.

This will be used later in the NFSv4.2 xattr code.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/internal.h | 3 +++
 fs/nfs/nfs4proc.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a1464bf8d178..75645d9ff10b 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -306,6 +306,9 @@ extern const u32 nfs42_maxlistxattrs_overhead;
 extern const struct rpc_procinfo nfs4_procedures[];
 #endif
 
+extern int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
+				    struct page **pages);
+
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 extern struct nfs4_label *nfs4_label_alloc(struct nfs_server *server, gfp_t flags);
 static inline struct nfs4_label *
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 30dd92d6e759..19d8fd087bf8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5453,7 +5453,7 @@ static inline int nfs4_server_supports_acls(struct nfs_server *server)
  */
 #define NFS4ACL_MAXPAGES DIV_ROUND_UP(XATTR_SIZE_MAX, PAGE_SIZE)
 
-static int buf_to_pages_noslab(const void *buf, size_t buflen,
+int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
 		struct page **pages)
 {
 	struct page *newpage, **spages;
@@ -5687,7 +5687,7 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t bufl
 		return -EOPNOTSUPP;
 	if (npages > ARRAY_SIZE(pages))
 		return -ERANGE;
-	i = buf_to_pages_noslab(buf, buflen, arg.acl_pages);
+	i = nfs4_buf_to_pages_noslab(buf, buflen, arg.acl_pages);
 	if (i < 0)
 		return i;
 	nfs4_inode_make_writeable(inode);
-- 
2.17.2

