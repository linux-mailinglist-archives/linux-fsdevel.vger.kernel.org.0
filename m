Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11ED643CBE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 16:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbhJ0OVv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 10:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242520AbhJ0OVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635344356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVFqLDCrHasN3ksu4U7F2BDhLyaCmyCxmI9lSrPwEqU=;
        b=A/oqRZzVE12n1aaLXjVfCMGwuCJvfnd1drNv1NJjCHQKyJiA87mI/uNSJLuyRs/MuF2YDs
        RRLvQlu1bMYnkZwcZ6a4E4ms2hXUnwo8FTQSO8GzhQxGI1cGhHxsvhTDb1wQvQCXtFeBQY
        o74i4HEzQEqoAe4K28URW4oIrAPAjW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-GjJ-RYQYOUmpd1f0iPfRLw-1; Wed, 27 Oct 2021 10:19:15 -0400
X-MC-Unique: GjJ-RYQYOUmpd1f0iPfRLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20B2C101F7A4;
        Wed, 27 Oct 2021 14:19:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1FF75DF35;
        Wed, 27 Oct 2021 14:19:12 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v4 01/13] fs_parse: allow parameter value to be empty
Date:   Wed, 27 Oct 2021 16:18:45 +0200
Message-Id: <20211027141857.33657-2-lczerner@redhat.com>
In-Reply-To: <20211027141857.33657-1-lczerner@redhat.com>
References: <20211027141857.33657-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow parameter value to be empty by specifying fs_param_can_be_empty
flag.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
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

