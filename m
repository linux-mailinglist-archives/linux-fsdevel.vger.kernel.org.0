Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2952B57E305
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiGVO3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 10:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGVO3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:29:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1F79D50F;
        Fri, 22 Jul 2022 07:29:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9AD7C380E7;
        Fri, 22 Jul 2022 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658500161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDz/z5x/8axDpMU/GZGGFz+fsQZdDoUpZOWw7JjfVtA=;
        b=qZ6p/Z+1GMGyxnLmZdjLyrJatnVl9lfXBov4e2cHN+fh3W1paC5pkpJ2iBYAZQqTP4ZPtw
        wAE4+Y2tlm3pFK7tnpJOOWV597RcMfxJUSprtWrRBrGqG5XeDC8mvXfDgASQTpEFTVkYtk
        klYXDK+14LcO7yhLC9ezK9aZqsU4rG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658500161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDz/z5x/8axDpMU/GZGGFz+fsQZdDoUpZOWw7JjfVtA=;
        b=XYDBG8ABue0jZcz7mwSHJSJWGKYccGQt3fRAomCBQqujW0zixIleFqsYNq32892gEeLMMG
        VzjXLGeYtpfRe4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 770C6134A9;
        Fri, 22 Jul 2022 14:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oGJZHEG02mJ7bwAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 22 Jul 2022 14:29:21 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] exfat: Downgrade ENAMETOOLONG error message to debug messages
Date:   Fri, 22 Jul 2022 16:29:16 +0200
Message-Id: <20220722142916.29435-5-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220722142916.29435-1-tiwai@suse.de>
References: <20220722142916.29435-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

