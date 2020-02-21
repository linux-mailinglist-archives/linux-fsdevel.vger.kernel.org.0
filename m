Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44FEB1685E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgBUSDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:03:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27672 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728442AbgBUSDC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582308178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+a4o6gIg+xTSFuQOyDOyz5dfHAf1a5JFpiyA8EzU+o=;
        b=HMrxenLmYFV6YaVYSyOOA/HQpFig93M4O1KXKJdc9yBlHWMGxBK8qkq/xNgGfg+++qWe8K
        wRuwx6e4KthNGZFHhjEAhZFlIX9p2CvQS0R4fskNM+YEYJa0JACvd9rb1S8gDY4A32Be4r
        IKP+eA/wTQAwC1BkuIziGP8XR5anqqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-lt0sQ3TjNf6jwug-tPIyXg-1; Fri, 21 Feb 2020 13:02:57 -0500
X-MC-Unique: lt0sQ3TjNf6jwug-tPIyXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE348107ACC5;
        Fri, 21 Feb 2020 18:02:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8745A5D9E2;
        Fri, 21 Feb 2020 18:02:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/17] fsinfo: Provide a bitmap of supported features [ver
 #17]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 18:02:52 +0000
Message-ID: <158230817278.2185128.5829650395549432816.stgit@warthog.procyon.org.uk>
In-Reply-To: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c                 |   30 +++++++++++++++++++
 include/linux/fsinfo.h      |   38 ++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h |   67 ++++++++++++++++++++++++++++++++++++++++++
 samples/vfs/test-fsinfo.c   |   69 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 204 insertions(+)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 5d3ba3c3a7ad..f423a4c5afd9 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -121,6 +121,35 @@ int fsinfo_generic_supports(struct path *path, struct fsinfo_context *ctx)
 }
 EXPORT_SYMBOL(fsinfo_generic_supports);
 
+int fsinfo_generic_features(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_features *p = ctx->buffer;
+	struct super_block *sb = path->dentry->d_sb;
+
+	fsinfo_init_features(p);
+	if (sb->s_mtd)
+		fsinfo_set_feature(p, FSINFO_FEAT_IS_FLASH_FS);
+	else if (sb->s_bdev)
+		fsinfo_set_feature(p, FSINFO_FEAT_IS_BLOCK_FS);
+
+	if (sb->s_quota_types & QTYPE_MASK_USR)
+		fsinfo_set_feature(p, FSINFO_FEAT_USER_QUOTAS);
+	if (sb->s_quota_types & QTYPE_MASK_GRP)
+		fsinfo_set_feature(p, FSINFO_FEAT_GROUP_QUOTAS);
+	if (sb->s_quota_types & QTYPE_MASK_PRJ)
+		fsinfo_set_feature(p, FSINFO_FEAT_PROJECT_QUOTAS);
+	if (sb->s_d_op && sb->s_d_op->d_automount)
+		fsinfo_set_feature(p, FSINFO_FEAT_AUTOMOUNTS);
+	if (sb->s_id[0])
+		fsinfo_set_feature(p, FSINFO_FEAT_VOLUME_ID);
+
+	fsinfo_set_feature(p, FSINFO_FEAT_HAS_ATIME);
+	fsinfo_set_feature(p, FSINFO_FEAT_HAS_CTIME);
+	fsinfo_set_feature(p, FSINFO_FEAT_HAS_MTIME);
+	return sizeof(*p);
+}
+EXPORT_SYMBOL(fsinfo_generic_features);
+
 static const struct fsinfo_timestamp_info fsinfo_default_timestamp_info = {
 	.atime = {
 		.minimum	= S64_MIN,
@@ -196,6 +225,7 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_VSTRUCT	(FSINFO_ATTR_TIMESTAMP_INFO,	fsinfo_generic_timestamp_info),
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		fsinfo_generic_features),
 
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	(void *)123UL),
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
diff --git a/include/linux/fsinfo.h b/include/linux/fsinfo.h
index 943fbd6640f9..1b141e8e88e0 100644
--- a/include/linux/fsinfo.h
+++ b/include/linux/fsinfo.h
@@ -66,6 +66,44 @@ extern int fsinfo_generic_supports(struct path *, struct fsinfo_context *);
 extern int fsinfo_generic_limits(struct path *, struct fsinfo_context *);
 extern int fsinfo_get_attribute(struct path *, struct fsinfo_context *,
 				const struct fsinfo_attribute *);
+extern int fsinfo_generic_features(struct path *, struct fsinfo_context *);
+
+static inline void fsinfo_init_features(struct fsinfo_features *p)
+{
+	p->nr_features = FSINFO_FEAT__NR;
+}
+
+static inline void fsinfo_set_feature(struct fsinfo_features *p,
+				      enum fsinfo_feature feature)
+{
+	p->features[feature / 8] |= 1 << (feature % 8);
+}
+
+static inline void fsinfo_clear_feature(struct fsinfo_features *p,
+					enum fsinfo_feature feature)
+{
+	p->features[feature / 8] &= ~(1 << (feature % 8));
+}
+
+/**
+ * fsinfo_set_unix_features - Set standard UNIX features.
+ * @f: The features mask to alter
+ */
+static inline void fsinfo_set_unix_features(struct fsinfo_features *p)
+{
+	fsinfo_set_feature(p, FSINFO_FEAT_UIDS);
+	fsinfo_set_feature(p, FSINFO_FEAT_GIDS);
+	fsinfo_set_feature(p, FSINFO_FEAT_DIRECTORIES);
+	fsinfo_set_feature(p, FSINFO_FEAT_SYMLINKS);
+	fsinfo_set_feature(p, FSINFO_FEAT_HARD_LINKS);
+	fsinfo_set_feature(p, FSINFO_FEAT_DEVICE_FILES);
+	fsinfo_set_feature(p, FSINFO_FEAT_UNIX_SPECIALS);
+	fsinfo_set_feature(p, FSINFO_FEAT_SPARSE);
+	fsinfo_set_feature(p, FSINFO_FEAT_HAS_ATIME);
+	fsinfo_set_feature(p, FSINFO_FEAT_HAS_CTIME);
+	fsinfo_set_feature(p, FSINFO_FEAT_HAS_MTIME);
+	fsinfo_set_feature(p, FSINFO_FEAT_HAS_INODE_NUMBERS);
+}
 
 #endif /* CONFIG_FSINFO */
 
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 6eb02de8a631..d7f24da36f0e 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -22,6 +22,7 @@
 #define FSINFO_ATTR_VOLUME_ID		0x05	/* Volume ID (string) */
 #define FSINFO_ATTR_VOLUME_UUID		0x06	/* Volume UUID (LE uuid) */
 #define FSINFO_ATTR_VOLUME_NAME		0x07	/* Volume name (string) */
+#define FSINFO_ATTR_FEATURES		0x08	/* Filesystem features (bits) */
 
 #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about attr N (for path) */
 #define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (for path) */
@@ -155,6 +156,72 @@ struct fsinfo_supports {
 
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
+	__u32	nr_features;	/* Number of supported features (FSINFO_FEAT__NR) */
+	__u8	features[(FSINFO_FEAT__NR + 7) / 8];
+};
+
+#define FSINFO_ATTR_FEATURES__STRUCT struct fsinfo_features
+
 struct fsinfo_timestamp_one {
 	__s64	minimum;	/* Minimum timestamp value in seconds */
 	__s64	maximum;	/* Maximum timestamp value in seconds */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 22fe3c47ff42..7f49c2125ed3 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -178,6 +178,74 @@ static void dump_fsinfo_generic_supports(void *reply, unsigned int size)
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
+	printf(" (nr=%u)\n", f->nr_features);
+	for (i = 0; i < FSINFO_FEAT__NR; i++)
+		if (f->features[i / 8] & (1 << (i % 8)))
+			printf("\t- %s\n", fsinfo_feature_names[i]);
+}
+
 static void print_time(struct fsinfo_timestamp_one *t, char stamp)
 {
 	printf("\t%ctime       : gran=%gs range=%llx-%llx\n",
@@ -271,6 +339,7 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_VSTRUCT	(FSINFO_ATTR_IDS,		fsinfo_generic_ids),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_LIMITS,		fsinfo_generic_limits),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		fsinfo_generic_supports),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		fsinfo_generic_features),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_TIMESTAMP_INFO,	fsinfo_generic_timestamp_info),
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),


