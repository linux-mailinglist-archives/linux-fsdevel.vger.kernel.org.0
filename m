Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7968B49E716
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243304AbiA0QIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiA0QIx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:08:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A17DC061714;
        Thu, 27 Jan 2022 08:08:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB1A56187A;
        Thu, 27 Jan 2022 16:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21B1C340E4;
        Thu, 27 Jan 2022 16:08:51 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 4/6] NFSD: Replace directory offset placeholder
Date:   Thu, 27 Jan 2022 11:08:51 -0500
Message-Id:  <164329973085.5879.646571358048546056.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
References:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401; h=from:subject:message-id; bh=ygQDJkZe0ROoIfeyx+08PXyGOCpWwxtxOJwsrSj4nxk=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8sOSkeaCbAX6y3q5XgrTPcO2rzoePl6Q5tA5/Zcr wXvg2aOJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfLDkgAKCRAzarMzb2Z/l4DSD/ 9UKJNt8F+KnnQKL1EUErYhfyMgPZOmLBY54lJ4puOcDZsQIxeD4CeJT7T1PYyaJiehzQK+x24L8Iw/ 2hLgWRHRXKmrq7VTytsu+d10ykqjoMO2Rqr3MYQUzMgAQgOJbD+erR9fa7w8SHL21VAhGs439AddmM 9eM97c5DMBVWB87PV/J3sGnDI6fBzucCfq90XualL6Sm8vnLJ0+7xaVJo1AdE+Fy+ZpxDSchdK4oMu aBViS4s1Gg1wIGkFFOY6r1tqjx0ZLWGXG3SaQkv6pKGmNlzZJs7puAA2B0KNBQR7AWfCyBFn1J8DGL zWMaH1RSoiNgLZSIfEYKf/HJDAFkfiG+mMijZZ+fPe69QfulKDHg6grKlbLHBUzxyCSgE48zlX4kAj 9kbDlLdfgYos/4kkynD+2ALwH2cjTyQg6hl9RU1izWmsSv6webGIP+8B4W5b37+RwI4uiR6mupK5VI YrzxpUq7p5XL3H4liIa5sROJObQ+nLSnil4WBsdZU2hl2G28lUhTHndBwyfdpXWFADSE1xf3uKig+y FKFonL010vJSl0FDL7l83fY2+rXVUPTHXSqxwULyWqtyWjjWkjSqKPO02fAgoA1ePcQxKgJvJaPlhm UoTyWm+4X8YENr+/mT/QE82zOgYUkE6fAloJPFJ6wWhn9INUnuyAlr/ihVjw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm about to remove NFS_OFFSET_MAX, so use a different symbolic
constant to mark the place of the offset field in directory
entries. OFFSET_MAX has the same value as NFS_OFFSET_MAX.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |    2 +-
 fs/nfsd/nfs4xdr.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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

