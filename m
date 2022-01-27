Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0449E711
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiA0QIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiA0QIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:08:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3E6C061714;
        Thu, 27 Jan 2022 08:08:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F122B8013C;
        Thu, 27 Jan 2022 16:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC201C340E4;
        Thu, 27 Jan 2022 16:08:38 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 2/6] NFSD: Fix NFSv3 SETATTR's handling of large file sizes
Date:   Thu, 27 Jan 2022 11:08:38 -0500
Message-Id:  <164329971780.5879.14075937739339830206.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
References:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2256; h=from:subject:message-id; bh=KZ6nEjCBaasoWlPViPJLjrjxkT/Ax1Hk2VBhr26ctok=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8sOFTCBYzUDyEwWX0eU8X+QTd97W25NKickI+VUK 2SklvM+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfLDhQAKCRAzarMzb2Z/l7lJD/ 9evtlURpyyEV3mJsT6oMaPu0aLir9EJzTg6ZBvtA+E8aONbOs2eZDjjxDY2nHuUUxKVlIu53IkE2f5 GN/LzrgBU7B6YyacRCyvveGwJDSaWm3Wl+i1VzlnpGDRnv1n8HGUNIwRtPIEOg2beVRAcUFrPa3hEV 0Fgubf/D9HADHGxMhC7pl+xjSApWm7Wdq7++pM9Xvgzh/28ytCv87Lans6SvigvLjEr1JQz5S+Olsd eP4U5DOk3DIvjuNstAYQ6lXEF+GSpbBKESzd372P/WYiXS7iB7XuShRJQhhRyNQmP0OA79Tq3fmB2I N0mzVi/pp+kl1vD/pY9RHbrN9GjinPs5ZROgUmEbEJARScYGUwexr6NrtHyGVQ8STC5kTN17xVwDsi 3JVy7g8dGt9kQwioQ4/ZFAYVkl8V9MKOy0Lc8cjbrjVSx6F0DeuHKZptG0rGewLokODH22HwvRDf+B m/zSiaT0fU2Cu9DKOHr5zu/xvaZiZ8F9qBJovfrKT6Ry9EqC3naPb/yzy4VkshQQkL8calIeoi5P02 bVRPSWQxoh3RXs4rNuydTFBYOAzoLF/w0EQWY7GolwkTv9Fvn1NFyJBudEoKYNMN54M0L7/K5+1nDv JOz0EEg7c3MkCvSTbZnG2Sldl3aS06yuH9evH2XeH0x+hTKsK/JAcIZtfyOg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iattr::ia_size is a loff_t, so the XDR decoders must be careful to
deal with incoming client size values that are larger than s64_max.

VFS size comparisons (like in inode_newsize_ok) should now work as
expected -- it returns -EFBIG if the new size is larger than the
underlying filesystem's s_maxbytes.

However, RFC 1813 permits only WRITE to return NFS3ERR_FBIG. Add an
extra check to prevent NFSv3 SETATTR from returning FBIG.

Other NFSv3 procedures that take sattr3 arguments need to be audited
for this issue.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |   19 ++++++++++++++++++-
 fs/nfsd/nfs3xdr.c  |    2 +-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 8ef53f6726ec..aa0f0261ddac 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -66,13 +66,30 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
 {
 	struct nfsd3_sattrargs *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
+	struct iattr *iap = &argp->attrs;
 
 	dprintk("nfsd: SETATTR(3)  %s\n",
 				SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
-	resp->status = nfsd_setattr(rqstp, &resp->fh, &argp->attrs,
+
+	if (iap->ia_valid & ATTR_SIZE) {
+		struct super_block *sb;
+
+		resp->status = fh_verify(rqstp, &resp->fh, S_IFREG,
+			NFSD_MAY_SATTR|NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE);
+		if (resp->status != nfs_ok)
+			goto out;
+
+		resp->status = nfserr_inval;
+		sb = resp->fh.fh_dentry->d_sb;
+		if (iap->ia_size < 0 || iap->ia_size > sb->s_maxbytes)
+			goto out;
+	}
+
+	resp->status = nfsd_setattr(rqstp, &resp->fh, iap,
 				    argp->check_guard, argp->guardtime);
+out:
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 7c45ba4db61b..2e47a07029f1 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -254,7 +254,7 @@ svcxdr_decode_sattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (xdr_stream_decode_u64(xdr, &newsize) < 0)
 			return false;
 		iap->ia_valid |= ATTR_SIZE;
-		iap->ia_size = min_t(u64, newsize, NFS_OFFSET_MAX);
+		iap->ia_size = newsize;
 	}
 	if (xdr_stream_decode_u32(xdr, &set_it) < 0)
 		return false;

