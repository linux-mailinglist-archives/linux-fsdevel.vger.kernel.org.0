Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F2F5F44EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 15:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJDN6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 09:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiJDN6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CD35C351
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Oct 2022 06:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664891888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FovgkzjBCd5eiueFMUNM+DsFnQ3oZ8WMZkVXqv5D0IQ=;
        b=GHtT+ehXFErbEsM4kOMManWp1hbIOrjk4EjVqab9nLTTVjKUesbzO0TQ3QcSdUW458ZFbN
        3m6Ald6V2bFhDauJAPaqcfPoYJF8Y1MZ2lleyIsGjMxTGoyBtwvrLI/vC3AJ9RZ4BsqUkJ
        5P1vk+YlgDff3a/c0+EE0r43TSgyMOw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-xLaMWaGeOfewNU4n5bQEYQ-1; Tue, 04 Oct 2022 09:58:05 -0400
X-MC-Unique: xLaMWaGeOfewNU4n5bQEYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42B32857D0B;
        Tue,  4 Oct 2022 13:58:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9249214152E8;
        Tue,  4 Oct 2022 13:58:04 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, linux-fsdevel@vger.kernel.org
Subject: [PATCH] ext4: journal_path mount options should follow links
Date:   Tue,  4 Oct 2022 15:58:03 +0200
Message-Id: <20221004135803.32283-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before the commit 461c3af045d3 ("ext4: Change handle_mount_opt() to use
fs_parameter") ext4 mount option journal_path did follow links in the
provided path.

Bring this behavior back by allowing to pass pathwalk flags to
fs_lookup_param().

Fixes: 461c3af045d3 ("ext4: Change handle_mount_opt() to use fs_parameter")
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 Documentation/filesystems/mount_api.rst | 1 +
 fs/ext4/super.c                         | 2 +-
 fs/fs_parser.c                          | 3 ++-
 include/linux/fs_parser.h               | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index eb358a00be27..1d16787a00e9 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -814,6 +814,7 @@ process the parameters it is given.
        int fs_lookup_param(struct fs_context *fc,
 			   struct fs_parameter *value,
 			   bool want_bdev,
+			   unsigned int flags,
 			   struct path *_path);
 
      This takes a parameter that carries a string or filename type and attempts
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9a66abcca1a8..4c1b3972d53f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2271,7 +2271,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		}
 
-		error = fs_lookup_param(fc, param, 1, &path);
+		error = fs_lookup_param(fc, param, 1, LOOKUP_FOLLOW, &path);
 		if (error) {
 			ext4_msg(NULL, KERN_ERR, "error: could not find "
 				 "journal device path");
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index ed40ce5742fd..edb3712dcfa5 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -138,15 +138,16 @@ EXPORT_SYMBOL(__fs_parse);
  * @fc: The filesystem context to log errors through.
  * @param: The parameter.
  * @want_bdev: T if want a blockdev
+ * @flags: Pathwalk flags passed to filename_lookup()
  * @_path: The result of the lookup
  */
 int fs_lookup_param(struct fs_context *fc,
 		    struct fs_parameter *param,
 		    bool want_bdev,
+		    unsigned int flags,
 		    struct path *_path)
 {
 	struct filename *f;
-	unsigned int flags = 0;
 	bool put_f;
 	int ret;
 
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index f103c91139d4..01542c4b87a2 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -76,6 +76,7 @@ static inline int fs_parse(struct fs_context *fc,
 extern int fs_lookup_param(struct fs_context *fc,
 			   struct fs_parameter *param,
 			   bool want_bdev,
+			   unsigned int flags,
 			   struct path *_path);
 
 extern int lookup_constant(const struct constant_table tbl[], const char *name, int not_found);
-- 
2.37.3

