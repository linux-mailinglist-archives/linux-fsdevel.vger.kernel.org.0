Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C095BEDE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 21:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiITTg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 15:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiITTgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696577645B
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663702607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anOQA/oJUS71LYPqHcQLEIYyutVeIxZG9umMeWdqoZk=;
        b=UHkaShc7Pgy8OxNYovgnPymTfjRRHudBlPG3VfbAayU2bbn+AuZsYR34m2UDQvIh89ILmx
        2gYXhPgTOXuYseDinGkHOMk97fnQCSSJENEaI2nkfpfNHaicrjcGqIdSj5LB7Psu7I9Y21
        Gbs/SBv5FJKqATny3uXFuWCtDuFGB0o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-xd_qq2uKO9CB3UOoEpg7gA-1; Tue, 20 Sep 2022 15:36:39 -0400
X-MC-Unique: xd_qq2uKO9CB3UOoEpg7gA-1
Received: by mail-ed1-f72.google.com with SMTP id x5-20020a05640226c500b00451ec193793so2610605edd.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=anOQA/oJUS71LYPqHcQLEIYyutVeIxZG9umMeWdqoZk=;
        b=EPadRgeoNxN9JIUHXWl7IO3pKtZBfiZF6ly+McYwpmZVPZ7+mDdoovCqRXVGUhzAYR
         g+i7BnbucAk0tsF92AXojcNkbwPZN0/KgdBbRWBBpmL7ZuS7XZR8lPYFIWPPqX3+K/S9
         3jsAVlMwMp65f3HCPeZjbcLKq9IRwxmckG2eCIq4W1k2tfEp8wJbl8J5R9e/7u2cOrjx
         H3Dccnlrj+tXQZeSM/2s/v2fFAeooFV4IaLh2UkO+/OaRoIgvMe92ZgCNguRH7jI51uk
         1lbcVNBA+gnBM6OKk/ai6LkNrAnqdPSjKbxU/r6lV4buxMxEXKyTicwpunvCMNXeHfrE
         i/xQ==
X-Gm-Message-State: ACrzQf3JsKM+SR/0A5VHwlfWOZ9WR9sqjYthKWt+CswMJFr9gLsD616E
        Pb8a2fZKWieKeH+NCF74olEscvsd2sdNjWNMW9c+ygArc+9MT9ooLEKrn3PrxTvhuGBBNyg0iPv
        nBAHXp0/yd74dntkl+DoH2WLI9gnD29er/AauAxDsesat7U8RLgkNSZ1MphDhOeuZaerb3A6PXU
        qv0w==
X-Received: by 2002:a05:6402:849:b0:453:10c3:2ee3 with SMTP id b9-20020a056402084900b0045310c32ee3mr21700780edz.339.1663702597688;
        Tue, 20 Sep 2022 12:36:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6i0vY5TvuiQ/vh2vfOw6Zj00vwxePEq7AvhTTBPAN+Ip2MGk3+qMaOGbvX8JfNKaRA/oD9wQ==
X-Received: by 2002:a05:6402:849:b0:453:10c3:2ee3 with SMTP id b9-20020a056402084900b0045310c32ee3mr21700760edz.339.1663702597495;
        Tue, 20 Sep 2022 12:36:37 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id p5-20020aa7d305000000b0045184540cecsm391821edq.36.2022.09.20.12.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:36:36 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v3 3/9] vfs: add tmpfile_open() helper
Date:   Tue, 20 Sep 2022 21:36:26 +0200
Message-Id: <20220920193632.2215598-4-mszeredi@redhat.com>
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

