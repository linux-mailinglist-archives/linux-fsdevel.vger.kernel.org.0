Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2355C4AAA61
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 18:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380539AbiBERE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 12:04:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40182 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380519AbiBERE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:04:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9785861113;
        Sat,  5 Feb 2022 17:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19D4C340E8;
        Sat,  5 Feb 2022 17:04:56 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 7/7] NFSD: Deprecate NFS_OFFSET_MAX
Date:   Sat,  5 Feb 2022 12:04:55 -0500
Message-Id:  <164408069573.3707.2101485349960133054.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164408013367.3707.1739092698555505020.stgit@bazille.1015granger.net>
References:  <164408013367.3707.1739092698555505020.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051; h=from:subject:message-id; bh=pkUTaosNQpKBg00uOuMM1iODPE3WLgAG/zzVyufdti4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh/q43hquHoEoRzj2ab/E8M5Y18D1ZSul26IJfwEkD u9jUNtqJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYf6uNwAKCRAzarMzb2Z/l3u+D/ 9pv3RmL1noi50Ox7vvCSYlSi+se0UR5tAGlOO0Qtn54YtVbdfgUefeCno6qJTDJioLmcnbl5LDJH+g RFGh6JrsLE5BgqwjPuSDGJ7zD3bZWA1vyOpIdaoET/FTm12+bM1vlj3eaus/wIRM7b9d2/ZxHvp1+B TuZyicULUKggw5AHEPmsIuUugKhZpxtU20UNN0dc+tNXjr+TzKTCY8QN3Yhd+yawn7ERjrcgokkYBj CS3p9WLA6wRz15oM0N+wlJlVcr63vnwVP341Ga29BptT2dFlufHBcEI47LbpfSZtvLT4NkAs97I9G+ HCEoJic4yQHb+lFZbFudxeay4swSAQV9dEWH0ITFqnhcj7SKSGozwvkpEgo1kNzZ4X1hZXpM4/umzT BmD8thyJNfsvVDzUXq5mlevLL5K/HyAITlLc13ABSbtV8FiXgGL4Pt1AgyCxQi3hcoYNIt0KUPHbP5 t4Rouc+KF/yqm4bYpByAbWPx5ZLEUD0to8XkFBxaVUSPLxf9cS0XfrQ0kNmUJH9DKlf1QJOPyHusbk iPtyk+6vORKcshu+kkbuxTbKljAnKdPpmDLIlBQr1WPrtMQ3Dw++XSesNAL+8qb2vLPUIUd6mcxwoJ DKrdkRHN8tByHBvYwh8FZtaFW7cl3RibnpS6C0OMeJk7wwbfI+UXN4lWIk4A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
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
index f5e3430bb6ff..714a3a3bd50c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3495,7 +3495,7 @@ nfsd4_encode_dirent(void *ccdv, const char *name, int namlen,
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

