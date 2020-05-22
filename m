Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D7E1DE27D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 10:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgEVI5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 04:57:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57557 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728368AbgEVI5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 04:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590137849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bP0iqVtM6Px0zA+0+w2xKiJv+MfLMqu9uf18xW+5ad0=;
        b=BlTLlpILTDZWRnEdq6FKGzbSKsVU6o+IjWwFRBKLPNUKa17EylT/q6WrRdjTRWWPpW5svY
        EtacPJ/LnfVpy090i1yBW1NJMoRe/ghmrbo6A6nXWJbwTsESoc/1e+e+snIRDK0xU47QDY
        ngb6TubfDM7Oo8Y2hCCUXXUWphcddDo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-CB146HJvN3SvCkzigF1LWg-1; Fri, 22 May 2020 04:57:27 -0400
X-MC-Unique: CB146HJvN3SvCkzigF1LWg-1
Received: by mail-ej1-f72.google.com with SMTP id u9so4293829ejz.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 01:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bP0iqVtM6Px0zA+0+w2xKiJv+MfLMqu9uf18xW+5ad0=;
        b=lRnuTcDFBtTd8VQ5a3nQlT15Wyww9a7yZCa6RKUNDwz94xtyM2/xLgQ0uZWUwvpox0
         88L7CWQZil3IbjCuuxVy+hmFwT8EyhUulYHEcuq+N6stfK0qLawHt4DwiVZUnK/AbSW1
         V+cbhU6BD4gf52GTcsJzK0FSAZ57Np0ivgrJU8d+0vSjw9rfnRTMeEP8AVKCsbgalbfe
         amH7jFCeT/Y0HhlpNxxCm3lLZ+x0deOTd6xGk4dHdyhTYNofZkBppIGyRu+9fWJn5vKU
         H7Fd+bnBoJ5luRIoW728wzfTnEBv+JcmwtjgILFHCd8KgVA2lZ0Ie2Ukto6OZ2vA3yEf
         FU4Q==
X-Gm-Message-State: AOAM533cxBLDbbddF0u+LJfw6sdPCVNmeLwtl5gK0TpLv111r0xgpw4E
        LvDfVP8B0iaUznO1Sj9+bwkPTVQqPAmY95G+BNGcayiOsMuDKHhRbY+FDEhorSS+LeL0djjH6o9
        nR65AvIEwLyD1vmqIIf6v/3DHZw==
X-Received: by 2002:a17:906:710:: with SMTP id y16mr1189337ejb.97.1590137846287;
        Fri, 22 May 2020 01:57:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvx4ECuzfcO7Yxgs+SJ8eQIQb55bAIoTi0z35gS0XxAWZefQlHs/YisgXSN00cpaSGxqiJkA==
X-Received: by 2002:a17:906:710:: with SMTP id y16mr1189332ejb.97.1590137846052;
        Fri, 22 May 2020 01:57:26 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id h20sm7210041eja.61.2020.05.22.01.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 01:57:25 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-unionfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] ovl: make private mounts longterm
Date:   Fri, 22 May 2020 10:57:23 +0200
Message-Id: <20200522085723.29007-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs is using clone_private_mount() to create internal mounts for
underlying layers.  These are used for operations requiring a path, such as
dentry_open().

Since these private mounts are not in any namespace they are treated as
short term, "detached" mounts and mntput() involves taking the global
mount_lock, which can result in serious cacheline pingpong.

Make these private mounts longterm instead, which trade the penalty on
mntput() for a slightly longer shutdown time due to an added RCU grace
period when putting these mounts.

Introduce a new helper kern_unmount_many() that can take care of multiple
longterm mounts with a single RCU grace period.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c        | 16 ++++++++++++++++
 fs/overlayfs/super.c  | 19 ++++++++++++++-----
 include/linux/mount.h |  2 ++
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a28e4db075ed..5d16d87b6b8b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1879,6 +1879,9 @@ struct vfsmount *clone_private_mount(const struct path *path)
 	if (IS_ERR(new_mnt))
 		return ERR_CAST(new_mnt);
 
+	/* Longterm mount to be removed by kern_unmount*() */
+	new_mnt->mnt_ns = MNT_NS_INTERNAL;
+
 	return &new_mnt->mnt;
 }
 EXPORT_SYMBOL_GPL(clone_private_mount);
@@ -3804,6 +3807,19 @@ void kern_unmount(struct vfsmount *mnt)
 }
 EXPORT_SYMBOL(kern_unmount);
 
+void kern_unmount_many(struct vfsmount *mnt[], unsigned int num)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++)
+		if (mnt[i])
+			real_mount(mnt[i])->mnt_ns = NULL;
+	synchronize_rcu_expedited();
+	for (i = 0; i < num; i++)
+		mntput(mnt[i]);
+}
+EXPORT_SYMBOL(kern_unmount_many);
+
 bool our_mnt(struct vfsmount *mnt)
 {
 	return check_mnt(real_mount(mnt));
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 60dfb27bc12b..a938dd2521b2 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -225,12 +225,21 @@ static void ovl_free_fs(struct ovl_fs *ofs)
 	dput(ofs->workbasedir);
 	if (ofs->upperdir_locked)
 		ovl_inuse_unlock(ofs->upper_mnt->mnt_root);
-	mntput(ofs->upper_mnt);
-	for (i = 1; i < ofs->numlayer; i++) {
-		iput(ofs->layers[i].trap);
-		mntput(ofs->layers[i].mnt);
+
+	if (!ofs->layers) {
+		/* Deal with partial setup */
+		kern_unmount(ofs->upper_mnt);
+	} else {
+		/* Hack!  Reuse ofs->layers as a mounts array */
+		struct vfsmount **mounts = (struct vfsmount **) ofs->layers;
+
+		for (i = 0; i < ofs->numlayer; i++) {
+			iput(ofs->layers[i].trap);
+			mounts[i] = ofs->layers[i].mnt;
+		}
+		kern_unmount_many(mounts, ofs->numlayer);
+		kfree(ofs->layers);
 	}
-	kfree(ofs->layers);
 	for (i = 0; i < ofs->numfs; i++)
 		free_anon_bdev(ofs->fs[i].pseudo_dev);
 	kfree(ofs->fs);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index bf8cc4108b8f..e3e994bfcecb 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -109,4 +109,6 @@ extern unsigned int sysctl_mount_max;
 
 extern bool path_is_mountpoint(const struct path *path);
 
+extern void kern_unmount_many(struct vfsmount *mnt[], unsigned int num);
+
 #endif /* _LINUX_MOUNT_H */
-- 
2.21.1

