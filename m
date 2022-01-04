Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F867483F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 10:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiADJmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 04:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiADJmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:42:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEB2C061761;
        Tue,  4 Jan 2022 01:42:30 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u16so26701585plg.9;
        Tue, 04 Jan 2022 01:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBavY+6P4AhhIu5KXV4JGN0g0rXvcOVcqkUnHUvbmEI=;
        b=do4v1VlR1cQ+PXDpmAgySJzZvl0d/0l2CexnUH8b3qp86GOvl1xfcJdv9WQNgrorAU
         esWtAhfVTxVmAe+IY9wE0cTx+rB+I5aDZE//xLyWKQ6TLfKyKrkPHPVYIIltdz6pjVvp
         8ur55BSO5G9DeKYQi922WZqVQTCUR7Q5+fcAfxafXiV/3xoaqhcXLvVTt8sH1qJXr7mL
         MpUUtt8XgINzTsTfEMGEEUJlPt65mHIFYEZApQt0SNovKcyZRwcOspzDJ9S69IOZ2ubB
         +VMj/cp+mBzBmDgzNd4Y1bDmMfRn4a6Em9N9mwdb+CEpr2dkIiJgDeYTuM+22lIehSDb
         GgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBavY+6P4AhhIu5KXV4JGN0g0rXvcOVcqkUnHUvbmEI=;
        b=jBkJuKldN0v91eg5koyf6Yf27MMxwp1zx+Pwn89PU53wn1b1HY/x5IIuFP/Cj/DblM
         2nmVBfSYGNUnCwTVY3brnSfc0taPEIZC+ZpP0ZsCbMijdSVMsbS96tC95WcNbQp9/vwn
         oaH9YzwD5rIsYaI/RlTglY/0KVKM8IL7fUctllfmtPI7/QS+9nJGcbvbop5j93Ly1fsk
         79XyVqiexDyPjPO1bKeQtrY9pTSIEepzDnUTmVrSj0Few7kelk9apzgLp1ii/G9E9apA
         wb62Nsyd6oyX+2SDO3KtJ5QfQ+n1EQYR2Gt8KNWskEA1gEHe52ID8sIEjDrTEMf1gb7K
         CxVQ==
X-Gm-Message-State: AOAM530BsqAJzTy1qmR+GMF4C9vz2KDrXQAxKmZZlJJ7dA6yzZ+eFF46
        S7f3j92nHHfQBJ95AIV9umM=
X-Google-Smtp-Source: ABdhPJx28QNTaJK/VveT2sNgitkgXQBqWZXoIDr9GIAmel+lMB1NG8wgSEMIMBLZS0OmJ9FQLLscIg==
X-Received: by 2002:a17:902:dccc:b0:148:b08b:6871 with SMTP id t12-20020a170902dccc00b00148b08b6871mr49013566pll.147.1641289350489;
        Tue, 04 Jan 2022 01:42:30 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.151])
        by smtp.googlemail.com with ESMTPSA id f16sm43999361pfj.6.2022.01.04.01.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 01:42:30 -0800 (PST)
From:   Qinghua Jin <qhjin.dev@gmail.com>
Cc:     qhjin.dev@gmail.com, Colin Ian King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] vfs: fix bug when opening a file with O_DIRECT on a file system that does not support it will leave an empty file
Date:   Tue,  4 Jan 2022 17:42:17 +0800
Message-Id: <20220104094217.99187-1-qhjin.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Colin Ian King reported the following

1. create a minix file system and mount it
2. open a file on the file system with O_RDWR | O_CREAT | O_TRUNC | O_DIRECT
3. open fails with -EINVAL but leaves an empty file behind.  All other open() failures don't leave the
failed open files behind.

The reason is because when checking the O_DIRECT in do_dentry_open, the inode has created, and later err
processing can't remove the inode.

The patch will remove the file in last step of open in do_open().

Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>
Reported-by:  Colin Ian King <colin.king@canonical.com>
---
 fs/namei.c | 6 ++++++
 fs/open.c  | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1f9d2187c765..081feb804154 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3426,6 +3426,12 @@ static int do_open(struct nameidata *nd,
 		error = vfs_open(&nd->path, file);
 	if (!error)
 		error = ima_file_check(file, op->acc_mode);
+	if (!error && (file->f_flags & O_DIRECT)) {
+		if (!file->f_mapping->a_ops || !file->f_mapping->a_ops->direct_IO) {
+			do_unlinkat(AT_FDCWD, getname_kernel(nd->name->name));
+			return -EINVAL;
+		}
+	}
 	if (!error && do_truncate)
 		error = handle_truncate(mnt_userns, file);
 	if (unlikely(error > 0)) {
diff --git a/fs/open.c b/fs/open.c
index f732fb94600c..2829c3613c0f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -838,12 +838,6 @@ static int do_dentry_open(struct file *f,
 
 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
 
-	/* NB: we're sure to have correct a_ops only after f_op->open */
-	if (f->f_flags & O_DIRECT) {
-		if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
-			return -EINVAL;
-	}
-
 	/*
 	 * XXX: Huge page cache doesn't support writing yet. Drop all page
 	 * cache for this file before processing writes.
-- 
2.30.2

