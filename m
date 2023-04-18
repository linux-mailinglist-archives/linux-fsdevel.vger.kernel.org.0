Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154DA6E570B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjDRBpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjDRBob (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:44:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10393D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f69fb5cafso190556127b3.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782118; x=1684374118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAO1Q9dHIBUjzlD7EaIYD+isx8yohgW2kA3a//3wT4c=;
        b=Kll014u8X4/3frsvKv6leX7edC+R7R1Svq3qo68yXW+C9ILWLgAfAjeNGMvs85FLGh
         zRrNJAuImgvQ5aLqSDs6M3APLSG0xdaiP4iK1agE9vnbv/bb9c9BBSAvBPElsvcznwhS
         18Td8YTl8Nbb5K44I/dYYJ0RKx30ve0GpDthDWt69IIdqj5AW7DXB5TyEF4h/R+gSB59
         20TGhlcI9NUnrlAgE2aCP3qYcsMrg8xF371ZknTy0YTdphlpmwpe1R4AMCUMeHYSZNSm
         B6IbrnWBvKY3/GcoP2N2xJuw2VM6t3g9rGLiGtVmfAxmLksP2oeb1gliWysDzZiaXu/O
         zeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782118; x=1684374118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAO1Q9dHIBUjzlD7EaIYD+isx8yohgW2kA3a//3wT4c=;
        b=hDIcItf/SQmExUEgDkqkLXCl4cViBupo85FGyZc5BLQ3uG87l22qCh/iyg0wcbfJy/
         zDTwP32KpdqmuID8EI73HVSyN5CaiCVuCIZpe0x4RedMQuI1BEfhwB1cVNRRlw/blTIw
         mlpxs6lgVaFglIqArsXkTPh0WN5hvDnSZ6z5joUrkeHHRAY4NALp5kJhyVmoAGXbQ+J/
         TG1yaInbc31shrkAav5rZMwcOVSGa3Ekj+YLTPriypJBzAqQL2g+Dn1M6pmJQr6kvRJI
         ariAWd16n0nUt+/Ugbnim9ip59C+r6TG6BjSzDWydURo9ckeWCnXjPUWtWwtJcvnaTZA
         cwrw==
X-Gm-Message-State: AAQBX9epEjHKR3DL0gb18R7vYhloW47b1yAZ+d+ZTWoOhnomQaGd0Wgo
        /7s/d1UQLXbskcuopoRy+EPGUKW4qPc=
X-Google-Smtp-Source: AKy350b2qWWm6u3O3O0nJnqw2v6qkgnCPTFrenW321HSICqNzQeyV4bIcR+CmpW2E20ABopGYna2UCgS8Vs=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a0d:ec02:0:b0:54c:2723:560d with SMTP id
 q2-20020a0dec02000000b0054c2723560dmr10855330ywn.3.1681782118566; Mon, 17 Apr
 2023 18:41:58 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:30 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-31-drosen@google.com>
Subject: [RFC PATCH v3 30/37] fuse: Provide registration functions for fuse-bpf
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
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

Fuse may be built as a module, but verifier components are not. This
provides a means for fuse-bpf to handle struct op programs once the
module is loaded.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/Makefile         |   2 +-
 fs/fuse/backing.c        |   2 +
 fs/fuse/bpf_register.c   | 209 +++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h         |  26 +++++
 include/linux/bpf_fuse.h |   8 ++
 5 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100644 fs/fuse/bpf_register.c

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index a0853c439db2..903253db7285 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -9,6 +9,6 @@ obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
-fuse-$(CONFIG_FUSE_BPF) += backing.o
+fuse-$(CONFIG_FUSE_BPF) += backing.o bpf_register.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index e807ae4f6f53..898ef9e05e9d 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -3360,6 +3360,7 @@ int fuse_bpf_access(int *out, struct inode *inode, int mask)
 
 int __init fuse_bpf_init(void)
 {
+	init_fuse_bpf();
 	fuse_bpf_aio_request_cachep = kmem_cache_create("fuse_bpf_aio_req",
 						   sizeof(struct fuse_bpf_aio_req),
 						   0, SLAB_HWCACHE_ALIGN, NULL);
@@ -3371,5 +3372,6 @@ int __init fuse_bpf_init(void)
 
 void __exit fuse_bpf_cleanup(void)
 {
+	uninit_fuse_bpf();
 	kmem_cache_destroy(fuse_bpf_aio_request_cachep);
 }
diff --git a/fs/fuse/bpf_register.c b/fs/fuse/bpf_register.c
new file mode 100644
index 000000000000..dfe15dcf3477
--- /dev/null
+++ b/fs/fuse/bpf_register.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FUSE-BPF: Filesystem in Userspace with BPF
+ * Copyright (c) 2021 Google LLC
+ */
+
+#include <linux/bpf_verifier.h>
+#include <linux/bpf_fuse.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/hashtable.h>
+
+#include "fuse_i.h"
+
+struct fuse_ops tmp_f_op_empty = { 0 };
+struct fuse_ops *tmp_f_op = &tmp_f_op_empty;
+
+struct hashtable_entry {
+	struct hlist_node hlist;
+	struct hlist_node dlist; /* for deletion cleanup */
+	struct qstr key;
+	struct fuse_ops *ops;
+};
+
+static DEFINE_HASHTABLE(name_to_ops, 8);
+
+static unsigned int full_name_case_hash(const void *salt, const unsigned char *name, unsigned int len)
+{
+	unsigned long hash = init_name_hash(salt);
+
+	while (len--)
+		hash = partial_name_hash(tolower(*name++), hash);
+	return end_name_hash(hash);
+}
+
+static inline void qstr_init(struct qstr *q, const char *name)
+{
+	q->name = name;
+	q->len = strlen(q->name);
+	q->hash = full_name_case_hash(0, q->name, q->len);
+}
+
+static inline int qstr_copy(const struct qstr *src, struct qstr *dest)
+{
+	dest->name = kstrdup(src->name, GFP_KERNEL);
+	dest->hash_len = src->hash_len;
+	return !!dest->name;
+}
+
+static inline int qstr_eq(const struct qstr *s1, const struct qstr *s2)
+{
+	int res, r1, r2, r3;
+
+	r1 = s1->len == s2->len;
+	r2 = s1->hash == s2->hash;
+	r3 = memcmp(s1->name, s2->name, s1->len);
+	res = (s1->len == s2->len && s1->hash == s2->hash && !memcmp(s1->name, s2->name, s1->len));
+	return res;
+}
+
+static struct fuse_ops *__find_fuse_ops(const struct qstr *key)
+{
+	struct hashtable_entry *hash_cur;
+	unsigned int hash = key->hash;
+	struct fuse_ops *ret_ops;
+
+	rcu_read_lock();
+	hash_for_each_possible_rcu(name_to_ops, hash_cur, hlist, hash) {
+		if (qstr_eq(key, &hash_cur->key)) {
+			ret_ops = hash_cur->ops;
+			ret_ops = get_fuse_ops(ret_ops);
+			rcu_read_unlock();
+			return ret_ops;
+		}
+	}
+	rcu_read_unlock();
+	return NULL;
+}
+
+struct fuse_ops *get_fuse_ops(struct fuse_ops *ops)
+{
+	if (bpf_try_module_get(ops, BPF_MODULE_OWNER))
+		return ops;
+	else
+		return NULL;
+}
+
+void put_fuse_ops(struct fuse_ops *ops)
+{
+	if (ops)
+		bpf_module_put(ops, BPF_MODULE_OWNER);
+}
+
+struct fuse_ops *find_fuse_ops(const char *key)
+{
+	struct qstr q;
+
+	qstr_init(&q, key);
+	return __find_fuse_ops(&q);
+}
+
+static struct hashtable_entry *alloc_hashtable_entry(const struct qstr *key,
+		struct fuse_ops *value)
+{
+	struct hashtable_entry *ret = kzalloc(sizeof(*ret), GFP_KERNEL);
+	if (!ret)
+		return NULL;
+	INIT_HLIST_NODE(&ret->dlist);
+	INIT_HLIST_NODE(&ret->hlist);
+
+	if (!qstr_copy(key, &ret->key)) {
+		kfree(ret);
+		return NULL;
+	}
+
+	ret->ops = value;
+	return ret;
+}
+
+static int __register_fuse_op(struct fuse_ops *value)
+{
+	struct hashtable_entry *hash_cur;
+	struct hashtable_entry *new_entry;
+	struct qstr key;
+	unsigned int hash;
+
+	qstr_init(&key, value->name);
+	hash = key.hash;
+	hash_for_each_possible_rcu(name_to_ops, hash_cur, hlist, hash) {
+		if (qstr_eq(&key, &hash_cur->key)) {
+			return -EEXIST;
+		}
+	}
+	new_entry = alloc_hashtable_entry(&key, value);
+	if (!new_entry)
+		return -ENOMEM;
+	hash_add_rcu(name_to_ops, &new_entry->hlist, hash);
+	return 0;
+}
+
+static int register_fuse_op(struct fuse_ops *value)
+{
+	int err;
+
+	if (bpf_try_module_get(value, BPF_MODULE_OWNER))
+		err = __register_fuse_op(value);
+	else
+		return -EBUSY;
+
+	return err;
+}
+
+static void unregister_fuse_op(struct fuse_ops *value)
+{
+	struct hashtable_entry *hash_cur;
+	struct qstr key;
+	unsigned int hash;
+	struct hlist_node *h_t;
+	HLIST_HEAD(free_list);
+
+	qstr_init(&key, value->name);
+	hash = key.hash;
+
+	hash_for_each_possible_rcu(name_to_ops, hash_cur, hlist, hash) {
+		if (qstr_eq(&key, &hash_cur->key)) {
+			hash_del_rcu(&hash_cur->hlist);
+			hlist_add_head(&hash_cur->dlist, &free_list);
+		}
+	}
+	synchronize_rcu();
+	bpf_module_put(value, BPF_MODULE_OWNER);
+	hlist_for_each_entry_safe(hash_cur, h_t, &free_list, dlist)
+		kfree(hash_cur);
+}
+
+static void fuse_op_list_destroy(void)
+{
+	struct hashtable_entry *hash_cur;
+	struct hlist_node *h_t;
+	HLIST_HEAD(free_list);
+	int i;
+
+	//mutex_lock(&sdcardfs_super_list_lock);
+	hash_for_each_rcu(name_to_ops, i, hash_cur, hlist) {
+		hash_del_rcu(&hash_cur->hlist);
+		hlist_add_head(&hash_cur->dlist, &free_list);
+	}
+	synchronize_rcu();
+	hlist_for_each_entry_safe(hash_cur, h_t, &free_list, dlist)
+		kfree(hash_cur);
+	//mutex_unlock(&sdcardfs_super_list_lock);
+	pr_info("fuse: destroyed fuse_op list\n");
+}
+
+static struct bpf_fuse_ops_attach bpf_fuse_ops_connect = {
+	.fuse_register_bpf = &register_fuse_op,
+	.fuse_unregister_bpf = &unregister_fuse_op,
+};
+
+int init_fuse_bpf(void)
+{
+	return register_fuse_bpf(&bpf_fuse_ops_connect);
+}
+
+void uninit_fuse_bpf(void)
+{
+	unregister_fuse_bpf(&bpf_fuse_ops_connect);
+	fuse_op_list_destroy();
+}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 2bd45c8658e8..84c591d02e43 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1390,6 +1390,32 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
 /* backing.c */
+#ifdef CONFIG_FUSE_BPF
+struct fuse_ops *find_fuse_ops(const char *key);
+struct fuse_ops *get_fuse_ops(struct fuse_ops *ops);
+void put_fuse_ops(struct fuse_ops *ops);
+int init_fuse_bpf(void);
+void uninit_fuse_bpf(void);
+#else
+int init_fuse_bpf(void)
+{
+	return -EOPNOTSUPP;
+}
+void uninit_fuse_bpf(void)
+{
+}
+struct fuse_ops *find_fuse_ops(const char *key)
+{
+	return NULL;
+}
+struct fuse_ops *get_fuse_ops(struct fuse_ops *ops)
+{
+	return NULL;
+}
+void put_fuse_ops(struct fuse_ops *ops)
+{
+}
+#endif
 
 enum fuse_bpf_set {
 	FUSE_BPF_UNCHANGED = 0,
diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
index 780a7889aea2..2183a7a45c92 100644
--- a/include/linux/bpf_fuse.h
+++ b/include/linux/bpf_fuse.h
@@ -270,4 +270,12 @@ struct fuse_ops {
 	char name[BPF_FUSE_NAME_MAX];
 };
 
+struct bpf_fuse_ops_attach {
+	int (*fuse_register_bpf)(struct fuse_ops *f_ops);
+	void (*fuse_unregister_bpf)(struct fuse_ops *f_ops);
+};
+
+int register_fuse_bpf(struct bpf_fuse_ops_attach *reg_ops);
+void unregister_fuse_bpf(struct bpf_fuse_ops_attach *reg_ops);
+
 #endif /* _BPF_FUSE_H */
-- 
2.40.0.634.g4ca3ef3211-goog

