Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8996F4425
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjEBMsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 08:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEBMsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 08:48:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF091B9;
        Tue,  2 May 2023 05:48:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3062c1e7df8so1607730f8f.1;
        Tue, 02 May 2023 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683031709; x=1685623709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeBn/JgpFqZE/TKMjDDbt2tMOlGTFfUTgS2LGEIVV+A=;
        b=BMBMxugwl4l3D1wY8kMpBLT7AjqGPGCrZ4OoFhPN+V0nKD0/gr5BHZ1M3oSf8nGfpJ
         gsJqEfBd8KFo8fJGe6ciCIIbIHtSMPn4SFNLDUzebSXff77CYFESFwSz49QE/R09iP/y
         pA+poYwh+V25PFsAqF6quA951X+pPN4E2XLvn5b8c+IS/mjSCKjwUe1ngNsBxKe103kE
         b71ZlFFU18LY+XyEbsg4iif7idtwC7KUWRWsi6PvPzsBTZezbacLw9kgo+6VlCe8XjVm
         JkvnIW1TduZUffmOjGzs5FM8QN9Bv/H6wGW+FFvy5xhGmlpQ6mSa+HBAWR6aJu4ON0CM
         2xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683031709; x=1685623709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeBn/JgpFqZE/TKMjDDbt2tMOlGTFfUTgS2LGEIVV+A=;
        b=RdyhUkaOIZoXzfIyS/OL8XJIrsdql2+DNrjW11QvFeR83uEOJlYkmOZQ2nFNg+5fX3
         NgBoVv0mqW0FqxwURmAb9jkMKCkumjnzD6kozltwKW2aLwhTV6aMtM5rGjh03XcyYwPP
         zeUvigZLJAYPelw/RzBdxyDL3bvpeG0sGy9Hg/IS8IHUaWbTjpnfUpdngKi46eiAFd/G
         ImfK4bNQQNOyWGyHpD7RiOzBXHX3/HpmUEa/wlvsi4fzu/NSy9aqdDctCBYWba5d8V+U
         QKPhslnj72q7oNervgqzXS8cyZZxO6D0ngiwUFgUm749TWAWblKBEumzcOzk2OFpZAnU
         fUEA==
X-Gm-Message-State: AC+VfDwpRjtONyIm5IAMmPGrWk/cESGbw4rRiQc/5N99ieYW3vOI1bv7
        Qdt//TsRKBTbqC+apliJKlw=
X-Google-Smtp-Source: ACHHUZ5PKQMo9PRvFeGHtHlUyI5p/qrVociXaKSKIGuGQpveGTSwcPjTDU/WcEMkZQ2l1L+X8NG63Q==
X-Received: by 2002:a5d:6a43:0:b0:2fe:80b7:3527 with SMTP id t3-20020a5d6a43000000b002fe80b73527mr11303588wrw.17.1683031709553;
        Tue, 02 May 2023 05:48:29 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b00304adbeeabbsm14226259wrz.99.2023.05.02.05.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 05:48:29 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 4/4] fanotify: support reporting non-decodeable file handles
Date:   Tue,  2 May 2023 15:48:17 +0300
Message-Id: <20230502124817.3070545-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502124817.3070545-1-amir73il@gmail.com>
References: <20230502124817.3070545-1-amir73il@gmail.com>
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

Even filesystems that do not have export_operations at all can fallback
to use the default FILEID_INO32_GEN encoding, but we use the existence
of export_operations as an indication that the encoded file handles will
be sufficiently unique and that user will be able to compare them to
filesystem objects using AT_HANDLE_FID flag to name_to_handle_at(2).

For filesystems that do not support NFS export, users will have to use
the AT_HANDLE_FID of name_to_handle_at(2) if they want to compare the
object in path to the object fid reported in an event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 4 ++--
 fs/notify/fanotify/fanotify_user.c | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

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
index 8f430bfad487..e1936e968abb 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1586,11 +1586,10 @@ static int fanotify_test_fid(struct dentry *dentry)
 	 * We need to make sure that the file system supports at least
 	 * encoding a file handle so user can use name_to_handle_at() to
 	 * compare fid returned with event to the file handle of watched
-	 * objects. However, name_to_handle_at() requires that the
-	 * filesystem also supports decoding file handles.
+	 * objects. However, even the relaxed AT_HANDLE_FID flag requires
+	 * at least empty export_operations for ecoding unique file ids.
 	 */
-	if (!dentry->d_sb->s_export_op ||
-	    !dentry->d_sb->s_export_op->fh_to_dentry)
+	if (!dentry->d_sb->s_export_op)
 		return -EOPNOTSUPP;
 
 	return 0;
-- 
2.34.1

