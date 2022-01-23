Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85284970DB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jan 2022 11:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiAWKEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jan 2022 05:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiAWKEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jan 2022 05:04:52 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACC8C06173B;
        Sun, 23 Jan 2022 02:04:52 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n32so3969876pfv.11;
        Sun, 23 Jan 2022 02:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MscxeP9jVOV6TslkZGhXdbAV5hOvpg7KQ67+Vz0+QMo=;
        b=R6IYRhf0hhPKze9peIoUZLw1K5oGHzKO0XK5dktPb9Edp7WyCHIZVA8Pj/gZP2BYnE
         PaQWAkWgRr+LvIWiNyJHbMIPm2XrOWOGU9evksNgcIf4I4sWw2/VymHjfqAIMnQKk7Or
         UIBmj2/8Makd8PD9hB2hEugZZq9VX0j5UJOA30nGnNz68xj/Ta1ChN/C/gPqn9ekZJZi
         3GVQejNmVhigcPbqhIw24gk4/Gbw7E6N1LdSoai+OuPmFd3e+uMHhA+0l4bM20k2PBeE
         ZSSHq8lQFdWvbjuH9geIT/QzNIcCgtaRWTNGKytKxyVLRd0+Eu5n1ymXbJnW/ZinYhaX
         DSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MscxeP9jVOV6TslkZGhXdbAV5hOvpg7KQ67+Vz0+QMo=;
        b=FnN457AKo5c6NVmrazUh6N5NQQNKVrGI7CgdJDY8Seqc36MjdYfrMKCxGZYsjyG5oH
         ZTJhdj5GRSVwC+Jz3DSiK8Amaup44GweOSth0TB8VwM5cCZijgTJQd1C/hGYED0mQQTg
         oPDFlucCJeXCL54uCjRMMXJ/WT+lKOq4wFDDSGYGAIcGkQeqO0yxiI/SW129v/+oNuYN
         AeOzTH2OqWX+UN/elCte2XWUKhHOo9R19bbbVV+jCd2pwawTCVF0mT1Es4w0IhXtfFh1
         I6WFKFEjP44wrYGdP6ABI+U0MeFHMcy8BcJbDlsg7hcM7YXJZ5HzSLU9wsuyASlVRlGL
         qF9g==
X-Gm-Message-State: AOAM5326h0hNsaY+8ZJ5ELxOrMuroDwQdJYH6VftLhfXjJBbF3OwLpog
        nkvsdUt4fUD+gjkxtqwzgbs/W5vPA/8=
X-Google-Smtp-Source: ABdhPJzrK8EKCJCB7oh1K3hVnKM531t5nD+Uzy+9rYUgghlEjDduIY+IofPig/s0HXE9Autioj3Y9A==
X-Received: by 2002:aa7:91d1:0:b0:4c0:27ac:4d6b with SMTP id z17-20020aa791d1000000b004c027ac4d6bmr9729667pfa.85.1642932291577;
        Sun, 23 Jan 2022 02:04:51 -0800 (PST)
Received: from haolee.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id b23sm9821038pjz.34.2022.01.23.02.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 02:04:50 -0800 (PST)
Date:   Sun, 23 Jan 2022 10:04:48 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        haolee.swjtu@gmail.com
Subject: [PATCH] fs/namespace: eliminate unnecessary mount counting
Message-ID: <20220123100448.GA1468@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

propagate_one() counts the number of propagated mounts in each
propagation. We can count them in advance and use the number in
subsequent propagation.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 fs/namespace.c | 27 +++++++++++++++++++--------
 fs/pnode.c     | 12 +++++++-----
 fs/pnode.h     |  5 +++--
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c6feb92209a6..5d05392854ca 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2082,18 +2082,15 @@ static int invent_group_ids(struct mount *mnt, bool recurse)
 	return 0;
 }
 
-int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
+int update_pending_mounts(struct mnt_namespace *ns, unsigned int mounts)
 {
 	unsigned int max = READ_ONCE(sysctl_mount_max);
-	unsigned int mounts = 0, old, pending, sum;
-	struct mount *p;
-
-	for (p = mnt; p; p = next_mnt(p, mnt))
-		mounts++;
+	unsigned int old, pending, sum;
 
 	old = ns->mounts;
 	pending = ns->pending_mounts;
 	sum = old + pending;
+
 	if ((old > sum) ||
 	    (pending > sum) ||
 	    (max < sum) ||
@@ -2104,6 +2101,17 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
 	return 0;
 }
 
+unsigned int count_mounts(struct mount *mnt)
+{
+	unsigned int mounts = 0;
+	struct mount *p;
+
+	for (p = mnt; p; p = next_mnt(p, mnt))
+		mounts++;
+
+	return mounts;
+}
+
 /*
  *  @source_mnt : mount tree to be attached
  *  @nd         : place the mount tree @source_mnt is attached
@@ -2178,6 +2186,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	struct mountpoint *smp;
 	struct mount *child, *p;
 	struct hlist_node *n;
+	unsigned int nr_mounts;
 	int err;
 
 	/* Preallocate a mountpoint in case the new mounts need
@@ -2187,9 +2196,10 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	if (IS_ERR(smp))
 		return PTR_ERR(smp);
 
+	nr_mounts = count_mounts(source_mnt);
 	/* Is there space to add these mounts to the mount namespace? */
 	if (!moving) {
-		err = count_mounts(ns, source_mnt);
+		err = update_pending_mounts(ns, nr_mounts);
 		if (err)
 			goto out;
 	}
@@ -2198,7 +2208,8 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		err = invent_group_ids(source_mnt, true);
 		if (err)
 			goto out;
-		err = propagate_mnt(dest_mnt, dest_mp, source_mnt, &tree_list);
+		err = propagate_mnt(dest_mnt, dest_mp, source_mnt, nr_mounts,
+				    &tree_list);
 		lock_mount_hash();
 		if (err)
 			goto out_cleanup_ids;
diff --git a/fs/pnode.c b/fs/pnode.c
index 1106137c747a..877de718fc35 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -222,7 +222,7 @@ static inline bool peers(struct mount *m1, struct mount *m2)
 	return m1->mnt_group_id == m2->mnt_group_id && m1->mnt_group_id;
 }
 
-static int propagate_one(struct mount *m)
+static int propagate_one(struct mount *m, unsigned int nr_mounts)
 {
 	struct mount *child;
 	int type;
@@ -269,7 +269,7 @@ static int propagate_one(struct mount *m)
 	last_dest = m;
 	last_source = child;
 	hlist_add_head(&child->mnt_hash, list);
-	return count_mounts(m->mnt_ns, child);
+	return update_pending_mounts(m->mnt_ns, nr_mounts);
 }
 
 /*
@@ -284,9 +284,11 @@ static int propagate_one(struct mount *m)
  * @dest_dentry: destination dentry.
  * @source_mnt: source mount.
  * @tree_list : list of heads of trees to be attached.
+ * @nr_mounts : the number of mounts in source_mnt
  */
 int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
-		    struct mount *source_mnt, struct hlist_head *tree_list)
+		    struct mount *source_mnt, unsigned int nr_mounts,
+		    struct hlist_head *tree_list)
 {
 	struct mount *m, *n;
 	int ret = 0;
@@ -305,7 +307,7 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 
 	/* all peers of dest_mnt, except dest_mnt itself */
 	for (n = next_peer(dest_mnt); n != dest_mnt; n = next_peer(n)) {
-		ret = propagate_one(n);
+		ret = propagate_one(n, nr_mounts);
 		if (ret)
 			goto out;
 	}
@@ -316,7 +318,7 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 		/* everything in that slave group */
 		n = m;
 		do {
-			ret = propagate_one(n);
+			ret = propagate_one(n, nr_mounts);
 			if (ret)
 				goto out;
 			n = next_peer(n);
diff --git a/fs/pnode.h b/fs/pnode.h
index 988f1aa9b02a..005355c0dd49 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -38,7 +38,7 @@ static inline void set_mnt_shared(struct mount *mnt)
 
 void change_mnt_propagation(struct mount *, int);
 int propagate_mnt(struct mount *, struct mountpoint *, struct mount *,
-		struct hlist_head *);
+		  unsigned int, struct hlist_head *);
 int propagate_umount(struct list_head *);
 int propagate_mount_busy(struct mount *, int);
 void propagate_mount_unlock(struct mount *);
@@ -52,5 +52,6 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp,
 struct mount *copy_tree(struct mount *, struct dentry *, int);
 bool is_path_reachable(struct mount *, struct dentry *,
 			 const struct path *root);
-int count_mounts(struct mnt_namespace *ns, struct mount *mnt);
+int update_pending_mounts(struct mnt_namespace *ns, unsigned int mounts);
+unsigned int count_mounts(struct mount *mnt);
 #endif /* _LINUX_PNODE_H */
-- 
2.34.1

