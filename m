Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7CD7368D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 12:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjFTKIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 06:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjFTKHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:07:34 -0400
Received: from forward204a.mail.yandex.net (forward204a.mail.yandex.net [178.154.239.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA41172B;
        Tue, 20 Jun 2023 03:07:19 -0700 (PDT)
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
        by forward204a.mail.yandex.net (Yandex) with ESMTP id 13770497AF;
        Tue, 20 Jun 2023 12:55:51 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id 28811463BB;
        Tue, 20 Jun 2023 12:55:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Utd7jIuDca60-Htt71yOI;
        Tue, 20 Jun 2023 12:55:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687254943;
        bh=sUfHCacVyDt7Kg3HyQ2KiMmhLhRyXxIZpN8hmjW6jXw=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=ceuQ+TxZ2P+d+L+jTkyDGA54u/cllL0gz+lX6yj7P9w6wz/m2WNtjsLtnH5kiKyLl
         G0BFqq4UGx/D20fJUH1w3ehXFfQROT2L5XWvgmxREKmLIT5EN/VEfHf68rydRZz/xW
         MJLXWtUocgpoqlfk9HxgeD6vK3xu9D6/z0o11nzo=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] fs/locks: F_UNLCK extension for F_OFD_GETLK
Date:   Tue, 20 Jun 2023 14:55:05 +0500
Message-Id: <20230620095507.2677463-2-stsp2@yandex.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620095507.2677463-1-stsp2@yandex.ru>
References: <20230620095507.2677463-1-stsp2@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently F_UNLCK with F_OFD_GETLK returns -EINVAL.
The proposed extension allows to use it for getting the lock
information from the particular fd.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org

---
 fs/locks.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index df8b26a42524..210766007e63 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -868,6 +868,21 @@ static bool posix_locks_conflict(struct file_lock *caller_fl,
 	return locks_conflict(caller_fl, sys_fl);
 }
 
+/* Determine if lock sys_fl blocks lock caller_fl. Used on xx_GETLK
+ * path so checks for additional GETLK-specific things like F_UNLCK.
+ */
+static bool posix_test_locks_conflict(struct file_lock *caller_fl,
+				      struct file_lock *sys_fl)
+{
+	/* F_UNLCK checks any locks on the same fd. */
+	if (caller_fl->fl_type == F_UNLCK) {
+		if (!posix_same_owner(caller_fl, sys_fl))
+			return false;
+		return locks_overlap(caller_fl, sys_fl);
+	}
+	return posix_locks_conflict(caller_fl, sys_fl);
+}
+
 /* Determine if lock sys_fl blocks lock caller_fl. FLOCK specific
  * checking before calling the locks_conflict().
  */
@@ -901,7 +916,7 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 retry:
 	spin_lock(&ctx->flc_lock);
 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
-		if (!posix_locks_conflict(fl, cfl))
+		if (!posix_test_locks_conflict(fl, cfl))
 			continue;
 		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable
 			&& (*cfl->fl_lmops->lm_lock_expirable)(cfl)) {
@@ -2207,7 +2222,8 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
 	if (fl == NULL)
 		return -ENOMEM;
 	error = -EINVAL;
-	if (flock->l_type != F_RDLCK && flock->l_type != F_WRLCK)
+	if (cmd != F_OFD_GETLK && flock->l_type != F_RDLCK
+			&& flock->l_type != F_WRLCK)
 		goto out;
 
 	error = flock_to_posix_lock(filp, fl, flock);
@@ -2414,7 +2430,8 @@ int fcntl_getlk64(struct file *filp, unsigned int cmd, struct flock64 *flock)
 		return -ENOMEM;
 
 	error = -EINVAL;
-	if (flock->l_type != F_RDLCK && flock->l_type != F_WRLCK)
+	if (cmd != F_OFD_GETLK && flock->l_type != F_RDLCK
+			&& flock->l_type != F_WRLCK)
 		goto out;
 
 	error = flock64_to_posix_lock(filp, fl, flock);
-- 
2.39.2

