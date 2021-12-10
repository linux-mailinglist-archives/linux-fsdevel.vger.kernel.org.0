Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC40246FBA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbhLJHkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:10 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:50788 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235413AbhLJHj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:39:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-80.ma_1639121782;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-80.ma_1639121782)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:22 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 02/19] cachefiles: implement key scheme for demand-read mode
Date:   Fri, 10 Dec 2021 15:36:02 +0800
Message-Id: <20211210073619.21667-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In demand-read mode, user daemon may prepare data blob files in advance
before they are lookud up.

Thus simplify the logic of placing backing files, in which backing files
are under "cache/<volume>/" directory directly.

Also skip coherency checking currently to ease the development and debug.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/namei.c | 8 +++++++-
 fs/cachefiles/xattr.c | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 61d412580353..981e6e80690b 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -603,11 +603,17 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 bool cachefiles_look_up_object(struct cachefiles_object *object)
 {
 	struct cachefiles_volume *volume = object->volume;
-	struct dentry *dentry, *fan = volume->fanout[(u8)object->cookie->key_hash];
+	struct cachefiles_cache *cache = volume->cache;
+	struct dentry *dentry, *fan;
 	int ret;
 
 	_enter("OBJ%x,%s,", object->debug_id, object->d_name);
 
+	if (cache->mode == CACHEFILES_MODE_CACHE)
+		fan = volume->fanout[(u8)object->cookie->key_hash];
+	else
+		fan = volume->dentry;
+
 	/* Look up path "cache/vol/fanout/file". */
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 0601c46a22ef..f562dd0d4bdd 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -88,6 +88,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
  */
 int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file)
 {
+	struct cachefiles_cache *cache = object->volume->cache;
 	struct cachefiles_xattr *buf;
 	struct dentry *dentry = file->f_path.dentry;
 	unsigned int len = object->cookie->aux_len, tlen;
@@ -96,6 +97,10 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 	ssize_t xlen;
 	int ret = -ESTALE;
 
+	/* TODO: coherency check */
+	if (cache->mode == CACHEFILES_MODE_DEMAND)
+		return 0;
+
 	tlen = sizeof(struct cachefiles_xattr) + len;
 	buf = kmalloc(tlen, GFP_KERNEL);
 	if (!buf)
-- 
2.27.0

