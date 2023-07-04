Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4A8747111
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjGDMYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjGDMXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:23:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30151701;
        Tue,  4 Jul 2023 05:22:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5EB1B22872;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epv0WU7Q4U27et91WPnFbrKixsesCGX2CbQ3cj/tlUI=;
        b=ZXP60VJFhu+sbSfRhBfyow89T5mRzJLWGXBe9NFLM35Tuy46y6x0lRUby4XKhuc4XytGDg
        2tKgg2EClD8twEoIDDdlLIhu0B0JFIQArAfb99N22sjDvrFAfqyPg6qp9N3XFveRoBPA9N
        gu4FcAME0AZuEYY8ZeSTyOt0Kxunk/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epv0WU7Q4U27et91WPnFbrKixsesCGX2CbQ3cj/tlUI=;
        b=5gm/5xDWhgcbVN8H7dqfNn8C4IUWd7ZVounn7/CM22b8Pkrzw9qPc1wkiSsrHnEcyM3d9q
        sxGy2hfYoxUZ6HAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5295213A90;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CLYyFAIPpGRFMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0631BA077C; Tue,  4 Jul 2023 14:22:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-pm@vger.kernel.org
Subject: [PATCH 18/32] PM: hibernate: Drop unused snapshot_test argument
Date:   Tue,  4 Jul 2023 14:21:45 +0200
Message-Id: <20230704122224.16257-18-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3450; i=jack@suse.cz; h=from:subject; bh=C34za05j7L6pDZccfR5nhpDFkY9rraFNuB4k5il1A0Q=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7a2u861YBiFQrIuVeFUr8gaAThZWEBvh68q52Z elKrY3qJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO2gAKCRCcnaoHP2RA2cipCA DoMKrSeK3MaPvj+kMStdT1bAcaDBLlafKLWzIsh/zSwrWvV72yLtNPq5hEoLXplmozwcJLoYRvIFPn 8RH/oJaQLXU28DyR5cfikd9ZRCx3OqWfH/mfr1cTPlcZjJrOE64HVYsHIrejEn7HfKCwRGTcnDOxSy 7Ebp0R9WOzlOJGx5dwAEqwIGqkmqeizUT7GTgqvCBPHRkKZ+2T+NIpebOpl4En3lo9lvHyY9qRr+JD HZ6yOUlgXb3+0ciKxsOPIQkjZbNQLoJpbM7Ca7DFRipbapuHY64oOY7k4jLbkuPNnHbUNiZeIh77SK 61XfGa5LEg/ZIQmjeEaxVLtUUmumOR
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

snapshot_test argument is now unused in swsusp_close() and
load_image_and_restore(). Drop it

CC: linux-pm@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 kernel/power/hibernate.c | 14 +++++++-------
 kernel/power/power.h     |  2 +-
 kernel/power/swap.c      |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index f62e89d0d906..0cde44a850c7 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -684,7 +684,7 @@ static void power_down(void)
 		cpu_relax();
 }
 
-static int load_image_and_restore(bool snapshot_test)
+static int load_image_and_restore(void)
 {
 	int error;
 	unsigned int flags;
@@ -694,12 +694,12 @@ static int load_image_and_restore(bool snapshot_test)
 	lock_device_hotplug();
 	error = create_basic_memory_bitmaps();
 	if (error) {
-		swsusp_close(snapshot_test);
+		swsusp_close();
 		goto Unlock;
 	}
 
 	error = swsusp_read(&flags);
-	swsusp_close(snapshot_test);
+	swsusp_close();
 	if (!error)
 		error = hibernation_restore(flags & SF_PLATFORM_MODE);
 
@@ -788,7 +788,7 @@ int hibernate(void)
 		pm_pr_dbg("Checking hibernation image\n");
 		error = swsusp_check(snapshot_test);
 		if (!error)
-			error = load_image_and_restore(snapshot_test);
+			error = load_image_and_restore();
 	}
 	thaw_processes();
 
@@ -952,7 +952,7 @@ static int software_resume(void)
 	/* The snapshot device should not be opened while we're running */
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
-		swsusp_close(false);
+		swsusp_close();
 		goto Unlock;
 	}
 
@@ -973,7 +973,7 @@ static int software_resume(void)
 		goto Close_Finish;
 	}
 
-	error = load_image_and_restore(false);
+	error = load_image_and_restore();
 	thaw_processes();
  Finish:
 	pm_notifier_call_chain(PM_POST_RESTORE);
@@ -987,7 +987,7 @@ static int software_resume(void)
 	pm_pr_dbg("Hibernation image not present or could not be loaded.\n");
 	return error;
  Close_Finish:
-	swsusp_close(false);
+	swsusp_close();
 	goto Finish;
 }
 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 46eb14dc50c3..bebf049a51c1 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -172,7 +172,7 @@ int swsusp_check(bool snapshot_test);
 extern void swsusp_free(void);
 extern int swsusp_read(unsigned int *flags_p);
 extern int swsusp_write(unsigned int flags);
-void swsusp_close(bool snapshot_test);
+void swsusp_close(void);
 #ifdef CONFIG_SUSPEND
 extern int swsusp_unmark(void);
 #endif
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index fd90ecf15ee1..9ebac878497f 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -444,7 +444,7 @@ static int get_swap_writer(struct swap_map_handle *handle)
 err_rel:
 	release_swap_writer(handle);
 err_close:
-	swsusp_close(false);
+	swsusp_close();
 	return ret;
 }
 
@@ -509,7 +509,7 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 	if (error)
 		free_all_swap_pages(root_swap);
 	release_swap_writer(handle);
-	swsusp_close(false);
+	swsusp_close();
 
 	return error;
 }
@@ -1567,7 +1567,7 @@ int swsusp_check(bool snapshot_test)
  *	swsusp_close - close swap device.
  */
 
-void swsusp_close(bool snapshot_test)
+void swsusp_close(void)
 {
 	if (IS_ERR(hib_resume_bdev_handle)) {
 		pr_debug("Image device not initialised\n");
-- 
2.35.3

