Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E1C22B5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 07:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfETFnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 01:43:08 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46491 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729535AbfETFnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 01:43:08 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id BB657115CB;
        Mon, 20 May 2019 01:43:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 May 2019 01:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=BWgf9mQL60frF07ii2U3Yx/gnin3umDFroib+xOOshw=; b=LhKqHj9w
        zvjIxq0G2O5k2GycyyiBsamzi2rk2+Lf+YY+F5xR7uqTFhkUs01LFET99pHIduQs
        zOM4rZdOSvJ/+z966a1bZjVfEqSxqIESB2sj2qYi/MyuhQjzu91wrVGuA9y2tEt/
        krfRq77gRiJ8tckBxpUTJnqfd3NJOGBYPJN2U39hcDUUkSJSWZSjJ0xSt1+Ea1O1
        +jt7qGo8NnY9WOhtrB/Q8GgsmaFNzTIQ9zSeGHSaxKOlKiD0s5oDmFpMAD46hK7W
        JEhgU6aa+NeSITEQ9r1zxvFsz532rqKkHToJnh6sHAdJRobsuaRB9jd+5RQ66NuX
        WpprC/lEu1nFAw==
X-ME-Sender: <xms:aj7iXJT6i9Oat66hbsjAGRKp8ivhzPTtOeQjhFevKqB3toMa-3N_4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgs
    ihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenuc
    fkphepuddvgedrudeiledrudehiedrvddtfeenucfrrghrrghmpehmrghilhhfrhhomhep
    thhosghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudeh
X-ME-Proxy: <xmx:aj7iXLsm8RfzRwpzWMqOv4yqNrnHvY2PreCiTcGGNgXUH65_A7ky8A>
    <xmx:aj7iXAxrdVYMTdmWW8Gdd31xDdHcU__M5rtYQ53IYinJWakQoNXpiw>
    <xmx:aj7iXN4O0EDlsxcZeLWMLUQnoXTPf_dzVR16xXlScM2-D2s4qKZjEw>
    <xmx:aj7iXIdowHHWet0oDJd0Uj4YrXknJYhGbESKyg7DQcS8YC1W7Av8MA>
Received: from eros.localdomain (124-169-156-203.dyn.iinet.net.au [124.169.156.203])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3664D80060;
        Mon, 20 May 2019 01:42:58 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
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
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 16/16] dcache: Add CONFIG_DCACHE_SMO
Date:   Mon, 20 May 2019 15:40:17 +1000
Message-Id: <20190520054017.32299-17-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520054017.32299-1-tobin@kernel.org>
References: <20190520054017.32299-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In an attempt to make the SMO patchset as non-invasive as possible add a
config option CONFIG_DCACHE_SMO (under "Memory Management options") for
enabling SMO for the DCACHE.  Whithout this option dcache constructor is
used but no other code is built in, with this option enabled slab
mobility is enabled and the isolate/migrate functions are built in.

Add CONFIG_DCACHE_SMO to guard the partial shrinking of the dcache via
Slab Movable Objects infrastructure.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c | 4 ++++
 mm/Kconfig  | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 0dfe580c2d42..96063e872366 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3072,6 +3072,7 @@ void d_tmpfile(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(d_tmpfile);
 
+#ifdef CONFIG_DCACHE_SMO
 /*
  * d_isolate() - Dentry isolation callback function.
  * @s: The dentry cache.
@@ -3144,6 +3145,7 @@ static void d_partial_shrink(struct kmem_cache *s, void **_unused, int __unused,
 
 	kfree(private);
 }
+#endif	/* CONFIG_DCACHE_SMO */
 
 static __initdata unsigned long dhash_entries;
 static int __init set_dhash_entries(char *str)
@@ -3190,7 +3192,9 @@ static void __init dcache_init(void)
 					   sizeof_field(struct dentry, d_iname),
 					   dcache_ctor);
 
+#ifdef CONFIG_DCACHE_SMO
 	kmem_cache_setup_mobility(dentry_cache, d_isolate, d_partial_shrink);
+#endif
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
diff --git a/mm/Kconfig b/mm/Kconfig
index aa8d60e69a01..7dcea76e5ecc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -265,6 +265,13 @@ config SMO_NODE
        help
          On NUMA systems enable moving objects to and from a specified node.
 
+config DCACHE_SMO
+       bool "Enable Slab Movable Objects for the dcache"
+       depends on SLUB
+       help
+         Under memory pressure we can try to free dentry slab cache objects from
+         the partial slab list if this is enabled.
+
 config PHYS_ADDR_T_64BIT
 	def_bool 64BIT
 
-- 
2.21.0

