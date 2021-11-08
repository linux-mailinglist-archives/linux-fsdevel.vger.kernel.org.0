Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2324449DEC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 22:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbhKHVWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 16:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbhKHVWv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:22:51 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0118C061714
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Nov 2021 13:20:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so3264246ybj.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Nov 2021 13:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=zVeQGTqO4yrZIJdGZXiUweQmgL96nl5isxRapgZhTQ8=;
        b=bSjwqOIRF175FXI/JaJgPUi97vnEQj89YKHRYiosJj4YHcKTNyFDssvZ/HcCV9yiWt
         i2XZHALoFJZvJbeu69RSuRiQBerATpSzTpx78EHqoDnh5PwVFu0KLk9RbJJG2Wd/NXtc
         bwqUaD0fNzk8Cif31JYb47qcaJ/JrT4cQzeTyUdD34pKyqrtQ7EWSy8HYLFpcAYzIVDM
         peEZjAylvtBhdz5/M6zOsnm17XjUqHzrbbD0dHBRwY1cSzp5E6lC8fHrH8clThvYvAG2
         l/J28AcKZ6pIICOui9D0Y5h3R3xKoLxeM3LneLlVYxArLmvwT1TzsBSJhBT/rrQ420k7
         w0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=zVeQGTqO4yrZIJdGZXiUweQmgL96nl5isxRapgZhTQ8=;
        b=XlB/qnFSKibBrrC3xOj0uO4lybPpaNiy9oOEDDkpV3n54E/Zl5PfkPltgyGfPwMtk8
         mELMGPwhdY5x+2HQYsgx/Q9cUDKlRcsxGwgelwdoCe3dEeZqj0gf5bQMgex7wa99QYaU
         7qn8CD0ehxab410P8ZuHZ7orDhaEddGZrINAq2a4yyUV4VujmDwb9tsas9o5xJxDsNeM
         xZ0sHn4+lIl3Or7RejmEWYObya1o/Ubl66ih3D4J922mVRzcoQkwJid5T4gS/HXGyUlr
         HO4vaYCuhmgyfN7I59ekS+zRrhhPPoPMTOF0JqkChbZOJUfrsagm+k2Q6suLDKHMM43W
         2+qA==
X-Gm-Message-State: AOAM533YRtlsu3C0AuB23cjNmkfss6D9IOdNLp31n/o7atpY0nmd5MCP
        4GtNU0oBtZjpysRKxpJ7e0lqD75KmC3GBtp94Q==
X-Google-Smtp-Source: ABdhPJzTHw6oqG6AiSf3Kr3pTcKuNjPhm96OIbGQULeQ9Rn0mcghP9uLa+I5NP9i6IULx/Pj1GRCd9wLDx6C5TKX5A==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:8717:7707:fb59:664e])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:725:: with SMTP id
 l5mr3139301ybt.314.1636406405747; Mon, 08 Nov 2021 13:20:05 -0800 (PST)
Date:   Mon,  8 Nov 2021 13:19:55 -0800
In-Reply-To: <20211108211959.1750915-1-almasrymina@google.com>
Message-Id: <20211108211959.1750915-2-almasrymina@google.com>
Mime-Version: 1.0
References: <20211108211959.1750915-1-almasrymina@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v1 1/5] mm/shmem: support deterministic charging of tmpfs
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add memcg= option to shmem mount.

Users can specify this option at mount time and all data page charges
will be charged to the memcg supplied.

Signed-off-by: Mina Almasry <almasrymina@google.com>

Cc: Michal Hocko <mhocko@suse.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Greg Thelen <gthelen@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Roman Gushchin <songmuchun@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: riel@surriel.com
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: cgroups@vger.kernel.org

---
 fs/super.c                 |   3 ++
 include/linux/fs.h         |   5 ++
 include/linux/memcontrol.h |  46 ++++++++++++++--
 mm/filemap.c               |   2 +-
 mm/memcontrol.c            | 104 ++++++++++++++++++++++++++++++++++++-
 mm/shmem.c                 |  50 +++++++++++++++++-
 6 files changed, 201 insertions(+), 9 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 3bfc0f8fbd5bc..8aafe5e4e6200 100644
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
+	mem_cgroup_set_charge_target(&s->s_memcg_to_charge, NULL);
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
@@ -292,6 +294,7 @@ static void __put_super(struct super_block *s)
 		WARN_ON(s->s_dentry_lru.node);
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(!list_empty(&s->s_mounts));
+		mem_cgroup_set_charge_target(&s->s_memcg_to_charge, NULL);
 		security_sb_free(s);
 		fscrypt_sb_free(s);
 		put_user_ns(s->s_user_ns);
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
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c5c403f4be6b..e9a64c1b8295b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -27,6 +27,7 @@ struct obj_cgroup;
 struct page;
 struct mm_struct;
 struct kmem_cache;
+struct super_block;

 /* Cgroup-specific page state, on top of universal node page state */
 enum memcg_stat_item {
@@ -689,7 +690,8 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 		page_counter_read(&memcg->memory);
 }

-int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp);
+int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp,
+			struct address_space *mapping);

 /**
  * mem_cgroup_charge - Charge a newly allocated folio to a cgroup.
@@ -710,7 +712,7 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 {
 	if (mem_cgroup_disabled())
 		return 0;
-	return __mem_cgroup_charge(folio, mm, gfp);
+	return __mem_cgroup_charge(folio, mm, gfp, NULL);
 }

 int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
@@ -923,6 +925,16 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
 	return !!(memcg->css.flags & CSS_ONLINE);
 }

+bool is_remote_oom(struct mem_cgroup *memcg_under_oom);
+void mem_cgroup_set_charge_target(struct mem_cgroup **target,
+				  struct mem_cgroup *memcg);
+struct mem_cgroup *mem_cgroup_get_from_path(const char *path);
+/**
+ * User is responsible for providing a buffer @buf of length @len and freeing
+ * it.
+ */
+int mem_cgroup_get_name_from_sb(struct super_block *sb, char *buf, size_t len);
+
 void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 		int zid, int nr_pages);

@@ -1217,8 +1229,15 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 	return false;
 }

-static inline int mem_cgroup_charge(struct folio *folio,
-		struct mm_struct *mm, gfp_t gfp)
+static inline int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
+				      gfp_t gfp_mask,
+				      struct address_space *mapping)
+{
+	return 0;
+}
+
+static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
+				    gfp_t gfp_mask)
 {
 	return 0;
 }
@@ -1326,6 +1345,25 @@ static inline void mem_cgroup_iter_break(struct mem_cgroup *root,
 {
 }

+static inline bool is_remote_oom(struct mem_cgroup *memcg_under_oom)
+{
+	return false;
+}
+
+static inline void mem_cgroup_set_charge_target(struct mem_cgroup **target,
+						struct mem_cgroup *memcg)
+{
+}
+
+static inline int mem_cgroup_get_name_from_sb(struct super_block *sb, char *buf,
+					      size_t len)
+{
+	if (len < 1)
+		return -EINVAL;
+	buf[0] = '\0';
+	return 0;
+}
+
 static inline int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 		int (*fn)(struct task_struct *, void *), void *arg)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 6844c9816a864..75e81dfd2c580 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -903,7 +903,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	folio->index = index;

 	if (!huge) {
-		error = mem_cgroup_charge(folio, NULL, gfp);
+		error = __mem_cgroup_charge(folio, NULL, gfp, mapping);
 		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 		if (error)
 			goto error;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 781605e920153..389d2f2be9674 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2580,6 +2580,103 @@ void mem_cgroup_handle_over_high(void)
 	css_put(&memcg->css);
 }

+/*
+ * Non error return value must eventually be released with css_put().
+ */
+struct mem_cgroup *mem_cgroup_get_from_path(const char *path)
+{
+	struct file *file;
+	struct cgroup_subsys_state *css;
+	struct mem_cgroup *memcg;
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
+/*
+ * Get the name of the optional charge target memcg associated with @sb.  This
+ * is the cgroup name, not the cgroup path.
+ */
+int mem_cgroup_get_name_from_sb(struct super_block *sb, char *buf, size_t len)
+{
+	struct mem_cgroup *memcg;
+	int ret = 0;
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
+		return 0;
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
+	return ret < 0 ? ret : 0;
+}
+
+/*
+ * Set or clear (if @memcg is NULL) charge association from file system to
+ * memcg.  If @memcg != NULL, then a css reference must be held by the caller to
+ * ensure that the cgroup is not deleted during this operation.
+ */
+void mem_cgroup_set_charge_target(struct mem_cgroup **target,
+				  struct mem_cgroup *memcg)
+{
+	if (memcg)
+		css_get(&memcg->css);
+	memcg = xchg(target, memcg);
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
@@ -6678,12 +6775,15 @@ static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 	return ret;
 }

-int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
+int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp,
+			struct address_space *mapping)
 {
 	struct mem_cgroup *memcg;
 	int ret;

-	memcg = get_mem_cgroup_from_mm(mm);
+	memcg = mem_cgroup_mapping_get_charge_target(mapping);
+	if (!memcg)
+		memcg = get_mem_cgroup_from_mm(mm);
 	ret = charge_memcg(folio, memcg, gfp);
 	css_put(&memcg->css);

diff --git a/mm/shmem.c b/mm/shmem.c
index 23c91a8beb781..01510fa8ab725 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -115,10 +115,14 @@ struct shmem_options {
 	bool full_inums;
 	int huge;
 	int seen;
+#if CONFIG_MEMCG
+	struct mem_cgroup *memcg;
+#endif
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
 #define SHMEM_SEEN_INUMS 8
+#define SHMEM_SEEN_MEMCG 16
 };

 #ifdef CONFIG_TMPFS
@@ -709,7 +713,8 @@ static int shmem_add_to_page_cache(struct page *page,
 	page->index = index;

 	if (!PageSwapCache(page)) {
-		error = mem_cgroup_charge(page_folio(page), charge_mm, gfp);
+		error = __mem_cgroup_charge(page_folio(page), charge_mm, gfp,
+					    mapping);
 		if (error) {
 			if (PageTransHuge(page)) {
 				count_vm_event(THP_FILE_FALLBACK);
@@ -3342,6 +3347,7 @@ static const struct export_operations shmem_export_ops = {
 enum shmem_param {
 	Opt_gid,
 	Opt_huge,
+	Opt_memcg,
 	Opt_mode,
 	Opt_mpol,
 	Opt_nr_blocks,
@@ -3363,6 +3369,7 @@ static const struct constant_table shmem_param_enums_huge[] = {
 const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_u32   ("gid",		Opt_gid),
 	fsparam_enum  ("huge",		Opt_huge,  shmem_param_enums_huge),
+	fsparam_string("memcg",		Opt_memcg),
 	fsparam_u32oct("mode",		Opt_mode),
 	fsparam_string("mpol",		Opt_mpol),
 	fsparam_string("nr_blocks",	Opt_nr_blocks),
@@ -3379,6 +3386,7 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 	struct shmem_options *ctx = fc->fs_private;
 	struct fs_parse_result result;
 	unsigned long long size;
+	struct mem_cgroup *memcg;
 	char *rest;
 	int opt;

@@ -3412,6 +3420,17 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 			goto bad_value;
 		ctx->seen |= SHMEM_SEEN_INODES;
 		break;
+#ifdef CONFIG_MEMCG
+	case Opt_memcg:
+		if (ctx->memcg)
+			css_put(&ctx->memcg->css);
+		memcg = mem_cgroup_get_from_path(param->string);
+		if (IS_ERR(memcg))
+			goto bad_value;
+		ctx->memcg = memcg;
+		ctx->seen |= SHMEM_SEEN_MEMCG;
+		break;
+#endif
 	case Opt_mode:
 		ctx->mode = result.uint_32 & 07777;
 		break;
@@ -3573,6 +3592,14 @@ static int shmem_reconfigure(struct fs_context *fc)
 	}
 	raw_spin_unlock(&sbinfo->stat_lock);
 	mpol_put(mpol);
+#if CONFIG_MEMCG
+	if (ctx->seen & SHMEM_SEEN_MEMCG && ctx->memcg) {
+		mem_cgroup_set_charge_target(&fc->root->d_sb->s_memcg_to_charge,
+					     ctx->memcg);
+		css_put(&ctx->memcg->css);
+		ctx->memcg = NULL;
+	}
+#endif
 	return 0;
 out:
 	raw_spin_unlock(&sbinfo->stat_lock);
@@ -3582,6 +3609,11 @@ static int shmem_reconfigure(struct fs_context *fc)
 static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(root->d_sb);
+	int err;
+	char *buf = __getname();
+
+	if (!buf)
+		return -ENOMEM;

 	if (sbinfo->max_blocks != shmem_default_max_blocks())
 		seq_printf(seq, ",size=%luk",
@@ -3625,7 +3657,13 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",huge=%s", shmem_format_huge(sbinfo->huge));
 #endif
 	shmem_show_mpol(seq, sbinfo->mpol);
-	return 0;
+	/* Memory cgroup binding: memcg=cgroup_name */
+	err = mem_cgroup_get_name_from_sb(root->d_sb, buf, PATH_MAX);
+	if (!err && buf[0] != '\0')
+		seq_printf(seq, ",memcg=%s", buf);
+
+	__putname(buf);
+	return err;
 }

 #endif /* CONFIG_TMPFS */
@@ -3710,6 +3748,14 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_flags |= SB_POSIXACL;
 #endif
 	uuid_gen(&sb->s_uuid);
+#if CONFIG_MEMCG
+	if (ctx->memcg) {
+		mem_cgroup_set_charge_target(&sb->s_memcg_to_charge,
+					     ctx->memcg);
+		css_put(&ctx->memcg->css);
+		ctx->memcg = NULL;
+	}
+#endif

 	inode = shmem_get_inode(sb, NULL, S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
 	if (!inode)
--
2.34.0.rc0.344.g81b53c2807-goog
