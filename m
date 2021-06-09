Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079933A1C91
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 20:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFISPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 14:15:12 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:51975 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFISPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:15:11 -0400
Received: by mail-wm1-f51.google.com with SMTP id l9so4614113wms.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jun 2021 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8b+ZhvWg0mzQUizw/kkYnxN6FxABkzkLpO2HEzkykrU=;
        b=gxjuGhj19IJ2C3HgNS7XZPVrBNv7N5QNudmlM12M67rwefyuYLyS61wwU4IAWGg1Ni
         ZkFwEIdQm9Pf21scEb8wrmQkqP6aDDBE7t6DU/QN+mjY8sQz+EU9niIRifbviUdoXtky
         MXBBAwxBwXNTwz/PqGnC9x3tWY8lgijLSK/yjoRQb++wfQ3cKlXJ2eg0yGxaMu+Qe23t
         Vhuizp1KBifNSb2Dlcf+XkroqVb0tWwTSsRkuxnCecHcaLIL8l70f1FrGYL8D9Po2VND
         33xAJnNxmLjXjGZmM67EClWTpODGetWQNIPNQA9SVh0MOrBWRWCUDLLcI3fMe7yL0fiV
         juMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8b+ZhvWg0mzQUizw/kkYnxN6FxABkzkLpO2HEzkykrU=;
        b=GAvNR8blUDmx6F9Vs398mVvVm0SbFxvZif99v2Rv1ghyoXktq/YZTEQGQZbD2LrKox
         uX1ngnyyKUdyMrpRuf2ZPpha8a8ZYu4QNyk8InPoGfbz7jiZku9JxZvxG7+CU/DD0zcB
         nn1WMqcANjXBKDq53KxgDIvlj2LbqtUMXEjaZeK79xd+o17/nuLPdMhgA4NH/xpGxpdI
         BG65fGUsbnKZnw+9N2pVAKYfdtoNWtKYa/qpceCkcedATpBmoWcNlT1kbv5Yu4hima4S
         iQGxbDAQXjBFGkt3/1BlSj0iLQEIYhS0tQC49pvSxxfE5+03BLbCYqGxHhMenWQpX9jt
         7Khg==
X-Gm-Message-State: AOAM532fARCdLiTpaXUDB3nAgLBiDEu2zX0YVQIGSXQyWgEV1MUQz054
        hK0xo5AR69/nc+s1PzhGQMhifyE3Rg0=
X-Google-Smtp-Source: ABdhPJwGRvKOPecS1+UkG4tkSMtQJZIRC9Ib2QwVggAXTTnEkeloEU2nEtbpsSGo2oeHpI+/SXpslw==
X-Received: by 2002:a1c:bad6:: with SMTP id k205mr11411451wmf.171.1623262321150;
        Wed, 09 Jun 2021 11:12:01 -0700 (PDT)
Received: from localhost.localdomain ([147.234.99.211])
        by smtp.gmail.com with ESMTPSA id q3sm707490wrr.43.2021.06.09.11.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 11:12:00 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: fix illegal access to inode with reused nodeid
Date:   Wed,  9 Jun 2021 21:11:58 +0300
Message-Id: <20210609181158.479781-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Server responds to LOOKUP and other ops (READDIRPLUS/CREATE/MKNOD/...)
with outarg containing nodeid and generation.

If a fuse inode is found in inode cache with the same nodeid but
different generation, the existing fuse inode should be unhashed and
marked "bad" and a new inode with the new generation should be hashed
instead.

This can happen, for example, with passhrough fuse filesystem that
returns the real filesystem ino/generation on lookup and where real inode
numbers can get recycled due to real files being unlinked not via the fuse
passthrough filesystem.

With current code, this situation will not be detected and an old fuse
dentry that used to point to an older generation real inode, can be used
to access a completely new inode, which should be accessed only via the
new dentry.

Note that because the FORGET message carries the nodeid w/o generation,
the server should wait to get FORGET counts for the nlookup counts of
the old and reused inodes combined, before it can free the resources
associated to that nodeid.

Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxgDMGUpK35huwqFYGH_idBB8S6eLiz85o0DDKOyDH4Syg@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

I was able to reproduce this issue with a passthrough fs that stored
ino+generation and uses then to open fd on lookup.

I extended libfuse's test_syscalls [1] program to demonstrate the issue
described in commit message.

Max, IIUC, you are making a modification to virtiofs-rs that would
result is being exposed to this bug.  You are welcome to try out the
test and let me know if you can reproduce the issue.

Note that some test_syscalls test fail with cache enabled, so libfuse's
test_examples.py only runs test_syscalls in cache disabled config.

Thanks,
Amir.

[1] https://github.com/amir73il/libfuse/commits/test-reused-inodes

 fs/fuse/dir.c     | 3 ++-
 fs/fuse/fuse_i.h  | 9 +++++++++
 fs/fuse/inode.c   | 4 ++--
 fs/fuse/readdir.c | 7 +++++--
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1b6c001a7dd1..b06628fd7d8e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -239,7 +239,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 		if (!ret) {
 			fi = get_fuse_inode(inode);
 			if (outarg.nodeid != get_node_id(inode) ||
-			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
+			    fuse_stale_inode(inode, outarg.generation,
+					     &outarg.attr)) {
 				fuse_queue_forget(fm->fc, forget,
 						  outarg.nodeid, 1);
 				goto invalid;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7e463e220053..f1bd28c176a9 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -867,6 +867,15 @@ static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
 	return atomic64_read(&fc->attr_version);
 }
 
+static inline bool fuse_stale_inode(const struct inode *inode, int generation,
+				    struct fuse_attr *attr)
+{
+	return inode->i_generation != generation ||
+		inode_wrong_type(inode, attr->mode) ||
+		(bool) IS_AUTOMOUNT(inode) !=
+		(bool) (attr->flags & FUSE_ATTR_SUBMOUNT);
+}
+
 static inline void fuse_make_bad(struct inode *inode)
 {
 	remove_inode_hash(inode);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 393e36b74dc4..257bb3e1cac8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -350,8 +350,8 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		inode->i_generation = generation;
 		fuse_init_inode(inode, attr);
 		unlock_new_inode(inode);
-	} else if (inode_wrong_type(inode, attr->mode)) {
-		/* Inode has changed type, any I/O on the old should fail */
+	} else if (fuse_stale_inode(inode, generation, attr)) {
+		/* nodeid was reused, any I/O on the old inode should fail */
 		fuse_make_bad(inode);
 		iput(inode);
 		goto retry;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 277f7041d55a..bc267832310c 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -200,9 +200,12 @@ static int fuse_direntplus_link(struct file *file,
 	if (!d_in_lookup(dentry)) {
 		struct fuse_inode *fi;
 		inode = d_inode(dentry);
+		if (inode && get_node_id(inode) != o->nodeid)
+			inode = NULL;
 		if (!inode ||
-		    get_node_id(inode) != o->nodeid ||
-		    inode_wrong_type(inode, o->attr.mode)) {
+		    fuse_stale_inode(inode, o->generation, &o->attr)) {
+			if (inode)
+				fuse_make_bad(inode);
 			d_invalidate(dentry);
 			dput(dentry);
 			goto retry;
-- 
2.31.1

