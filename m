Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC87832788
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 06:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFCE3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 00:29:03 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47851 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726221AbfFCE3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:29:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 07BB11283;
        Mon,  3 Jun 2019 00:29:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Jun 2019 00:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ewjgpKzrSyNZxS5aNItsJCiFiD2mCvE5h0lTeGrIDUo=; b=IoSRBbnW
        /MnkcmJqrNT5voVVHOF2HDm78r1ptlGnuLEAhtfByiYSAth7lBKRIFJHKGbONqmn
        n9UVthqyetkgCvsrj+7pkvH5MtmmzIiVs/c6jiLK7RxL/bbJUimKk3+O3szcTSRs
        vJIDHxqClhud2LL51vDDgg1FxOW68cw7tuSVnPX1iNMx24Ty5KeGH0+yAf0WrDBj
        socy5DCMQ7OE/FlOncvhs//KTN3ZJ5D1eoMOa9UGvVTkWNrQQx0IVoJ7tE8LCIud
        otq3mwQLk3BSy21ZvUTVfHv46iDriY2AepKcuL+2jT2Yu5mWCqSoEc4NY5EEUZyS
        IiYkQRy0xjTc3g==
X-ME-Sender: <xms:DaL0XNqx8Jd-XU-pkYuBd8vi9YcGoiJtH7JYmShfbeHw3LYdvhocbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudefiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvdegrddugeelrdduudefrdefieenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:DaL0XLTMXu_myirZJLnoa4L66T3Q6n3jM_UADurIL0AwHiM7i8oGLw>
    <xmx:DaL0XEpXGYDwOQWfc3NEfy_TXiaLtQznK_SMF_LcyLQ9FQ-B0MlJrQ>
    <xmx:DaL0XGy_3VbUMO_8C9GkpN7MZ-GI6V4dZj1LvJEpHY5Sv6TXNdnFGQ>
    <xmx:DaL0XLAFNMrlWEo8sfJXnnXQNn79inSmvfm97CjL5Hg18Y17ih9oXw>
Received: from eros.localdomain (124-149-113-36.dyn.iinet.net.au [124.149.113.36])
        by mail.messagingengine.com (Postfix) with ESMTPA id DCC0B80066;
        Mon,  3 Jun 2019 00:28:54 -0400 (EDT)
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
Subject: [PATCH 12/15] dcache: Provide a dentry constructor
Date:   Mon,  3 Jun 2019 14:26:34 +1000
Message-Id: <20190603042637.2018-13-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603042637.2018-1-tobin@kernel.org>
References: <20190603042637.2018-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to support object migration on the dentry cache we need to have
a determined object state at all times. Without a constructor the object
would have a random state after allocation.

Provide a dentry constructor.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c435398f2c81..867d97a86940 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1603,6 +1603,16 @@ void d_invalidate(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_invalidate);
 
+static void dcache_ctor(void *p)
+{
+	struct dentry *dentry = p;
+
+	/* Mimic lockref_mark_dead() */
+	dentry->d_lockref.count = -128;
+
+	spin_lock_init(&dentry->d_lock);
+}
+
 /**
  * __d_alloc	-	allocate a dcache entry
  * @sb: filesystem it will belong to
@@ -1658,7 +1668,6 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 
 	dentry->d_lockref.count = 1;
 	dentry->d_flags = 0;
-	spin_lock_init(&dentry->d_lock);
 	seqcount_init(&dentry->d_seq);
 	dentry->d_inode = NULL;
 	dentry->d_parent = dentry;
@@ -3096,14 +3105,17 @@ static void __init dcache_init_early(void)
 
 static void __init dcache_init(void)
 {
-	/*
-	 * A constructor could be added for stable state like the lists,
-	 * but it is probably not worth it because of the cache nature
-	 * of the dcache.
-	 */
-	dentry_cache = KMEM_CACHE_USERCOPY(dentry,
-		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MEM_SPREAD|SLAB_ACCOUNT,
-		d_iname);
+	slab_flags_t flags =
+		SLAB_RECLAIM_ACCOUNT | SLAB_PANIC | SLAB_MEM_SPREAD | SLAB_ACCOUNT;
+
+	dentry_cache =
+		kmem_cache_create_usercopy("dentry",
+					   sizeof(struct dentry),
+					   __alignof__(struct dentry),
+					   flags,
+					   offsetof(struct dentry, d_iname),
+					   sizeof_field(struct dentry, d_iname),
+					   dcache_ctor);
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
-- 
2.21.0

