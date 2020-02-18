Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA3FA162B51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgBRRF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:05:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33789 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726475AbgBRRF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582045526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SKeq+R5hg8niAmK4UlYSFJA6Mzo89VAHsWYSTZkNpcY=;
        b=XvNA6VVwOUUkASSvIstRy8GL+mQMR9JMe6J+L6KPuvtIle9gE4l022Aj+1FW5OKLGeqllW
        X7/faIeXlHA5PqwMfkVtiDJrfZbiI8lqcilG2HYYX3TxWzrxhs3M5xvnmO5RMCAigpf6FV
        E+RbT41doNVme+ZDKXwazqh8fFAr7Pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-PNeO0AxuNHqwIqLW4E8wQw-1; Tue, 18 Feb 2020 12:05:24 -0500
X-MC-Unique: PNeO0AxuNHqwIqLW4E8wQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E69D4107ACCA;
        Tue, 18 Feb 2020 17:05:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D0BE10021B2;
        Tue, 18 Feb 2020 17:05:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/19] fsinfo: Provide a bitmap of supported features [ver
 #16]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 17:05:20 +0000
Message-ID: <158204552063.3299825.17824500635078230412.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a bitmap of features that a filesystem may provide for the path
being queried.  Features include such things as:

 (1) The general class of filesystem, such as kernel-interface,
     block-based, flash-based, network-based.

 (2) Supported inode features, such as which timestamps are supported,
     whether simple numeric user, group or project IDs are supported and
     whether user identification is actually more complex behind the
     scenes.

 (3) Supported volume features, such as it having a UUID, a name or a
     filesystem ID.

 (4) Supported filesystem features, such as what types of file are
     supported, whether sparse files, extended attributes and quotas are
     supported.

 (5) Supported interface features, such as whether locking and leases are
     supported, what open flags are honoured and how i_version is managed.

For some filesystems, this may be an immutable set and can just be memcpy'd
into the reply buffer.
---

 fs/fsinfo.c                 |   41 +++++++++++++++++++
 include/linux/fsinfo.h      |   32 +++++++++++++++
 include/uapi/linux/fsinfo.h |   78 ++++++++++++++++++++++++++++++++++++
 samples/vfs/test-fsinfo.c   |   93 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 242 insertions(+), 2 deletions(-)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 3bc35b91f20b..55710d6da327 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -36,6 +36,17 @@ int fsinfo_string(const char *s, struct fsinfo_context *ctx)
 }
 EXPORT_SYMBOL(fsinfo_string);
 
+/*
+ * Get information about fsinfo() itself.
+ */
+static int fsinfo_generic_fsinfo(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_fsinfo *info = ctx->buffer;
+
+	info->max_features = FSINFO_FEAT__NR;
+	return sizeof(*info);
+}
+
 /*
  * Get basic filesystem stats from statfs.
  */
@@ -121,6 +132,33 @@ static int fsinfo_generic_supports(struct path *path, struct fsinfo_context *ctx
 	return sizeof(*c);
 }
 
+static int fsinfo_generic_features(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_features *ft = ctx->buffer;
+	struct super_block *sb = path->dentry->d_sb;
+
+	if (sb->s_mtd)
+		fsinfo_set_feature(ft, FSINFO_FEAT_IS_FLASH_FS);
+	else if (sb->s_bdev)
+		fsinfo_set_feature(ft, FSINFO_FEAT_IS_BLOCK_FS);
+
+	if (sb->s_quota_types & QTYPE_MASK_USR)
+		fsinfo_set_feature(ft, FSINFO_FEAT_USER_QUOTAS);
+	if (sb->s_quota_types & QTYPE_MASK_GRP)
+		fsinfo_set_feature(ft, FSINFO_FEAT_GROUP_QUOTAS);
+	if (sb->s_quota_types & QTYPE_MASK_PRJ)
+		fsinfo_set_feature(ft, FSINFO_FEAT_PROJECT_QUOTAS);
+	if (sb->s_d_op && sb->s_d_op->d_automount)
+		fsinfo_set_feature(ft, FSINFO_FEAT_AUTOMOUNTS);
+	if (sb->s_id[0])
+		fsinfo_set_feature(ft, FSINFO_FEAT_VOLUME_ID);
+
+	fsinfo_set_feature(ft, FSINFO_FEAT_HAS_ATIME);
+	fsinfo_set_feature(ft, FSINFO_FEAT_HAS_CTIME);
+	fsinfo_set_feature(ft, FSINFO_FEAT_HAS_MTIME);
+	return sizeof(*ft);
+}
+
 static const struct fsinfo_timestamp_info fsinfo_default_timestamp_info = {
 	.atime = {
 		.minimum	= S64_MIN,
@@ -252,6 +290,9 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_VSTRUCT	(FSINFO_ATTR_TIMESTAMP_INFO,	fsinfo_generic_timestamp_info),
 	FSINFO_STRING 	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		fsinfo_generic_features),
+
+	FSINFO_VSTRUCT	(FSINFO_ATTR_FSINFO,		fsinfo_generic_fsinfo),
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, fsinfo_attribute_info),
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	fsinfo_attributes),
 	{}
diff --git a/include/linux/fsinfo.h b/include/linux/fsinfo.h
index dcd55dbb02fa..564765c70659 100644
--- a/include/linux/fsinfo.h
+++ b/include/linux/fsinfo.h
@@ -65,6 +65,38 @@ struct fsinfo_attribute {
 
 extern int fsinfo_string(const char *, struct fsinfo_context *);
 
+static inline void fsinfo_set_feature(struct fsinfo_features *f,
+				      enum fsinfo_feature feature)
+{
+	f->features[feature / 8] |= 1 << (feature % 8);
+}
+
+static inline void fsinfo_clear_feature(struct fsinfo_features *f,
+					enum fsinfo_feature feature)
+{
+	f->features[feature / 8] &= ~(1 << (feature % 8));
+}
+
+/**
+ * fsinfo_set_unix_features - Set standard UNIX features.
+ * @f: The features mask to alter
+ */
+static inline void fsinfo_set_unix_features(struct fsinfo_features *f)
+{
+	fsinfo_set_feature(f, FSINFO_FEAT_UIDS);
+	fsinfo_set_feature(f, FSINFO_FEAT_GIDS);
+	fsinfo_set_feature(f, FSINFO_FEAT_DIRECTORIES);
+	fsinfo_set_feature(f, FSINFO_FEAT_SYMLINKS);
+	fsinfo_set_feature(f, FSINFO_FEAT_HARD_LINKS);
+	fsinfo_set_feature(f, FSINFO_FEAT_DEVICE_FILES);
+	fsinfo_set_feature(f, FSINFO_FEAT_UNIX_SPECIALS);
+	fsinfo_set_feature(f, FSINFO_FEAT_SPARSE);
+	fsinfo_set_feature(f, FSINFO_FEAT_HAS_ATIME);
+	fsinfo_set_feature(f, FSINFO_FEAT_HAS_CTIME);
+	fsinfo_set_feature(f, FSINFO_FEAT_HAS_MTIME);
+	fsinfo_set_feature(f, FSINFO_FEAT_HAS_INODE_NUMBERS);
+}
+
 #endif /* CONFIG_FSINFO */
 
 #endif /* _LINUX_FSINFO_H */
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 365d54fe9290..f40b5c0b5516 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -22,9 +22,11 @@
 #define FSINFO_ATTR_VOLUME_ID		0x05	/* Volume ID (string) */
 #define FSINFO_ATTR_VOLUME_UUID		0x06	/* Volume UUID (LE uuid) */
 #define FSINFO_ATTR_VOLUME_NAME		0x07	/* Volume name (string) */
+#define FSINFO_ATTR_FEATURES		0x08	/* Filesystem features (bits) */
 
 #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about attr N (for path) */
 #define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (for path) */
+#define FSINFO_ATTR_FSINFO		0x102	/* Information about fsinfo() as a whole */
 
 /*
  * Optional fsinfo() parameter structure.
@@ -45,6 +47,17 @@ struct fsinfo_params {
 	__u64	__reserved[3];
 };
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_FSINFO).
+ *
+ * This gives information about fsinfo() itself.
+ */
+struct fsinfo_fsinfo {
+	__u32	max_features;	/* Number of supported features (fsinfo_features__nr) */
+};
+
+#define FSINFO_ATTR_FSINFO__STRUCT struct fsinfo_fsinfo
+
 enum fsinfo_value_type {
 	FSINFO_TYPE_VSTRUCT	= 0,	/* Version-lengthed struct (up to 4096 bytes) */
 	FSINFO_TYPE_STRING	= 1,	/* NUL-term var-length string (up to 4095 chars) */
@@ -154,6 +167,71 @@ struct fsinfo_supports {
 
 #define FSINFO_ATTR_SUPPORTS__STRUCT struct fsinfo_supports
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_FEATURES).
+ *
+ * Bitmask indicating filesystem features where renderable as single bits.
+ */
+enum fsinfo_feature {
+	FSINFO_FEAT_IS_KERNEL_FS	= 0,	/* fs is kernel-special filesystem */
+	FSINFO_FEAT_IS_BLOCK_FS		= 1,	/* fs is block-based filesystem */
+	FSINFO_FEAT_IS_FLASH_FS		= 2,	/* fs is flash filesystem */
+	FSINFO_FEAT_IS_NETWORK_FS	= 3,	/* fs is network filesystem */
+	FSINFO_FEAT_IS_AUTOMOUNTER_FS	= 4,	/* fs is automounter special filesystem */
+	FSINFO_FEAT_IS_MEMORY_FS	= 5,	/* fs is memory-based filesystem */
+	FSINFO_FEAT_AUTOMOUNTS		= 6,	/* fs supports automounts */
+	FSINFO_FEAT_ADV_LOCKS		= 7,	/* fs supports advisory file locking */
+	FSINFO_FEAT_MAND_LOCKS		= 8,	/* fs supports mandatory file locking */
+	FSINFO_FEAT_LEASES		= 9,	/* fs supports file leases */
+	FSINFO_FEAT_UIDS		= 10,	/* fs supports numeric uids */
+	FSINFO_FEAT_GIDS		= 11,	/* fs supports numeric gids */
+	FSINFO_FEAT_PROJIDS		= 12,	/* fs supports numeric project ids */
+	FSINFO_FEAT_STRING_USER_IDS	= 13,	/* fs supports string user identifiers */
+	FSINFO_FEAT_GUID_USER_IDS	= 14,	/* fs supports GUID user identifiers */
+	FSINFO_FEAT_WINDOWS_ATTRS	= 15,	/* fs has windows attributes */
+	FSINFO_FEAT_USER_QUOTAS		= 16,	/* fs has per-user quotas */
+	FSINFO_FEAT_GROUP_QUOTAS	= 17,	/* fs has per-group quotas */
+	FSINFO_FEAT_PROJECT_QUOTAS	= 18,	/* fs has per-project quotas */
+	FSINFO_FEAT_XATTRS		= 19,	/* fs has xattrs */
+	FSINFO_FEAT_JOURNAL		= 20,	/* fs has a journal */
+	FSINFO_FEAT_DATA_IS_JOURNALLED	= 21,	/* fs is using data journalling */
+	FSINFO_FEAT_O_SYNC		= 22,	/* fs supports O_SYNC */
+	FSINFO_FEAT_O_DIRECT		= 23,	/* fs supports O_DIRECT */
+	FSINFO_FEAT_VOLUME_ID		= 24,	/* fs has a volume ID */
+	FSINFO_FEAT_VOLUME_UUID		= 25,	/* fs has a volume UUID */
+	FSINFO_FEAT_VOLUME_NAME		= 26,	/* fs has a volume name */
+	FSINFO_FEAT_VOLUME_FSID		= 27,	/* fs has a volume FSID */
+	FSINFO_FEAT_IVER_ALL_CHANGE	= 28,	/* i_version represents data + meta changes */
+	FSINFO_FEAT_IVER_DATA_CHANGE	= 29,	/* i_version represents data changes only */
+	FSINFO_FEAT_IVER_MONO_INCR	= 30,	/* i_version incremented monotonically */
+	FSINFO_FEAT_DIRECTORIES		= 31,	/* fs supports (sub)directories */
+	FSINFO_FEAT_SYMLINKS		= 32,	/* fs supports symlinks */
+	FSINFO_FEAT_HARD_LINKS		= 33,	/* fs supports hard links */
+	FSINFO_FEAT_HARD_LINKS_1DIR	= 34,	/* fs supports hard links in same dir only */
+	FSINFO_FEAT_DEVICE_FILES	= 35,	/* fs supports bdev, cdev */
+	FSINFO_FEAT_UNIX_SPECIALS	= 36,	/* fs supports pipe, fifo, socket */
+	FSINFO_FEAT_RESOURCE_FORKS	= 37,	/* fs supports resource forks/streams */
+	FSINFO_FEAT_NAME_CASE_INDEP	= 38,	/* Filename case independence is mandatory */
+	FSINFO_FEAT_NAME_NON_UTF8	= 39,	/* fs has non-utf8 names */
+	FSINFO_FEAT_NAME_HAS_CODEPAGE	= 40,	/* fs has a filename codepage */
+	FSINFO_FEAT_SPARSE		= 41,	/* fs supports sparse files */
+	FSINFO_FEAT_NOT_PERSISTENT	= 42,	/* fs is not persistent */
+	FSINFO_FEAT_NO_UNIX_MODE	= 43,	/* fs does not support unix mode bits */
+	FSINFO_FEAT_HAS_ATIME		= 44,	/* fs supports access time */
+	FSINFO_FEAT_HAS_BTIME		= 45,	/* fs supports birth/creation time */
+	FSINFO_FEAT_HAS_CTIME		= 46,	/* fs supports change time */
+	FSINFO_FEAT_HAS_MTIME		= 47,	/* fs supports modification time */
+	FSINFO_FEAT_HAS_ACL		= 48,	/* fs supports ACLs of some sort */
+	FSINFO_FEAT_HAS_INODE_NUMBERS	= 49,	/* fs has inode numbers */
+	FSINFO_FEAT__NR
+};
+
+struct fsinfo_features {
+	__u8	features[(FSINFO_FEAT__NR + 7) / 8];
+};
+
+#define FSINFO_ATTR_FEATURES__STRUCT struct fsinfo_features
+
 struct fsinfo_timestamp_one {
 	__s64	minimum;	/* Minimum timestamp value in seconds */
 	__u64	maximum;	/* Maximum timestamp value in seconds */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 9a4d49db2996..6fbf0ce099b2 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -107,6 +107,13 @@ static void dump_attribute_info(void *reply, unsigned int size)
 	       attr->name ? attr->name : "");
 }
 
+static void dump_fsinfo_info(void *reply, unsigned int size)
+{
+	struct fsinfo_fsinfo *f = reply;
+
+	printf("Number of feature bits: %u\n", f->max_features);
+}
+
 static void dump_fsinfo_generic_statfs(void *reply, unsigned int size)
 {
 	struct fsinfo_statfs *f = reply;
@@ -172,6 +179,74 @@ static void dump_fsinfo_generic_supports(void *reply, unsigned int size)
 	printf("\twin_fattrs   : %x\n", f->win_file_attrs);
 }
 
+#define FSINFO_FEATURE_NAME(C) [FSINFO_FEAT_##C] = #C
+static const char *fsinfo_feature_names[FSINFO_FEAT__NR] = {
+	FSINFO_FEATURE_NAME(IS_KERNEL_FS),
+	FSINFO_FEATURE_NAME(IS_BLOCK_FS),
+	FSINFO_FEATURE_NAME(IS_FLASH_FS),
+	FSINFO_FEATURE_NAME(IS_NETWORK_FS),
+	FSINFO_FEATURE_NAME(IS_AUTOMOUNTER_FS),
+	FSINFO_FEATURE_NAME(IS_MEMORY_FS),
+	FSINFO_FEATURE_NAME(AUTOMOUNTS),
+	FSINFO_FEATURE_NAME(ADV_LOCKS),
+	FSINFO_FEATURE_NAME(MAND_LOCKS),
+	FSINFO_FEATURE_NAME(LEASES),
+	FSINFO_FEATURE_NAME(UIDS),
+	FSINFO_FEATURE_NAME(GIDS),
+	FSINFO_FEATURE_NAME(PROJIDS),
+	FSINFO_FEATURE_NAME(STRING_USER_IDS),
+	FSINFO_FEATURE_NAME(GUID_USER_IDS),
+	FSINFO_FEATURE_NAME(WINDOWS_ATTRS),
+	FSINFO_FEATURE_NAME(USER_QUOTAS),
+	FSINFO_FEATURE_NAME(GROUP_QUOTAS),
+	FSINFO_FEATURE_NAME(PROJECT_QUOTAS),
+	FSINFO_FEATURE_NAME(XATTRS),
+	FSINFO_FEATURE_NAME(JOURNAL),
+	FSINFO_FEATURE_NAME(DATA_IS_JOURNALLED),
+	FSINFO_FEATURE_NAME(O_SYNC),
+	FSINFO_FEATURE_NAME(O_DIRECT),
+	FSINFO_FEATURE_NAME(VOLUME_ID),
+	FSINFO_FEATURE_NAME(VOLUME_UUID),
+	FSINFO_FEATURE_NAME(VOLUME_NAME),
+	FSINFO_FEATURE_NAME(VOLUME_FSID),
+	FSINFO_FEATURE_NAME(IVER_ALL_CHANGE),
+	FSINFO_FEATURE_NAME(IVER_DATA_CHANGE),
+	FSINFO_FEATURE_NAME(IVER_MONO_INCR),
+	FSINFO_FEATURE_NAME(DIRECTORIES),
+	FSINFO_FEATURE_NAME(SYMLINKS),
+	FSINFO_FEATURE_NAME(HARD_LINKS),
+	FSINFO_FEATURE_NAME(HARD_LINKS_1DIR),
+	FSINFO_FEATURE_NAME(DEVICE_FILES),
+	FSINFO_FEATURE_NAME(UNIX_SPECIALS),
+	FSINFO_FEATURE_NAME(RESOURCE_FORKS),
+	FSINFO_FEATURE_NAME(NAME_CASE_INDEP),
+	FSINFO_FEATURE_NAME(NAME_NON_UTF8),
+	FSINFO_FEATURE_NAME(NAME_HAS_CODEPAGE),
+	FSINFO_FEATURE_NAME(SPARSE),
+	FSINFO_FEATURE_NAME(NOT_PERSISTENT),
+	FSINFO_FEATURE_NAME(NO_UNIX_MODE),
+	FSINFO_FEATURE_NAME(HAS_ATIME),
+	FSINFO_FEATURE_NAME(HAS_BTIME),
+	FSINFO_FEATURE_NAME(HAS_CTIME),
+	FSINFO_FEATURE_NAME(HAS_MTIME),
+	FSINFO_FEATURE_NAME(HAS_ACL),
+	FSINFO_FEATURE_NAME(HAS_INODE_NUMBERS),
+};
+
+static void dump_fsinfo_generic_features(void *reply, unsigned int size)
+{
+	struct fsinfo_features *f = reply;
+	int i;
+
+	printf("\n\t");
+	for (i = 0; i < sizeof(f->features); i++)
+		printf("%02x", f->features[i]);
+	printf("\n");
+	for (i = 0; i < FSINFO_FEAT__NR; i++)
+		if (f->features[i / 8] & (1 << (i % 8)))
+			printf("\t- %s\n", fsinfo_feature_names[i]);
+}
+
 static void print_time(struct fsinfo_timestamp_one *t, char stamp)
 {
 	printf("\t%ctime       : gran=%gs range=%llx-%llx\n",
@@ -235,7 +310,6 @@ static void dump_string(void *reply, unsigned int size)
 
 #define dump_fsinfo_generic_volume_id		dump_string
 #define dump_fsinfo_generic_volume_name		dump_string
-#define dump_fsinfo_generic_name_encoding	dump_string
 
 /*
  *
@@ -266,6 +340,7 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_VSTRUCT	(FSINFO_ATTR_IDS,		fsinfo_generic_ids),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_LIMITS,		fsinfo_generic_limits),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		fsinfo_generic_supports),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		fsinfo_generic_features),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_TIMESTAMP_INFO,	fsinfo_generic_timestamp_info),
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
@@ -475,6 +550,7 @@ static int cmp_u32(const void *a, const void *b)
 int main(int argc, char **argv)
 {
 	struct fsinfo_attribute_info attr_info;
+	struct fsinfo_fsinfo fsinfo_info;
 	struct fsinfo_params params = {
 		.at_flags	= AT_SYMLINK_NOFOLLOW,
 		.flags		= FSINFO_FLAGS_QUERY_PATH,
@@ -531,6 +607,18 @@ int main(int argc, char **argv)
 	qsort(attrs, nr, sizeof(attrs[0]), cmp_u32);
 
 	if (meta) {
+		params.request = FSINFO_ATTR_FSINFO;
+		params.Nth = 0;
+		params.Mth = 0;
+		ret = fsinfo(AT_FDCWD, argv[0], &params, &fsinfo_info, sizeof(fsinfo_info));
+		if (ret == -1) {
+			fprintf(stderr, "Unable to get fsinfo information: %m\n");
+			exit(1);
+		}
+
+		dump_fsinfo_info(&fsinfo_info, ret);
+		printf("\n");
+
 		printf("ATTR ID  TYPE         FLAGS    SIZE  ESIZE NAME\n");
 		printf("======== ============ ======== ===== ===== =========\n");
 		for (i = 0; i < nr; i++) {
@@ -558,7 +646,8 @@ int main(int argc, char **argv)
 			exit(1);
 		}
 
-		if (attrs[i] == FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO ||
+		if (attrs[i] == FSINFO_ATTR_FSINFO ||
+		    attrs[i] == FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO ||
 		    attrs[i] == FSINFO_ATTR_FSINFO_ATTRIBUTES)
 			continue;
 


