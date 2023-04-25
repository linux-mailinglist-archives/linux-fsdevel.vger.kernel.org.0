Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5E06EE268
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 15:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjDYNBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 09:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjDYNBb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:01:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFE6D312;
        Tue, 25 Apr 2023 06:01:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2f3fe12de15so3467207f8f.3;
        Tue, 25 Apr 2023 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682427681; x=1685019681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1TOXMWuoQkvRdhBuoYArqNMO3EmKDW7kZ7IbV/tCJU=;
        b=WyIWIQ97OpGHkoKqBzG1aUJg+1xShHnHZlOsEwGUZpMR43VuICkIdDUjxFu/zUmqrT
         YM6/EAusONMFYpI3VtjLGRSdZ8gPfsezHaItywzHBlnC0WRzAoOZ/zpjw0OTtWYfiWfQ
         67aOYQQxli2+KJSB9jFL8XV54cGuhd/0hkCxyeyg7C+rIxTwgrjTkx2JKlfj7Ap16cVc
         y0rPjIwhwK8mtXjuOXsDk7COFOL7cNhg48NAyC0SEiDH+cHwQDr6ijiYR6wd3uUKMeLP
         W4f68SYgD+eb3JkUM46EWMa9KhfEpW+Tv4QXv8R5CARi9azDAMxJl9aMFOSb3El2XXzr
         654A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682427681; x=1685019681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1TOXMWuoQkvRdhBuoYArqNMO3EmKDW7kZ7IbV/tCJU=;
        b=XFfNOuFO+BzsayOcndol12h1qCRvxQR4XjpVpcpAZQYmIziBdQ2rBH5R/2QMdLHn7G
         54rPBN3ZU+gtcp+V+PD9EEIzMfUohWSxv9zHummuud9irL7zmfit1jWfPrz+d6Bynrqd
         1Q/UZNRvMouIareMRiRGm6pjHtz2fyQl/6Jq67Ii1cijd7d14To3Hlbm0VyTr9QA0mnV
         OrzJKeUK0IEuxk/HlbIKKEeR0dMAiHIJbLVe2c1idREei1gJ/4JI5UgeU8XJu3QeKf8Q
         98r+Zvsyn+ImeOgKFpJDh9pHNoBNpU4KbVnnbPTVSBpLLW3InEPBMtDjuP2+CqGqw2X1
         PLjQ==
X-Gm-Message-State: AAQBX9eos3voyRpGvTEVy0wkVwvzWTj5Hn5eLsTWbLdZfcdHFQ2TgyDt
        ntg2UBhhR/kc5Ixcd4tU5tjUq5QevVk=
X-Google-Smtp-Source: AKy350aMleWStRw+wvupNdJdGiarcUd5O4OGYZ3jUcCjrodh8ovgHoOwKveqhq8jq7tzEw0ymPTnwg==
X-Received: by 2002:a5d:4b45:0:b0:2f4:9956:e828 with SMTP id w5-20020a5d4b45000000b002f49956e828mr12045313wrs.18.1682427680609;
        Tue, 25 Apr 2023 06:01:20 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id s1-20020adff801000000b00300aee6c9cesm13103447wrp.20.2023.04.25.06.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:01:20 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [RFC][PATCH 4/4] fanotify: support reporting non-decodeable file handles
Date:   Tue, 25 Apr 2023 16:01:05 +0300
Message-Id: <20230425130105.2606684-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425130105.2606684-1-amir73il@gmail.com>
References: <20230425130105.2606684-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fanotify users do not always need to decode the file handles reported
with FAN_REPORT_FID.

Relax the restriction that filesystem needs to support NFS export and
allow reporting file handles from filesystems that only support ecoding
unique file handles.

For such filesystems, users will have to use the AT_HANDLE_FID of
name_to_handle_at(2) if they want to compare the object in path to the
object fid reported in an event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 4 ++--
 fs/notify/fanotify/fanotify_user.c | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index d1a49f5b6e6d..d2bbf1445a9e 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -380,7 +380,7 @@ static int fanotify_encode_fh_len(struct inode *inode)
 	if (!inode)
 		return 0;
 
-	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL, 0);
+	exportfs_encode_fid(inode, NULL, &dwords);
 	fh_len = dwords << 2;
 
 	/*
@@ -443,7 +443,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	}
 
 	dwords = fh_len >> 2;
-	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL, 0);
+	type = exportfs_encode_fid(inode, buf, &dwords);
 	err = -EINVAL;
 	if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
 		goto out_err;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8f430bfad487..a5af84cbb30d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1586,11 +1586,9 @@ static int fanotify_test_fid(struct dentry *dentry)
 	 * We need to make sure that the file system supports at least
 	 * encoding a file handle so user can use name_to_handle_at() to
 	 * compare fid returned with event to the file handle of watched
-	 * objects. However, name_to_handle_at() requires that the
-	 * filesystem also supports decoding file handles.
+	 * objects, but it does not need to support decoding file handles.
 	 */
-	if (!dentry->d_sb->s_export_op ||
-	    !dentry->d_sb->s_export_op->fh_to_dentry)
+	if (!dentry->d_sb->s_export_op)
 		return -EOPNOTSUPP;
 
 	return 0;
-- 
2.34.1

