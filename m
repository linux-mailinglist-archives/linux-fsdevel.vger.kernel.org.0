Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912301FD70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 03:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfEPBq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 21:46:26 -0400
Received: from fieldses.org ([173.255.197.46]:33070 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfEPBUX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 21:20:23 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 580471E67; Wed, 15 May 2019 21:20:23 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 01/12] nfsd: persist nfsd filesystem across mounts
Date:   Wed, 15 May 2019 21:20:07 -0400
Message-Id: <1557969619-17157-3-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557969619-17157-1-git-send-email-bfields@redhat.com>
References: <1557969619-17157-1-git-send-email-bfields@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Keep around one internal mount of the nfsd filesystem so that we can
e.g. add stuff to it when clients come and go, regardless of whether
anyone has it mounted.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/netns.h  |  3 +++
 fs/nfsd/nfsctl.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 32cb8c027483..cce335e1ec98 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -55,6 +55,9 @@ struct nfsd_net {
 	bool grace_ended;
 	time_t boot_time;
 
+	/* internal mount of the "nfsd" pseudofilesystem: */
+	struct vfsmount *nfsd_mnt;
+
 	/*
 	 * reclaim_str_hashtbl[] holds known client info from previous reset/reboot
 	 * used in reboot/reset lease grace period processing
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f2feb2d11bae..8d2062428569 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1231,6 +1231,7 @@ unsigned int nfsd_net_id;
 static __net_init int nfsd_init_net(struct net *net)
 {
 	int retval;
+	struct vfsmount *mnt;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	retval = nfsd_export_init(net);
@@ -1248,8 +1249,17 @@ static __net_init int nfsd_init_net(struct net *net)
 
 	atomic_set(&nn->ntf_refcnt, 0);
 	init_waitqueue_head(&nn->ntf_wq);
+
+	mnt =  vfs_kern_mount(&nfsd_fs_type, SB_KERNMOUNT, "nfsd", NULL);
+	if (IS_ERR(mnt)) {
+		retval = PTR_ERR(mnt);
+		goto out_mount_err;
+	}
+	nn->nfsd_mnt = mnt;
 	return 0;
 
+out_mount_err:
+	nfsd_idmap_shutdown(net);
 out_idmap_error:
 	nfsd_export_shutdown(net);
 out_export_error:
@@ -1258,6 +1268,9 @@ static __net_init int nfsd_init_net(struct net *net)
 
 static __net_exit void nfsd_exit_net(struct net *net)
 {
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	mntput(nn->nfsd_mnt);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
 }
-- 
2.21.0

