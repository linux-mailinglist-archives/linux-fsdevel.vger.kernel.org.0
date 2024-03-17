Return-Path: <linux-fsdevel+bounces-14631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E6D87DED9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511521F211A6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17861C695;
	Sun, 17 Mar 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARHgy30p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3151B949;
	Sun, 17 Mar 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693449; cv=none; b=OOKWmFXwv/ffGKw5l0FLCazmrxv7u1lE0xEJohgxw7U+PCvsj/pCLsWvtVrcVJH36XawKwShJ1UuGZ2ffpBWQIrNyw/dkvljxytb7geN2Ek/dw/vMqLYPNer/CbwOASZHApIAzok6L+rY3WlqS+5W5x9lYO2p+Hw07RiuScVkwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693449; c=relaxed/simple;
	bh=f1UHsvnI1+vMIp5ZzTIP0wFfVfso3zMXLY3gsBKN0Sc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgVgHfzAHYkMGVhC5nfS/+hch/XsEscqsJ4w1NUxQem+U4STZ3Yzhbp+ZD8b0MQXziBSHuuzUdEibV7bzSlw0iFAUlUa2zjl1qaV/aaHdQ8RtUr8idVuyg4PMd1b2Tlm3GRwgwDA+cGvL6K7ZJhrwsabv0JN2zFHr7H91YhpLSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARHgy30p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A967C433F1;
	Sun, 17 Mar 2024 16:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693449;
	bh=f1UHsvnI1+vMIp5ZzTIP0wFfVfso3zMXLY3gsBKN0Sc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ARHgy30pZ8ssyx0hoUg9f9qaNyET3Lh6fz5DyQt4dOn9xIFd9yteQlEc2Nh7lBI5L
	 SpaqmENMUj8X+ALhUybKFoumYjGe/8SysjYkcpRWk4f0bCd5EqviESxARBtD2K5FPb
	 6nVZa9GNwDVX+ETA6N4j873TvWi5ALOGSt8UX1aJ80oQW+g89S1dsOJaZCQLyjoczC
	 bsknxt6dZnRljyDmslwWPXbni5x+/pLI0FeYW5+UxQcoHCqUQ49wKkBpMXiAfAZpQE
	 hS25avu4TPXF9qoXI0wj0BbDXTvRNmcTbLHksZq8hD05SgUrNDQTl9s5Mn0xQt/sX0
	 jEeVjJvT+LhiQ==
Date: Sun, 17 Mar 2024 09:37:28 -0700
Subject: [PATCH 14/20] xfs_db: introduce attr_modify command
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247868.2685643.16613479398038252216.stgit@frogsfrogsfrogs>
In-Reply-To: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
References: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

This command allows for writing value over already existing value of
inode's extended attribute. The difference from 'write' command is
that extended attribute can be addressed by name and new value is
written over old value.

The command also allows addressing via binary names (introduced by
parent pointers). This can be done by specified name length (-m) and
value in #hex format.

Example:

	# Modify attribute with name #00000042 by overwriting 8
	# bytes at offset 3 with value #0000000000FF00FF
	attr_modify -o 3 -m 4 -v 8 #42 #FF00FF

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 db/attrset.c |  202 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 db/write.c   |    2 -
 db/write.h   |    1 
 3 files changed, 202 insertions(+), 3 deletions(-)


diff --git a/db/attrset.c b/db/attrset.c
index 0d8d70a8..7249294a 100644
--- a/db/attrset.c
+++ b/db/attrset.c
@@ -16,10 +16,12 @@
 #include "field.h"
 #include "inode.h"
 #include "malloc.h"
+#include "write.h"
 #include <sys/xattr.h>
 
 static int		attr_set_f(int argc, char **argv);
 static int		attr_remove_f(int argc, char **argv);
+static int		attr_modify_f(int argc, char **argv);
 static void		attrset_help(void);
 
 static const cmdinfo_t	attr_set_cmd =
@@ -30,6 +32,11 @@ static const cmdinfo_t	attr_remove_cmd =
 	{ "attr_remove", "aremove", attr_remove_f, 1, -1, 0,
 	  N_("[-r|-s|-u] [-n] name"),
 	  N_("remove the named attribute from the current inode"), attrset_help };
+static const cmdinfo_t	attr_modify_cmd =
+	{ "attr_modify", "amodify", attr_modify_f, 1, -1, 0,
+	  N_("[-r|-s|-u] [-o n] [-v n] [-m n] name value"),
+	  N_("modify value of the named attribute of the current inode"),
+		attrset_help };
 
 static void
 attrset_help(void)
@@ -38,8 +45,9 @@ attrset_help(void)
 "\n"
 " The 'attr_set' and 'attr_remove' commands provide interfaces for debugging\n"
 " the extended attribute allocation and removal code.\n"
-" Both commands require an attribute name to be specified, and the attr_set\n"
-" command allows an optional value length (-v) to be provided as well.\n"
+" Both commands together with 'attr_modify' require an attribute name to be\n"
+" specified. The attr_set and attr_modify commands allow an optional value\n"
+" length (-v) to be provided as well.\n"
 " There are 4 namespace flags:\n"
 "  -r -- 'root'\n"
 "  -u -- 'user'		(default)\n"
@@ -48,6 +56,9 @@ attrset_help(void)
 " For attr_set, these options further define the type of set operation:\n"
 "  -C -- 'create'    - create attribute, fail if it already exists\n"
 "  -R -- 'replace'   - replace attribute, fail if it does not exist\n"
+" attr_modify command provides more of the following options:\n"
+"  -m -- 'name length'   - specify length of the name (handy with binary names)\n"
+"  -o -- 'value offset'   - offset new value within old attr's value\n"
 " The backward compatibility mode 'noattr2' can be emulated (-n) also.\n"
 "\n"));
 }
@@ -60,6 +71,7 @@ attrset_init(void)
 
 	add_command(&attr_set_cmd);
 	add_command(&attr_remove_cmd);
+	add_command(&attr_modify_cmd);
 }
 
 static int
@@ -263,3 +275,189 @@ attr_remove_f(
 		libxfs_irele(args.dp);
 	return 0;
 }
+
+static int
+attr_modify_f(
+	int			argc,
+	char			**argv)
+{
+	struct xfs_da_args	args = { };
+	int			c;
+	int			offset = 0;
+	char			*sp;
+	char			*converted;
+	uint8_t			*name;
+	int			namelen = 0;
+	uint8_t			*value;
+	int			valuelen = 0;
+
+	if (cur_typ == NULL) {
+		dbprintf(_("no current type\n"));
+		return 0;
+	}
+
+	if (cur_typ->typnm != TYP_INODE) {
+		dbprintf(_("current type is not inode\n"));
+		return 0;
+	}
+
+	while ((c = getopt(argc, argv, "rusnv:o:m:")) != EOF) {
+		switch (c) {
+		/* namespaces */
+		case 'r':
+			args.attr_filter |= LIBXFS_ATTR_ROOT;
+			args.attr_filter &= ~LIBXFS_ATTR_SECURE;
+			break;
+		case 'u':
+			args.attr_filter &= ~(LIBXFS_ATTR_ROOT |
+					      LIBXFS_ATTR_SECURE);
+			break;
+		case 's':
+			args.attr_filter |= LIBXFS_ATTR_SECURE;
+			args.attr_filter &= ~LIBXFS_ATTR_ROOT;
+			break;
+
+		case 'n':
+			/*
+			 * We never touch attr2 these days; leave this here to
+			 * avoid breaking scripts.
+			 */
+			break;
+
+		case 'o':
+			offset = strtol(optarg, &sp, 0);
+			if (*sp != '\0' || offset < 0 || offset > 64 * 1024) {
+				dbprintf(_("bad attr_modify offset %s\n"),
+						optarg);
+				return 0;
+			}
+			break;
+
+		case 'v':
+			valuelen = strtol(optarg, &sp, 0);
+			if (*sp != '\0' || offset < 0 || valuelen > 64 * 1024) {
+				dbprintf(_("bad attr_modify value len %s\n"),
+						optarg);
+				return 0;
+			}
+			break;
+
+		case 'm':
+			namelen = strtol(optarg, &sp, 0);
+			if (*sp != '\0' || offset < 0 || namelen > MAXNAMELEN) {
+				dbprintf(_("bad attr_modify name len %s\n"),
+						optarg);
+				return 0;
+			}
+			break;
+
+		default:
+			dbprintf(_("bad option for attr_modify command\n"));
+			return 0;
+		}
+	}
+
+	if (optind != argc - 2) {
+		dbprintf(_("too few options for attr_modify\n"));
+		return 0;
+	}
+
+	if (namelen >= MAXNAMELEN) {
+		dbprintf(_("name too long\n"));
+		return 0;
+	}
+
+	if (!namelen) {
+		if (argv[optind][0] == '#')
+			namelen = strlen(argv[optind])/2;
+		if (argv[optind][0] == '"')
+			namelen = strlen(argv[optind]) - 2;
+	}
+
+	name = xcalloc(namelen, sizeof(uint8_t));
+	converted = convert_arg(argv[optind], (int)(namelen*8));
+	if (!converted) {
+		dbprintf(_("invalid name\n"));
+		goto out_free_name;
+	}
+
+	memcpy(name, converted, namelen);
+	args.name = (const uint8_t *)name;
+	args.namelen = namelen;
+
+	optind++;
+
+	if (valuelen > 64 * 1024) {
+		dbprintf(_("value too long\n"));
+		goto out_free_name;
+	}
+
+	if (!valuelen) {
+		if (argv[optind][0] == '#')
+			valuelen = strlen(argv[optind])/2;
+		if (argv[optind][0] == '"')
+			valuelen = strlen(argv[optind]) - 2;
+	}
+
+	if ((valuelen + offset) > 64 * 1024) {
+		dbprintf(_("offsetted value too long\n"));
+		goto out_free_name;
+	}
+
+	value = xcalloc(valuelen, sizeof(uint8_t));
+	converted = convert_arg(argv[optind], (int)(valuelen*8));
+	if (!converted) {
+		dbprintf(_("invalid value\n"));
+		goto out_free_value;
+	}
+	memcpy(value, converted, valuelen);
+
+	if (libxfs_iget(mp, NULL, iocur_top->ino, 0, &args.dp)) {
+		dbprintf(_("failed to iget inode %llu\n"),
+			(unsigned long long)iocur_top->ino);
+		goto out;
+	}
+
+	if (libxfs_attr_get(&args)) {
+		dbprintf(_("failed to get attr '%s' from inode %llu\n"),
+			args.name, (unsigned long long)iocur_top->ino);
+		goto out;
+	}
+
+	if (valuelen + offset > args.valuelen) {
+		dbprintf(_("new value too long\n"));
+		goto out;
+	}
+
+	/* As args.valuelen is now set let's get args.value */
+	if (libxfs_attr_get(&args)) {
+		dbprintf(_("failed to get attr '%s' from inode %llu\n"),
+			args.name, (unsigned long long)iocur_top->ino);
+		goto out;
+	}
+
+	/* modify value */
+	memcpy((uint8_t *)args.value + offset, value, valuelen);
+
+	args.attr_flags = XATTR_REPLACE;
+	args.attr_flags &= ~XATTR_CREATE;
+	if (libxfs_attr_set(&args)) {
+		dbprintf(_("failed to set attr '%s' from inode %llu\n"),
+			(unsigned char *)args.name,
+			(unsigned long long)iocur_top->ino);
+		goto out;
+	}
+
+	/* refresh with updated inode contents */
+	set_cur_inode(iocur_top->ino);
+
+out:
+	if (args.dp)
+		libxfs_irele(args.dp);
+	xfree(args.value);
+out_free_value:
+	xfree(value);
+out_free_name:
+	xfree(name);
+	return 0;
+}
diff --git a/db/write.c b/db/write.c
index 96dea705..9295dbc9 100644
--- a/db/write.c
+++ b/db/write.c
@@ -511,7 +511,7 @@ convert_oct(
  * are adjusted in the buffer so that the first input bit is to be be written to
  * the first bit in the output.
  */
-static char *
+char *
 convert_arg(
 	char		*arg,
 	int		bit_length)
diff --git a/db/write.h b/db/write.h
index e24e07d4..4ba04d03 100644
--- a/db/write.h
+++ b/db/write.h
@@ -6,6 +6,7 @@
 
 struct field;
 
+extern char	*convert_arg(char *arg, int bit_length);
 extern void	write_init(void);
 extern void	write_block(const field_t *fields, int argc, char **argv);
 extern void	write_struct(const field_t *fields, int argc, char **argv);


