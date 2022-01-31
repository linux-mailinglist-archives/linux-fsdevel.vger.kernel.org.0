Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0B4A4E31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 19:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350693AbiAaSZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 13:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355455AbiAaSZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:25:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD279C061714;
        Mon, 31 Jan 2022 10:25:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88AB3B82BE7;
        Mon, 31 Jan 2022 18:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA86C340ED;
        Mon, 31 Jan 2022 18:25:12 +0000 (UTC)
Subject: [PATCH v2 5/5] NFSD: Deprecate NFS_OFFSET_MAX
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 31 Jan 2022 13:25:11 -0500
Message-ID: <164365351148.3304.16514886721676463758.stgit@bazille.1015granger.net>
In-Reply-To: <164365324981.3304.4571955521912946906.stgit@bazille.1015granger.net>
References: <164365324981.3304.4571955521912946906.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NFS_OFFSET_MAX was introduced way back in Linux v2.3.y before there
was a kernel-wide OFFSET_MAX value. As a clean up, replace the last
few uses of it with its generic equivalent, and get rid of it.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c   |    2 +-
 fs/nfsd/nfs4xdr.c   |    2 +-
 include/linux/nfs.h |    8 --------
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 2e47a07029f1..0293b8d65f10 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1060,7 +1060,7 @@ svcxdr_encode_entry3_common(struct nfsd3_readdirres *resp, const char *name,
 		return false;
 	/* cookie */
 	resp->cookie_offset = dirlist->len;
-	if (xdr_stream_encode_u64(xdr, NFS_OFFSET_MAX) < 0)
+	if (xdr_stream_encode_u64(xdr, OFFSET_MAX) < 0)
 		return false;
 
 	return true;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7d2217cdaeaa..64d73b750491 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3505,7 +3505,7 @@ nfsd4_encode_dirent(void *ccdv, const char *name, int namlen,
 	p = xdr_reserve_space(xdr, 3*4 + namlen);
 	if (!p)
 		goto fail;
-	p = xdr_encode_hyper(p, NFS_OFFSET_MAX);    /* offset of next entry */
+	p = xdr_encode_hyper(p, OFFSET_MAX);        /* offset of next entry */
 	p = xdr_encode_array(p, name, namlen);      /* name length & name */
 
 	nfserr = nfsd4_encode_dirent_fattr(xdr, cd, name, namlen);
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index 0dc7ad38a0da..b06375e88e58 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -36,14 +36,6 @@ static inline void nfs_copy_fh(struct nfs_fh *target, const struct nfs_fh *sourc
 	memcpy(target->data, source->data, source->size);
 }
 
-
-/*
- * This is really a general kernel constant, but since nothing like
- * this is defined in the kernel headers, I have to do it here.
- */
-#define NFS_OFFSET_MAX		((__s64)((~(__u64)0) >> 1))
-
-
 enum nfs3_stable_how {
 	NFS_UNSTABLE = 0,
 	NFS_DATA_SYNC = 1,


