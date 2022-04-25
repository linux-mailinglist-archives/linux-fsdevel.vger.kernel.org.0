Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1754A50EABA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 22:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245611AbiDYUnQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 16:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbiDYUnM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:43:12 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E10D39148;
        Mon, 25 Apr 2022 13:40:06 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5C99C713F; Mon, 25 Apr 2022 16:40:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5C99C713F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1650919206;
        bh=+VeekoRe29lf5XaVLwuUWvY5RPHgcwboIhxpWqt3LD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jda/rr4e8I0qHQVs9NYnkzJ56W+3Qpvwq/Dwt6Rpo7HOHBAczM4pohFZi2NwPtI3r
         DZdrsp0AYtbjaOFOd9RtcIuyYXu4/XbDNy4GF2IGWUY+pN9EU6pFOoOU9hncZk/X9o
         tQkSrirAZAq1LIJNlMdh6LFCMhIhcHI0RiklSQE0=
Date:   Mon, 25 Apr 2022 16:40:06 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v21 1/7] NFSD: add courteous server support for
 thread with only delegation
Message-ID: <20220425204006.GI24825@fieldses.org>
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
 <1650739455-26096-2-git-send-email-dai.ngo@oracle.com>
 <20220425185121.GE24825@fieldses.org>
 <90f5ec04-deff-38d0-2b6f-8b2f48b72d9d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f5ec04-deff-38d0-2b6f-8b2f48b72d9d@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 12:42:58PM -0700, dai.ngo@oracle.com wrote:
> 
> On 4/25/22 11:51 AM, J. Bruce Fields wrote:
> >On Sat, Apr 23, 2022 at 11:44:09AM -0700, Dai Ngo wrote:
> >>This patch provides courteous server support for delegation only.
> >>Only expired client with delegation but no conflict and no open
> >>or lock state is allowed to be in COURTESY state.
> >>
> >>Delegation conflict with COURTESY client is resolved by setting it
> >>to EXPIRABLE, queue work for the laundromat and return delay to
> >>caller. Conflict is resolved when the laudromat runs and expires
> >>the EXIRABLE client while the NFS client retries the OPEN request.
> >>Local thread request that gets conflict is doing the retry in
> >>__break_lease.
> >>
> >>Client in COURTESY state is allowed to reconnect and continues to
> >>have access to its state while client in EXPIRABLE state is not.
> >>To prevent 2 clients with the same name are on the conf_name_tree,
> >>nfsd4_setclientid is modified to expire confirmed client in EXPIRABLE
> >>state.
> >>
> >>The spinlock cl_cs_lock is used to handle race conditions between
> >>conflict resolver, nfsd_break_deleg_cb, and the COURTESY client
> >>doing reconnect.
> >>
> >>find_in_sessionid_hashtbl, find_confirmed_client_by_name and
> >>find_confirmed_client are modified to activate COURTESY client by
> >>setting it to ACTIVE state and skip client in EXPIRABLE state.
> >>
> >>Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> >>---
> >>  fs/nfsd/nfs4state.c | 129 +++++++++++++++++++++++++++++++++++++++++++++-------
> >>  fs/nfsd/nfsd.h      |   1 +
> >>  fs/nfsd/state.h     |  63 +++++++++++++++++++++++++
> >>  3 files changed, 177 insertions(+), 16 deletions(-)
> >>
> >>diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >>index 234e852fcdfa..fea5e24e7d94 100644
> >>--- a/fs/nfsd/nfs4state.c
> >>+++ b/fs/nfsd/nfs4state.c
> >>@@ -125,6 +125,8 @@ static void free_session(struct nfsd4_session *);
> >>  static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
> >>  static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
> >>+static struct workqueue_struct *laundry_wq;
> >>+
> >>  static bool is_session_dead(struct nfsd4_session *ses)
> >>  {
> >>  	return ses->se_flags & NFS4_SESSION_DEAD;
> >>@@ -690,6 +692,14 @@ static unsigned int file_hashval(struct svc_fh *fh)
> >>  static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
> >>+static inline void
> >>+run_laundromat(struct nfsd_net *nn, bool wait)
> >>+{
> >>+	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> >>+	if (wait)
> >>+		flush_workqueue(laundry_wq);
> >>+}
> >Let's keep those two things separate.  The "wait" argument isn't
> >self-documenting when reading the calling code.
> 
> we can use enum to spell out the intention.
> 
> >   And the
> >mod_delayed_work call isn't always needed before flush_workqueue.
> 
> ok. I'll keep them separate.
> 
> >
> >>+
> >>  static void
> >>  __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
> >>  {
> >>@@ -1939,6 +1949,11 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
> >>  	session = __find_in_sessionid_hashtbl(sessionid, net);
> >>  	if (!session)
> >>  		goto out;
> >>+	if (!try_to_activate_client(session->se_client)) {
> >>+		/* client is EXPIRABLE */
> >>+		session = NULL;
> >>+		goto out;
> >No, we definitely don't want to do this.  As I said before, an
> >"expirable client" should be treated in every way exactly like any
> >regular active client.  Literally the only difference is that the
> >laundromat can try to expire it.
> 
> Do you mean leave the state as EXPIRABLE but allow the callers
> to use the client as an ACTIVE client:

The only place we should even be checking whether a client is EXPIRABLE
is in the laundromat thread, in the loop over the client_lru.  Even
there, EXPIRABLE being set doesn't mean the client *has* to be expired,
the real decision is left to mark_client_expired_locked(), as it
currently is.

> static inline bool try_to_expire_client(struct nfs4_client *clp)
> {
>         bool ret;
> 
>         spin_lock(&clp->cl_cs_lock);
>         if (clp->cl_state == NFSD4_EXPIRABLE) {
>                 spin_unlock(&clp->cl_cs_lock);
>                 return false;            <<<====== was true
>         }
>         ret = NFSD4_COURTESY ==
>                 cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>         spin_unlock(&clp->cl_cs_lock);
>         return ret;
> }

So, try_to_expire_client(), as I said, should be just

  static bool try_to_expire_client(struct nfs4_client *clp)
  {
	return COURTESY == cmpxchg(clp->cl_state, COURTESY, EXPIRABLE);
  }

Except, OK, I did forget that somebody else could have already set
EXPIRABLE, and we still want to tell the caller to retry in that case,
so, oops, let's make it:

	return ACTIVE != cmpxchg(clp->cl_state, COURTESY, EXPIRABLE);

In other words: set EXPIRABLE if and only if the state is COURTESY, and
then tell the caller to retry the operation if and only if the state was
previously COURTESY or EXPIRABLE.

But we shouldn't need the cl_cs_lock, and certainly shouldn't be failing
lookups of EXPIRABLE clients.

--b.


> 
> -Dai
> 
> >
> >And then all this code becomes unnecessary:
> >
> >>@@ -702,4 +727,42 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
> >>  extern int nfsd4_client_record_check(struct nfs4_client *clp);
> >>  extern void nfsd4_record_grace_done(struct nfsd_net *nn);
> >>+static inline bool try_to_expire_client(struct nfs4_client *clp)
> >>+{
> >>+	bool ret;
> >>+
> >>+	spin_lock(&clp->cl_cs_lock);
> >>+	if (clp->cl_state == NFSD4_EXPIRABLE) {
> >>+		spin_unlock(&clp->cl_cs_lock);
> >>+		return true;
> >>+	}
> >>+	ret = NFSD4_COURTESY ==
> >>+		cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
> >>+	spin_unlock(&clp->cl_cs_lock);
> >>+	return ret;
> >>+}
> >>+
> >>+static inline bool try_to_activate_client(struct nfs4_client *clp)
> >>+{
> >>+	bool ret;
> >>+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> >>+
> >>+	/* sync with laundromat */
> >>+	lockdep_assert_held(&nn->client_lock);
> >>+
> >>+	/* sync with try_to_expire_client */
> >>+	spin_lock(&clp->cl_cs_lock);
> >>+	if (clp->cl_state == NFSD4_ACTIVE) {
> >>+		spin_unlock(&clp->cl_cs_lock);
> >>+		return true;
> >>+	}
> >>+	if (clp->cl_state == NFSD4_EXPIRABLE) {
> >>+		spin_unlock(&clp->cl_cs_lock);
> >>+		return false;
> >>+	}
> >>+	ret = NFSD4_COURTESY ==
> >>+		cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_ACTIVE);
> >>+	spin_unlock(&clp->cl_cs_lock);
> >>+	return ret;
> >>+}
> >--b.
