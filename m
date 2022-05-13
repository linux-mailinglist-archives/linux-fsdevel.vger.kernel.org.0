Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E074E526A93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 21:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383892AbiEMTjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 15:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383887AbiEMTjk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 15:39:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AAF4DF7B;
        Fri, 13 May 2022 12:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FBBAB83177;
        Fri, 13 May 2022 19:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C26C34113;
        Fri, 13 May 2022 19:39:36 +0000 (UTC)
Subject: [PATCH 2/8] NFSD: Avoid calling fh_drop_write() twice in
 do_nfsd_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Date:   Fri, 13 May 2022 15:39:35 -0400
Message-ID: <165247077540.6691.1645892566852216165.stgit@bazille.1015granger.net>
In-Reply-To: <165247056822.6691.9087206893184705325.stgit@bazille.1015granger.net>
References: <165247056822.6691.9087206893184705325.stgit@bazille.1015granger.net>
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

Clean up: The "out" label already invokes fh_drop_write().

Note that fh_drop_write() is already careful not to invoke
mnt_drop_write() if either it has already been done or there is
nothing to drop. Therefore no change in behavior is expected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4c1984f07cdc..bbed7a986784 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1479,7 +1479,6 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		case NFS3_CREATE_GUARDED:
 			err = nfserr_exist;
 		}
-		fh_drop_write(fhp);
 		goto out;
 	}
 
@@ -1487,10 +1486,8 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_mode &= ~current_umask();
 
 	host_err = vfs_create(&init_user_ns, dirp, dchild, iap->ia_mode, true);
-	if (host_err < 0) {
-		fh_drop_write(fhp);
+	if (host_err < 0)
 		goto out_nfserr;
-	}
 	if (created)
 		*created = true;
 


