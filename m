Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B02738931
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjFUPbn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 11:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjFUPba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:31:30 -0400
Received: from forward206a.mail.yandex.net (forward206a.mail.yandex.net [178.154.239.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBADDCC;
        Wed, 21 Jun 2023 08:30:57 -0700 (PDT)
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
        by forward206a.mail.yandex.net (Yandex) with ESMTP id E496247332;
        Wed, 21 Jun 2023 18:22:46 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:58f:0:640:3768:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id 7231846C65;
        Wed, 21 Jun 2023 18:22:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UMkSjYADYGk0-AkLoIPpV;
        Wed, 21 Jun 2023 18:22:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687360962;
        bh=lDc4QgnEZC8KLbodk8+haNOeCOpk4ZEgKr8+epbYZ8s=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=eIQxgQ/KENbUZ2x3qrqriO4S0ZYhAkXI/90UF2KUSj/TTbA+veewMIsiEPhYnRdqt
         0V0P/wgTHNei1+XAV7yCi7yD4HZ3Ll1e4DBnlsO+NONxMTp0e/uNDn6HZVSqkGE1/J
         BP3N5YBMk6d5ek3PfEddmifedtt1aTG0h2dxqna4=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 1/2] fs/locks: F_UNLCK extension for F_OFD_GETLK
Date:   Wed, 21 Jun 2023 20:22:12 +0500
Message-Id: <20230621152214.2720319-2-stsp2@yandex.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621152214.2720319-1-stsp2@yandex.ru>
References: <20230621152214.2720319-1-stsp2@yandex.ru>
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
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org
CC: linux-api@vger.kernel.org

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

