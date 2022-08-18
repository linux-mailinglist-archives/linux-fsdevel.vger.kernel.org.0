Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838C25990A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 00:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbiHRWkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 18:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiHRWkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:40:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53614D805C;
        Thu, 18 Aug 2022 15:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B898CCE2344;
        Thu, 18 Aug 2022 22:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3B2C433D6;
        Thu, 18 Aug 2022 22:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660862398;
        bh=XhG5VJKg0K2Zsgy7igKZ4ZFLyQCgKURq1heQn+uTGhE=;
        h=From:To:Cc:Subject:Date:From;
        b=BqjHITUQAztJfrjxBMbnMfwBZcHgtC2xl3x3pGOD4+n7pwiHuPVeDIugDFFVUujpk
         aeuqIu3s4/VkmkHcRdSdJUIxmn+3hzlP6nF3IREyjgnpfp++SCWbkVOHBiZ5Fl4cIt
         rTx+nUtGfHDlUWvnLiDn/fB0dbWgmzHAOzKeOgZdFVKoMz32ix8EXdxuKKF0XN7La+
         fwslOgBCzF5RxsQhQlHGzIC5GHuHky66qiP74x6Y378QcfAko1KdOwo8MnWEivtWat
         KFuwfHJmiS5UX9JnLv/X6HrTlKTKTCuG35g4lb6hDu0ypL3Hz1bDeiESFJf1eqwTDj
         jydi0AcOBS3Gw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] fs-verity: use memcpy_from_page()
Date:   Thu, 18 Aug 2022 15:39:03 -0700
Message-Id: <20220818223903.43710-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Replace extract_hash() with the memcpy_from_page() helper function.

This is simpler, and it has the side effect of replacing the use of
kmap_atomic() with its recommended replacement kmap_local_page().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/verify.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 14e2fb49cff561..bde8c9b7d25f64 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -39,16 +39,6 @@ static void hash_at_level(const struct merkle_tree_params *params,
 		   (params->log_blocksize - params->log_arity);
 }
 
-/* Extract a hash from a hash page */
-static void extract_hash(struct page *hpage, unsigned int hoffset,
-			 unsigned int hsize, u8 *out)
-{
-	void *virt = kmap_atomic(hpage);
-
-	memcpy(out, virt + hoffset, hsize);
-	kunmap_atomic(virt);
-}
-
 static inline int cmp_hashes(const struct fsverity_info *vi,
 			     const u8 *want_hash, const u8 *real_hash,
 			     pgoff_t index, int level)
@@ -129,7 +119,7 @@ static bool verify_page(struct inode *inode, const struct fsverity_info *vi,
 		}
 
 		if (PageChecked(hpage)) {
-			extract_hash(hpage, hoffset, hsize, _want_hash);
+			memcpy_from_page(_want_hash, hpage, hoffset, hsize);
 			want_hash = _want_hash;
 			put_page(hpage);
 			pr_debug_ratelimited("Hash page already checked, want %s:%*phN\n",
@@ -158,7 +148,7 @@ static bool verify_page(struct inode *inode, const struct fsverity_info *vi,
 		if (err)
 			goto out;
 		SetPageChecked(hpage);
-		extract_hash(hpage, hoffset, hsize, _want_hash);
+		memcpy_from_page(_want_hash, hpage, hoffset, hsize);
 		want_hash = _want_hash;
 		put_page(hpage);
 		pr_debug("Verified hash page at level %d, now want %s:%*phN\n",

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.1

