Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6648F26D697
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIQI3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 04:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIQI3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:29:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECB4C06174A;
        Thu, 17 Sep 2020 01:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=V+AxwQGWoIbqc8x7A3UXP9dSWRbh6BxB+DuWCl5hM/g=; b=h/YwUqRPHztumPo41cJ1tEtgz9
        MuDLUw61pdTBNB7NxT724bN3a9YeCXaM2ngSpQyPpsgR8yhrYvT+oi8RHjoUR0iJPH8w7Dh+PgTRm
        qy4hiUuCFsjN26N9ia32tAQLbBSeDaoPERk06Nms6kmhLZa0xeVNX3WuUK+PXKjihrTaDBMyBRLNc
        b51Nt9nGanfH7Gq8fUGjl3f/Sou0TimK2qSdbuvWzT1wspuA/UA2TQ5bLreG2F1vBStSrKmu5MxdM
        JRAJcDSJmpsJoOjHdgkfMNoeTnYc8jiM4ppZacZmMO69qmZmhcijc3giUcl0mRus7tiR4e7Q1yPZj
        Qsi1ghgA==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIpHz-0001N6-6u; Thu, 17 Sep 2020 08:29:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] fs,nfs: lift compat nfs4 mount data handling into the nfs code
Date:   Thu, 17 Sep 2020 10:22:33 +0200
Message-Id: <20200917082236.2518236-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917082236.2518236-1-hch@lst.de>
References: <20200917082236.2518236-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no reason the generic fs code should bother with NFS specific
binary mount data - lift the conversion into nfs4_parse_monolithic
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/compat.c         | 75 ---------------------------------------------
 fs/nfs/fs_context.c | 62 +++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 75 deletions(-)

diff --git a/fs/compat.c b/fs/compat.c
index 436d228cf71c09..9b00523d7fa571 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -19,73 +19,6 @@
 #include <linux/uaccess.h>
 #include "internal.h"
 
-struct compat_nfs_string {
-	compat_uint_t len;
-	compat_uptr_t data;
-};
-
-static inline void compat_nfs_string(struct nfs_string *dst,
-				     struct compat_nfs_string *src)
-{
-	dst->data = compat_ptr(src->data);
-	dst->len = src->len;
-}
-
-struct compat_nfs4_mount_data_v1 {
-	compat_int_t version;
-	compat_int_t flags;
-	compat_int_t rsize;
-	compat_int_t wsize;
-	compat_int_t timeo;
-	compat_int_t retrans;
-	compat_int_t acregmin;
-	compat_int_t acregmax;
-	compat_int_t acdirmin;
-	compat_int_t acdirmax;
-	struct compat_nfs_string client_addr;
-	struct compat_nfs_string mnt_path;
-	struct compat_nfs_string hostname;
-	compat_uint_t host_addrlen;
-	compat_uptr_t host_addr;
-	compat_int_t proto;
-	compat_int_t auth_flavourlen;
-	compat_uptr_t auth_flavours;
-};
-
-static int do_nfs4_super_data_conv(void *raw_data)
-{
-	int version = *(compat_uint_t *) raw_data;
-
-	if (version == 1) {
-		struct compat_nfs4_mount_data_v1 *raw = raw_data;
-		struct nfs4_mount_data *real = raw_data;
-
-		/* copy the fields backwards */
-		real->auth_flavours = compat_ptr(raw->auth_flavours);
-		real->auth_flavourlen = raw->auth_flavourlen;
-		real->proto = raw->proto;
-		real->host_addr = compat_ptr(raw->host_addr);
-		real->host_addrlen = raw->host_addrlen;
-		compat_nfs_string(&real->hostname, &raw->hostname);
-		compat_nfs_string(&real->mnt_path, &raw->mnt_path);
-		compat_nfs_string(&real->client_addr, &raw->client_addr);
-		real->acdirmax = raw->acdirmax;
-		real->acdirmin = raw->acdirmin;
-		real->acregmax = raw->acregmax;
-		real->acregmin = raw->acregmin;
-		real->retrans = raw->retrans;
-		real->timeo = raw->timeo;
-		real->wsize = raw->wsize;
-		real->rsize = raw->rsize;
-		real->flags = raw->flags;
-		real->version = raw->version;
-	}
-
-	return 0;
-}
-
-#define NFS4_NAME	"nfs4"
-
 COMPAT_SYSCALL_DEFINE5(mount, const char __user *, dev_name,
 		       const char __user *, dir_name,
 		       const char __user *, type, compat_ulong_t, flags,
@@ -111,14 +44,6 @@ COMPAT_SYSCALL_DEFINE5(mount, const char __user *, dev_name,
 	if (IS_ERR(options))
 		goto out2;
 
-	if (kernel_type && options) {
-		if (!strcmp(kernel_type, NFS4_NAME)) {
-			retval = -EINVAL;
-			if (do_nfs4_super_data_conv(options))
-				goto out3;
-		}
-	}
-
 	retval = do_mount(kernel_dev, dir_name, kernel_type, flags, options);
 
  out3:
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index cbf6a4ba5e5806..222afba70bc08e 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1039,6 +1039,65 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 }
 
 #if IS_ENABLED(CONFIG_NFS_V4)
+struct compat_nfs_string {
+	compat_uint_t len;
+	compat_uptr_t data;
+};
+
+static inline void compat_nfs_string(struct nfs_string *dst,
+				     struct compat_nfs_string *src)
+{
+	dst->data = compat_ptr(src->data);
+	dst->len = src->len;
+}
+
+struct compat_nfs4_mount_data_v1 {
+	compat_int_t version;
+	compat_int_t flags;
+	compat_int_t rsize;
+	compat_int_t wsize;
+	compat_int_t timeo;
+	compat_int_t retrans;
+	compat_int_t acregmin;
+	compat_int_t acregmax;
+	compat_int_t acdirmin;
+	compat_int_t acdirmax;
+	struct compat_nfs_string client_addr;
+	struct compat_nfs_string mnt_path;
+	struct compat_nfs_string hostname;
+	compat_uint_t host_addrlen;
+	compat_uptr_t host_addr;
+	compat_int_t proto;
+	compat_int_t auth_flavourlen;
+	compat_uptr_t auth_flavours;
+};
+
+static void nfs4_compat_mount_data_conv(struct nfs4_mount_data *data)
+{
+	struct compat_nfs4_mount_data_v1 *compat =
+			(struct compat_nfs4_mount_data_v1 *)data;
+
+	/* copy the fields backwards */
+	data->auth_flavours = compat_ptr(compat->auth_flavours);
+	data->auth_flavourlen = compat->auth_flavourlen;
+	data->proto = compat->proto;
+	data->host_addr = compat_ptr(compat->host_addr);
+	data->host_addrlen = compat->host_addrlen;
+	compat_nfs_string(&data->hostname, &compat->hostname);
+	compat_nfs_string(&data->mnt_path, &compat->mnt_path);
+	compat_nfs_string(&data->client_addr, &compat->client_addr);
+	data->acdirmax = compat->acdirmax;
+	data->acdirmin = compat->acdirmin;
+	data->acregmax = compat->acregmax;
+	data->acregmin = compat->acregmin;
+	data->retrans = compat->retrans;
+	data->timeo = compat->timeo;
+	data->wsize = compat->wsize;
+	data->rsize = compat->rsize;
+	data->flags = compat->flags;
+	data->version = compat->version;
+}
+
 /*
  * Validate NFSv4 mount options
  */
@@ -1061,6 +1120,9 @@ static int nfs4_parse_monolithic(struct fs_context *fc,
 	if (data->version != 1)
 		return generic_parse_monolithic(fc, data);
 
+	if (in_compat_syscall())
+		nfs4_compat_mount_data_conv(data);
+
 	if (data->host_addrlen > sizeof(ctx->nfs_server.address))
 		goto out_no_address;
 	if (data->host_addrlen == 0)
-- 
2.28.0

