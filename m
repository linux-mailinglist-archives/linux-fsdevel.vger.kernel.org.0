Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9FD580F3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 10:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiGZIjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiGZIje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:39:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0352F667;
        Tue, 26 Jul 2022 01:39:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4AEE31FA88;
        Tue, 26 Jul 2022 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658824772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MsLW9yymgXmefY9ofAr6DRjYP6W1JWHULirWyX38Qes=;
        b=Ny8OSaHwLwcYTwNMFdrMKhixJfWYC47j/capDC1U4vnhK0+e1fzCQDx1GEUVTrM3KrL7Np
        h0WR8TnrEiJpnVh0sGBcpwaypreDbpQzZ7kYiE4U4FVnS7FWQlF0YeGwcqWGrHfQ4wujz5
        KaNX7IZknEOW9cZp/ONZYMb6khA/58M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658824772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MsLW9yymgXmefY9ofAr6DRjYP6W1JWHULirWyX38Qes=;
        b=OwZfwTsdS1lMLCMjtfbDcgXMJQQ0XEgHciOZ6lAbfLs5fgxVUejQEFevY7sUWKhlYBq9sY
        Sj63XAKenaxVQrCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C27213ADB;
        Tue, 26 Jul 2022 08:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AGgeBkSo32LYDQAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 26 Jul 2022 08:39:32 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Petr Vorel <pvorel@suse.cz>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] exfat: Expand exfat_err() and co directly to pr_*() macro
Date:   Tue, 26 Jul 2022 10:39:27 +0200
Message-Id: <20220726083929.1684-4-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220726083929.1684-1-tiwai@suse.de>
References: <20220726083929.1684-1-tiwai@suse.de>
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

Currently the error and info messages handled by exfat_err() and co
are tossed to exfat_msg() function that does nothing but passes the
strings with printk() invocation.  Not only that this is more overhead
by the indirect calls, but also this makes harder to extend for the
debug print usage; because of the direct printk() call, you cannot
make it for dynamic debug or without debug like the standard helpers
such as pr_debug() or dev_dbg().

For addressing the problem, this patch replaces exfat_*() macro to
expand to pr_*() directly.  Along with it, add the new exfat_debug()
macro that is expanded to pr_debug() (which output can be gracefully
suppressed via dyndbg).

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 fs/exfat/exfat_fs.h | 12 +++++++-----
 fs/exfat/misc.c     | 17 -----------------
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f431327af459..f9f0671515aa 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -508,14 +508,16 @@ void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
 #define exfat_fs_error_ratelimit(sb, fmt, args...) \
 		__exfat_fs_error(sb, __ratelimit(&EXFAT_SB(sb)->ratelimit), \
 		fmt, ## args)
-void exfat_msg(struct super_block *sb, const char *lv, const char *fmt, ...)
-		__printf(3, 4) __cold;
+
+/* expand to pr_*() with prefix */
 #define exfat_err(sb, fmt, ...)						\
-	exfat_msg(sb, KERN_ERR, fmt, ##__VA_ARGS__)
+	pr_err("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
 #define exfat_warn(sb, fmt, ...)					\
-	exfat_msg(sb, KERN_WARNING, fmt, ##__VA_ARGS__)
+	pr_warn("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
 #define exfat_info(sb, fmt, ...)					\
-	exfat_msg(sb, KERN_INFO, fmt, ##__VA_ARGS__)
+	pr_info("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
+#define exfat_debug(sb, fmt, ...)					\
+	pr_debug("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
 
 void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 tz, __le16 time, __le16 date, u8 time_cs);
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 9380e0188b55..2e1a1a6b1021 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -46,23 +46,6 @@ void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
 	}
 }
 
-/*
- * exfat_msg() - print preformated EXFAT specific messages.
- * All logs except what uses exfat_fs_error() should be written by exfat_msg()
- */
-void exfat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-	vaf.fmt = fmt;
-	vaf.va = &args;
-	/* level means KERN_ pacility level */
-	printk("%sexFAT-fs (%s): %pV\n", level, sb->s_id, &vaf);
-	va_end(args);
-}
-
 #define SECS_PER_MIN    (60)
 #define TIMEZONE_SEC(x)	((x) * 15 * SECS_PER_MIN)
 
-- 
2.35.3

