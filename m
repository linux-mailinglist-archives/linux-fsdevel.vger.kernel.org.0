Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9948C777652
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 12:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjHJK4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 06:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjHJK4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A8E26B8
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691664912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xwa6+6zF9pv0djpXrnIbd8z6z5wH7RTpeeZ5RrhlEq0=;
        b=I/gbyPC446Rh1yQGhNPA0lhOOX8m0wMc0ZKrxq31lcKfgv6nLqCAEkQ2A3ShjbS5W6CI5F
        7C+q38ZUpFvO9o7bgZMg6ILg0k0Wt6qDMQuM7tbv5oZK0ky8o3dwdaEym8APaUjcuSEIJW
        +XGkX2SK/eralu/XEYK063MhvNoEovs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-qe3Js4a4PSOciikMrrL3vg-1; Thu, 10 Aug 2023 06:55:10 -0400
X-MC-Unique: qe3Js4a4PSOciikMrrL3vg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-523338c7bc8so566486a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 03:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664909; x=1692269709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xwa6+6zF9pv0djpXrnIbd8z6z5wH7RTpeeZ5RrhlEq0=;
        b=AJUkwfGMXEOoPvqwtbYJeHDD+O5Ze8V40JYVCHLyM5ODQsNleT191S3B8VpiZ6+SZI
         Ws+5eCcDMOAvCZ4TW5pVkHHl45nulOX7t3i3K8ViZgOpiNN8SNhfatgbREWXuuPSUd4O
         Br3CejzSulR1fVNvWS4QhfZ5E0frB4pWH2S8wvskdE2BksI64ogYb804axIOjZwodh7N
         ZKf5NhDRiNI9Jzwv+V3ybbQ0kjj1MNsdVQdLVaCwpOLVj+rWT8C8OgwcwqLXPYtzX6zg
         YTM3VeATg9wCXq5naF+w93ooUOhIGKEZG40rYTfEE3tDuybqQxLlXeDeX0pUrNEc7XBA
         TZMg==
X-Gm-Message-State: AOJu0YzR5RAUzMuz5esm/FGADrpWYXwsmZ6IcycbOlKcInQ0wfhSLdzs
        RL3Vw8oMWU1mwDG/tq2FlKQIWdWP8FMDcVNLj3cM8s4o+gpyAdF5MMlLL+ZEe3Lcqmzjr+hWN+6
        3kiVJyphAXpaOoU5Sg0dsoUiVDucvosrDRcaQ1Pmaiv1sqo0GEcoyP6ycDBgUcvHjantr5jyMDO
        rMhBiCmKWUtw==
X-Received: by 2002:a50:ec84:0:b0:523:1ce9:1f41 with SMTP id e4-20020a50ec84000000b005231ce91f41mr1992692edr.18.1691664909397;
        Thu, 10 Aug 2023 03:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFCuL0IZC0lTPmn/H8CQNSDJR7CUUSaNs1Lm2FwXonn3StFHC6uLjGfmFy+v/jcH7UcyD56g==
X-Received: by 2002:a50:ec84:0:b0:523:1ce9:1f41 with SMTP id e4-20020a50ec84000000b005231ce91f41mr1992666edr.18.1691664909038;
        Thu, 10 Aug 2023 03:55:09 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-246-142.pool.digikabel.hu. [193.226.246.142])
        by smtp.gmail.com with ESMTPSA id v20-20020aa7cd54000000b005231f324a0bsm643732edw.28.2023.08.10.03.55.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:55:07 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] fuse: cache btime
Date:   Thu, 10 Aug 2023 12:55:01 +0200
Message-Id: <20230810105501.1418427-6-mszeredi@redhat.com>
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

Not all inode attributes are supported by all filesystems, but for the
basic stats (which are returned by stat(2) and friends) all of them will
have some value, even if that doesn't reflect a real attribute of the file.

Btime is different, in that filesystems are free to report or not report a
value in statx.  If the value is available, then STATX_BTIME bit is set in
stx_mask.

When caching the value of btime, remember the availability of the attribute
as well as the value (if available).  This is done by using the
FUSE_I_BTIME bit in fuse_inode->state to indicate availability, while using
fuse_inode->inval_mask & STATX_BTIME to indicate the state of the cache
itself (i.e. set if cache is invalid, and cleared if cache is valid).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c     | 14 +++++++++-----
 fs/fuse/fuse_i.h  |  7 +++++++
 fs/fuse/inode.c   | 25 +++++++++++++++++++++++--
 fs/fuse/readdir.c |  2 +-
 4 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 552157bd6a4d..42f49fe6e770 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -255,7 +255,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			goto invalid;
 
 		forget_all_cached_acls(inode);
-		fuse_change_attributes(inode, &outarg.attr,
+		fuse_change_attributes(inode, &outarg.attr, NULL,
 				       ATTR_TIMEOUT(&outarg),
 				       attr_version);
 		fuse_change_entry_timeout(entry, &outarg);
@@ -1213,8 +1213,8 @@ static int fuse_do_statx(struct inode *inode, struct file *file,
 
 	fuse_statx_to_attr(&outarg.stat, &attr);
 	if ((sx->mask & STATX_BASIC_STATS) == STATX_BASIC_STATS) {
-		fuse_change_attributes(inode, &attr, ATTR_TIMEOUT(&outarg),
-				       attr_version);
+		fuse_change_attributes(inode, &attr, &outarg.stat,
+				       ATTR_TIMEOUT(&outarg), attr_version);
 	}
 	stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
 	stat->btime.tv_sec = sx->btime.tv_sec;
@@ -1261,7 +1261,7 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 			fuse_make_bad(inode);
 			err = -EIO;
 		} else {
-			fuse_change_attributes(inode, &outarg.attr,
+			fuse_change_attributes(inode, &outarg.attr, NULL,
 					       ATTR_TIMEOUT(&outarg),
 					       attr_version);
 			if (stat)
@@ -1316,6 +1316,10 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 		generic_fillattr(&nop_mnt_idmap, inode, stat);
 		stat->mode = fi->orig_i_mode;
 		stat->ino = fi->orig_ino;
+		if (test_bit(FUSE_I_BTIME, &fi->state)) {
+			stat->btime = fi->i_btime;
+			stat->result_mask |= STATX_BTIME;
+		}
 	}
 
 	return err;
@@ -1952,7 +1956,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		/* FIXME: clear I_DIRTY_SYNC? */
 	}
 
-	fuse_change_attributes_common(inode, &outarg.attr,
+	fuse_change_attributes_common(inode, &outarg.attr, NULL,
 				      ATTR_TIMEOUT(&outarg),
 				      fuse_get_cache_mask(inode));
 	oldsize = inode->i_size;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index daae31c58754..4608c3deab52 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -88,6 +88,9 @@ struct fuse_inode {
 	    preserve the original mode */
 	umode_t orig_i_mode;
 
+	/* Cache birthtime */
+	struct timespec64 i_btime;
+
 	/** 64 bit inode number */
 	u64 orig_ino;
 
@@ -167,6 +170,8 @@ enum {
 	FUSE_I_SIZE_UNSTABLE,
 	/* Bad inode */
 	FUSE_I_BAD,
+	/* Has btime */
+	FUSE_I_BTIME,
 };
 
 struct fuse_conn;
@@ -1061,9 +1066,11 @@ void fuse_init_symlink(struct inode *inode);
  * Change attributes of an inode
  */
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
+			    struct fuse_statx *sx,
 			    u64 attr_valid, u64 attr_version);
 
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
+				   struct fuse_statx *sx,
 				   u64 attr_valid, u32 cache_mask);
 
 u32 fuse_get_cache_mask(struct inode *inode);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index a6cc102e66bc..175ac7e4e06d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -163,6 +163,7 @@ static ino_t fuse_squash_ino(u64 ino64)
 }
 
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
+				   struct fuse_statx *sx,
 				   u64 attr_valid, u32 cache_mask)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -198,6 +199,25 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 		inode->i_ctime.tv_sec   = attr->ctime;
 		inode->i_ctime.tv_nsec  = attr->ctimensec;
 	}
+	if (sx) {
+		/* Sanitize nsecs */
+		sx->btime.tv_nsec =
+			min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
+
+		/*
+		 * Btime has been queried, cache is valid (whether or not btime
+		 * is available or not) so clear STATX_BTIME from inval_mask.
+		 *
+		 * Availability of the btime attribute is indicated in
+		 * FUSE_I_BTIME
+		 */
+		set_mask_bits(&fi->inval_mask, STATX_BTIME, 0);
+		if (sx->mask & STATX_BTIME) {
+			set_bit(FUSE_I_BTIME, &fi->state);
+			fi->i_btime.tv_sec = sx->btime.tv_sec;
+			fi->i_btime.tv_nsec = sx->btime.tv_nsec;
+		}
+	}
 
 	if (attr->blksize != 0)
 		inode->i_blkbits = ilog2(attr->blksize);
@@ -237,6 +257,7 @@ u32 fuse_get_cache_mask(struct inode *inode)
 }
 
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
+			    struct fuse_statx *sx,
 			    u64 attr_valid, u64 attr_version)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -271,7 +292,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	}
 
 	old_mtime = inode->i_mtime;
-	fuse_change_attributes_common(inode, attr, attr_valid, cache_mask);
+	fuse_change_attributes_common(inode, attr, sx, attr_valid, cache_mask);
 
 	oldsize = inode->i_size;
 	/*
@@ -409,7 +430,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	spin_lock(&fi->lock);
 	fi->nlookup++;
 	spin_unlock(&fi->lock);
-	fuse_change_attributes(inode, attr, attr_valid, attr_version);
+	fuse_change_attributes(inode, attr, NULL, attr_valid, attr_version);
 
 	return inode;
 }
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 48b3a6ec278b..1c5e5bfb5d58 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -223,7 +223,7 @@ static int fuse_direntplus_link(struct file *file,
 		spin_unlock(&fi->lock);
 
 		forget_all_cached_acls(inode);
-		fuse_change_attributes(inode, &o->attr,
+		fuse_change_attributes(inode, &o->attr, NULL,
 				       ATTR_TIMEOUT(o),
 				       attr_version);
 		/*
-- 
2.40.1

