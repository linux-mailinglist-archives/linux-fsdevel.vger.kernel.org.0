Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D904EE429
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 00:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbiCaWiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 18:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242673AbiCaWiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:38:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B71C8A8E;
        Thu, 31 Mar 2022 15:36:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E7E7D21A91;
        Thu, 31 Mar 2022 22:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648766177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9oThGHhXzDbS58RdqWrTyTXsG5EK5i9whLg1NGJqU1k=;
        b=z7uUZhNT/wczrRmd53Lke7NQ6cWdwtqRLDWxlWN54/CBZMVMUqW7Aelv9lL7z/tS9qKNV1
        AQ3GgPs/DaP0ywJbEXl3RjGCqae908MBlUoU02q6r1W1Wqs8CiH+D9zTKCtjrDLmi47h+K
        t9FVSNFyl5X1EBW0XQKv0nLE959j7Lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648766177;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9oThGHhXzDbS58RdqWrTyTXsG5EK5i9whLg1NGJqU1k=;
        b=y/NoMJ/0G2E0UptWi9Tfx0kQWjpesoBNpLUzYTMDLjAI+DjC+N7YRyQ1P6LXAZVY4s6k+E
        kmvOMW1DS+8f12Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 662B5133D4;
        Thu, 31 Mar 2022 22:36:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Zc5nCNosRmJ1GQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 31 Mar 2022 22:36:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Muchun Song" <songmuchun@bytedance.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Vladimir Davydov" <vdavydov.dev@gmail.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Yang Shi" <shy828301@gmail.com>, "Alex Shi" <alexs@kernel.org>,
        "Wei Yang" <richard.weiyang@gmail.com>,
        "Dave Chinner" <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        "Kari Argillander" <kari.argillander@gmail.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, "Qi Zheng" <zhengqi.arch@bytedance.com>,
        "Xiongchun duan" <duanxiongchun@bytedance.com>,
        "Fam Zheng" <fam.zheng@bytedance.com>,
        "Muchun Song" <smuchun@gmail.com>
Subject: Re: [PATCH v6 12/16] mm: list_lru: replace linear array with xarray
In-reply-to: <CAMZfGtX9pkWYf40RwDALZLKGDc+Dt2UJA7wZFjTagf0AyWyCiw@mail.gmail.com>
References: <20220228122126.37293-1-songmuchun@bytedance.com>,
 <20220228122126.37293-13-songmuchun@bytedance.com>,
 <164869718565.25542.15818719940772238394@noble.neil.brown.name>,
 <CAMZfGtUSA9f3k9jF5U-y+NVt8cpmB9_mk1F9-vmm4JOuWFF_Bw@mail.gmail.com>,
 <164870069595.25542.17292003658915487357@noble.neil.brown.name>,
 <CAMZfGtX9pkWYf40RwDALZLKGDc+Dt2UJA7wZFjTagf0AyWyCiw@mail.gmail.com>
Date:   Fri, 01 Apr 2022 09:36:06 +1100
Message-id: <164876616694.25542.14010655277238655246@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 31 Mar 2022, Muchun Song wrote:
>=20
> Thanks for your report.  I knew the reason. It is because the following
> patch in this series was missed upstream.  Could you help me test if it
> works properly?
>=20
> [v6,06/16] nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry
>=20

Thanks for the quick response!  That patch helps, but has a bug.  My
testing resulted in refcount underflow errors.

Problem is that kref_init() is called in nfs4_xattr_entry_init_once().
This means that it is initialised to '1' the first time an entry is
allocated, but it is left as zero the second time.
I applied:
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -191,6 +191,7 @@ nfs4_xattr_alloc_entry(const char *name, const void *valu=
e,
 	entry =3D kmem_cache_alloc_lru(nfs4_xattr_entry_cachep, lru, gfp);
 	if (!entry)
 		return NULL;
+	kref_init(&entry->ref);
 	namep =3D kstrdup_const(name, gfp);
 	if (!namep && name)
 		goto free_buf;
@@ -974,7 +975,6 @@ static void nfs4_xattr_entry_init_once(void *p)
 {
 	struct nfs4_xattr_entry *entry =3D p;
=20
-	kref_init(&entry->ref);
 	entry->bucket =3D NULL;
 	INIT_LIST_HEAD(&entry->lru);
 	INIT_LIST_HEAD(&entry->dispose);

and now it seems to work.

The complete patch that I applied is below.  I haven't reviewed it, just
tested it.
  Tested-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


From: Muchun Song <songmuchun@bytedance.com>
Date: Mon, 28 Feb 2022 20:21:16 +0800
Subject: [PATCH] nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry

If we want to add the allocated objects to its list_lru, we should use
kmem_cache_alloc_lru() to allocate objects. So intruduce
nfs4_xattr_entry_cachep which is used to allocate nfs4_xattr_entry.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index ad3405c64b9e..d4163c46acf1 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -81,7 +81,7 @@ struct nfs4_xattr_entry {
 	struct hlist_node hnode;
 	struct list_head lru;
 	struct list_head dispose;
-	char *xattr_name;
+	const char *xattr_name;
 	void *xattr_value;
 	size_t xattr_size;
 	struct nfs4_xattr_bucket *bucket;
@@ -98,6 +98,7 @@ static struct list_lru nfs4_xattr_entry_lru;
 static struct list_lru nfs4_xattr_large_entry_lru;
=20
 static struct kmem_cache *nfs4_xattr_cache_cachep;
+static struct kmem_cache *nfs4_xattr_entry_cachep;
=20
 /*
  * Hashing helper functions.
@@ -177,49 +178,28 @@ nfs4_xattr_alloc_entry(const char *name, const void *va=
lue,
 {
 	struct nfs4_xattr_entry *entry;
 	void *valp;
-	char *namep;
-	size_t alloclen, slen;
-	char *buf;
-	uint32_t flags;
+	const char *namep;
+	uint32_t flags =3D len > PAGE_SIZE ? NFS4_XATTR_ENTRY_EXTVAL : 0;
+	gfp_t gfp =3D GFP_KERNEL;
+	struct list_lru *lru;
=20
 	BUILD_BUG_ON(sizeof(struct nfs4_xattr_entry) +
 	    XATTR_NAME_MAX + 1 > PAGE_SIZE);
=20
-	alloclen =3D sizeof(struct nfs4_xattr_entry);
-	if (name !=3D NULL) {
-		slen =3D strlen(name) + 1;
-		alloclen +=3D slen;
-	} else
-		slen =3D 0;
-
-	if (alloclen + len <=3D PAGE_SIZE) {
-		alloclen +=3D len;
-		flags =3D 0;
-	} else {
-		flags =3D NFS4_XATTR_ENTRY_EXTVAL;
-	}
-
-	buf =3D kmalloc(alloclen, GFP_KERNEL);
-	if (buf =3D=3D NULL)
+	lru =3D flags & NFS4_XATTR_ENTRY_EXTVAL ? &nfs4_xattr_large_entry_lru :
+	      &nfs4_xattr_entry_lru;
+	entry =3D kmem_cache_alloc_lru(nfs4_xattr_entry_cachep, lru, gfp);
+	if (!entry)
 		return NULL;
-	entry =3D (struct nfs4_xattr_entry *)buf;
-
-	if (name !=3D NULL) {
-		namep =3D buf + sizeof(struct nfs4_xattr_entry);
-		memcpy(namep, name, slen);
-	} else {
-		namep =3D NULL;
-	}
-
-
-	if (flags & NFS4_XATTR_ENTRY_EXTVAL) {
-		valp =3D kvmalloc(len, GFP_KERNEL);
-		if (valp =3D=3D NULL) {
-			kfree(buf);
-			return NULL;
-		}
-	} else if (len !=3D 0) {
-		valp =3D buf + sizeof(struct nfs4_xattr_entry) + slen;
+	kref_init(&entry->ref);
+	namep =3D kstrdup_const(name, gfp);
+	if (!namep && name)
+		goto free_buf;
+
+	if (len !=3D 0) {
+		valp =3D kvmalloc(len, gfp);
+		if (!valp)
+			goto free_name;
 	} else
 		valp =3D NULL;
=20
@@ -232,23 +212,23 @@ nfs4_xattr_alloc_entry(const char *name, const void *va=
lue,
=20
 	entry->flags =3D flags;
 	entry->xattr_value =3D valp;
-	kref_init(&entry->ref);
 	entry->xattr_name =3D namep;
 	entry->xattr_size =3D len;
-	entry->bucket =3D NULL;
-	INIT_LIST_HEAD(&entry->lru);
-	INIT_LIST_HEAD(&entry->dispose);
-	INIT_HLIST_NODE(&entry->hnode);
=20
 	return entry;
+free_name:
+	kfree_const(namep);
+free_buf:
+	kmem_cache_free(nfs4_xattr_entry_cachep, entry);
+	return NULL;
 }
=20
 static void
 nfs4_xattr_free_entry(struct nfs4_xattr_entry *entry)
 {
-	if (entry->flags & NFS4_XATTR_ENTRY_EXTVAL)
-		kvfree(entry->xattr_value);
-	kfree(entry);
+	kvfree(entry->xattr_value);
+	kfree_const(entry->xattr_name);
+	kmem_cache_free(nfs4_xattr_entry_cachep, entry);
 }
=20
 static void
@@ -289,7 +269,7 @@ nfs4_xattr_alloc_cache(void)
 {
 	struct nfs4_xattr_cache *cache;
=20
-	cache =3D kmem_cache_alloc(nfs4_xattr_cache_cachep, GFP_KERNEL);
+	cache =3D kmem_cache_alloc_lru(nfs4_xattr_cache_cachep, &nfs4_xattr_cache_l=
ru, GFP_KERNEL);
 	if (cache =3D=3D NULL)
 		return NULL;
=20
@@ -991,6 +971,16 @@ static void nfs4_xattr_cache_init_once(void *p)
 	INIT_LIST_HEAD(&cache->dispose);
 }
=20
+static void nfs4_xattr_entry_init_once(void *p)
+{
+	struct nfs4_xattr_entry *entry =3D p;
+
+	entry->bucket =3D NULL;
+	INIT_LIST_HEAD(&entry->lru);
+	INIT_LIST_HEAD(&entry->dispose);
+	INIT_HLIST_NODE(&entry->hnode);
+}
+
 int __init nfs4_xattr_cache_init(void)
 {
 	int ret =3D 0;
@@ -1002,6 +992,13 @@ int __init nfs4_xattr_cache_init(void)
 	if (nfs4_xattr_cache_cachep =3D=3D NULL)
 		return -ENOMEM;
=20
+	nfs4_xattr_entry_cachep =3D kmem_cache_create("nfs4_xattr_entry",
+			sizeof(struct nfs4_xattr_entry), 0,
+			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
+			nfs4_xattr_entry_init_once);
+	if (!nfs4_xattr_entry_cachep)
+		goto out5;
+
 	ret =3D list_lru_init_memcg(&nfs4_xattr_large_entry_lru,
 	    &nfs4_xattr_large_entry_shrinker);
 	if (ret)
@@ -1039,6 +1036,8 @@ int __init nfs4_xattr_cache_init(void)
 out3:
 	list_lru_destroy(&nfs4_xattr_large_entry_lru);
 out4:
+	kmem_cache_destroy(nfs4_xattr_entry_cachep);
+out5:
 	kmem_cache_destroy(nfs4_xattr_cache_cachep);
=20
 	return ret;

