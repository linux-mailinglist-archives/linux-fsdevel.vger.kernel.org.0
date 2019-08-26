Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9710B1395
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbfILR2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:28:54 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:7941 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387601AbfILR2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309333; x=1599845333;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=UiFv3SNJuY94P5tjOwzpJIDbJB9YBiEh3khbIHtxppM=;
  b=c1nhCo3+pYZdbcfGY6SwpfBYHOu6q/DfQuIC/MdCNIs1kkwuNu2efOKy
   DJGFZZzHNLvqTfqyMa2l+ZTRP/iqgsOMUCx/a4FftnqqavuebswD9jXLN
   vqQ5atiRfho7cZqtst/PuE/w+6T5iBI3MtbhMxUR0FZmppAH2eltJaP1m
   U=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="414961236"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id ABBCAA2B72;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D04UEA003.ant.amazon.com (10.43.61.177) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D04UEA003.ant.amazon.com (10.43.61.177) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:52 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E52E9C0574; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <f85e8d3bf54eb8308cc854e852b2368560fdb828.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 26 Aug 2019 22:06:38 +0000
Subject: [RFC PATCH 05/35] NFSv4.2: define a function to compute the maximum
 XDR size for listxattr
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RFC 8276 specifies the maximum return size of the LISTXATTRS operation
as the XDR-encoded size of the entire reply.

Define a function that computes the maximum needed XDR size (minus the
cookie and the attribute count, which are in the XDR buffer header), to
have an upper bound to check against.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs42.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 901cca7542f9..935651345be7 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -6,6 +6,10 @@
 #ifndef __LINUX_FS_NFS_NFS4_2_H
 #define __LINUX_FS_NFS_NFS4_2_H
 
+#ifdef CONFIG_NFS_V4_XATTR
+#include <linux/xattr.h>
+#endif
+
 /*
  * FIXME:  four LAYOUTSTATS calls per compound at most! Do we need to support
  * more? Need to consider not to pre-alloc too much for a compound.
@@ -24,4 +28,20 @@ int nfs42_proc_layouterror(struct pnfs_layout_segment *lseg,
 			   const struct nfs42_layout_error *errors,
 			   size_t n);
 
+#ifdef CONFIG_NFS_V4_XATTR
+/*
+ * Maximum XDR buffer size needed for a listxattr buffer of buflen size.
+ *
+ * The upper boundary is a buffer with all 1-byte sized attribute names.
+ * They would be 7 bytes long in the eventual buffer ("user.x\0"), and
+ * 8 bytes long XDR-encoded.
+ *
+ * Include the trailing eof word as well.
+ */
+static inline u32 nfs42_listxattr_xdrsize(u32 buflen)
+{
+	return ((buflen / (XATTR_USER_PREFIX_LEN + 2)) * 8) + 4;
+}
+#endif
+
 #endif /* __LINUX_FS_NFS_NFS4_2_H */
-- 
2.17.2

