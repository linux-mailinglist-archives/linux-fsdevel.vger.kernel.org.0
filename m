Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE0777653
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 12:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjHJK4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 06:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbjHJK4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4352B1736
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691664909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPNRQJq/hyiYldLtrBMY3seKZRMqc2xitsd2NuT766U=;
        b=RiPLeBvw0uuzdLPCbsBr1eCw+hh4AAybdNrFhH9H7+1rrsZY8fdKvTsQVNnMC7gfkbSpYq
        HlcwpS1X1FI4Ifdq4GXObuKqN1MZpiy+DNE6B51GX5GzOfvw+JuM1IyZ8e8oHmmu9HFSun
        y9K5jOYfzUiEMPKl38rcepK1ipu5aRc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-4Xw3uI9CMUCXHM6WcjuLdg-1; Thu, 10 Aug 2023 06:55:08 -0400
X-MC-Unique: 4Xw3uI9CMUCXHM6WcjuLdg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-52349404bb0so535875a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 03:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664906; x=1692269706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPNRQJq/hyiYldLtrBMY3seKZRMqc2xitsd2NuT766U=;
        b=auqOzn8SoI3M8J+IatG5L8WcoB3R5uKQMVeMxi9JwmwVc2ywyChLe6UtTJW9hCinDq
         mBMaAXcKAsy4PImui26ihBb+lpuJvTNMfkyFd8DcC7/ldTSNYjS9b4slv6bhSxoRpSGA
         6ujJ5DynfAqqd7pglgsjHYQl4l1ZLeXDFpdm7Fc580fboHvWnL6PU7MiGzoitVNhSn8g
         p0u2vqB60G8MoC1wPovFJuZdWpBwhPYaURDqhixWyA8u7Tolur1IGHlFPMRW+GH9wOZd
         AMZGDHJ0ZpMJAcz+mSYr6gXDRQEFUNsXwAZTXUKYKkwDmuFGze1LbTUTtBmJTbXrpRzh
         8Jiw==
X-Gm-Message-State: AOJu0YxCqNEXy1zHWCFMPmiCTr7VYaQjQC1qRVWXWK+FKKQuM7bdSgip
        iqFVIywARWg6Lkf+4keiipLoTy3cmjabWzN0txNqzbeG3mIrl6QyiEJIxnwAAEX+Zb4orRHuPta
        QZh9dv6RYC9RNgV/nPr/8xpgnoU6Ft0I/Wg07R5DiTq8Q3uuzPMECW2l3tZTSWRtZMDCZh55yH2
        4qUwDa44tgrA==
X-Received: by 2002:aa7:d646:0:b0:51e:53eb:88a3 with SMTP id v6-20020aa7d646000000b0051e53eb88a3mr1641341edr.25.1691664906534;
        Thu, 10 Aug 2023 03:55:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpjv0QjJoe8gLhTAOi//9Ylb+gcQKJlx8YVL8Nuqm6t+2y/Bm/vapXtIKJXH/LOcZElgjxKQ==
X-Received: by 2002:aa7:d646:0:b0:51e:53eb:88a3 with SMTP id v6-20020aa7d646000000b0051e53eb88a3mr1641332edr.25.1691664906171;
        Thu, 10 Aug 2023 03:55:06 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-246-142.pool.digikabel.hu. [193.226.246.142])
        by smtp.gmail.com with ESMTPSA id v20-20020aa7cd54000000b005231f324a0bsm643732edw.28.2023.08.10.03.55.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:55:05 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] fuse: add ATTR_TIMEOUT macro
Date:   Thu, 10 Aug 2023 12:54:59 +0200
Message-Id: <20230810105501.1418427-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810105501.1418427-1-mszeredi@redhat.com>
References: <20230810105501.1418427-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Next patch will introduce yet another type attribute reply.  Add a macro
that can handle attribute timeouts for all of the structs.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c     | 26 ++++++++------------------
 fs/fuse/fuse_i.h  |  5 ++++-
 fs/fuse/readdir.c |  4 ++--
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d38ab93e2007..04006db6e173 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -92,7 +92,7 @@ static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 /*
  * Calculate the time in jiffies until a dentry/attributes are valid
  */
-static u64 time_to_jiffies(u64 sec, u32 nsec)
+u64 fuse_time_to_jiffies(u64 sec, u32 nsec)
 {
 	if (sec || nsec) {
 		struct timespec64 ts = {
@@ -112,17 +112,7 @@ static u64 time_to_jiffies(u64 sec, u32 nsec)
 void fuse_change_entry_timeout(struct dentry *entry, struct fuse_entry_out *o)
 {
 	fuse_dentry_settime(entry,
-		time_to_jiffies(o->entry_valid, o->entry_valid_nsec));
-}
-
-static u64 attr_timeout(struct fuse_attr_out *o)
-{
-	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
-}
-
-u64 entry_attr_timeout(struct fuse_entry_out *o)
-{
-	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
+		fuse_time_to_jiffies(o->entry_valid, o->entry_valid_nsec));
 }
 
 void fuse_invalidate_attr_mask(struct inode *inode, u32 mask)
@@ -266,7 +256,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
 		forget_all_cached_acls(inode);
 		fuse_change_attributes(inode, &outarg.attr,
-				       entry_attr_timeout(&outarg),
+				       ATTR_TIMEOUT(&outarg),
 				       attr_version);
 		fuse_change_entry_timeout(entry, &outarg);
 	} else if (inode) {
@@ -399,7 +389,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 		goto out_put_forget;
 
 	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
-			   &outarg->attr, entry_attr_timeout(outarg),
+			   &outarg->attr, ATTR_TIMEOUT(outarg),
 			   attr_version);
 	err = -ENOMEM;
 	if (!*inode) {
@@ -686,7 +676,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	ff->nodeid = outentry.nodeid;
 	ff->open_flags = outopen.open_flags;
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
-			  &outentry.attr, entry_attr_timeout(&outentry), 0);
+			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0);
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
 		fuse_sync_release(NULL, ff, flags);
@@ -813,7 +803,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 		goto out_put_forget_req;
 
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
-			  &outarg.attr, entry_attr_timeout(&outarg), 0);
+			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0);
 	if (!inode) {
 		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
 		return -ENOMEM;
@@ -1190,7 +1180,7 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 			err = -EIO;
 		} else {
 			fuse_change_attributes(inode, &outarg.attr,
-					       attr_timeout(&outarg),
+					       ATTR_TIMEOUT(&outarg),
 					       attr_version);
 			if (stat)
 				fuse_fillattr(inode, &outarg.attr, stat);
@@ -1867,7 +1857,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	}
 
 	fuse_change_attributes_common(inode, &outarg.attr,
-				      attr_timeout(&outarg),
+				      ATTR_TIMEOUT(&outarg),
 				      fuse_get_cache_mask(inode));
 	oldsize = inode->i_size;
 	/* see the comment in fuse_change_attributes() */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b7fc7d3c7f1..fd55c09514cd 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1111,7 +1111,10 @@ void fuse_invalidate_entry_cache(struct dentry *entry);
 
 void fuse_invalidate_atime(struct inode *inode);
 
-u64 entry_attr_timeout(struct fuse_entry_out *o);
+u64 fuse_time_to_jiffies(u64 sec, u32 nsec);
+#define ATTR_TIMEOUT(o) \
+	fuse_time_to_jiffies((o)->attr_valid, (o)->attr_valid_nsec)
+
 void fuse_change_entry_timeout(struct dentry *entry, struct fuse_entry_out *o);
 
 /**
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index dc603479b30e..48b3a6ec278b 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -224,7 +224,7 @@ static int fuse_direntplus_link(struct file *file,
 
 		forget_all_cached_acls(inode);
 		fuse_change_attributes(inode, &o->attr,
-				       entry_attr_timeout(o),
+				       ATTR_TIMEOUT(o),
 				       attr_version);
 		/*
 		 * The other branch comes via fuse_iget()
@@ -232,7 +232,7 @@ static int fuse_direntplus_link(struct file *file,
 		 */
 	} else {
 		inode = fuse_iget(dir->i_sb, o->nodeid, o->generation,
-				  &o->attr, entry_attr_timeout(o),
+				  &o->attr, ATTR_TIMEOUT(o),
 				  attr_version);
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);
-- 
2.40.1

