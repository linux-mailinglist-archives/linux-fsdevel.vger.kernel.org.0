Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A073F595E97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 16:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbiHPOxZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 10:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiHPOxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:53:24 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E68E113E
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 07:53:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bu15so4429700wrb.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=4llRFXnBcaQLdHTCgiOVHAzZqek7JSHT+X10DQaIJVA=;
        b=FCGe/wd30FXA5rdSvutNEet3IEKbI2M0+77NNVFFk2Q+ov5HUEGDDhAe+pTL3sOWa1
         eF1+FII/RCzch8q0fxmOmjH78cOrwsyW8lxmZGi9rdcyGBEa/JDi8hsMVMPtyuwMcl2m
         5LoSq1iNiSfG0QAcrLBZtrnTVjSpGopMZ11BXNa3bJUGIdvAonDr0SFzv5wdzNSCdlCy
         0antBLSpx/Xf7aIeED3U1TTKRbvNK18Xqeg5+Ou3QyTSMQ+TkFn5E+uivCruq86dvzIE
         ddxr42+n7QS2uRsHpofdfRgMGLMaeWO7SFlwPMQ9yPjCjRCxVMVgcGZxWJReBjIL/gu0
         T3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=4llRFXnBcaQLdHTCgiOVHAzZqek7JSHT+X10DQaIJVA=;
        b=b6KFEGwf6g2h245+33JmxgCCXsrnbxMIyWKh4JcgtOyDMPiEjvU+/HDM3eqWC5gV2T
         YpnsWQKwQK5UyF8v4zN8bZTDkqa5tqfQLzi7kebYCZDNPhtHcR3RpzwmWeK7HWyPRboW
         Gw0zBLNmlbgNZJMryi/1zMZxI2XrxCsf2vnpYsLYD/byq91qd9aGadJLC9FbbEkRPYIs
         agzX8IFx4cLN3EUlv8dkR5vMVlRI0jkHBgzuZGofYu+vU93rCYNWxc/+TppYiO/QJ90Y
         Cqtye3P0+6+n2Gn9RgiGjYv8O7AfuYpaLRVzugls4fiXeJVLiBc0Up4edT6Hc4imQlUx
         lTGQ==
X-Gm-Message-State: ACgBeo0KNjemdEzCdGJBR85VA7vSA2ot1HWQBU46EVDEapMy0W/LJVBO
        UHzSzWsc7XeUBRoRjCIEwh26q6B0heU=
X-Google-Smtp-Source: AA6agR47opgfylJC4T5TsfWONvWSsQJL1ztvl1z3y0Y6MZsyNygV4NNIL3J/PYzpY8k2XyoUISWS9A==
X-Received: by 2002:adf:e9c8:0:b0:224:f896:94bc with SMTP id l8-20020adfe9c8000000b00224f89694bcmr7416886wrn.635.1660661601824;
        Tue, 16 Aug 2022 07:53:21 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id b6-20020a05600c4e0600b003a5f4fccd4asm7569882wmq.35.2022.08.16.07.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 07:53:21 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] locks: fix TOCTOU race when granting write lease
Date:   Tue, 16 Aug 2022 17:53:17 +0300
Message-Id: <20220816145317.710368-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thread A trying to acquire a write lease checks the value of i_readcount
and i_writecount in check_conflicting_open() to verify that its own fd
is the only fd referencing the file.

Thread B trying to open the file for read will call break_lease() in
do_dentry_open() before incrementing i_readcount, which leaves a small
window where thread A can acquire the write lease and then thread B
completes the open of the file for read without breaking the write lease
that was acquired by thread A.

Fix this race by incrementing i_readcount before checking for existing
leases, same as the case with i_writecount.

Use a helper put_file_access() to decrement i_readcount or i_writecount
in do_dentry_open() and __fput().

Fixes: 387e3746d01c ("locks: eliminate false positive conflicts for write lease")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Al,

Added Jeff's RVB assuming you will be taking this patch.

Thanks,
Amir.

Changes since v2:
- Add RVB Jeff

Changes since v1:
- Move helper to internal.h

 fs/file_table.c |  7 +------
 fs/internal.h   | 10 ++++++++++
 fs/open.c       | 11 ++++-------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 99c6796c9f28..dd88701e54a9 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -324,12 +324,7 @@ static void __fput(struct file *file)
 	}
 	fops_put(file->f_op);
 	put_pid(file->f_owner.pid);
-	if ((mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
-		i_readcount_dec(inode);
-	if (mode & FMODE_WRITER) {
-		put_write_access(inode);
-		__mnt_drop_write(mnt);
-	}
+	put_file_access(file);
 	dput(dentry);
 	if (unlikely(mode & FMODE_NEED_UNMOUNT))
 		dissolve_on_fput(mnt);
diff --git a/fs/internal.h b/fs/internal.h
index 87e96b9024ce..31861e6c3eff 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -101,6 +101,16 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 extern struct file *alloc_empty_file(int, const struct cred *);
 extern struct file *alloc_empty_file_noaccount(int, const struct cred *);
 
+static inline void put_file_access(struct file *file)
+{
+	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
+		i_readcount_dec(file->f_inode);
+	} else if (file->f_mode & FMODE_WRITER) {
+		put_write_access(file->f_inode);
+		__mnt_drop_write(file->f_path.mnt);
+	}
+}
+
 /*
  * super.c
  */
diff --git a/fs/open.c b/fs/open.c
index 8a813fa5ca56..a98572585815 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -840,7 +840,9 @@ static int do_dentry_open(struct file *f,
 		return 0;
 	}
 
-	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
+	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
+		i_readcount_inc(inode);
+	} else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
 		error = get_write_access(inode);
 		if (unlikely(error))
 			goto cleanup_file;
@@ -880,8 +882,6 @@ static int do_dentry_open(struct file *f,
 			goto cleanup_all;
 	}
 	f->f_mode |= FMODE_OPENED;
-	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
-		i_readcount_inc(inode);
 	if ((f->f_mode & FMODE_READ) &&
 	     likely(f->f_op->read || f->f_op->read_iter))
 		f->f_mode |= FMODE_CAN_READ;
@@ -935,10 +935,7 @@ static int do_dentry_open(struct file *f,
 	if (WARN_ON_ONCE(error > 0))
 		error = -EINVAL;
 	fops_put(f->f_op);
-	if (f->f_mode & FMODE_WRITER) {
-		put_write_access(inode);
-		__mnt_drop_write(f->f_path.mnt);
-	}
+	put_file_access(f);
 cleanup_file:
 	path_put(&f->f_path);
 	f->f_path.mnt = NULL;
-- 
2.25.1

