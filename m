Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789A7580F40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 10:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbiGZIjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbiGZIje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:39:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBDE2F66D;
        Tue, 26 Jul 2022 01:39:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5AD3374D3;
        Tue, 26 Jul 2022 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658824772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LyAIREx3+up4ZrbQ5xgQUckoAU4ZUqQh/qnLXz2wNQ=;
        b=zPZAnjaFfvk6fptC8TbQvLBz4sqC44gnOqMK6MbdYvbLS4MZRzJQMe/jnNSOI4Q6Qj5WDA
        eQhzpNQgAZZfYNUPxNqxgRg2muiItbCNrfguPC3ChLIXS1gvA71YzarS2FxFDQHZBIZMFI
        ieQNOxxQdp2LU0hv40ct/Jq8z16sCTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658824772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LyAIREx3+up4ZrbQ5xgQUckoAU4ZUqQh/qnLXz2wNQ=;
        b=jKwnj/eVPofYELrkIIvcsZCPOznrGzBTsLiv7xEM0MjA2xjUKqrNfiFhFtKMDGhUHCOHfV
        kcARGEhmwsQ0Q5CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87B0113ADB;
        Tue, 26 Jul 2022 08:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kBxbIESo32LYDQAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 26 Jul 2022 08:39:32 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Petr Vorel <pvorel@suse.cz>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] exfat: Drop superfluous new line for error messages
Date:   Tue, 26 Jul 2022 10:39:29 +0200
Message-Id: <20220726083929.1684-6-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220726083929.1684-1-tiwai@suse.de>
References: <20220726083929.1684-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

exfat_err() adds the new line at the end of the message by itself,
hence the passed string shouldn't contain a new line.  Drop the
superfluous newline letters in the error messages in a few places that
have been put mistakenly.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 fs/exfat/fatent.c | 2 +-
 fs/exfat/nls.c    | 2 +-
 fs/exfat/super.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 9de6a6b844c9..ee0b7cf51157 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -331,7 +331,7 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 	/* find new cluster */
 	if (hint_clu == EXFAT_EOF_CLUSTER) {
 		if (sbi->clu_srch_ptr < EXFAT_FIRST_CLUSTER) {
-			exfat_err(sb, "sbi->clu_srch_ptr is invalid (%u)\n",
+			exfat_err(sb, "sbi->clu_srch_ptr is invalid (%u)",
 				  sbi->clu_srch_ptr);
 			sbi->clu_srch_ptr = EXFAT_FIRST_CLUSTER;
 		}
diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 617aa1272265..705710f93e2d 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -671,7 +671,7 @@ static int exfat_load_upcase_table(struct super_block *sb,
 
 		bh = sb_bread(sb, sector);
 		if (!bh) {
-			exfat_err(sb, "failed to read sector(0x%llx)\n",
+			exfat_err(sb, "failed to read sector(0x%llx)",
 				  (unsigned long long)sector);
 			ret = -EIO;
 			goto free_table;
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 6a4dfe9f31ee..35f0305cd493 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -464,7 +464,7 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	 */
 	if (p_boot->sect_size_bits < EXFAT_MIN_SECT_SIZE_BITS ||
 	    p_boot->sect_size_bits > EXFAT_MAX_SECT_SIZE_BITS) {
-		exfat_err(sb, "bogus sector size bits : %u\n",
+		exfat_err(sb, "bogus sector size bits : %u",
 				p_boot->sect_size_bits);
 		return -EINVAL;
 	}
@@ -473,7 +473,7 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	 * sect_per_clus_bits could be at least 0 and at most 25 - sect_size_bits.
 	 */
 	if (p_boot->sect_per_clus_bits > EXFAT_MAX_SECT_PER_CLUS_BITS(p_boot)) {
-		exfat_err(sb, "bogus sectors bits per cluster : %u\n",
+		exfat_err(sb, "bogus sectors bits per cluster : %u",
 				p_boot->sect_per_clus_bits);
 		return -EINVAL;
 	}
-- 
2.35.3

