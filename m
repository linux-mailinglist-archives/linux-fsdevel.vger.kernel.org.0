Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2638257E307
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiGVO32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 10:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiGVO3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:29:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B644E9DC8A;
        Fri, 22 Jul 2022 07:29:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 74CC8205A9;
        Fri, 22 Jul 2022 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658500161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCKgMpdkoeUUmrvULH1dWwj7dlOEZPQRX7TkZqgDpa4=;
        b=Yc35hzLyAZtRyx/gkkZQ6jJq0h60rkG7VQjP+zXnqSttVQOG6g5TIyejGHZBf6xkAsK5Ek
        0tLSQQmj8j7ei0JO51d3Z1D3ted43d8UEXm9FQIW2Qlqnpf0NxofEIxcs2WI+ijn5Q+zLb
        xGIVPiP6zO3GaOU2fBCy9GQ9nUmCX/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658500161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCKgMpdkoeUUmrvULH1dWwj7dlOEZPQRX7TkZqgDpa4=;
        b=FM8aUJbPAswDHtFCAArvU+V7khKgfSVmACrz5G8xhPjFF2x3K0aQAlIVSfo0cmZSjv/6Od
        2GguCqArmMzjqNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5269013ABC;
        Fri, 22 Jul 2022 14:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ID5hE0G02mJ7bwAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 22 Jul 2022 14:29:21 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] exfat: Expand exfat_err() and co directly to pr_*() macro
Date:   Fri, 22 Jul 2022 16:29:15 +0200
Message-Id: <20220722142916.29435-4-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220722142916.29435-1-tiwai@suse.de>
References: <20220722142916.29435-1-tiwai@suse.de>
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

Currently the error and info messages handled by exfat_err() and co
are tossed to exfat_msg() function that does nothing but passes the
strings with printk() invocation.  Not only that this is more overhead
by the indirect calls, but also this makes harder to extend for the
debug print usage; because of the direct printk() call, you cannot
make it for dynamic debug or without debug like the standard helpers
such as pr_debug() or dev_dbg().

For addressing the problem, this patch replaces exfat_msg() function
with a macro to expand to pr_*() directly.  This allows us to create
exfat_debug() macro that is expanded to pr_debug() (which output can
gracefully suppressed via dyndbg).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 fs/exfat/exfat_fs.h | 15 ++++++++++-----
 fs/exfat/misc.c     | 17 -----------------
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f431327af459..a5bc0fc11f79 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -508,14 +508,19 @@ void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
 #define exfat_fs_error_ratelimit(sb, fmt, args...) \
 		__exfat_fs_error(sb, __ratelimit(&EXFAT_SB(sb)->ratelimit), \
 		fmt, ## args)
-void exfat_msg(struct super_block *sb, const char *lv, const char *fmt, ...)
-		__printf(3, 4) __cold;
+
+/* expand to pr_xxx() with prefix */
+#define exfat_msg(sb, lv, fmt, ...) \
+	pr_##lv("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
+
 #define exfat_err(sb, fmt, ...)						\
-	exfat_msg(sb, KERN_ERR, fmt, ##__VA_ARGS__)
+	exfat_msg(sb, err, fmt, ##__VA_ARGS__)
 #define exfat_warn(sb, fmt, ...)					\
-	exfat_msg(sb, KERN_WARNING, fmt, ##__VA_ARGS__)
+	exfat_msg(sb, warn, fmt, ##__VA_ARGS__)
 #define exfat_info(sb, fmt, ...)					\
-	exfat_msg(sb, KERN_INFO, fmt, ##__VA_ARGS__)
+	exfat_msg(sb, info, fmt, ##__VA_ARGS__)
+#define exfat_debug(sb, fmt, ...)					\
+	exfat_msg(sb, debug, fmt, ##__VA_ARGS__)
 
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

