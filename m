Return-Path: <linux-fsdevel+bounces-28859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3512D96FA74
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 20:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EC4287133
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 18:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E881D88A3;
	Fri,  6 Sep 2024 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg0YZWHv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C201D86F4;
	Fri,  6 Sep 2024 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646051; cv=none; b=ogCiFTZJ88hCB6UoK511prUAbabCel+s/7RGh4sEi2hS4ULJG5nJvohNTfHr1n12kplKMFy5xBJDUPrPr4NLxbzb06Pc/HKezlaIhkJMQ1Hj6xs4x7dZ/cUFXPKyTSz0pJLBL6uXGGdVm0We/pZwl3O5W0QMgLQKzpU4Mcvs/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646051; c=relaxed/simple;
	bh=tl5dmsN9C4YuIhY60C/p286cQGp5ZSrQnUtg1in09fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYfqDXgdY8mJBdlPh2aVxhJwinMu3qFPGWfL9UgwhSNLDlXGtpiOH3LKsx1m6EibdB+NSPmGSMshHXeda2hLzNQspt/J5QVQd14hv6len7oVEPuZdvj2HKObf0iVt1hsKm0Gu0TETvGqfBWyk2CpHry9nKWPOUrPYpfg1MWsrE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg0YZWHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B2DC4CECD;
	Fri,  6 Sep 2024 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725646050;
	bh=tl5dmsN9C4YuIhY60C/p286cQGp5ZSrQnUtg1in09fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pg0YZWHv9jwBBocNi8NDvJSNK2S/z6E/aoEOo0T0dCi9O5TPFNlgs46vRtKRGBfNi
	 gBkC5xbCO4Qsj6IeoYVVZG3OjkvJ6aJpzlF6nc2/7PYjP/ecssJou02Ar+q+9Y0bUV
	 3bOfER++lQFX7389i/iwg1hErhevc+F5N5iLR5qh3AqGpqzH9nuP7TZ2tsL9vf4BS+
	 COiQQa/ZQxkjuOVzWa8MiNcvr4P3274GwrDdM1bKDZ4ZH0tQeinvRs3DmqaUa6bGcK
	 kuNAwLapEOVzX6K6n3EzNhGx58772qzL8UttTyijCg2tKwtno4lmzCelu06fPEmsG+
	 tILgxhNhwtotg==
Date: Fri, 6 Sep 2024 14:07:28 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Message-ID: <ZttE4DKrqqVa0ACn@kernel.org>
References: <>
 <Ztm-TbSdXOkx3IHn@kernel.org>
 <172557924809.4433.12586767127138915683@noble.neil.brown.name>
 <ZtsZ8IEoV-DyqAzj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtsZ8IEoV-DyqAzj@kernel.org>

On Fri, Sep 06, 2024 at 11:04:16AM -0400, Mike Snitzer wrote:
> On Fri, Sep 06, 2024 at 09:34:08AM +1000, NeilBrown wrote:
> > On Fri, 06 Sep 2024, Mike Snitzer wrote:
> > > On Wed, Sep 04, 2024 at 09:47:07AM -0400, Chuck Lever wrote:
> > > > On Wed, Sep 04, 2024 at 03:01:46PM +1000, NeilBrown wrote:
> > > > > On Wed, 04 Sep 2024, NeilBrown wrote:
> > > > > > 
> > > > > > I agree that dropping and reclaiming a lock is an anti-pattern and in
> > > > > > best avoided in general.  I cannot see a better alternative in this
> > > > > > case.
> > > > > 
> > > > > It occurred to me what I should spell out the alternate that I DO see so
> > > > > you have the option of disagreeing with my assessment that it isn't
> > > > > "better".
> > > > > 
> > > > > We need RCU to call into nfsd, we need a per-cpu ref on the net (which
> > > > > we can only get inside nfsd) and NOT RCU to call
> > > > > nfsd_file_acquire_local().
> > > > > 
> > > > > The current code combines these (because they are only used together)
> > > > > and so the need to drop rcu. 
> > > > > 
> > > > > I thought briefly that it could simply drop rcu and leave it dropped
> > > > > (__releases(rcu)) but not only do I generally like that LESS than
> > > > > dropping and reclaiming, I think it would be buggy.  While in the nfsd
> > > > > module code we need to be holding either rcu or a ref on the server else
> > > > > the code could disappear out from under the CPU.  So if we exit without
> > > > > a ref on the server - which we do if nfsd_file_acquire_local() fails -
> > > > > then we need to reclaim RCU *before* dropping the ref.  So the current
> > > > > code is slightly buggy.
> > > > > 
> > > > > We could instead split the combined call into multiple nfs_to
> > > > > interfaces.
> > > > > 
> > > > > So nfs_open_local_fh() in nfs_common/nfslocalio.c would be something
> > > > > like:
> > > > > 
> > > > >  rcu_read_lock();
> > > > >  net = READ_ONCE(uuid->net);
> > > > >  if (!net || !nfs_to.get_net(net)) {
> > > > >        rcu_read_unlock();
> > > > >        return ERR_PTR(-ENXIO);
> > > > >  }
> > > > >  rcu_read_unlock();
> > > > >  localio = nfs_to.nfsd_open_local_fh(....);
> > > > >  if (IS_ERR(localio))
> > > > >        nfs_to.put_net(net);
> > > > >  return localio;
> > > > > 
> > > > > So we have 3 interfaces instead of 1, but no hidden unlock/lock.
> > > > 
> > > > Splitting up the function call occurred to me as well, but I didn't
> > > > come up with a specific bit of surgery. Thanks for the suggestion.
> > > > 
> > > > At this point, my concern is that we will lose your cogent
> > > > explanation of why the release/lock is done. Having it in email is
> > > > great, but email is more ephemeral than actually putting it in the
> > > > code.
> > > > 
> > > > 
> > > > > As I said, I don't think this is a net win, but reasonable people might
> > > > > disagree with me.
> > > > 
> > > > The "win" here is that it makes this code self-documenting and
> > > > somewhat less likely to be broken down the road by changes in and
> > > > around this area. Since I'm more forgetful these days I lean towards
> > > > the more obvious kinds of coding solutions. ;-)
> > > > 
> > > > Mike, how do you feel about the 3-interface suggestion?
> > > 
> > > I dislike expanding from 1 indirect function call to 2 in rapid
> > > succession (3 for the error path, not a problem, just being precise.
> > > But I otherwise like it.. maybe.. heh.
> > > 
> > > FYI, I did run with the suggestion to make nfs_to a pointer that just
> > > needs a simple assignment rather than memcpy to initialize.  So Neil's
> > > above code becames:
> > > 
> > >         rcu_read_lock();
> > >         net = rcu_dereference(uuid->net);
> > >         if (!net || !nfs_to->nfsd_serv_try_get(net)) {
> > >                 rcu_read_unlock();
> > >                 return ERR_PTR(-ENXIO);
> > >         }
> > >         rcu_read_unlock();
> > >         /* We have an implied reference to net thanks to nfsd_serv_try_get */
> > >         localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
> > >                                              cred, nfs_fh, fmode);
> > >         if (IS_ERR(localio))
> > >                 nfs_to->nfsd_serv_put(net);
> > >         return localio;
> > > 
> > > I do think it cleans the code up... full patch is here:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-next.v15-with-fixups&id=e85306941878a87070176702de687f2779436061
> > > 
> > > But I'm still on the fence.. someone help push me over!
> > 
> > I think the new code is unquestionable clearer, and not taking this
> > approach would be a micro-optimisation which would need to be
> > numerically justified.  So I'm pushing for the three-interface version
> > (despite what I said before).
> > 
> > Unfortunately the new code is not bug-free - not quite.
> > As soon as nfs_to->nfsd_serv_put() calls percpu_ref_put() the nfsd
> > module can be unloaded, and the "return" instruction might not be
> > present.  For this to go wrong would require a lot of bad luck, but if
> > the CPU took an interrupt at the wrong time were would be room.
> > 
> > [Ever since module_put_and_exit() was added (now ..and_kthread_exit)
> >  I've been sensitive to dropping the ref to a module in code running in
> >  the module]
> > 
> > So I think nfsd_serv_put (and nfsd_serv_try_get() __must_hold(RCU) and
> > nfs_open_local_fh() needs rcu_read_lock() before calling
> > nfs_to->nfsd_serv_put(net).
> 
> OK, yes I can see that, I implemented what you suggested at the end of
> your reply (see inline patch below)...
> 
> But I'd just like to point out that something like the below patch
> wouldn't be needed if we kept my "heavy" approach (nfs reference on
> nfsd modules via nfs_common using request_symbol):
> https://marc.info/?l=linux-nfs&m=172499445027800&w=2
> (that patch has stuff I since cleaned up, e.g. removed typedefs and
> EXPORT_SYMBOL_GPLs..)
> 
> I knew we were going to pay for being too cute with how nfs took its
> reference on nfsd.
> 
> So here we are, needing fiddly incremental fixes like this to close a
> really-small-yet-will-be-deadly race:

<snip required delicate rcu re-locking requirements patch>

I prefer this incremental re-implementation of my symbol_request patch
that eliminates all concerns about the validity of 'nfs_to' calls:

---
 fs/nfs/localio.c           |  5 +++
 fs/nfs_common/nfslocalio.c | 84 +++++++++++++++++++++++++++++++-------
 fs/nfsd/localio.c          |  2 +-
 include/linux/nfslocalio.h |  7 +++-
 4 files changed, 80 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index c29cdf51c458..43520ac0fde8 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -124,6 +124,10 @@ const struct rpc_program nfslocalio_program = {
 static void nfs_local_enable(struct nfs_client *clp)
 {
 	spin_lock(&clp->cl_localio_lock);
+	if (!nfs_to_nfsd_localio_ops_get()) {
+		spin_unlock(&clp->cl_localio_lock);
+		return;
+	}
 	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
 	trace_nfs_local_enable(clp);
 	spin_unlock(&clp->cl_localio_lock);
@@ -138,6 +142,7 @@ void nfs_local_disable(struct nfs_client *clp)
 	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
 		trace_nfs_local_disable(clp);
 		nfs_uuid_invalidate_one_client(&clp->cl_uuid);
+		nfs_to_nfsd_localio_ops_put();
 	}
 	spin_unlock(&clp->cl_localio_lock);
 }
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 42b479b9191f..9039e0f1afa3 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/rculist.h>
 #include <linux/nfslocalio.h>
+#include <linux/refcount.h>
 #include <net/netns/generic.h>
 
 MODULE_LICENSE("GPL");
@@ -53,11 +54,8 @@ static nfs_uuid_t * nfs_uuid_lookup_locked(const uuid_t *uuid)
 	return NULL;
 }
 
-static struct module *nfsd_mod;
-
 void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
-		       struct net *net, struct auth_domain *dom,
-		       struct module *mod)
+		       struct net *net, struct auth_domain *dom)
 {
 	nfs_uuid_t *nfs_uuid;
 
@@ -73,9 +71,6 @@ void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
 		 */
 		list_move(&nfs_uuid->list, list);
 		rcu_assign_pointer(nfs_uuid->net, net);
-
-		__module_get(mod);
-		nfsd_mod = mod;
 	}
 	spin_unlock(&nfs_uuid_lock);
 }
@@ -83,10 +78,8 @@ EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
 
 static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
 {
-	if (nfs_uuid->net) {
-		module_put(nfsd_mod);
-		nfs_uuid->net = NULL;
-	}
+	if (nfs_uuid->net)
+		RCU_INIT_POINTER(nfs_uuid->net, NULL);
 	if (nfs_uuid->dom) {
 		auth_domain_put(nfs_uuid->dom);
 		nfs_uuid->dom = NULL;
@@ -123,14 +116,14 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	struct nfsd_file *localio;
 
 	/*
-	 * Not running in nfsd context, so must safely get reference on nfsd_serv.
+	 * NFS has a reference to NFSD and can safely make 'nfs_to' calls.
+	 *
+	 * But not running in NFSD context, so must safely get reference to nfsd_serv.
 	 * But the server may already be shutting down, if so disallow new localio.
+	 *
 	 * uuid->net is NOT a counted reference, but rcu_read_lock() ensures that
 	 * if uuid->net is not NULL, then calling nfsd_serv_try_get() is safe
 	 * and if it succeeds we will have an implied reference to the net.
-	 *
-	 * Otherwise NFS may not have ref on NFSD and therefore cannot safely
-	 * make 'nfs_to' calls.
 	 */
 	rcu_read_lock();
 	net = rcu_dereference(uuid->net);
@@ -153,6 +146,7 @@ EXPORT_SYMBOL_GPL(nfs_open_local_fh);
  * but cannot be statically linked, because that will make the NFS
  * module always depend on the NFSD module.
  *
+ * [FIXME: must adjust following 2 paragraphs]
  * 'nfs_to' provides NFS access to NFSD functions needed for LOCALIO,
  * its lifetime is tightly coupled to the NFSD module and will always
  * be available to NFS LOCALIO because any successful client<->server
@@ -170,3 +164,63 @@ EXPORT_SYMBOL_GPL(nfs_open_local_fh);
  */
 const struct nfsd_localio_operations *nfs_to;
 EXPORT_SYMBOL_GPL(nfs_to);
+
+static DEFINE_SPINLOCK(nfs_to_nfsd_lock);
+static refcount_t nfs_to_ref;
+
+bool nfs_to_nfsd_localio_ops_get(void)
+{
+	spin_lock(&nfs_to_nfsd_lock);
+
+	/* Only get nfsd_localio_operations on first reference */
+	if (refcount_read(&nfs_to_ref) == 0) {
+		refcount_set(&nfs_to_ref, 1);
+		/* fallthru */
+	} else {
+		refcount_inc(&nfs_to_ref);
+		spin_unlock(&nfs_to_nfsd_lock);
+		return true;
+	}
+
+	/* Must drop spinlock before call to symbol_request */
+	spin_unlock(&nfs_to_nfsd_lock);
+
+	/*
+	 * If NFSD isn't available LOCALIO isn't possible.
+	 * Use nfsd_open_local_fh symbol as the bellwether, if
+	 * available then nfs_common has NFSD module reference
+	 * on NFS's behalf and can safely call 'nfs_to' functions.
+	 */
+	if (!symbol_request(nfsd_open_local_fh))
+		return false;
+	return true;
+}
+EXPORT_SYMBOL_GPL(nfs_to_nfsd_localio_ops_get);
+
+void nfs_to_nfsd_localio_ops_put(void)
+{
+	spin_lock(&nfs_to_nfsd_lock);
+
+	if (!refcount_dec_and_test(&nfs_to_ref))
+		goto out;
+
+	symbol_put(nfsd_open_local_fh);
+	nfs_to = NULL;
+out:
+	spin_unlock(&nfs_to_nfsd_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_to_nfsd_localio_ops_put);
+
+static int __init nfslocalio_init(void)
+{
+	refcount_set(&nfs_to_ref, 0);
+
+	return 0;
+}
+
+static void __exit nfslocalio_exit(void)
+{
+}
+
+module_init(nfslocalio_init);
+module_exit(nfslocalio_exit);
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 291e9c69cae4..291ad916d67a 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -114,7 +114,7 @@ static __be32 localio_proc_uuid_is_local(struct svc_rqst *rqstp)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	nfs_uuid_is_local(&argp->uuid, &nn->local_clients,
-			  net, rqstp->rq_client, THIS_MODULE);
+			  net, rqstp->rq_client);
 
 	return rpc_success;
 }
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index b353abe00357..2e6b9107a7d1 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -35,7 +35,7 @@ typedef struct {
 void nfs_uuid_begin(nfs_uuid_t *);
 void nfs_uuid_end(nfs_uuid_t *);
 void nfs_uuid_is_local(const uuid_t *, struct list_head *,
-		       struct net *, struct auth_domain *, struct module *);
+		       struct net *, struct auth_domain *);
 void nfs_uuid_invalidate_clients(struct list_head *list);
 void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
 
@@ -58,9 +58,12 @@ struct nfsd_localio_operations {
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 } ____cacheline_aligned;
 
-extern void nfsd_localio_ops_init(void);
 extern const struct nfsd_localio_operations *nfs_to;
 
+extern void nfsd_localio_ops_init(void);
+bool nfs_to_nfsd_localio_ops_get(void);
+void nfs_to_nfsd_localio_ops_put(void);
+
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
 		   struct rpc_clnt *, const struct cred *,
 		   const struct nfs_fh *, const fmode_t);
-- 
2.39.3


