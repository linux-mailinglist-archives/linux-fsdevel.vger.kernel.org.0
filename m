Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF0508F75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 20:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381513AbiDTScQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 14:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381512AbiDTScI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:32:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD1238BFF;
        Wed, 20 Apr 2022 11:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4746B61B1F;
        Wed, 20 Apr 2022 18:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B495C385A0;
        Wed, 20 Apr 2022 18:29:20 +0000 (UTC)
Subject: [PATCH RFC 7/8] NFSD: Clean up nfsd_open_verified()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 20 Apr 2022 14:29:19 -0400
Message-ID: <165047935951.1829.4140838884832238133.stgit@manet.1015granger.net>
In-Reply-To: <165047903719.1829.18357114060053600197.stgit@manet.1015granger.net>
References: <165047903719.1829.18357114060053600197.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Its only caller always passes S_IFREG as the @type parameter. As an
additional clean-up, add a kerneldoc comment.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |    4 ++--
 fs/nfsd/vfs.c       |   15 ++++++++++++---
 fs/nfsd/vfs.h       |    2 +-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2c1b027774d4..781bef7e42d9 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -995,8 +995,8 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	nf->nf_mark = nfsd_file_mark_find_or_create(nf);
 	if (nf->nf_mark)
-		status = nfsd_open_verified(rqstp, fhp, S_IFREG,
-				may_flags, &nf->nf_file);
+		status = nfsd_open_verified(rqstp, fhp, may_flags,
+					    &nf->nf_file);
 	else
 		status = nfserr_jukebox;
 	/*
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 407976830a2b..893b5f21dab9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -827,14 +827,23 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 	return err;
 }
 
+/**
+ * nfsd_open_verified - Open a regular file for the filecache
+ * @rqstp: RPC request
+ * @fhp: NFS filehandle of the file to open
+ * @may_flags: internal permission flags
+ * @filp: OUT: open "struct file *"
+ *
+ * Returns an nfsstat value in network byte order.
+ */
 __be32
-nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
-		int may_flags, struct file **filp)
+nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, int may_flags,
+		   struct file **filp)
 {
 	__be32 err;
 
 	validate_process_creds();
-	err = __nfsd_open(rqstp, fhp, type, may_flags, filp);
+	err = __nfsd_open(rqstp, fhp, S_IFREG, may_flags, filp);
 	validate_process_creds();
 	return err;
 }
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index f99794b033a5..26347d76f44a 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -86,7 +86,7 @@ __be32		nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 int 		nfsd_open_break_lease(struct inode *, int);
 __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
-__be32		nfsd_open_verified(struct svc_rqst *, struct svc_fh *, umode_t,
+__be32		nfsd_open_verified(struct svc_rqst *, struct svc_fh *,
 				int, struct file **);
 __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,


