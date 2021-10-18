Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5584317E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 13:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhJRLt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 07:49:56 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:33504 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhJRLtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:49:47 -0400
Received: by mail-ed1-f42.google.com with SMTP id y30so51975966edi.0;
        Mon, 18 Oct 2021 04:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQ9vGBplovxkjkXfQYlY3shu8H3p0LkLkA5L8hbsn4g=;
        b=neeztIQItFBWSDlzv+EeuRptlMPmrJ22aFAAexUoQT6REgdsYjnnpxoq5bfjpAe9j1
         Msqb5wirWrcaguEsgz199i9LG0vy0VdGfcViQHNtWKYntynd4x/ZyCEaX4SsD01Y8wIY
         nSDE+bDo0ZUGqPtSkC7XvDKY3O1Afk7oSMd2KrXN0o9uKwW32cZG60yPoMXV9Ow1kT9r
         hysWyNdi5jvoDk4As7ZpC+bcKQFGCUF/dRLdAD6qIVnMRwoik2kuXfRtxzdpumcYW/Ui
         biVyN+MihjONqU7ibLKj/ZB2zc7o92T0b0Q85o0OGDYsnTbSk66cZ6rqckqOLpTEKfIW
         ld6Q==
X-Gm-Message-State: AOAM531Z7bGtLAVhfuKkcjyM0xj+6guQbYJNRIdKVZhz2ajjtBT4IzY9
        oODd8ZsJPxbuDMxDkKeplbc=
X-Google-Smtp-Source: ABdhPJxH7akfI7MYypqxGlSyOwxwmopqyA/cOk5HYHG7CD5PbWSL9XfZKK6k+XVi75CQKzU+7Lvfjw==
X-Received: by 2002:a17:906:3c51:: with SMTP id i17mr29943628ejg.86.1634557649682;
        Mon, 18 Oct 2021 04:47:29 -0700 (PDT)
Received: from localhost.localdomain (ip-85-160-35-99.eurotel.cz. [85.160.35.99])
        by smtp.gmail.com with ESMTPSA id b2sm9587458edv.73.2021.10.18.04.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 04:47:29 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC 3/3] mm: allow !GFP_KERNEL allocations for kvmalloc
Date:   Mon, 18 Oct 2021 13:47:12 +0200
Message-Id: <20211018114712.9802-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018114712.9802-1-mhocko@kernel.org>
References: <20211018114712.9802-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

A support for GFP_NO{FS,IO} and __GFP_NOFAIL has been implemented
by previous patches so we can allow the support for kvmalloc. This
will allow some external users to simplify or completely remove
their helpers.

GFP_NOWAIT semantic hasn't been supported so far but it hasn't been
explicitly documented so let's add a note about that.

ceph_kvmalloc is the first helper to be dropped and changed to
kvmalloc.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/ceph/libceph.h |  1 -
 mm/util.c                    | 15 ++++-----------
 net/ceph/buffer.c            |  4 ++--
 net/ceph/ceph_common.c       | 27 ---------------------------
 net/ceph/crypto.c            |  2 +-
 net/ceph/messenger.c         |  2 +-
 net/ceph/messenger_v2.c      |  2 +-
 net/ceph/osdmap.c            | 12 ++++++------
 8 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 409d8c29bc4f..309acbcb5a8a 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -295,7 +295,6 @@ extern bool libceph_compatible(void *data);
 
 extern const char *ceph_msg_type_name(int type);
 extern int ceph_check_fsid(struct ceph_client *client, struct ceph_fsid *fsid);
-extern void *ceph_kvmalloc(size_t size, gfp_t flags);
 
 struct fs_parameter;
 struct fc_log;
diff --git a/mm/util.c b/mm/util.c
index bacabe446906..fdec6b4b1267 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -549,13 +549,10 @@ EXPORT_SYMBOL(vm_mmap);
  * Uses kmalloc to get the memory but if the allocation fails then falls back
  * to the vmalloc allocator. Use kvfree for freeing the memory.
  *
- * Reclaim modifiers - __GFP_NORETRY and __GFP_NOFAIL are not supported.
+ * Reclaim modifiers - __GFP_NORETRY and GFP_NOWAIT are not supported.
  * __GFP_RETRY_MAYFAIL is supported, and it should be used only if kmalloc is
  * preferable to the vmalloc fallback, due to visible performance drawbacks.
  *
- * Please note that any use of gfp flags outside of GFP_KERNEL is careful to not
- * fall back to vmalloc.
- *
  * Return: pointer to the allocated memory of %NULL in case of failure
  */
 void *kvmalloc_node(size_t size, gfp_t flags, int node)
@@ -563,13 +560,6 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	gfp_t kmalloc_flags = flags;
 	void *ret;
 
-	/*
-	 * vmalloc uses GFP_KERNEL for some internal allocations (e.g page tables)
-	 * so the given set of flags has to be compatible.
-	 */
-	if ((flags & GFP_KERNEL) != GFP_KERNEL)
-		return kmalloc_node(size, flags, node);
-
 	/*
 	 * We want to attempt a large physically contiguous block first because
 	 * it is less likely to fragment multiple larger blocks and therefore
@@ -582,6 +572,9 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 
 		if (!(kmalloc_flags & __GFP_RETRY_MAYFAIL))
 			kmalloc_flags |= __GFP_NORETRY;
+
+		/* nofail semantic is implemented by the vmalloc fallback */
+		kmalloc_flags &= ~__GFP_NOFAIL;
 	}
 
 	ret = kmalloc_node(size, kmalloc_flags, node);
diff --git a/net/ceph/buffer.c b/net/ceph/buffer.c
index 5622763ad402..7e51f128045d 100644
--- a/net/ceph/buffer.c
+++ b/net/ceph/buffer.c
@@ -7,7 +7,7 @@
 
 #include <linux/ceph/buffer.h>
 #include <linux/ceph/decode.h>
-#include <linux/ceph/libceph.h> /* for ceph_kvmalloc */
+#include <linux/ceph/libceph.h> /* for kvmalloc */
 
 struct ceph_buffer *ceph_buffer_new(size_t len, gfp_t gfp)
 {
@@ -17,7 +17,7 @@ struct ceph_buffer *ceph_buffer_new(size_t len, gfp_t gfp)
 	if (!b)
 		return NULL;
 
-	b->vec.iov_base = ceph_kvmalloc(len, gfp);
+	b->vec.iov_base = kvmalloc(len, gfp);
 	if (!b->vec.iov_base) {
 		kfree(b);
 		return NULL;
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 97d6ea763e32..9441b4a4912b 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -190,33 +190,6 @@ int ceph_compare_options(struct ceph_options *new_opt,
 }
 EXPORT_SYMBOL(ceph_compare_options);
 
-/*
- * kvmalloc() doesn't fall back to the vmalloc allocator unless flags are
- * compatible with (a superset of) GFP_KERNEL.  This is because while the
- * actual pages are allocated with the specified flags, the page table pages
- * are always allocated with GFP_KERNEL.
- *
- * ceph_kvmalloc() may be called with GFP_KERNEL, GFP_NOFS or GFP_NOIO.
- */
-void *ceph_kvmalloc(size_t size, gfp_t flags)
-{
-	void *p;
-
-	if ((flags & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS)) {
-		p = kvmalloc(size, flags);
-	} else if ((flags & (__GFP_IO | __GFP_FS)) == __GFP_IO) {
-		unsigned int nofs_flag = memalloc_nofs_save();
-		p = kvmalloc(size, GFP_KERNEL);
-		memalloc_nofs_restore(nofs_flag);
-	} else {
-		unsigned int noio_flag = memalloc_noio_save();
-		p = kvmalloc(size, GFP_KERNEL);
-		memalloc_noio_restore(noio_flag);
-	}
-
-	return p;
-}
-
 static int parse_fsid(const char *str, struct ceph_fsid *fsid)
 {
 	int i = 0;
diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 92d89b331645..051d22c0e4ad 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -147,7 +147,7 @@ void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
 static const u8 *aes_iv = (u8 *)CEPH_AES_IV;
 
 /*
- * Should be used for buffers allocated with ceph_kvmalloc().
+ * Should be used for buffers allocated with kvmalloc().
  * Currently these are encrypt out-buffer (ceph_buffer) and decrypt
  * in-buffer (msg front).
  *
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 57d043b382ed..7b891be799d2 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1920,7 +1920,7 @@ struct ceph_msg *ceph_msg_new2(int type, int front_len, int max_data_items,
 
 	/* front */
 	if (front_len) {
-		m->front.iov_base = ceph_kvmalloc(front_len, flags);
+		m->front.iov_base = kvmalloc(front_len, flags);
 		if (m->front.iov_base == NULL) {
 			dout("ceph_msg_new can't allocate %d bytes\n",
 			     front_len);
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index cc40ce4e02fb..c4099b641b38 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -308,7 +308,7 @@ static void *alloc_conn_buf(struct ceph_connection *con, int len)
 	if (WARN_ON(con->v2.conn_buf_cnt >= ARRAY_SIZE(con->v2.conn_bufs)))
 		return NULL;
 
-	buf = ceph_kvmalloc(len, GFP_NOIO);
+	buf = kvmalloc(len, GFP_NOIO);
 	if (!buf)
 		return NULL;
 
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 75b738083523..2823bb3cff55 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -980,7 +980,7 @@ static struct crush_work *alloc_workspace(const struct crush_map *c)
 	work_size = crush_work_size(c, CEPH_PG_MAX_SIZE);
 	dout("%s work_size %zu bytes\n", __func__, work_size);
 
-	work = ceph_kvmalloc(work_size, GFP_NOIO);
+	work = kvmalloc(work_size, GFP_NOIO);
 	if (!work)
 		return NULL;
 
@@ -1190,9 +1190,9 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, u32 max)
 	if (max == map->max_osd)
 		return 0;
 
-	state = ceph_kvmalloc(array_size(max, sizeof(*state)), GFP_NOFS);
-	weight = ceph_kvmalloc(array_size(max, sizeof(*weight)), GFP_NOFS);
-	addr = ceph_kvmalloc(array_size(max, sizeof(*addr)), GFP_NOFS);
+	state = kvmalloc(array_size(max, sizeof(*state)), GFP_NOFS);
+	weight = kvmalloc(array_size(max, sizeof(*weight)), GFP_NOFS);
+	addr = kvmalloc(array_size(max, sizeof(*addr)), GFP_NOFS);
 	if (!state || !weight || !addr) {
 		kvfree(state);
 		kvfree(weight);
@@ -1222,7 +1222,7 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, u32 max)
 	if (map->osd_primary_affinity) {
 		u32 *affinity;
 
-		affinity = ceph_kvmalloc(array_size(max, sizeof(*affinity)),
+		affinity = kvmalloc(array_size(max, sizeof(*affinity)),
 					 GFP_NOFS);
 		if (!affinity)
 			return -ENOMEM;
@@ -1503,7 +1503,7 @@ static int set_primary_affinity(struct ceph_osdmap *map, int osd, u32 aff)
 	if (!map->osd_primary_affinity) {
 		int i;
 
-		map->osd_primary_affinity = ceph_kvmalloc(
+		map->osd_primary_affinity = kvmalloc(
 		    array_size(map->max_osd, sizeof(*map->osd_primary_affinity)),
 		    GFP_NOFS);
 		if (!map->osd_primary_affinity)
-- 
2.30.2

