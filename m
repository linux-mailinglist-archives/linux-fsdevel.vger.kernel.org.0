Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE918279826
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 11:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIZJU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 05:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgIZJU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 05:20:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280B6C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UWPi/1FLtgS0P8YCIByz3Ni3dIDhDRY9b0/pA0/D2vg=; b=RD4v3uMBxjzR/YsnLW18Qp+JeC
        lrOfwke2heZSO/9qcr86TiH7t6GY+oJO4J6aJ0pPW2U0R0V+UzWaLGgdswuvrXy42UiBwfL7M/sN+
        TWHpb0t60I62EDgSC+7PgYJYBDiipn2b2vi2u2Ng4/akdeG3LD4qZ0KwAzjTQYWVwqekuji1JiHJh
        Ku9Yuy9qifAez71K39tSlvcW40FrksP8eqZbv6t1GdMqBjCERbQZVpMkcCyjwJFhn47kVu4/m4tNx
        P2srfBe+w6jEwKyKUVl4lTnrZ14XSZNT1tVcecx5N8w4Ep4onoxySDoQCBWhErwcmg6dYrQ3d2CXZ
        yNuAxr0w==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM6O0-0002FX-MK; Sat, 26 Sep 2020 09:20:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] fs: remove the unused fs_lookup_param function
Date:   Sat, 26 Sep 2020 11:20:48 +0200
Message-Id: <20200926092051.115577-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926092051.115577-1-hch@lst.de>
References: <20200926092051.115577-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/mount_api.rst | 18 +-------
 fs/fs_parser.c                          | 56 -------------------------
 include/linux/fs_parser.h               |  5 ---
 3 files changed, 2 insertions(+), 77 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index 29c169c68961f3..dbff847986da47 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -254,8 +254,8 @@ manage the filesystem context.  They are as follows:
      will have been weeded out and fc->sb_flags updated in the context.
      Security options will also have been weeded out and fc->security updated.
 
-     The parameter can be parsed with fs_parse() and fs_lookup_param().  Note
-     that the source(s) are presented as parameters named "source".
+     The parameter can be parsed with fs_parse().  Note that the source(s) are
+     presented as parameters named "source".
 
      If successful, 0 should be returned or a negative error code otherwise.
 
@@ -809,17 +809,3 @@ process the parameters it is given.
      If the parameter isn't matched, -ENOPARAM will be returned; if the
      parameter is matched, but the value is erroneous, -EINVAL will be
      returned; otherwise the parameter's option number will be returned.
-
-   * ::
-
-       int fs_lookup_param(struct fs_context *fc,
-			   struct fs_parameter *value,
-			   bool want_bdev,
-			   struct path *_path);
-
-     This takes a parameter that carries a string or filename type and attempts
-     to do a path lookup on it.  If the parameter expects a blockdev, a check
-     is made that the inode actually represents one.
-
-     Returns 0 if successful and ``*_path`` will be set; returns a negative
-     error code if not.
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index ab53e42a874aaa..ee40f838b2be91 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -133,62 +133,6 @@ int __fs_parse(struct p_log *log,
 }
 EXPORT_SYMBOL(__fs_parse);
 
-/**
- * fs_lookup_param - Look up a path referred to by a parameter
- * @fc: The filesystem context to log errors through.
- * @param: The parameter.
- * @want_bdev: T if want a blockdev
- * @_path: The result of the lookup
- */
-int fs_lookup_param(struct fs_context *fc,
-		    struct fs_parameter *param,
-		    bool want_bdev,
-		    struct path *_path)
-{
-	struct filename *f;
-	unsigned int flags = 0;
-	bool put_f;
-	int ret;
-
-	switch (param->type) {
-	case fs_value_is_string:
-		f = getname_kernel(param->string);
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-		put_f = true;
-		break;
-	case fs_value_is_filename:
-		f = param->name;
-		put_f = false;
-		break;
-	default:
-		return invalf(fc, "%s: not usable as path", param->key);
-	}
-
-	f->refcnt++; /* filename_lookup() drops our ref. */
-	ret = filename_lookup(param->dirfd, f, flags, _path, NULL);
-	if (ret < 0) {
-		errorf(fc, "%s: Lookup failure for '%s'", param->key, f->name);
-		goto out;
-	}
-
-	if (want_bdev &&
-	    !S_ISBLK(d_backing_inode(_path->dentry)->i_mode)) {
-		path_put(_path);
-		_path->dentry = NULL;
-		_path->mnt = NULL;
-		errorf(fc, "%s: Non-blockdev passed as '%s'",
-		       param->key, f->name);
-		ret = -ENOTBLK;
-	}
-
-out:
-	if (put_f)
-		putname(f);
-	return ret;
-}
-EXPORT_SYMBOL(fs_lookup_param);
-
 int fs_param_bad_value(struct p_log *log, struct fs_parameter *param)
 {
 	return inval_plog(log, "Bad value for '%s'", param->key);
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index aab0ffc6bac67a..a62ed20fda6d98 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -73,11 +73,6 @@ static inline int fs_parse(struct fs_context *fc,
 	return __fs_parse(&fc->log, desc, param, result);
 }
 
-extern int fs_lookup_param(struct fs_context *fc,
-			   struct fs_parameter *param,
-			   bool want_bdev,
-			   struct path *_path);
-
 extern int lookup_constant(const struct constant_table tbl[], const char *name, int not_found);
 
 #ifdef CONFIG_VALIDATE_FS_PARSER
-- 
2.28.0

