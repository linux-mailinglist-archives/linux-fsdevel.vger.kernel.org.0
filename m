Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5484B7B4AD8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjJBChQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjJBChP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:37:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FC9C9
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+qRw2nig3APcRxOSe394947Vm6w5yWReQ0ggdVYj3xA=; b=uA44cOVCuiHmIhoWPPIJwrAgeG
        VehtUOPWTC+Vkbqt8BJinaG7VnvGv3D1BgZEheAHUrkw+AMgpWaFuAHm599AILmROC+Z7n2vLJNVg
        Xam224y9QIdlkC8SXeAFYB2GDyo6ESKxxHxZWvXvRRqerf9HmfbJkrx6CdU1AmRn85cdj7I5++y3e
        jyTuQbTUV3ccliXLckGtGBmTZMxjLl94B3+kiF1wvKpsPzceWCKvMJHT82Y9uWhUQTBMHAqg6igde
        Zb56D7MbOdYf//sHcrvft2djsXCPpKmXOiP0ZmX8k9bpdkiPumQGlAJTwqx8FpGNjYRONz1wMEXN2
        A2bt5A5Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8o3-00EE0M-0r;
        Mon, 02 Oct 2023 02:37:11 +0000
Date:   Mon, 2 Oct 2023 03:37:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 15/15] overlayfs: make use of ->layers safe in rcu pathwalk
Message-ID: <20231002023711.GP3389589@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
 <20231002023613.GN3389589@ZenIV>
 <20231002023643.GO3389589@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002023643.GO3389589@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ovl_permission() accesses ->layers[...].mnt; we can't have ->layers
freed without an RCU delay on fs shutdown.  Fortunately, kern_unmount_array()
used to drop those mounts does include an RCU delay, so freeing is
delayed; unfortunately, the array passed to kern_unmount_array() is
formed by mangling ->layers contents and that happens without any
delays.

Use a separate array instead; local if we have a few layers,
kmalloc'ed if there's a lot of them.  If allocation fails,
fall back to kern_unmount() for individual mounts; it's
not a fast path by any stretch of imagination.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/ovl_entry.h |  1 -
 fs/overlayfs/params.c    | 26 ++++++++++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index e9539f98e86a..618b63bb7987 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -30,7 +30,6 @@ struct ovl_sb {
 };
 
 struct ovl_layer {
-	/* ovl_free_fs() relies on @mnt being the first member! */
 	struct vfsmount *mnt;
 	/* Trap in ovl inode cache */
 	struct inode *trap;
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index b9355bb6d75a..ab594fd407b4 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -738,8 +738,15 @@ int ovl_init_fs_context(struct fs_context *fc)
 void ovl_free_fs(struct ovl_fs *ofs)
 {
 	struct vfsmount **mounts;
+	struct vfsmount *m[16];
+	unsigned n = ofs->numlayer;
 	unsigned i;
 
+	if (n > 16)
+		mounts = kmalloc_array(n, sizeof(struct mount *), GFP_KERNEL);
+	else
+		mounts = m;
+
 	iput(ofs->workbasedir_trap);
 	iput(ofs->indexdir_trap);
 	iput(ofs->workdir_trap);
@@ -752,14 +759,21 @@ void ovl_free_fs(struct ovl_fs *ofs)
 	if (ofs->upperdir_locked)
 		ovl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root);
 
-	/* Hack!  Reuse ofs->layers as a vfsmount array before freeing it */
-	mounts = (struct vfsmount **) ofs->layers;
-	for (i = 0; i < ofs->numlayer; i++) {
+	for (i = 0; i < n; i++) {
 		iput(ofs->layers[i].trap);
-		mounts[i] = ofs->layers[i].mnt;
-		kfree(ofs->layers[i].name);
+		if (unlikely(!mounts))
+			kern_unmount(ofs->layers[i].mnt);
+		else
+			mounts[i] = ofs->layers[i].mnt;
 	}
-	kern_unmount_array(mounts, ofs->numlayer);
+	if (mounts) {
+		kern_unmount_array(mounts, n);
+		if (mounts != m)
+			kfree(mounts);
+	}
+	// by this point we had an RCU delay from kern_unmount{_array,}()
+	for (i = 0; i < n; i++)
+		kfree(ofs->layers[i].name);
 	kfree(ofs->layers);
 	for (i = 0; i < ofs->numfs; i++)
 		free_anon_bdev(ofs->fs[i].pseudo_dev);
-- 
2.39.2

