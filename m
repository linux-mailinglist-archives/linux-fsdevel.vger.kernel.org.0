Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AA0457B56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Nov 2021 05:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhKTExX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 23:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbhKTExV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:53:21 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9928C061748
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 20:50:18 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id m15-20020a170902bb8f00b0014382b67873so5681728pls.19
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 20:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iWNn/wNJRY2Y0h/rqhWfX8g07yS3O6443gwIflX0KOQ=;
        b=rF6A573f3uTOcP2DN6YOqIIDuHlaXpDc1X65m9DnLi+HiZPGfATiXrq+3lKL51BV2J
         zH/nOMLgcXjU3rOypQV1ZglbzMm4evZaxfS7Z0iYCdBGvUGZCygsGuWtTcHids+8SYw+
         ApI4iPKAq6PWmZD2gJmVsVefolSEQHlmQ5NYdMG69ybH0uWBhmhfPmbyJnL20mZeuZNq
         pFy8vgTlaTsYDMbj1itS2UaqnkvHp1VIS0M8vmC7pBVHPPZ01qGIG5nhczAWpVAKfj9p
         MMggKZw0+33MZWnWfgVOgyObj1qHy3d/p+jT7uaw7PpddPuZ00gzYKBjwz+PufwD+tPy
         s8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iWNn/wNJRY2Y0h/rqhWfX8g07yS3O6443gwIflX0KOQ=;
        b=n3z3+Lu4LMgCeb7IxIiziapYgsxKDbsen5UAp0GIGXZZNGzdunM1Tts6Ku6TLdH86l
         c0puzbtzF3Gg0DpVPJeYM34atVCJq0/l1VMv3XcCOk4zLork0JzU6158a6NcBYtDN2uh
         vH4WPbaUeN1EZB+GcEG2jWEdoOiomydOqC2FLAXaJzCItZ16xIXj4rjJZ3iqHd1XRVmX
         XGXTe0isiUobmGFuFfkYW/Mbai1ltvfSmgQwjidUMCV7WMYhVucNcxa8ZXaO/h4fCDfz
         tgZUWAgNCdTScFDNPDCg0jwAypUOQs0H6tZ83tvIB5MZv16RnhGOID2XjmXkaFuw0ado
         EVUA==
X-Gm-Message-State: AOAM531wCS4Xfwku7PAsC7OMRcu93xwLgZPay8brFMWQBIed/PXB5rnT
        PusCR9wfFkKQZY9Hy7rJuVcMd6UiK/D5gLX/4Q==
X-Google-Smtp-Source: ABdhPJzLZCsmVsHYvgrxaIaGq8zvGjvN62zWcOui3rUsL12upLL9nA2Q48apGhptRBH2NZzYjm9TANV5i09OBpimOQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:fa91:560a:d7b4:93])
 (user=almasrymina job=sendgmr) by 2002:a63:89c2:: with SMTP id
 v185mr1094980pgd.252.1637383818156; Fri, 19 Nov 2021 20:50:18 -0800 (PST)
Date:   Fri, 19 Nov 2021 20:50:07 -0800
In-Reply-To: <20211120045011.3074840-1-almasrymina@google.com>
Message-Id: <20211120045011.3074840-2-almasrymina@google.com>
Mime-Version: 1.0
References: <20211120045011.3074840-1-almasrymina@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v4 1/4] mm: support deterministic memory charging of filesystems
From:   Mina Almasry <almasrymina@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Users can specify a memcg= mount option option at mount time and all
data page charges will be charged to the memcg supplied.  This is useful
to deterministicly charge the memory of the file system or memory shared
via tmpfs for example.

Implementation notes:
- Add memcg= option parsing to fs common code.
- We attach the memcg to charge for this filesystem data pages to the
  struct super_block. The memcg can be changed via a remount operation,
  and all future memcg charges in this filesystem will be charged to
  the new memcg.
- We create a new interface mem_cgroup_charge_mapping(), which will
  check if the super_block in the mapping has a memcg to charge. It
  charges that, and falls back to the mm passed if there is no
  super_block memcg.
- On filesystem data memory allocation paths, we call the new interface
  mem_cgroup_charge_mapping().

Caveats:
- Processes are only allowed to direct filesystem charges to a cgroup that
  they themselves can enter and allocate memory in. This so that we do not
  introduce an attack vector where processes can DoS any cgroup in the
  system that they are not normally allowed to enter and allocate memory in.
- In mem_cgroup_charge_mapping() we pay the cost of checking whether the
  super_block has a memcg to charge, regardless of whether the mount
  point was mounted with memcg=. This can be alleviated by putting the
  memcg to charge in the struct address_space, but, this increases the
  size of that struct and makes it difficult to support remounting the
  memcg= option, although remounting is of dubious value.
- mem_cgroup_charge_mapping() simply returns any error received from the
  following charge_memcg() or mem_cgroup_charge() calls. There is
  a follow up patch in this series which closely examines and handles the
  behavior when hitting the limit of the remote memcg.

Signed-off-by: Mina Almasry <almasrymina@google.com>


---

Changes in v4:
- Added cover letter and moved list of Cc's there.
- Made memcg= option generic to all file systems.
- Reverted to calling mem_cgroup_charge_mapping() for generic file
  system allocation paths, since this feature is not implemented for all
  filesystems.
- Refactored some memcontrol interfaces slightly to reduce the number of
  "#ifdef CONFIG_MEMCG" needed in other files.

Changes in v3:
- Fixed build failures/warnings Reported-by: kernel test robot <lkp@intel.com>

Changes in v2:
- Fixed Roman's email.
- Added a new wrapper around charge_memcg() instead of __mem_cgroup_charge()
- Merged the permission check into this patch as Roman suggested.
- Instead of checking for a s_memcg_to_charge off the superblock in the
filemap code, I set_active_memcg() before calling into the fs generic
code as Dave suggests.
- I have kept the s_memcg_to_charge in the superblock to keep the
struct address_space pointer small and preserve the remount use case..

---
 fs/fs_context.c            |  27 +++++++
 fs/proc_namespace.c        |   4 ++
 fs/super.c                 |   9 +++
 include/linux/fs.h         |   5 ++
 include/linux/fs_context.h |   2 +
 include/linux/memcontrol.h |  32 +++++++++
 mm/filemap.c               |   2 +-
 mm/khugepaged.c            |   3 +-
 mm/memcontrol.c            | 142 +++++++++++++++++++++++++++++++++++++
 mm/shmem.c                 |   3 +-
 10 files changed, 226 insertions(+), 3 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index b7e43a780a625..fe2449d5f1fbf 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -23,6 +23,7 @@
 #include <asm/sections.h>
 #include "mount.h"
 #include "internal.h"
+#include <linux/memcontrol.h>

 enum legacy_fs_param {
 	LEGACY_FS_UNSET_PARAMS,
@@ -108,6 +109,28 @@ int vfs_parse_fs_param_source(struct fs_context *fc, struct fs_parameter *param)
 }
 EXPORT_SYMBOL(vfs_parse_fs_param_source);

+static int parse_param_memcg(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct mem_cgroup *memcg;
+
+	if (strcmp(param->key, "memcg") != 0)
+		return -ENOPARAM;
+
+	if (param->type != fs_value_is_string)
+		return invalf(fc, "Non-string source");
+
+	if (fc->memcg)
+		return invalf(fc, "Multiple memcgs specified");
+
+	memcg = mem_cgroup_get_from_path(param->string);
+	if (IS_ERR(memcg))
+		return invalf(fc, "Bad value for memcg");
+
+	fc->memcg = memcg;
+	param->string = NULL;
+	return 0;
+}
+
 /**
  * vfs_parse_fs_param - Add a single parameter to a superblock config
  * @fc: The filesystem context to modify
@@ -148,6 +171,10 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 			return ret;
 	}

+	ret = parse_param_memcg(fc, param);
+	if (ret != -ENOPARAM)
+		return ret;
+
 	/* If the filesystem doesn't take any arguments, give it the
 	 * default handling of source.
 	 */
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 392ef5162655b..32e1647dcef43 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/fs_struct.h>
 #include <linux/sched/task.h>
+#include <linux/memcontrol.h>

 #include "proc/internal.h" /* only for get_proc_task() in ->open() */

@@ -125,6 +126,9 @@ static int show_vfsmnt(struct seq_file *m, struct vfsmount *mnt)
 	if (err)
 		goto out;
 	show_mnt_opts(m, mnt);
+
+	mem_cgroup_put_name_in_seq(m, sb);
+
 	if (sb->s_op->show_options)
 		err = sb->s_op->show_options(m, mnt_path.dentry);
 	seq_puts(m, " 0 0\n");
diff --git a/fs/super.c b/fs/super.c
index 3bfc0f8fbd5bc..06c972f80c529 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -24,6 +24,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
+#include <linux/memcontrol.h>
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
@@ -180,6 +181,7 @@ static void destroy_unused_super(struct super_block *s)
 	up_write(&s->s_umount);
 	list_lru_destroy(&s->s_dentry_lru);
 	list_lru_destroy(&s->s_inode_lru);
+	mem_cgroup_set_charge_target(s, NULL);
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
@@ -292,6 +294,7 @@ static void __put_super(struct super_block *s)
 		WARN_ON(s->s_dentry_lru.node);
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(!list_empty(&s->s_mounts));
+		mem_cgroup_set_charge_target(s, NULL);
 		security_sb_free(s);
 		fscrypt_sb_free(s);
 		put_user_ns(s->s_user_ns);
@@ -904,6 +907,9 @@ int reconfigure_super(struct fs_context *fc)
 		}
 	}

+	if (fc->memcg)
+		mem_cgroup_set_charge_target(sb, fc->memcg);
+
 	if (fc->ops->reconfigure) {
 		retval = fc->ops->reconfigure(fc);
 		if (retval) {
@@ -1528,6 +1534,9 @@ int vfs_get_tree(struct fs_context *fc)
 		return error;
 	}

+	if (fc->memcg)
+		mem_cgroup_set_charge_target(sb, fc->memcg);
+
 	/*
 	 * filesystems should never set s_maxbytes larger than MAX_LFS_FILESIZE
 	 * but s_maxbytes was an unsigned long long for many releases. Throw
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3afca821df32e..59407b3e7aee3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1567,6 +1567,11 @@ struct super_block {
 	struct workqueue_struct *s_dio_done_wq;
 	struct hlist_head s_pins;

+#ifdef CONFIG_MEMCG
+	/* memcg to charge for pages allocated to this filesystem */
+	struct mem_cgroup *s_memcg_to_charge;
+#endif
+
 	/*
 	 * Owning user namespace and default context in which to
 	 * interpret filesystem uids, gids, quotas, device nodes,
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 6b54982fc5f37..8e2cc1e554fa1 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -25,6 +25,7 @@ struct super_block;
 struct user_namespace;
 struct vfsmount;
 struct path;
+struct mem_cgroup;

 enum fs_context_purpose {
 	FS_CONTEXT_FOR_MOUNT,		/* New superblock for explicit mount */
@@ -110,6 +111,7 @@ struct fs_context {
 	bool			need_free:1;	/* Need to call ops->free() */
 	bool			global:1;	/* Goes into &init_user_ns */
 	bool			oldapi:1;	/* Coming from mount(2) */
+	struct mem_cgroup 	*memcg;		/* memcg to charge */
 };

 struct fs_context_operations {
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c5c403f4be6b..0a9b0bba5f3c8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -27,6 +27,7 @@ struct obj_cgroup;
 struct page;
 struct mm_struct;
 struct kmem_cache;
+struct super_block;

 /* Cgroup-specific page state, on top of universal node page state */
 enum memcg_stat_item {
@@ -923,6 +924,15 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
 	return !!(memcg->css.flags & CSS_ONLINE);
 }

+void mem_cgroup_set_charge_target(struct super_block *sb,
+				  struct mem_cgroup *memcg);
+
+int mem_cgroup_charge_mapping(struct folio *folio, struct mm_struct *mm,
+			      gfp_t gfp, struct address_space *mapping);
+
+struct mem_cgroup *mem_cgroup_get_from_path(const char *path);
+void mem_cgroup_put_name_in_seq(struct seq_file *seq, struct super_block *sb);
+
 void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 		int zid, int nr_pages);

@@ -1223,6 +1233,28 @@ static inline int mem_cgroup_charge(struct folio *folio,
 	return 0;
 }

+static inline void mem_cgroup_set_charge_target(struct super_block *sb,
+						struct mem_cgroup *memcg)
+{
+}
+
+static inline int mem_cgroup_charge_mapping(struct folio *folio,
+					    struct mm_struct *mm, gfp_t gfp,
+					    struct address_space *mapping)
+{
+	return 0;
+}
+
+static inline struct mem_cgroup *mem_cgroup_get_from_path(const char *path)
+{
+	return NULL;
+}
+
+static inline void mem_cgroup_put_name_in_seq(struct seq_file *seq,
+					      struct super_block *sb)
+{
+}
+
 static inline int mem_cgroup_swapin_charge_page(struct page *page,
 			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 6844c9816a864..3825cf12bc345 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -903,7 +903,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	folio->index = index;

 	if (!huge) {
-		error = mem_cgroup_charge(folio, NULL, gfp);
+		error = mem_cgroup_charge_mapping(folio, NULL, gfp, mapping);
 		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 		if (error)
 			goto error;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e99101162f1ab..8468a3ad446b9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1661,7 +1661,8 @@ static void collapse_file(struct mm_struct *mm,
 		goto out;
 	}

-	if (unlikely(mem_cgroup_charge(page_folio(new_page), mm, gfp))) {
+	if (unlikely(mem_cgroup_charge_mapping(page_folio(new_page), mm, gfp,
+					       mapping))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out;
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 781605e920153..c4ba7f364c214 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -62,6 +62,7 @@
 #include <linux/tracehook.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/string.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -2580,6 +2581,129 @@ void mem_cgroup_handle_over_high(void)
 	css_put(&memcg->css);
 }

+/*
+ * Non error return value must eventually be released with css_put().
+ */
+struct mem_cgroup *mem_cgroup_get_from_path(const char *path)
+{
+	static const char procs_filename[] = "/cgroup.procs";
+	struct file *file, *procs;
+	struct cgroup_subsys_state *css;
+	struct mem_cgroup *memcg;
+	char *procs_path =
+		kmalloc(strlen(path) + sizeof(procs_filename), GFP_KERNEL);
+
+	if (procs_path == NULL)
+		return ERR_PTR(-ENOMEM);
+	strcpy(procs_path, path);
+	strcat(procs_path, procs_filename);
+
+	procs = filp_open(procs_path, O_WRONLY, 0);
+	kfree(procs_path);
+
+	/*
+	 * Restrict the capability for tasks to mount with memcg charging to the
+	 * cgroup they could not join. For example, disallow:
+	 *
+	 * mount -t tmpfs -o memcg=root-cgroup nodev <MOUNT_DIR>
+	 *
+	 * if it is a non-root task.
+	 */
+	if (IS_ERR(procs))
+		return (struct mem_cgroup *)procs;
+	fput(procs);
+
+	file = filp_open(path, O_DIRECTORY | O_RDONLY, 0);
+	if (IS_ERR(file))
+		return (struct mem_cgroup *)file;
+
+	css = css_tryget_online_from_dir(file->f_path.dentry,
+					 &memory_cgrp_subsys);
+	if (IS_ERR(css))
+		memcg = (struct mem_cgroup *)css;
+	else
+		memcg = container_of(css, struct mem_cgroup, css);
+
+	fput(file);
+	return memcg;
+}
+
+void mem_cgroup_put_name_in_seq(struct seq_file *m, struct super_block *sb)
+{
+	struct mem_cgroup *memcg;
+	int ret = 0;
+	char *buf = __getname();
+	int len = PATH_MAX;
+
+	if (!buf)
+		return;
+
+	buf[0] = '\0';
+
+	rcu_read_lock();
+	memcg = rcu_dereference(sb->s_memcg_to_charge);
+	if (memcg && !css_tryget_online(&memcg->css))
+		memcg = NULL;
+	rcu_read_unlock();
+
+	if (!memcg)
+		return;
+
+	ret = cgroup_path(memcg->css.cgroup, buf + len / 2, len / 2);
+	if (ret >= len / 2)
+		strcpy(buf, "?");
+	else {
+		char *p = mangle_path(buf, buf + len / 2, " \t\n\\");
+
+		if (p)
+			*p = '\0';
+		else
+			strcpy(buf, "?");
+	}
+
+	css_put(&memcg->css);
+	if (buf[0] != '\0')
+		seq_printf(m, ",memcg=%s", buf);
+
+	__putname(buf);
+}
+
+/*
+ * Set or clear (if @memcg is NULL) charge association from file system to
+ * memcg.  If @memcg != NULL, then a css reference must be held by the caller to
+ * ensure that the cgroup is not deleted during this operation, this reference
+ * is dropped after this operation.
+ */
+void mem_cgroup_set_charge_target(struct super_block *sb,
+				  struct mem_cgroup *memcg)
+{
+	memcg = xchg(&sb->s_memcg_to_charge, memcg);
+	if (memcg)
+		css_put(&memcg->css);
+}
+
+/*
+ * Returns the memcg to charge for inode pages.  If non-NULL is returned, caller
+ * must drop reference with css_put().  NULL indicates that the inode does not
+ * have a memcg to charge, so the default process based policy should be used.
+ */
+static struct mem_cgroup *
+mem_cgroup_mapping_get_charge_target(struct address_space *mapping)
+{
+	struct mem_cgroup *memcg;
+
+	if (!mapping)
+		return NULL;
+
+	rcu_read_lock();
+	memcg = rcu_dereference(mapping->host->i_sb->s_memcg_to_charge);
+	if (memcg && !css_tryget_online(&memcg->css))
+		memcg = NULL;
+	rcu_read_unlock();
+
+	return memcg;
+}
+
 static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			unsigned int nr_pages)
 {
@@ -6678,6 +6802,24 @@ static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 	return ret;
 }

+int mem_cgroup_charge_mapping(struct folio *folio, struct mm_struct *mm,
+			      gfp_t gfp, struct address_space *mapping)
+{
+	struct mem_cgroup *mapping_memcg;
+	int ret = 0;
+	if (mem_cgroup_disabled())
+		return 0;
+
+	mapping_memcg = mem_cgroup_mapping_get_charge_target(mapping);
+	if (mapping_memcg) {
+		ret = charge_memcg(folio, mapping_memcg, gfp);
+		css_put(&mapping_memcg->css);
+		return ret;
+	}
+
+	return mem_cgroup_charge(folio, mm, gfp);
+}
+
 int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 {
 	struct mem_cgroup *memcg;
diff --git a/mm/shmem.c b/mm/shmem.c
index 23c91a8beb781..e469da13a1b8a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -709,7 +709,8 @@ static int shmem_add_to_page_cache(struct page *page,
 	page->index = index;

 	if (!PageSwapCache(page)) {
-		error = mem_cgroup_charge(page_folio(page), charge_mm, gfp);
+		error = mem_cgroup_charge_mapping(page_folio(page), charge_mm,
+						  gfp, mapping);
 		if (error) {
 			if (PageTransHuge(page)) {
 				count_vm_event(THP_FILE_FALLBACK);
--
2.34.0.rc2.393.gf8c9666880-goog
