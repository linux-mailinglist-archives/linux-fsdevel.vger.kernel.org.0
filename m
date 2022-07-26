Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92270580F3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 10:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbiGZIjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 04:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiGZIje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:39:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0692F66A;
        Tue, 26 Jul 2022 01:39:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86602374D1;
        Tue, 26 Jul 2022 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658824772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8sC6TOUOa2fUJaaIzlatUrA9lcMWdgpyfpzmTF7peu8=;
        b=kvLofho28b2Vz1ZBPuS7xbMPjjy9aw8K0rFniuSSDeIzGJZUZjCKOr7Hc0dWY7b/5TgVrn
        NUemp69cxP1k1iCOA6oI054bFM4OJ/C3xVL36mpDf5McL1RfnmDlqfD7DJ5IQJIywiBi+j
        55bfxfqm09p2iKhzozhXuSRm7tXk+iY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658824772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8sC6TOUOa2fUJaaIzlatUrA9lcMWdgpyfpzmTF7peu8=;
        b=JD5Xzv3RS/x9B1IaYe39DUje+CruqCbi105k03+vARoLzof0XCL8zmCd3xtaCYdDnjDOq4
        y55bst0pq0+9fWAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E34713A7C;
        Tue, 26 Jul 2022 08:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yJRUEkSo32LYDQAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 26 Jul 2022 08:39:32 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Petr Vorel <pvorel@suse.cz>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] exfat: Downgrade ENAMETOOLONG error message to debug messages
Date:   Tue, 26 Jul 2022 10:39:28 +0200
Message-Id: <20220726083929.1684-5-tiwai@suse.de>
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

The ENAMETOOLONG error message is printed at each time when user tries
to operate with a too long name, and this can flood the kernel logs
easily, as every user can trigger this.  Let's downgrade this error
message level to a debug message for suppressing the superfluous
logs.

BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1201725
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 fs/exfat/nls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index ef115e673406..617aa1272265 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -509,7 +509,7 @@ static int exfat_utf8_to_utf16(struct super_block *sb,
 	}
 
 	if (unilen > MAX_NAME_LENGTH) {
-		exfat_err(sb, "failed to %s (estr:ENAMETOOLONG) nls len : %d, unilen : %d > %d",
+		exfat_debug(sb, "failed to %s (estr:ENAMETOOLONG) nls len : %d, unilen : %d > %d",
 			  __func__, len, unilen, MAX_NAME_LENGTH);
 		return -ENAMETOOLONG;
 	}
-- 
2.35.3

