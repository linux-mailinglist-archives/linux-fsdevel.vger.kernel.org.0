Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE6B13A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbfILR3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:02 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:7948 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387621AbfILR2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309335; x=1599845335;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=Z4E0AqIfFgbjUDhGUbLREjhsw6QurJUKx7DGtDCP9rU=;
  b=JXZ3hdC9vex37Egs8PjzkKnOgm2rtP+/96dniQzxlC+aKP7I5MQUBB9c
   ozkcf4sF7X3uQZCI2SnXphNz8z8KotiO7naB9X3dfh39ZIvluwBiGUINl
   aZkG6NVzRcdDJQmTK3Y7IcQm5GKeQAsvGcRQmVcy/yslVHaQSA7JIDoyO
   k=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="414961245"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Sep 2019 17:28:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 48631A3280;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:52 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E7B19C0581; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <26089a6ab4337ba6b5c39a6633e7cfac0cd12c2f.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 26 Aug 2019 22:32:34 +0000
Subject: [RFC PATCH 07/35] NFSv4.2: define argument and response structures
 for xattr operations
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define the argument and response structures that will be used for
RFC 8276 extended attribute RPC calls.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 include/linux/nfs_xdr.h | 61 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index f289c024943d..9299a2465c02 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1480,7 +1480,66 @@ struct nfs42_seek_res {
 	u32	sr_eof;
 	u64	sr_offset;
 };
-#endif
+
+#ifdef CONFIG_NFS_V4_XATTR
+struct nfs42_setxattrargs {
+	struct nfs4_sequence_args	seq_args;
+	struct nfs_fh *			fh;
+	const char *			xattr_name;
+	u32				xattr_flags;
+	size_t				xattr_len;
+	struct page **			xattr_pages;
+};
+
+struct nfs42_setxattrres {
+	struct nfs4_sequence_res	seq_res;
+	struct nfs4_change_info		cinfo;
+};
+
+struct nfs42_getxattrargs {
+	struct nfs4_sequence_args 	seq_args;
+	struct nfs_fh *			fh;
+	const char *			xattr_name;
+	size_t				xattr_len;
+	struct page **			xattr_pages;
+};
+
+struct nfs42_getxattrres {
+	struct nfs4_sequence_res	seq_res;
+	size_t				xattr_len;
+};
+
+struct nfs42_listxattrsargs {
+	struct nfs4_sequence_args	seq_args;
+	struct nfs_fh *			fh;
+	u32				count;
+	u64				cookie;
+	struct page **			xattr_pages;
+};
+
+struct nfs42_listxattrsres {
+	struct nfs4_sequence_res	seq_res;
+	struct page *			scratch;
+	void *				xattr_buf;
+	size_t				xattr_len;
+	u64				cookie;
+	bool				eof;
+	size_t				copied;
+};
+
+struct nfs42_removexattrargs {
+	struct nfs4_sequence_args	seq_args;
+	struct nfs_fh *			fh;
+	const char *			xattr_name;
+};
+
+struct nfs42_removexattrres {
+	struct nfs4_sequence_res	seq_res;
+	struct nfs4_change_info		cinfo;
+};
+
+#endif /* CONFIG_NFS_V4_XATTR */
+#endif /* CONFIG_NFS_V4_2 */
 
 struct nfs_page;
 
-- 
2.17.2

