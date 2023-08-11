Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B26778CE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbjHKLFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjHKLFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF2EE71;
        Fri, 11 Aug 2023 04:05:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4BE1821883;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6luzPVXSDVEUOtJJ3n3omPBoNUdDHogmn1iNnmk3SJ4=;
        b=SuVjHf5WZctl55n6lUk2h3uRI+BhXIwIdWDt8rp23E6w4P7Kn2iGwIG4j7wDQ9Fft/PeYJ
        fDppUURzbUyNYvGYnmtR2lN3Q5W3FjrbxLR3hEAdhG1vjpN9Pjd10snquZTTA0o/2qsiOr
        p3SouZolZvLFwID1OQVrfil2rFX7660=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6luzPVXSDVEUOtJJ3n3omPBoNUdDHogmn1iNnmk3SJ4=;
        b=jIaCi4urD01bjLEQl8bYVLVRhjAtYVf1qHwL70t6PUXgjFJVxmnSaVWYxsagJb3KezE1Rx
        z4VrU1e2Zny+SfDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E2B5139FD;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N38rD+IV1mRmRQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 24D5FA0790; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-pm@vger.kernel.org
Subject: [PATCH 17/29] PM: hibernate: Drop unused snapshot_test argument
Date:   Fri, 11 Aug 2023 13:04:48 +0200
Message-Id: <20230811110504.27514-17-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3450; i=jack@suse.cz; h=from:subject; bh=EYiYPYIKB+WJacuyKZgkGjy+mR31pBVUNTN/L6fc2bs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXR/+ckoRxIzn1GaSHqLLvthVaos2lTm5L88vxE rm8UX3WJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYV0QAKCRCcnaoHP2RA2ek5B/ 9Pi82m0GTl08fRjdq0kEU1LfLdWe8eE/Un0pnOLzFHu/FLF7/o1AARu66tsRIu/f6mblm099QfGQVi E7qHzgthGg20b1dQz+uOgkNhqnNO7pBOBqsiBFBxvh8ALfl9WpVveGAof7/8bKe6f1r0cCixAA1yvE 8LIxzx2vBYQi2kNw8BhhP+7l2mZnvk8ebOKdvcroQrU12k0EM+ga2aYWO6zt4ltOFxaC+y2Z/ZlhP9 zXFhDphr1FpTeqGFbBxm5f21S7W30FXVImufnudg8KlwKBjr11hYxWOnNSW85ZZCi4d7Y0I7mLpCE9 tyQX61tgIk8qo6D1jw4l4x4Xn/0Xaa
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index e1b4bfa938dd..6abeec0ae084 100644
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
index b475bee282ff..17e0dad5008e 100644
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

