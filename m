Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08C76A64F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 02:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCABuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 20:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCABug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:50:36 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD86D193E4
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 17:50:35 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id ff4so8305100qvb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 17:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112; t=1677635435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mcrDBIGtrTEDjzonWUNUAc4MXuRWYEApdBnj/prlZpU=;
        b=dDKs5CP907SyA/Bjl9QDsBGZ56nJyMPapGC8bBkngXXKV1sqgR27+HEkCACRSCaOLl
         vLHnnYCcap/MfQncsNX7nqNofY9v49OyxdDsfwIE6LLSzmDCIpX8tNjBgM7wCd6ZBBjG
         92Xvh11XoHf0jiIbyL+CcMt++wiEAXwEph+dDblB0/3r0CuJ7n3E4U9XvRP47Yg9Q74o
         nSpWC690N+qR//1QyrR58O/7PNRJsuAYpiiqkCQTCihzM+i7RoiKGTIjMe2kBKBmvOQt
         JdoHVszfYpgUSAfwRN0LLNVztjr+MOfYHS0rADQ0TPR0lkgOQoQgaINpKmeJGV02/bzN
         ANEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677635435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcrDBIGtrTEDjzonWUNUAc4MXuRWYEApdBnj/prlZpU=;
        b=CmG6cBKyDqlittYxdd6Co849MKIp8a7T0r0wlXb2PWv5LkrsxKL13GbKI94vrGtWIy
         +KJx+PoB7E7gvRFrnHkGhLT/8hFGBlJq51zd8b9ybaRszMssi0vz54PkkOJ+D3lkNRyz
         0+Tv/4clUkbI3zUr5HBSrhkqWCPLtfuS2mkifaL9DjcrkgZx+gzcA1nDQLv1gLwKpjiv
         +Vk95d0YNt7OUNR8GQrCd9SoDCIPrFaYVeZL/8TjG6IiZWmefuR1kSyxMDGitx2onSSW
         k70otlGQFAh5TLQETp12kPuOAmVbmJXxEVATom0qSXxqB4nDo5ygxBFi4u86eXH8efDX
         tJ4w==
X-Gm-Message-State: AO0yUKU1xgoQgNmR43sj4TCY51JMh7yILOecWAZPqgw4uQaPoWPf+bn/
        /a/UyyWM7L3FaJ/jAC00/qeGCA==
X-Google-Smtp-Source: AK7set9a/p6WWFIvBuX9pL8jdiOxPQ2UPXugNGMeAAUTu0K6mSLmk0zzIXFguEf4CPa4Hbqn9ECGyA==
X-Received: by 2002:a05:6214:c43:b0:56e:9ab5:cd9f with SMTP id r3-20020a0562140c4300b0056e9ab5cd9fmr8229751qvj.39.1677635434870;
        Tue, 28 Feb 2023 17:50:34 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id d184-20020a37b4c1000000b0073b69922cfesm7750267qkf.85.2023.02.28.17.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 17:50:34 -0800 (PST)
From:   Glenn Washburn <development@efficientek.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Cc:     Glenn Washburn <development@efficientek.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v2] hostfs: handle idmapped mounts
Date:   Tue, 28 Feb 2023 19:50:02 -0600
Message-Id: <20230301015002.2402544-1-development@efficientek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let hostfs handle idmapped mounts. This allows to have the same hostfs
mount appear in multiple locations with different id mappings.

root@(none):/media# id
uid=0(root) gid=0(root) groups=0(root)
root@(none):/media# mkdir mnt idmapped
root@(none):/media# mount -thostfs -o/home/user hostfs mnt

root@(none):/media# touch mnt/aaa
root@(none):/media# mount-idmapped --map-mount u:`id -u user`:0:1 --map-mount g:`id -g user`:0:1 /media/mnt /media/idmapped
root@(none):/media# ls -l mnt/aaa idmapped/aaa
-rw-r--r-- 1 root root 0 Jan 28 01:23 idmapped/aaa
-rw-r--r-- 1 user user 0 Jan 28 01:23 mnt/aaa

root@(none):/media# touch idmapped/bbb
root@(none):/media# ls -l mnt/bbb idmapped/bbb
-rw-r--r-- 1 root root 0 Jan 28 01:26 idmapped/bbb
-rw-r--r-- 1 user user 0 Jan 28 01:26 mnt/bbb

Signed-off-by: Glenn Washburn <development@efficientek.com>
---
Changes from v1:
 * Rebase on to tip. The above commands work and have the results expected.
   The __vfsuid_val(make_vfsuid(...)) seems ugly to get the uid_t, but it
   seemed like the best one I've come across. Is there a better way?

Glenn
---
 fs/hostfs/hostfs_kern.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index c18bb50c31b6..9459da99a0db 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -786,7 +786,7 @@ static int hostfs_permission(struct mnt_idmap *idmap,
 		err = access_file(name, r, w, x);
 	__putname(name);
 	if (!err)
-		err = generic_permission(&nop_mnt_idmap, ino, desired);
+		err = generic_permission(idmap, ino, desired);
 	return err;
 }
 
@@ -794,13 +794,14 @@ static int hostfs_setattr(struct mnt_idmap *idmap,
 			  struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
+	struct user_namespace *fs_userns = i_user_ns(inode);
 	struct hostfs_iattr attrs;
 	char *name;
 	int err;
 
 	int fd = HOSTFS_I(inode)->fd;
 
-	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
 		return err;
 
@@ -814,11 +815,11 @@ static int hostfs_setattr(struct mnt_idmap *idmap,
 	}
 	if (attr->ia_valid & ATTR_UID) {
 		attrs.ia_valid |= HOSTFS_ATTR_UID;
-		attrs.ia_uid = from_kuid(&init_user_ns, attr->ia_uid);
+		attrs.ia_uid = __vfsuid_val(make_vfsuid(idmap, fs_userns, attr->ia_uid));
 	}
 	if (attr->ia_valid & ATTR_GID) {
 		attrs.ia_valid |= HOSTFS_ATTR_GID;
-		attrs.ia_gid = from_kgid(&init_user_ns, attr->ia_gid);
+		attrs.ia_gid = __vfsgid_val(make_vfsgid(idmap, fs_userns, attr->ia_gid));
 	}
 	if (attr->ia_valid & ATTR_SIZE) {
 		attrs.ia_valid |= HOSTFS_ATTR_SIZE;
@@ -857,7 +858,7 @@ static int hostfs_setattr(struct mnt_idmap *idmap,
 	    attr->ia_size != i_size_read(inode))
 		truncate_setsize(inode, attr->ia_size);
 
-	setattr_copy(&nop_mnt_idmap, inode, attr);
+	setattr_copy(idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
@@ -991,7 +992,7 @@ static struct file_system_type hostfs_type = {
 	.name 		= "hostfs",
 	.mount	 	= hostfs_read_sb,
 	.kill_sb	= hostfs_kill_sb,
-	.fs_flags 	= 0,
+	.fs_flags 	= FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("hostfs");
 

base-commit: 7fa08de735e41001a70c8ca869b2b159d74c2339
-- 
2.30.2

