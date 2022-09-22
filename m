Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2B55E5DC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 10:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiIVIpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 04:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiIVIo5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D3561B0F
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663836288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YUr4vpC7819u5uQSeXZvt7C05pVq5tFuU8XWNKqRjX4=;
        b=M6VR3Qa2GbM7KTh4yk/6o9LylZvi9qvsstuQRmxOuXRcvp9bAIhFw5K1gLgJyJoqO9kpJa
        o8ih/a281saS4UIDl56fhxCCPO1RpWU+EZQyKjX7Ye/T9w+RQGRr/FdUmCZE2bzIJ7WFvM
        jlAgnLVbqfYAjXHdZFkKtUumvKS0szg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-27-Dms1aIyoNaWZOzP_t9bsdA-1; Thu, 22 Sep 2022 04:44:47 -0400
X-MC-Unique: Dms1aIyoNaWZOzP_t9bsdA-1
Received: by mail-ej1-f70.google.com with SMTP id nc18-20020a1709071c1200b00780b046fb4eso4207056ejc.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YUr4vpC7819u5uQSeXZvt7C05pVq5tFuU8XWNKqRjX4=;
        b=aRfObKDAiopq3CwyWQprd+dFLN8xz6UESoh4lcNStR4uYQGDdBgEJMFUSCR/R3y3cj
         9leNHahYe2ze9JclgRx01YVqH6V38RVlQxTMSTiqfP198UWx+iFUb86lfhgTOfBHMNI0
         gLsbA59yakqQl3TCf0s/OMtxrs1oouGqghTwRSvMtczxtrwynIHb5R0DgMExdXBFl+hs
         P+UkSyNYdh6ZvfuJOcAqlW6BqzBdiJgLvdD6hsZiwPcrFuHn1W7uq8+zM2ir0AUBXDCw
         Gwx44hW27+zNpYHiSA/IROZ+++WzvXNLNGqBGI9uTY/UK8cjDpiO0dWH/JcUDbOjpnVg
         Zo0A==
X-Gm-Message-State: ACrzQf0XcKqP5Tdx+khWdkNjbg0QrLUayNpFo08PdAbuB+bKv8r+KDU3
        7XrDCNQlNumssvcFmJfZ8F01fFIold/PY9sU+b66pmeqqxPX0BbNaupg3Xvr4sJSqxiYy3c5pcu
        IhdMdEUPExSXFqQMW+NzA7FJNPVhh33bMzv5GX3GgE3gvHN008rfASuyUoyajnu/7dBJ6euH1ex
        NLJQ==
X-Received: by 2002:a17:907:6d03:b0:780:6fdd:974e with SMTP id sa3-20020a1709076d0300b007806fdd974emr1805595ejc.288.1663836285980;
        Thu, 22 Sep 2022 01:44:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4OoZYLWxyUdTn44c8s/grB0DBwcG1pYYYDnsq3V+vEu6Q2QCgS9MEYEXmep0RmwGFyvOEnxQ==
X-Received: by 2002:a17:907:6d03:b0:780:6fdd:974e with SMTP id sa3-20020a1709076d0300b007806fdd974emr1805572ejc.288.1663836285655;
        Thu, 22 Sep 2022 01:44:45 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906718f00b00730b3bdd8d7sm2297942ejk.179.2022.09.22.01.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:44:45 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v4 01/10] vfs: add vfs_tmpfile_open() helper
Date:   Thu, 22 Sep 2022 10:44:33 +0200
Message-Id: <20220922084442.2401223-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922084442.2401223-1-mszeredi@redhat.com>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
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
Disable accounting in this helper too, which should be okay for both
callers.

Add MAY_OPEN permission checking for consistency.  Like for create(2)
read/write permissions are not checked.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namei.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  4 ++++
 2 files changed, 45 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 53b4bc094db2..81c388a813d3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3624,6 +3624,47 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 }
 EXPORT_SYMBOL(vfs_tmpfile);
 
+/**
+ * vfs_tmpfile_open - open a tmpfile for kernel internal use
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
+struct file *vfs_tmpfile_open(struct user_namespace *mnt_userns,
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
+EXPORT_SYMBOL(vfs_tmpfile_open);
+
 static int do_tmpfile(struct nameidata *nd, unsigned flags,
 		const struct open_flags *op,
 		struct file *file)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..15fafda95dd3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2007,6 +2007,10 @@ static inline int vfs_whiteout(struct user_namespace *mnt_userns,
 struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 			   struct dentry *dentry, umode_t mode, int open_flag);
 
+struct file *vfs_tmpfile_open(struct user_namespace *mnt_userns,
+			const struct path *parentpath,
+			umode_t mode, int open_flag, const struct cred *cred);
+
 int vfs_mkobj(struct dentry *, umode_t,
 		int (*f)(struct dentry *, umode_t, void *),
 		void *);
-- 
2.37.3

