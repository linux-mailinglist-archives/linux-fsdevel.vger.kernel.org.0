Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 561C0162B89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgBRRH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:07:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27088 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726640AbgBRRHz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582045674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wUKdUlz9U8UTwNyokp0ScO/lvYBNbQyisRDz0h80to=;
        b=dWtz+4cAyZqpg1Go++QUxeXq3UPSl1te41rI25+R6jWDxEfVI/DVWbb4kv55STJ+PuVexp
        lEt/UWQTeTZU5Jzu0xHmcz1b5jjibDhVYmnEQWyVWjfvr3p+N/1UvfGxOMhmhliMLB58pT
        Lf0AuWp+a5zJS3GOIO9O+hYlpQRGZmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-HqrXiQhMO3So81JYbc6GfA-1; Tue, 18 Feb 2020 12:07:30 -0500
X-MC-Unique: HqrXiQhMO3So81JYbc6GfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F5B4100F63D;
        Tue, 18 Feb 2020 17:07:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B58159183B;
        Tue, 18 Feb 2020 17:07:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 19/19] nfs: Add example filesystem information [ver #16]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 17:07:26 +0000
Message-ID: <158204564600.3299825.1942403408111770890.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the ability to list NFS server addresses and hostname, timestamp
information and capabilities as an example.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-nfs@vger.kernel.org
---

 fs/nfs/Makefile             |    1 +
 fs/nfs/internal.h           |    8 ++++++++
 fs/nfs/nfs4super.c          |    1 +
 fs/nfs/super.c              |    1 +
 include/uapi/linux/fsinfo.h |   29 +++++++++++++++++++++++++++++
 samples/vfs/test-fsinfo.c   |   40 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+)

diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 2433c3e03cfa..20fbc9596833 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -13,6 +13,7 @@ nfs-y 			:= client.o dir.o file.o getroot.o inode.o super.o \
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o
 nfs-$(CONFIG_SYSCTL)	+= sysctl.o
 nfs-$(CONFIG_NFS_FSCACHE) += fscache.o fscache-index.o
+nfs-$(CONFIG_FSINFO)	+= fsinfo.o
 
 obj-$(CONFIG_NFS_V2) += nfsv2.o
 nfsv2-y := nfs2super.o proc.o nfs2xdr.o
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index f80c47d5ff27..4ddf0da25740 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -10,6 +10,7 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_page.h>
 #include <linux/wait_bit.h>
+#include <linux/fsinfo.h>
 
 #define NFS_SB_MASK (SB_RDONLY|SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
 
@@ -247,6 +248,13 @@ extern const struct svc_version nfs4_callback_version4;
 /* fs_context.c */
 extern struct file_system_type nfs_fs_type;
 
+/* fsinfo.c */
+#ifdef CONFIG_FSINFO
+extern const struct fsinfo_attribute nfs_fsinfo_attributes[];
+#else
+#define nfs_fsinfo_attributes NULL
+#endif
+
 /* pagelist.c */
 extern int __init nfs_init_nfspagecache(void);
 extern void nfs_destroy_nfspagecache(void);
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 1475f932d7da..1b75144e24f4 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -26,6 +26,7 @@ static const struct super_operations nfs4_sops = {
 	.write_inode	= nfs4_write_inode,
 	.drop_inode	= nfs_drop_inode,
 	.statfs		= nfs_statfs,
+	.fsinfo_attributes = nfs_fsinfo_attributes,
 	.evict_inode	= nfs4_evict_inode,
 	.umount_begin	= nfs_umount_begin,
 	.show_options	= nfs_show_options,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index dada09b391c6..fbc2cf5f803b 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -76,6 +76,7 @@ const struct super_operations nfs_sops = {
 	.write_inode	= nfs_write_inode,
 	.drop_inode	= nfs_drop_inode,
 	.statfs		= nfs_statfs,
+	.fsinfo_attributes = nfs_fsinfo_attributes,
 	.evict_inode	= nfs_evict_inode,
 	.umount_begin	= nfs_umount_begin,
 	.show_options	= nfs_show_options,
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index da9a6f48ec5b..7c97d65333ec 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -40,6 +40,11 @@
 
 #define FSINFO_ATTR_EXT4_TIMESTAMPS	0x400	/* Ext4 superblock timestamps */
 
+#define FSINFO_ATTR_NFS_INFO		0x500	/* Information about an NFS mount */
+#define FSINFO_ATTR_NFS_SERVER_NAME	0x501	/* Name of the server (string) */
+#define FSINFO_ATTR_NFS_SERVER_ADDRESSES 0x502	/* List of addresses of the server */
+#define FSINFO_ATTR_NFS_GSSAPI_NAME	0x503	/* GSSAPI acceptor name */
+
 /*
  * Optional fsinfo() parameter structure.
  *
@@ -339,4 +344,28 @@ struct fsinfo_ext4_timestamps {
 
 #define FSINFO_ATTR_EXT4_TIMESTAMPS__STRUCT struct fsinfo_ext4_timestamps
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_NFS_INFO).
+ *
+ * Get information about an NFS mount.
+ */
+struct fsinfo_nfs_info {
+	__u32		version;
+	__u32		minor_version;
+	__u32		transport_proto;
+};
+
+#define FSINFO_ATTR_NFS_INFO__STRUCT struct fsinfo_nfs_info
+
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_NFS_SERVER_ADDRESSES).
+ *
+ * Get the addresses of the server for an NFS mount.
+ */
+struct fsinfo_nfs_server_address {
+	struct __kernel_sockaddr_storage address;
+};
+
+#define FSINFO_ATTR_NFS_SERVER_ADDRESSES__STRUCT struct fsinfo_nfs_server_address
+
 #endif /* _UAPI_LINUX_FSINFO_H */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 53251ee98d1c..68652db686e8 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -393,6 +393,40 @@ static void dump_ext4_fsinfo_timestamps(void *reply, unsigned int size)
 	printf("\tlast-err: %s\n", dump_ext4_time(buffer, r->last_error_time));
 }
 
+static void dump_nfs_fsinfo_info(void *reply, unsigned int size)
+{
+	struct fsinfo_nfs_info *r = reply;
+
+	printf("ver=%u.%u proto=%u\n", r->version, r->minor_version, r->transport_proto);
+}
+
+static void dump_nfs_fsinfo_server_addresses(void *reply, unsigned int size)
+{
+	struct fsinfo_nfs_server_address *r = reply;
+	struct sockaddr_storage *ss = (struct sockaddr_storage *)&r->address;
+	struct sockaddr_in6 *sin6;
+	struct sockaddr_in *sin;
+	char buf[1024];
+
+	switch (ss->ss_family) {
+	case AF_INET:
+		sin = (struct sockaddr_in *)ss;
+		if (!inet_ntop(AF_INET, &sin->sin_addr, buf, sizeof(buf)))
+			break;
+		printf("%5u %s\n", ntohs(sin->sin_port), buf);
+		return;
+	case AF_INET6:
+		sin6 = (struct sockaddr_in6 *)ss;
+		if (!inet_ntop(AF_INET6, &sin6->sin6_addr, buf, sizeof(buf)))
+			break;
+		printf("%5u %s\n", ntohs(sin6->sin6_port), buf);
+		return;
+	default:
+		printf("family=%u\n", ss->ss_family);
+		return;
+	}
+}
+
 static void dump_string(void *reply, unsigned int size)
 {
 	char *s = reply, *p;
@@ -424,6 +458,8 @@ static void dump_string(void *reply, unsigned int size)
 #define dump_fsinfo_generic_mount_point		dump_string
 #define dump_afs_cell_name			dump_string
 #define dump_afs_server_name			dump_string
+#define dump_nfs_fsinfo_server_name		dump_string
+#define dump_nfs_fsinfo_gssapi_name		dump_string
 
 /*
  *
@@ -468,6 +504,10 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	afs_server_name),
 	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_server_address),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_EXT4_TIMESTAMPS,	ext4_fsinfo_timestamps),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_NFS_INFO,		nfs_fsinfo_info),
+	FSINFO_STRING	(FSINFO_ATTR_NFS_SERVER_NAME,	nfs_fsinfo_server_name),
+	FSINFO_LIST	(FSINFO_ATTR_NFS_SERVER_ADDRESSES, nfs_fsinfo_server_addresses),
+	FSINFO_STRING	(FSINFO_ATTR_NFS_GSSAPI_NAME,	nfs_fsinfo_gssapi_name),
 	{}
 };
 


