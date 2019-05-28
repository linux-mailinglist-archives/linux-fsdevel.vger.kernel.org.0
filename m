Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE12C9F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfE1PN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:13:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfE1PN0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:13:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 379AE30BF4E5;
        Tue, 28 May 2019 15:13:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0ECBCA700;
        Tue, 28 May 2019 15:13:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/25] nfs: Support fsinfo() [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:13:23 +0100
Message-ID: <155905640395.1662.11340611657732220291.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 28 May 2019 15:13:26 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow fsinfo() to retrieve information about a superblock, including the
values configured by the parameters passed at superblock creation.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/fs_context.c |  163 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/internal.h   |    6 ++
 fs/nfs/nfs4super.c  |    3 +
 fs/nfs/super.c      |   77 ++++++++++++++++++++++++
 4 files changed, 248 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index d05271b91e38..f550b0e54833 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -17,6 +17,8 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsinfo.h>
+#include <linux/mount.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
@@ -1407,3 +1409,164 @@ MODULE_ALIAS_FS("nfs4");
 MODULE_ALIAS("nfs4");
 EXPORT_SYMBOL_GPL(nfs4_fs_type);
 #endif /* CONFIG_NFS_V4 */
+
+#ifdef CONFIG_FSINFO
+/*
+ * Allow the filesystem parameters to be queried.
+ */
+int nfs_fsinfo_parameters(struct fsinfo_kparams *params, struct path *path,
+			  const struct nfs_server *server)
+{
+	const struct nfs_client *client = server->nfs_client;
+	const struct sockaddr *sap = (const struct sockaddr *)&server->mountd_address;
+	unsigned int version = client->rpc_ops->version;
+	unsigned int sf = server->flags;
+	const char *b;
+	char *e;
+	int i;
+
+	static const struct proc_nfs_info {
+		int flag;
+		const char *str;
+		const char *nostr;
+	} nfs_info[] = {
+		{ NFS_MOUNT_SOFT, "soft", "hard" },
+		{ NFS_MOUNT_POSIX, "posix", "" },
+		{ NFS_MOUNT_NOCTO, "nocto", "" },
+		{ NFS_MOUNT_NOAC, "noac", "" },
+		{ NFS_MOUNT_NONLM, "nolock", "" },
+		{ NFS_MOUNT_NOACL, "noacl", "" },
+		{ NFS_MOUNT_NORDIRPLUS, "nordirplus", "" },
+		{ NFS_MOUNT_UNSHARED, "nosharecache", "" },
+		{ NFS_MOUNT_NORESVPORT, "noresvport", "" },
+	};
+
+	rcu_read_lock();
+
+	b = params->scratch_buffer;
+	b = nfs_path(&e, path->mnt->mnt_root, params->scratch_buffer, params->buf_size, 0);
+	if (b < e)
+		fsinfo_note_param(params, "source", b);
+
+	if (version == 4)
+		fsinfo_note_paramf(params, "vers", "4.%u", client->cl_minorversion);
+	else
+		fsinfo_note_paramf(params, "vers", "%u", version);
+
+	fsinfo_note_paramf(params, "rsize", "%u", server->rsize);
+	fsinfo_note_paramf(params, "wsize", "%u", server->wsize);
+	if (server->bsize)
+		fsinfo_note_paramf(params, "bsize", "%u", server->bsize);
+	fsinfo_note_paramf(params, "namlen", "%u", server->namelen);
+
+	if (server->acregmin != NFS_DEF_ACREGMIN*HZ)
+		fsinfo_note_paramf(params, "acregmin", "%u", server->acregmin/HZ);
+	if (server->acregmax != NFS_DEF_ACREGMAX*HZ)
+		fsinfo_note_paramf(params, "acregmin", "%u", server->acregmax/HZ);
+	if (server->acdirmin != NFS_DEF_ACDIRMIN*HZ)
+		fsinfo_note_paramf(params, "acdirmin", "%u", server->acdirmin/HZ);
+	if (server->acdirmax != NFS_DEF_ACDIRMAX*HZ)
+		fsinfo_note_paramf(params, "acdirmin", "%u", server->acdirmax/HZ);
+
+	for (i = 0; i < ARRAY_SIZE(nfs_info); i++) {
+		if (sf & nfs_info[i].flag)
+			b = nfs_info[i].str;
+		else
+			b = nfs_info[i].nostr;
+		if (b[0])
+			fsinfo_note_param(params, b, NULL);
+	}
+
+	fsinfo_note_param(params, "proto",
+			  rpc_peeraddr2str(server->client, RPC_DISPLAY_NETID));
+	if (version != 4 || server->port != NFS_PORT)
+		fsinfo_note_paramf(params, "port", "%u", server->port);
+
+	fsinfo_note_paramf(params, "timeo", "%lu",
+			   10U * server->client->cl_timeout->to_initval / HZ);
+	fsinfo_note_paramf(params, "retrans", "%u",
+			  server->client->cl_timeout->to_retries);
+	fsinfo_note_param(params, "sec",
+			  nfs_pseudoflavour_to_name(server->client->cl_auth->au_flavor));
+
+	if (server->options & NFS_OPTION_FSCACHE)
+		fsinfo_note_param(params, "fsc", NULL);
+	if (server->options & NFS_OPTION_MIGRATION)
+		fsinfo_note_param(params, "migration", NULL);
+
+	if (server->flags & NFS_MOUNT_LOOKUP_CACHE_NONEG) {
+		if (server->flags & NFS_MOUNT_LOOKUP_CACHE_NONE)
+			fsinfo_note_param(params, "lookupcache", "none");
+		else
+			fsinfo_note_param(params, "lookupcache", "pos");
+	}
+
+	switch (server->flags & (NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL)) {
+	case 0:				b = "none";	break;
+	case NFS_MOUNT_LOCAL_FLOCK:	b = "flock";	break;
+	case NFS_MOUNT_LOCAL_FCNTL:	b = "posix";	break;
+	default:			b = "all";	break;
+	}
+	fsinfo_note_param(params, "local_lock", b);
+
+	if (version == 4)
+		fsinfo_note_param(params, "clientaddr", client->cl_ipaddr);
+
+	if (version != 4 && !(server->flags & NFS_MOUNT_LEGACY_INTERFACE)) {
+		switch (sap->sa_family) {
+		case AF_INET: {
+			struct sockaddr_in *sin = (struct sockaddr_in *)sap;
+			fsinfo_note_paramf(params, "mountaddr", "%pI4",
+					   &sin->sin_addr.s_addr);
+			break;
+		}
+		case AF_INET6: {
+			struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sap;
+			fsinfo_note_paramf(params, "mountaddr", "%pI6c",
+					   &sin6->sin6_addr);
+			break;
+		}
+		}
+
+		if (server->mountd_port &&
+		    server->mountd_port != (unsigned short)NFS_UNSPEC_PORT)
+			fsinfo_note_paramf(params, "mountport", "%u", server->mountd_port);
+
+		switch (sap->sa_family) {
+		case AF_INET:
+			switch (server->mountd_protocol) {
+			case IPPROTO_UDP:
+				b = RPCBIND_NETID_UDP;
+				break;
+			case IPPROTO_TCP:
+				b = RPCBIND_NETID_TCP;
+				break;
+			}
+			break;
+		case AF_INET6:
+			switch (server->mountd_protocol) {
+			case IPPROTO_UDP:
+				b = RPCBIND_NETID_UDP6;
+				break;
+			case IPPROTO_TCP:
+				b = RPCBIND_NETID_TCP6;
+				break;
+			}
+			break;
+		}
+
+		if (b)
+			fsinfo_note_param(params, "mountproto", b);
+
+		if (server->mountd_version)
+			fsinfo_note_paramf(params, "mountvers", "%u",
+					   server->mountd_version);
+	}
+
+	fsinfo_note_param(params, "addr",
+			  rpc_peeraddr2str(server->nfs_client->cl_rpcclient, RPC_DISPLAY_ADDR));
+
+	rcu_read_unlock();
+	return params->usage;
+}
+#endif /* CONFIG_FSINFO */
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index da088f5611f0..c218e715881d 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -244,6 +244,10 @@ extern const struct svc_version nfs4_callback_version4;
 
 /* fs_context.c */
 extern struct file_system_type nfs_fs_type;
+#ifdef CONFIG_FSINFO
+extern int nfs_fsinfo_parameters(struct fsinfo_kparams *params, struct path *path,
+				 const struct nfs_server *server);
+#endif
 
 /* pagelist.c */
 extern int __init nfs_init_nfspagecache(void);
@@ -408,6 +412,7 @@ bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
 int nfs_try_get_tree(struct fs_context *);
 int nfs_get_tree_common(struct fs_context *);
 void nfs_kill_super(struct super_block *);
+const char *nfs_pseudoflavour_to_name(rpc_authflavor_t);
 
 extern struct rpc_stat nfs_rpcstat;
 
@@ -455,6 +460,7 @@ extern void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio);
 /* super.c */
 void nfs_umount_begin(struct super_block *);
 int  nfs_statfs(struct dentry *, struct kstatfs *);
+int  nfs_fsinfo(struct path *, struct fsinfo_kparams *);
 int  nfs_show_options(struct seq_file *, struct dentry *);
 int  nfs_show_devname(struct seq_file *, struct dentry *);
 int  nfs_show_path(struct seq_file *, struct dentry *);
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 0240429ec596..22d8f2842ac1 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -31,6 +31,9 @@ static const struct super_operations nfs4_sops = {
 	.show_devname	= nfs_show_devname,
 	.show_path	= nfs_show_path,
 	.show_stats	= nfs_show_stats,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= nfs_fsinfo,
+#endif
 };
 
 struct nfs_subversion nfs_v4 = {
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index c455ebeeadc9..dde6c59d0210 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -54,6 +54,7 @@
 #include <linux/parser.h>
 #include <linux/nsproxy.h>
 #include <linux/rcupdate.h>
+#include <linux/fsinfo.h>
 
 #include <linux/uaccess.h>
 
@@ -81,6 +82,9 @@ const struct super_operations nfs_sops = {
 	.show_devname	= nfs_show_devname,
 	.show_path	= nfs_show_path,
 	.show_stats	= nfs_show_stats,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= nfs_fsinfo,
+#endif
 };
 EXPORT_SYMBOL_GPL(nfs_sops);
 
@@ -241,10 +245,81 @@ int nfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 }
 EXPORT_SYMBOL_GPL(nfs_statfs);
 
+#ifdef CONFIG_FSINFO
+/*
+ * Get filesystem information.
+ */
+int nfs_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct fsinfo_server_address *addr;
+	struct fsinfo_capabilities *caps;
+	struct nfs_server *server = NFS_SB(path->dentry->d_sb);
+	struct nfs_client *client = server->nfs_client;
+	struct rpc_clnt *clnt;
+	struct rpc_xprt *xprt;
+	const char *str;
+	unsigned int version = client->rpc_ops->version;
+
+	switch (params->request) {
+	case FSINFO_ATTR_CAPABILITIES:
+		caps = params->buffer;
+		fsinfo_set_cap(caps, FSINFO_CAP_IS_NETWORK_FS);
+		fsinfo_set_cap(caps, FSINFO_CAP_AUTOMOUNTS);
+		fsinfo_set_cap(caps, FSINFO_CAP_ADV_LOCKS);
+		fsinfo_set_cap(caps, FSINFO_CAP_UIDS);
+		fsinfo_set_cap(caps, FSINFO_CAP_GIDS);
+		fsinfo_set_cap(caps, FSINFO_CAP_O_SYNC);
+		fsinfo_set_cap(caps, FSINFO_CAP_O_DIRECT);
+		fsinfo_set_cap(caps, FSINFO_CAP_SYMLINKS);
+		fsinfo_set_cap(caps, FSINFO_CAP_HARD_LINKS);
+		fsinfo_set_cap(caps, FSINFO_CAP_DEVICE_FILES);
+		fsinfo_set_cap(caps, FSINFO_CAP_UNIX_SPECIALS);
+		fsinfo_set_cap(caps, FSINFO_CAP_HAS_ATIME);
+		fsinfo_set_cap(caps, FSINFO_CAP_HAS_CTIME);
+		fsinfo_set_cap(caps, FSINFO_CAP_HAS_MTIME);
+		if (version == 4) {
+			fsinfo_set_cap(caps, FSINFO_CAP_LEASES);
+			fsinfo_set_cap(caps, FSINFO_CAP_IVER_ALL_CHANGE);
+		}
+		return sizeof(*caps);
+
+	case FSINFO_ATTR_SERVER_NAME:
+		if (params->Nth || params->Mth)
+			return -ENODATA;
+		str = client->cl_hostname;
+		goto string;
+
+	case FSINFO_ATTR_SERVER_ADDRESS:
+		if (params->Nth || params->Mth)
+			return -ENODATA;
+		addr = params->buffer;
+		clnt = client->cl_rpcclient;
+		rcu_read_lock();
+		xprt = rcu_dereference(clnt->cl_xprt);
+		memcpy(&addr->address, &xprt->addr, xprt->addrlen);
+		rcu_read_unlock();
+		return sizeof(*addr);
+
+	case FSINFO_ATTR_PARAMETERS:
+		return nfs_fsinfo_parameters(params, path, server);
+
+	default:
+		return generic_fsinfo(path, params);
+	}
+
+string:
+	if (!str)
+		return 0;
+	strcpy(params->buffer, str);
+	return strlen(params->buffer);
+}
+EXPORT_SYMBOL_GPL(nfs_fsinfo);
+#endif /* CONFIG_FSINFO */
+
 /*
  * Map the security flavour number to a name
  */
-static const char *nfs_pseudoflavour_to_name(rpc_authflavor_t flavour)
+const char *nfs_pseudoflavour_to_name(rpc_authflavor_t flavour)
 {
 	static const struct {
 		rpc_authflavor_t flavour;

