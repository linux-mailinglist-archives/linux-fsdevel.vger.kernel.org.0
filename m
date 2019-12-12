Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E3C11D8A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 22:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbfLLVgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 16:36:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57817 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731081AbfLLVgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576186571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iA7ztsSbNlCcDdsPrRY4M9rq9EkGKI95V0pGlAltfQM=;
        b=FGX1KClsc76GzE5bxiDlCtJxBymw3l/lZb+xbQq47E8Shgikz3nCZn2ODKQvZnLjLbtg+e
        QtbQ1/I2n2r7p3XtgLamGs+or9b2HqW04srMC4W7XLi99cn+YIP7a1Cn9pQqpd2RgbQlNz
        q2k6LlZW6IuW8eIRfXLs67db39odB8E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-3vZbWcZlOxaPkVI6gbd63A-1; Thu, 12 Dec 2019 16:36:07 -0500
X-MC-Unique: 3vZbWcZlOxaPkVI6gbd63A-1
Received: by mail-qv1-f71.google.com with SMTP id c1so315466qvw.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 13:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iA7ztsSbNlCcDdsPrRY4M9rq9EkGKI95V0pGlAltfQM=;
        b=mabFEL7oLZfxWryfcFSpD0ucWTB7nB7QT61XsyCC/3gkxG+H9XrwRgqXPAvlq8TJyD
         PdYcLJxda1fOpjzgZBAbcAn4KdyRI5C3NwhOBBYkE5VCPkYcEPaRoenXyiPp2lFIXlly
         1ijCv92a8xY+S9rbvUXxqJ1UK10g3nZibfQ/tv2d9XTN6ZaYYH7KhZFdau84hj9C+dyu
         tN1iEczZFEUTl+XuLL3P+hGfJcFor5pVgldf3VuFa9utUmIJo2+1uuBCPQ5i4W7x3Dm0
         dd9WGKgbNTc0mhdzMsTYxwFd1SIpoKjizTf0bpkK3gRvPX1QXE4xsMPn0zMpVAHPZWec
         Qt8w==
X-Gm-Message-State: APjAAAU5IgYn/s9qadGLITzYkDZUrwVfQkgCtCv45pzgNdFzxzt6a4ld
        b1C6li42O39Bx/ONqeq0/0zFqxGYKqGPqsL6rvw/QG3C3Vr33XqSW++ebaxSATSEz8eJk1RENg1
        RfNxGE5cprtBGYC4BwqowM5Zg4Q==
X-Received: by 2002:a37:ac16:: with SMTP id e22mr10539646qkm.186.1576186567301;
        Thu, 12 Dec 2019 13:36:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqzeJTq6XNxmt9i7ijf5+K/wgdrZ9W/NN1+8UgCZfR2DawNq9krbPYAnrdPZZbMfx451jDvh4g==
X-Received: by 2002:a37:ac16:: with SMTP id e22mr10539615qkm.186.1576186566867;
        Thu, 12 Dec 2019 13:36:06 -0800 (PST)
Received: from labbott-redhat.redhat.com (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id 2sm2135906qkv.98.2019.12.12.13.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:36:06 -0800 (PST)
From:   Laura Abbott <labbott@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] vfs: Handle file systems without ->parse_params better
Date:   Thu, 12 Dec 2019 16:36:04 -0500
Message-Id: <20191212213604.19525-1-labbott@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The new mount API relies on file systems to provide a ->parse_params
function to handle parsing of arguments. If a file system doesn't
have a ->parse_param function, it falls back to parsing the source
option and rejecting all other options. This is a change in behavior
for some file systems which would just quietly ignore extra options
and mount successfully. This was noticed by users as squashfs failing
to mount with extra options after the conversion to the new mount
API.

File systems with a ->parse_params function rely on the top level
to parse the "source" param so we can't easily move that around. To
get around this, introduce a default parsing functions for file
systems that take no arguments. This parses only the "source" option
and only logs an error for other arguments. Update the comment
to reflect this expected behavior for "source" parsing as well.

Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock
creation/configuration context")
Link: https://lore.kernel.org/lkml/20191130181548.GA28459@gentoo-tp.home/
Reported-by: Jeremi Piotrowski <jeremi.piotrowski@gmail.com>
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1781863
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
I cleaned up my original suggestion a bit as I realized things would
be easier if we just made this a default option if there's no parsing.
Lightly tested only.
---
 fs/fs_context.c | 69 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 138b5b4d621d..8c5dc131e29a 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -107,6 +107,55 @@ static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
 	return -ENOPARAM;
 }
 
+enum {
+        GENERIC_FS_SOURCE,
+};
+
+static const struct fs_parameter_spec generic_fs_param_specs[] = {
+        fsparam_string  ("source",              GENERIC_FS_SOURCE),
+        {}
+};
+
+const struct fs_parameter_description generic_fs_parameters = {
+        .name           = "generic_fs",
+        .specs          = generic_fs_param_specs,
+};
+
+/**
+ * fs_generic_parse_param - ->parse_param function for a file system that
+ * takes no arguments
+ * @fc: The filesystem context
+ * @param: The parameter.
+ */
+static int fs_generic_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+        struct fs_parse_result result;
+        int opt;
+
+        opt = fs_parse(fc, &generic_fs_parameters, param, &result);
+        if (opt < 0) {
+                /* Just log an error for backwards compatibility */
+                errorf(fc, "%s: Unknown parameter '%s'",
+                      fc->fs_type->name, param->key);
+                return 0;
+        }
+
+        switch (opt) {
+        case GENERIC_FS_SOURCE:
+                if (param->type != fs_value_is_string)
+                        return invalf(fc, "%s: Non-string source",
+					fc->fs_type->name);
+                if (fc->source)
+                        return invalf(fc, "%s: Multiple sources specified",
+					fc->fs_type->name);
+                fc->source = param->string;
+                param->string = NULL;
+                break;
+        }
+
+        return 0;
+}
+
 /**
  * vfs_parse_fs_param - Add a single parameter to a superblock config
  * @fc: The filesystem context to modify
@@ -126,6 +175,7 @@ static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
 int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	int ret;
+	int (*parse_param)(struct fs_context *, struct fs_parameter *);
 
 	if (!param->key)
 		return invalf(fc, "Unnamed parameter\n");
@@ -141,14 +191,19 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 		 */
 		return ret;
 
-	if (fc->ops->parse_param) {
-		ret = fc->ops->parse_param(fc, param);
-		if (ret != -ENOPARAM)
-			return ret;
-	}
+	parse_param = fc->ops->parse_param;
+	if (!parse_param)
+		parse_param = fs_generic_parse_param;
+
+	ret = parse_param(fc, param);
+	if (ret != -ENOPARAM)
+		return ret;
 
-	/* If the filesystem doesn't take any arguments, give it the
-	 * default handling of source.
+	/*
+	 * File systems may have a ->parse_param function but rely on
+	 * the top level to parse the source function. File systems
+	 * may have their own source parsing though so this needs
+	 * to come after the call to parse_param above.
 	 */
 	if (strcmp(param->key, "source") == 0) {
 		if (param->type != fs_value_is_string)
-- 
2.21.0

