Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A94FE116BF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfLILKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:10:18 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60126 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLILKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZxpiStDSGhnlOZMQ7E0+3uvZ2a0Fj2rFfFMeV/gs0OM=; b=SaJf24s28GolWadLIIkywHHtXr
        mL9LKpGOW5UHZ8KuaqHh3kq13Ey9Qk06Q5HtDGJgUGcx3O9GcFnXVoOixnjHY48Xbsy+K1a5/58hJ
        lyBJFu7D/vlVHYtBEfyOU28LMag7ZkvZ2ETlzirbunRIpxRb54CBAH29T8CNCAAz4qYyiLwp1YW97
        T0vdNiVi6j9vavJDjwN8s6es1aFDO04vA7X3IvOhju9RESsDOGAgy5FsZmDmigMS7hhNqa/IMmTBh
        KB9AAWZjEcGuUHR/rkyRQA7t4T1n6lHYqN/aJ9MK4am9Zp1yKh17VYMPJLgy2N8Bssb/CYizWcSAE
        XhTGuf8w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49842 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvc-0002Vp-Mr; Mon, 09 Dec 2019 11:10:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvb-0004cC-L0; Mon, 09 Dec 2019 11:10:11 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 23/41] fs/adfs: dir: switch to iterate_shared method
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGvb-0004cC-L0@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:10:11 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is nothing in our readdir (aka iterate) method that relies on
the directory inode being exclusively locked, so switch to using the
iterate_shared() hook rather than iterate().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 931eefb2375b..2a8f5f1fd3d0 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -235,8 +235,7 @@ void adfs_object_fixup(struct adfs_dir *dir, struct object_info *obj)
 	}
 }
 
-static int
-adfs_readdir(struct file *file, struct dir_context *ctx)
+static int adfs_iterate(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
@@ -399,7 +398,7 @@ static int adfs_dir_lookup_byname(struct inode *inode, const struct qstr *qstr,
 const struct file_operations adfs_dir_operations = {
 	.read		= generic_read_dir,
 	.llseek		= generic_file_llseek,
-	.iterate	= adfs_readdir,
+	.iterate_shared	= adfs_iterate,
 	.fsync		= generic_file_fsync,
 };
 
-- 
2.20.1

