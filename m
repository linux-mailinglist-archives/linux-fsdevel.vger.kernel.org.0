Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE38B1273A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 03:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLTCto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 21:49:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36209 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfLTCtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 21:49:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so7695719wma.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2019 18:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3dLi1FN4YuHTK91k3PaWwlK01Zg48IND9WDfUCQ0nug=;
        b=dO66Fqa3XMaKGPCSvFs4jNIPGQ3yORAEBJ87DqlfN8HELqe1P4KBQBhr0c8k3+NKTV
         vhalMsnfFMYVDX/bfHNyT4YAIABEQ6Yp95jumUnKvTQAEbj9d9t9birE7kZDRpDF70Wp
         SAj2YiAQ18qwN8Tg87JQT9yZ17HBJr1PCHxNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3dLi1FN4YuHTK91k3PaWwlK01Zg48IND9WDfUCQ0nug=;
        b=DIejCZDuTsRtgMOX5zjCRVq1ds+kucmjzVZ4A4jE66NJ4Zt1tqzOG5YuidsIkQF0Nr
         /4jJ6udA/prNZhoq8vZDHoMYtD5/S09psGgqTQwj5F3lv39GYTYsNR+0dk7H+lN/Pe2x
         YszrpY3IwjOmgHV65UenQwsfsu68zgeV2HBZ4gFGDzYlLfLmDrdCuHrDvMl6pqh7tvzs
         i/EAe8QVLYS58wLebR/46GeGXsM2uBmDDOy02xYysq+6M23oH5oMx+iu0anxXUF7yGxH
         AFMDwhBAxvD5vviUQUEuHtZg/Qyh9s5b8gS+1QCLk3CtKuiqrIl8sZOIJbMlWZ4jxrHR
         f0NQ==
X-Gm-Message-State: APjAAAXot2zmwJDMBQNMBl2JRJiqom+Jq2GSmyz75ASHjLWfpxdBwL+H
        apnIf9WfBGiGDSpOZHXlQiXtAt3ph5t8OCWc
X-Google-Smtp-Source: APXvYqxT8x3YdvMdnGsp2PZJu2iYUAEMJ3/fb9pqO77S/7VEy4oAOaKykbpVEn7CAydy1TK0TWzluA==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr12666080wma.121.1576810177917;
        Thu, 19 Dec 2019 18:49:37 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:aad7])
        by smtp.gmail.com with ESMTPSA id q19sm7891917wmc.12.2019.12.19.18.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 18:49:37 -0800 (PST)
Date:   Fri, 20 Dec 2019 02:49:36 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] fs: inode: Reduce volatile inode wraparound risk when ino_t
 is 64 bit
Message-ID: <20191220024936.GA380394@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In Facebook production we are seeing heavy inode number wraparounds on
tmpfs. On affected tiers, in excess of 10% of hosts show multiple files
with different content and the same inode number, with some servers even
having as many as 150 duplicated inode numbers with differing file
content.

This causes actual, tangible problems in production. For example, we
have complaints from those working on remote caches that their
application is reporting cache corruptions because it uses (device,
inodenum) to establish the identity of a particular cache object, but
because it's not unique any more, the application refuses to continue
and reports cache corruption. Even worse, sometimes applications may not
even detect the corruption but may continue anyway, causing phantom and
hard to debug behaviour.

In general, userspace applications expect that (device, inodenum) should
be enough to be uniquely point to one inode, which seems fair enough.
This patch changes get_next_ino to use up to min(sizeof(ino_t), 8) bytes
to reduce the likelihood of wraparound. On architectures with 32-bit
ino_t the problem is, at least, not made any worse than it is right now.

I noted the concern in the comment above about 32-bit applications on a
64-bit kernel with 32-bit wide ino_t in userspace, as documented by Jeff
in the commit message for 866b04fc, but these applications are going to
get EOVERFLOW on filesystems with non-volatile inode numbers anyway,
since those will likely be 64-bit. Concerns about that seem slimmer
compared to the disadvantages this presents for known, real users of
this functionality on platforms with a 64-bit ino_t.

Other approaches I've considered:

- Use an IDA. If this is a problem for users with 32-bit ino_t as well,
  this seems a feasible approach. For now this change is non-intrusive
  enough, though, and doesn't make the situation any worse for them than
  present at least.
- Look for other approaches in userspace. I think this is less
  feasible -- users do need to have a way to reliably determine inode
  identity, and the risk of wraparound with a 2^32-sized counter is
  pretty high, quite clearly manifesting in production for workloads
  which make heavy use of tmpfs.

Signed-off-by: Chris Down <chris@chrisdown.name>
Reported-by: Phyllipe Medeiros <phyllipe@fb.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 fs/inode.c         | 29 ++++++++++++++++++-----------
 include/linux/fs.h |  2 +-
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index aff2b5831168..8193c17e2d16 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -870,26 +870,33 @@ static struct inode *find_inode_fast(struct super_block *sb,
  * This does not significantly increase overflow rate because every CPU can
  * consume at most LAST_INO_BATCH-1 unused inode numbers. So there is
  * NR_CPUS*(LAST_INO_BATCH-1) wastage. At 4096 and 1024, this is ~0.1% of the
- * 2^32 range, and is a worst-case. Even a 50% wastage would only increase
- * overflow rate by 2x, which does not seem too significant.
+ * 2^32 range (for 32-bit ino_t), and is a worst-case. Even a 50% wastage would
+ * only increase overflow rate by 2x, which does not seem too significant. With
+ * a 64-bit ino_t, overflow in general is fairly hard to achieve.
  *
- * On a 32bit, non LFS stat() call, glibc will generate an EOVERFLOW
- * error if st_ino won't fit in target struct field. Use 32bit counter
- * here to attempt to avoid that.
+ * Care should be taken not to overflow when at all possible, since generally
+ * userspace depends on (device, inodenum) being reliably unique.
  */
 #define LAST_INO_BATCH 1024
-static DEFINE_PER_CPU(unsigned int, last_ino);
+static DEFINE_PER_CPU(ino_t, last_ino);
 
-unsigned int get_next_ino(void)
+ino_t get_next_ino(void)
 {
-	unsigned int *p = &get_cpu_var(last_ino);
-	unsigned int res = *p;
+	ino_t *p = &get_cpu_var(last_ino);
+	ino_t res = *p;
 
 #ifdef CONFIG_SMP
 	if (unlikely((res & (LAST_INO_BATCH-1)) == 0)) {
-		static atomic_t shared_last_ino;
-		int next = atomic_add_return(LAST_INO_BATCH, &shared_last_ino);
+		static atomic64_t shared_last_ino;
+		u64 next = atomic64_add_return(LAST_INO_BATCH,
+					       &shared_last_ino);
 
+		/*
+		 * This might get truncated if ino_t is 32-bit, and so be more
+		 * susceptible to wrap around than on environments where ino_t
+		 * is 64-bit, but that's really no worse than always encoding
+		 * `res` as unsigned int.
+		 */
 		res = next - LAST_INO_BATCH;
 	}
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 190c45039359..ca1a04334c9e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3052,7 +3052,7 @@ static inline void lockdep_annotate_inode_mutex_key(struct inode *inode) { };
 #endif
 extern void unlock_new_inode(struct inode *);
 extern void discard_new_inode(struct inode *);
-extern unsigned int get_next_ino(void);
+extern ino_t get_next_ino(void);
 extern void evict_inodes(struct super_block *sb);
 
 extern void __iget(struct inode * inode);
-- 
2.24.1

