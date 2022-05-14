Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC325272FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 18:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiENQhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 12:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiENQhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 12:37:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE29245BC;
        Sat, 14 May 2022 09:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D598B80AEA;
        Sat, 14 May 2022 16:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42B2C340EE;
        Sat, 14 May 2022 16:37:29 +0000 (UTC)
Subject: [PATCH v2 1/8] NFSD: Clean up nfsd3_proc_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Date:   Sat, 14 May 2022 12:37:28 -0400
Message-ID: <165254624868.2361.1144532307953943311.stgit@bazille.1015granger.net>
In-Reply-To: <165254610700.2361.2480451215356922637.stgit@bazille.1015granger.net>
References: <165254610700.2361.2480451215356922637.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As near as I can tell, mode bit masking and setting S_IFREG is
already done by do_nfsd_create() and vfs_create(). The NFSv4 path
(do_open_lookup), for example, does not bother with this special
processing.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 936eebd4c56d..981a2a71c5af 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -229,8 +229,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 {
 	struct nfsd3_createargs *argp = rqstp->rq_argp;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
-	svc_fh		*dirfhp, *newfhp = NULL;
-	struct iattr	*attr;
+	svc_fh *dirfhp, *newfhp;
 
 	dprintk("nfsd: CREATE(3)   %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -239,20 +238,9 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 
 	dirfhp = fh_copy(&resp->dirfh, &argp->fh);
 	newfhp = fh_init(&resp->fh, NFS3_FHSIZE);
-	attr   = &argp->attrs;
-
-	/* Unfudge the mode bits */
-	attr->ia_mode &= ~S_IFMT;
-	if (!(attr->ia_valid & ATTR_MODE)) { 
-		attr->ia_valid |= ATTR_MODE;
-		attr->ia_mode = S_IFREG;
-	} else {
-		attr->ia_mode = (attr->ia_mode & ~S_IFMT) | S_IFREG;
-	}
 
-	/* Now create the file and set attributes */
 	resp->status = do_nfsd_create(rqstp, dirfhp, argp->name, argp->len,
-				      attr, newfhp, argp->createmode,
+				      &argp->attrs, newfhp, argp->createmode,
 				      (u32 *)argp->verf, NULL, NULL);
 	return rpc_success;
 }


