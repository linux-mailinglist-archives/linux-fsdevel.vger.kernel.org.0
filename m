Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE6B57852F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 16:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiGROT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiGROT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:19:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD16D1FA
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 07:19:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B65FA33D3D;
        Mon, 18 Jul 2022 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658153963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZCQl51aw00MOrSomnfKOs9WdaDfI8s7DSoau3b/HXZo=;
        b=tk7vvjcume+duMdpHD6iRj2a7hVOXSmTlzEwpGP/JnrXhesUT5bLCtJgCQptQwJpV1c8Vu
        3JJzrI6XDDZ0XP+7RrlzxkS4xmlYiDcnhfv7xNW/rQ6RmWWNaPLHXw16blEhUW8fUvCWgi
        0eZK89zBnGHMZzkE+i+ZzplQ3w81eo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658153963;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZCQl51aw00MOrSomnfKOs9WdaDfI8s7DSoau3b/HXZo=;
        b=BpBhLaUCLPsO/4rpR+GhOywP0lGAS31inCewfI4305FUphQqcDp7K3rLJ1HxLWk00xeacV
        AzvU0tXjeIRrb8Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1E6E13A37;
        Mon, 18 Jul 2022 14:19:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MSKmJutr1WI2PQAAMHmgww
        (envelope-from <dmueller@suse.de>); Mon, 18 Jul 2022 14:19:23 +0000
From:   =?UTF-8?q?Dirk=20M=C3=BCller?= <dmueller@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     =?UTF-8?q?Dirk=20M=C3=BCller?= <dmueller@suse.de>
Subject: [PATCH] fs/proc: remove workaround for obsolete compiler version
Date:   Mon, 18 Jul 2022 16:19:19 +0200
Message-Id: <20220718141919.5384-1-dmueller@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

GCC 5.1+ is required, so with this change we can remove a
workaround for a really obsolete compiler version issue.

Signed-off-by: Dirk Müller <dmueller@suse.de>
---
 fs/proc/stat.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 4fb8729a68d4..9eaa59fab7bf 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -167,29 +167,17 @@ static int show_stat(struct seq_file *p, void *v)
 		u64 *cpustat = kcpustat.cpustat;
 
 		kcpustat_cpu_fetch(&kcpustat, i);
-
-		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
-		user		= cpustat[CPUTIME_USER];
-		nice		= cpustat[CPUTIME_NICE];
-		system		= cpustat[CPUTIME_SYSTEM];
-		idle		= get_idle_time(&kcpustat, i);
-		iowait		= get_iowait_time(&kcpustat, i);
-		irq		= cpustat[CPUTIME_IRQ];
-		softirq		= cpustat[CPUTIME_SOFTIRQ];
-		steal		= cpustat[CPUTIME_STEAL];
-		guest		= cpustat[CPUTIME_GUEST];
-		guest_nice	= cpustat[CPUTIME_GUEST_NICE];
 		seq_printf(p, "cpu%d", i);
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(system));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(idle));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(iowait));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(irq));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(softirq));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(steal));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(cpustat[CPUTIME_USER]));
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(cpustat[CPUTIME_NICE]));
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(cpustat[CPUTIME_SYSTEM]));
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(get_idle_time(&kcpustat, i)));
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(get_iowait_time(&kcpustat, i)));
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(cpustat[CPUTIME_IRQ]));
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(cpustat[CPUTIME_SOFTIRQ]));
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(cpustat[CPUTIME_STEAL]));
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(cpustat[CPUTIME_GUEST]));
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(cpustat[CPUTIME_GUEST_NICE]));
 		seq_putc(p, '\n');
 	}
 	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
-- 
2.37.1

