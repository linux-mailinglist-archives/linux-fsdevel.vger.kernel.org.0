Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A65B016F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 18:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfIKQSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 12:18:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbfIKQQX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:16:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1034B99C41;
        Wed, 11 Sep 2019 16:16:23 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8D225D9E2;
        Wed, 11 Sep 2019 16:16:22 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 16EB820B4C; Wed, 11 Sep 2019 12:16:22 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/26] nfs: don't bother setting/restoring export_path around do_nfs_root_mount()
Date:   Wed, 11 Sep 2019 12:16:00 -0400
Message-Id: <20190911161621.19832-6-smayhew@redhat.com>
In-Reply-To: <20190911161621.19832-1-smayhew@redhat.com>
References: <20190911161621.19832-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 11 Sep 2019 16:16:23 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

nothing in it will be looking at that thing anyway

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs4super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index d0237d8ffa2b..a0b66f98f6ba 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -233,12 +233,10 @@ struct dentry *nfs4_try_mount(int flags, const char *dev_name,
 	dfprintk(MOUNT, "--> nfs4_try_mount()\n");
 
 	export_path = data->nfs_server.export_path;
-	data->nfs_server.export_path = "/";
 	root_mnt = nfs_do_root_mount(
 			nfs4_create_server(mount_info, &nfs_v4),
 			flags, mount_info,
 			data->nfs_server.hostname);
-	data->nfs_server.export_path = export_path;
 
 	res = nfs_follow_remote_path(root_mnt, export_path);
 
@@ -271,12 +269,10 @@ static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
 		return ERR_PTR(-ENOMEM);
 
 	export_path = data->mnt_path;
-	data->mnt_path = "/";
 	root_mnt = nfs_do_root_mount(
 			nfs4_create_referral_server(mount_info.cloned,
 						    mount_info.mntfh),
 			flags, &mount_info, data->hostname);
-	data->mnt_path = export_path;
 
 	res = nfs_follow_remote_path(root_mnt, export_path);
 	dprintk("<-- nfs4_referral_mount() = %d%s\n",
-- 
2.17.2

