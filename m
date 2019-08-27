Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFEFB13F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfILRqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:46:02 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27357 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfILRqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568310358; x=1599846358;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=oI4wFRFpQ3M/5bjRnX8XLchXwaOsarbV+0U8a1JOwKs=;
  b=mFFWbUzpKGj2NK53/GrqPgcxGqvCZMplllQzh8mXkMK/bsDFZHlnpmUt
   JFrV2lumCZ+c9iOotVJE/YzboA3kHw6qO71JjoKZxCJcOJVg5MrDVYaZ7
   cyzc2ripLsn385jrtRyH7S5ROnq6EsFtDuUhmlLoX5R6gLUXLId4qxFxw
   k=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="831156447"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Sep 2019 17:28:54 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id 0A9B2A2B1D;
        Thu, 12 Sep 2019 17:28:51 +0000 (UTC)
Received: from EX13D12UEE003.ant.amazon.com (10.43.62.198) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D12UEE003.ant.amazon.com (10.43.62.198) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E1EC8C0575; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <5914572e3fd0bdac58559833264e4a035f6190fb.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Tue, 27 Aug 2019 15:34:31 +0000
Subject: [RFC PATCH 10/35] NFSv4.2: add client side XDR handling for extended
 attributes
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the necessary functions to encode/decode the extended
attribute operations.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs42xdr.c | 372 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4xdr.c  |   8 +
 2 files changed, 380 insertions(+)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index ca29d2702017..dbd27d52f119 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -354,6 +354,212 @@ static void encode_layouterror(struct xdr_stream *xdr,
 	encode_device_error(xdr, &args->errors[0]);
 }
 
+#ifdef CONFIG_NFS_V4_XATTR
+static void encode_setxattr(struct xdr_stream *xdr,
+			    const struct nfs42_setxattrargs *arg,
+			    struct compound_hdr *hdr)
+{
+	__be32 *p;
+
+	BUILD_BUG_ON(XATTR_CREATE != SETXATTR4_CREATE);
+	BUILD_BUG_ON(XATTR_REPLACE != SETXATTR4_REPLACE);
+
+	encode_op_hdr(xdr, OP_SETXATTR, decode_setxattr_maxsz, hdr);
+	p = reserve_space(xdr, 4);
+	*p = cpu_to_be32(arg->xattr_flags);
+	encode_string(xdr, strlen(arg->xattr_name), arg->xattr_name);
+	p = reserve_space(xdr, 4);
+	*p = cpu_to_be32(arg->xattr_len);
+	if (arg->xattr_len)
+		xdr_write_pages(xdr, arg->xattr_pages, 0, arg->xattr_len);
+}
+
+static int decode_setxattr(struct xdr_stream *xdr,
+			   struct nfs4_change_info *cinfo)
+{
+	int status;
+
+	status = decode_op_hdr(xdr, OP_SETXATTR);
+	if (status)
+		goto out;
+	status = decode_change_info(xdr, cinfo);
+out:
+	return status;
+}
+
+
+static void encode_getxattr(struct xdr_stream *xdr, const char *name,
+			    struct compound_hdr *hdr)
+{
+	encode_op_hdr(xdr, OP_GETXATTR, decode_getxattr_maxsz, hdr);
+	encode_string(xdr, strlen(name), name);
+}
+
+static int decode_getxattr(struct xdr_stream *xdr,
+			   struct nfs42_getxattrres *res,
+			   struct rpc_rqst *req)
+{
+	int status;
+	__be32 *p;
+	u32 len, rdlen;
+
+	status = decode_op_hdr(xdr, OP_GETXATTR);
+	if (status)
+		return status;
+
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	len = be32_to_cpup(p);
+	if (len > req->rq_rcv_buf.page_len)
+		return -ERANGE;
+
+	res->xattr_len = len;
+
+	if (len > 0) {
+		rdlen = xdr_read_pages(xdr, len);
+		if (rdlen < len)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static void encode_removexattr(struct xdr_stream *xdr, const char *name,
+			       struct compound_hdr *hdr)
+{
+	encode_op_hdr(xdr, OP_REMOVEXATTR, decode_removexattr_maxsz, hdr);
+	encode_string(xdr, strlen(name), name);
+}
+
+
+static int decode_removexattr(struct xdr_stream *xdr,
+			   struct nfs4_change_info *cinfo)
+{
+	int status;
+
+	status = decode_op_hdr(xdr, OP_REMOVEXATTR);
+	if (status)
+		goto out;
+
+	status = decode_change_info(xdr, cinfo);
+out:
+	return status;
+}
+
+static void encode_listxattrs(struct xdr_stream *xdr,
+			     const struct nfs42_listxattrsargs *arg,
+			     struct compound_hdr *hdr)
+{
+	 __be32 *p;
+
+	encode_op_hdr(xdr, OP_LISTXATTRS, decode_listxattrs_maxsz + 1, hdr);
+
+	p = reserve_space(xdr, 12);
+	if (unlikely(!p))
+		return;
+
+	p = xdr_encode_hyper(p, arg->cookie);
+	/*
+	 * RFC 8276 says to specify the full max length of the LISTXATTRS
+	 * XDR reply. Count is set to the XDR length of the names array
+	 * plus the EOF marker. So, add the cookie and the names count.
+	 */
+	*p = cpu_to_be32(arg->count + 8 + 4);
+}
+
+static int decode_listxattrs(struct xdr_stream *xdr,
+			    struct nfs42_listxattrsres *res)
+{
+	int status;
+	__be32 *p;
+	u32 count, len, ulen;
+	size_t left, copied;
+	char *buf;
+
+	status = decode_op_hdr(xdr, OP_LISTXATTRS);
+	if (status) {
+		/*
+		 * Special case: for LISTXATTRS, NFS4ERR_TOOSMALL
+		 * should be translated to ERANGE.
+		 */
+		if (status == -ETOOSMALL)
+			status = -ERANGE;
+		goto out;
+	}
+
+	p = xdr_inline_decode(xdr, 8);
+	if (unlikely(!p))
+		return -EIO;
+
+	xdr_decode_hyper(p, &res->cookie);
+
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	left = res->xattr_len;
+	buf = res->xattr_buf;
+
+	count = be32_to_cpup(p);
+	copied = 0;
+
+	/*
+	 * We have asked for enough room to encode the maximum number
+	 * of possible attribute names, so everything should fit.
+	 *
+	 * But, don't rely on that assumption. Just decode entries
+	 * until they don't fit anymore, just in case the server did
+	 * something odd.
+	 */
+	while (count--) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+
+		len = be32_to_cpup(p);
+		if (len > (XATTR_NAME_MAX - XATTR_USER_PREFIX_LEN)) {
+			status = -ERANGE;
+			goto out;
+		}
+
+		p = xdr_inline_decode(xdr, len);
+		if (unlikely(!p))
+			return -EIO;
+
+		ulen = len + XATTR_USER_PREFIX_LEN + 1;
+		if (buf) {
+			if (ulen > left) {
+				status = -ERANGE;
+				goto out;
+			}
+
+			memcpy(buf, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
+			memcpy(buf + XATTR_USER_PREFIX_LEN, p, len);
+
+			buf[ulen - 1] = 0;
+			buf += ulen;
+			left -= ulen;
+		}
+		copied += ulen;
+	}
+
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	res->eof = be32_to_cpup(p);
+	res->copied = copied;
+
+out:
+	if (status == -ERANGE && res->xattr_len == XATTR_LIST_MAX)
+		status = -E2BIG;
+
+	return status;
+}
+#endif
+
 /*
  * Encode ALLOCATE request
  */
@@ -876,4 +1082,170 @@ static int nfs4_xdr_dec_layouterror(struct rpc_rqst *rqstp,
 	return status;
 }
 
+#ifdef CONFIG_NFS_V4_XATTR
+static void nfs4_xdr_enc_setxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
+                                const void *data)
+{
+	const struct nfs42_setxattrargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_setxattr(xdr, args, &hdr);
+	encode_nops(&hdr);
+}
+
+static int nfs4_xdr_dec_setxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
+                                 void *data)
+{
+	struct nfs42_setxattrres *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->seq_res, req);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+
+	status = decode_setxattr(xdr, &res->cinfo);
+out:
+	return status;
+}
+
+static void nfs4_xdr_enc_getxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
+                                const void *data)
+{
+	const struct nfs42_getxattrargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+	size_t plen;
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_getxattr(xdr, args->xattr_name, &hdr);
+
+	plen = args->xattr_len ? args->xattr_len : XATTR_SIZE_MAX;
+
+	rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
+	    hdr.replen);
+	req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
+
+	encode_nops(&hdr);
+}
+
+static int nfs4_xdr_dec_getxattr(struct rpc_rqst *rqstp,
+                                 struct xdr_stream *xdr,
+                                 void *data)
+{
+	struct nfs42_getxattrres *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->seq_res, rqstp);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+	status = decode_getxattr(xdr, res, rqstp);
+out:
+        return status;
+}
+
+static void nfs4_xdr_enc_listxattrs(struct rpc_rqst *req,
+				    struct xdr_stream *xdr,
+				    const void *data)
+{
+	const struct nfs42_listxattrsargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_listxattrs(xdr, args, &hdr);
+
+	rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count,
+	    hdr.replen);
+	req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
+
+	encode_nops(&hdr);
+}
+
+static int nfs4_xdr_dec_listxattrs(struct rpc_rqst *rqstp,
+                                 struct xdr_stream *xdr,
+                                 void *data)
+{
+	struct nfs42_listxattrsres *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	xdr_set_scratch_buffer(xdr, page_address(res->scratch), PAGE_SIZE);
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->seq_res, rqstp);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+	status = decode_listxattrs(xdr, res);
+out:
+        return status;
+}
+
+static void nfs4_xdr_enc_removexattr(struct rpc_rqst *req,
+				     struct xdr_stream *xdr, const void *data)
+{
+	const struct nfs42_removexattrargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_removexattr(xdr, args->xattr_name, &hdr);
+	encode_nops(&hdr);
+}
+
+static int nfs4_xdr_dec_removexattr(struct rpc_rqst *req,
+				      struct xdr_stream *xdr,
+				      void *data)
+{
+	struct nfs42_removexattrres *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->seq_res, req);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+
+	status = decode_removexattr(xdr, &res->cinfo);
+out:
+	return status;
+}
+#endif
 #endif /* __LINUX_FS_NFS_NFS4_2XDR_H */
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 00fd5732c59d..7b9c39e66d15 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7483,6 +7483,8 @@ static struct {
 	{ NFS4ERR_SYMLINK,	-ELOOP		},
 	{ NFS4ERR_OP_ILLEGAL,	-EOPNOTSUPP	},
 	{ NFS4ERR_DEADLOCK,	-EDEADLK	},
+	{ NFS4ERR_NOXATTR,	-ENODATA	},
+	{ NFS4ERR_XATTR2BIG,	-E2BIG		},
 	{ -1,			-EIO		}
 };
 
@@ -7610,6 +7612,12 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC42(OFFLOAD_CANCEL,	enc_offload_cancel,	dec_offload_cancel),
 	PROC(LOOKUPP,		enc_lookupp,		dec_lookupp),
 	PROC42(LAYOUTERROR,	enc_layouterror,	dec_layouterror),
+#ifdef CONFIG_NFS_V4_XATTR
+	PROC42(GETXATTR,	enc_getxattr,		dec_getxattr),
+	PROC42(SETXATTR,	enc_setxattr,		dec_setxattr),
+	PROC42(LISTXATTRS,	enc_listxattrs,		dec_listxattrs),
+	PROC42(REMOVEXATTR,	enc_removexattr,	dec_removexattr),
+#endif
 };
 
 static unsigned int nfs_version4_counts[ARRAY_SIZE(nfs4_procedures)];
-- 
2.17.2

