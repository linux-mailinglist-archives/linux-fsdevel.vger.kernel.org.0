Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C22C79E0F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 09:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbjIMHiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 03:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238601AbjIMHiH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:38:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8315B198A;
        Wed, 13 Sep 2023 00:38:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c1c66876aso826485266b.2;
        Wed, 13 Sep 2023 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694590682; x=1695195482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGPyIb1HGq4abaYVspi7B35g7rbpHLusTwiCCwBXkZ8=;
        b=Qx0MY4EDbi7tb9LhPHOyZ6khx3GkjpzMDTnwabmmLrE2DlLcpuFBE3zf0NeuU6mgBz
         4E3BFlMQJJITmBcn2q6ddl0ODPJu3NHWHxXGZ+EaceR860h3RPsL0S3LLj2T7VLPDE7l
         1IAvevNJgcjR6u4HJ4vqsvWSLnfwTxB9niHSswOdpK9y1nP+blix19ooowH+SV5btZ/W
         cNKoHJtIXFAoYluyAQkqXn5nk/H2N3jLvdI0Zg4ojDvV3wP0GM24MoUxDac4s28BtTN4
         eR9JQ4uP6ryjNs55m8FDfeicNsC11EEJWUxLus2hbcQ45HQc805MzgOXGvBzpUrnigv4
         ioig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694590682; x=1695195482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGPyIb1HGq4abaYVspi7B35g7rbpHLusTwiCCwBXkZ8=;
        b=LocL9LAu4P4ie54BDloX6b45wUGIedJPYieczdydWlvaYiFzGGCuXTQiQWU3Hpdkyw
         +VGEgXcVFKSqUFgOBO+vy0kGGsX5Kt+9C0N+e+tOUAEV0yvKcLLU4UdLsoIo5Dq0NVp2
         3DVlHVABcWs9cidrn2bKopoDyNQmyxSQ8grBLHIbK65wQeSgfcQlhnNyXc62mj/N4/TT
         InMgOWk1qdlvcBJJ1eDKzVZz9bY8UqlIOusd3gFvr+PKBg3Bot3hlq3E71hW+5To9xG3
         JzD9K+p04VZWIoVBLvJYpYYzjG/l2DPqUGhti6Vb/ws48M7KRqhhTZsDeVzLZ6x81jfd
         IfGQ==
X-Gm-Message-State: AOJu0YzgJ47iXOiDqhOtste6uNBKV37LBsN+mSc3nCEY5O5P4PsYtjWY
        fyaW6tw0sYitblFvRjMFmtY=
X-Google-Smtp-Source: AGHT+IFazP25PdmSVaA59gaWkoWmpxuKWAh/oziE3J+wRE+dDHxnvuwLhC3zDhLCwTe9w/W6w0UlFg==
X-Received: by 2002:a17:907:78d9:b0:9a5:b8c1:916c with SMTP id kv25-20020a17090778d900b009a5b8c1916cmr1190698ejc.30.1694590681641;
        Wed, 13 Sep 2023 00:38:01 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id lz24-20020a170906fb1800b009932337747esm7906691ejb.86.2023.09.13.00.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:38:00 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [PATCH] ima: fix wrong dereferences of file->f_path
Date:   Wed, 13 Sep 2023 10:37:55 +0300
Message-Id: <20230913073755.3489676-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When storing IMA xattr on an overlayfs inode, the xattr is actually
stored in the inode of the underlying (a.k.a real) filesystem, so there
is an ambiguity whether this IMA xattr describes the integrity of the
overlayfs inode or the real inode.

For this reason and other reasons, IMA is not supported on overlayfs,
in the sense that integrity checking on the overlayfs inode/file/path
do not work correctly and have undefined behavior and the IMA xattr
always describes the integrity of the real inode.

When a user operates on an overlayfs file, whose underlying real file
has IMA enabled, IMA should always operate on the real path and not
on the overlayfs path.

IMA code already uses the helper file_dentry() to get the dentry
of the real file. Dereferencing file->f_path directly means that IMA
will operate on the overlayfs inode, which is wrong.

Therefore, all dereferences to f_path were converted to use the
file_real_path() helper.

Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-unionfs/0000000000005bd097060530b758@google.com/
Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Mimi,

Some of the wrong f_path dereferences are much older than the Fixes
commit, but they did not have as big an impact as the wrong f_path
dereference that the Fixes commit introduced.

For example, commit a408e4a86b36 ("ima: open a new file instance if no
read permissions") worked because reading the content of the overlayfs
file has the same result as reading the content of the real file, but it
is actually the real file integrity that we want to verify.

Anyway, the real path information, that is now available via the
file_real_path() helper, was not available in IMA itegrity check context
at the time that commit a408e4a86b36 was merged.

Thanks,
Amir.

 security/integrity/ima/ima_api.c    |  4 ++--
 security/integrity/ima/ima_crypto.c |  2 +-
 security/integrity/ima/ima_main.c   | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 452e80b541e5..badf3784a1a0 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -268,8 +268,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	 * to an initial measurement/appraisal/audit, but was modified to
 	 * assume the file changed.
 	 */
-	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
-				   AT_STATX_SYNC_AS_STAT);
+	result = vfs_getattr_nosec(file_real_path(file), &stat,
+				   STATX_CHANGE_COOKIE, AT_STATX_SYNC_AS_STAT);
 	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
 		i_version = stat.change_cookie;
 	hash.hdr.algo = algo;
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 51ad29940f05..e6c52f3c8f37 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -555,7 +555,7 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
 		int flags = file->f_flags & ~(O_WRONLY | O_APPEND |
 				O_TRUNC | O_CREAT | O_NOCTTY | O_EXCL);
 		flags |= O_RDONLY;
-		f = dentry_open(&file->f_path, flags, file->f_cred);
+		f = dentry_open(file_real_path(file), flags, file->f_cred);
 		if (IS_ERR(f))
 			return PTR_ERR(f);
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 365db0e43d7c..87c13effbdf4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -94,7 +94,7 @@ static int mmap_violation_check(enum ima_hooks func, struct file *file,
 		inode = file_inode(file);
 
 		if (!*pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
-			*pathname = ima_d_path(&file->f_path, pathbuf,
+			*pathname = ima_d_path(file_real_path(file), pathbuf,
 					       filename);
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, *pathname,
 				    "mmap_file", "mmapped_writers", rc, 0);
@@ -142,7 +142,7 @@ static void ima_rdwr_violation_check(struct file *file,
 	if (!send_tomtou && !send_writers)
 		return;
 
-	*pathname = ima_d_path(&file->f_path, pathbuf, filename);
+	*pathname = ima_d_path(file_real_path(file), pathbuf, filename);
 
 	if (send_tomtou)
 		ima_add_violation(file, *pathname, iint,
@@ -168,7 +168,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
 					    &iint->atomic_flags);
 		if ((iint->flags & IMA_NEW_FILE) ||
-		    vfs_getattr_nosec(&file->f_path, &stat,
+		    vfs_getattr_nosec(file_real_path(file), &stat,
 				      STATX_CHANGE_COOKIE,
 				      AT_STATX_SYNC_AS_STAT) ||
 		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
@@ -347,7 +347,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		goto out_locked;
 
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
-		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
+		pathname = ima_d_path(file_real_path(file), &pathbuf, filename);
 
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
@@ -487,7 +487,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 		result = -EPERM;
 
 	file = vma->vm_file;
-	pathname = ima_d_path(&file->f_path, &pathbuf, filename);
+	pathname = ima_d_path(file_real_path(file), &pathbuf, filename);
 	integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, pathname,
 			    "collect_data", "failed-mprotect", result, 0);
 	if (pathbuf)
-- 
2.34.1

