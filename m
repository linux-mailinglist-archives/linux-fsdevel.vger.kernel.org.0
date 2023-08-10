Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F96777651
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 12:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjHJK4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjHJK4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9140826AC
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 03:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691664910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yobj2C2jpQ0SRM9YFm12DxRhqrSRbPGhdfbz0EvvYa0=;
        b=LAu33BZI8vj7TktBnjZvCZmeXzs+IIf+LEJ/gQ4spPi5MKIMIwxHfO7Unnz1rvlOenCEQ5
        D6gz/8kBcysk6Z1SbJ4uMo0zn8hRTQ9j+G1kqWk/l1Unyx5mFuyuybEg7Lk+FEDhO9YdYg
        BkugO4V4ufoO8Qu1qafKQDZ13PqGwo4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-6Dn8WLrUOsanhewdRrDuag-1; Thu, 10 Aug 2023 06:55:09 -0400
X-MC-Unique: 6Dn8WLrUOsanhewdRrDuag-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-52310538efaso533063a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 03:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664908; x=1692269708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yobj2C2jpQ0SRM9YFm12DxRhqrSRbPGhdfbz0EvvYa0=;
        b=VtjGrK+7aiIbLW5UvvluTJGJPooMZOHOJ2G/67n5i3zGR/RW+vU+7EYgN2dedcJSu3
         GuqtEHx2P18aJBnJbq7WZney9UYUfdONY4ZDfFyhkBusJjLjIz5SitBko222ba3ycrrF
         EvO9I6i5yBsFe+AwFzME1HbjcLos4sVJkAZi/D61Nl/xxXPOzt43XF6ZjaO46ux826Ao
         lDPlWq5TFvLrOgDrkTYcRiS4Xh6iV3e/+nXd8E/hO7TYZqWY4Q9ltX/ST2Tztj95NvCo
         pT1QyW14uj9fLZl6qZLCkBohLJc0alJQBPPjMyrXq1GIYV408+sNc1QZtV788/uNXJ9+
         17BQ==
X-Gm-Message-State: AOJu0YySP/DIH6hgwkaBbfQ91EVlmzizi8DhtDi7IgsiH8HFBVVTSCSm
        RliH+c7pti/QfmCjo89arTnn2ZX+3zxCEKCqzy2/fvWVuTuFcUtDpaJfo6bYioYpkcx2rzlame+
        +N1mrZeF0zk1RIff7jrrYm4SH3E8tAOA7XB8YCUXq2PVNIrUwQOj+mFFH/0ZWY6jvvyv8QLRxmj
        3hB+0BO2Iyuw==
X-Received: by 2002:aa7:c593:0:b0:521:e502:baf8 with SMTP id g19-20020aa7c593000000b00521e502baf8mr1767138edq.11.1691664907954;
        Thu, 10 Aug 2023 03:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXQBIMk7o8IWE4YwMNtCJ0RBhm1xIYb4i6avmLM8PBpa2D3mChsTR3Sy94A7JYRbi6kk7XrA==
X-Received: by 2002:aa7:c593:0:b0:521:e502:baf8 with SMTP id g19-20020aa7c593000000b00521e502baf8mr1767121edq.11.1691664907504;
        Thu, 10 Aug 2023 03:55:07 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-246-142.pool.digikabel.hu. [193.226.246.142])
        by smtp.gmail.com with ESMTPSA id v20-20020aa7cd54000000b005231f324a0bsm643732edw.28.2023.08.10.03.55.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:55:06 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] fuse: implement statx
Date:   Thu, 10 Aug 2023 12:55:00 +0200
Message-Id: <20230810105501.1418427-5-mszeredi@redhat.com>
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

Allow querying btime.  When btime is requested in mask, then FUSE_STATX
request is sent.  Otherwise keep using FUSE_GETATTR.

The userspace interface for statx matches that of the statx(2) API.
However there are limitations on how this interface is used:

 - returned basic stats and btime are used, stx_attributes, etc. are
   ignored

 - always query basic stats and btime, regardless of what was requested

 - requested sync type is ignored, the default is passed to the server

 - if server returns with some attributes missing from the result_mask,
   then no attributes will be cached

 - btime is not cached yet (next patch will fix that)

For new inodes initialize fi->inval_mask to "all invalid", instead of "all
valid" as previously.  Also only clear basic stats from inval_mask when
caching attributes.  This will result in the caching logic not thinking
that btime is cached.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c    | 106 ++++++++++++++++++++++++++++++++++++++++++++---
 fs/fuse/fuse_i.h |   3 ++
 fs/fuse/inode.c  |   5 ++-
 3 files changed, 107 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 04006db6e173..552157bd6a4d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -350,10 +350,14 @@ int fuse_valid_type(int m)
 		S_ISBLK(m) || S_ISFIFO(m) || S_ISSOCK(m);
 }
 
+bool fuse_valid_size(u64 size)
+{
+	return size <= LLONG_MAX;
+}
+
 bool fuse_invalid_attr(struct fuse_attr *attr)
 {
-	return !fuse_valid_type(attr->mode) ||
-		attr->size > LLONG_MAX;
+	return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->size);
 }
 
 int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
@@ -1143,6 +1147,84 @@ static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
 	stat->blksize = 1 << blkbits;
 }
 
+static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
+{
+	memset(attr, 0, sizeof(*attr));
+	attr->ino = sx->ino;
+	attr->size = sx->size;
+	attr->blocks = sx->blocks;
+	attr->atime = sx->atime.tv_sec;
+	attr->mtime = sx->mtime.tv_sec;
+	attr->ctime = sx->ctime.tv_sec;
+	attr->atimensec = sx->atime.tv_nsec;
+	attr->mtimensec = sx->mtime.tv_nsec;
+	attr->ctimensec = sx->ctime.tv_nsec;
+	attr->mode = sx->mode;
+	attr->nlink = sx->nlink;
+	attr->uid = sx->uid;
+	attr->gid = sx->gid;
+	attr->rdev = new_encode_dev(MKDEV(sx->rdev_major, sx->rdev_minor));
+	attr->blksize = sx->blksize;
+}
+
+static int fuse_do_statx(struct inode *inode, struct file *file,
+			 struct kstat *stat)
+{
+	int err;
+	struct fuse_attr attr;
+	struct fuse_statx *sx;
+	struct fuse_statx_in inarg;
+	struct fuse_statx_out outarg;
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	u64 attr_version = fuse_get_attr_version(fm->fc);
+	FUSE_ARGS(args);
+
+	memset(&inarg, 0, sizeof(inarg));
+	memset(&outarg, 0, sizeof(outarg));
+	/* Directories have separate file-handle space */
+	if (file && S_ISREG(inode->i_mode)) {
+		struct fuse_file *ff = file->private_data;
+
+		inarg.getattr_flags |= FUSE_GETATTR_FH;
+		inarg.fh = ff->fh;
+	}
+	/* For now leave sync hints as the default, request all stats. */
+	inarg.sx_flags = 0;
+	inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
+	args.opcode = FUSE_STATX;
+	args.nodeid = get_node_id(inode);
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.out_numargs = 1;
+	args.out_args[0].size = sizeof(outarg);
+	args.out_args[0].value = &outarg;
+	err = fuse_simple_request(fm, &args);
+	if (err)
+		return err;
+
+	sx = &outarg.stat;
+	if (((sx->mask & STATX_SIZE) && !fuse_valid_size(sx->size)) ||
+	    ((sx->mask & STATX_TYPE) && (!fuse_valid_type(sx->mode) ||
+					 inode_wrong_type(inode, sx->mode)))) {
+		make_bad_inode(inode);
+		return -EIO;
+	}
+
+	fuse_statx_to_attr(&outarg.stat, &attr);
+	if ((sx->mask & STATX_BASIC_STATS) == STATX_BASIC_STATS) {
+		fuse_change_attributes(inode, &attr, ATTR_TIMEOUT(&outarg),
+				       attr_version);
+	}
+	stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
+	stat->btime.tv_sec = sx->btime.tv_sec;
+	stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
+	fuse_fillattr(inode, &attr, stat);
+	stat->result_mask |= STATX_TYPE;
+
+	return 0;
+}
+
 static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 			   struct file *file)
 {
@@ -1194,13 +1276,18 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 				unsigned int flags)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 	int err = 0;
 	bool sync;
 	u32 inval_mask = READ_ONCE(fi->inval_mask);
 	u32 cache_mask = fuse_get_cache_mask(inode);
 
-	/* FUSE only supports basic stats */
-	request_mask &= STATX_BASIC_STATS;
+
+	/* FUSE only supports basic stats and possibly btime */
+	request_mask &= STATX_BASIC_STATS | STATX_BTIME;
+retry:
+	if (fc->no_statx)
+		request_mask &= STATX_BASIC_STATS;
 
 	if (!request_mask)
 		sync = false;
@@ -1215,7 +1302,16 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 
 	if (sync) {
 		forget_all_cached_acls(inode);
-		err = fuse_do_getattr(inode, stat, file);
+		/* Try statx if BTIME is requested */
+		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
+			err = fuse_do_statx(inode, file, stat);
+			if (err == -ENOSYS) {
+				fc->no_statx = 1;
+				goto retry;
+			}
+		} else {
+			err = fuse_do_getattr(inode, stat, file);
+		}
 	} else if (stat) {
 		generic_fillattr(&nop_mnt_idmap, inode, stat);
 		stat->mode = fi->orig_i_mode;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fd55c09514cd..daae31c58754 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -792,6 +792,9 @@ struct fuse_conn {
 	/* Is tmpfile not implemented by fs? */
 	unsigned int no_tmpfile:1;
 
+	/* Is statx not implemented by fs? */
+	unsigned int no_statx:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f19d748890f0..a6cc102e66bc 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -77,7 +77,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 		return NULL;
 
 	fi->i_time = 0;
-	fi->inval_mask = 0;
+	fi->inval_mask = ~0;
 	fi->nodeid = 0;
 	fi->nlookup = 0;
 	fi->attr_version = 0;
@@ -172,7 +172,8 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 
 	fi->attr_version = atomic64_inc_return(&fc->attr_version);
 	fi->i_time = attr_valid;
-	WRITE_ONCE(fi->inval_mask, 0);
+	/* Clear basic stats from invalid mask */
+	set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);
 
 	inode->i_ino     = fuse_squash_ino(attr->ino);
 	inode->i_mode    = (inode->i_mode & S_IFMT) | (attr->mode & 07777);
-- 
2.40.1

