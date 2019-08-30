Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88C6B13A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbfILR27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:28:59 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:50464 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbfILR2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309334; x=1599845334;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=Fhp05V2eXGhrkdyW58/NUL6YsENXTu2GeQsbtF4lpyw=;
  b=Bb//noGACXg7GVVP7ZVvvwCOAtlqe9bQBuakAEM9OhOTS19dDzXQhsXT
   rF2DOkuApeFcLrG2Zv7rpEGMiMIgmRBO4Dpd/r3KtYCoRvtsD1uPeW7Fq
   Nw+NTjuOs96J9OvWeHmWywxC6gKEjM7u0D36pk4FXDAQy16ZZlS9zwgyq
   8=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="420869461"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 50A37A177F;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D03UWC004.ant.amazon.com (10.43.162.49) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D03UWC004.ant.amazon.com (10.43.162.49) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E3A06C053A; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <d6c681bfa00a527d1a48b42844fd414f95f65123.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Fri, 30 Aug 2019 23:15:10 +0000
Subject: [RFC PATCH 16/35] NFSv4.2: add the extended attribute proc functions.
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the extended attribute procedures for NFSv4.2 extended
attribute support (RFC 8276).

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs42.h     |   9 ++
 fs/nfs/nfs42proc.c | 242 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 251 insertions(+)

diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 935651345be7..96834d172269 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -29,6 +29,15 @@ int nfs42_proc_layouterror(struct pnfs_layout_segment *lseg,
 			   size_t n);
 
 #ifdef CONFIG_NFS_V4_XATTR
+
+ssize_t nfs42_proc_getxattr(struct inode *inode, const char *name,
+			void *buf, size_t buflen);
+int nfs42_proc_setxattr(struct inode *inode, const char *name,
+			const void *buf, size_t buflen, int flags);
+ssize_t nfs42_proc_listxattrs(struct inode *inode, void *buf,
+			  size_t buflen, u64 *cookiep, bool *eofp);
+int nfs42_proc_removexattr(struct inode *inode, const char *name);
+
 /*
  * Maximum XDR buffer size needed for a listxattr buffer of buflen size.
  *
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 5196bfa7894d..1c7081f35401 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -933,3 +933,245 @@ int nfs42_proc_clone(struct file *src_f, struct file *dst_f,
 	nfs_put_lock_context(src_lock);
 	return err;
 }
+
+#ifdef CONFIG_NFS_V4_XATTR
+
+#define NFS4XATTR_MAXPAGES DIV_ROUND_UP(XATTR_SIZE_MAX, PAGE_SIZE)
+
+static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct nfs42_removexattrargs args = {
+		.fh = NFS_FH(inode),
+		.xattr_name = name,
+	};
+	struct nfs42_removexattrres res;
+	struct rpc_message msg = {
+		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_REMOVEXATTR],
+		.rpc_argp = &args,
+		.rpc_resp = &res,
+	};
+	int ret;
+	unsigned long timestamp = jiffies;
+
+	ret = nfs4_call_sync(server->client, server, &msg, &args.seq_args,
+	    &res.seq_res, 1);
+	if (!ret)
+		nfs4_update_changeattr(inode, &res.cinfo, timestamp,
+		    NFS_INO_INVALID_XATTR);
+
+	return ret;
+}
+
+static int _nfs42_proc_setxattr(struct inode *inode, const char *name,
+				const void *buf, size_t buflen, int flags)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct page *pages[NFS4XATTR_MAXPAGES];
+	struct nfs42_setxattrargs arg = {
+		.fh		= NFS_FH(inode),
+		.xattr_pages	= pages,
+		.xattr_len	= buflen,
+		.xattr_name	= name,
+		.xattr_flags	= flags,
+	};
+	struct nfs42_setxattrres res;
+	struct rpc_message msg = {
+		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_SETXATTR],
+		.rpc_argp	= &arg,
+		.rpc_resp	= &res,
+	};
+	int ret, np;
+	unsigned long timestamp = jiffies;
+
+	if (buflen > server->sxasize)
+		return -ERANGE;
+
+	if (buflen > 0) {
+		np = nfs4_buf_to_pages_noslab(buf, buflen, arg.xattr_pages);
+		if (np < 0)
+			return np;
+	} else
+		np = 0;
+
+	ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
+	    &res.seq_res, 1);
+
+	for (; np > 0; np--)
+		put_page(pages[np - 1]);
+
+	if (!ret)
+		nfs4_update_changeattr(inode, &res.cinfo, timestamp,
+		    NFS_INO_INVALID_XATTR);
+
+	return ret;
+}
+
+static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
+				void *buf, size_t buflen)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct page *pages[NFS4XATTR_MAXPAGES] = {};
+	struct nfs42_getxattrargs arg = {
+		.fh		= NFS_FH(inode),
+		.xattr_pages	= pages,
+		.xattr_len	= buflen,
+		.xattr_name	= name,
+	};
+	struct nfs42_getxattrres res;
+	struct rpc_message msg = {
+		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_GETXATTR],
+		.rpc_argp	= &arg,
+		.rpc_resp	= &res,
+	};
+	int ret, np;
+
+	ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
+	    &res.seq_res, 0);
+	if (ret < 0)
+		return ret;
+
+	if (buflen) {
+		if (res.xattr_len > buflen)
+			return -ERANGE;
+		_copy_from_pages(buf, pages, 0, res.xattr_len);
+	}
+
+	np = DIV_ROUND_UP(res.xattr_len, PAGE_SIZE);
+	while (--np >= 0)
+		__free_page(pages[np]);
+
+	return res.xattr_len;
+}
+
+static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
+				 size_t buflen, u64 *cookiep, bool *eofp)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct page **pages;
+	struct nfs42_listxattrsargs arg = {
+		.fh		= NFS_FH(inode),
+		.cookie		= *cookiep,
+	};
+	struct nfs42_listxattrsres res = {
+		.eof = false,
+		.xattr_buf = buf,
+		.xattr_len = buflen,
+	};
+	struct rpc_message msg = {
+		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_LISTXATTRS],
+		.rpc_argp	= &arg,
+		.rpc_resp	= &res,
+	};
+	u32 xdrlen;
+	int ret, np;
+
+
+	res.scratch = alloc_page(GFP_KERNEL);
+	if (!res.scratch)
+		return -ENOMEM;
+
+	xdrlen = nfs42_listxattr_xdrsize(buflen);
+	if (xdrlen > server->lxasize)
+		xdrlen = server->lxasize;
+	np = xdrlen / PAGE_SIZE + 1;
+
+	pages = kzalloc(np * sizeof (struct page *), GFP_KERNEL);
+	if (pages == NULL) {
+		__free_page(res.scratch);
+		return -ENOMEM;
+	}
+
+	arg.xattr_pages = pages;
+	arg.count = xdrlen;
+
+	ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
+	    &res.seq_res, 0);
+
+	if (ret >= 0) {
+		ret = res.copied;
+		*cookiep = res.cookie;
+		*eofp = res.eof;
+	}
+
+	while (--np >= 0) {
+		if (pages[np])
+			__free_page(pages[np]);
+	}
+
+	__free_page(res.scratch);
+	kfree(pages);
+
+	return ret;
+
+}
+
+ssize_t nfs42_proc_getxattr(struct inode *inode, const char *name,
+			      void *buf, size_t buflen)
+{
+	struct nfs4_exception exception = { };
+	ssize_t err;
+
+	do {
+		err = _nfs42_proc_getxattr(inode, name, buf, buflen);
+		if (err >= 0)
+			break;
+		err = nfs4_handle_exception(NFS_SERVER(inode), err,
+				&exception);
+	} while (exception.retry);
+
+	return err;
+}
+
+int nfs42_proc_setxattr(struct inode *inode, const char *name,
+			      const void *buf, size_t buflen, int flags)
+{
+	struct nfs4_exception exception = { };
+	int err;
+
+	do {
+		err = _nfs42_proc_setxattr(inode, name, buf, buflen, flags);
+		if (!err)
+			break;
+		err = nfs4_handle_exception(NFS_SERVER(inode), err,
+				&exception);
+	} while (exception.retry);
+
+	return err;
+}
+
+ssize_t nfs42_proc_listxattrs(struct inode *inode, void *buf,
+			      size_t buflen, u64 *cookiep, bool *eofp)
+{
+	struct nfs4_exception exception = { };
+	ssize_t err;
+
+	do {
+		err = _nfs42_proc_listxattrs(inode, buf, buflen,
+		    cookiep, eofp);
+		if (err >= 0)
+			break;
+		err = nfs4_handle_exception(NFS_SERVER(inode), err,
+				&exception);
+	} while (exception.retry);
+
+	return err;
+}
+
+int nfs42_proc_removexattr(struct inode *inode, const char *name)
+{
+	struct nfs4_exception exception = { };
+	int err;
+
+	do {
+		err = _nfs42_proc_removexattr(inode, name);
+		if (!err)
+			break;
+		err = nfs4_handle_exception(NFS_SERVER(inode), err,
+				&exception);
+	} while (exception.retry);
+
+	return err;
+}
+
+#endif /* CONFIG_NFS_V4_XATTR */
-- 
2.17.2

