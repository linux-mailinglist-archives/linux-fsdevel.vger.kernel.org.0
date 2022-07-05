Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DAB566579
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 10:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiGEIxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 04:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGEIxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:53:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB99DFBA;
        Tue,  5 Jul 2022 01:53:42 -0700 (PDT)
X-UUID: 2fc1557c25e24d2ab808217b4c3bfd4e-20220705
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:fbf722cf-dcd6-4065-a886-96046fa1fc3e,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:a09ca5d6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 2fc1557c25e24d2ab808217b4c3bfd4e-20220705
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1710000726; Tue, 05 Jul 2022 16:53:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 5 Jul 2022 16:53:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jul 2022 16:53:35 +0800
From:   Ed Tsai <ed.tsai@mediatek.com>
To:     <miklos@szeredi.hu>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <fuse-devel@lists.sourceforge.net>, <chenguanyou9338@gmail.com>,
        <stanley.chu@mediatek.com>, <Yong-xuan.Wang@mediatek.com>,
        <wsd_upstream@mediatek.com>, Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH 1/1] fuse: add fuse_d_iput to postponed the iput
Date:   Tue, 5 Jul 2022 16:53:08 +0800
Message-ID: <20220705085308.32518-1-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <490be4e0b984e146c93586507442de3dad8694bb.camel@mediatek.com>
References: <490be4e0b984e146c93586507442de3dad8694bb.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When all the references of an inode are dropped, and write of its dirty
pages is serving in Daemon, reclaim may deadlock on a regular allocation
in Daemon.

Add fuse_dentry_iput and some FI_* flags to postponed the iput for the
inodes be using in fuse_write_inode.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
---
Hi Miklos,
I define d_iput for fuse to postpone the iput until the fuse_write_inode
is done. This works fine at our platform. Please help to check this.

 fs/fuse/dir.c    | 17 +++++++++++++++++
 fs/fuse/file.c   | 15 +++++++++++++++
 fs/fuse/fuse_i.h |  4 ++++
 3 files changed, 36 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 74303d6e987b..37d768088c87 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -331,6 +331,22 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 	return mnt;
 }
 
+static void fuse_dentry_iput(struct dentry *dentry, struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	int need_iput = true;
+
+	spin_lock(&fi->lock);
+	if (test_bit(FUSE_I_WRITING, &fi->state)) {
+		set_bit(FUSE_I_NEED_IPUT, &fi->state);
+		need_iput = false;
+	}
+	spin_unlock(&fi->lock);
+
+	if (need_iput)
+		iput(inode);
+}
+
 const struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
 	.d_delete	= fuse_dentry_delete,
@@ -339,6 +355,7 @@ const struct dentry_operations fuse_dentry_operations = {
 	.d_release	= fuse_dentry_release,
 #endif
 	.d_automount	= fuse_dentry_automount,
+	.d_iput		= fuse_dentry_iput,
 };
 
 const struct dentry_operations fuse_root_dentry_operations = {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 05caa2b9272e..a291784d42bc 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1848,6 +1848,7 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_file *ff;
+	int need_iput = false;
 	int err;
 
 	/*
@@ -1862,10 +1863,24 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 	WARN_ON(wbc->for_reclaim);
 
 	ff = __fuse_write_file_get(fi);
+
+	spin_lock(&fi->lock);
+	set_bit(FUSE_I_WRITING, &fi->state);
+	spin_unlock(&fi->lock);
+
 	err = fuse_flush_times(inode, ff);
 	if (ff)
 		fuse_file_put(ff, false, false);
 
+	spin_lock(&fi->lock);
+	clear_bit(FUSE_I_WRITING, &fi->state);
+	if (test_and_clear_bit(FUSE_I_NEED_IPUT, &fi->state))
+		need_iput = true;
+	spin_unlock(&fi->lock);
+
+	if (need_iput)
+		iput(inode);
+
 	return err;
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 488b460e046f..f5851e5397ce 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -167,6 +167,10 @@ enum {
 	FUSE_I_SIZE_UNSTABLE,
 	/* Bad inode */
 	FUSE_I_BAD,
+	/* inode is writing */
+	FUSE_I_WRITING,
+	/* inode need iput() after writing */
+	FUSE_I_NEED_IPUT,
 };
 
 struct fuse_conn;
-- 
2.18.0

