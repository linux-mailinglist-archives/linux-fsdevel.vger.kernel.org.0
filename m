Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0786F436090
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 13:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhJULro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 07:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230411AbhJULrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634816716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f729deV6SBYmuHP64BKtDJJfyd+xGoEE+ZW4OlBFRAk=;
        b=Cvm0102o0XsD5jzCWMHfbCQb/qTJsIYnEWMK1iiqr2BcdN83lQlBeTEWtmNyV5bItv1HGX
        ev6TSsHyFyqazkJIo7L9TKHGfgWitVnGL1A4t5Vu4fnDMS4BuMhWd3o9dYBuXC3aPX0j/4
        UsgUjc4KgjQPL+4JtM9w9jtVUu7aOSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-6VqvFNU_PJS_kdjnlTZ3Yw-1; Thu, 21 Oct 2021 07:45:15 -0400
X-MC-Unique: 6VqvFNU_PJS_kdjnlTZ3Yw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13E51100CCC1;
        Thu, 21 Oct 2021 11:45:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E20DB69217;
        Thu, 21 Oct 2021 11:45:12 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 01/13] fs_parse: allow parameter value to be empty
Date:   Thu, 21 Oct 2021 13:44:56 +0200
Message-Id: <20211021114508.21407-2-lczerner@redhat.com>
In-Reply-To: <20211021114508.21407-1-lczerner@redhat.com>
References: <20211021114508.21407-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow parameter value to be empty by spcifying fs_param_can_be_empty
flag.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fs_parser.c            | 31 +++++++++++++++++++++++--------
 include/linux/fs_parser.h |  2 +-
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 3df07c0e32b3..ed40ce5742fd 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -199,6 +199,8 @@ int fs_param_is_bool(struct p_log *log, const struct fs_parameter_spec *p,
 	int b;
 	if (param->type != fs_value_is_string)
 		return fs_param_bad_value(log, param);
+	if (!*param->string && (p->flags & fs_param_can_be_empty))
+		return 0;
 	b = lookup_constant(bool_names, param->string, -1);
 	if (b == -1)
 		return fs_param_bad_value(log, param);
@@ -211,8 +213,11 @@ int fs_param_is_u32(struct p_log *log, const struct fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
 	int base = (unsigned long)p->data;
-	if (param->type != fs_value_is_string ||
-	    kstrtouint(param->string, base, &result->uint_32) < 0)
+	if (param->type != fs_value_is_string)
+		return fs_param_bad_value(log, param);
+	if (!*param->string && (p->flags & fs_param_can_be_empty))
+		return 0;
+	if (kstrtouint(param->string, base, &result->uint_32) < 0)
 		return fs_param_bad_value(log, param);
 	return 0;
 }
@@ -221,8 +226,11 @@ EXPORT_SYMBOL(fs_param_is_u32);
 int fs_param_is_s32(struct p_log *log, const struct fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
-	if (param->type != fs_value_is_string ||
-	    kstrtoint(param->string, 0, &result->int_32) < 0)
+	if (param->type != fs_value_is_string)
+		return fs_param_bad_value(log, param);
+	if (!*param->string && (p->flags & fs_param_can_be_empty))
+		return 0;
+	if (kstrtoint(param->string, 0, &result->int_32) < 0)
 		return fs_param_bad_value(log, param);
 	return 0;
 }
@@ -231,8 +239,11 @@ EXPORT_SYMBOL(fs_param_is_s32);
 int fs_param_is_u64(struct p_log *log, const struct fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
-	if (param->type != fs_value_is_string ||
-	    kstrtoull(param->string, 0, &result->uint_64) < 0)
+	if (param->type != fs_value_is_string)
+		return fs_param_bad_value(log, param);
+	if (!*param->string && (p->flags & fs_param_can_be_empty))
+		return 0;
+	if (kstrtoull(param->string, 0, &result->uint_64) < 0)
 		return fs_param_bad_value(log, param);
 	return 0;
 }
@@ -244,6 +255,8 @@ int fs_param_is_enum(struct p_log *log, const struct fs_parameter_spec *p,
 	const struct constant_table *c;
 	if (param->type != fs_value_is_string)
 		return fs_param_bad_value(log, param);
+	if (!*param->string && (p->flags & fs_param_can_be_empty))
+		return 0;
 	c = __lookup_constant(p->data, param->string);
 	if (!c)
 		return fs_param_bad_value(log, param);
@@ -255,7 +268,8 @@ EXPORT_SYMBOL(fs_param_is_enum);
 int fs_param_is_string(struct p_log *log, const struct fs_parameter_spec *p,
 		       struct fs_parameter *param, struct fs_parse_result *result)
 {
-	if (param->type != fs_value_is_string || !*param->string)
+	if (param->type != fs_value_is_string ||
+	    (!*param->string && !(p->flags & fs_param_can_be_empty)))
 		return fs_param_bad_value(log, param);
 	return 0;
 }
@@ -275,7 +289,8 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
 {
 	switch (param->type) {
 	case fs_value_is_string:
-		if (kstrtouint(param->string, 0, &result->uint_32) < 0)
+		if ((!*param->string && !(p->flags & fs_param_can_be_empty)) ||
+		    kstrtouint(param->string, 0, &result->uint_32) < 0)
 			break;
 		if (result->uint_32 <= INT_MAX)
 			return 0;
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index aab0ffc6bac6..f103c91139d4 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -42,7 +42,7 @@ struct fs_parameter_spec {
 	u8			opt;	/* Option number (returned by fs_parse()) */
 	unsigned short		flags;
 #define fs_param_neg_with_no	0x0002	/* "noxxx" is negative param */
-#define fs_param_neg_with_empty	0x0004	/* "xxx=" is negative param */
+#define fs_param_can_be_empty	0x0004	/* "xxx=" is allowed */
 #define fs_param_deprecated	0x0008	/* The param is deprecated */
 	const void		*data;
 };
-- 
2.31.1

