Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA86F32784
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 06:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfFCE2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 00:28:49 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47411 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbfFCE2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:28:48 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 826751320;
        Mon,  3 Jun 2019 00:28:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Jun 2019 00:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=rxVuyzm1WS3UxHiswMwmyEkW+N4rdmsFgqzw5exGUx0=; b=3d+ZatUl
        A1wPrysCoCMns7irCJnO7Xzs7tZnZQVOKKKVaWHjLzAFoXe4z13qk76ntzD8JLfU
        4HaxCNIuJL/exRpJajmfocUXwv4Ch6gFZ4YYN09t0niw059zAsAjvYo522x8vOov
        8L9UEKPmAyncQ0HRHJyMyevUkW+tmjAj1SZXGxDL2hHU/7DRwv7nvFU5FVNe4xNv
        /uneC2szDjRVXRGohIKjBhyC3shW1yigoMlax+huURJH4w+iuGc2SXRa0N6c6PkO
        RsV4+o1I9wI13p7aJyXEBTIcn0oPteBIq+ELuOTKKcOimm1Bu1VI1dQi3E9mnaU5
        LqbFoNczAeDp/A==
X-ME-Sender: <xms:_6H0XG3MQauOjhRYnA2Qe8C2DuD0XU_YZmqCVKbls8tV5ARuj6XJgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudefiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvdegrddugeelrdduudefrdefieenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:_6H0XDHnyRjJLe3A6QUOQj0F7hHtGtgHam6uYJBbGsXXTn1ipzT2ew>
    <xmx:_6H0XI90qzVyyfcJc_i-Ej-xnEBO2szNnB6ldCDZav5CEOy78Dkb4w>
    <xmx:_6H0XJnwznT-s6I0tP2LMLgCENFpQgk1MaDKkmPIX9H40RA7QpYv1Q>
    <xmx:_6H0XB63MuU8MKLiUkKQp0w-WF2SKTfMOgcCtxhg_FVXf8Fkn6b36Q>
Received: from eros.localdomain (124-149-113-36.dyn.iinet.net.au [124.149.113.36])
        by mail.messagingengine.com (Postfix) with ESMTPA id EC9598005C;
        Mon,  3 Jun 2019 00:28:39 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] xarray: Implement migration function for xa_node objects
Date:   Mon,  3 Jun 2019 14:26:32 +1000
Message-Id: <20190603042637.2018-11-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603042637.2018-1-tobin@kernel.org>
References: <20190603042637.2018-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recently Slab Movable Objects (SMO) was implemented for the SLUB
allocator.  The XArray can take advantage of this and make the xa_node
slab cache objects movable.

Implement functions to migrate objects and activate SMO when we
initialise the XArray slab cache.

This is based on initial code by Matthew Wilcox and was modified to work
with slab object migration.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 lib/xarray.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/lib/xarray.c b/lib/xarray.c
index 861c042daa1d..9354e0f01f26 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1993,12 +1993,73 @@ static void xa_node_ctor(void *arg)
 	INIT_LIST_HEAD(&node->private_list);
 }
 
+static void xa_object_migrate(struct xa_node *node, int numa_node)
+{
+	struct xarray *xa = READ_ONCE(node->array);
+	void __rcu **slot;
+	struct xa_node *new_node;
+	int i;
+
+	/* Freed or not yet in tree then skip */
+	if (!xa || xa == XA_RCU_FREE)
+		return;
+
+	new_node = kmem_cache_alloc_node(xa_node_cachep, GFP_KERNEL, numa_node);
+	if (!new_node) {
+		pr_err("%s: slab cache allocation failed\n", __func__);
+		return;
+	}
+
+	xa_lock_irq(xa);
+
+	/* Check again..... */
+	if (xa != node->array) {
+		node = new_node;
+		goto unlock;
+	}
+
+	memcpy(new_node, node, sizeof(struct xa_node));
+
+	if (list_empty(&node->private_list))
+		INIT_LIST_HEAD(&new_node->private_list);
+	else
+		list_replace(&node->private_list, &new_node->private_list);
+
+	for (i = 0; i < XA_CHUNK_SIZE; i++) {
+		void *x = xa_entry_locked(xa, new_node, i);
+
+		if (xa_is_node(x))
+			rcu_assign_pointer(xa_to_node(x)->parent, new_node);
+	}
+	if (!new_node->parent)
+		slot = &xa->xa_head;
+	else
+		slot = &xa_parent_locked(xa, new_node)->slots[new_node->offset];
+	rcu_assign_pointer(*slot, xa_mk_node(new_node));
+
+unlock:
+	xa_unlock_irq(xa);
+	xa_node_free(node);
+	rcu_barrier();
+}
+
+static void xa_migrate(struct kmem_cache *s, void **objects, int nr,
+		       int node, void *_unused)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		xa_object_migrate(objects[i], node);
+}
+
 void __init xarray_slabcache_init(void)
 {
 	xa_node_cachep = kmem_cache_create("xarray_node",
 					   sizeof(struct xa_node), 0,
 					   SLAB_PANIC | SLAB_RECLAIM_ACCOUNT,
 					   xa_node_ctor);
+
+	kmem_cache_setup_mobility(xa_node_cachep, NULL, xa_migrate);
 }
 
 #ifdef XA_DEBUG
-- 
2.21.0

