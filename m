Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA722035F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEPK1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:27:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34529 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfEPK1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:27:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8so1360395wrt.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8uMm+ah3xFXkku1nch1pEhGBu98y4pTUZbVq8XNm008=;
        b=UBIC8UNAa5NZRHO4B/F7lPCcdDz7U1hVhcDs1YxYW8+MgYyUVRj/Lv37RXutRepUKz
         fz7f6K2AZ5eRC741zKosqYdmuSTDjOXwYlmGZkQoVpd08GXPeKfVlBSIwz/zjKeIoP2M
         ZpreUTGkLelLQiEj9//X3ajkiNtMhOa+HbI+AGFyzWYMtKtLstgCUIR1ToLvpKgTQj75
         1o4LETVQz5dkdEdQrzAkFzY/nWm4Y2PAlTAVHF+PX8QuJ9lfAQv9NpgGShXKTwmStszj
         D4217S77mTjOkKW01vKbuPyPjKzeY3ZbJGEIOanU2ODGPOjX9eAmy9MI59IbeBAwNmQk
         dAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8uMm+ah3xFXkku1nch1pEhGBu98y4pTUZbVq8XNm008=;
        b=K0NNSMNhio+BN3bYzIrwa7dCHK/bjQ2yg/UqGCzucCy9bvK3NBMiEjbc/iAfBUbxub
         rmAISaeOq2s2ttGsr9vqDM477uovITW2Cr6Rf2tDFOcSCJ6QO4QU5uxPG/+CKLCtkVFU
         /9UtbaFzUW733OtU+pk88kjQh17Da+tGfWh2Ue5oAjwU1nrZ5xVFA58R6QH2rnFsgYGL
         8/vH6OmxXIupudJ3qpwTpwGDrhx2/IqTzGk117q/lr8lxaS7yBFlvuq5eULtF1Ms3VT0
         0aSxGWVd7tkCdGyiG48Ql9rTVQeguVo9nJ9oQS846PyMRZBqZYb8+4FmKoayocQlvWbP
         81cQ==
X-Gm-Message-State: APjAAAVutxs7zDvzBw5F8wwqs5Nc6pQy8+bl+XT3vUAGPpQ42W26Jf/V
        2gAVoBgPZUBFPaIep8vp1U6mDnxj
X-Google-Smtp-Source: APXvYqxcZZIvatMaOm++md73i5zZYn8rj7fZPVd1moKnVpDsVFMP6tWhMWoNiMtMY50VASTOpoJvzw==
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr26836621wrp.320.1558002421216;
        Thu, 16 May 2019 03:27:01 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:27:00 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 06/14] fs: convert debugfs to use simple_remove() helper
Date:   Thu, 16 May 2019 13:26:33 +0300
Message-Id: <20190516102641.6574-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/debugfs/inode.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index acef14ad53db..bc96198df1d4 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -617,13 +617,10 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_symlink);
 
-static void __debugfs_remove_file(struct dentry *dentry, struct dentry *parent)
+static void __debugfs_file_removed(struct dentry *dentry)
 {
 	struct debugfs_fsdata *fsd;
 
-	simple_unlink(d_inode(parent), dentry);
-	d_delete(dentry);
-
 	/*
 	 * Paired with the closing smp_mb() implied by a successful
 	 * cmpxchg() in debugfs_file_get(): either
@@ -643,18 +640,9 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
 	int ret = 0;
 
 	if (simple_positive(dentry)) {
-		dget(dentry);
-		if (!d_is_reg(dentry)) {
-			if (d_is_dir(dentry))
-				ret = simple_rmdir(d_inode(parent), dentry);
-			else
-				simple_unlink(d_inode(parent), dentry);
-			if (!ret)
-				d_delete(dentry);
-		} else {
-			__debugfs_remove_file(dentry, parent);
-		}
-		dput(dentry);
+		ret = simple_remove(d_inode(parent), dentry);
+		if (d_is_reg(dentry))
+			__debugfs_file_removed(dentry);
 	}
 	return ret;
 }
-- 
2.17.1

