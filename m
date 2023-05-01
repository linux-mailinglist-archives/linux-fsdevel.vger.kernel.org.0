Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60246F34B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjEARCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjEARBY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 13:01:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA6A40C5
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:56:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a3146ed47so15571947b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960188; x=1685552188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lw2pXEBNfkStSvJmyTF2I1dH+bsBIyZ0OpKs2HHzIO8=;
        b=6G5OUnFqmhYzObxhYE56pVPUPb5/Z5fFLyg/xv1k1ELzqtOEByasEUKmpVLdsnIlKz
         +HpmKICNn1SXskm4W84Z1YnQTS1wv+HkfBClJgQjOTklB/JflZpG6ZVI9CkbEHZZ4VtX
         +VU0ocTLcHc6zEEkMfHwEXLiatB8YSa4vtZi59KquEiZLQ8PGIiDrQ9uUD2CTQfE2G7r
         IqwFOlnQ0w6JmNavUX7vfGowmYc1Kgs8nx0nF3FhUsDCRqWZuUIsUlCL/KEMxoHEQqWr
         IxEVdl0XX/ZNM2Oo2w3beOsDv/rdq05Vn6EfHRE3NqnRnISnGzk4Nz7tXYADK5fB+Pd5
         tQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960188; x=1685552188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lw2pXEBNfkStSvJmyTF2I1dH+bsBIyZ0OpKs2HHzIO8=;
        b=F9BNWmmTJR22q3H31+y4ifpCj8jsNR1fX5KO5rP1xMA5wmHmbktrJ5j9V23LE1ScfU
         wMGTszvqNY+0XL0T9txXmQg+4+U2vutUkpAbPj+5XvYwuTSkN5griKYNOrBhxRvke5eb
         hOXhVusgWuTTZ0yZu0gQgEMqFlpKaHxsL6ezhKFMl+6z15RgEMSNrXcywtcdlmowjnB+
         ujDw9/diKgAeSPRHgtjdmc5Bls+/iQPHaLFfHJdlp2g0fgJV+N5AXFZs2hl0nelE5br2
         voO6GJsQ5hn8YzCNbw939ITyKjWoLaHDkqeR9jmexD+3JKCPr673xHxQLFDSV10zY7mp
         Hq0A==
X-Gm-Message-State: AC+VfDzLhch4r5ueC7Rt55kI+emWNwwCVkF/Z0dKljGEa0mB30XbXLpe
        LivvtOepwtvWTIBXBUmNOk1Er9bfrsA=
X-Google-Smtp-Source: ACHHUZ4jn05QWo1AuUjIBZxdqElOhbGVaSLvkqDYZu4aVA/YTY7kkMHxf30EuctFEiweZjTNT8dvorYRrv0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a81:4304:0:b0:55a:c44:6151 with SMTP id
 q4-20020a814304000000b0055a0c446151mr3660331ywa.5.1682960187794; Mon, 01 May
 2023 09:56:27 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:45 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-36-surenb@google.com>
Subject: [PATCH 35/40] lib: implement context capture support for tagged allocations
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement mechanisms for capturing allocation call context which consists
of:
- allocation size
- pid, tgid and name of the allocating task
- allocation timestamp
- allocation call stack
The patch creates allocations.ctx file which can be written to
enable/disable context capture for a specific code tag. Captured context
can be obtained by reading allocations.ctx file.
Usage example:

echo "file include/asm-generic/pgalloc.h line 63 enable" > \
    /sys/kernel/debug/allocations.ctx
cat allocations.ctx
 91.0MiB      212 include/asm-generic/pgalloc.h:63 module:pgtable func:__pte_alloc_one
    size: 4096
    pid: 1551
    tgid: 1551
    comm: cat
    ts: 670109646361
    call stack:
         pte_alloc_one+0xfe/0x130
         __pte_alloc+0x22/0x90
         move_page_tables.part.0+0x994/0xa60
         shift_arg_pages+0xa4/0x180
         setup_arg_pages+0x286/0x2d0
         load_elf_binary+0x4e1/0x18d0
         bprm_execve+0x26b/0x660
         do_execveat_common.isra.0+0x19d/0x220
         __x64_sys_execve+0x2e/0x40
         do_syscall_64+0x38/0x90
         entry_SYSCALL_64_after_hwframe+0x63/0xcd

    size: 4096
    pid: 1551
    tgid: 1551
    comm: cat
    ts: 670109711801
    call stack:
         pte_alloc_one+0xfe/0x130
         __do_fault+0x52/0xc0
         __handle_mm_fault+0x7d9/0xdd0
         handle_mm_fault+0xc0/0x2b0
         do_user_addr_fault+0x1c3/0x660
         exc_page_fault+0x62/0x150
         asm_exc_page_fault+0x22/0x30
...

echo "file include/asm-generic/pgalloc.h line 63 disable" > \
    /sys/kernel/debug/alloc_tags.ctx

Note that disabling context capture will not clear already captured
context but no new context will be captured.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h   |  25 +++-
 include/linux/codetag.h     |   3 +-
 include/linux/pgalloc_tag.h |   4 +-
 lib/Kconfig.debug           |   1 +
 lib/alloc_tag.c             | 238 +++++++++++++++++++++++++++++++++++-
 lib/codetag.c               |  20 +--
 6 files changed, 272 insertions(+), 19 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 07922d81b641..2a3d248aae10 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -17,20 +17,29 @@
  * an array of these. Embedded codetag utilizes codetag framework.
  */
 struct alloc_tag {
-	struct codetag			ct;
+	struct codetag_with_ctx		ctc;
 	struct lazy_percpu_counter	bytes_allocated;
 } __aligned(8);
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
+static inline struct alloc_tag *ctc_to_alloc_tag(struct codetag_with_ctx *ctc)
+{
+	return container_of(ctc, struct alloc_tag, ctc);
+}
+
 static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
 {
-	return container_of(ct, struct alloc_tag, ct);
+	return container_of(ct_to_ctc(ct), struct alloc_tag, ctc);
 }
 
+struct codetag_ctx *alloc_tag_create_ctx(struct alloc_tag *tag, size_t size);
+void alloc_tag_free_ctx(struct codetag_ctx *ctx, struct alloc_tag **ptag);
+bool alloc_tag_enable_ctx(struct alloc_tag *tag, bool enable);
+
 #define DEFINE_ALLOC_TAG(_alloc_tag, _old)				\
 	static struct alloc_tag _alloc_tag __used __aligned(8)		\
-	__section("alloc_tags") = { .ct = CODE_TAG_INIT };		\
+	__section("alloc_tags") = { .ctc.ct = CODE_TAG_INIT };		\
 	struct alloc_tag * __maybe_unused _old = alloc_tag_save(&_alloc_tag)
 
 extern struct static_key_true mem_alloc_profiling_key;
@@ -54,7 +63,10 @@ static inline void __alloc_tag_sub(union codetag_ref *ref, size_t bytes,
 	if (!ref || !ref->ct)
 		return;
 
-	tag = ct_to_alloc_tag(ref->ct);
+	if (is_codetag_ctx_ref(ref))
+		alloc_tag_free_ctx(ref->ctx, &tag);
+	else
+		tag = ct_to_alloc_tag(ref->ct);
 
 	if (may_allocate)
 		lazy_percpu_counter_add(&tag->bytes_allocated, -bytes);
@@ -88,7 +100,10 @@ static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
 	if (!ref || !tag)
 		return;
 
-	ref->ct = &tag->ct;
+	if (codetag_ctx_enabled(&tag->ctc))
+		ref->ctx = alloc_tag_create_ctx(tag, bytes);
+	else
+		ref->ct = &tag->ctc.ct;
 	lazy_percpu_counter_add(&tag->bytes_allocated, bytes);
 }
 
diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index 9ab2f017e845..b6a2f0287a83 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -104,7 +104,8 @@ struct codetag_with_ctx *ct_to_ctc(struct codetag *ct)
 }
 
 void codetag_lock_module_list(struct codetag_type *cttype, bool lock);
-struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype);
+void codetag_init_iter(struct codetag_iterator *iter,
+		       struct codetag_type *cttype);
 struct codetag *codetag_next_ct(struct codetag_iterator *iter);
 struct codetag_ctx *codetag_next_ctx(struct codetag_iterator *iter);
 
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 0cbba13869b5..e4661bbd40c6 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -6,6 +6,7 @@
 #define _LINUX_PGALLOC_TAG_H
 
 #include <linux/alloc_tag.h>
+#include <linux/codetag_ctx.h>
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
@@ -70,7 +71,8 @@ static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
 	if (!ref->ct)
 		goto out;
 
-	tag = ct_to_alloc_tag(ref->ct);
+	tag = is_codetag_ctx_ref(ref) ? ctc_to_alloc_tag(ref->ctx->ctc)
+				      : ct_to_alloc_tag(ref->ct);
 	page_ext = page_ext_next(page_ext);
 	for (i = 1; i < nr; i++) {
 		/* New reference with 0 bytes accounted */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4157c2251b07..1b83ef17d232 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -969,6 +969,7 @@ config MEM_ALLOC_PROFILING
 	select LAZY_PERCPU_COUNTER
 	select PAGE_EXTENSION
 	select SLAB_OBJ_EXT
+	select STACKDEPOT
 	help
 	  Track allocation source code and record total allocation size
 	  initiated at that code location. The mechanism can be used to track
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 4a0b95a46b2e..675c7a08e38b 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -1,13 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/alloc_tag.h>
+#include <linux/codetag_ctx.h>
 #include <linux/debugfs.h>
 #include <linux/fs.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
 #include <linux/page_ext.h>
+#include <linux/sched/clock.h>
 #include <linux/seq_buf.h>
+#include <linux/stackdepot.h>
 #include <linux/uaccess.h>
 
+#define STACK_BUF_SIZE 1024
+
 DEFINE_STATIC_KEY_TRUE(mem_alloc_profiling_key);
 
 /*
@@ -23,6 +28,16 @@ static int __init mem_alloc_profiling_disable(char *s)
 }
 __setup("nomem_profiling", mem_alloc_profiling_disable);
 
+struct alloc_call_ctx {
+	struct codetag_ctx ctx;
+	size_t size;
+	pid_t pid;
+	pid_t tgid;
+	char comm[TASK_COMM_LEN];
+	u64 ts_nsec;
+	depot_stack_handle_t stack_handle;
+} __aligned(8);
+
 struct alloc_tag_file_iterator {
 	struct codetag_iterator ct_iter;
 	struct seq_buf		buf;
@@ -64,7 +79,7 @@ static int allocations_file_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	codetag_lock_module_list(cttype, true);
-	iter->ct_iter = codetag_get_ct_iter(cttype);
+	codetag_init_iter(&iter->ct_iter, cttype);
 	codetag_lock_module_list(cttype, false);
 	seq_buf_init(&iter->buf, iter->rawbuf, sizeof(iter->rawbuf));
 	file->private_data = iter;
@@ -125,24 +140,240 @@ static const struct file_operations allocations_file_ops = {
 	.read	= allocations_file_read,
 };
 
+static void alloc_tag_ops_free_ctx(struct kref *refcount)
+{
+	kfree(container_of(kref_to_ctx(refcount), struct alloc_call_ctx, ctx));
+}
+
+struct codetag_ctx *alloc_tag_create_ctx(struct alloc_tag *tag, size_t size)
+{
+	struct alloc_call_ctx *ac_ctx;
+
+	/* TODO: use a dedicated kmem_cache */
+	ac_ctx = kmalloc(sizeof(struct alloc_call_ctx), GFP_KERNEL);
+	if (WARN_ON(!ac_ctx))
+		return NULL;
+
+	ac_ctx->size = size;
+	ac_ctx->pid = current->pid;
+	ac_ctx->tgid = current->tgid;
+	strscpy(ac_ctx->comm, current->comm, sizeof(ac_ctx->comm));
+	ac_ctx->ts_nsec = local_clock();
+	ac_ctx->stack_handle =
+			stack_depot_capture_stack(GFP_NOWAIT | __GFP_NOWARN);
+	add_ctx(&ac_ctx->ctx, &tag->ctc);
+
+	return &ac_ctx->ctx;
+}
+EXPORT_SYMBOL_GPL(alloc_tag_create_ctx);
+
+void alloc_tag_free_ctx(struct codetag_ctx *ctx, struct alloc_tag **ptag)
+{
+	*ptag = ctc_to_alloc_tag(ctx->ctc);
+	rem_ctx(ctx, alloc_tag_ops_free_ctx);
+}
+EXPORT_SYMBOL_GPL(alloc_tag_free_ctx);
+
+bool alloc_tag_enable_ctx(struct alloc_tag *tag, bool enable)
+{
+	static bool stack_depot_ready;
+
+	if (enable && !stack_depot_ready) {
+		stack_depot_init();
+		stack_depot_capture_init();
+		stack_depot_ready = true;
+	}
+
+	return codetag_enable_ctx(&tag->ctc, enable);
+}
+
+static void alloc_tag_ctx_to_text(struct seq_buf *out, struct codetag_ctx *ctx)
+{
+	struct alloc_call_ctx *ac_ctx;
+	char *buf;
+
+	ac_ctx = container_of(ctx, struct alloc_call_ctx, ctx);
+	seq_buf_printf(out, "    size: %zu\n", ac_ctx->size);
+	seq_buf_printf(out, "    pid: %d\n", ac_ctx->pid);
+	seq_buf_printf(out, "    tgid: %d\n", ac_ctx->tgid);
+	seq_buf_printf(out, "    comm: %s\n", ac_ctx->comm);
+	seq_buf_printf(out, "    ts: %llu\n", ac_ctx->ts_nsec);
+
+	buf = kmalloc(STACK_BUF_SIZE, GFP_KERNEL);
+	if (buf) {
+		int bytes_read = stack_depot_snprint(ac_ctx->stack_handle, buf,
+						     STACK_BUF_SIZE - 1, 8);
+		buf[bytes_read] = '\0';
+		seq_buf_printf(out, "    call stack:\n%s\n", buf);
+	}
+	kfree(buf);
+}
+
+static ssize_t allocations_ctx_file_read(struct file *file, char __user *ubuf,
+					 size_t size, loff_t *ppos)
+{
+	struct alloc_tag_file_iterator *iter = file->private_data;
+	struct codetag_iterator *ct_iter = &iter->ct_iter;
+	struct user_buf	buf = { .buf = ubuf, .size = size };
+	struct codetag_ctx *ctx;
+	struct codetag *prev_ct;
+	int err = 0;
+
+	codetag_lock_module_list(ct_iter->cttype, true);
+	while (1) {
+		err = flush_ubuf(&buf, &iter->buf);
+		if (err || !buf.size)
+			break;
+
+		prev_ct = ct_iter->ct;
+		ctx = codetag_next_ctx(ct_iter);
+		if (!ctx)
+			break;
+
+		if (prev_ct != &ctx->ctc->ct)
+			alloc_tag_to_text(&iter->buf, &ctx->ctc->ct);
+		alloc_tag_ctx_to_text(&iter->buf, ctx);
+	}
+	codetag_lock_module_list(ct_iter->cttype, false);
+
+	return err ? : buf.ret;
+}
+
+#define CTX_CAPTURE_TOKENS()	\
+	x(disable,	0)	\
+	x(enable,	0)
+
+static const char * const ctx_capture_token_strs[] = {
+#define x(name, nr_args)	#name,
+	CTX_CAPTURE_TOKENS()
+#undef x
+	NULL
+};
+
+enum ctx_capture_token {
+#define x(name, nr_args)	TOK_##name,
+	CTX_CAPTURE_TOKENS()
+#undef x
+};
+
+static int enable_ctx_capture(struct codetag_type *cttype,
+			      struct codetag_query *query, bool enable)
+{
+	struct codetag_iterator ct_iter;
+	struct codetag_with_ctx *ctc;
+	struct codetag *ct;
+	unsigned int nfound = 0;
+
+	codetag_lock_module_list(cttype, true);
+
+	codetag_init_iter(&ct_iter, cttype);
+	while ((ct = codetag_next_ct(&ct_iter))) {
+		if (!codetag_matches_query(query, ct, ct_iter.cmod, NULL))
+			continue;
+
+		ctc = ct_to_ctc(ct);
+		if (codetag_ctx_enabled(ctc) == enable)
+			continue;
+
+		if (!alloc_tag_enable_ctx(ctc_to_alloc_tag(ctc), enable)) {
+			pr_warn("Failed to toggle context capture\n");
+			continue;
+		}
+
+		nfound++;
+	}
+
+	codetag_lock_module_list(cttype, false);
+
+	return nfound ? 0 : -ENOENT;
+}
+
+static int parse_command(struct codetag_type *cttype, char *buf)
+{
+	struct codetag_query query = { NULL };
+	char *cmd;
+	int ret;
+	int tok;
+
+	buf = codetag_query_parse(&query, buf);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	cmd = strsep_no_empty(&buf, " \t\r\n");
+	if (!cmd)
+		return -EINVAL;	/* no command */
+
+	tok = match_string(ctx_capture_token_strs,
+			   ARRAY_SIZE(ctx_capture_token_strs), cmd);
+	if (tok < 0)
+		return -EINVAL;	/* unknown command */
+
+	ret = enable_ctx_capture(cttype, &query, tok == TOK_enable);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static ssize_t allocations_ctx_file_write(struct file *file, const char __user *ubuf,
+					  size_t len, loff_t *offp)
+{
+	struct alloc_tag_file_iterator *iter = file->private_data;
+	char tmpbuf[256];
+
+	if (len == 0)
+		return 0;
+	/* we don't check *offp -- multiple writes() are allowed */
+	if (len > sizeof(tmpbuf) - 1)
+		return -E2BIG;
+
+	if (copy_from_user(tmpbuf, ubuf, len))
+		return -EFAULT;
+
+	tmpbuf[len] = '\0';
+	parse_command(iter->ct_iter.cttype, tmpbuf);
+
+	*offp += len;
+	return len;
+}
+
+static const struct file_operations allocations_ctx_file_ops = {
+	.owner	= THIS_MODULE,
+	.open	= allocations_file_open,
+	.release = allocations_file_release,
+	.read	= allocations_ctx_file_read,
+	.write	= allocations_ctx_file_write,
+};
+
 static int __init dbgfs_init(struct codetag_type *cttype)
 {
 	struct dentry *file;
+	struct dentry *ctx_file;
 
 	file = debugfs_create_file("allocations", 0444, NULL, cttype,
 				   &allocations_file_ops);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ctx_file = debugfs_create_file("allocations.ctx", 0666, NULL, cttype,
+				       &allocations_ctx_file_ops);
+	if (IS_ERR(ctx_file)) {
+		debugfs_remove(file);
+		return PTR_ERR(ctx_file);
+	}
 
-	return IS_ERR(file) ? PTR_ERR(file) : 0;
+	return 0;
 }
 
 static bool alloc_tag_module_unload(struct codetag_type *cttype, struct codetag_module *cmod)
 {
-	struct codetag_iterator iter = codetag_get_ct_iter(cttype);
+	struct codetag_iterator iter;
 	bool module_unused = true;
 	struct alloc_tag *tag;
 	struct codetag *ct;
 	size_t bytes;
 
+	codetag_init_iter(&iter, cttype);
 	for (ct = codetag_next_ct(&iter); ct; ct = codetag_next_ct(&iter)) {
 		if (iter.cmod != cmod)
 			continue;
@@ -183,6 +414,7 @@ static int __init alloc_tag_init(void)
 		.section	= "alloc_tags",
 		.tag_size	= sizeof(struct alloc_tag),
 		.module_unload	= alloc_tag_module_unload,
+		.free_ctx	= alloc_tag_ops_free_ctx,
 	};
 
 	cttype = codetag_register_type(&desc);
diff --git a/lib/codetag.c b/lib/codetag.c
index d891bbe4481d..cbff146b3fe8 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -27,16 +27,14 @@ void codetag_lock_module_list(struct codetag_type *cttype, bool lock)
 		up_read(&cttype->mod_lock);
 }
 
-struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype)
+void codetag_init_iter(struct codetag_iterator *iter,
+		       struct codetag_type *cttype)
 {
-	struct codetag_iterator iter = {
-		.cttype = cttype,
-		.cmod = NULL,
-		.mod_id = 0,
-		.ct = NULL,
-	};
-
-	return iter;
+	iter->cttype = cttype;
+	iter->cmod = NULL;
+	iter->mod_id = 0;
+	iter->ct = NULL;
+	iter->ctx = NULL;
 }
 
 static inline struct codetag *get_first_module_ct(struct codetag_module *cmod)
@@ -128,6 +126,10 @@ struct codetag_ctx *codetag_next_ctx(struct codetag_iterator *iter)
 
 	lockdep_assert_held(&iter->cttype->mod_lock);
 
+	/* Move to the first codetag if search just started */
+	if (!iter->ct)
+		codetag_next_ct(iter);
+
 	if (!ctx)
 		return next_ctx_from_ct(iter);
 
-- 
2.40.1.495.gc816e09b53d-goog

