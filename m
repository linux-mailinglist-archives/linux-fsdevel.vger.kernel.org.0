Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0748C5EC217
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 14:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiI0MJM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiI0MJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:09:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDE7A8302
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 05:09:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lc7so20343400ejb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 05:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=k07p0rf0vkA3gAMEm4COhp2yO1grpwLyq/HgUM2N6qY=;
        b=EPGbeF9gmDZS2nP9x/LMlRQge6IdIpxC2sP93nfMuVwIZq2ePHbzWIRkp1OIzeeHT9
         D6aULyed6qPZihmernkcntzYKgbu5nxLqrV4yoy9gROUd3QKMQ1fsUw+XEQPWcxW58oY
         jZL1fYGZF/rQ+CcuWB/Tl/s4Hz4unvYKLTrz5eLjx8OHGOKtWhyvqZyb0ofvtytbrQkJ
         HMLZL7/+ZD/FD+ZkwhAIIVaL0x2zymdIVyOEuWWlyD774HAZ4wRe6N3aQkM7JZxQm2QV
         slKkuZKqOZ3HshfdtMmfXiYyguZTOm3N8BXmtH157u1JtdNeupPe3M+Lwoa1DY51n2bX
         W8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=k07p0rf0vkA3gAMEm4COhp2yO1grpwLyq/HgUM2N6qY=;
        b=nxRrqfARAGf2/jzNUiqb7H5AIj8NrIU7A2ZbHc/AhwN05IVGHQ9r2MwzGGPVyp6C6b
         00AqsObbJpEHjt0gGvNn9VAsD2dsaTDUTf6NqD4lixNisevsXW1sVPsH+7tmgoiD0B4u
         c7qUMU8zp2N6F6o2pG3n9NzUy/681LuOndopEo4xNbEWVXw+El+0Xjn9aq2jE2818T3S
         mOPGLIcbQ6BMmBEaxCQTDzMsZkbSeCERfpaAAgmXZwxdJISM0+btMh4yIXCwUS7s/FmG
         eCaGum8TbXSQbiA25xX5YgYcjan45HWZU9ETWLIhsTn67GBOm0rYu+7wfSXuK3/wqzGj
         5MeA==
X-Gm-Message-State: ACrzQf3grLtlO1EnSxRag4ylCfnvz5W+OhFuv1ZF5TPTyI2gRafaAgMV
        y7Of0doBUDMYi8vL2fNPXg6Mew==
X-Google-Smtp-Source: AMsMyM6b6/kkAN9mo9OPtDRwtTEWRbYu/iQFFoGizn3BOKZzOMO8GaLBqZzYWJkaiwlLNEMeO8heLg==
X-Received: by 2002:a17:907:da9:b0:783:a3b4:2cff with SMTP id go41-20020a1709070da900b00783a3b42cffmr7308324ejc.51.1664280546378;
        Tue, 27 Sep 2022 05:09:06 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f0da700529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f0d:a700:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id ne13-20020a1709077b8d00b0073dc4385d3bsm726827ejc.105.2022.09.27.05.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 05:09:06 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     xiubli@redhat.com, idryomov@gmail.com, jlayton@kernel.org,
        ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/ceph/super: add mount options "snapdir{mode,uid,gid}"
Date:   Tue, 27 Sep 2022 14:08:57 +0200
Message-Id: <20220927120857.639461-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By default, the ".snap" directory inherits the parent's permissions
and ownership, which allows all users to create new cephfs snapshots
in arbitrary directories they have write access on.

In some environments, giving everybody this capability is not
desirable, but there is currently no way to disallow only some users
to create snapshots.  It is only possible to revoke the permission to
the whole client (i.e. all users on the computer which mounts the
cephfs).

This patch allows overriding the permissions and ownership of all
virtual ".snap" directories in a cephfs mount, which allows
restricting (read and write) access to snapshots.

For example, the mount options:

 snapdirmode=0751,snapdiruid=0,snapdirgid=4

... allows only user "root" to create or delete snapshots, and group
"adm" (gid=4) is allowed to get a list of snapshots.  All others are
allowed to read the contents of existing snapshots (if they know the
name).

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/inode.c |  7 ++++---
 fs/ceph/super.c | 33 +++++++++++++++++++++++++++++++++
 fs/ceph/super.h |  4 ++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 56c53ab3618e..0e9388af2821 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -80,6 +80,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	};
 	struct inode *inode = ceph_get_inode(parent->i_sb, vino);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_mount_options *const fsopt = ceph_inode_to_client(parent)->mount_options;
 
 	if (IS_ERR(inode))
 		return inode;
@@ -96,9 +97,9 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 		goto err;
 	}
 
-	inode->i_mode = parent->i_mode;
-	inode->i_uid = parent->i_uid;
-	inode->i_gid = parent->i_gid;
+	inode->i_mode = fsopt->snapdir_mode == (umode_t)-1 ? parent->i_mode : fsopt->snapdir_mode;
+	inode->i_uid = uid_eq(fsopt->snapdir_uid, INVALID_UID) ? parent->i_uid : fsopt->snapdir_uid;
+	inode->i_gid = gid_eq(fsopt->snapdir_gid, INVALID_GID) ? parent->i_gid : fsopt->snapdir_gid;
 	inode->i_mtime = parent->i_mtime;
 	inode->i_ctime = parent->i_ctime;
 	inode->i_atime = parent->i_atime;
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 40140805bdcf..5e5713946f7b 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -143,6 +143,9 @@ enum {
 	Opt_readdir_max_entries,
 	Opt_readdir_max_bytes,
 	Opt_congestion_kb,
+	Opt_snapdirmode,
+	Opt_snapdiruid,
+	Opt_snapdirgid,
 	/* int args above */
 	Opt_snapdirname,
 	Opt_mds_namespace,
@@ -200,6 +203,9 @@ static const struct fs_parameter_spec ceph_mount_parameters[] = {
 	fsparam_flag_no ("require_active_mds",		Opt_require_active_mds),
 	fsparam_u32	("rsize",			Opt_rsize),
 	fsparam_string	("snapdirname",			Opt_snapdirname),
+	fsparam_u32oct	("snapdirmode",			Opt_snapdirmode),
+	fsparam_u32	("snapdiruid",			Opt_snapdiruid),
+	fsparam_u32	("snapdirgid",			Opt_snapdirgid),
 	fsparam_string	("source",			Opt_source),
 	fsparam_string	("mon_addr",			Opt_mon_addr),
 	fsparam_u32	("wsize",			Opt_wsize),
@@ -414,6 +420,22 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 		fsopt->snapdir_name = param->string;
 		param->string = NULL;
 		break;
+	case Opt_snapdirmode:
+		fsopt->snapdir_mode = result.uint_32;
+		if (fsopt->snapdir_mode & ~0777)
+			return invalfc(fc, "Invalid snapdirmode");
+		fsopt->snapdir_mode |= S_IFDIR;
+		break;
+	case Opt_snapdiruid:
+		fsopt->snapdir_uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(fsopt->snapdir_uid))
+			return invalfc(fc, "Invalid snapdiruid");
+		break;
+	case Opt_snapdirgid:
+		fsopt->snapdir_gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(fsopt->snapdir_gid))
+			return invalfc(fc, "Invalid snapdirgid");
+		break;
 	case Opt_mds_namespace:
 		if (!namespace_equals(fsopt, param->string, strlen(param->string)))
 			return invalfc(fc, "Mismatching mds_namespace");
@@ -734,6 +756,14 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",readdir_max_bytes=%u", fsopt->max_readdir_bytes);
 	if (strcmp(fsopt->snapdir_name, CEPH_SNAPDIRNAME_DEFAULT))
 		seq_show_option(m, "snapdirname", fsopt->snapdir_name);
+	if (fsopt->snapdir_mode != (umode_t)-1)
+		seq_printf(m, ",snapdirmode=%o", fsopt->snapdir_mode);
+	if (!uid_eq(fsopt->snapdir_uid, INVALID_UID))
+		seq_printf(m, ",snapdiruid=%o",
+			   from_kuid_munged(&init_user_ns, fsopt->snapdir_uid));
+	if (!gid_eq(fsopt->snapdir_gid, INVALID_GID))
+		seq_printf(m, ",snapdirgid=%o",
+			   from_kgid_munged(&init_user_ns, fsopt->snapdir_gid));
 
 	return 0;
 }
@@ -1335,6 +1365,9 @@ static int ceph_init_fs_context(struct fs_context *fc)
 	fsopt->wsize = CEPH_MAX_WRITE_SIZE;
 	fsopt->rsize = CEPH_MAX_READ_SIZE;
 	fsopt->rasize = CEPH_RASIZE_DEFAULT;
+	fsopt->snapdir_mode = (umode_t)-1;
+	fsopt->snapdir_uid = INVALID_UID;
+	fsopt->snapdir_gid = INVALID_GID;
 	fsopt->snapdir_name = kstrdup(CEPH_SNAPDIRNAME_DEFAULT, GFP_KERNEL);
 	if (!fsopt->snapdir_name)
 		goto nomem;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d44a366b2f1b..3c930816078d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -85,6 +85,10 @@ struct ceph_mount_options {
 	unsigned int max_readdir;       /* max readdir result (entries) */
 	unsigned int max_readdir_bytes; /* max readdir result (bytes) */
 
+	umode_t snapdir_mode;
+	kuid_t snapdir_uid;
+	kgid_t snapdir_gid;
+
 	bool new_dev_syntax;
 
 	/*
-- 
2.35.1

