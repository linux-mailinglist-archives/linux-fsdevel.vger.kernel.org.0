Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2365D563D13
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 02:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiGBAsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 20:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiGBAsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 20:48:11 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF42D73;
        Fri,  1 Jul 2022 17:48:10 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id B839E100802;
        Sat,  2 Jul 2022 10:48:07 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8ivGRhSuOnG0; Sat,  2 Jul 2022 10:48:07 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id AFDB1100822; Sat,  2 Jul 2022 10:48:07 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id E58F0100534;
        Sat,  2 Jul 2022 10:48:06 +1000 (AEST)
Subject: [PATCH v2] vfs: parse: deal with zero length string value
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 02 Jul 2022 08:48:06 +0800
Message-ID: <165672288662.20702.12232487558332361737.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Parsing an fs string that has zero length should result in the parameter
being set to NULL so that downstream processing handles it correctly.
For example, the proc mount table processing should print "(none)" in
this case to preserve mount record field count, but if the value points
to the NULL string this doesn't happen.

Changes:

v2: fix possible oops if conversion functions such as fs_param_is_u32()
    are called.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/fs_context.c            |   17 ++++++++++++-----
 fs/fs_parser.c             |   16 ++++++++++++++++
 include/linux/fs_context.h |    3 ++-
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 24ce12f0db32..df04e5fc6d66 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -96,7 +96,9 @@ int vfs_parse_fs_param_source(struct fs_context *fc, struct fs_parameter *param)
 	if (strcmp(param->key, "source") != 0)
 		return -ENOPARAM;
 
-	if (param->type != fs_value_is_string)
+	/* source value may be NULL */
+	if (param->type != fs_value_is_string &&
+	    param->type != fs_value_is_empty)
 		return invalf(fc, "Non-string source");
 
 	if (fc->source)
@@ -175,10 +177,15 @@ int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 	};
 
 	if (value) {
-		param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
-		if (!param.string)
-			return -ENOMEM;
-		param.type = fs_value_is_string;
+		if (!v_size) {
+			param.string = NULL;
+			param.type = fs_value_is_empty;
+		} else {
+			param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
+			if (!param.string)
+				return -ENOMEM;
+			param.type = fs_value_is_string;
+		}
 	}
 
 	ret = vfs_parse_fs_param(fc, &param);
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index ed40ce5742fd..2046f41ab00b 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -197,6 +197,8 @@ int fs_param_is_bool(struct p_log *log, const struct fs_parameter_spec *p,
 		     struct fs_parameter *param, struct fs_parse_result *result)
 {
 	int b;
+	if (param->type == fs_value_is_empty)
+		return 0;
 	if (param->type != fs_value_is_string)
 		return fs_param_bad_value(log, param);
 	if (!*param->string && (p->flags & fs_param_can_be_empty))
@@ -213,6 +215,8 @@ int fs_param_is_u32(struct p_log *log, const struct fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
 	int base = (unsigned long)p->data;
+	if (param->type == fs_value_is_empty)
+		return 0;
 	if (param->type != fs_value_is_string)
 		return fs_param_bad_value(log, param);
 	if (!*param->string && (p->flags & fs_param_can_be_empty))
@@ -226,6 +230,8 @@ EXPORT_SYMBOL(fs_param_is_u32);
 int fs_param_is_s32(struct p_log *log, const struct fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
+	if (param->type == fs_value_is_empty)
+		return 0;
 	if (param->type != fs_value_is_string)
 		return fs_param_bad_value(log, param);
 	if (!*param->string && (p->flags & fs_param_can_be_empty))
@@ -239,6 +245,8 @@ EXPORT_SYMBOL(fs_param_is_s32);
 int fs_param_is_u64(struct p_log *log, const struct fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
+	if (param->type == fs_value_is_empty)
+		return 0;
 	if (param->type != fs_value_is_string)
 		return fs_param_bad_value(log, param);
 	if (!*param->string && (p->flags & fs_param_can_be_empty))
@@ -253,6 +261,8 @@ int fs_param_is_enum(struct p_log *log, const struct fs_parameter_spec *p,
 		     struct fs_parameter *param, struct fs_parse_result *result)
 {
 	const struct constant_table *c;
+	if (param->type == fs_value_is_empty)
+		return 0;
 	if (param->type != fs_value_is_string)
 		return fs_param_bad_value(log, param);
 	if (!*param->string && (p->flags & fs_param_can_be_empty))
@@ -268,6 +278,8 @@ EXPORT_SYMBOL(fs_param_is_enum);
 int fs_param_is_string(struct p_log *log, const struct fs_parameter_spec *p,
 		       struct fs_parameter *param, struct fs_parse_result *result)
 {
+	if (param->type == fs_value_is_empty)
+		return 0;
 	if (param->type != fs_value_is_string ||
 	    (!*param->string && !(p->flags & fs_param_can_be_empty)))
 		return fs_param_bad_value(log, param);
@@ -278,6 +290,8 @@ EXPORT_SYMBOL(fs_param_is_string);
 int fs_param_is_blob(struct p_log *log, const struct fs_parameter_spec *p,
 		     struct fs_parameter *param, struct fs_parse_result *result)
 {
+	if (param->type == fs_value_is_empty)
+		return 0;
 	if (param->type != fs_value_is_blob)
 		return fs_param_bad_value(log, param);
 	return 0;
@@ -287,6 +301,8 @@ EXPORT_SYMBOL(fs_param_is_blob);
 int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
 		  struct fs_parameter *param, struct fs_parse_result *result)
 {
+	if (param->type == fs_value_is_empty)
+		return 0;
 	switch (param->type) {
 	case fs_value_is_string:
 		if ((!*param->string && !(p->flags & fs_param_can_be_empty)) ||
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 13fa6f3df8e4..ff1375a16c8c 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -50,7 +50,8 @@ enum fs_context_phase {
  */
 enum fs_value_type {
 	fs_value_is_undefined,
-	fs_value_is_flag,		/* Value not given a value */
+	fs_value_is_flag,		/* Does not take a value */
+	fs_value_is_empty,		/* Value is not given */
 	fs_value_is_string,		/* Value is a string */
 	fs_value_is_blob,		/* Value is a binary blob */
 	fs_value_is_filename,		/* Value is a filename* + dirfd */


