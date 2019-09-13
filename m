Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3F6B1D34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbfIMMR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 08:17:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387523AbfIMMRv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:17:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D0AE8AC6FD;
        Fri, 13 Sep 2019 12:17:51 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B11A5D9E1;
        Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 3752120F44; Fri, 13 Sep 2019 08:17:49 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 26/26] NFS: Attach supplementary error information to fs_context.
Date:   Fri, 13 Sep 2019 08:17:48 -0400
Message-Id: <20190913121748.25391-27-smayhew@redhat.com>
In-Reply-To: <20190913121748.25391-1-smayhew@redhat.com>
References: <20190913121748.25391-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 13 Sep 2019 12:17:51 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split out from commit "NFS: Add fs_context support."

Add wrappers nfs_errorf(), nfs_invalf(), and nfs_warnf() which log error
information to the fs_context.  Convert some printk's to use these new
wrappers instead.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/fs_context.c | 105 +++++++++++++++-----------------------------
 fs/nfs/getroot.c    |   3 ++
 fs/nfs/internal.h   |   4 ++
 fs/nfs/namespace.c  |   2 +-
 fs/nfs/nfs4super.c  |   2 +
 fs/nfs/super.c      |   4 +-
 6 files changed, 48 insertions(+), 72 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 0bf346cdea18..c0c661aea27d 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -318,10 +318,8 @@ static int nfs_auth_info_add(struct fs_context *fc,
 			return 0;
 	}
 
-	if (auth_info->flavor_len + 1 >= max_flavor_len) {
-		dfprintk(MOUNT, "NFS: too many sec= flavors\n");
-		return -EINVAL;
-	}
+	if (auth_info->flavor_len + 1 >= max_flavor_len)
+		return nfs_invalf(fc, "NFS: too many sec= flavors");
 
 	auth_info->flavors[auth_info->flavor_len++] = flavor;
 	return 0;
@@ -378,9 +376,7 @@ static int nfs_parse_security_flavors(struct fs_context *fc,
 			pseudoflavor = RPC_AUTH_GSS_SPKMP;
 			break;
 		default:
-			dfprintk(MOUNT,
-				 "NFS: sec= option '%s' not recognized\n", p);
-			return -EINVAL;
+			return nfs_invalf(fc, "NFS: sec=%s option not recognized", p);
 		}
 
 		ret = nfs_auth_info_add(fc, &ctx->auth_info, pseudoflavor);
@@ -425,8 +421,7 @@ static int nfs_parse_version_string(struct fs_context *fc,
 		ctx->minorversion = 2;
 		break;
 	default:
-		dfprintk(MOUNT, "NFS:   Unsupported NFS version\n");
-		return -EINVAL;
+		return nfs_invalf(fc, "NFS: Unsupported NFS version");
 	}
 	return 0;
 }
@@ -451,10 +446,8 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 
 	switch (opt) {
 	case Opt_source:
-		if (fc->source) {
-			dfprintk(MOUNT, "NFS: Multiple sources not supported\n");
-			return -EINVAL;
-		}
+		if (fc->source)
+			return nfs_invalf(fc, "NFS: Multiple sources not supported");
 		fc->source = param->string;
 		param->string = NULL;
 		break;
@@ -664,8 +657,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 			xprt_load_transport(param->string);
 			break;
 		default:
-			dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
-			return -EINVAL;
+			return nfs_invalf(fc, "NFS: Unrecognized transport protocol");
 		}
 
 		ctx->protofamily = protofamily;
@@ -688,8 +680,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 			break;
 		case Opt_xprt_rdma: /* not used for side protocols */
 		default:
-			dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
-			return -EINVAL;
+			return nfs_invalf(fc, "NFS: Unrecognized transport protocol");
 		}
 		ctx->mountfamily = mountfamily;
 		break;
@@ -774,13 +765,11 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 	return 0;
 
 out_invalid_value:
-	printk(KERN_INFO "NFS: Bad mount option value specified\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: Bad mount option value specified");
 out_invalid_address:
-	printk(KERN_INFO "NFS: Bad IP address specified\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: Bad IP address specified");
 out_of_bounds:
-	printk(KERN_INFO "NFS: Value for '%s' out of range\n", param->key);
+	nfs_invalf(fc, "NFS: Value for '%s' out of range", param->key);
 	return -ERANGE;
 }
 
@@ -846,19 +835,15 @@ static int nfs_parse_source(struct fs_context *fc,
 	return 0;
 
 out_bad_devname:
-	dfprintk(MOUNT, "NFS: device name not in host:path format\n");
-	return -EINVAL;
-
+	return nfs_invalf(fc, "NFS: device name not in host:path format");
 out_nomem:
-	dfprintk(MOUNT, "NFS: not enough memory to parse device name\n");
+	nfs_errorf(fc, "NFS: not enough memory to parse device name");
 	return -ENOMEM;
-
 out_hostname:
-	dfprintk(MOUNT, "NFS: server hostname too long\n");
+	nfs_errorf(fc, "NFS: server hostname too long");
 	return -ENAMETOOLONG;
-
 out_path:
-	dfprintk(MOUNT, "NFS: export pathname too long\n");
+	nfs_errorf(fc, "NFS: export pathname too long");
 	return -ENAMETOOLONG;
 }
 
@@ -1015,29 +1000,23 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 		ctx->skip_reconfig_option_check = true;
 		return 0;
 	}
-	dfprintk(MOUNT, "NFS: mount program didn't pass any mount data\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: mount program didn't pass any mount data");
 
 out_no_v3:
-	dfprintk(MOUNT, "NFS: nfs_mount_data version %d does not support v3\n",
-		 data->version);
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: nfs_mount_data version does not support v3");
 
 out_no_sec:
-	dfprintk(MOUNT, "NFS: nfs_mount_data version supports only AUTH_SYS\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: nfs_mount_data version supports only AUTH_SYS");
 
 out_nomem:
-	dfprintk(MOUNT, "NFS: not enough memory to handle mount options\n");
+	dfprintk(MOUNT, "NFS: not enough memory to handle mount options");
 	return -ENOMEM;
 
 out_no_address:
-	dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: mount program didn't pass remote address");
 
 out_invalid_fh:
-	dfprintk(MOUNT, "NFS: invalid root filehandle\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: invalid root filehandle");
 }
 
 #if IS_ENABLED(CONFIG_NFS_V4)
@@ -1132,21 +1111,17 @@ static int nfs4_parse_monolithic(struct fs_context *fc,
 		ctx->skip_reconfig_option_check = true;
 		return 0;
 	}
-	dfprintk(MOUNT, "NFS4: mount program didn't pass any mount data\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS4: mount program didn't pass any mount data");
 
 out_inval_auth:
-	dfprintk(MOUNT, "NFS4: Invalid number of RPC auth flavours %d\n",
-		 data->auth_flavourlen);
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS4: Invalid number of RPC auth flavours %d",
+		      data->auth_flavourlen);
 
 out_no_address:
-	dfprintk(MOUNT, "NFS4: mount program didn't pass remote address\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS4: mount program didn't pass remote address");
 
 out_invalid_transport_udp:
-	dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFSv4: Unsupported transport protocol udp");
 }
 #endif
 
@@ -1164,8 +1139,7 @@ static int nfs_fs_context_parse_monolithic(struct fs_context *fc,
 		return nfs4_parse_monolithic(fc, data);
 #endif
 
-	dfprintk(MOUNT, "NFS: Unsupported monolithic data version\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: Unsupported monolithic data version");
 }
 
 /*
@@ -1253,32 +1227,25 @@ static int nfs_fs_context_validate(struct fs_context *fc)
 	return 0;
 
 out_no_device_name:
-	dfprintk(MOUNT, "NFS: Device name not specified\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: Device name not specified");
 out_v4_not_compiled:
-	dfprintk(MOUNT, "NFS: NFSv4 is not compiled into kernel\n");
+	nfs_errorf(fc, "NFS: NFSv4 is not compiled into kernel");
 	return -EPROTONOSUPPORT;
 out_invalid_transport_udp:
-	dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFSv4: Unsupported transport protocol udp");
 out_no_address:
-	dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: mount program didn't pass remote address");
 out_mountproto_mismatch:
-	dfprintk(MOUNT, "NFS: Mount server address does not match mountproto= option\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: Mount server address does not match mountproto= option");
 out_proto_mismatch:
-	dfprintk(MOUNT, "NFS: Server address does not match proto= option\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: Server address does not match proto= option");
 out_minorversion_mismatch:
-	dfprintk(MOUNT, "NFS: Mount option vers=%u does not support minorversion=%u\n",
+	return nfs_invalf(fc, "NFS: Mount option vers=%u does not support minorversion=%u",
 			  ctx->version, ctx->minorversion);
-	return -EINVAL;
 out_migration_misuse:
-	dfprintk(MOUNT, "NFS: 'Migration' not supported for this NFS version\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: 'Migration' not supported for this NFS version");
 out_version_unavailable:
-	dfprintk(MOUNT, "NFS: Version unavailable\n");
+	nfs_errorf(fc, "NFS: Version unavailable");
 	return ret;
 }
 
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index ab45496d23a6..b012c2668a1f 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -86,6 +86,7 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 	error = server->nfs_client->rpc_ops->getroot(server, ctx->mntfh, &fsinfo);
 	if (error < 0) {
 		dprintk("nfs_get_root: getattr error = %d\n", -error);
+		nfs_errorf(fc, "NFS: Couldn't getattr on root");
 		goto out_fattr;
 	}
 
@@ -93,6 +94,7 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 	if (IS_ERR(inode)) {
 		dprintk("nfs_get_root: get root inode failed\n");
 		error = PTR_ERR(inode);
+		nfs_errorf(fc, "NFS: Couldn't get root inode");
 		goto out_fattr;
 	}
 
@@ -108,6 +110,7 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 	if (IS_ERR(root)) {
 		dprintk("nfs_get_root: get root dentry failed\n");
 		error = PTR_ERR(root);
+		nfs_errorf(fc, "NFS: Couldn't get root dentry");
 		goto out_fattr;
 	}
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index e0911815e153..e1f46034814f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -141,6 +141,10 @@ struct nfs_fs_context {
 	} clone_data;
 };
 
+#define nfs_errorf(fc, fmt, ...) errorf(fc, fmt, ## __VA_ARGS__)
+#define nfs_invalf(fc, fmt, ...) invalf(fc, fmt, ## __VA_ARGS__)
+#define nfs_warnf(fc, fmt, ...) warnf(fc, fmt, ## __VA_ARGS__)
+
 static inline struct nfs_fs_context *nfs_fc2context(const struct fs_context *fc)
 {
 	return fc->fs_private;
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 3e566a632215..c1824bc6336b 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -278,7 +278,7 @@ int nfs_do_submount(struct fs_context *fc)
 
 	p = nfs_devname(dentry, buffer, 4096);
 	if (IS_ERR(p)) {
-		dprintk("NFS: Couldn't determine submount pathname\n");
+		nfs_errorf(fc, "NFS: Couldn't determine submount pathname");
 		ret = PTR_ERR(p);
 	} else {
 		ret = vfs_parse_fs_string(fc, "source", p, buffer + 4096 - p);
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 3b27c5e3d781..54e9c54bd08d 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -225,6 +225,7 @@ int nfs4_try_get_tree(struct fs_context *fc)
 			   fc, ctx->nfs_server.hostname,
 			   ctx->nfs_server.export_path);
 	if (err) {
+		nfs_errorf(fc, "NFS4: Couldn't follow remote path");
 		dfprintk(MOUNT, "<-- nfs4_try_get_tree() = %d [error]\n", err);
 	} else {
 		dfprintk(MOUNT, "<-- nfs4_try_get_tree() = 0\n");
@@ -247,6 +248,7 @@ int nfs4_get_referral_tree(struct fs_context *fc)
 			    fc, ctx->nfs_server.hostname,
 			    ctx->nfs_server.export_path);
 	if (err) {
+		nfs_errorf(fc, "NFS4: Couldn't follow remote path");
 		dfprintk(MOUNT, "<-- nfs4_get_referral_tree() = %d [error]\n", err);
 	} else {
 		dfprintk(MOUNT, "<-- nfs4_get_referral_tree() = 0\n");
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 60174a30a91a..2e363cc65688 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1189,7 +1189,7 @@ int nfs_get_tree_common(struct fs_context *fc)
 	fc->s_fs_info = NULL;
 	if (IS_ERR(s)) {
 		error = PTR_ERR(s);
-		dfprintk(MOUNT, "NFS: Couldn't get superblock\n");
+		nfs_errorf(fc, "NFS: Couldn't get superblock");
 		goto out_err_nosb;
 	}
 
@@ -1218,7 +1218,7 @@ int nfs_get_tree_common(struct fs_context *fc)
 
 	error = nfs_get_root(s, fc);
 	if (error < 0) {
-		dfprintk(MOUNT, "NFS: Couldn't get root dentry\n");
+		nfs_errorf(fc, "NFS: Couldn't get root dentry");
 		goto error_splat_super;
 	}
 
-- 
2.17.2

