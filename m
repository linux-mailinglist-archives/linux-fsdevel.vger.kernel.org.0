Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37E112B538
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 15:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfL0Oad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 09:30:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45479 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfL0Oad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 09:30:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so26175741wrj.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2019 06:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FmDWuldBs0b5kcWfBSnCcU4oKSPI7N0a4hPlwYaEMJM=;
        b=k8eoK+jn0saMIIbZHTtTqHg76qLGNvfRNrsnqFE4rb4bO+PAXQ3KvMvm+5F3W0iQgL
         zU3FloVqRrGZhPgQNpNOL2jS2eiZfVDEQNL53qgI40EuIlB7awjdMe824P15kfHDghsz
         xE3J85HniiPlMc3uFl45H71+mbelhX3ZmmW9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FmDWuldBs0b5kcWfBSnCcU4oKSPI7N0a4hPlwYaEMJM=;
        b=sdV6+RIFGtSa7XTHq3wB/WLKFdYVvNgJi0VSY70L+s1vFe4RJMwvOLoy9dkxsAneqj
         0V/psDf2tqMv2oCM7Ao2YTp6W7wOcl9aCJRnVxZHx4xLRRlYXYDwSK+UFnDSXFdL69Q6
         wvgws2Y4Qy0BlVdzhSFU/TELR+0u6clErEPh1DSdNtuYxSa6z3W328G5CxM0IguqqVdT
         KzVajArnjiYEakq+CGy0oTtfyNpq9I02mNyjQd4XZlrizcP+7KdnhZrhrEcJty5PAxKy
         TkJqmMg86sIIhJhgSdOfpoxOS9VM5vQ6OAbEIpFzvO1t90Lt/1o65S3GUOKG+I9Y8iJb
         OAcw==
X-Gm-Message-State: APjAAAU4wO/Dl7D+DuX+qWYvL4eSDC9iHCzqjRMlTeuCXjnIEYtRHlDJ
        K7yU/0rJVK4Jbr7gbe4P2J58m7qH+5I=
X-Google-Smtp-Source: APXvYqyx5vhJr4F3TEl1jqSGGJVzLx/nNMkUS05tG6xs0w4p9noLdf30j+0bUWuhYPDWorWMuHIOKQ==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr51003206wrv.77.1577457030979;
        Fri, 27 Dec 2019 06:30:30 -0800 (PST)
Received: from localhost (host-92-23-123-10.as13285.net. [92.23.123.10])
        by smtp.gmail.com with ESMTPSA id x7sm34407315wrq.41.2019.12.27.06.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 06:30:30 -0800 (PST)
Date:   Fri, 27 Dec 2019 14:30:29 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/3] fs: inode: Add API to retrieve global next ino using
 full ino_t width
Message-ID: <28599683653d3fa779442a24b3b643bc395d88d0.1577456898.git.chris@chrisdown.name>
References: <cover.1577456898.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577456898.git.chris@chrisdown.name>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can't just wholesale replace get_next_ino to use ino_t and 64-bit
atomics because of a few setbacks:

1. This may break some 32-bit userspace applications on a 64-bit kernel
   which cannot handle a 64-bit ino_t -- see the comment above
   get_next_ino;
2. Some applications inside the kernel already make use of the ino_t
   high bits. For example, overlayfs' xino feature uses these to merge
   inode numbers and fsid indexes to form a new identifier.

As such we need to make using the full width of ino_t an option for
users without being a requirement.

This will later be used to power inode64 in tmpfs, and can be used
elsewhere for other filesystems as desired.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 fs/inode.c         | 41 +++++++++++++++++++++++++++++++++++++----
 include/linux/fs.h |  1 +
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 255a4ae81b65..1d96ad8b71f6 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -878,16 +878,17 @@ static struct inode *find_inode_fast(struct super_block *sb,
  * here to attempt to avoid that.
  */
 #define LAST_INO_BATCH 1024
-static DEFINE_PER_CPU(unsigned int, last_ino);
+static DEFINE_PER_CPU(unsigned int, last_ino_ui);
 
 /*
  * As get_next_ino returns a type with a small width (typically 32 bits),
  * consider reusing inode numbers in your filesystem if you have a private inode
- * cache in order to reduce the risk of wraparound.
+ * cache in order to reduce the risk of wraparound, or consider providing the
+ * option to use get_next_ino_full instead.
  */
 unsigned int get_next_ino(void)
 {
-	unsigned int *p = &get_cpu_var(last_ino);
+	unsigned int *p = &get_cpu_var(last_ino_ui);
 	unsigned int res = *p;
 
 #ifdef CONFIG_SMP
@@ -904,11 +905,43 @@ unsigned int get_next_ino(void)
 	if (unlikely(!res))
 		res++;
 	*p = res;
-	put_cpu_var(last_ino);
+	put_cpu_var(last_ino_ui);
 	return res;
 }
 EXPORT_SYMBOL(get_next_ino);
 
+static DEFINE_PER_CPU(ino_t, last_ino_full);
+
+ino_t get_next_ino_full(void)
+{
+	ino_t *p = &get_cpu_var(last_ino_full);
+	ino_t res = *p;
+
+#ifdef CONFIG_SMP
+	if (unlikely((res & (LAST_INO_BATCH-1)) == 0)) {
+		static atomic64_t shared_last_ino;
+		u64 next = atomic64_add_return(LAST_INO_BATCH,
+					       &shared_last_ino);
+
+		/*
+		 * This might get truncated if ino_t is 32-bit, and so be more
+		 * susceptible to wrap around than on environments where ino_t
+		 * is 64-bit.
+		 */
+		res = next - LAST_INO_BATCH;
+	}
+#endif
+
+	res++;
+	/* get_next_ino_full should not provide a 0 inode number */
+	if (unlikely(!res))
+		res++;
+	*p = res;
+	put_cpu_var(last_ino_full);
+	return res;
+}
+EXPORT_SYMBOL(get_next_ino_full);
+
 /**
  *	new_inode_pseudo 	- obtain an inode
  *	@sb: superblock
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 190c45039359..c73896d993c1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3053,6 +3053,7 @@ static inline void lockdep_annotate_inode_mutex_key(struct inode *inode) { };
 extern void unlock_new_inode(struct inode *);
 extern void discard_new_inode(struct inode *);
 extern unsigned int get_next_ino(void);
+extern ino_t get_next_ino_full(void);
 extern void evict_inodes(struct super_block *sb);
 
 extern void __iget(struct inode * inode);
-- 
2.24.1

