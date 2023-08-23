Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B559978561B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjHWKu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjHWKuE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:50:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CEAE59;
        Wed, 23 Aug 2023 03:49:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DB8CE21F3A;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=koXdTHHczmYX77MioiKuwdIQH7N17vLhNMrB6mN2fJM=;
        b=mnpPWm8afR+9nWlKCmIpqDUUh6p5xsCEWi41UMQh7WCdYphewj06PLmgmIgZKgFCFWhkQJ
        hoSEDIEtIQ1WA2CTIV8kzq+7K6gVVwLTJCbc4P13c4dHLMH4d49yjIaAsHkLzx95gsRp54
        4WLlLP1m8AK7CBfAu5gbj037AxsRNlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=koXdTHHczmYX77MioiKuwdIQH7N17vLhNMrB6mN2fJM=;
        b=AjRGbNyN+DsbWWQwPC4gYZuNK5FCziaWFp5gMg8ROMPbwIgc9/JgnhyaqTEHZ5B3tFSouc
        Zw7lp0LQdcXNdaCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBAFE139D0;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zvW3MRrk5WRUIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6CAA4A0791; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-pm@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH 17/29] PM: hibernate: Drop unused snapshot_test argument
Date:   Wed, 23 Aug 2023 12:48:28 +0200
Message-Id: <20230823104857.11437-17-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3541; i=jack@suse.cz; h=from:subject; bh=bL9P9WbbJq+VAaQcU+81IXLuC2juctCN6GMTdhaNaNo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eP8Qf4Tspp9mvpWbL96y+M+A4TYjvK/96/tICEp pYM7WP2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj/AAKCRCcnaoHP2RA2dBMCA CoQBofnjIAeTI62/NHVLi47LWKBoYLZiEUedBt51Ai7eEozrEW5nN+mXynIkbgtM3lZUG89zspSK2b pZRpd1YWSqAJzg8p5WpPMljD9F6jMBVCY5u2l7rAg5uqhYRo3R8cg1du9LXcksiwmcfFZvVmVHQG3a 17OnqXhMkD9Usg3OHeK8vPq9GEibQ0NXSCFZ2ETyTm3e+jljlGgaUtN3ggrkpwwyWuQmg0BZbZESDr mOA6QmQTTeErquxe3mALbJ7Folydv45MsjB7VtzinqUjshvP5RPvoghz1zEy2B6D7obwwqf5310tOz fDlwPXodO2hEm2WY+/VxLy0vFdNSbj
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

snapshot_test argument is now unused in swsusp_close() and
load_image_and_restore(). Drop it

CC: linux-pm@vger.kernel.org
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
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

