Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1066362695
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 19:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbhDPRUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 13:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbhDPRUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:20:44 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21930C061574;
        Fri, 16 Apr 2021 10:20:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id p12so19637701pgj.10;
        Fri, 16 Apr 2021 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HNdoPRhe9ydcDzsOjKuBgbIIMgX8oUiaq4I6X+MyuLg=;
        b=c/vt2HVwweliTRqSdVAM0D/2ZFdsaG03KL3iQnQ8A17zQm4+r2KYQCg+edqIEmDQFY
         7Fym+OV8RAgyTjQWUt1fdTFYz6vdFg4RNFrnCZHXDNfXNZ9k3Uxms1bFAjstw61GW/CX
         ZpZt5cpSitvmk/+jYnadKjEpg8qUELibXQvEcXYopTyDHRq8ghG7Q6mgHQS1D0J+QjYD
         ZGv/w44aeF8f4wrmwz157usBme5VCUowoA3cQf5NRR35sKYGzsczCQH2SSiVssC/rFFG
         tL9WLkAtCrwnsNBNtbwalDO8ZnEo9TNq4bD1ng1hXE6sLocDZtpVpMX6MSJ/Agl0VS/O
         SpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HNdoPRhe9ydcDzsOjKuBgbIIMgX8oUiaq4I6X+MyuLg=;
        b=WN6jdyjWR0Z1JU+12+PiiuOaBeM5T8CE6bQQZYc6rQ8ZKeoudkPhkZSoNjB0NfDA6y
         HrAbBB2aPGGpXuDbgrfFXX3hu2Xv8iSxK28Y6VXuM16Fyi2Yy9JNf80uQUU+bNlJR49m
         1QAZPSiq/NLPw9PUGAPccHalOTtsN/epUN3qbp8z/i51sHViUsOuiHbPblegPlWK7Ky3
         SxCHiGtTS62idQTQq+u5HiXaEckZry217XPJbEdxLczuqfzaX+8OSrF0gJlqBtTYttzr
         SSJuSKX0bPZYu4OJCeWMpzOYIJU/8i6Bg9P4HGjOvUtzx5sl03o4TR1BOf24HA+DsrbM
         Sqpg==
X-Gm-Message-State: AOAM530o5To5AU3PWf71Rz+KhPLgpFg6yF1RHHYea0iXWHsWXIFvndTc
        IQOjUcrphuP+uSrewy9vAfQIwV5jW/MU+w==
X-Google-Smtp-Source: ABdhPJz0reBgvQimWpOzDOCBMDyxNNikEwZd815dZP5BsTmzz2ngQ88C+BlAqQw+15z4ykfcS457sA==
X-Received: by 2002:a63:1a50:: with SMTP id a16mr164697pgm.92.1618593617602;
        Fri, 16 Apr 2021 10:20:17 -0700 (PDT)
Received: from localhost.localdomain (220-130-175-235.HINET-IP.hinet.net. [220.130.175.235])
        by smtp.gmail.com with ESMTPSA id 33sm5536776pgq.21.2021.04.16.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 10:20:17 -0700 (PDT)
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
X-Google-Original-From: Chung-Chiang Cheng <cccheng@synology.com>
To:     christian.brauner@ubuntu.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     cccheng@synology.com
Subject: [PATCH] hfsplus: prevent negative dentries when casefolded
Date:   Sat, 17 Apr 2021 01:20:12 +0800
Message-Id: <20210416172012.8667-1-cccheng@synology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hfsplus uses the case-insensitive filenames by default, but VFS negative
dentries are incompatible with case-insensitive. For example, the
following instructions will get a cached filename 'aaa' which isn't
expected. There is no such problem in macOS.

  touch aaa
  rm aaa
  touch AAA

This patch just takes the same approach as ext4 and f2fs to prevent
negative dentries for this issue.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/hfsplus/dir.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 03e6c046faf4..fcab8f09b6af 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -121,6 +121,9 @@ static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 	if (S_ISREG(inode->i_mode))
 		HFSPLUS_I(inode)->linkid = linkid;
 out:
+	/* Prevent the negative dentry in the casefolded form from being cached */
+	if (!inode && test_bit(HFSPLUS_SB_CASEFOLD, &HFSPLUS_SB(sb)->flags))
+		return NULL;
 	return d_splice_alias(inode, dentry);
 fail:
 	hfs_find_exit(&fd);
@@ -407,6 +410,12 @@ static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
 		sbi->file_count--;
 	inode->i_ctime = current_time(inode);
 	mark_inode_dirty(inode);
+
+	/* VFS negative dentries are incompatible with encoding and
+	 * case-insensitiveness
+	 */
+	if (test_bit(HFSPLUS_SB_CASEFOLD, &sbi->flags))
+		d_invalidate(dentry);
 out:
 	mutex_unlock(&sbi->vh_mutex);
 	return res;
@@ -429,6 +438,12 @@ static int hfsplus_rmdir(struct inode *dir, struct dentry *dentry)
 	inode->i_ctime = current_time(inode);
 	hfsplus_delete_inode(inode);
 	mark_inode_dirty(inode);
+
+	/* VFS negative dentries are incompatible with encoding and
+	 * case-insensitiveness
+	 */
+	if (test_bit(HFSPLUS_SB_CASEFOLD, &sbi->flags))
+		d_invalidate(dentry);
 out:
 	mutex_unlock(&sbi->vh_mutex);
 	return res;
-- 
2.25.1

