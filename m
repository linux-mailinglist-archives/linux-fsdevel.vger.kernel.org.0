Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD6EB13F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfILRqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:46:04 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27379 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfILRp7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568310358; x=1599846358;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=0yHfrO5fJu7ri9JgC0Uo4x8vb2zut04XSLFV8Hj17bQ=;
  b=ECctC9xEvdIOTRZL3zcm2k+cR1lFe31foayBmdaan/1w9rFQiRqqW6jN
   iXLVm5g7vpREpSyXXCoa4mTvfMD2NiwFDu7g0YRz7kM3Yj301y8lfrQJ0
   rKdddqOUeHsxZgwCu7GnlRm1C8LIRrb5eckhUVe4x+aihX5xOuH8U7wOs
   w=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="831156449"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Sep 2019 17:28:54 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 732D5282DF2;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D19UEA003.ant.amazon.com (10.43.61.115) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19UEA003.ant.amazon.com (10.43.61.115) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E277DC055A; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <0e544dca79417c9943ccb480c0fd829c2efe057c.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 2 Sep 2019 20:09:40 +0000
Subject: [RFC PATCH 30/35] nfsd: add xattr XDR encode functions
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the XDR encode functions for the user extended attribute
operations.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4xdr.c | 231 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index acf606f764a2..be57dc09a468 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4547,6 +4547,224 @@ nfsd4_encode_noop(struct nfsd4_compoundres *resp, __be32 nfserr, void *p)
 	return nfserr;
 }
 
+#ifdef CONFIG_NFSD_V4_XATTR
+/*
+ * Encode kmalloc-ed buffer in to XDR stream.
+ */
+static int
+nfsd4_vbuf_to_stream(struct xdr_stream *xdr, char *buf, u32 buflen)
+{
+	u32 cplen;
+	__be32 *p;
+
+	cplen = min_t(unsigned long, buflen,
+		      ((void *)xdr->end - (void *)xdr->p));
+	p = xdr_reserve_space(xdr, cplen);
+	if (!p)
+		return nfserr_resource;
+
+	memcpy(p, buf, cplen);
+	buf += cplen;
+	buflen -= cplen;
+
+	while (buflen) {
+		cplen = min_t(u32, buflen, PAGE_SIZE);
+		p = xdr_reserve_space(xdr, cplen);
+		if (!p)
+			return nfserr_resource;
+
+		memcpy(p, buf, cplen);
+
+		if (cplen < PAGE_SIZE) {
+			/*
+			 * We're done, with a length that wasn't page
+			 * aligned, so possibly not word aligned. Pad
+			 * any trailing bytes with 0.
+			 */
+			xdr_encode_opaque_fixed(p, NULL, cplen);
+			break;
+		}
+
+		buflen -= PAGE_SIZE;
+		buf += PAGE_SIZE;
+	}
+
+	return 0;
+}
+
+static __be32
+nfsd4_encode_getxattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_getxattr *getxattr)
+{
+	struct xdr_stream *xdr = &resp->xdr;
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, 4);
+	if (!p)
+		return nfserr_resource;
+
+	*p = cpu_to_be32(getxattr->getxa_len);
+
+	if (getxattr->getxa_len == 0)
+		return 0;
+
+	return nfsd4_vbuf_to_stream(xdr, getxattr->getxa_buf,
+				    getxattr->getxa_len);
+}
+
+static __be32
+nfsd4_encode_setxattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct
+		      nfsd4_setxattr *setxattr)
+{
+	struct xdr_stream *xdr = &resp->xdr;
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, 20);
+	if (!p)
+		return nfserr_resource;
+
+	encode_cinfo(p, &setxattr->setxa_cinfo);
+
+	return 0;
+}
+
+/*
+ * See if there are cookie values that can be rejected outright.
+ */
+static int
+nfsd4_listxattr_validate_cookie(struct nfsd4_listxattrs *listxattrs,
+				u32 *offsetp)
+{
+	u64 cookie = listxattrs->lsxa_cookie;
+
+	/*
+	 * If the cookie is larger than the maximum number we can fit
+	 * in either the buffer we just got back from vfs_listxattr, or,
+	 * XDR-encoded, in the return buffer, it's invalid.
+	 */
+	if (cookie > (listxattrs->lsxa_len) / (XATTR_USER_PREFIX_LEN + 2))
+		return nfserr_badcookie;
+
+	if (cookie > (listxattrs->lsxa_maxcount /
+		      (XDR_QUADLEN(XATTR_USER_PREFIX_LEN + 2) + 4)))
+		return nfserr_badcookie;
+
+	*offsetp = (u32)cookie;
+	return 0;
+}
+
+static __be32
+nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_listxattrs *listxattrs)
+{
+	struct xdr_stream *xdr = &resp->xdr;
+	u32 cookie_offset, count_offset, eof;
+	u32 left, xdrleft, slen, count;
+	u32 xdrlen, offset;
+	u64 cookie;
+	char *sp;
+	int status;
+	__be32 *p;
+	u32 nuser;
+
+	eof = 1;
+
+	status = nfsd4_listxattr_validate_cookie(listxattrs, &offset);
+	if (status)
+		return status;
+
+	/*
+	 * Reserve space for the cookie and the name array count. Record
+	 * the offsets to save them later.
+	 */
+	cookie_offset = xdr->buf->len;
+	count_offset = cookie_offset + 8;
+	p = xdr_reserve_space(xdr, 12);
+	if (!p)
+		return nfserr_resource;
+
+	count = 0;
+	left = listxattrs->lsxa_len;
+	sp = listxattrs->lsxa_buf;
+	nuser = 0;
+
+	xdrleft = listxattrs->lsxa_maxcount;
+
+	while (left > 0 && xdrleft > 0) {
+		slen = strlen(sp);
+
+		/*
+		 * Check if this a user. attribute, skip it if not.
+		 */
+		if (strncmp(sp, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+			goto contloop;
+
+		slen -= XATTR_USER_PREFIX_LEN;
+		xdrlen = 4 + ((slen + 3) & ~3);
+		if (xdrlen > xdrleft) {
+			if (count == 0) {
+				/*
+				 * Can't even fit the first attribute name.
+				 */
+				return nfserr_toosmall;
+			}
+			eof = 0;
+			goto wreof;
+		}
+
+		left -= XATTR_USER_PREFIX_LEN;
+		sp += XATTR_USER_PREFIX_LEN;
+		if (nuser++ < offset)
+			goto contloop;
+
+
+		p = xdr_reserve_space(xdr, xdrlen);
+		if (!p)
+			return nfserr_resource;
+
+		p = xdr_encode_opaque(p, sp, slen);
+
+		xdrleft -= xdrlen;
+		count++;
+contloop:
+		sp += slen + 1;
+		left -= slen + 1;
+	}
+
+	/*
+	 * If there were user attributes to copy, but we didn't copy
+	 * any, the offset was too large (e.g. the cookie was invalid).
+	 */
+	if (nuser > 0 && count == 0)
+		return nfserr_badcookie;
+
+wreof:
+	p = xdr_reserve_space(xdr, 4);
+	if (!p)
+		return nfserr_resource;
+	*p = cpu_to_be32(eof);
+
+	cookie = offset + count;
+
+	write_bytes_to_xdr_buf(xdr->buf, cookie_offset, &cookie, 8);
+	count = htonl(count);
+	write_bytes_to_xdr_buf(xdr->buf, count_offset, &count, 4);
+	return 0;
+}
+
+static __be32
+nfsd4_encode_removexattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_removexattr *removexattr)
+{
+	struct xdr_stream *xdr = &resp->xdr;
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, 20);
+	if (!p)
+		return nfserr_resource;
+
+	p = encode_cinfo(p, &removexattr->rmxa_cinfo);
+	return 0;
+}
+#endif
+
 typedef __be32(* nfsd4_enc)(struct nfsd4_compoundres *, __be32, void *);
 
 /*
@@ -4636,6 +4854,19 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
 	[OP_SEEK]		= (nfsd4_enc)nfsd4_encode_seek,
 	[OP_WRITE_SAME]		= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_CLONE]		= (nfsd4_enc)nfsd4_encode_noop,
+
+#ifdef CONFIG_NFSD_V4_XATTR
+	/* RFC 8276 extended atributes operations */
+	[OP_GETXATTR]		= (nfsd4_enc)nfsd4_encode_getxattr,
+	[OP_SETXATTR]		= (nfsd4_enc)nfsd4_encode_setxattr,
+	[OP_LISTXATTRS]		= (nfsd4_enc)nfsd4_encode_listxattrs,
+	[OP_REMOVEXATTR]	= (nfsd4_enc)nfsd4_encode_removexattr,
+#else
+	[OP_GETXATTR]		= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_SETXATTR]		= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_LISTXATTRS]		= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_REMOVEXATTR]	= (nfsd4_enc)nfsd4_encode_noop,
+#endif
 };
 
 /*
-- 
2.17.2

