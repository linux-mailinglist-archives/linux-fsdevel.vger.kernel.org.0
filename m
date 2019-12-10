Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9CE11882F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 13:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfLJMbx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 07:31:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23545 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727574AbfLJMb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yOYlE8pzfAV8zc/Kdn3Ix9s/TDGFT/cwzKV9zRTV5bs=;
        b=aVvsLHUDcTFL6NzSMToD2Exf9pz9q0VkVklNfOkuSihWRrXJnXs/fbME+/7vboDK94XXT1
        4zb6St2H7d4RBTNurrinhNEb1gGe5GY3ZjYcb7DtXjqT9eLcd3uGOJBS53Tt0q+2WdnX+y
        0r5ws3CG88xvfZZhedEgeAmVRx/0ubU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-6Xss-6DGPyuddwbOJq-dRw-1; Tue, 10 Dec 2019 07:31:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C153B100551D;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59B356E41F;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id DB6E720C2B; Tue, 10 Dec 2019 07:31:15 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 16/27] NFS: Move mount parameterisation bits into their own file
Date:   Tue, 10 Dec 2019 07:31:04 -0500
Message-Id: <20191210123115.1655-17-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 6Xss-6DGPyuddwbOJq-dRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Split various bits relating to mount parameterisation out from
fs/nfs/super.c into their own file to form the basis of filesystem context
handling for NFS.

No other changes are made to the code beyond removing 'static' qualifiers.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/Makefile     |    2 +-
 fs/nfs/fs_context.c | 1414 +++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/internal.h   |   30 +
 fs/nfs/super.c      | 1411 ------------------------------------------
 4 files changed, 1445 insertions(+), 1412 deletions(-)
 create mode 100644 fs/nfs/fs_context.c

diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 34cdeaecccf6..2433c3e03cfa 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -9,7 +9,7 @@ CFLAGS_nfstrace.o +=3D -I$(src)
 nfs-y =09=09=09:=3D client.o dir.o file.o getroot.o inode.o super.o \
 =09=09=09   io.o direct.o pagelist.o read.o symlink.o unlink.o \
 =09=09=09   write.o namespace.o mount_clnt.o nfstrace.o \
-=09=09=09   export.o sysfs.o
+=09=09=09   export.o sysfs.o fs_context.o
 nfs-$(CONFIG_ROOT_NFS)=09+=3D nfsroot.o
 nfs-$(CONFIG_SYSCTL)=09+=3D sysctl.o
 nfs-$(CONFIG_NFS_FSCACHE) +=3D fscache.o fscache-index.o
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
new file mode 100644
index 000000000000..c8f99a3c7264
--- /dev/null
+++ b/fs/nfs/fs_context.c
@@ -0,0 +1,1414 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * linux/fs/nfs/fs_context.c
+ *
+ * Copyright (C) 1992 Rick Sladkey
+ *
+ * NFS mount handling.
+ *
+ * Split from fs/nfs/super.c by David Howells <dhowells@redhat.com>
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/parser.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_mount.h>
+#include <linux/nfs4_mount.h>
+#include "nfs.h"
+#include "internal.h"
+
+#define NFSDBG_FACILITY=09=09NFSDBG_MOUNT
+
+#if IS_ENABLED(CONFIG_NFS_V3)
+#define NFS_DEFAULT_VERSION 3
+#else
+#define NFS_DEFAULT_VERSION 2
+#endif
+
+#define NFS_MAX_CONNECTIONS 16
+
+enum {
+=09/* Mount options that take no arguments */
+=09Opt_soft, Opt_softerr, Opt_hard,
+=09Opt_posix, Opt_noposix,
+=09Opt_cto, Opt_nocto,
+=09Opt_ac, Opt_noac,
+=09Opt_lock, Opt_nolock,
+=09Opt_udp, Opt_tcp, Opt_rdma,
+=09Opt_acl, Opt_noacl,
+=09Opt_rdirplus, Opt_nordirplus,
+=09Opt_sharecache, Opt_nosharecache,
+=09Opt_resvport, Opt_noresvport,
+=09Opt_fscache, Opt_nofscache,
+=09Opt_migration, Opt_nomigration,
+
+=09/* Mount options that take integer arguments */
+=09Opt_port,
+=09Opt_rsize, Opt_wsize, Opt_bsize,
+=09Opt_timeo, Opt_retrans,
+=09Opt_acregmin, Opt_acregmax,
+=09Opt_acdirmin, Opt_acdirmax,
+=09Opt_actimeo,
+=09Opt_namelen,
+=09Opt_mountport,
+=09Opt_mountvers,
+=09Opt_minorversion,
+
+=09/* Mount options that take string arguments */
+=09Opt_nfsvers,
+=09Opt_sec, Opt_proto, Opt_mountproto, Opt_mounthost,
+=09Opt_addr, Opt_mountaddr, Opt_clientaddr,
+=09Opt_nconnect,
+=09Opt_lookupcache,
+=09Opt_fscache_uniq,
+=09Opt_local_lock,
+
+=09/* Special mount options */
+=09Opt_userspace, Opt_deprecated, Opt_sloppy,
+
+=09Opt_err
+};
+
+static const match_table_t nfs_mount_option_tokens =3D {
+=09{ Opt_userspace, "bg" },
+=09{ Opt_userspace, "fg" },
+=09{ Opt_userspace, "retry=3D%s" },
+
+=09{ Opt_sloppy, "sloppy" },
+
+=09{ Opt_soft, "soft" },
+=09{ Opt_softerr, "softerr" },
+=09{ Opt_hard, "hard" },
+=09{ Opt_deprecated, "intr" },
+=09{ Opt_deprecated, "nointr" },
+=09{ Opt_posix, "posix" },
+=09{ Opt_noposix, "noposix" },
+=09{ Opt_cto, "cto" },
+=09{ Opt_nocto, "nocto" },
+=09{ Opt_ac, "ac" },
+=09{ Opt_noac, "noac" },
+=09{ Opt_lock, "lock" },
+=09{ Opt_nolock, "nolock" },
+=09{ Opt_udp, "udp" },
+=09{ Opt_tcp, "tcp" },
+=09{ Opt_rdma, "rdma" },
+=09{ Opt_acl, "acl" },
+=09{ Opt_noacl, "noacl" },
+=09{ Opt_rdirplus, "rdirplus" },
+=09{ Opt_nordirplus, "nordirplus" },
+=09{ Opt_sharecache, "sharecache" },
+=09{ Opt_nosharecache, "nosharecache" },
+=09{ Opt_resvport, "resvport" },
+=09{ Opt_noresvport, "noresvport" },
+=09{ Opt_fscache, "fsc" },
+=09{ Opt_nofscache, "nofsc" },
+=09{ Opt_migration, "migration" },
+=09{ Opt_nomigration, "nomigration" },
+
+=09{ Opt_port, "port=3D%s" },
+=09{ Opt_rsize, "rsize=3D%s" },
+=09{ Opt_wsize, "wsize=3D%s" },
+=09{ Opt_bsize, "bsize=3D%s" },
+=09{ Opt_timeo, "timeo=3D%s" },
+=09{ Opt_retrans, "retrans=3D%s" },
+=09{ Opt_acregmin, "acregmin=3D%s" },
+=09{ Opt_acregmax, "acregmax=3D%s" },
+=09{ Opt_acdirmin, "acdirmin=3D%s" },
+=09{ Opt_acdirmax, "acdirmax=3D%s" },
+=09{ Opt_actimeo, "actimeo=3D%s" },
+=09{ Opt_namelen, "namlen=3D%s" },
+=09{ Opt_mountport, "mountport=3D%s" },
+=09{ Opt_mountvers, "mountvers=3D%s" },
+=09{ Opt_minorversion, "minorversion=3D%s" },
+
+=09{ Opt_nfsvers, "nfsvers=3D%s" },
+=09{ Opt_nfsvers, "vers=3D%s" },
+
+=09{ Opt_sec, "sec=3D%s" },
+=09{ Opt_proto, "proto=3D%s" },
+=09{ Opt_mountproto, "mountproto=3D%s" },
+=09{ Opt_addr, "addr=3D%s" },
+=09{ Opt_clientaddr, "clientaddr=3D%s" },
+=09{ Opt_mounthost, "mounthost=3D%s" },
+=09{ Opt_mountaddr, "mountaddr=3D%s" },
+
+=09{ Opt_nconnect, "nconnect=3D%s" },
+
+=09{ Opt_lookupcache, "lookupcache=3D%s" },
+=09{ Opt_fscache_uniq, "fsc=3D%s" },
+=09{ Opt_local_lock, "local_lock=3D%s" },
+
+=09/* The following needs to be listed after all other options */
+=09{ Opt_nfsvers, "v%s" },
+
+=09{ Opt_err, NULL }
+};
+
+enum {
+=09Opt_xprt_udp, Opt_xprt_udp6, Opt_xprt_tcp, Opt_xprt_tcp6, Opt_xprt_rdma=
,
+=09Opt_xprt_rdma6,
+
+=09Opt_xprt_err
+};
+
+static const match_table_t nfs_xprt_protocol_tokens =3D {
+=09{ Opt_xprt_udp, "udp" },
+=09{ Opt_xprt_udp6, "udp6" },
+=09{ Opt_xprt_tcp, "tcp" },
+=09{ Opt_xprt_tcp6, "tcp6" },
+=09{ Opt_xprt_rdma, "rdma" },
+=09{ Opt_xprt_rdma6, "rdma6" },
+
+=09{ Opt_xprt_err, NULL }
+};
+
+enum {
+=09Opt_sec_none, Opt_sec_sys,
+=09Opt_sec_krb5, Opt_sec_krb5i, Opt_sec_krb5p,
+=09Opt_sec_lkey, Opt_sec_lkeyi, Opt_sec_lkeyp,
+=09Opt_sec_spkm, Opt_sec_spkmi, Opt_sec_spkmp,
+
+=09Opt_sec_err
+};
+
+static const match_table_t nfs_secflavor_tokens =3D {
+=09{ Opt_sec_none, "none" },
+=09{ Opt_sec_none, "null" },
+=09{ Opt_sec_sys, "sys" },
+
+=09{ Opt_sec_krb5, "krb5" },
+=09{ Opt_sec_krb5i, "krb5i" },
+=09{ Opt_sec_krb5p, "krb5p" },
+
+=09{ Opt_sec_lkey, "lkey" },
+=09{ Opt_sec_lkeyi, "lkeyi" },
+=09{ Opt_sec_lkeyp, "lkeyp" },
+
+=09{ Opt_sec_spkm, "spkm3" },
+=09{ Opt_sec_spkmi, "spkm3i" },
+=09{ Opt_sec_spkmp, "spkm3p" },
+
+=09{ Opt_sec_err, NULL }
+};
+
+enum {
+=09Opt_lookupcache_all, Opt_lookupcache_positive,
+=09Opt_lookupcache_none,
+
+=09Opt_lookupcache_err
+};
+
+static match_table_t nfs_lookupcache_tokens =3D {
+=09{ Opt_lookupcache_all, "all" },
+=09{ Opt_lookupcache_positive, "pos" },
+=09{ Opt_lookupcache_positive, "positive" },
+=09{ Opt_lookupcache_none, "none" },
+
+=09{ Opt_lookupcache_err, NULL }
+};
+
+enum {
+=09Opt_local_lock_all, Opt_local_lock_flock, Opt_local_lock_posix,
+=09Opt_local_lock_none,
+
+=09Opt_local_lock_err
+};
+
+static match_table_t nfs_local_lock_tokens =3D {
+=09{ Opt_local_lock_all, "all" },
+=09{ Opt_local_lock_flock, "flock" },
+=09{ Opt_local_lock_posix, "posix" },
+=09{ Opt_local_lock_none, "none" },
+
+=09{ Opt_local_lock_err, NULL }
+};
+
+enum {
+=09Opt_vers_2, Opt_vers_3, Opt_vers_4, Opt_vers_4_0,
+=09Opt_vers_4_1, Opt_vers_4_2,
+
+=09Opt_vers_err
+};
+
+static match_table_t nfs_vers_tokens =3D {
+=09{ Opt_vers_2, "2" },
+=09{ Opt_vers_3, "3" },
+=09{ Opt_vers_4, "4" },
+=09{ Opt_vers_4_0, "4.0" },
+=09{ Opt_vers_4_1, "4.1" },
+=09{ Opt_vers_4_2, "4.2" },
+
+=09{ Opt_vers_err, NULL }
+};
+
+struct nfs_parsed_mount_data *nfs_alloc_parsed_mount_data(void)
+{
+=09struct nfs_parsed_mount_data *data;
+
+=09data =3D kzalloc(sizeof(*data), GFP_KERNEL);
+=09if (data) {
+=09=09data->timeo=09=09=3D NFS_UNSPEC_TIMEO;
+=09=09data->retrans=09=09=3D NFS_UNSPEC_RETRANS;
+=09=09data->acregmin=09=09=3D NFS_DEF_ACREGMIN;
+=09=09data->acregmax=09=09=3D NFS_DEF_ACREGMAX;
+=09=09data->acdirmin=09=09=3D NFS_DEF_ACDIRMIN;
+=09=09data->acdirmax=09=09=3D NFS_DEF_ACDIRMAX;
+=09=09data->mount_server.port=09=3D NFS_UNSPEC_PORT;
+=09=09data->nfs_server.port=09=3D NFS_UNSPEC_PORT;
+=09=09data->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09=09data->selected_flavor=09=3D RPC_AUTH_MAXFLAVOR;
+=09=09data->minorversion=09=3D 0;
+=09=09data->need_mount=09=3D true;
+=09=09data->net=09=09=3D current->nsproxy->net_ns;
+=09=09data->lsm_opts=09=09=3D NULL;
+=09}
+=09return data;
+}
+
+void nfs_free_parsed_mount_data(struct nfs_parsed_mount_data *data)
+{
+=09if (data) {
+=09=09kfree(data->client_address);
+=09=09kfree(data->mount_server.hostname);
+=09=09kfree(data->nfs_server.export_path);
+=09=09kfree(data->nfs_server.hostname);
+=09=09kfree(data->fscache_uniq);
+=09=09security_free_mnt_opts(&data->lsm_opts);
+=09=09kfree(data);
+=09}
+}
+
+/*
+ * Sanity-check a server address provided by the mount command.
+ *
+ * Address family must be initialized, and address must not be
+ * the ANY address for that family.
+ */
+static int nfs_verify_server_address(struct sockaddr *addr)
+{
+=09switch (addr->sa_family) {
+=09case AF_INET: {
+=09=09struct sockaddr_in *sa =3D (struct sockaddr_in *)addr;
+=09=09return sa->sin_addr.s_addr !=3D htonl(INADDR_ANY);
+=09}
+=09case AF_INET6: {
+=09=09struct in6_addr *sa =3D &((struct sockaddr_in6 *)addr)->sin6_addr;
+=09=09return !ipv6_addr_any(sa);
+=09}
+=09}
+
+=09dfprintk(MOUNT, "NFS: Invalid IP address specified\n");
+=09return 0;
+}
+
+/*
+ * Sanity check the NFS transport protocol.
+ *
+ */
+static void nfs_validate_transport_protocol(struct nfs_parsed_mount_data *=
mnt)
+{
+=09switch (mnt->nfs_server.protocol) {
+=09case XPRT_TRANSPORT_UDP:
+=09case XPRT_TRANSPORT_TCP:
+=09case XPRT_TRANSPORT_RDMA:
+=09=09break;
+=09default:
+=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09}
+}
+
+/*
+ * For text based NFSv2/v3 mounts, the mount protocol transport default
+ * settings should depend upon the specified NFS transport.
+ */
+static void nfs_set_mount_transport_protocol(struct nfs_parsed_mount_data =
*mnt)
+{
+=09nfs_validate_transport_protocol(mnt);
+
+=09if (mnt->mount_server.protocol =3D=3D XPRT_TRANSPORT_UDP ||
+=09    mnt->mount_server.protocol =3D=3D XPRT_TRANSPORT_TCP)
+=09=09=09return;
+=09switch (mnt->nfs_server.protocol) {
+=09case XPRT_TRANSPORT_UDP:
+=09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
+=09=09break;
+=09case XPRT_TRANSPORT_TCP:
+=09case XPRT_TRANSPORT_RDMA:
+=09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09}
+}
+
+/*
+ * Add 'flavor' to 'auth_info' if not already present.
+ * Returns true if 'flavor' ends up in the list, false otherwise
+ */
+static bool nfs_auth_info_add(struct nfs_auth_info *auth_info,
+=09=09=09      rpc_authflavor_t flavor)
+{
+=09unsigned int i;
+=09unsigned int max_flavor_len =3D ARRAY_SIZE(auth_info->flavors);
+
+=09/* make sure this flavor isn't already in the list */
+=09for (i =3D 0; i < auth_info->flavor_len; i++) {
+=09=09if (flavor =3D=3D auth_info->flavors[i])
+=09=09=09return true;
+=09}
+
+=09if (auth_info->flavor_len + 1 >=3D max_flavor_len) {
+=09=09dfprintk(MOUNT, "NFS: too many sec=3D flavors\n");
+=09=09return false;
+=09}
+
+=09auth_info->flavors[auth_info->flavor_len++] =3D flavor;
+=09return true;
+}
+
+/*
+ * Parse the value of the 'sec=3D' option.
+ */
+static int nfs_parse_security_flavors(char *value,
+=09=09=09=09      struct nfs_parsed_mount_data *mnt)
+{
+=09substring_t args[MAX_OPT_ARGS];
+=09rpc_authflavor_t pseudoflavor;
+=09char *p;
+
+=09dfprintk(MOUNT, "NFS: parsing sec=3D%s option\n", value);
+
+=09while ((p =3D strsep(&value, ":")) !=3D NULL) {
+=09=09switch (match_token(p, nfs_secflavor_tokens, args)) {
+=09=09case Opt_sec_none:
+=09=09=09pseudoflavor =3D RPC_AUTH_NULL;
+=09=09=09break;
+=09=09case Opt_sec_sys:
+=09=09=09pseudoflavor =3D RPC_AUTH_UNIX;
+=09=09=09break;
+=09=09case Opt_sec_krb5:
+=09=09=09pseudoflavor =3D RPC_AUTH_GSS_KRB5;
+=09=09=09break;
+=09=09case Opt_sec_krb5i:
+=09=09=09pseudoflavor =3D RPC_AUTH_GSS_KRB5I;
+=09=09=09break;
+=09=09case Opt_sec_krb5p:
+=09=09=09pseudoflavor =3D RPC_AUTH_GSS_KRB5P;
+=09=09=09break;
+=09=09case Opt_sec_lkey:
+=09=09=09pseudoflavor =3D RPC_AUTH_GSS_LKEY;
+=09=09=09break;
+=09=09case Opt_sec_lkeyi:
+=09=09=09pseudoflavor =3D RPC_AUTH_GSS_LKEYI;
+=09=09=09break;
+=09=09case Opt_sec_lkeyp:
+=09=09=09pseudoflavor =3D RPC_AUTH_GSS_LKEYP;
+=09=09=09break;
+=09=09case Opt_sec_spkm:
+=09=09=09pseudoflavor =3D RPC_AUTH_GSS_SPKM;
+=09=09=09break;
+=09=09case Opt_sec_spkmi:
+=09=09=09pseudoflavor =3D RPC_AUTH_GSS_SPKMI;
+=09=09=09break;
+=09=09case Opt_sec_spkmp:
+=09=09=09pseudoflavor =3D RPC_AUTH_GSS_SPKMP;
+=09=09=09break;
+=09=09default:
+=09=09=09dfprintk(MOUNT,
+=09=09=09=09 "NFS: sec=3D option '%s' not recognized\n", p);
+=09=09=09return 0;
+=09=09}
+
+=09=09if (!nfs_auth_info_add(&mnt->auth_info, pseudoflavor))
+=09=09=09return 0;
+=09}
+
+=09return 1;
+}
+
+static int nfs_parse_version_string(char *string,
+=09=09struct nfs_parsed_mount_data *mnt,
+=09=09substring_t *args)
+{
+=09mnt->flags &=3D ~NFS_MOUNT_VER3;
+=09switch (match_token(string, nfs_vers_tokens, args)) {
+=09case Opt_vers_2:
+=09=09mnt->version =3D 2;
+=09=09break;
+=09case Opt_vers_3:
+=09=09mnt->flags |=3D NFS_MOUNT_VER3;
+=09=09mnt->version =3D 3;
+=09=09break;
+=09case Opt_vers_4:
+=09=09/* Backward compatibility option. In future,
+=09=09 * the mount program should always supply
+=09=09 * a NFSv4 minor version number.
+=09=09 */
+=09=09mnt->version =3D 4;
+=09=09break;
+=09case Opt_vers_4_0:
+=09=09mnt->version =3D 4;
+=09=09mnt->minorversion =3D 0;
+=09=09break;
+=09case Opt_vers_4_1:
+=09=09mnt->version =3D 4;
+=09=09mnt->minorversion =3D 1;
+=09=09break;
+=09case Opt_vers_4_2:
+=09=09mnt->version =3D 4;
+=09=09mnt->minorversion =3D 2;
+=09=09break;
+=09default:
+=09=09return 0;
+=09}
+=09return 1;
+}
+
+static int nfs_get_option_str(substring_t args[], char **option)
+{
+=09kfree(*option);
+=09*option =3D match_strdup(args);
+=09return !*option;
+}
+
+static int nfs_get_option_ul(substring_t args[], unsigned long *option)
+{
+=09int rc;
+=09char *string;
+
+=09string =3D match_strdup(args);
+=09if (string =3D=3D NULL)
+=09=09return -ENOMEM;
+=09rc =3D kstrtoul(string, 10, option);
+=09kfree(string);
+
+=09return rc;
+}
+
+static int nfs_get_option_ul_bound(substring_t args[], unsigned long *opti=
on,
+=09=09unsigned long l_bound, unsigned long u_bound)
+{
+=09int ret;
+
+=09ret =3D nfs_get_option_ul(args, option);
+=09if (ret !=3D 0)
+=09=09return ret;
+=09if (*option < l_bound || *option > u_bound)
+=09=09return -ERANGE;
+=09return 0;
+}
+
+/*
+ * Error-check and convert a string of mount options from user space into
+ * a data structure.  The whole mount string is processed; bad options are
+ * skipped as they are encountered.  If there were no errors, return 1;
+ * otherwise return 0 (zero).
+ */
+int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
+{
+=09char *p, *string;
+=09int rc, sloppy =3D 0, invalid_option =3D 0;
+=09unsigned short protofamily =3D AF_UNSPEC;
+=09unsigned short mountfamily =3D AF_UNSPEC;
+
+=09if (!raw) {
+=09=09dfprintk(MOUNT, "NFS: mount options string was NULL.\n");
+=09=09return 1;
+=09}
+=09dfprintk(MOUNT, "NFS: nfs mount opts=3D'%s'\n", raw);
+
+=09rc =3D security_sb_eat_lsm_opts(raw, &mnt->lsm_opts);
+=09if (rc)
+=09=09goto out_security_failure;
+
+=09while ((p =3D strsep(&raw, ",")) !=3D NULL) {
+=09=09substring_t args[MAX_OPT_ARGS];
+=09=09unsigned long option;
+=09=09int token;
+
+=09=09if (!*p)
+=09=09=09continue;
+
+=09=09dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", p);
+
+=09=09token =3D match_token(p, nfs_mount_option_tokens, args);
+=09=09switch (token) {
+
+=09=09/*
+=09=09 * boolean options:  foo/nofoo
+=09=09 */
+=09=09case Opt_soft:
+=09=09=09mnt->flags |=3D NFS_MOUNT_SOFT;
+=09=09=09mnt->flags &=3D ~NFS_MOUNT_SOFTERR;
+=09=09=09break;
+=09=09case Opt_softerr:
+=09=09=09mnt->flags |=3D NFS_MOUNT_SOFTERR;
+=09=09=09mnt->flags &=3D ~NFS_MOUNT_SOFT;
+=09=09=09break;
+=09=09case Opt_hard:
+=09=09=09mnt->flags &=3D ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
+=09=09=09break;
+=09=09case Opt_posix:
+=09=09=09mnt->flags |=3D NFS_MOUNT_POSIX;
+=09=09=09break;
+=09=09case Opt_noposix:
+=09=09=09mnt->flags &=3D ~NFS_MOUNT_POSIX;
+=09=09=09break;
+=09=09case Opt_cto:
+=09=09=09mnt->flags &=3D ~NFS_MOUNT_NOCTO;
+=09=09=09break;
+=09=09case Opt_nocto:
+=09=09=09mnt->flags |=3D NFS_MOUNT_NOCTO;
+=09=09=09break;
+=09=09case Opt_ac:
+=09=09=09mnt->flags &=3D ~NFS_MOUNT_NOAC;
+=09=09=09break;
+=09=09case Opt_noac:
+=09=09=09mnt->flags |=3D NFS_MOUNT_NOAC;
+=09=09=09break;
+=09=09case Opt_lock:
+=09=09=09mnt->flags &=3D ~NFS_MOUNT_NONLM;
+=09=09=09mnt->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
+=09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
+=09=09=09break;
+=09=09case Opt_nolock:
+=09=09=09mnt->flags |=3D NFS_MOUNT_NONLM;
+=09=09=09mnt->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
+=09=09=09=09       NFS_MOUNT_LOCAL_FCNTL);
+=09=09=09break;
+=09=09case Opt_udp:
+=09=09=09mnt->flags &=3D ~NFS_MOUNT_TCP;
+=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
+=09=09=09break;
+=09=09case Opt_tcp:
+=09=09=09mnt->flags |=3D NFS_MOUNT_TCP;
+=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09=09=09break;
+=09=09case Opt_rdma:
+=09=09=09mnt->flags |=3D NFS_MOUNT_TCP; /* for side protocols */
+=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
+=09=09=09xprt_load_transport(p);
+=09=09=09break;
+=09=09case Opt_acl:
+=09=09=09mnt->flags &=3D ~NFS_MOUNT_NOACL;
+=09=09=09break;
+=09=09case Opt_noacl:
+=09=09=09mnt->flags |=3D NFS_MOUNT_NOACL;
+=09=09=09break;
+=09=09case Opt_rdirplus:
+=09=09=09mnt->flags &=3D ~NFS_MOUNT_NORDIRPLUS;
+=09=09=09break;
+=09=09case Opt_nordirplus:
+=09=09=09mnt->flags |=3D NFS_MOUNT_NORDIRPLUS;
+=09=09=09break;
+=09=09case Opt_sharecache:
+=09=09=09mnt->flags &=3D ~NFS_MOUNT_UNSHARED;
+=09=09=09break;
+=09=09case Opt_nosharecache:
+=09=09=09mnt->flags |=3D NFS_MOUNT_UNSHARED;
+=09=09=09break;
+=09=09case Opt_resvport:
+=09=09=09mnt->flags &=3D ~NFS_MOUNT_NORESVPORT;
+=09=09=09break;
+=09=09case Opt_noresvport:
+=09=09=09mnt->flags |=3D NFS_MOUNT_NORESVPORT;
+=09=09=09break;
+=09=09case Opt_fscache:
+=09=09=09mnt->options |=3D NFS_OPTION_FSCACHE;
+=09=09=09kfree(mnt->fscache_uniq);
+=09=09=09mnt->fscache_uniq =3D NULL;
+=09=09=09break;
+=09=09case Opt_nofscache:
+=09=09=09mnt->options &=3D ~NFS_OPTION_FSCACHE;
+=09=09=09kfree(mnt->fscache_uniq);
+=09=09=09mnt->fscache_uniq =3D NULL;
+=09=09=09break;
+=09=09case Opt_migration:
+=09=09=09mnt->options |=3D NFS_OPTION_MIGRATION;
+=09=09=09break;
+=09=09case Opt_nomigration:
+=09=09=09mnt->options &=3D ~NFS_OPTION_MIGRATION;
+=09=09=09break;
+
+=09=09/*
+=09=09 * options that take numeric values
+=09=09 */
+=09=09case Opt_port:
+=09=09=09if (nfs_get_option_ul(args, &option) ||
+=09=09=09    option > USHRT_MAX)
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->nfs_server.port =3D option;
+=09=09=09break;
+=09=09case Opt_rsize:
+=09=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->rsize =3D option;
+=09=09=09break;
+=09=09case Opt_wsize:
+=09=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->wsize =3D option;
+=09=09=09break;
+=09=09case Opt_bsize:
+=09=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->bsize =3D option;
+=09=09=09break;
+=09=09case Opt_timeo:
+=09=09=09if (nfs_get_option_ul_bound(args, &option, 1, INT_MAX))
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->timeo =3D option;
+=09=09=09break;
+=09=09case Opt_retrans:
+=09=09=09if (nfs_get_option_ul_bound(args, &option, 0, INT_MAX))
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->retrans =3D option;
+=09=09=09break;
+=09=09case Opt_acregmin:
+=09=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->acregmin =3D option;
+=09=09=09break;
+=09=09case Opt_acregmax:
+=09=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->acregmax =3D option;
+=09=09=09break;
+=09=09case Opt_acdirmin:
+=09=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->acdirmin =3D option;
+=09=09=09break;
+=09=09case Opt_acdirmax:
+=09=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->acdirmax =3D option;
+=09=09=09break;
+=09=09case Opt_actimeo:
+=09=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->acregmin =3D mnt->acregmax =3D
+=09=09=09mnt->acdirmin =3D mnt->acdirmax =3D option;
+=09=09=09break;
+=09=09case Opt_namelen:
+=09=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->namlen =3D option;
+=09=09=09break;
+=09=09case Opt_mountport:
+=09=09=09if (nfs_get_option_ul(args, &option) ||
+=09=09=09    option > USHRT_MAX)
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->mount_server.port =3D option;
+=09=09=09break;
+=09=09case Opt_mountvers:
+=09=09=09if (nfs_get_option_ul(args, &option) ||
+=09=09=09    option < NFS_MNT_VERSION ||
+=09=09=09    option > NFS_MNT3_VERSION)
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->mount_server.version =3D option;
+=09=09=09break;
+=09=09case Opt_minorversion:
+=09=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09=09goto out_invalid_value;
+=09=09=09if (option > NFS4_MAX_MINOR_VERSION)
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->minorversion =3D option;
+=09=09=09break;
+
+=09=09/*
+=09=09 * options that take text values
+=09=09 */
+=09=09case Opt_nfsvers:
+=09=09=09string =3D match_strdup(args);
+=09=09=09if (string =3D=3D NULL)
+=09=09=09=09goto out_nomem;
+=09=09=09rc =3D nfs_parse_version_string(string, mnt, args);
+=09=09=09kfree(string);
+=09=09=09if (!rc)
+=09=09=09=09goto out_invalid_value;
+=09=09=09break;
+=09=09case Opt_sec:
+=09=09=09string =3D match_strdup(args);
+=09=09=09if (string =3D=3D NULL)
+=09=09=09=09goto out_nomem;
+=09=09=09rc =3D nfs_parse_security_flavors(string, mnt);
+=09=09=09kfree(string);
+=09=09=09if (!rc) {
+=09=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
+=09=09=09=09=09=09"security flavor\n");
+=09=09=09=09return 0;
+=09=09=09}
+=09=09=09break;
+=09=09case Opt_proto:
+=09=09=09string =3D match_strdup(args);
+=09=09=09if (string =3D=3D NULL)
+=09=09=09=09goto out_nomem;
+=09=09=09token =3D match_token(string,
+=09=09=09=09=09    nfs_xprt_protocol_tokens, args);
+
+=09=09=09protofamily =3D AF_INET;
+=09=09=09switch (token) {
+=09=09=09case Opt_xprt_udp6:
+=09=09=09=09protofamily =3D AF_INET6;
+=09=09=09=09/* fall through */
+=09=09=09case Opt_xprt_udp:
+=09=09=09=09mnt->flags &=3D ~NFS_MOUNT_TCP;
+=09=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
+=09=09=09=09break;
+=09=09=09case Opt_xprt_tcp6:
+=09=09=09=09protofamily =3D AF_INET6;
+=09=09=09=09/* fall through */
+=09=09=09case Opt_xprt_tcp:
+=09=09=09=09mnt->flags |=3D NFS_MOUNT_TCP;
+=09=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09=09=09=09break;
+=09=09=09case Opt_xprt_rdma6:
+=09=09=09=09protofamily =3D AF_INET6;
+=09=09=09=09/* fall through */
+=09=09=09case Opt_xprt_rdma:
+=09=09=09=09/* vector side protocols to TCP */
+=09=09=09=09mnt->flags |=3D NFS_MOUNT_TCP;
+=09=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
+=09=09=09=09xprt_load_transport(string);
+=09=09=09=09break;
+=09=09=09default:
+=09=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
+=09=09=09=09=09=09"transport protocol\n");
+=09=09=09=09kfree(string);
+=09=09=09=09return 0;
+=09=09=09}
+=09=09=09kfree(string);
+=09=09=09break;
+=09=09case Opt_mountproto:
+=09=09=09string =3D match_strdup(args);
+=09=09=09if (string =3D=3D NULL)
+=09=09=09=09goto out_nomem;
+=09=09=09token =3D match_token(string,
+=09=09=09=09=09    nfs_xprt_protocol_tokens, args);
+=09=09=09kfree(string);
+
+=09=09=09mountfamily =3D AF_INET;
+=09=09=09switch (token) {
+=09=09=09case Opt_xprt_udp6:
+=09=09=09=09mountfamily =3D AF_INET6;
+=09=09=09=09/* fall through */
+=09=09=09case Opt_xprt_udp:
+=09=09=09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
+=09=09=09=09break;
+=09=09=09case Opt_xprt_tcp6:
+=09=09=09=09mountfamily =3D AF_INET6;
+=09=09=09=09/* fall through */
+=09=09=09case Opt_xprt_tcp:
+=09=09=09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09=09=09=09break;
+=09=09=09case Opt_xprt_rdma: /* not used for side protocols */
+=09=09=09default:
+=09=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
+=09=09=09=09=09=09"transport protocol\n");
+=09=09=09=09return 0;
+=09=09=09}
+=09=09=09break;
+=09=09case Opt_addr:
+=09=09=09string =3D match_strdup(args);
+=09=09=09if (string =3D=3D NULL)
+=09=09=09=09goto out_nomem;
+=09=09=09mnt->nfs_server.addrlen =3D
+=09=09=09=09rpc_pton(mnt->net, string, strlen(string),
+=09=09=09=09=09(struct sockaddr *)
+=09=09=09=09=09&mnt->nfs_server.address,
+=09=09=09=09=09sizeof(mnt->nfs_server.address));
+=09=09=09kfree(string);
+=09=09=09if (mnt->nfs_server.addrlen =3D=3D 0)
+=09=09=09=09goto out_invalid_address;
+=09=09=09break;
+=09=09case Opt_clientaddr:
+=09=09=09if (nfs_get_option_str(args, &mnt->client_address))
+=09=09=09=09goto out_nomem;
+=09=09=09break;
+=09=09case Opt_mounthost:
+=09=09=09if (nfs_get_option_str(args,
+=09=09=09=09=09       &mnt->mount_server.hostname))
+=09=09=09=09goto out_nomem;
+=09=09=09break;
+=09=09case Opt_mountaddr:
+=09=09=09string =3D match_strdup(args);
+=09=09=09if (string =3D=3D NULL)
+=09=09=09=09goto out_nomem;
+=09=09=09mnt->mount_server.addrlen =3D
+=09=09=09=09rpc_pton(mnt->net, string, strlen(string),
+=09=09=09=09=09(struct sockaddr *)
+=09=09=09=09=09&mnt->mount_server.address,
+=09=09=09=09=09sizeof(mnt->mount_server.address));
+=09=09=09kfree(string);
+=09=09=09if (mnt->mount_server.addrlen =3D=3D 0)
+=09=09=09=09goto out_invalid_address;
+=09=09=09break;
+=09=09case Opt_nconnect:
+=09=09=09if (nfs_get_option_ul_bound(args, &option, 1, NFS_MAX_CONNECTIONS=
))
+=09=09=09=09goto out_invalid_value;
+=09=09=09mnt->nfs_server.nconnect =3D option;
+=09=09=09break;
+=09=09case Opt_lookupcache:
+=09=09=09string =3D match_strdup(args);
+=09=09=09if (string =3D=3D NULL)
+=09=09=09=09goto out_nomem;
+=09=09=09token =3D match_token(string,
+=09=09=09=09=09nfs_lookupcache_tokens, args);
+=09=09=09kfree(string);
+=09=09=09switch (token) {
+=09=09=09=09case Opt_lookupcache_all:
+=09=09=09=09=09mnt->flags &=3D ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LO=
OKUP_CACHE_NONE);
+=09=09=09=09=09break;
+=09=09=09=09case Opt_lookupcache_positive:
+=09=09=09=09=09mnt->flags &=3D ~NFS_MOUNT_LOOKUP_CACHE_NONE;
+=09=09=09=09=09mnt->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG;
+=09=09=09=09=09break;
+=09=09=09=09case Opt_lookupcache_none:
+=09=09=09=09=09mnt->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOK=
UP_CACHE_NONE;
+=09=09=09=09=09break;
+=09=09=09=09default:
+=09=09=09=09=09dfprintk(MOUNT, "NFS:   invalid "
+=09=09=09=09=09=09=09"lookupcache argument\n");
+=09=09=09=09=09return 0;
+=09=09=09}
+=09=09=09break;
+=09=09case Opt_fscache_uniq:
+=09=09=09if (nfs_get_option_str(args, &mnt->fscache_uniq))
+=09=09=09=09goto out_nomem;
+=09=09=09mnt->options |=3D NFS_OPTION_FSCACHE;
+=09=09=09break;
+=09=09case Opt_local_lock:
+=09=09=09string =3D match_strdup(args);
+=09=09=09if (string =3D=3D NULL)
+=09=09=09=09goto out_nomem;
+=09=09=09token =3D match_token(string, nfs_local_lock_tokens,
+=09=09=09=09=09args);
+=09=09=09kfree(string);
+=09=09=09switch (token) {
+=09=09=09case Opt_local_lock_all:
+=09=09=09=09mnt->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
+=09=09=09=09=09       NFS_MOUNT_LOCAL_FCNTL);
+=09=09=09=09break;
+=09=09=09case Opt_local_lock_flock:
+=09=09=09=09mnt->flags |=3D NFS_MOUNT_LOCAL_FLOCK;
+=09=09=09=09break;
+=09=09=09case Opt_local_lock_posix:
+=09=09=09=09mnt->flags |=3D NFS_MOUNT_LOCAL_FCNTL;
+=09=09=09=09break;
+=09=09=09case Opt_local_lock_none:
+=09=09=09=09mnt->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
+=09=09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
+=09=09=09=09break;
+=09=09=09default:
+=09=09=09=09dfprintk(MOUNT, "NFS:=09invalid=09"
+=09=09=09=09=09=09"local_lock argument\n");
+=09=09=09=09return 0;
+=09=09=09}
+=09=09=09break;
+
+=09=09/*
+=09=09 * Special options
+=09=09 */
+=09=09case Opt_sloppy:
+=09=09=09sloppy =3D 1;
+=09=09=09dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
+=09=09=09break;
+=09=09case Opt_userspace:
+=09=09case Opt_deprecated:
+=09=09=09dfprintk(MOUNT, "NFS:   ignoring mount option "
+=09=09=09=09=09"'%s'\n", p);
+=09=09=09break;
+
+=09=09default:
+=09=09=09invalid_option =3D 1;
+=09=09=09dfprintk(MOUNT, "NFS:   unrecognized mount option "
+=09=09=09=09=09"'%s'\n", p);
+=09=09}
+=09}
+
+=09if (!sloppy && invalid_option)
+=09=09return 0;
+
+=09if (mnt->minorversion && mnt->version !=3D 4)
+=09=09goto out_minorversion_mismatch;
+
+=09if (mnt->options & NFS_OPTION_MIGRATION &&
+=09    (mnt->version !=3D 4 || mnt->minorversion !=3D 0))
+=09=09goto out_migration_misuse;
+
+=09/*
+=09 * verify that any proto=3D/mountproto=3D options match the address
+=09 * families in the addr=3D/mountaddr=3D options.
+=09 */
+=09if (protofamily !=3D AF_UNSPEC &&
+=09    protofamily !=3D mnt->nfs_server.address.ss_family)
+=09=09goto out_proto_mismatch;
+
+=09if (mountfamily !=3D AF_UNSPEC) {
+=09=09if (mnt->mount_server.addrlen) {
+=09=09=09if (mountfamily !=3D mnt->mount_server.address.ss_family)
+=09=09=09=09goto out_mountproto_mismatch;
+=09=09} else {
+=09=09=09if (mountfamily !=3D mnt->nfs_server.address.ss_family)
+=09=09=09=09goto out_mountproto_mismatch;
+=09=09}
+=09}
+
+=09return 1;
+
+out_mountproto_mismatch:
+=09printk(KERN_INFO "NFS: mount server address does not match mountproto=
=3D "
+=09=09=09 "option\n");
+=09return 0;
+out_proto_mismatch:
+=09printk(KERN_INFO "NFS: server address does not match proto=3D option\n"=
);
+=09return 0;
+out_invalid_address:
+=09printk(KERN_INFO "NFS: bad IP address specified: %s\n", p);
+=09return 0;
+out_invalid_value:
+=09printk(KERN_INFO "NFS: bad mount option value specified: %s\n", p);
+=09return 0;
+out_minorversion_mismatch:
+=09printk(KERN_INFO "NFS: mount option vers=3D%u does not support "
+=09=09=09 "minorversion=3D%u\n", mnt->version, mnt->minorversion);
+=09return 0;
+out_migration_misuse:
+=09printk(KERN_INFO
+=09=09"NFS: 'migration' not supported for this NFS version\n");
+=09return 0;
+out_nomem:
+=09printk(KERN_INFO "NFS: not enough memory to parse option\n");
+=09return 0;
+out_security_failure:
+=09printk(KERN_INFO "NFS: security options invalid: %d\n", rc);
+=09return 0;
+}
+
+/*
+ * Split "dev_name" into "hostname:export_path".
+ *
+ * The leftmost colon demarks the split between the server's hostname
+ * and the export path.  If the hostname starts with a left square
+ * bracket, then it may contain colons.
+ *
+ * Note: caller frees hostname and export path, even on error.
+ */
+static int nfs_parse_devname(const char *dev_name,
+=09=09=09     char **hostname, size_t maxnamlen,
+=09=09=09     char **export_path, size_t maxpathlen)
+{
+=09size_t len;
+=09char *end;
+
+=09if (unlikely(!dev_name || !*dev_name)) {
+=09=09dfprintk(MOUNT, "NFS: device name not specified\n");
+=09=09return -EINVAL;
+=09}
+
+=09/* Is the host name protected with square brakcets? */
+=09if (*dev_name =3D=3D '[') {
+=09=09end =3D strchr(++dev_name, ']');
+=09=09if (end =3D=3D NULL || end[1] !=3D ':')
+=09=09=09goto out_bad_devname;
+
+=09=09len =3D end - dev_name;
+=09=09end++;
+=09} else {
+=09=09char *comma;
+
+=09=09end =3D strchr(dev_name, ':');
+=09=09if (end =3D=3D NULL)
+=09=09=09goto out_bad_devname;
+=09=09len =3D end - dev_name;
+
+=09=09/* kill possible hostname list: not supported */
+=09=09comma =3D strchr(dev_name, ',');
+=09=09if (comma !=3D NULL && comma < end)
+=09=09=09len =3D comma - dev_name;
+=09}
+
+=09if (len > maxnamlen)
+=09=09goto out_hostname;
+
+=09/* N.B. caller will free nfs_server.hostname in all cases */
+=09*hostname =3D kstrndup(dev_name, len, GFP_KERNEL);
+=09if (*hostname =3D=3D NULL)
+=09=09goto out_nomem;
+=09len =3D strlen(++end);
+=09if (len > maxpathlen)
+=09=09goto out_path;
+=09*export_path =3D kstrndup(end, len, GFP_KERNEL);
+=09if (!*export_path)
+=09=09goto out_nomem;
+
+=09dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", *export_path);
+=09return 0;
+
+out_bad_devname:
+=09dfprintk(MOUNT, "NFS: device name not in host:path format\n");
+=09return -EINVAL;
+
+out_nomem:
+=09dfprintk(MOUNT, "NFS: not enough memory to parse device name\n");
+=09return -ENOMEM;
+
+out_hostname:
+=09dfprintk(MOUNT, "NFS: server hostname too long\n");
+=09return -ENAMETOOLONG;
+
+out_path:
+=09dfprintk(MOUNT, "NFS: export pathname too long\n");
+=09return -ENAMETOOLONG;
+}
+
+/*
+ * Validate the NFS2/NFS3 mount data
+ * - fills in the mount root filehandle
+ *
+ * For option strings, user space handles the following behaviors:
+ *
+ * + DNS: mapping server host name to IP address ("addr=3D" option)
+ *
+ * + failure mode: how to behave if a mount request can't be handled
+ *   immediately ("fg/bg" option)
+ *
+ * + retry: how often to retry a mount request ("retry=3D" option)
+ *
+ * + breaking back: trying proto=3Dudp after proto=3Dtcp, v2 after v3,
+ *   mountproto=3Dtcp after mountproto=3Dudp, and so on
+ */
+static int nfs23_validate_mount_data(void *options,
+=09=09=09=09     struct nfs_parsed_mount_data *args,
+=09=09=09=09     struct nfs_fh *mntfh,
+=09=09=09=09     const char *dev_name)
+{
+=09struct nfs_mount_data *data =3D (struct nfs_mount_data *)options;
+=09struct sockaddr *sap =3D (struct sockaddr *)&args->nfs_server.address;
+=09int extra_flags =3D NFS_MOUNT_LEGACY_INTERFACE;
+
+=09if (data =3D=3D NULL)
+=09=09goto out_no_data;
+
+=09args->version =3D NFS_DEFAULT_VERSION;
+=09switch (data->version) {
+=09case 1:
+=09=09data->namlen =3D 0; /* fall through */
+=09case 2:
+=09=09data->bsize =3D 0; /* fall through */
+=09case 3:
+=09=09if (data->flags & NFS_MOUNT_VER3)
+=09=09=09goto out_no_v3;
+=09=09data->root.size =3D NFS2_FHSIZE;
+=09=09memcpy(data->root.data, data->old_root.data, NFS2_FHSIZE);
+=09=09/* Turn off security negotiation */
+=09=09extra_flags |=3D NFS_MOUNT_SECFLAVOUR;
+=09=09/* fall through */
+=09case 4:
+=09=09if (data->flags & NFS_MOUNT_SECFLAVOUR)
+=09=09=09goto out_no_sec;
+=09=09/* fall through */
+=09case 5:
+=09=09memset(data->context, 0, sizeof(data->context));
+=09=09/* fall through */
+=09case 6:
+=09=09if (data->flags & NFS_MOUNT_VER3) {
+=09=09=09if (data->root.size > NFS3_FHSIZE || data->root.size =3D=3D 0)
+=09=09=09=09goto out_invalid_fh;
+=09=09=09mntfh->size =3D data->root.size;
+=09=09=09args->version =3D 3;
+=09=09} else {
+=09=09=09mntfh->size =3D NFS2_FHSIZE;
+=09=09=09args->version =3D 2;
+=09=09}
+
+
+=09=09memcpy(mntfh->data, data->root.data, mntfh->size);
+=09=09if (mntfh->size < sizeof(mntfh->data))
+=09=09=09memset(mntfh->data + mntfh->size, 0,
+=09=09=09       sizeof(mntfh->data) - mntfh->size);
+
+=09=09/*
+=09=09 * Translate to nfs_parsed_mount_data, which nfs_fill_super
+=09=09 * can deal with.
+=09=09 */
+=09=09args->flags=09=09=3D data->flags & NFS_MOUNT_FLAGMASK;
+=09=09args->flags=09=09|=3D extra_flags;
+=09=09args->rsize=09=09=3D data->rsize;
+=09=09args->wsize=09=09=3D data->wsize;
+=09=09args->timeo=09=09=3D data->timeo;
+=09=09args->retrans=09=09=3D data->retrans;
+=09=09args->acregmin=09=09=3D data->acregmin;
+=09=09args->acregmax=09=09=3D data->acregmax;
+=09=09args->acdirmin=09=09=3D data->acdirmin;
+=09=09args->acdirmax=09=09=3D data->acdirmax;
+=09=09args->need_mount=09=3D false;
+
+=09=09memcpy(sap, &data->addr, sizeof(data->addr));
+=09=09args->nfs_server.addrlen =3D sizeof(data->addr);
+=09=09args->nfs_server.port =3D ntohs(data->addr.sin_port);
+=09=09if (sap->sa_family !=3D AF_INET ||
+=09=09    !nfs_verify_server_address(sap))
+=09=09=09goto out_no_address;
+
+=09=09if (!(data->flags & NFS_MOUNT_TCP))
+=09=09=09args->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
+=09=09/* N.B. caller will free nfs_server.hostname in all cases */
+=09=09args->nfs_server.hostname =3D kstrdup(data->hostname, GFP_KERNEL);
+=09=09args->namlen=09=09=3D data->namlen;
+=09=09args->bsize=09=09=3D data->bsize;
+
+=09=09if (data->flags & NFS_MOUNT_SECFLAVOUR)
+=09=09=09args->selected_flavor =3D data->pseudoflavor;
+=09=09else
+=09=09=09args->selected_flavor =3D RPC_AUTH_UNIX;
+=09=09if (!args->nfs_server.hostname)
+=09=09=09goto out_nomem;
+
+=09=09if (!(data->flags & NFS_MOUNT_NONLM))
+=09=09=09args->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK|
+=09=09=09=09=09 NFS_MOUNT_LOCAL_FCNTL);
+=09=09else
+=09=09=09args->flags |=3D (NFS_MOUNT_LOCAL_FLOCK|
+=09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
+=09=09/*
+=09=09 * The legacy version 6 binary mount data from userspace has a
+=09=09 * field used only to transport selinux information into the
+=09=09 * the kernel.  To continue to support that functionality we
+=09=09 * have a touch of selinux knowledge here in the NFS code. The
+=09=09 * userspace code converted context=3Dblah to just blah so we are
+=09=09 * converting back to the full string selinux understands.
+=09=09 */
+=09=09if (data->context[0]){
+#ifdef CONFIG_SECURITY_SELINUX
+=09=09=09int rc;
+=09=09=09data->context[NFS_MAX_CONTEXT_LEN] =3D '\0';
+=09=09=09rc =3D security_add_mnt_opt("context", data->context,
+=09=09=09=09=09strlen(data->context), &args->lsm_opts);
+=09=09=09if (rc)
+=09=09=09=09return rc;
+#else
+=09=09=09return -EINVAL;
+#endif
+=09=09}
+
+=09=09break;
+=09default:
+=09=09return NFS_TEXT_DATA;
+=09}
+
+=09return 0;
+
+out_no_data:
+=09dfprintk(MOUNT, "NFS: mount program didn't pass any mount data\n");
+=09return -EINVAL;
+
+out_no_v3:
+=09dfprintk(MOUNT, "NFS: nfs_mount_data version %d does not support v3\n",
+=09=09 data->version);
+=09return -EINVAL;
+
+out_no_sec:
+=09dfprintk(MOUNT, "NFS: nfs_mount_data version supports only AUTH_SYS\n")=
;
+=09return -EINVAL;
+
+out_nomem:
+=09dfprintk(MOUNT, "NFS: not enough memory to handle mount options\n");
+=09return -ENOMEM;
+
+out_no_address:
+=09dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
+=09return -EINVAL;
+
+out_invalid_fh:
+=09dfprintk(MOUNT, "NFS: invalid root filehandle\n");
+=09return -EINVAL;
+}
+
+#if IS_ENABLED(CONFIG_NFS_V4)
+
+static void nfs4_validate_mount_flags(struct nfs_parsed_mount_data *args)
+{
+=09args->flags &=3D ~(NFS_MOUNT_NONLM|NFS_MOUNT_NOACL|NFS_MOUNT_VER3|
+=09=09=09 NFS_MOUNT_LOCAL_FLOCK|NFS_MOUNT_LOCAL_FCNTL);
+}
+
+/*
+ * Validate NFSv4 mount options
+ */
+static int nfs4_validate_mount_data(void *options,
+=09=09=09=09    struct nfs_parsed_mount_data *args,
+=09=09=09=09    const char *dev_name)
+{
+=09struct sockaddr *sap =3D (struct sockaddr *)&args->nfs_server.address;
+=09struct nfs4_mount_data *data =3D (struct nfs4_mount_data *)options;
+=09char *c;
+
+=09if (data =3D=3D NULL)
+=09=09goto out_no_data;
+
+=09args->version =3D 4;
+
+=09switch (data->version) {
+=09case 1:
+=09=09if (data->host_addrlen > sizeof(args->nfs_server.address))
+=09=09=09goto out_no_address;
+=09=09if (data->host_addrlen =3D=3D 0)
+=09=09=09goto out_no_address;
+=09=09args->nfs_server.addrlen =3D data->host_addrlen;
+=09=09if (copy_from_user(sap, data->host_addr, data->host_addrlen))
+=09=09=09return -EFAULT;
+=09=09if (!nfs_verify_server_address(sap))
+=09=09=09goto out_no_address;
+=09=09args->nfs_server.port =3D ntohs(((struct sockaddr_in *)sap)->sin_por=
t);
+
+=09=09if (data->auth_flavourlen) {
+=09=09=09rpc_authflavor_t pseudoflavor;
+=09=09=09if (data->auth_flavourlen > 1)
+=09=09=09=09goto out_inval_auth;
+=09=09=09if (copy_from_user(&pseudoflavor,
+=09=09=09=09=09   data->auth_flavours,
+=09=09=09=09=09   sizeof(pseudoflavor)))
+=09=09=09=09return -EFAULT;
+=09=09=09args->selected_flavor =3D pseudoflavor;
+=09=09} else
+=09=09=09args->selected_flavor =3D RPC_AUTH_UNIX;
+
+=09=09c =3D strndup_user(data->hostname.data, NFS4_MAXNAMLEN);
+=09=09if (IS_ERR(c))
+=09=09=09return PTR_ERR(c);
+=09=09args->nfs_server.hostname =3D c;
+
+=09=09c =3D strndup_user(data->mnt_path.data, NFS4_MAXPATHLEN);
+=09=09if (IS_ERR(c))
+=09=09=09return PTR_ERR(c);
+=09=09args->nfs_server.export_path =3D c;
+=09=09dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", c);
+
+=09=09c =3D strndup_user(data->client_addr.data, 16);
+=09=09if (IS_ERR(c))
+=09=09=09return PTR_ERR(c);
+=09=09args->client_address =3D c;
+
+=09=09/*
+=09=09 * Translate to nfs_parsed_mount_data, which nfs4_fill_super
+=09=09 * can deal with.
+=09=09 */
+
+=09=09args->flags=09=3D data->flags & NFS4_MOUNT_FLAGMASK;
+=09=09args->rsize=09=3D data->rsize;
+=09=09args->wsize=09=3D data->wsize;
+=09=09args->timeo=09=3D data->timeo;
+=09=09args->retrans=09=3D data->retrans;
+=09=09args->acregmin=09=3D data->acregmin;
+=09=09args->acregmax=09=3D data->acregmax;
+=09=09args->acdirmin=09=3D data->acdirmin;
+=09=09args->acdirmax=09=3D data->acdirmax;
+=09=09args->nfs_server.protocol =3D data->proto;
+=09=09nfs_validate_transport_protocol(args);
+=09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
+=09=09=09goto out_invalid_transport_udp;
+
+=09=09break;
+=09default:
+=09=09return NFS_TEXT_DATA;
+=09}
+
+=09return 0;
+
+out_no_data:
+=09dfprintk(MOUNT, "NFS4: mount program didn't pass any mount data\n");
+=09return -EINVAL;
+
+out_inval_auth:
+=09dfprintk(MOUNT, "NFS4: Invalid number of RPC auth flavours %d\n",
+=09=09 data->auth_flavourlen);
+=09return -EINVAL;
+
+out_no_address:
+=09dfprintk(MOUNT, "NFS4: mount program didn't pass remote address\n");
+=09return -EINVAL;
+
+out_invalid_transport_udp:
+=09dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
+=09return -EINVAL;
+}
+
+int nfs_validate_mount_data(struct file_system_type *fs_type,
+=09=09=09    void *options,
+=09=09=09    struct nfs_parsed_mount_data *args,
+=09=09=09    struct nfs_fh *mntfh,
+=09=09=09    const char *dev_name)
+{
+=09if (fs_type =3D=3D &nfs_fs_type)
+=09=09return nfs23_validate_mount_data(options, args, mntfh, dev_name);
+=09return nfs4_validate_mount_data(options, args, dev_name);
+}
+#else
+int nfs_validate_mount_data(struct file_system_type *fs_type,
+=09=09=09    void *options,
+=09=09=09    struct nfs_parsed_mount_data *args,
+=09=09=09    struct nfs_fh *mntfh,
+=09=09=09    const char *dev_name)
+{
+=09return nfs23_validate_mount_data(options, args, mntfh, dev_name);
+}
+#endif
+
+int nfs_validate_text_mount_data(void *options,
+=09=09=09=09 struct nfs_parsed_mount_data *args,
+=09=09=09=09 const char *dev_name)
+{
+=09int port =3D 0;
+=09int max_namelen =3D PAGE_SIZE;
+=09int max_pathlen =3D NFS_MAXPATHLEN;
+=09struct sockaddr *sap =3D (struct sockaddr *)&args->nfs_server.address;
+
+=09if (nfs_parse_mount_options((char *)options, args) =3D=3D 0)
+=09=09return -EINVAL;
+
+=09if (!nfs_verify_server_address(sap))
+=09=09goto out_no_address;
+
+=09if (args->version =3D=3D 4) {
+#if IS_ENABLED(CONFIG_NFS_V4)
+=09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_RDMA)
+=09=09=09port =3D NFS_RDMA_PORT;
+=09=09else
+=09=09=09port =3D NFS_PORT;
+=09=09max_namelen =3D NFS4_MAXNAMLEN;
+=09=09max_pathlen =3D NFS4_MAXPATHLEN;
+=09=09nfs_validate_transport_protocol(args);
+=09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
+=09=09=09goto out_invalid_transport_udp;
+=09=09nfs4_validate_mount_flags(args);
+#else
+=09=09goto out_v4_not_compiled;
+#endif /* CONFIG_NFS_V4 */
+=09} else {
+=09=09nfs_set_mount_transport_protocol(args);
+=09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_RDMA)
+=09=09=09port =3D NFS_RDMA_PORT;
+=09}
+
+=09nfs_set_port(sap, &args->nfs_server.port, port);
+
+=09return nfs_parse_devname(dev_name,
+=09=09=09=09   &args->nfs_server.hostname,
+=09=09=09=09   max_namelen,
+=09=09=09=09   &args->nfs_server.export_path,
+=09=09=09=09   max_pathlen);
+
+#if !IS_ENABLED(CONFIG_NFS_V4)
+out_v4_not_compiled:
+=09dfprintk(MOUNT, "NFS: NFSv4 is not compiled into kernel\n");
+=09return -EPROTONOSUPPORT;
+#else
+out_invalid_transport_udp:
+=09dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
+=09return -EINVAL;
+#endif /* !CONFIG_NFS_V4 */
+
+out_no_address:
+=09dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
+=09return -EINVAL;
+}
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a467e43fc682..28ab31fc5aa6 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -7,6 +7,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/crc32.h>
+#include <linux/sunrpc/addr.h>
 #include <linux/nfs_page.h>
 #include <linux/wait_bit.h>
=20
@@ -224,6 +225,22 @@ extern const struct svc_version nfs4_callback_version1=
;
 extern const struct svc_version nfs4_callback_version4;
=20
 struct nfs_pageio_descriptor;
+
+/* mount.c */
+#define NFS_TEXT_DATA=09=091
+
+extern struct nfs_parsed_mount_data *nfs_alloc_parsed_mount_data(void);
+extern void nfs_free_parsed_mount_data(struct nfs_parsed_mount_data *data)=
;
+extern int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data=
 *mnt);
+extern int nfs_validate_mount_data(struct file_system_type *fs_type,
+=09=09=09=09   void *options,
+=09=09=09=09   struct nfs_parsed_mount_data *args,
+=09=09=09=09   struct nfs_fh *mntfh,
+=09=09=09=09   const char *dev_name);
+extern int nfs_validate_text_mount_data(void *options,
+=09=09=09=09=09struct nfs_parsed_mount_data *args,
+=09=09=09=09=09const char *dev_name);
+
 /* pagelist.c */
 extern int __init nfs_init_nfspagecache(void);
 extern void nfs_destroy_nfspagecache(void);
@@ -765,3 +782,16 @@ static inline bool nfs_error_is_fatal_on_server(int er=
r)
 =09}
 =09return nfs_error_is_fatal(err);
 }
+
+/*
+ * Select between a default port value and a user-specified port value.
+ * If a zero value is set, then autobind will be used.
+ */
+static inline void nfs_set_port(struct sockaddr *sap, int *port,
+=09=09=09=09const unsigned short default_port)
+{
+=09if (*port =3D=3D NFS_UNSPEC_PORT)
+=09=09*port =3D default_port;
+
+=09rpc_set_port(sap, *port);
+}
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index de00f89dbe6e..b07585f62c65 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -69,229 +69,6 @@
 #include "nfs.h"
=20
 #define NFSDBG_FACILITY=09=09NFSDBG_VFS
-#define NFS_TEXT_DATA=09=091
-
-#if IS_ENABLED(CONFIG_NFS_V3)
-#define NFS_DEFAULT_VERSION 3
-#else
-#define NFS_DEFAULT_VERSION 2
-#endif
-
-#define NFS_MAX_CONNECTIONS 16
-
-enum {
-=09/* Mount options that take no arguments */
-=09Opt_soft, Opt_softerr, Opt_hard,
-=09Opt_posix, Opt_noposix,
-=09Opt_cto, Opt_nocto,
-=09Opt_ac, Opt_noac,
-=09Opt_lock, Opt_nolock,
-=09Opt_udp, Opt_tcp, Opt_rdma,
-=09Opt_acl, Opt_noacl,
-=09Opt_rdirplus, Opt_nordirplus,
-=09Opt_sharecache, Opt_nosharecache,
-=09Opt_resvport, Opt_noresvport,
-=09Opt_fscache, Opt_nofscache,
-=09Opt_migration, Opt_nomigration,
-
-=09/* Mount options that take integer arguments */
-=09Opt_port,
-=09Opt_rsize, Opt_wsize, Opt_bsize,
-=09Opt_timeo, Opt_retrans,
-=09Opt_acregmin, Opt_acregmax,
-=09Opt_acdirmin, Opt_acdirmax,
-=09Opt_actimeo,
-=09Opt_namelen,
-=09Opt_mountport,
-=09Opt_mountvers,
-=09Opt_minorversion,
-
-=09/* Mount options that take string arguments */
-=09Opt_nfsvers,
-=09Opt_sec, Opt_proto, Opt_mountproto, Opt_mounthost,
-=09Opt_addr, Opt_mountaddr, Opt_clientaddr,
-=09Opt_nconnect,
-=09Opt_lookupcache,
-=09Opt_fscache_uniq,
-=09Opt_local_lock,
-
-=09/* Special mount options */
-=09Opt_userspace, Opt_deprecated, Opt_sloppy,
-
-=09Opt_err
-};
-
-static const match_table_t nfs_mount_option_tokens =3D {
-=09{ Opt_userspace, "bg" },
-=09{ Opt_userspace, "fg" },
-=09{ Opt_userspace, "retry=3D%s" },
-
-=09{ Opt_sloppy, "sloppy" },
-
-=09{ Opt_soft, "soft" },
-=09{ Opt_softerr, "softerr" },
-=09{ Opt_hard, "hard" },
-=09{ Opt_deprecated, "intr" },
-=09{ Opt_deprecated, "nointr" },
-=09{ Opt_posix, "posix" },
-=09{ Opt_noposix, "noposix" },
-=09{ Opt_cto, "cto" },
-=09{ Opt_nocto, "nocto" },
-=09{ Opt_ac, "ac" },
-=09{ Opt_noac, "noac" },
-=09{ Opt_lock, "lock" },
-=09{ Opt_nolock, "nolock" },
-=09{ Opt_udp, "udp" },
-=09{ Opt_tcp, "tcp" },
-=09{ Opt_rdma, "rdma" },
-=09{ Opt_acl, "acl" },
-=09{ Opt_noacl, "noacl" },
-=09{ Opt_rdirplus, "rdirplus" },
-=09{ Opt_nordirplus, "nordirplus" },
-=09{ Opt_sharecache, "sharecache" },
-=09{ Opt_nosharecache, "nosharecache" },
-=09{ Opt_resvport, "resvport" },
-=09{ Opt_noresvport, "noresvport" },
-=09{ Opt_fscache, "fsc" },
-=09{ Opt_nofscache, "nofsc" },
-=09{ Opt_migration, "migration" },
-=09{ Opt_nomigration, "nomigration" },
-
-=09{ Opt_port, "port=3D%s" },
-=09{ Opt_rsize, "rsize=3D%s" },
-=09{ Opt_wsize, "wsize=3D%s" },
-=09{ Opt_bsize, "bsize=3D%s" },
-=09{ Opt_timeo, "timeo=3D%s" },
-=09{ Opt_retrans, "retrans=3D%s" },
-=09{ Opt_acregmin, "acregmin=3D%s" },
-=09{ Opt_acregmax, "acregmax=3D%s" },
-=09{ Opt_acdirmin, "acdirmin=3D%s" },
-=09{ Opt_acdirmax, "acdirmax=3D%s" },
-=09{ Opt_actimeo, "actimeo=3D%s" },
-=09{ Opt_namelen, "namlen=3D%s" },
-=09{ Opt_mountport, "mountport=3D%s" },
-=09{ Opt_mountvers, "mountvers=3D%s" },
-=09{ Opt_minorversion, "minorversion=3D%s" },
-
-=09{ Opt_nfsvers, "nfsvers=3D%s" },
-=09{ Opt_nfsvers, "vers=3D%s" },
-
-=09{ Opt_sec, "sec=3D%s" },
-=09{ Opt_proto, "proto=3D%s" },
-=09{ Opt_mountproto, "mountproto=3D%s" },
-=09{ Opt_addr, "addr=3D%s" },
-=09{ Opt_clientaddr, "clientaddr=3D%s" },
-=09{ Opt_mounthost, "mounthost=3D%s" },
-=09{ Opt_mountaddr, "mountaddr=3D%s" },
-
-=09{ Opt_nconnect, "nconnect=3D%s" },
-
-=09{ Opt_lookupcache, "lookupcache=3D%s" },
-=09{ Opt_fscache_uniq, "fsc=3D%s" },
-=09{ Opt_local_lock, "local_lock=3D%s" },
-
-=09/* The following needs to be listed after all other options */
-=09{ Opt_nfsvers, "v%s" },
-
-=09{ Opt_err, NULL }
-};
-
-enum {
-=09Opt_xprt_udp, Opt_xprt_udp6, Opt_xprt_tcp, Opt_xprt_tcp6, Opt_xprt_rdma=
,
-=09Opt_xprt_rdma6,
-
-=09Opt_xprt_err
-};
-
-static const match_table_t nfs_xprt_protocol_tokens =3D {
-=09{ Opt_xprt_udp, "udp" },
-=09{ Opt_xprt_udp6, "udp6" },
-=09{ Opt_xprt_tcp, "tcp" },
-=09{ Opt_xprt_tcp6, "tcp6" },
-=09{ Opt_xprt_rdma, "rdma" },
-=09{ Opt_xprt_rdma6, "rdma6" },
-
-=09{ Opt_xprt_err, NULL }
-};
-
-enum {
-=09Opt_sec_none, Opt_sec_sys,
-=09Opt_sec_krb5, Opt_sec_krb5i, Opt_sec_krb5p,
-=09Opt_sec_lkey, Opt_sec_lkeyi, Opt_sec_lkeyp,
-=09Opt_sec_spkm, Opt_sec_spkmi, Opt_sec_spkmp,
-
-=09Opt_sec_err
-};
-
-static const match_table_t nfs_secflavor_tokens =3D {
-=09{ Opt_sec_none, "none" },
-=09{ Opt_sec_none, "null" },
-=09{ Opt_sec_sys, "sys" },
-
-=09{ Opt_sec_krb5, "krb5" },
-=09{ Opt_sec_krb5i, "krb5i" },
-=09{ Opt_sec_krb5p, "krb5p" },
-
-=09{ Opt_sec_lkey, "lkey" },
-=09{ Opt_sec_lkeyi, "lkeyi" },
-=09{ Opt_sec_lkeyp, "lkeyp" },
-
-=09{ Opt_sec_spkm, "spkm3" },
-=09{ Opt_sec_spkmi, "spkm3i" },
-=09{ Opt_sec_spkmp, "spkm3p" },
-
-=09{ Opt_sec_err, NULL }
-};
-
-enum {
-=09Opt_lookupcache_all, Opt_lookupcache_positive,
-=09Opt_lookupcache_none,
-
-=09Opt_lookupcache_err
-};
-
-static match_table_t nfs_lookupcache_tokens =3D {
-=09{ Opt_lookupcache_all, "all" },
-=09{ Opt_lookupcache_positive, "pos" },
-=09{ Opt_lookupcache_positive, "positive" },
-=09{ Opt_lookupcache_none, "none" },
-
-=09{ Opt_lookupcache_err, NULL }
-};
-
-enum {
-=09Opt_local_lock_all, Opt_local_lock_flock, Opt_local_lock_posix,
-=09Opt_local_lock_none,
-
-=09Opt_local_lock_err
-};
-
-static match_table_t nfs_local_lock_tokens =3D {
-=09{ Opt_local_lock_all, "all" },
-=09{ Opt_local_lock_flock, "flock" },
-=09{ Opt_local_lock_posix, "posix" },
-=09{ Opt_local_lock_none, "none" },
-
-=09{ Opt_local_lock_err, NULL }
-};
-
-enum {
-=09Opt_vers_2, Opt_vers_3, Opt_vers_4, Opt_vers_4_0,
-=09Opt_vers_4_1, Opt_vers_4_2,
-
-=09Opt_vers_err
-};
-
-static match_table_t nfs_vers_tokens =3D {
-=09{ Opt_vers_2, "2" },
-=09{ Opt_vers_3, "3" },
-=09{ Opt_vers_4, "4" },
-=09{ Opt_vers_4_0, "4.0" },
-=09{ Opt_vers_4_1, "4.1" },
-=09{ Opt_vers_4_2, "4.2" },
-
-=09{ Opt_vers_err, NULL }
-};
=20
 static struct dentry *nfs_prepared_mount(struct file_system_type *fs_type,
 =09=09int flags, const char *dev_name, void *raw_data);
@@ -332,10 +109,6 @@ const struct super_operations nfs_sops =3D {
 EXPORT_SYMBOL_GPL(nfs_sops);
=20
 #if IS_ENABLED(CONFIG_NFS_V4)
-static void nfs4_validate_mount_flags(struct nfs_parsed_mount_data *);
-static int nfs4_validate_mount_data(void *options,
-=09struct nfs_parsed_mount_data *args, const char *dev_name);
-
 struct file_system_type nfs4_fs_type =3D {
 =09.owner=09=09=3D THIS_MODULE,
 =09.name=09=09=3D "nfs4",
@@ -932,141 +705,6 @@ void nfs_umount_begin(struct super_block *sb)
 }
 EXPORT_SYMBOL_GPL(nfs_umount_begin);
=20
-static struct nfs_parsed_mount_data *nfs_alloc_parsed_mount_data(void)
-{
-=09struct nfs_parsed_mount_data *data;
-
-=09data =3D kzalloc(sizeof(*data), GFP_KERNEL);
-=09if (data) {
-=09=09data->timeo=09=09=3D NFS_UNSPEC_TIMEO;
-=09=09data->retrans=09=09=3D NFS_UNSPEC_RETRANS;
-=09=09data->acregmin=09=09=3D NFS_DEF_ACREGMIN;
-=09=09data->acregmax=09=09=3D NFS_DEF_ACREGMAX;
-=09=09data->acdirmin=09=09=3D NFS_DEF_ACDIRMIN;
-=09=09data->acdirmax=09=09=3D NFS_DEF_ACDIRMAX;
-=09=09data->mount_server.port=09=3D NFS_UNSPEC_PORT;
-=09=09data->nfs_server.port=09=3D NFS_UNSPEC_PORT;
-=09=09data->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
-=09=09data->selected_flavor=09=3D RPC_AUTH_MAXFLAVOR;
-=09=09data->minorversion=09=3D 0;
-=09=09data->need_mount=09=3D true;
-=09=09data->net=09=09=3D current->nsproxy->net_ns;
-=09=09data->lsm_opts=09=09=3D NULL;
-=09}
-=09return data;
-}
-
-static void nfs_free_parsed_mount_data(struct nfs_parsed_mount_data *data)
-{
-=09if (data) {
-=09=09kfree(data->client_address);
-=09=09kfree(data->mount_server.hostname);
-=09=09kfree(data->nfs_server.export_path);
-=09=09kfree(data->nfs_server.hostname);
-=09=09kfree(data->fscache_uniq);
-=09=09security_free_mnt_opts(&data->lsm_opts);
-=09=09kfree(data);
-=09}
-}
-
-/*
- * Sanity-check a server address provided by the mount command.
- *
- * Address family must be initialized, and address must not be
- * the ANY address for that family.
- */
-static int nfs_verify_server_address(struct sockaddr *addr)
-{
-=09switch (addr->sa_family) {
-=09case AF_INET: {
-=09=09struct sockaddr_in *sa =3D (struct sockaddr_in *)addr;
-=09=09return sa->sin_addr.s_addr !=3D htonl(INADDR_ANY);
-=09}
-=09case AF_INET6: {
-=09=09struct in6_addr *sa =3D &((struct sockaddr_in6 *)addr)->sin6_addr;
-=09=09return !ipv6_addr_any(sa);
-=09}
-=09}
-
-=09dfprintk(MOUNT, "NFS: Invalid IP address specified\n");
-=09return 0;
-}
-
-/*
- * Select between a default port value and a user-specified port value.
- * If a zero value is set, then autobind will be used.
- */
-static void nfs_set_port(struct sockaddr *sap, int *port,
-=09=09=09=09 const unsigned short default_port)
-{
-=09if (*port =3D=3D NFS_UNSPEC_PORT)
-=09=09*port =3D default_port;
-
-=09rpc_set_port(sap, *port);
-}
-
-/*
- * Sanity check the NFS transport protocol.
- *
- */
-static void nfs_validate_transport_protocol(struct nfs_parsed_mount_data *=
mnt)
-{
-=09switch (mnt->nfs_server.protocol) {
-=09case XPRT_TRANSPORT_UDP:
-=09case XPRT_TRANSPORT_TCP:
-=09case XPRT_TRANSPORT_RDMA:
-=09=09break;
-=09default:
-=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
-=09}
-}
-
-/*
- * For text based NFSv2/v3 mounts, the mount protocol transport default
- * settings should depend upon the specified NFS transport.
- */
-static void nfs_set_mount_transport_protocol(struct nfs_parsed_mount_data =
*mnt)
-{
-=09nfs_validate_transport_protocol(mnt);
-
-=09if (mnt->mount_server.protocol =3D=3D XPRT_TRANSPORT_UDP ||
-=09    mnt->mount_server.protocol =3D=3D XPRT_TRANSPORT_TCP)
-=09=09=09return;
-=09switch (mnt->nfs_server.protocol) {
-=09case XPRT_TRANSPORT_UDP:
-=09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
-=09=09break;
-=09case XPRT_TRANSPORT_TCP:
-=09case XPRT_TRANSPORT_RDMA:
-=09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
-=09}
-}
-
-/*
- * Add 'flavor' to 'auth_info' if not already present.
- * Returns true if 'flavor' ends up in the list, false otherwise
- */
-static bool nfs_auth_info_add(struct nfs_auth_info *auth_info,
-=09=09=09      rpc_authflavor_t flavor)
-{
-=09unsigned int i;
-=09unsigned int max_flavor_len =3D ARRAY_SIZE(auth_info->flavors);
-
-=09/* make sure this flavor isn't already in the list */
-=09for (i =3D 0; i < auth_info->flavor_len; i++) {
-=09=09if (flavor =3D=3D auth_info->flavors[i])
-=09=09=09return true;
-=09}
-
-=09if (auth_info->flavor_len + 1 >=3D max_flavor_len) {
-=09=09dfprintk(MOUNT, "NFS: too many sec=3D flavors\n");
-=09=09return false;
-=09}
-
-=09auth_info->flavors[auth_info->flavor_len++] =3D flavor;
-=09return true;
-}
-
 /*
  * Return true if 'match' is in auth_info or auth_info is empty.
  * Return false otherwise.
@@ -1087,627 +725,6 @@ bool nfs_auth_info_match(const struct nfs_auth_info =
*auth_info,
 }
 EXPORT_SYMBOL_GPL(nfs_auth_info_match);
=20
-/*
- * Parse the value of the 'sec=3D' option.
- */
-static int nfs_parse_security_flavors(char *value,
-=09=09=09=09      struct nfs_parsed_mount_data *mnt)
-{
-=09substring_t args[MAX_OPT_ARGS];
-=09rpc_authflavor_t pseudoflavor;
-=09char *p;
-
-=09dfprintk(MOUNT, "NFS: parsing sec=3D%s option\n", value);
-
-=09while ((p =3D strsep(&value, ":")) !=3D NULL) {
-=09=09switch (match_token(p, nfs_secflavor_tokens, args)) {
-=09=09case Opt_sec_none:
-=09=09=09pseudoflavor =3D RPC_AUTH_NULL;
-=09=09=09break;
-=09=09case Opt_sec_sys:
-=09=09=09pseudoflavor =3D RPC_AUTH_UNIX;
-=09=09=09break;
-=09=09case Opt_sec_krb5:
-=09=09=09pseudoflavor =3D RPC_AUTH_GSS_KRB5;
-=09=09=09break;
-=09=09case Opt_sec_krb5i:
-=09=09=09pseudoflavor =3D RPC_AUTH_GSS_KRB5I;
-=09=09=09break;
-=09=09case Opt_sec_krb5p:
-=09=09=09pseudoflavor =3D RPC_AUTH_GSS_KRB5P;
-=09=09=09break;
-=09=09case Opt_sec_lkey:
-=09=09=09pseudoflavor =3D RPC_AUTH_GSS_LKEY;
-=09=09=09break;
-=09=09case Opt_sec_lkeyi:
-=09=09=09pseudoflavor =3D RPC_AUTH_GSS_LKEYI;
-=09=09=09break;
-=09=09case Opt_sec_lkeyp:
-=09=09=09pseudoflavor =3D RPC_AUTH_GSS_LKEYP;
-=09=09=09break;
-=09=09case Opt_sec_spkm:
-=09=09=09pseudoflavor =3D RPC_AUTH_GSS_SPKM;
-=09=09=09break;
-=09=09case Opt_sec_spkmi:
-=09=09=09pseudoflavor =3D RPC_AUTH_GSS_SPKMI;
-=09=09=09break;
-=09=09case Opt_sec_spkmp:
-=09=09=09pseudoflavor =3D RPC_AUTH_GSS_SPKMP;
-=09=09=09break;
-=09=09default:
-=09=09=09dfprintk(MOUNT,
-=09=09=09=09 "NFS: sec=3D option '%s' not recognized\n", p);
-=09=09=09return 0;
-=09=09}
-
-=09=09if (!nfs_auth_info_add(&mnt->auth_info, pseudoflavor))
-=09=09=09return 0;
-=09}
-
-=09return 1;
-}
-
-static int nfs_parse_version_string(char *string,
-=09=09struct nfs_parsed_mount_data *mnt,
-=09=09substring_t *args)
-{
-=09mnt->flags &=3D ~NFS_MOUNT_VER3;
-=09switch (match_token(string, nfs_vers_tokens, args)) {
-=09case Opt_vers_2:
-=09=09mnt->version =3D 2;
-=09=09break;
-=09case Opt_vers_3:
-=09=09mnt->flags |=3D NFS_MOUNT_VER3;
-=09=09mnt->version =3D 3;
-=09=09break;
-=09case Opt_vers_4:
-=09=09/* Backward compatibility option. In future,
-=09=09 * the mount program should always supply
-=09=09 * a NFSv4 minor version number.
-=09=09 */
-=09=09mnt->version =3D 4;
-=09=09break;
-=09case Opt_vers_4_0:
-=09=09mnt->version =3D 4;
-=09=09mnt->minorversion =3D 0;
-=09=09break;
-=09case Opt_vers_4_1:
-=09=09mnt->version =3D 4;
-=09=09mnt->minorversion =3D 1;
-=09=09break;
-=09case Opt_vers_4_2:
-=09=09mnt->version =3D 4;
-=09=09mnt->minorversion =3D 2;
-=09=09break;
-=09default:
-=09=09return 0;
-=09}
-=09return 1;
-}
-
-static int nfs_get_option_str(substring_t args[], char **option)
-{
-=09kfree(*option);
-=09*option =3D match_strdup(args);
-=09return !*option;
-}
-
-static int nfs_get_option_ul(substring_t args[], unsigned long *option)
-{
-=09int rc;
-=09char *string;
-
-=09string =3D match_strdup(args);
-=09if (string =3D=3D NULL)
-=09=09return -ENOMEM;
-=09rc =3D kstrtoul(string, 10, option);
-=09kfree(string);
-
-=09return rc;
-}
-
-static int nfs_get_option_ul_bound(substring_t args[], unsigned long *opti=
on,
-=09=09unsigned long l_bound, unsigned long u_bound)
-{
-=09int ret;
-
-=09ret =3D nfs_get_option_ul(args, option);
-=09if (ret !=3D 0)
-=09=09return ret;
-=09if (*option < l_bound || *option > u_bound)
-=09=09return -ERANGE;
-=09return 0;
-}
-
-/*
- * Error-check and convert a string of mount options from user space into
- * a data structure.  The whole mount string is processed; bad options are
- * skipped as they are encountered.  If there were no errors, return 1;
- * otherwise return 0 (zero).
- */
-static int nfs_parse_mount_options(char *raw,
-=09=09=09=09   struct nfs_parsed_mount_data *mnt)
-{
-=09char *p, *string;
-=09int rc, sloppy =3D 0, invalid_option =3D 0;
-=09unsigned short protofamily =3D AF_UNSPEC;
-=09unsigned short mountfamily =3D AF_UNSPEC;
-
-=09if (!raw) {
-=09=09dfprintk(MOUNT, "NFS: mount options string was NULL.\n");
-=09=09return 1;
-=09}
-=09dfprintk(MOUNT, "NFS: nfs mount opts=3D'%s'\n", raw);
-
-=09rc =3D security_sb_eat_lsm_opts(raw, &mnt->lsm_opts);
-=09if (rc)
-=09=09goto out_security_failure;
-
-=09while ((p =3D strsep(&raw, ",")) !=3D NULL) {
-=09=09substring_t args[MAX_OPT_ARGS];
-=09=09unsigned long option;
-=09=09int token;
-
-=09=09if (!*p)
-=09=09=09continue;
-
-=09=09dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", p);
-
-=09=09token =3D match_token(p, nfs_mount_option_tokens, args);
-=09=09switch (token) {
-
-=09=09/*
-=09=09 * boolean options:  foo/nofoo
-=09=09 */
-=09=09case Opt_soft:
-=09=09=09mnt->flags |=3D NFS_MOUNT_SOFT;
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_SOFTERR;
-=09=09=09break;
-=09=09case Opt_softerr:
-=09=09=09mnt->flags |=3D NFS_MOUNT_SOFTERR;
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_SOFT;
-=09=09=09break;
-=09=09case Opt_hard:
-=09=09=09mnt->flags &=3D ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
-=09=09=09break;
-=09=09case Opt_posix:
-=09=09=09mnt->flags |=3D NFS_MOUNT_POSIX;
-=09=09=09break;
-=09=09case Opt_noposix:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_POSIX;
-=09=09=09break;
-=09=09case Opt_cto:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_NOCTO;
-=09=09=09break;
-=09=09case Opt_nocto:
-=09=09=09mnt->flags |=3D NFS_MOUNT_NOCTO;
-=09=09=09break;
-=09=09case Opt_ac:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_NOAC;
-=09=09=09break;
-=09=09case Opt_noac:
-=09=09=09mnt->flags |=3D NFS_MOUNT_NOAC;
-=09=09=09break;
-=09=09case Opt_lock:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_NONLM;
-=09=09=09mnt->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
-=09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
-=09=09=09break;
-=09=09case Opt_nolock:
-=09=09=09mnt->flags |=3D NFS_MOUNT_NONLM;
-=09=09=09mnt->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
-=09=09=09=09       NFS_MOUNT_LOCAL_FCNTL);
-=09=09=09break;
-=09=09case Opt_udp:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_TCP;
-=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
-=09=09=09break;
-=09=09case Opt_tcp:
-=09=09=09mnt->flags |=3D NFS_MOUNT_TCP;
-=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
-=09=09=09break;
-=09=09case Opt_rdma:
-=09=09=09mnt->flags |=3D NFS_MOUNT_TCP; /* for side protocols */
-=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
-=09=09=09xprt_load_transport(p);
-=09=09=09break;
-=09=09case Opt_acl:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_NOACL;
-=09=09=09break;
-=09=09case Opt_noacl:
-=09=09=09mnt->flags |=3D NFS_MOUNT_NOACL;
-=09=09=09break;
-=09=09case Opt_rdirplus:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_NORDIRPLUS;
-=09=09=09break;
-=09=09case Opt_nordirplus:
-=09=09=09mnt->flags |=3D NFS_MOUNT_NORDIRPLUS;
-=09=09=09break;
-=09=09case Opt_sharecache:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_UNSHARED;
-=09=09=09break;
-=09=09case Opt_nosharecache:
-=09=09=09mnt->flags |=3D NFS_MOUNT_UNSHARED;
-=09=09=09break;
-=09=09case Opt_resvport:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_NORESVPORT;
-=09=09=09break;
-=09=09case Opt_noresvport:
-=09=09=09mnt->flags |=3D NFS_MOUNT_NORESVPORT;
-=09=09=09break;
-=09=09case Opt_fscache:
-=09=09=09mnt->options |=3D NFS_OPTION_FSCACHE;
-=09=09=09kfree(mnt->fscache_uniq);
-=09=09=09mnt->fscache_uniq =3D NULL;
-=09=09=09break;
-=09=09case Opt_nofscache:
-=09=09=09mnt->options &=3D ~NFS_OPTION_FSCACHE;
-=09=09=09kfree(mnt->fscache_uniq);
-=09=09=09mnt->fscache_uniq =3D NULL;
-=09=09=09break;
-=09=09case Opt_migration:
-=09=09=09mnt->options |=3D NFS_OPTION_MIGRATION;
-=09=09=09break;
-=09=09case Opt_nomigration:
-=09=09=09mnt->options &=3D ~NFS_OPTION_MIGRATION;
-=09=09=09break;
-
-=09=09/*
-=09=09 * options that take numeric values
-=09=09 */
-=09=09case Opt_port:
-=09=09=09if (nfs_get_option_ul(args, &option) ||
-=09=09=09    option > USHRT_MAX)
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->nfs_server.port =3D option;
-=09=09=09break;
-=09=09case Opt_rsize:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->rsize =3D option;
-=09=09=09break;
-=09=09case Opt_wsize:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->wsize =3D option;
-=09=09=09break;
-=09=09case Opt_bsize:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->bsize =3D option;
-=09=09=09break;
-=09=09case Opt_timeo:
-=09=09=09if (nfs_get_option_ul_bound(args, &option, 1, INT_MAX))
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->timeo =3D option;
-=09=09=09break;
-=09=09case Opt_retrans:
-=09=09=09if (nfs_get_option_ul_bound(args, &option, 0, INT_MAX))
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->retrans =3D option;
-=09=09=09break;
-=09=09case Opt_acregmin:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->acregmin =3D option;
-=09=09=09break;
-=09=09case Opt_acregmax:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->acregmax =3D option;
-=09=09=09break;
-=09=09case Opt_acdirmin:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->acdirmin =3D option;
-=09=09=09break;
-=09=09case Opt_acdirmax:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->acdirmax =3D option;
-=09=09=09break;
-=09=09case Opt_actimeo:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->acregmin =3D mnt->acregmax =3D
-=09=09=09mnt->acdirmin =3D mnt->acdirmax =3D option;
-=09=09=09break;
-=09=09case Opt_namelen:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->namlen =3D option;
-=09=09=09break;
-=09=09case Opt_mountport:
-=09=09=09if (nfs_get_option_ul(args, &option) ||
-=09=09=09    option > USHRT_MAX)
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->mount_server.port =3D option;
-=09=09=09break;
-=09=09case Opt_mountvers:
-=09=09=09if (nfs_get_option_ul(args, &option) ||
-=09=09=09    option < NFS_MNT_VERSION ||
-=09=09=09    option > NFS_MNT3_VERSION)
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->mount_server.version =3D option;
-=09=09=09break;
-=09=09case Opt_minorversion:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09if (option > NFS4_MAX_MINOR_VERSION)
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->minorversion =3D option;
-=09=09=09break;
-
-=09=09/*
-=09=09 * options that take text values
-=09=09 */
-=09=09case Opt_nfsvers:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09rc =3D nfs_parse_version_string(string, mnt, args);
-=09=09=09kfree(string);
-=09=09=09if (!rc)
-=09=09=09=09goto out_invalid_value;
-=09=09=09break;
-=09=09case Opt_sec:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09rc =3D nfs_parse_security_flavors(string, mnt);
-=09=09=09kfree(string);
-=09=09=09if (!rc) {
-=09=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
-=09=09=09=09=09=09"security flavor\n");
-=09=09=09=09return 0;
-=09=09=09}
-=09=09=09break;
-=09=09case Opt_proto:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09token =3D match_token(string,
-=09=09=09=09=09    nfs_xprt_protocol_tokens, args);
-
-=09=09=09protofamily =3D AF_INET;
-=09=09=09switch (token) {
-=09=09=09case Opt_xprt_udp6:
-=09=09=09=09protofamily =3D AF_INET6;
-=09=09=09=09/* fall through */
-=09=09=09case Opt_xprt_udp:
-=09=09=09=09mnt->flags &=3D ~NFS_MOUNT_TCP;
-=09=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
-=09=09=09=09break;
-=09=09=09case Opt_xprt_tcp6:
-=09=09=09=09protofamily =3D AF_INET6;
-=09=09=09=09/* fall through */
-=09=09=09case Opt_xprt_tcp:
-=09=09=09=09mnt->flags |=3D NFS_MOUNT_TCP;
-=09=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
-=09=09=09=09break;
-=09=09=09case Opt_xprt_rdma6:
-=09=09=09=09protofamily =3D AF_INET6;
-=09=09=09=09/* fall through */
-=09=09=09case Opt_xprt_rdma:
-=09=09=09=09/* vector side protocols to TCP */
-=09=09=09=09mnt->flags |=3D NFS_MOUNT_TCP;
-=09=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
-=09=09=09=09xprt_load_transport(string);
-=09=09=09=09break;
-=09=09=09default:
-=09=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
-=09=09=09=09=09=09"transport protocol\n");
-=09=09=09=09kfree(string);
-=09=09=09=09return 0;
-=09=09=09}
-=09=09=09kfree(string);
-=09=09=09break;
-=09=09case Opt_mountproto:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09token =3D match_token(string,
-=09=09=09=09=09    nfs_xprt_protocol_tokens, args);
-=09=09=09kfree(string);
-
-=09=09=09mountfamily =3D AF_INET;
-=09=09=09switch (token) {
-=09=09=09case Opt_xprt_udp6:
-=09=09=09=09mountfamily =3D AF_INET6;
-=09=09=09=09/* fall through */
-=09=09=09case Opt_xprt_udp:
-=09=09=09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
-=09=09=09=09break;
-=09=09=09case Opt_xprt_tcp6:
-=09=09=09=09mountfamily =3D AF_INET6;
-=09=09=09=09/* fall through */
-=09=09=09case Opt_xprt_tcp:
-=09=09=09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
-=09=09=09=09break;
-=09=09=09case Opt_xprt_rdma: /* not used for side protocols */
-=09=09=09default:
-=09=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
-=09=09=09=09=09=09"transport protocol\n");
-=09=09=09=09return 0;
-=09=09=09}
-=09=09=09break;
-=09=09case Opt_addr:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09mnt->nfs_server.addrlen =3D
-=09=09=09=09rpc_pton(mnt->net, string, strlen(string),
-=09=09=09=09=09(struct sockaddr *)
-=09=09=09=09=09&mnt->nfs_server.address,
-=09=09=09=09=09sizeof(mnt->nfs_server.address));
-=09=09=09kfree(string);
-=09=09=09if (mnt->nfs_server.addrlen =3D=3D 0)
-=09=09=09=09goto out_invalid_address;
-=09=09=09break;
-=09=09case Opt_clientaddr:
-=09=09=09if (nfs_get_option_str(args, &mnt->client_address))
-=09=09=09=09goto out_nomem;
-=09=09=09break;
-=09=09case Opt_mounthost:
-=09=09=09if (nfs_get_option_str(args,
-=09=09=09=09=09       &mnt->mount_server.hostname))
-=09=09=09=09goto out_nomem;
-=09=09=09break;
-=09=09case Opt_mountaddr:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09mnt->mount_server.addrlen =3D
-=09=09=09=09rpc_pton(mnt->net, string, strlen(string),
-=09=09=09=09=09(struct sockaddr *)
-=09=09=09=09=09&mnt->mount_server.address,
-=09=09=09=09=09sizeof(mnt->mount_server.address));
-=09=09=09kfree(string);
-=09=09=09if (mnt->mount_server.addrlen =3D=3D 0)
-=09=09=09=09goto out_invalid_address;
-=09=09=09break;
-=09=09case Opt_nconnect:
-=09=09=09if (nfs_get_option_ul_bound(args, &option, 1, NFS_MAX_CONNECTIONS=
))
-=09=09=09=09goto out_invalid_value;
-=09=09=09mnt->nfs_server.nconnect =3D option;
-=09=09=09break;
-=09=09case Opt_lookupcache:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09token =3D match_token(string,
-=09=09=09=09=09nfs_lookupcache_tokens, args);
-=09=09=09kfree(string);
-=09=09=09switch (token) {
-=09=09=09=09case Opt_lookupcache_all:
-=09=09=09=09=09mnt->flags &=3D ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LO=
OKUP_CACHE_NONE);
-=09=09=09=09=09break;
-=09=09=09=09case Opt_lookupcache_positive:
-=09=09=09=09=09mnt->flags &=3D ~NFS_MOUNT_LOOKUP_CACHE_NONE;
-=09=09=09=09=09mnt->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG;
-=09=09=09=09=09break;
-=09=09=09=09case Opt_lookupcache_none:
-=09=09=09=09=09mnt->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOK=
UP_CACHE_NONE;
-=09=09=09=09=09break;
-=09=09=09=09default:
-=09=09=09=09=09dfprintk(MOUNT, "NFS:   invalid "
-=09=09=09=09=09=09=09"lookupcache argument\n");
-=09=09=09=09=09return 0;
-=09=09=09}
-=09=09=09break;
-=09=09case Opt_fscache_uniq:
-=09=09=09if (nfs_get_option_str(args, &mnt->fscache_uniq))
-=09=09=09=09goto out_nomem;
-=09=09=09mnt->options |=3D NFS_OPTION_FSCACHE;
-=09=09=09break;
-=09=09case Opt_local_lock:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09token =3D match_token(string, nfs_local_lock_tokens,
-=09=09=09=09=09args);
-=09=09=09kfree(string);
-=09=09=09switch (token) {
-=09=09=09case Opt_local_lock_all:
-=09=09=09=09mnt->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
-=09=09=09=09=09       NFS_MOUNT_LOCAL_FCNTL);
-=09=09=09=09break;
-=09=09=09case Opt_local_lock_flock:
-=09=09=09=09mnt->flags |=3D NFS_MOUNT_LOCAL_FLOCK;
-=09=09=09=09break;
-=09=09=09case Opt_local_lock_posix:
-=09=09=09=09mnt->flags |=3D NFS_MOUNT_LOCAL_FCNTL;
-=09=09=09=09break;
-=09=09=09case Opt_local_lock_none:
-=09=09=09=09mnt->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
-=09=09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
-=09=09=09=09break;
-=09=09=09default:
-=09=09=09=09dfprintk(MOUNT, "NFS:=09invalid=09"
-=09=09=09=09=09=09"local_lock argument\n");
-=09=09=09=09return 0;
-=09=09=09}
-=09=09=09break;
-
-=09=09/*
-=09=09 * Special options
-=09=09 */
-=09=09case Opt_sloppy:
-=09=09=09sloppy =3D 1;
-=09=09=09dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
-=09=09=09break;
-=09=09case Opt_userspace:
-=09=09case Opt_deprecated:
-=09=09=09dfprintk(MOUNT, "NFS:   ignoring mount option "
-=09=09=09=09=09"'%s'\n", p);
-=09=09=09break;
-
-=09=09default:
-=09=09=09invalid_option =3D 1;
-=09=09=09dfprintk(MOUNT, "NFS:   unrecognized mount option "
-=09=09=09=09=09"'%s'\n", p);
-=09=09}
-=09}
-
-=09if (!sloppy && invalid_option)
-=09=09return 0;
-
-=09if (mnt->minorversion && mnt->version !=3D 4)
-=09=09goto out_minorversion_mismatch;
-
-=09if (mnt->options & NFS_OPTION_MIGRATION &&
-=09    (mnt->version !=3D 4 || mnt->minorversion !=3D 0))
-=09=09goto out_migration_misuse;
-
-=09/*
-=09 * verify that any proto=3D/mountproto=3D options match the address
-=09 * families in the addr=3D/mountaddr=3D options.
-=09 */
-=09if (protofamily !=3D AF_UNSPEC &&
-=09    protofamily !=3D mnt->nfs_server.address.ss_family)
-=09=09goto out_proto_mismatch;
-
-=09if (mountfamily !=3D AF_UNSPEC) {
-=09=09if (mnt->mount_server.addrlen) {
-=09=09=09if (mountfamily !=3D mnt->mount_server.address.ss_family)
-=09=09=09=09goto out_mountproto_mismatch;
-=09=09} else {
-=09=09=09if (mountfamily !=3D mnt->nfs_server.address.ss_family)
-=09=09=09=09goto out_mountproto_mismatch;
-=09=09}
-=09}
-
-=09return 1;
-
-out_mountproto_mismatch:
-=09printk(KERN_INFO "NFS: mount server address does not match mountproto=
=3D "
-=09=09=09 "option\n");
-=09return 0;
-out_proto_mismatch:
-=09printk(KERN_INFO "NFS: server address does not match proto=3D option\n"=
);
-=09return 0;
-out_invalid_address:
-=09printk(KERN_INFO "NFS: bad IP address specified: %s\n", p);
-=09return 0;
-out_invalid_value:
-=09printk(KERN_INFO "NFS: bad mount option value specified: %s\n", p);
-=09return 0;
-out_minorversion_mismatch:
-=09printk(KERN_INFO "NFS: mount option vers=3D%u does not support "
-=09=09=09 "minorversion=3D%u\n", mnt->version, mnt->minorversion);
-=09return 0;
-out_migration_misuse:
-=09printk(KERN_INFO
-=09=09"NFS: 'migration' not supported for this NFS version\n");
-=09return 0;
-out_nomem:
-=09printk(KERN_INFO "NFS: not enough memory to parse option\n");
-=09return 0;
-out_security_failure:
-=09printk(KERN_INFO "NFS: security options invalid: %d\n", rc);
-=09return 0;
-}
-
 /*
  * Ensure that a specified authtype in args->auth_info is supported by
  * the server. Returns 0 and sets args->selected_flavor if it's ok, and
@@ -1908,327 +925,6 @@ struct dentry *nfs_try_mount(int flags, const char *=
dev_name,
 }
 EXPORT_SYMBOL_GPL(nfs_try_mount);
=20
-/*
- * Split "dev_name" into "hostname:export_path".
- *
- * The leftmost colon demarks the split between the server's hostname
- * and the export path.  If the hostname starts with a left square
- * bracket, then it may contain colons.
- *
- * Note: caller frees hostname and export path, even on error.
- */
-static int nfs_parse_devname(const char *dev_name,
-=09=09=09     char **hostname, size_t maxnamlen,
-=09=09=09     char **export_path, size_t maxpathlen)
-{
-=09size_t len;
-=09char *end;
-
-=09if (unlikely(!dev_name || !*dev_name)) {
-=09=09dfprintk(MOUNT, "NFS: device name not specified\n");
-=09=09return -EINVAL;
-=09}
-
-=09/* Is the host name protected with square brakcets? */
-=09if (*dev_name =3D=3D '[') {
-=09=09end =3D strchr(++dev_name, ']');
-=09=09if (end =3D=3D NULL || end[1] !=3D ':')
-=09=09=09goto out_bad_devname;
-
-=09=09len =3D end - dev_name;
-=09=09end++;
-=09} else {
-=09=09char *comma;
-
-=09=09end =3D strchr(dev_name, ':');
-=09=09if (end =3D=3D NULL)
-=09=09=09goto out_bad_devname;
-=09=09len =3D end - dev_name;
-
-=09=09/* kill possible hostname list: not supported */
-=09=09comma =3D strchr(dev_name, ',');
-=09=09if (comma !=3D NULL && comma < end)
-=09=09=09len =3D comma - dev_name;
-=09}
-
-=09if (len > maxnamlen)
-=09=09goto out_hostname;
-
-=09/* N.B. caller will free nfs_server.hostname in all cases */
-=09*hostname =3D kstrndup(dev_name, len, GFP_KERNEL);
-=09if (*hostname =3D=3D NULL)
-=09=09goto out_nomem;
-=09len =3D strlen(++end);
-=09if (len > maxpathlen)
-=09=09goto out_path;
-=09*export_path =3D kstrndup(end, len, GFP_KERNEL);
-=09if (!*export_path)
-=09=09goto out_nomem;
-
-=09dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", *export_path);
-=09return 0;
-
-out_bad_devname:
-=09dfprintk(MOUNT, "NFS: device name not in host:path format\n");
-=09return -EINVAL;
-
-out_nomem:
-=09dfprintk(MOUNT, "NFS: not enough memory to parse device name\n");
-=09return -ENOMEM;
-
-out_hostname:
-=09dfprintk(MOUNT, "NFS: server hostname too long\n");
-=09return -ENAMETOOLONG;
-
-out_path:
-=09dfprintk(MOUNT, "NFS: export pathname too long\n");
-=09return -ENAMETOOLONG;
-}
-
-/*
- * Validate the NFS2/NFS3 mount data
- * - fills in the mount root filehandle
- *
- * For option strings, user space handles the following behaviors:
- *
- * + DNS: mapping server host name to IP address ("addr=3D" option)
- *
- * + failure mode: how to behave if a mount request can't be handled
- *   immediately ("fg/bg" option)
- *
- * + retry: how often to retry a mount request ("retry=3D" option)
- *
- * + breaking back: trying proto=3Dudp after proto=3Dtcp, v2 after v3,
- *   mountproto=3Dtcp after mountproto=3Dudp, and so on
- */
-static int nfs23_validate_mount_data(void *options,
-=09=09=09=09     struct nfs_parsed_mount_data *args,
-=09=09=09=09     struct nfs_fh *mntfh,
-=09=09=09=09     const char *dev_name)
-{
-=09struct nfs_mount_data *data =3D (struct nfs_mount_data *)options;
-=09struct sockaddr *sap =3D (struct sockaddr *)&args->nfs_server.address;
-=09int extra_flags =3D NFS_MOUNT_LEGACY_INTERFACE;
-
-=09if (data =3D=3D NULL)
-=09=09goto out_no_data;
-
-=09args->version =3D NFS_DEFAULT_VERSION;
-=09switch (data->version) {
-=09case 1:
-=09=09data->namlen =3D 0; /* fall through */
-=09case 2:
-=09=09data->bsize =3D 0; /* fall through */
-=09case 3:
-=09=09if (data->flags & NFS_MOUNT_VER3)
-=09=09=09goto out_no_v3;
-=09=09data->root.size =3D NFS2_FHSIZE;
-=09=09memcpy(data->root.data, data->old_root.data, NFS2_FHSIZE);
-=09=09/* Turn off security negotiation */
-=09=09extra_flags |=3D NFS_MOUNT_SECFLAVOUR;
-=09=09/* fall through */
-=09case 4:
-=09=09if (data->flags & NFS_MOUNT_SECFLAVOUR)
-=09=09=09goto out_no_sec;
-=09=09/* fall through */
-=09case 5:
-=09=09memset(data->context, 0, sizeof(data->context));
-=09=09/* fall through */
-=09case 6:
-=09=09if (data->flags & NFS_MOUNT_VER3) {
-=09=09=09if (data->root.size > NFS3_FHSIZE || data->root.size =3D=3D 0)
-=09=09=09=09goto out_invalid_fh;
-=09=09=09mntfh->size =3D data->root.size;
-=09=09=09args->version =3D 3;
-=09=09} else {
-=09=09=09mntfh->size =3D NFS2_FHSIZE;
-=09=09=09args->version =3D 2;
-=09=09}
-
-
-=09=09memcpy(mntfh->data, data->root.data, mntfh->size);
-=09=09if (mntfh->size < sizeof(mntfh->data))
-=09=09=09memset(mntfh->data + mntfh->size, 0,
-=09=09=09       sizeof(mntfh->data) - mntfh->size);
-
-=09=09/*
-=09=09 * Translate to nfs_parsed_mount_data, which nfs_fill_super
-=09=09 * can deal with.
-=09=09 */
-=09=09args->flags=09=09=3D data->flags & NFS_MOUNT_FLAGMASK;
-=09=09args->flags=09=09|=3D extra_flags;
-=09=09args->rsize=09=09=3D data->rsize;
-=09=09args->wsize=09=09=3D data->wsize;
-=09=09args->timeo=09=09=3D data->timeo;
-=09=09args->retrans=09=09=3D data->retrans;
-=09=09args->acregmin=09=09=3D data->acregmin;
-=09=09args->acregmax=09=09=3D data->acregmax;
-=09=09args->acdirmin=09=09=3D data->acdirmin;
-=09=09args->acdirmax=09=09=3D data->acdirmax;
-=09=09args->need_mount=09=3D false;
-
-=09=09memcpy(sap, &data->addr, sizeof(data->addr));
-=09=09args->nfs_server.addrlen =3D sizeof(data->addr);
-=09=09args->nfs_server.port =3D ntohs(data->addr.sin_port);
-=09=09if (sap->sa_family !=3D AF_INET ||
-=09=09    !nfs_verify_server_address(sap))
-=09=09=09goto out_no_address;
-
-=09=09if (!(data->flags & NFS_MOUNT_TCP))
-=09=09=09args->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
-=09=09/* N.B. caller will free nfs_server.hostname in all cases */
-=09=09args->nfs_server.hostname =3D kstrdup(data->hostname, GFP_KERNEL);
-=09=09args->namlen=09=09=3D data->namlen;
-=09=09args->bsize=09=09=3D data->bsize;
-
-=09=09if (data->flags & NFS_MOUNT_SECFLAVOUR)
-=09=09=09args->selected_flavor =3D data->pseudoflavor;
-=09=09else
-=09=09=09args->selected_flavor =3D RPC_AUTH_UNIX;
-=09=09if (!args->nfs_server.hostname)
-=09=09=09goto out_nomem;
-
-=09=09if (!(data->flags & NFS_MOUNT_NONLM))
-=09=09=09args->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK|
-=09=09=09=09=09 NFS_MOUNT_LOCAL_FCNTL);
-=09=09else
-=09=09=09args->flags |=3D (NFS_MOUNT_LOCAL_FLOCK|
-=09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
-=09=09/*
-=09=09 * The legacy version 6 binary mount data from userspace has a
-=09=09 * field used only to transport selinux information into the
-=09=09 * the kernel.  To continue to support that functionality we
-=09=09 * have a touch of selinux knowledge here in the NFS code. The
-=09=09 * userspace code converted context=3Dblah to just blah so we are
-=09=09 * converting back to the full string selinux understands.
-=09=09 */
-=09=09if (data->context[0]){
-#ifdef CONFIG_SECURITY_SELINUX
-=09=09=09int rc;
-=09=09=09data->context[NFS_MAX_CONTEXT_LEN] =3D '\0';
-=09=09=09rc =3D security_add_mnt_opt("context", data->context,
-=09=09=09=09=09strlen(data->context), &args->lsm_opts);
-=09=09=09if (rc)
-=09=09=09=09return rc;
-#else
-=09=09=09return -EINVAL;
-#endif
-=09=09}
-
-=09=09break;
-=09default:
-=09=09return NFS_TEXT_DATA;
-=09}
-
-=09return 0;
-
-out_no_data:
-=09dfprintk(MOUNT, "NFS: mount program didn't pass any mount data\n");
-=09return -EINVAL;
-
-out_no_v3:
-=09dfprintk(MOUNT, "NFS: nfs_mount_data version %d does not support v3\n",
-=09=09 data->version);
-=09return -EINVAL;
-
-out_no_sec:
-=09dfprintk(MOUNT, "NFS: nfs_mount_data version supports only AUTH_SYS\n")=
;
-=09return -EINVAL;
-
-out_nomem:
-=09dfprintk(MOUNT, "NFS: not enough memory to handle mount options\n");
-=09return -ENOMEM;
-
-out_no_address:
-=09dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
-=09return -EINVAL;
-
-out_invalid_fh:
-=09dfprintk(MOUNT, "NFS: invalid root filehandle\n");
-=09return -EINVAL;
-}
-
-#if IS_ENABLED(CONFIG_NFS_V4)
-static int nfs_validate_mount_data(struct file_system_type *fs_type,
-=09=09=09=09   void *options,
-=09=09=09=09   struct nfs_parsed_mount_data *args,
-=09=09=09=09   struct nfs_fh *mntfh,
-=09=09=09=09   const char *dev_name)
-{
-=09if (fs_type =3D=3D &nfs_fs_type)
-=09=09return nfs23_validate_mount_data(options, args, mntfh, dev_name);
-=09return nfs4_validate_mount_data(options, args, dev_name);
-}
-#else
-static int nfs_validate_mount_data(struct file_system_type *fs_type,
-=09=09=09=09   void *options,
-=09=09=09=09   struct nfs_parsed_mount_data *args,
-=09=09=09=09   struct nfs_fh *mntfh,
-=09=09=09=09   const char *dev_name)
-{
-=09return nfs23_validate_mount_data(options, args, mntfh, dev_name);
-}
-#endif
-
-static int nfs_validate_text_mount_data(void *options,
-=09=09=09=09=09struct nfs_parsed_mount_data *args,
-=09=09=09=09=09const char *dev_name)
-{
-=09int port =3D 0;
-=09int max_namelen =3D PAGE_SIZE;
-=09int max_pathlen =3D NFS_MAXPATHLEN;
-=09struct sockaddr *sap =3D (struct sockaddr *)&args->nfs_server.address;
-
-=09if (nfs_parse_mount_options((char *)options, args) =3D=3D 0)
-=09=09return -EINVAL;
-
-=09if (!nfs_verify_server_address(sap))
-=09=09goto out_no_address;
-
-=09if (args->version =3D=3D 4) {
-#if IS_ENABLED(CONFIG_NFS_V4)
-=09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_RDMA)
-=09=09=09port =3D NFS_RDMA_PORT;
-=09=09else
-=09=09=09port =3D NFS_PORT;
-=09=09max_namelen =3D NFS4_MAXNAMLEN;
-=09=09max_pathlen =3D NFS4_MAXPATHLEN;
-=09=09nfs_validate_transport_protocol(args);
-=09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
-=09=09=09goto out_invalid_transport_udp;
-=09=09nfs4_validate_mount_flags(args);
-#else
-=09=09goto out_v4_not_compiled;
-#endif /* CONFIG_NFS_V4 */
-=09} else {
-=09=09nfs_set_mount_transport_protocol(args);
-=09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_RDMA)
-=09=09=09port =3D NFS_RDMA_PORT;
-=09}
-
-=09nfs_set_port(sap, &args->nfs_server.port, port);
-
-=09return nfs_parse_devname(dev_name,
-=09=09=09=09   &args->nfs_server.hostname,
-=09=09=09=09   max_namelen,
-=09=09=09=09   &args->nfs_server.export_path,
-=09=09=09=09   max_pathlen);
-
-#if !IS_ENABLED(CONFIG_NFS_V4)
-out_v4_not_compiled:
-=09dfprintk(MOUNT, "NFS: NFSv4 is not compiled into kernel\n");
-=09return -EPROTONOSUPPORT;
-#else
-out_invalid_transport_udp:
-=09dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
-=09return -EINVAL;
-#endif /* !CONFIG_NFS_V4 */
-
-out_no_address:
-=09dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
-=09return -EINVAL;
-}
-
 #define NFS_REMOUNT_CMP_FLAGMASK ~(NFS_MOUNT_INTR \
 =09=09| NFS_MOUNT_SECURE \
 =09=09| NFS_MOUNT_TCP \
@@ -2735,113 +1431,6 @@ nfs_prepared_mount(struct file_system_type *fs_type=
, int flags,
=20
 #if IS_ENABLED(CONFIG_NFS_V4)
=20
-static void nfs4_validate_mount_flags(struct nfs_parsed_mount_data *args)
-{
-=09args->flags &=3D ~(NFS_MOUNT_NONLM|NFS_MOUNT_NOACL|NFS_MOUNT_VER3|
-=09=09=09 NFS_MOUNT_LOCAL_FLOCK|NFS_MOUNT_LOCAL_FCNTL);
-}
-
-/*
- * Validate NFSv4 mount options
- */
-static int nfs4_validate_mount_data(void *options,
-=09=09=09=09    struct nfs_parsed_mount_data *args,
-=09=09=09=09    const char *dev_name)
-{
-=09struct sockaddr *sap =3D (struct sockaddr *)&args->nfs_server.address;
-=09struct nfs4_mount_data *data =3D (struct nfs4_mount_data *)options;
-=09char *c;
-
-=09if (data =3D=3D NULL)
-=09=09goto out_no_data;
-
-=09args->version =3D 4;
-
-=09switch (data->version) {
-=09case 1:
-=09=09if (data->host_addrlen > sizeof(args->nfs_server.address))
-=09=09=09goto out_no_address;
-=09=09if (data->host_addrlen =3D=3D 0)
-=09=09=09goto out_no_address;
-=09=09args->nfs_server.addrlen =3D data->host_addrlen;
-=09=09if (copy_from_user(sap, data->host_addr, data->host_addrlen))
-=09=09=09return -EFAULT;
-=09=09if (!nfs_verify_server_address(sap))
-=09=09=09goto out_no_address;
-=09=09args->nfs_server.port =3D ntohs(((struct sockaddr_in *)sap)->sin_por=
t);
-
-=09=09if (data->auth_flavourlen) {
-=09=09=09rpc_authflavor_t pseudoflavor;
-=09=09=09if (data->auth_flavourlen > 1)
-=09=09=09=09goto out_inval_auth;
-=09=09=09if (copy_from_user(&pseudoflavor,
-=09=09=09=09=09   data->auth_flavours,
-=09=09=09=09=09   sizeof(pseudoflavor)))
-=09=09=09=09return -EFAULT;
-=09=09=09args->selected_flavor =3D pseudoflavor;
-=09=09} else
-=09=09=09args->selected_flavor =3D RPC_AUTH_UNIX;
-
-=09=09c =3D strndup_user(data->hostname.data, NFS4_MAXNAMLEN);
-=09=09if (IS_ERR(c))
-=09=09=09return PTR_ERR(c);
-=09=09args->nfs_server.hostname =3D c;
-
-=09=09c =3D strndup_user(data->mnt_path.data, NFS4_MAXPATHLEN);
-=09=09if (IS_ERR(c))
-=09=09=09return PTR_ERR(c);
-=09=09args->nfs_server.export_path =3D c;
-=09=09dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", c);
-
-=09=09c =3D strndup_user(data->client_addr.data, 16);
-=09=09if (IS_ERR(c))
-=09=09=09return PTR_ERR(c);
-=09=09args->client_address =3D c;
-
-=09=09/*
-=09=09 * Translate to nfs_parsed_mount_data, which nfs4_fill_super
-=09=09 * can deal with.
-=09=09 */
-
-=09=09args->flags=09=3D data->flags & NFS4_MOUNT_FLAGMASK;
-=09=09args->rsize=09=3D data->rsize;
-=09=09args->wsize=09=3D data->wsize;
-=09=09args->timeo=09=3D data->timeo;
-=09=09args->retrans=09=3D data->retrans;
-=09=09args->acregmin=09=3D data->acregmin;
-=09=09args->acregmax=09=3D data->acregmax;
-=09=09args->acdirmin=09=3D data->acdirmin;
-=09=09args->acdirmax=09=3D data->acdirmax;
-=09=09args->nfs_server.protocol =3D data->proto;
-=09=09nfs_validate_transport_protocol(args);
-=09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
-=09=09=09goto out_invalid_transport_udp;
-
-=09=09break;
-=09default:
-=09=09return NFS_TEXT_DATA;
-=09}
-
-=09return 0;
-
-out_no_data:
-=09dfprintk(MOUNT, "NFS4: mount program didn't pass any mount data\n");
-=09return -EINVAL;
-
-out_inval_auth:
-=09dfprintk(MOUNT, "NFS4: Invalid number of RPC auth flavours %d\n",
-=09=09 data->auth_flavourlen);
-=09return -EINVAL;
-
-out_no_address:
-=09dfprintk(MOUNT, "NFS4: mount program didn't pass remote address\n");
-=09return -EINVAL;
-
-out_invalid_transport_udp:
-=09dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
-=09return -EINVAL;
-}
-
 /*
  * NFS v4 module parameters need to stay in the
  * NFS client for backwards compatibility
--=20
2.17.2

