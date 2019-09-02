Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE7AB13B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387672AbfILR3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:13 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2868 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbfILR3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309351; x=1599845351;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=aKG3UVS/A9zzvZkRymQ0AZJ7OphTa/w8NjjWeGF7D/M=;
  b=nkujDLYaHCSyEfEftfADXRK72D21q402kpNWcAKu0nVokuW/gDqdSluX
   LOdt3nAUkhBpan3DkifPgUfpvnGZXTHdIFx5MDfRzHEqZA1kr0nAn6UlL
   96cVFwfVncSemiyi8KFmWriiykdeSlLNIZf1PWlnwqJDjoBXGm5BYBrke
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="702191785"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Sep 2019 17:28:58 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 21684A2973;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D02UWB004.ant.amazon.com (10.43.161.11) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D02UWB004.ant.amazon.com (10.43.161.11) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E6558C0564; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <7c77f897843ccdc150550926bc9e6cd5290dfc8e.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 2 Sep 2019 19:58:35 +0000
Subject: [RFC PATCH 29/35] nfsd: add xattr XDR decode functions
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the XDR decode functions for the user extended attribute
operations.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4xdr.c | 233 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 228 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c921945f0df0..acf606f764a2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1793,6 +1793,222 @@ nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 	DECODE_TAIL;
 }
 
+#ifdef CONFIG_NFSD_V4_XATTR
+/*
+ * XDR data that is more than PAGE_SIZE in size is normally part of a
+ * read or write. However, the size of extended attributes is limited
+ * by the maximum request size, and then further limited by the underlying
+ * filesystem limits. This can exceed PAGE_SIZE (currently, XATTR_SIZE_MAX
+ * is 64k). Since there is no kvec- or page-based interface to xattrs,
+ * and we're not dealing with contiguous pages, we need to do some copying.
+ */
+
+/*
+ * Decode int to buffer. Uses head and pages constructed by
+ * svcxdr_construct_vector.
+ */
+static int
+nfsd4_vbuf_from_stream(struct nfsd4_compoundargs *argp, struct kvec *head,
+		       struct page **pages, char **bufp, u32 buflen)
+{
+	char *tmp, *dp;
+	u32 len;
+
+	if (buflen <= head->iov_len) {
+		/*
+		 * We're in luck, the head has enough space. Just return
+		 * the head, no need for copying.
+		 */
+		*bufp = head->iov_base;
+		return 0;
+	}
+
+	tmp = svcxdr_tmpalloc(argp, buflen);
+	if (tmp == NULL)
+		return nfserr_jukebox;
+
+	dp = tmp;
+	memcpy(dp, head->iov_base, head->iov_len);
+	buflen -= head->iov_len;
+	dp += head->iov_len;
+
+	while (buflen > 0) {
+		len = min_t(u32, buflen, PAGE_SIZE);
+		memcpy(dp, page_address(*pages), len);
+
+		buflen -= len;
+		dp += len;
+		pages++;
+	}
+
+	*bufp = tmp;
+	return 0;
+}
+
+/*
+ * Get a user extended attribute name from the XDR buffer.
+ * It will not have the "user." prefix, so prepend it.
+ * Lastly, check for nul characters in the name.
+ */
+static int
+nfsd4_decode_xattr_name(struct nfsd4_compoundargs *argp, char **namep)
+{
+	DECODE_HEAD;
+	char *name, *sp, *dp;
+	u32 namelen, cnt;
+
+	READ_BUF(4);
+	namelen = be32_to_cpup(p++);
+
+	if (namelen > (XATTR_NAME_MAX - XATTR_USER_PREFIX_LEN))
+		return nfserr_nametoolong;
+
+	if (namelen == 0)
+		goto xdr_error;
+
+	READ_BUF(namelen);
+
+	name = svcxdr_tmpalloc(argp, namelen + XATTR_USER_PREFIX_LEN + 1);
+	if (!name)
+		return nfserr_jukebox;
+
+	memcpy(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
+
+	/*
+	 * Copy the extended attribute name over while checking for 0
+	 * characters.
+	 */
+	sp = (char *)p;
+	dp = name + XATTR_USER_PREFIX_LEN;
+	cnt = namelen;
+
+	while (cnt-- > 0) {
+		if (*sp == '\0')
+			goto xdr_error;
+		*dp++ = *sp++;
+	}
+	*dp = '\0';
+
+	*namep = name;
+
+	DECODE_TAIL;
+}
+
+/*
+ * A GETXATTR op request comes without a length specifier. We just set the
+ * maximum length for the reply based on XATTR_SIZE_MAX and the maximum
+ * channel reply size, allocate a buffer of that length and pass it to
+ * vfs_getxattr.
+ */
+static __be32
+nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp, struct nfsd4_getxattr *getxattr)
+{
+	int status;
+	u32 maxcount;
+
+	status = nfsd4_decode_xattr_name(argp, &getxattr->getxa_name);
+	if (status)
+		return status;
+
+	maxcount = svc_max_payload(argp->rqstp);
+	maxcount = min_t(u32, XATTR_SIZE_MAX, maxcount);
+
+	getxattr->getxa_buf = svcxdr_tmpalloc(argp, maxcount);
+	if (!getxattr->getxa_buf)
+		status = nfserr_jukebox;
+	getxattr->getxa_len = maxcount;
+
+	return status;
+}
+
+static __be32
+nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp, struct nfsd4_setxattr *setxattr)
+{
+	DECODE_HEAD;
+	u32 flags, maxcount, size;
+	struct kvec head;
+	struct page **pagelist;
+
+	READ_BUF(4);
+	flags = be32_to_cpup(p++);
+
+	if (flags > SETXATTR4_REPLACE)
+		return nfserr_inval;
+	setxattr->setxa_flags = flags;
+
+	status = nfsd4_decode_xattr_name(argp, &setxattr->setxa_name);
+	if (status)
+		return status;
+
+	maxcount = svc_max_payload(argp->rqstp);
+	maxcount = min_t(u32, XATTR_SIZE_MAX, maxcount);
+
+	READ_BUF(4);
+	size = be32_to_cpup(p++);
+	if (size > maxcount)
+		return nfserr_xattr2big;
+
+	setxattr->setxa_len = size;
+	if (size > 0) {
+		status = svcxdr_construct_vector(argp, &head, &pagelist, size);
+		if (status)
+			return status;
+
+		status = nfsd4_vbuf_from_stream(argp, &head, pagelist,
+		    &setxattr->setxa_buf, size);
+	}
+
+	DECODE_TAIL;
+}
+
+static __be32
+nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp, struct nfsd4_listxattrs *listxattrs)
+{
+	DECODE_HEAD;
+	u32 maxcount;
+
+	READ_BUF(12);
+	p = xdr_decode_hyper(p, &listxattrs->lsxa_cookie);
+
+	/*
+	 * If the cookie  is too large to have even one user.x attribute
+	 * plus trailing '\0' left in a maximum size buffer, it's invalid.
+	 */
+	if (listxattrs->lsxa_cookie >=
+	    (XATTR_LIST_MAX / (XATTR_USER_PREFIX_LEN + 2)))
+		return nfserr_badcookie;
+
+	maxcount = be32_to_cpup(p++);
+	if (maxcount < 8)
+		/* Always need at least 2 words (length and one character) */
+		return nfserr_inval;
+
+	maxcount = min(maxcount, svc_max_payload(argp->rqstp));
+	listxattrs->lsxa_maxcount = maxcount;
+
+	/*
+	 * Unfortunately, there is no interface to only list xattrs for
+	 * one prefix. So there is no good way to convert maxcount to
+	 * a maximum value to pass to vfs_listxattr, as we don't know
+	 * how many of the returned attributes will be user attributes.
+	 *
+	 * So, always ask vfs_listxattr for the maximum size, and encode
+	 * as many as possible.
+	 */
+	listxattrs->lsxa_buf = svcxdr_tmpalloc(argp, XATTR_LIST_MAX);
+	if (!listxattrs->lsxa_buf)
+		status = nfserr_jukebox;
+
+	DECODE_TAIL;
+}
+
+static __be32
+nfsd4_decode_removexattr(struct nfsd4_compoundargs *argp, struct nfsd4_removexattr *removexattr)
+{
+	return nfsd4_decode_xattr_name(argp, &removexattr->rmxa_name);
+}
+#endif
+
 static __be32
 nfsd4_decode_noop(struct nfsd4_compoundargs *argp, void *p)
 {
@@ -1890,11 +2106,18 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_WRITE_SAME]		= (nfsd4_dec)nfsd4_decode_notsupp,
 	[OP_CLONE]		= (nfsd4_dec)nfsd4_decode_clone,
 
-        /* Placeholders for RFC 8276 extended atributes operations */
-        [OP_GETXATTR]           = (nfsd4_dec)nfsd4_decode_notsupp,
-        [OP_SETXATTR]           = (nfsd4_dec)nfsd4_decode_notsupp,
-        [OP_LISTXATTRS]         = (nfsd4_dec)nfsd4_decode_notsupp,
-        [OP_REMOVEXATTR]        = (nfsd4_dec)nfsd4_decode_notsupp,
+#ifdef CONFIG_NFSD_V4_XATTR
+	/* RFC 8276 extended atributes operations */
+	[OP_GETXATTR]		= (nfsd4_dec)nfsd4_decode_getxattr,
+	[OP_SETXATTR]		= (nfsd4_dec)nfsd4_decode_setxattr,
+	[OP_LISTXATTRS]		= (nfsd4_dec)nfsd4_decode_listxattrs,
+	[OP_REMOVEXATTR]	= (nfsd4_dec)nfsd4_decode_removexattr,
+#else
+	[OP_GETXATTR]		= (nfsd4_dec)nfsd4_decode_notsupp,
+	[OP_SETXATTR]		= (nfsd4_dec)nfsd4_decode_notsupp,
+	[OP_LISTXATTRS]		= (nfsd4_dec)nfsd4_decode_notsupp,
+	[OP_REMOVEXATTR]	= (nfsd4_dec)nfsd4_decode_notsupp,
+#endif
 };
 
 static inline bool
-- 
2.17.2

