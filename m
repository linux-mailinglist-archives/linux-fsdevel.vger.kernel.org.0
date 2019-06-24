Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 077FC50D5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbfFXOJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:09:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfFXOJg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:09:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52F79307EA85;
        Mon, 24 Jun 2019 14:09:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 404266085B;
        Mon, 24 Jun 2019 14:09:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/25] vfs: Implement parameter value retrieval with
 fsinfo() [ver #14]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 15:09:33 +0100
Message-ID: <156138537329.25627.5525420330768463735.stgit@warthog.procyon.org.uk>
In-Reply-To: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 24 Jun 2019 14:09:36 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement parameter value retrieval with fsinfo() - akin to parsing
/proc/mounts.

This allows all the parameters to be retrieved in one go with:

	struct fsinfo_params params = {
		.request	= FSINFO_ATTR_PARAMETER,
	};

Each parameter comes as a pair of blobs with a length tacked on the front
rather than using separators, since any printable character that could be
used as a separator can be found in some value somewhere (including comma).
In fact, cifs allows the separator to be set using the "sep=" option in
parameter parsing.

The length on the front of each blob is 1-3 bytes long.  Each byte has a
flag in bit 7 that's set if there are more bytes and clear on the last
byte; bits 0-6 should be shifted and OR'd into the length count.  The bytes
are most-significant first.

For example, 0x83 0xf5 0x06 is the length (0x03<<14 | 0x75<<7 | 0x06).

As mentioned, each parameter comes as a pair of blobs in key, value order.
The value has length zero if not present.  So, for example:

	\x08compress\x04zlib

from btrfs would be equivalent to "compress=zlib" and:

	\x02ro\x00\x06noexec\x00

would be equivalent to "ro,noexec".

The test-fsinfo sample program is modified to dump the parameters.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c                 |  122 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fsinfo.h      |    4 +
 include/uapi/linux/fsinfo.h |    1 
 samples/vfs/test-fsinfo.c   |   38 +++++++++++++
 4 files changed, 165 insertions(+)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 9e2a25510b88..3b35cedab0df 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -296,6 +296,32 @@ static int fsinfo_generic_param_enum(struct file_system_type *f,
 	return sizeof(*p);
 }
 
+void fsinfo_note_sb_params(struct fsinfo_kparams *params, unsigned int s_flags)
+{
+	if (s_flags & SB_DIRSYNC)
+		fsinfo_note_param(params, "dirsync", NULL);
+	if (s_flags & SB_LAZYTIME)
+		fsinfo_note_param(params, "lazytime", NULL);
+	if (s_flags & SB_MANDLOCK)
+		fsinfo_note_param(params, "mand", NULL);
+	if (s_flags & SB_POSIXACL)
+		fsinfo_note_param(params, "posixacl", NULL);
+	if (s_flags & SB_RDONLY)
+		fsinfo_note_param(params, "ro", NULL);
+	else
+		fsinfo_note_param(params, "rw", NULL);
+	if (s_flags & SB_SYNCHRONOUS)
+		fsinfo_note_param(params, "sync", NULL);
+}
+EXPORT_SYMBOL(fsinfo_note_sb_params);
+
+static int fsinfo_generic_parameters(struct path *path,
+				     struct fsinfo_kparams *params)
+{
+	fsinfo_note_sb_params(params, READ_ONCE(path->dentry->d_sb->s_flags));
+	return params->usage;
+}
+
 /*
  * Implement some queries generically from stuff in the superblock.
  */
@@ -304,6 +330,7 @@ int generic_fsinfo(struct path *path, struct fsinfo_kparams *params)
 	struct file_system_type *fs = path->dentry->d_sb->s_type;
 
 #define _gen(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(path, params->buffer)
+#define _genp(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(path, params)
 #define _genf(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(fs, params)
 
 	switch (params->request) {
@@ -319,6 +346,7 @@ int generic_fsinfo(struct path *path, struct fsinfo_kparams *params)
 	case _genf(PARAM_DESCRIPTION,	param_description);
 	case _genf(PARAM_SPECIFICATION,	param_specification);
 	case _genf(PARAM_ENUM,		param_enum);
+	case _genp(PARAMETERS,		parameters);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -358,8 +386,16 @@ static int vfs_fsinfo(struct path *path, struct fsinfo_kparams *params)
 		return fsinfo(path, params);
 
 	while (!signal_pending(current)) {
+		if (params->request == FSINFO_ATTR_PARAMETERS) {
+			if (down_read_killable(&dentry->d_sb->s_umount) < 0)
+				return -ERESTARTSYS;
+		}
+
 		params->usage = 0;
 		ret = fsinfo(path, params);
+		if (params->request == FSINFO_ATTR_PARAMETERS)
+			up_read(&dentry->d_sb->s_umount);
+
 		if (ret <= (int)params->buf_size)
 			return ret; /* Error or it fitted */
 		kvfree(params->buffer);
@@ -529,6 +565,7 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRUCT		(PARAM_DESCRIPTION,	param_description),
 	FSINFO_STRUCT_N		(PARAM_SPECIFICATION,	param_specification),
 	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
+	FSINFO_OPAQUE		(PARAMETERS,		-),
 };
 
 /**
@@ -676,3 +713,88 @@ SYSCALL_DEFINE5(fsinfo,
 error:
 	return ret;
 }
+
+/*
+ * Store a parameter into the user's parameter buffer.  The key is prefixed by
+ * a single byte length (1-127) and the value by one (0-0x7f) or two bytes
+ * (0x80-0x3fff) or three bytes (0x4000-0x1fffff).
+ *
+ * Note that we must always make the size determination, even if the buffer is
+ * already full, so that we can tell the caller how much buffer we actually
+ * need.
+ */
+static void __fsinfo_note_param(struct fsinfo_kparams *params, const char *key,
+				const char *val, unsigned int vlen)
+{
+	char *p;
+	unsigned int usage;
+	int klen, total, vmeta;
+	u8 x;
+
+	klen = strlen(key);
+	BUG_ON(klen < 1 || klen > 127);
+	BUG_ON(vlen > (1 << 21) - 1);
+	BUG_ON(vlen > 0 && !val);
+
+	vmeta = (vlen <= 127) ? 1 : (vlen <= 127 * 127) ? 2 : 3;
+
+	total = 1 + klen + vmeta + vlen;
+
+	usage = params->usage;
+	params->usage = usage + total;
+	if (!params->buffer || params->usage > params->buf_size)
+		return;
+
+	p = params->buffer + usage;
+	*p++ = klen;
+	p = memcpy(p, key, klen);
+	p += klen;
+
+	/* The more significant groups of 7 bits in the size are included in
+	 * most->least order with 0x80 OR'd in.  The least significant 7 bits
+	 * are last with the top bit clear.
+	 */
+	x = vlen >> 14;
+	if (x & 0x7f)
+		*p++ = 0x80 | x;
+
+	x = vlen >> 7;
+	if (x & 0x7f)
+		*p++ = 0x80 | x;
+
+	*p++ = vlen & 0x7f;
+	memcpy(p, val, vlen);
+}
+
+/**
+ * fsinfo_note_param - Store a parameter for FSINFO_ATTR_PARAMETERS
+ * @params: The parameter buffer
+ * @key: The parameter's key
+ * @val: The parameter's value (or NULL)
+ */
+void fsinfo_note_param(struct fsinfo_kparams *params, const char *key,
+		       const char *val)
+{
+	__fsinfo_note_param(params, key, val, val ? strlen(val) : 0);
+}
+EXPORT_SYMBOL(fsinfo_note_param);
+
+/**
+ * fsinfo_note_paramf - Store a formatted parameter for FSINFO_ATTR_PARAMETERS
+ * @params: The parameter buffer
+ * @key: The parameter's key
+ * @val_fmt: Format string for the parameter's value
+ */
+void fsinfo_note_paramf(struct fsinfo_kparams *params, const char *key,
+			const char *val_fmt, ...)
+{
+	va_list va;
+	int n;
+
+	va_start(va, val_fmt);
+	n = vsnprintf(params->scratch_buffer, 4096, val_fmt, va);
+	va_end(va);
+
+	__fsinfo_note_param(params, key, params->scratch_buffer, n);
+}
+EXPORT_SYMBOL(fsinfo_note_paramf);
diff --git a/include/linux/fsinfo.h b/include/linux/fsinfo.h
index e17e4f0bae18..731931afbf1c 100644
--- a/include/linux/fsinfo.h
+++ b/include/linux/fsinfo.h
@@ -29,6 +29,10 @@ struct fsinfo_kparams {
 };
 
 extern int generic_fsinfo(struct path *, struct fsinfo_kparams *);
+extern void fsinfo_note_sb_params(struct fsinfo_kparams *, unsigned int);
+extern void fsinfo_note_param(struct fsinfo_kparams *, const char *, const char *);
+extern void fsinfo_note_paramf(struct fsinfo_kparams *, const char *, const char *, ...)
+	__printf(3, 4);
 
 static inline void fsinfo_set_cap(struct fsinfo_capabilities *c,
 				  enum fsinfo_capability cap)
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 9d929d2f7eee..475cd1c97b12 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -30,6 +30,7 @@ enum fsinfo_attribute {
 	FSINFO_ATTR_PARAM_DESCRIPTION	= 12,	/* General fs parameter description */
 	FSINFO_ATTR_PARAM_SPECIFICATION	= 13,	/* Nth parameter specification */
 	FSINFO_ATTR_PARAM_ENUM		= 14,	/* Nth enum-to-val */
+	FSINFO_ATTR_PARAMETERS		= 15,	/* Mount parameters (large string) */
 	FSINFO_ATTR__NR
 };
 
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 3c6ea3a5c157..8cf5b02e333a 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -81,6 +81,7 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRUCT		(PARAM_DESCRIPTION,	param_description),
 	FSINFO_STRUCT_N		(PARAM_SPECIFICATION,	param_specification),
 	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
+	FSINFO_OVERLARGE	(PARAMETERS,		-),
 };
 
 #define FSINFO_NAME(X,Y) [FSINFO_ATTR_##X] = #Y
@@ -100,6 +101,7 @@ static const char *fsinfo_attr_names[FSINFO_ATTR__NR] = {
 	FSINFO_NAME		(PARAM_DESCRIPTION,	param_description),
 	FSINFO_NAME		(PARAM_SPECIFICATION,	param_specification),
 	FSINFO_NAME		(PARAM_ENUM,		param_enum),
+	FSINFO_NAME		(PARAMETERS,		parameters),
 };
 
 union reply {
@@ -352,6 +354,34 @@ static void dump_fsinfo(enum fsinfo_attribute attr,
 	dumper(r, size);
 }
 
+static void dump_params(struct fsinfo_attr_info about, union reply *r, int size)
+{
+	int len;
+	char *p = r->buffer, *e = p + size;
+	bool is_key = true;
+
+	while (p < e) {
+		len = 0;
+		while (p[0] & 0x80) {
+			len <<= 7;
+			len |= *p++ & 0x7f;
+		}
+
+		len <<= 7;
+		len |= *p++;
+		if (len > e - p)
+			break;
+		if (is_key || len)
+			printf("%s%*.*s", is_key ? "[PARM] " : "= ", len, len, p);
+		if (is_key)
+			putchar(' ');
+		else
+			putchar('\n');
+		p += len;
+		is_key = !is_key;
+	}
+}
+
 /*
  * Try one subinstance of an attribute.
  */
@@ -427,6 +457,12 @@ static int try_one(const char *file, struct fsinfo_params *params, bool raw)
 		return 0;
 	}
 
+	switch (params->request) {
+	case FSINFO_ATTR_PARAMETERS:
+		if (ret == 0)
+			return 0;
+	}
+
 	switch (about.flags & (__FSINFO_N | __FSINFO_NM)) {
 	case 0:
 		printf("\e[33m%s\e[m: ",
@@ -469,6 +505,8 @@ static int try_one(const char *file, struct fsinfo_params *params, bool raw)
 		return 0;
 
 	case __FSINFO_OVER:
+		if (params->request == FSINFO_ATTR_PARAMETERS)
+			dump_params(about, r, ret);
 		return 0;
 
 	case __FSINFO_STRUCT_ARRAY:

