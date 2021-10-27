Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E4A43CBF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbhJ0OXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 10:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242522AbhJ0OXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635344454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zX4H+c6yjsL7nmSydorSU+0CJsORDXgMFr/2jjHZFSA=;
        b=PUDOLBicVIE+pHxpG9YhrG4x0jFZO/RZmYYqxOC6KL9F7hUL7fjZKWwlkWF61EpQZlQBIb
        t+vtWFqfWaH6lnjZgSqM+eA1GFf0ShhNNwvfTRjuEiY3FLNDDGQpHYw05tblkqb9Ha0Y68
        uCUX7FijyWxhRmlyTN0hJ7qXlD1fykY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-qPeDJ-szN3GelsfqLB4SXQ-1; Wed, 27 Oct 2021 10:20:50 -0400
X-MC-Unique: qPeDJ-szN3GelsfqLB4SXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC047801ADE;
        Wed, 27 Oct 2021 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7D955DF35;
        Wed, 27 Oct 2021 14:20:48 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v4 10/13] ext4: clean up return values in handle_mount_opt()
Date:   Wed, 27 Oct 2021 16:18:54 +0200
Message-Id: <20211027141857.33657-11-lczerner@redhat.com>
In-Reply-To: <20211027141857.33657-1-lczerner@redhat.com>
References: <20211027141857.33657-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Clean up return values in handle_mount_opt() and rename the function to
ext4_parse_param()

Now we can use it in fs_context_operations as .parse_param.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ext4/super.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 21845f899c50..b66087f55009 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -91,6 +91,7 @@ static int ext4_validate_options(struct fs_context *fc);
 static int ext4_check_opt_consistency(struct fs_context *fc,
 				      struct super_block *sb);
 static int ext4_apply_options(struct fs_context *fc, struct super_block *sb);
+static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param);
 
 /*
  * Lock ordering
@@ -118,6 +119,11 @@ static int ext4_apply_options(struct fs_context *fc, struct super_block *sb);
  * transaction start -> page lock(s) -> i_data_sem (rw)
  */
 
+static const struct fs_context_operations ext4_context_ops = {
+	.parse_param	= ext4_parse_param,
+};
+
+
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defined(CONFIG_EXT4_USE_FOR_EXT2)
 static struct file_system_type ext2_fs_type = {
 	.owner		= THIS_MODULE,
@@ -2269,7 +2275,7 @@ EXT4_SET_CTX(mount_opt);
 EXT4_SET_CTX(mount_opt2);
 EXT4_SET_CTX(mount_flags);
 
-static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
+static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct ext4_fs_context *ctx = fc->fs_private;
 	struct fs_parse_result result;
@@ -2310,30 +2316,30 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			ctx->s_sb_block = result.uint_32;
 			ctx->spec |= EXT4_SPEC_s_sb_block;
 		}
-		return 1;
+		return 0;
 	case Opt_removed:
 		ext4_msg(NULL, KERN_WARNING, "Ignoring removed %s option",
 			 param->key);
-		return 1;
+		return 0;
 	case Opt_abort:
 		ctx_set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
-		return 1;
+		return 0;
 	case Opt_i_version:
 		ctx_set_flags(ctx, SB_I_VERSION);
-		return 1;
+		return 0;
 	case Opt_lazytime:
 		ctx_set_flags(ctx, SB_LAZYTIME);
-		return 1;
+		return 0;
 	case Opt_nolazytime:
 		ctx_clear_flags(ctx, SB_LAZYTIME);
-		return 1;
+		return 0;
 	case Opt_inlinecrypt:
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
 		ctx_set_flags(ctx, SB_INLINECRYPT);
 #else
 		ext4_msg(NULL, KERN_ERR, "inline encryption not supported");
 #endif
-		return 1;
+		return 0;
 	case Opt_errors:
 	case Opt_data:
 	case Opt_data_err:
@@ -2485,7 +2491,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (param->type == fs_value_is_flag) {
 			ctx->spec |= EXT4_SPEC_DUMMY_ENCRYPTION;
 			ctx->test_dummy_enc_arg = NULL;
-			return 1;
+			return 0;
 		}
 		if (*param->string &&
 		    !(!strcmp(param->string, "v1") ||
@@ -2576,7 +2582,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 				ctx_clear_mount_opt(ctx, m->mount_opt);
 		}
 	}
-	return 1;
+	return 0;
 }
 
 static int parse_options(struct fs_context *fc, char *options)
@@ -2612,7 +2618,7 @@ static int parse_options(struct fs_context *fc, char *options)
 			param.key = key;
 			param.size = v_len;
 
-			ret = handle_mount_opt(fc, &param);
+			ret = ext4_parse_param(fc, &param);
 			if (param.string)
 				kfree(param.string);
 			if (ret < 0)
-- 
2.31.1

