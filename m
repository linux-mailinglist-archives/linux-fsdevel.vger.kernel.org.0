Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0725BCE1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 16:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiISOKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 10:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiISOKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C7015FCB
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663596640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anOQA/oJUS71LYPqHcQLEIYyutVeIxZG9umMeWdqoZk=;
        b=V/ZAsfouujEVbTfSOQY8qyxd6254F8E9jcuZVeq+1E9RfFZRcTdrcytK38QkygXKJY3a1M
        XLHIB4X0zxAlDzvsCQdCTbbIE43eX+FOym+gi09s6iNmC4cLuUsXMex0DTsxhdpC8J9DJ3
        eVygwIAMbI7My7tsDXsLMylzzDTFPUE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-SqyZrmtpPxuCe-e0graiiw-1; Mon, 19 Sep 2022 10:10:38 -0400
X-MC-Unique: SqyZrmtpPxuCe-e0graiiw-1
Received: by mail-ed1-f69.google.com with SMTP id c6-20020a05640227c600b004521382116dso15417154ede.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=anOQA/oJUS71LYPqHcQLEIYyutVeIxZG9umMeWdqoZk=;
        b=7iCBzTBARBOO0UdrWySZrne9jUSujBWA1JzH2rANbDfqv2yuIx7DxOQJkI9vInmsW1
         XhNJDgDS1qser4MPQ5KLn93FTXxqpo2Dt6W2/V8PNlxtAbr4LxT8n7Kcl/5imgkTSpCM
         xWCV4mpHdSuUUR1zUy+PC93frb17iwKtRXqEcEjJUxHWS6T2JWJTeq3H0VhueBGNBeTT
         5mD6dYpkDx8Rz6oO8pusZF8o/RUKR4pwVuS+GLM/iNnVfRF1QxAdGBbcSd5nRSpHJHPg
         ENKu0u8AAAQbqZ6wJkDf8BsepGsgKmM1YTCWuFxMat+OEYkIfihc/CwQ/IPrZ+7lfxZu
         KFCg==
X-Gm-Message-State: ACrzQf2osqIrphs+WxKdkz465xHBVfAOUIE4YRAqQr0ivfyIiqSraEey
        52jaiqExwt1s5W4MaGwFQLL7bLN3tJiaPOQ+g/WsWXjxB7Wcz/AQ71PfNxEfBjsd4mquWzrpK6f
        DuiNFrF1JiUkiBSktMR5Fj+jPflWrrrSI80yGe1Yr2KauQq1EUozZO9dCjQdU3PSWmDvLe6hUoA
        eHUQ==
X-Received: by 2002:a05:6402:34cb:b0:451:61c9:a316 with SMTP id w11-20020a05640234cb00b0045161c9a316mr16334077edc.268.1663596636710;
        Mon, 19 Sep 2022 07:10:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4rMjhU4aBxmJYnr3cEmmYBTFIL1SwBoJDwDS9Vj/QnCalbOWDpSNyrscGJKA2crEGHkA79pg==
X-Received: by 2002:a05:6402:34cb:b0:451:61c9:a316 with SMTP id w11-20020a05640234cb00b0045161c9a316mr16334049edc.268.1663596636416;
        Mon, 19 Sep 2022 07:10:36 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id lb22-20020a170907785600b0073bdf71995dsm9849951ejc.139.2022.09.19.07.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:10:35 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v2 2/8] vfs: add tmpfile_open() helper
Date:   Mon, 19 Sep 2022 16:10:25 +0200
Message-Id: <20220919141031.1834447-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919141031.1834447-1-mszeredi@redhat.com>
References: <20220919141031.1834447-1-mszeredi@redhat.com>
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

This helper unifies tmpfile creation with opening.

Existing vfs_tmpfile() callers outside of fs/namei.c will be converted to
using this helper.  There are two such callers: cachefile and overlayfs.

The cachefiles code currently uses the open_with_fake_path() helper to open
the tmpfile, presumably to disable accounting of the open file.  Overlayfs
uses tmpfile for copy_up, which means these struct file instances will be
short lived, hence it doesn't really matter if they are accounted or not.
Disable accounting in this helper to, which should be okay for both caller.

Add MAY_OPEN permission checking for consistency.  Like for create(2)
read/write permissions are not checked.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namei.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  4 ++++
 2 files changed, 45 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 53b4bc094db2..5e4a0c59eef6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3624,6 +3624,47 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 }
 EXPORT_SYMBOL(vfs_tmpfile);
 
+/**
+ * tmpfile_open - open a tmpfile for kernel internal use
+ * @mnt_userns:	user namespace of the mount the inode was found from
+ * @parentpath:	path of the base directory
+ * @mode:	mode of the new tmpfile
+ * @open_flag:	flags
+ * @cred:	credentials for open
+ *
+ * Create and open a temporary file.  The file is not accounted in nr_files,
+ * hence this is only for kernel internal use, and must not be installed into
+ * file tables or such.
+ */
+struct file *tmpfile_open(struct user_namespace *mnt_userns,
+			  const struct path *parentpath,
+			  umode_t mode, int open_flag, const struct cred *cred)
+{
+	struct file *file;
+	int error;
+	struct path path = { .mnt = parentpath->mnt };
+
+	path.dentry = vfs_tmpfile(mnt_userns, parentpath->dentry, mode, open_flag);
+	if (IS_ERR(path.dentry))
+		return ERR_CAST(path.dentry);
+
+	error = may_open(mnt_userns, &path, 0, open_flag);
+	file = ERR_PTR(error);
+	if (error)
+		goto out_dput;
+
+	/*
+	 * This relies on the "noaccount" property of fake open, otherwise
+	 * equivalent to dentry_open().
+	 */
+	file = open_with_fake_path(&path, open_flag, d_inode(path.dentry), cred);
+out_dput:
+	dput(path.dentry);
+
+	return file;
+}
+EXPORT_SYMBOL(tmpfile_open);
+
 static int do_tmpfile(struct nameidata *nd, unsigned flags,
 		const struct open_flags *op,
 		struct file *file)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..34e7a189565b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2007,6 +2007,10 @@ static inline int vfs_whiteout(struct user_namespace *mnt_userns,
 struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 			   struct dentry *dentry, umode_t mode, int open_flag);
 
+struct file *tmpfile_open(struct user_namespace *mnt_userns,
+			  const struct path *parentpath,
+			  umode_t mode, int open_flag, const struct cred *cred);
+
 int vfs_mkobj(struct dentry *, umode_t,
 		int (*f)(struct dentry *, umode_t, void *),
 		void *);
-- 
2.37.3

