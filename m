Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117CB5BEDDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 21:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiITTgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 15:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiITTgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174C47285E
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663702599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aXOUicD8m2wUDdpQaEIdZ33TfsG0Pt6psSrh+0P/vhQ=;
        b=BkNMPvIGoSN6YISxmSiWoe0P1IQrNruCul5KcbtI8R0Svsu8kbqBH+OY4ruDY16XDoOxCu
        Oazv/3KoFZv2He2QKjyl22ZkV5mo6scSO2Kc4/5FFHwvit+afEr32hpCP96eQbR06WvPYw
        ks2lQGWw8PlMUXEJ/59nUeigrVxvWa0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-pcvK2KfDMmumIiNPk4W88Q-1; Tue, 20 Sep 2022 15:36:38 -0400
X-MC-Unique: pcvK2KfDMmumIiNPk4W88Q-1
Received: by mail-ej1-f69.google.com with SMTP id jg32-20020a170907972000b0077ce313a8f0so1955568ejc.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aXOUicD8m2wUDdpQaEIdZ33TfsG0Pt6psSrh+0P/vhQ=;
        b=yknAaJm89OKU+MVe9u0FfWjxhbZ8IB1sXphl7f5yt75cZurKvjCDIp0uoDNwXF1x9q
         cF0RxntJcMP10cK+a5SjiLI/E+62t1lyf8pQ9lh6TgW/FxFrmWca04VxyaYtbCgRu3OH
         etjkbMIEPSB3hNvNEbxlAcwg5basB4LLexu032TLZci4kp5deGFpy0YvrHd/8G1H46KQ
         3zluzrjy/gSLuWu7ZpjdnIqkZ/OAiV4Z++n8QKzUzBSa/v6ZO477RyRpj/5++dV15ufO
         ltvVMdFegSoDXvV1CINQnc8dr8U6+bJBW3Rh2wui0Nv/l+u7an3IjEpqGbJ9Z70/Pen4
         4/hA==
X-Gm-Message-State: ACrzQf0IEvJR9AA7xCsTiA313R8/1THMfcu0i2uzmCDfIqSo/lReJDXl
        7Weuzct3/IJ+bBg9N2EY4YUABCZsFo8XNNNC6hs4zADX2dtUG3QUqOQpDSc0qFZ0lp+yIwrQFl5
        fjIgkRSQqMZWBNDD4HnCcbfeh1DxFQ4C3uXy9+Wk/3kQE8QGUO0wRmEyhE+0XhpkeJunA6m4T2t
        uasw==
X-Received: by 2002:a17:907:270c:b0:76f:afae:2705 with SMTP id w12-20020a170907270c00b0076fafae2705mr17609848ejk.463.1663702596597;
        Tue, 20 Sep 2022 12:36:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6s+UGGiK1pEmf8uw96ovDGIYIqQk3tyNcgoHk1wdq8w4flnYCk2X7DFGVfQnw4w4EMyFy+xw==
X-Received: by 2002:a17:907:270c:b0:76f:afae:2705 with SMTP id w12-20020a170907270c00b0076fafae2705mr17609824ejk.463.1663702596282;
        Tue, 20 Sep 2022 12:36:36 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id p5-20020aa7d305000000b0045184540cecsm391821edq.36.2022.09.20.12.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:36:35 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v3 2/9] hugetlbfs: cleanup mknod and tmpfile
Date:   Tue, 20 Sep 2022 21:36:25 +0200
Message-Id: <20220920193632.2215598-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920193632.2215598-1-mszeredi@redhat.com>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Duplicate the few lines that are shared between hugetlbfs_mknod() and
hugetlbfs_tmpfile().

This is a prerequisite for sanely changing the signature of ->tmpfile().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/hugetlbfs/inode.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f7a5b5124d8a..0b458beb318c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -885,33 +885,18 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 /*
  * File creation. Allocate an inode, and we're done..
  */
-static int do_hugetlbfs_mknod(struct inode *dir,
-			struct dentry *dentry,
-			umode_t mode,
-			dev_t dev,
-			bool tmpfile)
+static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+			   struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	struct inode *inode;
-	int error = -ENOSPC;
 
 	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
-	if (inode) {
-		dir->i_ctime = dir->i_mtime = current_time(dir);
-		if (tmpfile) {
-			d_tmpfile(dentry, inode);
-		} else {
-			d_instantiate(dentry, inode);
-			dget(dentry);/* Extra count - pin the dentry in core */
-		}
-		error = 0;
-	}
-	return error;
-}
-
-static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
-			   struct dentry *dentry, umode_t mode, dev_t dev)
-{
-	return do_hugetlbfs_mknod(dir, dentry, mode, dev, false);
+	if (!inode)
+		return -ENOSPC;
+	dir->i_ctime = dir->i_mtime = current_time(dir);
+	d_instantiate(dentry, inode);
+	dget(dentry);/* Extra count - pin the dentry in core */
+	return 0;
 }
 
 static int hugetlbfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
@@ -935,7 +920,14 @@ static int hugetlbfs_tmpfile(struct user_namespace *mnt_userns,
 			     struct inode *dir, struct dentry *dentry,
 			     umode_t mode)
 {
-	return do_hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0, true);
+	struct inode *inode;
+
+	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode | S_IFREG, 0);
+	if (!inode)
+		return -ENOSPC;
+	dir->i_ctime = dir->i_mtime = current_time(dir);
+	d_tmpfile(dentry, inode);
+	return 0;
 }
 
 static int hugetlbfs_symlink(struct user_namespace *mnt_userns,
-- 
2.37.3

