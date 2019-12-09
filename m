Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99FB116BCC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfLILIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:08:48 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59994 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfLILIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5JgrPF8PdOfqAGPffV/H9js1qIZk2DRmse9E00F+FXE=; b=meK8lLHL6BFShMw2ELo4BnnAeO
        O6S1heA3n9FAIKVUUXbDKEjbInHU0jA9dmelpXyECvpxNVec71Ne9nQatlrkD8z1I3bWC1TGawxMC
        2kqNnIhiFdbm3ZIEz0d0qihNxcOYHLqgJljdDC6djHjZuyNxDNIIIdV0nCLZ9HlLaMsu0lh6xMVER
        e3X0NAMhRZMgpWacPxkJigqwV5mIcvXN8vJ/uJrrSEjZB9a+npS1fT9fMdTrmzANi9S/Av8Wmpzwv
        h9/me928Ig56jl/+utaKD3bSdmQJW+C9C14ycwRRN2k40ik4CroJpIkKKVmioIGOrZMMb64A7XvJs
        CnqbnHpg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49806 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuC-0002T2-Si; Mon, 09 Dec 2019 11:08:44 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuC-0004aE-B3; Mon, 09 Dec 2019 11:08:44 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/41] fs/adfs: map: factor out map cleanup
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGuC-0004aE-B3@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:08:44 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have several places which deal with releasing the map buffers and
freeing the map array.  Provide a helper for this.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h  |  1 +
 fs/adfs/map.c   |  8 ++++++++
 fs/adfs/super.c | 10 ++--------
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 45fd48fbd5e0..6497da8a2c8a 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -147,6 +147,7 @@ int adfs_notify_change(struct dentry *dentry, struct iattr *attr);
 int adfs_map_lookup(struct super_block *sb, u32 frag_id, unsigned int offset);
 void adfs_map_statfs(struct super_block *sb, struct kstatfs *buf);
 struct adfs_discmap *adfs_read_map(struct super_block *sb, struct adfs_discrecord *dr);
+void adfs_free_map(struct super_block *sb);
 
 /* Misc */
 __printf(3, 4)
diff --git a/fs/adfs/map.c b/fs/adfs/map.c
index 4b677cd5d015..8ba8877110ff 100644
--- a/fs/adfs/map.c
+++ b/fs/adfs/map.c
@@ -421,3 +421,11 @@ struct adfs_discmap *adfs_read_map(struct super_block *sb, struct adfs_discrecor
 	kfree(dm);
 	return ERR_PTR(-EIO);
 }
+
+void adfs_free_map(struct super_block *sb)
+{
+	struct adfs_sb_info *asb = ADFS_SB(sb);
+
+	adfs_map_relse(asb->s_map, asb->s_map_size);
+	kfree(asb->s_map);
+}
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 458824e0ca83..cef16028e9f2 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -90,12 +90,9 @@ static int adfs_checkdiscrecord(struct adfs_discrecord *dr)
 
 static void adfs_put_super(struct super_block *sb)
 {
-	int i;
 	struct adfs_sb_info *asb = ADFS_SB(sb);
 
-	for (i = 0; i < asb->s_map_size; i++)
-		brelse(asb->s_map[i].dm_bh);
-	kfree(asb->s_map);
+	adfs_free_map(sb);
 	kfree_rcu(asb, rcu);
 }
 
@@ -412,10 +409,7 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	root = adfs_iget(sb, &root_obj);
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root) {
-		int i;
-		for (i = 0; i < asb->s_map_size; i++)
-			brelse(asb->s_map[i].dm_bh);
-		kfree(asb->s_map);
+		adfs_free_map(sb);
 		adfs_error(sb, "get root inode failed\n");
 		ret = -EIO;
 		goto error;
-- 
2.20.1

