Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEC923216E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 17:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgG2PVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2PVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:21:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCE3C061794;
        Wed, 29 Jul 2020 08:21:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f193so2689263pfa.12;
        Wed, 29 Jul 2020 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LB6ErndUimj8juju207fCa8GTUpRDIvvzw5XefrRl1c=;
        b=EP1xsCCPEEIFtVxQaK75SMR9DOTaTU5Xqf14+SYpdODK97SealSgoMdd5kU+RCbRlM
         //yEW98teMCS44q7It6GiuBUaR167hMTMIhGBhLNcgs1nYAftjL1QQB3Q3A+Q/sEusoG
         M1f6ztXdvWxf862We358w6YmIZXbf+/D34AWZ1rr4VRMDBHr4Y+mMTKiWeFI1vpTcdgu
         9oKruz2duTWazN+josrN7rTYH/q/mab5BtFlCyghMVTwYt6pmk/Q969AR0iqlsfJYRcj
         K0vpC67jw+UR3n80Ah97J975jeEhVb003BisXrip4tVeeincFSSIjsaNN5qvsovJiytC
         X7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LB6ErndUimj8juju207fCa8GTUpRDIvvzw5XefrRl1c=;
        b=ZBYtfl9kiBA+oXSnR/Cp/GtFs+51SMo0m68Cv1ZUBVVFqOQnzMClT8DGJou5DDSdLV
         XsXgyLcuTZCZH2MFrtZvWWWpIR7fTyAXDzC0lvlxepN2FUg47JWCy+SeGgkq1afEyySZ
         2mbCFfMTBJe4ICPdjARrkPUH2g9E6pwzJlve7CZgr7UQAbNousl+xQXjAellp/rUH1+g
         gcVfuH2bUY/MlP78ez0jtJ3Tmzy/ZyzC25hLXscRsb2QMHPCcjtg32T+COYZFSR1H0xJ
         kNpi9MD09TQlejurdOuV8AZYZTf6sq3g9w2NP+gtO7wMSE8o3dmJdr3Jl49EAlD25KpA
         TyEg==
X-Gm-Message-State: AOAM530XdR+VJphhzQ+jwKim7tSKEVekF5uxOpNY9UlJFTedttwhi1vq
        nR6ZzhnX4BA9+tAGCfiqpwQ=
X-Google-Smtp-Source: ABdhPJzk83AluJcCY0gxmUiLNglHxpNWtrXlGu0NT+vUGdySnQRA8XfGLWXNWyx2H9JZRkz7hjswpg==
X-Received: by 2002:a62:3895:: with SMTP id f143mr30490860pfa.27.1596036090694;
        Wed, 29 Jul 2020 08:21:30 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id i13sm2494552pjd.33.2020.07.29.08.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:21:30 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:21:28 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        haolee.swjtu@gmail.com
Subject: [PATCH] fs: Eliminate a local variable to make the code more clear
Message-ID: <20200729151740.GA3430@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The dentry local variable is introduced in 'commit 84d17192d2afd ("get
rid of full-hash scan on detaching vfsmounts")' to reduce the length of
some long statements for example
mutex_lock(&path->dentry->d_inode->i_mutex). We have already used
inode_lock(dentry->d_inode) to do the same thing now, and its length is
acceptable. Furthermore, it seems not concise that assign path->dentry
to local variable dentry in the statement before goto. So, this function
would be more clear if we eliminate the local variable dentry.

The function logic is not changed.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 fs/namespace.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 4a0f600a3328..fcb93586fcc9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2187,20 +2187,19 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 static struct mountpoint *lock_mount(struct path *path)
 {
 	struct vfsmount *mnt;
-	struct dentry *dentry = path->dentry;
 retry:
-	inode_lock(dentry->d_inode);
-	if (unlikely(cant_mount(dentry))) {
-		inode_unlock(dentry->d_inode);
+	inode_lock(path->dentry->d_inode);
+	if (unlikely(cant_mount(path->dentry))) {
+		inode_unlock(path->dentry->d_inode);
 		return ERR_PTR(-ENOENT);
 	}
 	namespace_lock();
 	mnt = lookup_mnt(path);
 	if (likely(!mnt)) {
-		struct mountpoint *mp = get_mountpoint(dentry);
+		struct mountpoint *mp = get_mountpoint(path->dentry);
 		if (IS_ERR(mp)) {
 			namespace_unlock();
-			inode_unlock(dentry->d_inode);
+			inode_unlock(path->dentry->d_inode);
 			return mp;
 		}
 		return mp;
@@ -2209,7 +2208,7 @@ static struct mountpoint *lock_mount(struct path *path)
 	inode_unlock(path->dentry->d_inode);
 	path_put(path);
 	path->mnt = mnt;
-	dentry = path->dentry = dget(mnt->mnt_root);
+	path->dentry = dget(mnt->mnt_root);
 	goto retry;
 }
 
-- 
2.24.1

