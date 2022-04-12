Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE34FCCE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 05:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbiDLDQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 23:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344220AbiDLDQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:16:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BAB2ACC;
        Mon, 11 Apr 2022 20:14:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 476A821605;
        Tue, 12 Apr 2022 03:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649733245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTNHNQ/aWOG3zfcSQNNp3wwHE5EsZ8zdnZxQSLDfLgY=;
        b=TUiaQxfaoYhTihitAL1UTW2cf9TqpZ9X05bDxUEYIhoKpm01EC//0Qfgjhvcwk5x4SYaSd
        jkZqjIhvqGTXDFiSxie+i6iHRL4oDXuz7Wo1ktAocZ2OtozMjMVQVqd1Pwj8CegOrkUq+n
        cwqlsa3B5m6Ftdz0hOuhUElJcAVNnWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649733245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTNHNQ/aWOG3zfcSQNNp3wwHE5EsZ8zdnZxQSLDfLgY=;
        b=+qcms7P5zGyx7gdx6ngQM8TAH+vouie6Bt18KhKgz9+NVyXEGMeTl9/bG67YJ1+lxw/3DG
        PW5NJh6588gm+SBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DF3313A99;
        Tue, 12 Apr 2022 03:14:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +WAsOXruVGJBNQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 12 Apr 2022 03:14:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: sporadic hangs on generic/186
In-reply-to: <20220410233415.GG1609613@dread.disaster.area>
References: <20220406195424.GA1242@fieldses.org>,
 <20220407001453.GE1609613@dread.disaster.area>,
 <164929126156.10985.11316778982526844125@noble.neil.brown.name>,
 <164929437439.10985.5253499040284089154@noble.neil.brown.name>,
 <b282c5b98c4518952f62662ea3ba1d4e6ef85f26.camel@hammerspace.com>,
 <164930468885.10985.9905950866720150663@noble.neil.brown.name>,
 <43aace26d3a09f868f732b2ad94ca2dbf90f50bd.camel@hammerspace.com>,
 <164938596863.10985.998515507989861871@noble.neil.brown.name>,
 <20220408050321.GF1609613@dread.disaster.area>,
 <164939595866.10985.2936909905164009297@noble.neil.brown.name>,
 <20220410233415.GG1609613@dread.disaster.area>
Date:   Tue, 12 Apr 2022 13:13:57 +1000
Message-id: <164973323782.10985.11874897668084187412@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Mon, 11 Apr 2022, Dave Chinner wrote:
=20
> Yup, and you've missed my point entirely,

Hmm... It seems that I did. Sorry.

Your point is that the flags passed to kmalloc et al should be relevant,
and that we should be focusing on process context - including for
access to reserves in memalloc context (using memalloc_noreclaim_save()
as appropriate).  I agree.

My point is that memalloc_noreclaim_save() isn't necessarily sufficient.
It provides access to a shared pool of reserves, which is hard to reason
about.  It *might* provide a guarantee that every allocation will
succeed without deadlock - but only if there is a reasonable limit on
the number or parallel allocation chains - and we don't have any
mechanism for tracking those.

So there is still a place for mempools - they complement __GFP_MEMALLOC
reserves and can both be used together.  mempools() are particularly
appropriate when the allocation commonly (or always) occurs in
PF_MEMALLOC context, as using the mempool provides a better guarantee,
and removes a burden from the shared pool.

This suggests to me that a different interface to mempools could be
useful.  One that uses the mempool preallocation instead of the shared
preallocation
If PF_MEMALLOC or GFP_MEMALLOC are set, then the mempool is used which
avoids the shared reserves.
Otherwise (or if __GFP_NOMEMALLOC is set), follow the normal allocation
path and don't use the mempool reserves.=20

Something like the following.

Do you agree?

Thanks,
NeilBrown

diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 0c964ac107c2..4414644c49d5 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -46,6 +46,7 @@ extern mempool_t *mempool_create_node(int min_nr, mempool_a=
lloc_t *alloc_fn,
 extern int mempool_resize(mempool_t *pool, int new_min_nr);
 extern void mempool_destroy(mempool_t *pool);
 extern void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask) __malloc;
+extern void *mempool_memalloc(mempool_t *pool, gfp_t gfp_mask) __malloc;
 extern void mempool_free(void *element, mempool_t *pool);
=20
 /*
diff --git a/mm/mempool.c b/mm/mempool.c
index b933d0fc21b8..1182bd3443cc 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -417,8 +417,12 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 		goto repeat_alloc;
 	}
=20
-	/* We must not sleep if !__GFP_DIRECT_RECLAIM */
-	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
+	/*
+	 * We must not sleep if !__GFP_DIRECT_RECLAIM
+	 * and must not retry in __GFP_NORETRY
+	 */
+	if (!(gfp_mask & __GFP_DIRECT_RECLAIM) ||
+	    (gfp_mask & __GFP_NORETRY)) {
 		spin_unlock_irqrestore(&pool->lock, flags);
 		return NULL;
 	}
@@ -440,6 +444,30 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(mempool_alloc);
=20
+/**
+ * mempool_memalloc - allocate, using mempool rather than shared reserves
+ * @pool:	mempool to allocate from
+ * @gfp_mask:	GFP allocation flags
+ *
+ *
+ * If the process context or gfp flags permit allocation from reserves
+ * (i.e. PF_MEMALLOC or GFP_MEMALLOC), then use the mempool for allocation,
+ * otherwise allocate directly using the underlying allocator
+ *
+ * Return: pointer to allocated element, or %NULL on failure.
+ */
+
+void *mempool_memalloc(mempool_t *pool, gfp_t gfp_mask)
+{
+	if (gfp_mask & __GFP_NOMEMALLOC ||
+	    (!(current->flags & PF_MEMALLOC) &&
+	     !(gfp_mask & __GFP_MEMALLOC)))
+		/* No reserves requested */
+		return pool->alloc(gfp_mask, pool->pool_data);
+	else
+		return mempool_alloc(pool, gfp_mask);
+}
+
 /**
  * mempool_free - return an element to the pool.
  * @element:   pool element pointer.
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 682fcd24bf43..2ecbe6b89fbb 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -615,8 +615,6 @@ rpcauth_bind_root_cred(struct rpc_task *task, int lookupf=
lags)
 	};
 	struct rpc_cred *ret;
=20
-	if (RPC_IS_ASYNC(task))
-		lookupflags |=3D RPCAUTH_LOOKUP_ASYNC;
 	ret =3D auth->au_ops->lookup_cred(auth, &acred, lookupflags);
 	put_cred(acred.cred);
 	return ret;
@@ -633,8 +631,6 @@ rpcauth_bind_machine_cred(struct rpc_task *task, int look=
upflags)
=20
 	if (!acred.principal)
 		return NULL;
-	if (RPC_IS_ASYNC(task))
-		lookupflags |=3D RPCAUTH_LOOKUP_ASYNC;
 	return auth->au_ops->lookup_cred(auth, &acred, lookupflags);
 }
=20
@@ -658,7 +654,7 @@ rpcauth_bindcred(struct rpc_task *task, const struct cred=
 *cred, int flags)
 	};
=20
 	if (flags & RPC_TASK_ASYNC)
-		lookupflags |=3D RPCAUTH_LOOKUP_NEW | RPCAUTH_LOOKUP_ASYNC;
+		lookupflags |=3D RPCAUTH_LOOKUP_NEW;
 	if (task->tk_op_cred)
 		/* Task must use exactly this rpc_cred */
 		new =3D get_rpccred(task->tk_op_cred);
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index de7e5b41ab8f..4f68934dbeb5 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1343,11 +1343,7 @@ gss_hash_cred(struct auth_cred *acred, unsigned int ha=
shbits)
 static struct rpc_cred *
 gss_lookup_cred(struct rpc_auth *auth, struct auth_cred *acred, int flags)
 {
-	gfp_t gfp =3D GFP_KERNEL;
-
-	if (flags & RPCAUTH_LOOKUP_ASYNC)
-		gfp =3D GFP_NOWAIT | __GFP_NOWARN;
-	return rpcauth_lookup_credcache(auth, acred, flags, gfp);
+	return rpcauth_lookup_credcache(auth, acred, flags, GFP_KERNEL);
 }
=20
 static struct rpc_cred *
diff --git a/net/sunrpc/auth_unix.c b/net/sunrpc/auth_unix.c
index 1e091d3fa607..6170d4d34687 100644
--- a/net/sunrpc/auth_unix.c
+++ b/net/sunrpc/auth_unix.c
@@ -45,14 +45,10 @@ static struct rpc_cred *unx_lookup_cred(struct rpc_auth *=
auth,
 {
 	struct rpc_cred *ret;
=20
-	ret =3D kmalloc(sizeof(*ret), rpc_task_gfp_mask());
-	if (!ret) {
-		if (!(flags & RPCAUTH_LOOKUP_ASYNC))
-			return ERR_PTR(-ENOMEM);
-		ret =3D mempool_alloc(unix_pool, GFP_NOWAIT);
-		if (!ret)
-			return ERR_PTR(-ENOMEM);
-	}
+	ret =3D mempool_memalloc(unix_pool, rpc_task_gfp_mask());
+	if (!ret)
+		return ERR_PTR(-ENOMEM);
+
 	rpcauth_init_cred(ret, acred, auth, &unix_credops);
 	ret->cr_flags =3D 1UL << RPCAUTH_CRED_UPTODATE;
 	return ret;
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 7f70c1e608b7..4138aa62d3f3 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -1040,12 +1040,9 @@ int rpc_malloc(struct rpc_task *task)
 	gfp_t gfp =3D rpc_task_gfp_mask();
=20
 	size +=3D sizeof(struct rpc_buffer);
-	if (size <=3D RPC_BUFFER_MAXSIZE) {
-		buf =3D kmem_cache_alloc(rpc_buffer_slabp, gfp);
-		/* Reach for the mempool if dynamic allocation fails */
-		if (!buf && RPC_IS_ASYNC(task))
-			buf =3D mempool_alloc(rpc_buffer_mempool, GFP_NOWAIT);
-	} else
+	if (size <=3D RPC_BUFFER_MAXSIZE)
+		buf =3D mempool_memalloc(rpc_buffer_mempool, gfp);
+	else
 		buf =3D kmalloc(size, gfp);
=20
 	if (!buf)
@@ -1110,12 +1107,7 @@ static void rpc_init_task(struct rpc_task *task, const=
 struct rpc_task_setup *ta
=20
 static struct rpc_task *rpc_alloc_task(void)
 {
-	struct rpc_task *task;
-
-	task =3D kmem_cache_alloc(rpc_task_slabp, rpc_task_gfp_mask());
-	if (task)
-		return task;
-	return mempool_alloc(rpc_task_mempool, GFP_NOWAIT);
+	return mempool_memalloc(rpc_task_mempool, rpc_task_gfp_mask());
 }
=20
 /*

diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
index 3e6ce288a7fc..98da816b5fc2 100644
--- a/include/linux/sunrpc/auth.h
+++ b/include/linux/sunrpc/auth.h
@@ -99,7 +99,6 @@ struct rpc_auth_create_args {
=20
 /* Flags for rpcauth_lookupcred() */
 #define RPCAUTH_LOOKUP_NEW		0x01	/* Accept an uninitialised cred */
-#define RPCAUTH_LOOKUP_ASYNC		0x02	/* Don't block waiting for memory */
=20
 /*
  * Client authentication ops
