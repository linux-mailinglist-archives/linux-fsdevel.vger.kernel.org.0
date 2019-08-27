Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83CB79DACC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 02:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfH0AqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 20:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfH0AqV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 20:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 910312A09A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2019 00:46:20 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0343B196AE;
        Tue, 27 Aug 2019 00:46:19 +0000 (UTC)
To:     fsdevel <linux-fsdevel@vger.kernel.org>
From:   Eric Sandeen <sandeen@redhat.com>
Cc:     David Howells <dhowells@redhat.com>
Subject: [PATCH] fs: fs_parser: remove fs_parameter_description name field
Message-ID: <7020be46-f21f-bd05-71a5-cb2bc073596b@redhat.com>
Date:   Mon, 26 Aug 2019 19:46:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 27 Aug 2019 00:46:20 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There doesn't seem to be a strong reason to have another copy of the
filesystem name string in the fs_parameter_description structure;
it's easy enough to get the name from the fs_type, and using it
instead ensures consistency across messages (for example,
vfs_parse_fs_param() already uses fc->fs_type->name for the error
messages, because it doesn't have the fs_parameter_description).

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

If I'm missing a reason for the separate copy of the string, feel
free to nak...

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a46dee8e78db..5999eae23308 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2047,7 +2047,6 @@ static const struct fs_parameter_spec rdt_param_specs[] = {
 };
 
 static const struct fs_parameter_description rdt_fs_parameters = {
-	.name		= "rdt",
 	.specs		= rdt_param_specs,
 };
 
diff --git a/fs/afs/super.c b/fs/afs/super.c
index f18911e8d770..b7c2dd4219dd 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -90,7 +90,6 @@ static const struct fs_parameter_enum afs_param_enums[] = {
 };
 
 static const struct fs_parameter_description afs_fs_parameters = {
-	.name		= "kAFS",
 	.specs		= afs_param_specs,
 	.enums		= afs_param_enums,
 };
diff --git a/fs/filesystems.c b/fs/filesystems.c
index 9135646e41ac..77bf5f95362d 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -74,7 +74,8 @@ int register_filesystem(struct file_system_type * fs)
 	int res = 0;
 	struct file_system_type ** p;
 
-	if (fs->parameters && !fs_validate_description(fs->parameters))
+	if (fs->parameters &&
+	    !fs_validate_description(fs->name, fs->parameters))
 		return -EINVAL;
 
 	BUG_ON(strchr(fs->name, '.'));
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 460ea4206fa2..43d5ca08e629 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -111,7 +111,7 @@ int fs_parse(struct fs_context *fc,
 
 	if (p->flags & fs_param_deprecated)
 		warnf(fc, "%s: Deprecated parameter '%s'",
-		      desc->name, param->key);
+		      fc->fs_type->name, param->key);
 
 	if (result->negated)
 		goto okay;
@@ -147,7 +147,7 @@ int fs_parse(struct fs_context *fc,
 		if (param->type != fs_value_is_flag &&
 		    (param->type != fs_value_is_string || result->has_value))
 			return invalf(fc, "%s: Unexpected value for '%s'",
-				      desc->name, param->key);
+				      fc->fs_type->name, param->key);
 		result->boolean = true;
 		goto okay;
 
@@ -223,7 +223,8 @@ int fs_parse(struct fs_context *fc,
 	return p->opt;
 
 bad_value:
-	return invalf(fc, "%s: Bad value for '%s'", desc->name, param->key);
+	return invalf(fc, "%s: Bad value for '%s'",
+		      fc->fs_type->name, param->key);
 unknown_parameter:
 	return -ENOPARAM;
 }
@@ -343,22 +344,16 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
  * fs_validate_description - Validate a parameter description
  * @desc: The parameter description to validate.
  */
-bool fs_validate_description(const struct fs_parameter_description *desc)
+bool fs_validate_description(const char *name,
+	const struct fs_parameter_description *desc)
 {
 	const struct fs_parameter_spec *param, *p2;
 	const struct fs_parameter_enum *e;
-	const char *name = desc->name;
 	unsigned int nr_params = 0;
 	bool good = true, enums = false;
 
 	pr_notice("*** VALIDATE %s ***\n", name);
 
-	if (!name[0]) {
-		pr_err("VALIDATE Parser: No name\n");
-		name = "Unknown";
-		good = false;
-	}
-
 	if (desc->specs) {
 		for (param = desc->specs; param->name; param++) {
 			enum fs_parameter_type t = param->type;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a478df035651..67b76e0125a4 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -85,7 +85,6 @@ static const struct fs_parameter_spec hugetlb_param_specs[] = {
 };
 
 static const struct fs_parameter_description hugetlb_fs_parameters = {
-	.name		= "hugetlbfs",
 	.specs		= hugetlb_param_specs,
 };
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 33f72d1b92cc..b3dc8e0da732 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -48,7 +48,6 @@ static const struct fs_parameter_spec proc_param_specs[] = {
 };
 
 static const struct fs_parameter_description proc_fs_parameters = {
-	.name		= "proc",
 	.specs		= proc_param_specs,
 };
 
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index dee140db6240..090a2edf3e72 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -62,7 +62,6 @@ struct fs_parameter_enum {
 };
 
 struct fs_parameter_description {
-	const char	name[16];		/* Name for logging purposes */
 	const struct fs_parameter_spec *specs;	/* List of param specifications */
 	const struct fs_parameter_enum *enums;	/* Enum values */
 };
@@ -97,12 +96,14 @@ extern int __lookup_constant(const struct constant_table tbl[], size_t tbl_size,
 #ifdef CONFIG_VALIDATE_FS_PARSER
 extern bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
 				    int low, int high, int special);
-extern bool fs_validate_description(const struct fs_parameter_description *desc);
+extern bool fs_validate_description(const char *name,
+				    const struct fs_parameter_description *desc);
 #else
 static inline bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
 					   int low, int high, int special)
 { return true; }
-static inline bool fs_validate_description(const struct fs_parameter_description *desc)
+static inline bool fs_validate_description(const char *name,
+					   const struct fs_parameter_description *desc)
 { return true; }
 #endif
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 88006be40ea3..9a317f08b323 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -918,7 +918,6 @@ static const struct fs_parameter_spec cgroup1_param_specs[] = {
 };
 
 const struct fs_parameter_description cgroup1_fs_parameters = {
-	.name		= "cgroup1",
 	.specs		= cgroup1_param_specs,
 };
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 753afbca549f..ee3a84aa6599 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1826,7 +1826,6 @@ static const struct fs_parameter_spec cgroup2_param_specs[] = {
 };
 
 static const struct fs_parameter_description cgroup2_fs_parameters = {
-	.name		= "cgroup2",
 	.specs		= cgroup2_param_specs,
 };
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 74dd46de01b6..9e45cf94cd4d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2820,7 +2820,6 @@ static const struct fs_parameter_spec selinux_param_specs[] = {
 };
 
 static const struct fs_parameter_description selinux_fs_parameters = {
-	.name		= "SELinux",
 	.specs		= selinux_param_specs,
 };
 
@@ -7021,7 +7020,7 @@ static __init int selinux_init(void)
 	else
 		pr_debug("SELinux:  Starting in permissive mode\n");
 
-	fs_validate_description(&selinux_fs_parameters);
+	fs_validate_description("selinux", &selinux_fs_parameters);
 
 	return 0;
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4c5e5a438f8b..87d9e4a1e3ed 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -690,7 +690,6 @@ static const struct fs_parameter_spec smack_param_specs[] = {
 };
 
 static const struct fs_parameter_description smack_fs_parameters = {
-	.name		= "smack",
 	.specs		= smack_param_specs,
 };
 

