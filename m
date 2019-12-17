Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D651234DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 19:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfLQSbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 13:31:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48912 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfLQSbp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:31:45 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihHdH-0002ou-80; Tue, 17 Dec 2019 18:31:43 +0000
Date:   Tue, 17 Dec 2019 18:31:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 09/12] fs_parser: "string" with missing value is a "flag"
Message-ID: <20191217183143.GC4203@ZenIV.linux.org.uk>
References: <20191128155940.17530-1-mszeredi@redhat.com>
 <20191128155940.17530-10-mszeredi@redhat.com>
 <20191217173259.GA4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217173259.GA4203@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 05:32:59PM +0000, Al Viro wrote:

> No.  This is simply wrong - as it is, there's no difference between
> "foo" and "foo=".  Passing NULL in the latter case is wrong, but
> this is not a good fix.
> 
> This
>         if (v_size > 0) {
>                 param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
>                 if (!param.string)
>                         return -ENOMEM;
>         }
> should really be
> 	if (value) {
>                 param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
>                 if (!param.string)
>                         return -ENOMEM;
>         }
> and your chunk should be conditional upon value, not v_size.  The
> same problem exists for rbd.c

How about this (completely untested):

Pass consistent param->type to fs_parse()

As it is, vfs_parse_fs_string() makes "foo" and "foo=" indistinguishable;
both get fs_value_is_string for ->type and NULL for ->string.  To make
it even more unpleasant, that combination is impossible to produce with
fsconfig().

Much saner rules would be
	"foo"		=> fs_value_is_flag, NULL
	"foo="		=> fs_value_is_string, ""
	"foo=bar"	=> fs_value_is_string, "bar"
All cases are distinguishable, all results are expressable by fsconfig(),
->has_value checks are much simpler that way (to the point of the field
being useless) and quite a few regressions go away (gfs2 has no business
accepting -o nodebug=, for example).

Partially based upon patches from Miklos.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2b184563cd32..9fc686be81ca 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6433,7 +6433,7 @@ static int rbd_parse_options(char *options, struct rbd_parse_opts_ctx *pctx)
 		if (*key) {
 			struct fs_parameter param = {
 				.key	= key,
-				.type	= fs_value_is_string,
+				.type	= fs_value_is_flag,
 			};
 			char *value = strchr(key, '=');
 			size_t v_len = 0;
@@ -6443,14 +6443,11 @@ static int rbd_parse_options(char *options, struct rbd_parse_opts_ctx *pctx)
 					continue;
 				*value++ = 0;
 				v_len = strlen(value);
-			}
-
-
-			if (v_len > 0) {
 				param.string = kmemdup_nul(value, v_len,
 							   GFP_KERNEL);
 				if (!param.string)
 					return -ENOMEM;
+				param.type = fs_value_is_string;
 			}
 			param.size = v_len;
 
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 138b5b4d621d..9097421cbba5 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -175,14 +175,15 @@ int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 
 	struct fs_parameter param = {
 		.key	= key,
-		.type	= fs_value_is_string,
+		.type	= fs_value_is_flag,
 		.size	= v_size,
 	};
 
-	if (v_size > 0) {
+	if (value) {
 		param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
 		if (!param.string)
 			return -ENOMEM;
+		param.type = fs_value_is_string;
 	}
 
 	ret = vfs_parse_fs_param(fc, &param);
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index d1930adce68d..65842cd2e320 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -85,7 +85,6 @@ int fs_parse(struct fs_context *fc,
 	const struct fs_parameter_enum *e;
 	int ret = -ENOPARAM, b;
 
-	result->has_value = !!param->string;
 	result->negated = false;
 	result->uint_64 = 0;
 
@@ -95,7 +94,7 @@ int fs_parse(struct fs_context *fc,
 		 * "xxx" takes the "no"-form negative - but only if there
 		 * wasn't an value.
 		 */
-		if (result->has_value)
+		if (param->type != fs_value_is_flag)
 			goto unknown_parameter;
 		if (param->key[0] != 'n' || param->key[1] != 'o' || !param->key[2])
 			goto unknown_parameter;
@@ -127,14 +126,13 @@ int fs_parse(struct fs_context *fc,
 	case fs_param_is_u64:
 	case fs_param_is_enum:
 	case fs_param_is_string:
-		if (param->type != fs_value_is_string)
-			goto bad_value;
-		if (!result->has_value) {
+		if (param->type == fs_value_is_string)
+			break;
+		if (param->type == fs_value_is_flag) {
 			if (p->flags & fs_param_v_optional)
 				goto okay;
-			goto bad_value;
 		}
-		/* Fall through */
+		goto bad_value;
 	default:
 		break;
 	}
@@ -144,8 +142,7 @@ int fs_parse(struct fs_context *fc,
 	 */
 	switch (p->type) {
 	case fs_param_is_flag:
-		if (param->type != fs_value_is_flag &&
-		    (param->type != fs_value_is_string || result->has_value))
+		if (param->type != fs_value_is_flag)
 			return invalf(fc, "%s: Unexpected value for '%s'",
 				      desc->name, param->key);
 		result->boolean = true;
@@ -206,9 +203,6 @@ int fs_parse(struct fs_context *fc,
 	case fs_param_is_fd: {
 		switch (param->type) {
 		case fs_value_is_string:
-			if (!result->has_value)
-				goto bad_value;
-
 			ret = kstrtouint(param->string, 0, &result->uint_32);
 			break;
 		case fs_value_is_file:
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index dee140db6240..45323203128b 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -72,7 +72,6 @@ struct fs_parameter_description {
  */
 struct fs_parse_result {
 	bool			negated;	/* T if param was "noxxx" */
-	bool			has_value;	/* T if value supplied to param */
 	union {
 		bool		boolean;	/* For spec_bool */
 		int		int_32;		/* For spec_s32/spec_enum */
