Return-Path: <linux-fsdevel+bounces-28854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DFE96F7C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 17:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D551F21F2D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB361D2F7E;
	Fri,  6 Sep 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQAOhGT6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E3E1D2F78;
	Fri,  6 Sep 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635057; cv=none; b=En6NPRPLg89bdgCCpVAL80qP3gxNFmw7USc8G9F8uShDVaS/536MtBAEejKvvj1OxfpcBTHHOjdENPikID8gDVv7nY/ooZUw6s7iU2rXfTer9AKZ2CsBL8rtLIFYPdkksKu9tbQ8pvqfalZBmgUtkeEDFj0nv0hoUfGdJ5+ANBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635057; c=relaxed/simple;
	bh=YhCFGAb5WC3vk773YhEinYlmUParKn+DvJYWuMeX/XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRt41CUV8NtjF/dGSFcwXjzzn3JZ33/Letvi7a/dZmfClPgONgxkeAeKlZyaGY4vzkGzK7Gi8oLn0heKTRlYgTpanId92PJ3O90UzhzbJCpGsxr+BCxyRZnyqahgwoy7dapKJ3CmLSbVI9ilk429htUX1S9cMEqOVkPsBGN1qpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQAOhGT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E5FC4CEC6;
	Fri,  6 Sep 2024 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725635057;
	bh=YhCFGAb5WC3vk773YhEinYlmUParKn+DvJYWuMeX/XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQAOhGT6Cc4QknaOQqtydtNxLpTv/XuhqxkHoZX8udgOtD0y+uxCeFSI2XtAqIZPU
	 y2h4MA1EBNaDqFZNjMoEcfvrsbRh0/17R/uVLbmt1lmO+9fAHzVmHoqAXIpQgq4FK6
	 g/FGUdZ5pJPcNujfTf/dtvaA05xckxGfxT61sEJsKmy6u4Ql059Bw2Ox2py6SP+wvC
	 UUoDjApPOyBQJzSF4gGLKDFswRX2fhJd8yMOZkX5qSkh1ADwK4wGOUsR4u9Jsdhx+x
	 KRinhVlUq+S0fiuAyXskTzczN0hKUSfyvcrvjNDskbrYDPKmzwCsTxGbC9XrjzaqKj
	 dScqxlRQ/ODBw==
Date: Fri, 6 Sep 2024 11:04:16 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Message-ID: <ZtsZ8IEoV-DyqAzj@kernel.org>
References: <>
 <Ztm-TbSdXOkx3IHn@kernel.org>
 <172557924809.4433.12586767127138915683@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172557924809.4433.12586767127138915683@noble.neil.brown.name>

On Fri, Sep 06, 2024 at 09:34:08AM +1000, NeilBrown wrote:
> On Fri, 06 Sep 2024, Mike Snitzer wrote:
> > On Wed, Sep 04, 2024 at 09:47:07AM -0400, Chuck Lever wrote:
> > > On Wed, Sep 04, 2024 at 03:01:46PM +1000, NeilBrown wrote:
> > > > On Wed, 04 Sep 2024, NeilBrown wrote:
> > > > > 
> > > > > I agree that dropping and reclaiming a lock is an anti-pattern and in
> > > > > best avoided in general.  I cannot see a better alternative in this
> > > > > case.
> > > > 
> > > > It occurred to me what I should spell out the alternate that I DO see so
> > > > you have the option of disagreeing with my assessment that it isn't
> > > > "better".
> > > > 
> > > > We need RCU to call into nfsd, we need a per-cpu ref on the net (which
> > > > we can only get inside nfsd) and NOT RCU to call
> > > > nfsd_file_acquire_local().
> > > > 
> > > > The current code combines these (because they are only used together)
> > > > and so the need to drop rcu. 
> > > > 
> > > > I thought briefly that it could simply drop rcu and leave it dropped
> > > > (__releases(rcu)) but not only do I generally like that LESS than
> > > > dropping and reclaiming, I think it would be buggy.  While in the nfsd
> > > > module code we need to be holding either rcu or a ref on the server else
> > > > the code could disappear out from under the CPU.  So if we exit without
> > > > a ref on the server - which we do if nfsd_file_acquire_local() fails -
> > > > then we need to reclaim RCU *before* dropping the ref.  So the current
> > > > code is slightly buggy.
> > > > 
> > > > We could instead split the combined call into multiple nfs_to
> > > > interfaces.
> > > > 
> > > > So nfs_open_local_fh() in nfs_common/nfslocalio.c would be something
> > > > like:
> > > > 
> > > >  rcu_read_lock();
> > > >  net = READ_ONCE(uuid->net);
> > > >  if (!net || !nfs_to.get_net(net)) {
> > > >        rcu_read_unlock();
> > > >        return ERR_PTR(-ENXIO);
> > > >  }
> > > >  rcu_read_unlock();
> > > >  localio = nfs_to.nfsd_open_local_fh(....);
> > > >  if (IS_ERR(localio))
> > > >        nfs_to.put_net(net);
> > > >  return localio;
> > > > 
> > > > So we have 3 interfaces instead of 1, but no hidden unlock/lock.
> > > 
> > > Splitting up the function call occurred to me as well, but I didn't
> > > come up with a specific bit of surgery. Thanks for the suggestion.
> > > 
> > > At this point, my concern is that we will lose your cogent
> > > explanation of why the release/lock is done. Having it in email is
> > > great, but email is more ephemeral than actually putting it in the
> > > code.
> > > 
> > > 
> > > > As I said, I don't think this is a net win, but reasonable people might
> > > > disagree with me.
> > > 
> > > The "win" here is that it makes this code self-documenting and
> > > somewhat less likely to be broken down the road by changes in and
> > > around this area. Since I'm more forgetful these days I lean towards
> > > the more obvious kinds of coding solutions. ;-)
> > > 
> > > Mike, how do you feel about the 3-interface suggestion?
> > 
> > I dislike expanding from 1 indirect function call to 2 in rapid
> > succession (3 for the error path, not a problem, just being precise.
> > But I otherwise like it.. maybe.. heh.
> > 
> > FYI, I did run with the suggestion to make nfs_to a pointer that just
> > needs a simple assignment rather than memcpy to initialize.  So Neil's
> > above code becames:
> > 
> >         rcu_read_lock();
> >         net = rcu_dereference(uuid->net);
> >         if (!net || !nfs_to->nfsd_serv_try_get(net)) {
> >                 rcu_read_unlock();
> >                 return ERR_PTR(-ENXIO);
> >         }
> >         rcu_read_unlock();
> >         /* We have an implied reference to net thanks to nfsd_serv_try_get */
> >         localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
> >                                              cred, nfs_fh, fmode);
> >         if (IS_ERR(localio))
> >                 nfs_to->nfsd_serv_put(net);
> >         return localio;
> > 
> > I do think it cleans the code up... full patch is here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-next.v15-with-fixups&id=e85306941878a87070176702de687f2779436061
> > 
> > But I'm still on the fence.. someone help push me over!
> 
> I think the new code is unquestionable clearer, and not taking this
> approach would be a micro-optimisation which would need to be
> numerically justified.  So I'm pushing for the three-interface version
> (despite what I said before).
> 
> Unfortunately the new code is not bug-free - not quite.
> As soon as nfs_to->nfsd_serv_put() calls percpu_ref_put() the nfsd
> module can be unloaded, and the "return" instruction might not be
> present.  For this to go wrong would require a lot of bad luck, but if
> the CPU took an interrupt at the wrong time were would be room.
> 
> [Ever since module_put_and_exit() was added (now ..and_kthread_exit)
>  I've been sensitive to dropping the ref to a module in code running in
>  the module]
> 
> So I think nfsd_serv_put (and nfsd_serv_try_get() __must_hold(RCU) and
> nfs_open_local_fh() needs rcu_read_lock() before calling
> nfs_to->nfsd_serv_put(net).

OK, yes I can see that, I implemented what you suggested at the end of
your reply (see inline patch below)...

But I'd just like to point out that something like the below patch
wouldn't be needed if we kept my "heavy" approach (nfs reference on
nfsd modules via nfs_common using request_symbol):
https://marc.info/?l=linux-nfs&m=172499445027800&w=2
(that patch has stuff I since cleaned up, e.g. removed typedefs and
EXPORT_SYMBOL_GPLs..)

I knew we were going to pay for being too cute with how nfs took its
reference on nfsd.

So here we are, needing fiddly incremental fixes like this to close a
really-small-yet-will-be-deadly race:

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index c29cdf51c458..d124c265b8fd 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -341,7 +341,7 @@ nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
 
-	nfs_to->nfsd_file_put_local(iocb->localio);
+	nfs_to_nfsd_file_put_local(iocb->localio);
 	nfs_local_iocb_free(iocb);
 	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
 }
@@ -622,7 +622,7 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 	}
 out:
 	if (status != 0) {
-		nfs_to->nfsd_file_put_local(localio);
+		nfs_to_nfsd_file_put_local(localio);
 		hdr->task.tk_status = status;
 		nfs_local_hdr_release(hdr, call_ops);
 	}
@@ -673,7 +673,7 @@ nfs_local_release_commit_data(struct nfsd_file *localio,
 		struct nfs_commit_data *data,
 		const struct rpc_call_ops *call_ops)
 {
-	nfs_to->nfsd_file_put_local(localio);
+	nfs_to_nfsd_file_put_local(localio);
 	call_ops->rpc_call_done(&data->task, data);
 	call_ops->rpc_release(data);
 }
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 42b479b9191f..5c8ce5066c16 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -142,8 +142,11 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	/* We have an implied reference to net thanks to nfsd_serv_try_get */
 	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
 					     cred, nfs_fh, fmode);
-	if (IS_ERR(localio))
+	if (IS_ERR(localio)) {
+		rcu_read_lock();
 		nfs_to->nfsd_serv_put(net);
+		rcu_read_unlock();
+	}
 	return localio;
 }
 EXPORT_SYMBOL_GPL(nfs_open_local_fh);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 7ff477b40bcd..0d389051d08d 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -398,7 +398,7 @@ nfsd_file_put(struct nfsd_file *nf)
  * reference to the associated nn->nfsd_serv.
  */
 void
-nfsd_file_put_local(struct nfsd_file *nf)
+nfsd_file_put_local(struct nfsd_file *nf) __must_hold(rcu)
 {
 	struct net *net = nf->nf_net;
 
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 291e9c69cae4..f441cb9f74d5 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -53,7 +53,7 @@ void nfsd_localio_ops_init(void)
  *
  * On successful return, returned nfsd_file will have its nf_net member
  * set. Caller (NFS client) is responsible for calling nfsd_serv_put and
- * nfsd_file_put (via nfs_to->nfsd_file_put_local).
+ * nfsd_file_put (via nfs_to_nfsd_file_put_local).
  */
 struct nfsd_file *
 nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index e236135ddc63..47172b407be8 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -214,14 +214,14 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
 	return 0;
 }
 
-bool nfsd_serv_try_get(struct net *net)
+bool nfsd_serv_try_get(struct net *net) __must_hold(rcu)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	return (nn && percpu_ref_tryget_live(&nn->nfsd_serv_ref));
 }
 
-void nfsd_serv_put(struct net *net)
+void nfsd_serv_put(struct net *net) __must_hold(rcu)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index b353abe00357..b0dd9b1eef4f 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -65,10 +65,25 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
 		   struct rpc_clnt *, const struct cred *,
 		   const struct nfs_fh *, const fmode_t);
 
+static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
+{
+	/*
+	 * Once reference to nfsd_serv is dropped, NFSD could be
+	 * unloaded, so ensure safe return from nfsd_file_put_local()
+	 * by always taking RCU.
+	 */
+	rcu_read_lock();
+	nfs_to->nfsd_file_put_local(localio);
+	rcu_read_unlock();
+}
+
 #else   /* CONFIG_NFS_LOCALIO */
 static inline void nfsd_localio_ops_init(void)
 {
 }
+static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
+{
+}
 #endif  /* CONFIG_NFS_LOCALIO */
 
 #endif  /* __LINUX_NFSLOCALIO_H */

> > 
> > Tangent, but in the related business of "what are next steps?":
> > 
> > I updated headers with various provided Reviewed-by:s and Acked-by:s,
> > fixed at least 1 commit header, fixed some sparse issues, various
> > fixes to nfs_to patch (removed EXPORT_SYMBOL_GPL, switched to using
> > pointer, updated nfs_to callers). Etc...
> > 
> > But if I fold those changes in I compromise the provided Reviewed-by
> > and Acked-by.. so I'm leaning toward posting a v16 that has
> > these incremental fixes/improvements, see the 3 topmost commits here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next.v15-with-fixups
> > 
> > Or if you can review the incremental patches I can fold them in and
> > preserve the various Reviewed-by and Acked-by...
> 
> I have reviewed the incremental patches and I'm happy for all my tags to
> apply to the new versions of the patches.

Thanks!
Mike

