Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8B364EDE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiLPP1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiLPP1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61137654D8
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70911343E5;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mp0im0k3WbBYQT/mwck0hoftjHi9dYOSbAp0W30+/so=;
        b=UYcjpna0eT8Ypskw0/PVCw2q1CbKYEk0WjQV7ACVvri+vvxPcre0esDPIrY1JeWELnNzQN
        ae/JQA1K/h3cTsR3pRUnz6lhxNfsfquXCO3fAUhpUBxWsKUAXBlt18u8S8q3tJtw2zAyYl
        Juq1DOHQWFpZV+o4YUzNtqsL1+Vfc34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204422;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mp0im0k3WbBYQT/mwck0hoftjHi9dYOSbAp0W30+/so=;
        b=l5JUAOIOKSjxLMcwaKI63pELeEDE9/uumiCKapJR/mTFVjIxm8ANqZxF8FBS41oTyvnKDK
        EmY5RSKH5hHRY2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4879B1390C;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b9b9EEaOnGPaCAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:27:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9CA61A076A; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 08/20] udf: Convert udf_get_parent() to new directory iteration code
Date:   Fri, 16 Dec 2022 16:24:12 +0100
Message-Id: <20221216152656.6236-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=jack@suse.cz; h=from:subject; bh=piFUdLIcqb+p1WWJajYPaIJAbEytR/v21OeKiJyIQms=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2dcaWJtZtEQEV/L84pmGy6Tzyy2uBoZaEAnoCA lWoOmc2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNnQAKCRCcnaoHP2RA2U9pB/ 9JPwXa83pks1Ehf/RR4E6piRuxhwx1O5gn7OjP15KNrXEiGbyP7h6v4nREKr22GF7YyH1RhBQRC4q6 IPbEg20VDwXE4JBCJZqyIz8r8QWPcYSMTeECsuUmG9zSq4vhqvXNdcLJRfuTWLDQlwUZ+P66tUlCHF VqJkQvCiMiXkiZpBSweYgICWq8bfkiiCll1bp5MCkET76cDz5JptklOCT7cMaxUR1o2rVeDQSytxmX o0v2ffgPWY1faLqSEUrFo7wyvbimvbXWceE0McDJK5pMvMnSanVnJFTYz5ErLLWPxu+Ym8ALhmeFSx XgtyassZXZEYmSxWWNuX93oIIpPbLQ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert udf_get_parent() to use udf_fiiter_find_entry().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index efc75cf5722d..812786050617 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1367,17 +1367,15 @@ static struct dentry *udf_get_parent(struct dentry *child)
 {
 	struct kernel_lb_addr tloc;
 	struct inode *inode = NULL;
-	struct fileIdentDesc cfi;
-	struct udf_fileident_bh fibh;
-
-	if (!udf_find_entry(d_inode(child), &dotdot_name, &fibh, &cfi))
-		return ERR_PTR(-EACCES);
+	struct udf_fileident_iter iter;
+	int err;
 
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
+	err = udf_fiiter_find_entry(d_inode(child), &dotdot_name, &iter);
+	if (err)
+		return ERR_PTR(err);
 
-	tloc = lelb_to_cpu(cfi.icb.extLocation);
+	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
+	udf_fiiter_release(&iter);
 	inode = udf_iget(child->d_sb, &tloc);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
-- 
2.35.3

