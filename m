Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A22298D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbgGVM7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 08:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgGVM7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:59:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E8C0619DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 88so1827264wrh.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LDIZNgi94GiXOtORkm5SjaKnLd9AG9vo4a42BVfLa+w=;
        b=Z10qrMUd5wwTiwqazU7e1BKBn4UrbKmyTBPUW+87/xmF3X1irHRRiK42otsRnv7TGL
         NPwx+OYwhTIcSdf/WOT2KUVoaC9Up3EZy67466pzLsYt4roI12JlwXEwOilo8cE54hnt
         TFVeukq8WGPQFEZYNHI9qIAerd07igm/qlm/I7Q1a534usaPz9I9qwFh7f3PIX+lBE8S
         mWC0N00M53rFJcCUVptN1KmVXcKF6dcjKhJSBQ90v1qmCqGNRxcRPQD138RsdRECh7am
         wQLlTMe56vfpLUJrxh98t1H4PijDEmK7f/AjV40Nrx/b0rowiRmLh1GbqlmK6o2vrMHE
         LaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LDIZNgi94GiXOtORkm5SjaKnLd9AG9vo4a42BVfLa+w=;
        b=uVwedmXL3ac4LN4009snmKbpI9HZ1vtS+A7qFu3T/3Ktb9uVMYecmoUHO/ZFgRmKKn
         6s/n2G2dNCAhNKdP0+kVZsD2ZMqjZm5jgYsUS99JULEkCGR5IEue7sNYy6Bk6XO1ub0i
         DhMkqjYHLj1AzLbLoIwi27Y7q6J7q6NkwijXRDGPADjsabNoQqsU8s8JNVu5GkN3xLdp
         c9i0OUEPoxQcfyOBH76XZAweO6hhB3odUmoTYtTOop1nrER4Rt8w3YJO6xIjHFRinKC+
         OCDVm+F9075bg1oUJp2a214bBm/EFSB4NTmPNW0eum6nZKqa9NkZVUZ/J8JC/uBq9dDh
         xWSg==
X-Gm-Message-State: AOAM532RgKdEpKUyR8lLVvIEgvlX2i1UQy1wS9JFXCM1gpPHxzEW8TUk
        8oiG/sDf7e4HMt09DmF5slE3y9yc
X-Google-Smtp-Source: ABdhPJx51L5Tw5ehb3BYPCtYsCJyYQS9zezZVsqQ9qRGC2DmyCE7z6QzP8Q+erk5oDnE2EGGfiA7iw==
X-Received: by 2002:adf:e486:: with SMTP id i6mr16879281wrm.258.1595422754414;
        Wed, 22 Jul 2020 05:59:14 -0700 (PDT)
Received: from localhost.localdomain ([31.210.180.214])
        by smtp.gmail.com with ESMTPSA id s4sm35487744wre.53.2020.07.22.05.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:59:13 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 9/9] fsnotify: pass inode to fsnotify_parent()
Date:   Wed, 22 Jul 2020 15:58:49 +0300
Message-Id: <20200722125849.17418-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722125849.17418-1-amir73il@gmail.com>
References: <20200722125849.17418-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can get inode by dereferenceing dentry->d_inode, but that may have
performance impact in the fast path of non watched file.

Kernel test robot reported a performance regression in concurrent open
workload, so maybe that can fix it.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Fixes: c738fbabb0ff ("fsnotify: fold fsnotify() call into fsnotify_parent()")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index d9b26c6552ee..4a9b2f5b819b 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -49,10 +49,9 @@ static inline void fsnotify_inode(struct inode *inode, __u32 mask)
 
 /* Notify this dentry's parent about a child's events. */
 static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
-				  const void *data, int data_type)
+				  const void *data, int data_type,
+				  struct inode *inode)
 {
-	struct inode *inode = d_inode(dentry);
-
 	if (S_ISDIR(inode->i_mode)) {
 		mask |= FS_ISDIR;
 
@@ -77,7 +76,8 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
  */
 static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 {
-	fsnotify_parent(dentry, mask, d_inode(dentry), FSNOTIFY_EVENT_INODE);
+	fsnotify_parent(dentry, mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
+			d_inode(dentry));
 }
 
 static inline int fsnotify_file(struct file *file, __u32 mask)
@@ -87,7 +87,8 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 	if (file->f_mode & FMODE_NONOTIFY)
 		return 0;
 
-	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
+	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH,
+			       file_inode(file));
 }
 
 /* Simple call site for access decisions */
-- 
2.17.1

