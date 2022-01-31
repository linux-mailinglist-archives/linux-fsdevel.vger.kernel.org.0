Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC8C4A4E27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 19:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355738AbiAaSZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 13:25:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49214 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355749AbiAaSYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:24:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B21661113;
        Mon, 31 Jan 2022 18:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02F3C36AF6;
        Mon, 31 Jan 2022 18:24:53 +0000 (UTC)
Subject: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of large
 file sizes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 31 Jan 2022 13:24:53 -0500
Message-ID: <164365349299.3304.4161554101383665486.stgit@bazille.1015granger.net>
In-Reply-To: <164365324981.3304.4571955521912946906.stgit@bazille.1015granger.net>
References: <164365324981.3304.4571955521912946906.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iattr::ia_size is a loff_t, so these NFSv3 procedures must be
careful to deal with incoming client size values that are larger
than s64_max without corrupting the value.

Silently capping the value results in storing a different value
than the client passed in which is unexpected behavior, so remove
the min_t() check in decode_sattr3().

Moreover, a large file size is not an XDR error, since anything up
to U64_MAX is permitted for NFSv3 file size values. So it has to be
dealt with in nfs3proc.c, not in the XDR decoder.

Size comparisons like in inode_newsize_ok should now work as
expected -- the VFS returns -EFBIG if the new size is larger than
the underlying filesystem's s_maxbytes.

However, RFC 1813 permits only the WRITE procedure to return
NFS3ERR_FBIG. Extra checks are needed to prevent NFSv3 SETATTR and
CREATE from returning FBIG. Unfortunately RFC 1813 does not provide
a specific status code for either procedure to indicate this
specific failure, so I've chosen NFS3ERR_INVAL for SETATTR and
NFS3ERR_IO for CREATE.

Applications and NFS clients might be better served if the server
stuck with NFS3ERR_FBIG despite what RFC 1813 says.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    9 +++++++++
 fs/nfsd/nfs3xdr.c  |    2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 8ef53f6726ec..02edc7074d06 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -73,6 +73,10 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_setattr(rqstp, &resp->fh, &argp->attrs,
 				    argp->check_guard, argp->guardtime);
+
+	if (resp->status == nfserr_fbig)
+		resp->status = nfserr_inval;
+
 	return rpc_success;
 }
 
@@ -245,6 +249,11 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 	resp->status = do_nfsd_create(rqstp, dirfhp, argp->name, argp->len,
 				      attr, newfhp, argp->createmode,
 				      (u32 *)argp->verf, NULL, NULL);
+
+	/* CREATE must not return NFS3ERR_FBIG */
+	if (resp->status == nfserr_fbig)
+		resp->status = nfserr_io;
+
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


