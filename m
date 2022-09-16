Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C67E5BB2F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 21:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiIPToY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 15:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiIPToX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE3AB5168
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663357461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tDvv+QvG1dG0+OfJSXyJZ9PeJhhYUW8AHlr5Rmz0DZA=;
        b=GZ1p+RqW1j4YzNwb23K0+11HLQaiLC5jH5Eh/tU+mpQH4ccFJKibsZ9Fknyuc27hRjFqj8
        BsbRBNeuULAaHaxwlzP0ZYJhlAMqQbiRQD7IFDFJ3WhSveYKPQUGo2t0ZkX/nHmtvIDqdE
        71MXt656Fcty63VwyEKbFM/Zuf1x27Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-543-c2IA7UcpP_KmQvA1HFpVng-1; Fri, 16 Sep 2022 15:44:20 -0400
X-MC-Unique: c2IA7UcpP_KmQvA1HFpVng-1
Received: by mail-ed1-f71.google.com with SMTP id f10-20020a0564021e8a00b00451be6582d5so11751101edf.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 12:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tDvv+QvG1dG0+OfJSXyJZ9PeJhhYUW8AHlr5Rmz0DZA=;
        b=45MKHgq/QuJQ4Ad0TPKFne2yvXbMBpWIVdz1XEVtSOkgLvyaQ0GPZ7gX0m1IJSavoX
         GY+6LNV3PlQScKox5Q6thsNcbAeztHdBF4N0PgPwvvCYQ1GgXjKZmxQZJOMZwQHcKbt5
         Ay834uJaV5X4gof2tmN0e7eCbrRsRuph7TKK/2c1Qep+tES8pBE6w5nAAiYm+bHLke1n
         MBNrPDl0jn0HomfnuC8D+5J41jhqfQRtWiw/3VUhP53+PW5X8L47E2rvLR+U5Mp9etiP
         1GkkoT0EMrDqT28+ntr37SOVnBkggv+uwziwNoldUMtR2XCFDyxGHRFpVuqIVqxZFU0m
         RCzg==
X-Gm-Message-State: ACrzQf3+4z4Xstjd/V71hADpX0Yqqg1JfwO3/kYnEgx3e97g/oj0DJqi
        hchXLcPxDbVDp+ISLLdYCmsblYyqNBRViOKkFRal1BYmY2/+AdPROS9bf1jjUB2g2VkIjhNhxBn
        OkUnUgI3LSDfEfo8CqTyyLGaSUpayi6AvlDYkFCwDeZcmoidxaLhYrGQneOz4hBYV7NdxbXl9em
        fK6A==
X-Received: by 2002:a17:906:591:b0:73d:c3ef:84ae with SMTP id 17-20020a170906059100b0073dc3ef84aemr4621619ejn.155.1663357458907;
        Fri, 16 Sep 2022 12:44:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5BISLmeCqoctbJXtmKqdcTmws/gbheUbEF5ZcSJoFeXgKA+iDz6GQptGzMF66OLuDpVzDUJg==
X-Received: by 2002:a17:906:591:b0:73d:c3ef:84ae with SMTP id 17-20020a170906059100b0073dc3ef84aemr4621606ejn.155.1663357458647;
        Fri, 16 Sep 2022 12:44:18 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-212-116.pool.digikabel.hu. [193.226.212.116])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b0077ce503bd77sm8348592eje.129.2022.09.16.12.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:44:18 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH 2/8] vfs: add tmpfile_open() helper
Date:   Fri, 16 Sep 2022 21:44:10 +0200
Message-Id: <20220916194416.1657716-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220916194416.1657716-1-mszeredi@redhat.com>
References: <20220916194416.1657716-1-mszeredi@redhat.com>
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
 fs/namei.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  4 ++++
 2 files changed, 47 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 53b4bc094db2..078ecd88f016 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3624,6 +3624,49 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 }
 EXPORT_SYMBOL(vfs_tmpfile);
 
+
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

