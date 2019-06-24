Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F256350D59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfFXOJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:09:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfFXOJ1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:09:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF3498830F;
        Mon, 24 Jun 2019 14:09:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4ECFD60BFB;
        Mon, 24 Jun 2019 14:09:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/25] vfs: Allow fsinfo() to be used to query an fs
 parameter description [ver #14]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 15:09:21 +0100
Message-ID: <156138536153.25627.3397429813740738568.stgit@warthog.procyon.org.uk>
In-Reply-To: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 24 Jun 2019 14:09:27 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide fsinfo() attributes that can be used to query a filesystem
parameter description.  To do this, fsinfo() can be called on an
fs_context that doesn't yet have a superblock created and attached.

It can be obtained by doing, for example:

	fd = fsopen("ext4", 0);

	struct fsinfo_param_name name;
	struct fsinfo_params params = {
		.at_flags = AT_FSINFO_FROM_FSOPEN,
		.request = fsinfo_attr_param_name,
		.Nth	 = 3,
	};
	fsinfo(fd, NULL, &params, &name, sizeof(name));

to query the 4th parameter name in the name to parameter ID mapping table.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c                 |  101 +++++++++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h |   58 ++++++++++++++++++
 samples/vfs/Makefile        |    2 +
 samples/vfs/test-fs-query.c |  138 +++++++++++++++++++++++++++++++++++++++++++
 samples/vfs/test-fsinfo.c   |   14 ++++
 5 files changed, 311 insertions(+), 2 deletions(-)
 create mode 100644 samples/vfs/test-fs-query.c

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index c24701f994d1..9e2a25510b88 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 #include <linux/fsinfo.h>
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -223,12 +224,87 @@ static int fsinfo_generic_name_encoding(struct path *path, char *buf)
 	return sizeof(encoding) - 1;
 }
 
+static int fsinfo_generic_param_description(struct file_system_type *f,
+					    struct fsinfo_kparams *params)
+{
+	const struct fs_parameter_description *desc = f->parameters;
+	const struct fs_parameter_spec *s;
+	const struct fs_parameter_enum *e;
+	struct fsinfo_param_description *p = params->buffer;
+
+	if (desc && desc->specs) {
+		for (s = desc->specs; s->name; s++) {}
+		p->nr_params = s - desc->specs;
+		if (desc->enums) {
+			for (e = desc->enums; e->name[0]; e++) {}
+			p->nr_enum_names = e - desc->enums;
+		}
+	}
+
+	return sizeof(*p);
+}
+
+static int fsinfo_generic_param_specification(struct file_system_type *f,
+					      struct fsinfo_kparams *params)
+{
+	const struct fs_parameter_description *desc = f->parameters;
+	const struct fs_parameter_spec *s;
+	struct fsinfo_param_specification *p = params->buffer;
+	unsigned int nth = params->Nth;
+
+	if (!desc || !desc->specs)
+		return -ENODATA;
+
+	for (s = desc->specs; s->name; s++) {
+		if (nth == 0)
+			goto found;
+		nth--;
+	}
+
+	return -ENODATA;
+
+found:
+	p->type = s->type;
+	p->flags = s->flags;
+	p->opt = s->opt;
+	strlcpy(p->name, s->name, sizeof(p->name));
+	return sizeof(*p);
+}
+
+static int fsinfo_generic_param_enum(struct file_system_type *f,
+				     struct fsinfo_kparams *params)
+{
+	const struct fs_parameter_description *desc = f->parameters;
+	const struct fs_parameter_enum *e;
+	struct fsinfo_param_enum *p = params->buffer;
+	unsigned int nth = params->Nth;
+
+	if (!desc || !desc->enums)
+		return -ENODATA;
+
+	for (e = desc->enums; e->name; e++) {
+		if (nth == 0)
+			goto found;
+		nth--;
+	}
+
+	return -ENODATA;
+
+found:
+	p->opt = e->opt;
+	strlcpy(p->name, e->name, sizeof(p->name));
+	return sizeof(*p);
+}
+
 /*
  * Implement some queries generically from stuff in the superblock.
  */
 int generic_fsinfo(struct path *path, struct fsinfo_kparams *params)
 {
+	struct file_system_type *fs = path->dentry->d_sb->s_type;
+
 #define _gen(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(path, params->buffer)
+#define _genf(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(fs, params)
 
 	switch (params->request) {
 	case _gen(STATFS,		statfs);
@@ -240,6 +316,9 @@ int generic_fsinfo(struct path *path, struct fsinfo_kparams *params)
 	case _gen(VOLUME_UUID,		volume_uuid);
 	case _gen(VOLUME_ID,		volume_id);
 	case _gen(NAME_ENCODING,	name_encoding);
+	case _genf(PARAM_DESCRIPTION,	param_description);
+	case _genf(PARAM_SPECIFICATION,	param_specification);
+	case _genf(PARAM_ENUM,		param_enum);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -342,10 +421,11 @@ static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_kparams *params)
 }
 
 /*
- * Allow access to an fs_context object as created by fsopen() or fspick().
+ * Allow an fs_context object as created by fsopen() or fspick() to be queried.
  */
 static int vfs_fsinfo_fscontext(int fd, struct fsinfo_kparams *params)
 {
+	struct file_system_type *fs;
 	struct fs_context *fc;
 	struct fd f = fdget(fd);
 	int ret;
@@ -354,12 +434,26 @@ static int vfs_fsinfo_fscontext(int fd, struct fsinfo_kparams *params)
 		return -EBADF;
 
 	ret = -EINVAL;
-	if (f.file->f_op == &fscontext_fops)
+	if (f.file->f_op != &fscontext_fops)
 		goto out_f;
+	fc = f.file->private_data;
+	fs = fc->fs_type;
+
 	ret = -EOPNOTSUPP;
 	if (fc->ops == &legacy_fs_context_ops)
 		goto out_f;
 
+	/* Filesystem parameter query is static information and doesn't need a
+	 * lock to read it, nor even a dentry or superblock.
+	 */
+	switch (params->request) {
+	case _genf(PARAM_DESCRIPTION,	param_description);
+	case _genf(PARAM_SPECIFICATION,	param_specification);
+	case _genf(PARAM_ENUM,		param_enum);
+	default:
+		break;
+	}
+
 	ret = mutex_lock_interruptible(&fc->uapi_mutex);
 	if (ret == 0) {
 		ret = -EIO;
@@ -432,6 +526,9 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRING		(VOLUME_NAME,		-),
 	FSINFO_STRING		(NAME_ENCODING,		-),
 	FSINFO_STRING		(NAME_CODEPAGE,		-),
+	FSINFO_STRUCT		(PARAM_DESCRIPTION,	param_description),
+	FSINFO_STRUCT_N		(PARAM_SPECIFICATION,	param_specification),
+	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
 };
 
 /**
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index a7a7c731d992..9d929d2f7eee 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -27,6 +27,9 @@ enum fsinfo_attribute {
 	FSINFO_ATTR_VOLUME_NAME		= 9,	/* Volume name (string) */
 	FSINFO_ATTR_NAME_ENCODING	= 10,	/* Filename encoding (string) */
 	FSINFO_ATTR_NAME_CODEPAGE	= 11,	/* Filename codepage (string) */
+	FSINFO_ATTR_PARAM_DESCRIPTION	= 12,	/* General fs parameter description */
+	FSINFO_ATTR_PARAM_SPECIFICATION	= 13,	/* Nth parameter specification */
+	FSINFO_ATTR_PARAM_ENUM		= 14,	/* Nth enum-to-val */
 	FSINFO_ATTR__NR
 };
 
@@ -216,4 +219,59 @@ struct fsinfo_fsinfo {
 	__u32	max_cap;	/* Number of supported capabilities (fsinfo_cap__nr) */
 };
 
+/*
+ * Information struct for fsinfo(fsinfo_attr_param_description).
+ *
+ * Query the parameter set for a filesystem.
+ */
+struct fsinfo_param_description {
+	__u32		nr_params;		/* Number of individual parameters */
+	__u32		nr_enum_names;		/* Number of enum names  */
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_param_specification).
+ *
+ * Query the specification of the Nth filesystem parameter.
+ */
+struct fsinfo_param_specification {
+	__u32		type;		/* enum fsinfo_param_specification_type */
+	__u32		flags;		/* Qualifiers */
+	__u32		opt;		/* Corresponding params have same ID here */
+	char		name[240];
+};
+
+enum fsinfo_param_specification_type {
+	FSINFO_PARAM_SPEC_NOT_DEFINED		= 0,
+	FSINFO_PARAM_SPEC_IS_FLAG		= 1,
+	FSINFO_PARAM_SPEC_IS_BOOL		= 2,
+	FSINFO_PARAM_SPEC_IS_U32		= 3,
+	FSINFO_PARAM_SPEC_IS_U32_OCTAL		= 4,
+	FSINFO_PARAM_SPEC_IS_U32_HEX		= 5,
+	FSINFO_PARAM_SPEC_IS_S32		= 6,
+	FSINFO_PARAM_SPEC_IS_U64		= 7,
+	FSINFO_PARAM_SPEC_IS_ENUM		= 8,
+	FSINFO_PARAM_SPEC_IS_STRING		= 9,
+	FSINFO_PARAM_SPEC_IS_BLOB		= 10,
+	FSINFO_PARAM_SPEC_IS_BLOCKDEV		= 11,
+	FSINFO_PARAM_SPEC_IS_PATH		= 12,
+	FSINFO_PARAM_SPEC_IS_FD			= 13,
+	NR__FSINFO_PARAM_SPEC
+};
+
+#define FSINFO_PARAM_SPEC_VALUE_IS_OPTIONAL	0X00000001
+#define FSINFO_PARAM_SPEC_PREFIX_NO_IS_NEG	0X00000002
+#define FSINFO_PARAM_SPEC_EMPTY_STRING_IS_NEG	0X00000004
+#define FSINFO_PARAM_SPEC_DEPRECATED		0X00000008
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_param_enum).
+ *
+ * Query the Nth filesystem enum parameter value name.
+ */
+struct fsinfo_param_enum {
+	__u32		opt;		/* ->opt of the relevant parameter specification */
+	char		name[252];	/* Name of the enum value */
+};
+
 #endif /* _UAPI_LINUX_FSINFO_H */
diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index d3cc8e9a4fd8..3c542d3b9479 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,6 +1,7 @@
 # List of programs to build
 hostprogs-y := \
 	test-fsinfo \
+	test-fs-query \
 	test-fsmount \
 	test-statx
 
@@ -10,5 +11,6 @@ always := $(hostprogs-y)
 HOSTCFLAGS_test-fsinfo.o += -I$(objtree)/usr/include
 HOSTLDLIBS_test-fsinfo += -lm
 
+HOSTCFLAGS_test-fs-query.o += -I$(objtree)/usr/include
 HOSTCFLAGS_test-fsmount.o += -I$(objtree)/usr/include
 HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
diff --git a/samples/vfs/test-fs-query.c b/samples/vfs/test-fs-query.c
new file mode 100644
index 000000000000..7572411ddb7e
--- /dev/null
+++ b/samples/vfs/test-fs-query.c
@@ -0,0 +1,138 @@
+/* Test using the fsinfo() system call to query mount parameters.
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#define _GNU_SOURCE
+#define _ATFILE_SOURCE
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <errno.h>
+#include <time.h>
+#include <math.h>
+#include <sys/syscall.h>
+#include <linux/fsinfo.h>
+#include <linux/fcntl.h>
+#include <sys/stat.h>
+
+#ifndef __NR_fsopen
+#define __NR_fsopen -1
+#endif
+#ifndef __NR_fsinfo
+#define __NR_fsinfo -1
+#endif
+
+static int fsopen(const char *fs_name, unsigned int flags)
+{
+	return syscall(__NR_fsopen, fs_name, flags);
+}
+
+static ssize_t fsinfo(int dfd, const char *filename, struct fsinfo_params *params,
+		      void *buffer, size_t buf_size)
+{
+	return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
+}
+
+static const char *param_types[NR__FSINFO_PARAM_SPEC] = {
+	[FSINFO_PARAM_SPEC_NOT_DEFINED]		= "?undef",
+	[FSINFO_PARAM_SPEC_IS_FLAG]		= "flag",
+	[FSINFO_PARAM_SPEC_IS_BOOL]		= "bool",
+	[FSINFO_PARAM_SPEC_IS_U32]		= "u32",
+	[FSINFO_PARAM_SPEC_IS_U32_OCTAL]	= "octal",
+	[FSINFO_PARAM_SPEC_IS_U32_HEX]		= "hex",
+	[FSINFO_PARAM_SPEC_IS_S32]		= "s32",
+	[FSINFO_PARAM_SPEC_IS_U64]		= "u64",
+	[FSINFO_PARAM_SPEC_IS_ENUM]		= "enum",
+	[FSINFO_PARAM_SPEC_IS_STRING]		= "string",
+	[FSINFO_PARAM_SPEC_IS_BLOB]		= "binary",
+	[FSINFO_PARAM_SPEC_IS_BLOCKDEV]		= "blockdev",
+	[FSINFO_PARAM_SPEC_IS_PATH]		= "path",
+	[FSINFO_PARAM_SPEC_IS_FD]		= "fd",
+};
+
+/*
+ *
+ */
+int main(int argc, char **argv)
+{
+	struct fsinfo_param_description desc;
+	struct fsinfo_param_specification spec;
+	struct fsinfo_param_enum enum_name;
+
+	struct fsinfo_params params = {
+		.at_flags = AT_FSINFO_FROM_FSOPEN,
+	};
+	int fd;
+
+	if (argc != 2) {
+		printf("Format: test-fs-query <fs_name>\n");
+		exit(2);
+	}
+
+	fd = fsopen(argv[1], 0);
+	if (fd == -1) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	params.request = FSINFO_ATTR_PARAM_DESCRIPTION;
+	if (fsinfo(fd, NULL, &params, &desc, sizeof(desc)) == -1) {
+		perror("fsinfo/desc");
+		exit(1);
+	}
+
+	printf("Filesystem %s has %u parameters\n", argv[1], desc.nr_params);
+
+	params.request = FSINFO_ATTR_PARAM_SPECIFICATION;
+	for (params.Nth = 0; params.Nth < desc.nr_params; params.Nth++) {
+		char type[32];
+
+		if (fsinfo(fd, NULL, &params, &spec, sizeof(spec)) == -1) {
+			if (errno == ENODATA)
+				break;
+			perror("fsinfo/spec");
+			exit(1);
+		}
+
+		if (spec.type < NR__FSINFO_PARAM_SPEC)
+			strcpy(type, param_types[spec.type]);
+		else
+			sprintf(type, "?%u", spec.type);
+
+		printf("- PARAM[%3u] %-20s %3u %s%s%s%s%s\n",
+		       params.Nth,
+		       spec.name,
+		       spec.opt,
+		       type,
+		       spec.flags & FSINFO_PARAM_SPEC_VALUE_IS_OPTIONAL ? ",opt" : "",
+		       spec.flags & FSINFO_PARAM_SPEC_PREFIX_NO_IS_NEG ? ",neg-no" : "",
+		       spec.flags & FSINFO_PARAM_SPEC_EMPTY_STRING_IS_NEG ? ",neg-empty" : "",
+		       spec.flags & FSINFO_PARAM_SPEC_DEPRECATED ? ",dep" : "");
+	}
+
+	printf("Filesystem has %u enumeration values\n", desc.nr_enum_names);
+
+	params.request = FSINFO_ATTR_PARAM_ENUM;
+	for (params.Nth = 0; params.Nth < desc.nr_enum_names; params.Nth++) {
+		if (fsinfo(fd, NULL, &params, &enum_name, sizeof(enum_name)) == -1) {
+			if (errno == ENODATA)
+				break;
+			perror("fsinfo/enum");
+			exit(1);
+		}
+		printf("- ENUM[%3u] %3u: %s\n",
+		       params.Nth, enum_name.opt, enum_name.name);
+	}
+	return 0;
+}
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 8cce1986df7e..3c6ea3a5c157 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -78,6 +78,9 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRING		(VOLUME_NAME,		volume_name),
 	FSINFO_STRING		(NAME_ENCODING,		name_encoding),
 	FSINFO_STRING		(NAME_CODEPAGE,		name_codepage),
+	FSINFO_STRUCT		(PARAM_DESCRIPTION,	param_description),
+	FSINFO_STRUCT_N		(PARAM_SPECIFICATION,	param_specification),
+	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
 };
 
 #define FSINFO_NAME(X,Y) [FSINFO_ATTR_##X] = #Y
@@ -94,6 +97,9 @@ static const char *fsinfo_attr_names[FSINFO_ATTR__NR] = {
 	FSINFO_NAME		(VOLUME_NAME,		volume_name),
 	FSINFO_NAME		(NAME_ENCODING,		name_encoding),
 	FSINFO_NAME		(NAME_CODEPAGE,		name_codepage),
+	FSINFO_NAME		(PARAM_DESCRIPTION,	param_description),
+	FSINFO_NAME		(PARAM_SPECIFICATION,	param_specification),
+	FSINFO_NAME		(PARAM_ENUM,		param_enum),
 };
 
 union reply {
@@ -514,6 +520,14 @@ int main(int argc, char **argv)
 	}
 
 	for (attr = 0; attr <= FSINFO_ATTR__NR; attr++) {
+		switch (attr) {
+		case FSINFO_ATTR_PARAM_DESCRIPTION:
+		case FSINFO_ATTR_PARAM_SPECIFICATION:
+		case FSINFO_ATTR_PARAM_ENUM:
+			/* See test-fs-query.c instead */
+			continue;
+		}
+
 		Nth = 0;
 		do {
 			Mth = 0;

