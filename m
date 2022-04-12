Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AE14FE84A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 20:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351915AbiDLS77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 14:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346239AbiDLS76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:59:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2FD433A3;
        Tue, 12 Apr 2022 11:57:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E557FB8200A;
        Tue, 12 Apr 2022 18:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B7FC385A5;
        Tue, 12 Apr 2022 18:57:37 +0000 (UTC)
Subject: [PATCH v1] NFSD: Clean up nfsd_splice_actor()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Tue, 12 Apr 2022 14:57:36 -0400
Message-ID: <164978985638.4322.14481417646650679676.stgit@bazille.1015granger.net>
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

nfsd_splice_actor() checks that the page being spliced does not
match the previous element in the svc_rqst::rq_pages array. We
believe this is to prevent a double put_page() in cases where the
READ payload is partially contained in the xdr_buf's head buffer.

However, the NFSD READ proc functions no longer place any part of
the READ payload in the head buffer, in order to properly support
NFS/RDMA READ with Write chunks. Therefore, simplify the logic in
nfsd_splice_actor() to remove this unnecessary check.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c22ad0532e8e..4c1984f07cdc 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -849,17 +849,11 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 		  struct splice_desc *sd)
 {
 	struct svc_rqst *rqstp = sd->u.data;
-	struct page **pp = rqstp->rq_next_page;
-	struct page *page = buf->page;
 
-	if (rqstp->rq_res.page_len == 0) {
-		svc_rqst_replace_page(rqstp, page);
+	svc_rqst_replace_page(rqstp, buf->page);
+	if (rqstp->rq_res.page_len == 0)
 		rqstp->rq_res.page_base = buf->offset;
-	} else if (page != pp[-1]) {
-		svc_rqst_replace_page(rqstp, page);
-	}
 	rqstp->rq_res.page_len += sd->len;
-
 	return sd->len;
 }
 


