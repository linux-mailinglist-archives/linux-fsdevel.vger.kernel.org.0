Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1188A7B007B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjI0JfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjI0Je7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C71F19F;
        Wed, 27 Sep 2023 02:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A4C4F1FD68;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z5OCfoVmTsaBL2Gfx6TUXOFq7TTPvyZsCL/Ny27Rypk=;
        b=OtRd956PzORnCmj7nHXnA7pNQIlJ5q2TgW7rGbbbcBidcmE/oPQ0+xbSRBPqu4Fu4amFTS
        viF4wcZzVfAfJiyQvf1CkJ6XliKsW9xJh4sOwI3pUeRDTioCrngwtK9DKqKZliBWTYxTH5
        Z9vxxvmWnZ/OpZwgbBzQYXsj0B1ZH98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z5OCfoVmTsaBL2Gfx6TUXOFq7TTPvyZsCL/Ny27Rypk=;
        b=tY2GuTgZlnT5Jv2rXYOdnpLhg2ktTanaP+bwzW0VL3v1Rynzt1SUzLw8ou/UzDEnayGoR3
        YU7Zew8b7zW8m9Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 929151338F;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bDrFIzT3E2UjEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6526AA07EA; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-pm@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH 17/29] PM: hibernate: Drop unused snapshot_test argument
Date:   Wed, 27 Sep 2023 11:34:23 +0200
Message-Id: <20230927093442.25915-17-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3587; i=jack@suse.cz; h=from:subject; bh=ue+d316dU3wKe970FQgK6UwU0ZJMWcHPgjUjn81LUJc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cgqt+pK7mBPymiUvyrC8EZQuP5m3r6g9hplhOk gq3ZAeiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3IAAKCRCcnaoHP2RA2dA3B/ 0SRUwo54z6mYOGazjAxztad6pjzapFEcC6+7GnIe90mklxKvfI/Bndrs1pVYNkl5hv0T3m+hrMJ9c+ dkorLtXViACZ3jcRcAlmka60swIoEcgm+BnURcZSd/KhB7bH2W1XXLaGuP5GNiw19KhkW9YlzxgLrp VeTBCLxuIWacOC2JOJ4dY3ceOoZ0ip6smEsJ6il8PfLp/ZZ+Jbu7kMDxHuLQ6d5mWzgERWA8zbsNPe DDtLxZ4X3reatLC6Uu4Q+8KQTebGayXVj6IWmckDpl0aX9uszLAFvv1trks0qa3QY0+Ysl/QtpKw2D lm3Aq1XfbCaFHoCCentYIHqIRZeEl0
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

snapshot_test argument is now unused in swsusp_close() and
load_image_and_restore(). Drop it

CC: linux-pm@vger.kernel.org
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 kernel/power/hibernate.c | 14 +++++++-------
 kernel/power/power.h     |  2 +-
 kernel/power/swap.c      |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 8d35b9f9aaa3..dee341ae4ace 100644
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
 		error = swsusp_check(false);
 		if (!error)
-			error = load_image_and_restore(false);
+			error = load_image_and_restore();
 	}
 	thaw_processes();
 
@@ -952,7 +952,7 @@ static int software_resume(void)
 	/* The snapshot device should not be opened while we're running */
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
-		swsusp_close(true);
+		swsusp_close();
 		goto Unlock;
 	}
 
@@ -973,7 +973,7 @@ static int software_resume(void)
 		goto Close_Finish;
 	}
 
-	error = load_image_and_restore(true);
+	error = load_image_and_restore();
 	thaw_processes();
  Finish:
 	pm_notifier_call_chain(PM_POST_RESTORE);
@@ -987,7 +987,7 @@ static int software_resume(void)
 	pm_pr_dbg("Hibernation image not present or could not be loaded.\n");
 	return error;
  Close_Finish:
-	swsusp_close(true);
+	swsusp_close();
 	goto Finish;
 }
 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index a98f95e309a3..17fd9aaaf084 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -172,7 +172,7 @@ int swsusp_check(bool exclusive);
 extern void swsusp_free(void);
 extern int swsusp_read(unsigned int *flags_p);
 extern int swsusp_write(unsigned int flags);
-void swsusp_close(bool exclusive);
+void swsusp_close(void);
 #ifdef CONFIG_SUSPEND
 extern int swsusp_unmark(void);
 #endif
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 095a263da7c4..68a5c2f06957 100644
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
@@ -1569,7 +1569,7 @@ int swsusp_check(bool exclusive)
  * @exclusive: Close the resume device which is exclusively opened.
  */
 
-void swsusp_close(bool exclusive)
+void swsusp_close(void)
 {
 	if (IS_ERR(hib_resume_bdev_handle)) {
 		pr_debug("Image device not initialised\n");
-- 
2.35.3

