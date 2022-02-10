Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345C74B12C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 17:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbiBJQcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 11:32:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbiBJQcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:32:16 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2168104;
        Thu, 10 Feb 2022 08:32:15 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 43CCC6F2D; Thu, 10 Feb 2022 11:32:15 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 43CCC6F2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1644510735;
        bh=Zmi5zHYRDHhUDgMLlZ61bOSsMZxmy70me7846Xp6Qh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0R1LFkuxL6H73arQoBkEovVltc1ELoZe4tIWE1PmSpGUfNcq90ZL0MYHjN0hn3Koj
         1pGEdZDiSONuq/fdfJ7tMt6m9SVW9WyR+vJzmy5ph6lL1ZZwbLG15uchyTIOCbEOAV
         C7BpbAZG3vNmbgdkJ1aQ2gvlKPyUxzZ045/fcICU=
Date:   Thu, 10 Feb 2022 11:32:15 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v12 3/3] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220210163215.GH21434@fieldses.org>
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
 <1644468729-30383-4-git-send-email-dai.ngo@oracle.com>
 <20220210151759.GE21434@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210151759.GE21434@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I was standing in the shower thinking....

We're now removing the persistent client record early, after the first
lease period expires, instead of waiting till the first lock conflict.

That simplifies conflict handling.

It also means that all clients lose their locks any time a crash or
reboot is preceded by a network partition of longer than a lease period.

Which is what happens currently, so it's no regression.

Still, I think it will be a common case that it would be nice to handle:
there's a network problem, and as a later consequence of the problem or
perhaps a part of addressing it, the server gets rebooted.  There's no
real reason to prevent clients recovering in that case.

Seems likely enough that it would be worth a little extra complexity in
the code that handles conflicts.

So I'm no longer convinced that it's a good tradeoff to remove the
persistent client record early.

--b.

On Thu, Feb 10, 2022 at 10:17:59AM -0500, J. Bruce Fields wrote:
> Thanks for your persistence, this is a tricky project!:
> 
> On Wed, Feb 09, 2022 at 08:52:09PM -0800, Dai Ngo wrote:
> > Currently an NFSv4 client must maintain its lease by using the at least
> > one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
> > a singleton SEQUENCE (4.1) at least once during each lease period. If the
> > client fails to renew the lease, for any reason, the Linux server expunges
> > the state tokens immediately upon detection of the "failure to renew the
> > lease" condition and begins returning NFS4ERR_EXPIRED if the client should
> > reconnect and attempt to use the (now) expired state.
> > 
> > The default lease period for the Linux server is 90 seconds.  The typical
> > client cuts that in half and will issue a lease renewing operation every
> > 45 seconds.
> 
> CLients have a lot of leeway there, and that's a detail not important to
> this patch.  Just cut this sentence.
> 
> > The 90 second lease period is very short considering the
> > potential for moderately long term network partitions.  A network partition
> > refers to any loss of network connectivity between the NFS client and the
> > NFS server, regardless of its root cause.  This includes NIC failures, NIC
> > driver bugs, network misconfigurations & administrative errors, routers &
> > switches crashing and/or having software updates applied, even down to
> > cables being physically pulled.  In most cases, these network failures are
> > transient, although the duration is unknown.
> 
> This patch is heavy reading.  Let's not make it longer than necessary.
> I'd replace the above paragraphs by something short like:
> 
> 	Problems such as hardware failures or administrative errors may
> 	cause network partitions longer than the NFSv4 lease period.
> 	Our server currently removes all client state as soon as a
> 	client fails to renew.
> 
> > A server which does not immediately expunge the state on lease expiration
> > is known as a Courteous Server.  A Courteous Server continues to recognize
> > previously generated state tokens as valid until conflict arises between
> > the expired state and the requests from another client, or the server
> > reboots.
> >
> > The initial implementation of the Courteous Server will do the following:
> > 
> > . When the laundromat thread detects an expired client and if that client
> > still has established state on the Linux server and there is no waiters
> > for the client's locks then deletes the client persistent record and marks
> > the client as NFSD4_CLIENT_COURTESY and skips destroying the client and
> > all of its state, otherwise destroys the client as usual.
> > 
> > . Client persistent record is added to the client database when the
> > courtesy client reconnects and transits to normal client.
> > 
> > . Lock/delegation/share reversation conflict with courtesy client is
> > resolved by marking the courtesy client as NFSD4_CLIENT_DESTROY_COURTESY,
> > effectively disable it, then allow the current request to proceed
> > immediately.
> > 
> > . Courtesy client marked as NFSD4_CLIENT_DESTROY_COURTESY is not allowed to
> > reconnect to reuse itsstate. It is expired by the laundromat asynchronously
> > in the background.
> 
> I haven't had a chance to read the code in detail yet.  Two things do
> jump out at me:
> 
> 	- Why the two flags? (CLIENT_COURTESY and CLIENT_COURTESY_CLNT?)
> 	  Are you sure that's necessary?  If so, that could use some
> 	  documentation.
> 
> 	- There is a lot of duplicated code.  For example, the code
> 	  added to find_in_sessionid_hashtable, find_clp_in_name_tree,
> 	  and find_client_in_id_table.  Any place you find yourself
> 	  repeating more than a line or two of code, please consider
> 	  factoring it out into a separate function.  That would make
> 	  this easier to read.
> 
> --b.
> 
> > 
> > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > ---
> >  fs/nfsd/nfs4state.c | 446 +++++++++++++++++++++++++++++++++++++++++++++++++---
> >  fs/nfsd/nfsd.h      |   1 +
> >  fs/nfsd/state.h     |   6 +
> >  3 files changed, 430 insertions(+), 23 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 1956d377d1a6..a50a670e2088 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1917,10 +1917,27 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
> >  {
> >  	struct nfsd4_session *session;
> >  	__be32 status = nfserr_badsession;
> > +	struct nfs4_client *clp;
> >  
> >  	session = __find_in_sessionid_hashtbl(sessionid, net);
> >  	if (!session)
> >  		goto out;
> > +	clp = session->se_client;
> > +	if (clp) {
> > +		clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
> > +		/* need to sync with thread resolving lock/deleg conflict */
> > +		spin_lock(&clp->cl_cs_lock);
> > +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
> > +			spin_unlock(&clp->cl_cs_lock);
> > +			session = NULL;
> > +			goto out;
> > +		}
> > +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> > +			clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> > +			set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
> > +		}
> > +		spin_unlock(&clp->cl_cs_lock);
> > +	}
> >  	status = nfsd4_get_session_locked(session);
> >  	if (status)
> >  		session = NULL;
> > @@ -1990,6 +2007,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
> >  	INIT_LIST_HEAD(&clp->cl_openowners);
> >  	INIT_LIST_HEAD(&clp->cl_delegations);
> >  	INIT_LIST_HEAD(&clp->cl_lru);
> > +	INIT_LIST_HEAD(&clp->cl_cs_list);
> >  	INIT_LIST_HEAD(&clp->cl_revoked);
> >  #ifdef CONFIG_NFSD_PNFS
> >  	INIT_LIST_HEAD(&clp->cl_lo_states);
> > @@ -1997,6 +2015,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
> >  	INIT_LIST_HEAD(&clp->async_copies);
> >  	spin_lock_init(&clp->async_lock);
> >  	spin_lock_init(&clp->cl_lock);
> > +	spin_lock_init(&clp->cl_cs_lock);
> >  	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
> >  	return clp;
> >  err_no_hashtbl:
> > @@ -2394,6 +2413,10 @@ static int client_info_show(struct seq_file *m, void *v)
> >  		seq_puts(m, "status: confirmed\n");
> >  	else
> >  		seq_puts(m, "status: unconfirmed\n");
> > +	seq_printf(m, "courtesy client: %s\n",
> > +		test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : "no");
> > +	seq_printf(m, "seconds from last renew: %lld\n",
> > +		ktime_get_boottime_seconds() - clp->cl_time);
> >  	seq_printf(m, "name: ");
> >  	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
> >  	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
> > @@ -2814,8 +2837,22 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
> >  			node = node->rb_left;
> >  		else if (cmp < 0)
> >  			node = node->rb_right;
> > -		else
> > +		else {
> > +			clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
> > +			/* sync with thread resolving lock/deleg conflict */
> > +			spin_lock(&clp->cl_cs_lock);
> > +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
> > +					&clp->cl_flags)) {
> > +				spin_unlock(&clp->cl_cs_lock);
> > +				return NULL;
> > +			}
> > +			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> > +				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> > +				set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
> > +			}
> > +			spin_unlock(&clp->cl_cs_lock);
> >  			return clp;
> > +		}
> >  	}
> >  	return NULL;
> >  }
> > @@ -2861,6 +2898,20 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
> >  		if (same_clid(&clp->cl_clientid, clid)) {
> >  			if ((bool)clp->cl_minorversion != sessions)
> >  				return NULL;
> > +
> > +			/* need to sync with thread resolving lock/deleg conflict */
> > +			clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
> > +			spin_lock(&clp->cl_cs_lock);
> > +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
> > +					&clp->cl_flags)) {
> > +				spin_unlock(&clp->cl_cs_lock);
> > +				continue;
> > +			}
> > +			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> > +				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> > +				set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
> > +			}
> > +			spin_unlock(&clp->cl_cs_lock);
> >  			renew_client_locked(clp);
> >  			return clp;
> >  		}
> > @@ -3177,6 +3228,12 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  	/* Cases below refer to rfc 5661 section 18.35.4: */
> >  	spin_lock(&nn->client_lock);
> >  	conf = find_confirmed_client_by_name(&exid->clname, nn);
> > +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
> > +		spin_lock(&conf->cl_cs_lock);
> > +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &conf->cl_flags);
> > +		spin_unlock(&conf->cl_cs_lock);
> > +		conf = NULL;
> > +	}
> >  	if (conf) {
> >  		bool creds_match = same_creds(&conf->cl_cred, &rqstp->rq_cred);
> >  		bool verfs_match = same_verf(&verf, &conf->cl_verifier);
> > @@ -3444,6 +3501,12 @@ nfsd4_create_session(struct svc_rqst *rqstp,
> >  	spin_lock(&nn->client_lock);
> >  	unconf = find_unconfirmed_client(&cr_ses->clientid, true, nn);
> >  	conf = find_confirmed_client(&cr_ses->clientid, true, nn);
> > +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
> > +		spin_lock(&conf->cl_cs_lock);
> > +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &conf->cl_flags);
> > +		spin_unlock(&conf->cl_cs_lock);
> > +		conf = NULL;
> > +	}
> >  	WARN_ON_ONCE(conf && unconf);
> >  
> >  	if (conf) {
> > @@ -3475,6 +3538,12 @@ nfsd4_create_session(struct svc_rqst *rqstp,
> >  			goto out_free_conn;
> >  		}
> >  		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
> > +		if (old && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &old->cl_flags)) {
> > +			spin_lock(&old->cl_cs_lock);
> > +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &old->cl_flags);
> > +			spin_unlock(&old->cl_cs_lock);
> > +			old = NULL;
> > +		}
> >  		if (old) {
> >  			status = mark_client_expired_locked(old);
> >  			if (status) {
> > @@ -3613,6 +3682,7 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
> >  	struct nfsd4_session *session;
> >  	struct net *net = SVC_NET(rqstp);
> >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > +	struct nfs4_client *clp;
> >  
> >  	if (!nfsd4_last_compound_op(rqstp))
> >  		return nfserr_not_only_op;
> > @@ -3645,6 +3715,16 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
> >  	nfsd4_init_conn(rqstp, conn, session);
> >  	status = nfs_ok;
> >  out:
> > +	clp = session->se_client;
> > +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
> > +		if (status == nfs_ok)
> > +			nfsd4_client_record_create(clp);
> > +		else {
> > +			spin_lock(&clp->cl_cs_lock);
> > +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
> > +			spin_unlock(&clp->cl_cs_lock);
> > +		}
> > +	}
> >  	nfsd4_put_session(session);
> >  out_no_session:
> >  	return status;
> > @@ -3667,6 +3747,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
> >  	int ref_held_by_me = 0;
> >  	struct net *net = SVC_NET(r);
> >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > +	struct nfs4_client *clp;
> >  
> >  	status = nfserr_not_only_op;
> >  	if (nfsd4_compound_in_session(cstate, sessionid)) {
> > @@ -3679,6 +3760,15 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
> >  	ses = find_in_sessionid_hashtbl(sessionid, net, &status);
> >  	if (!ses)
> >  		goto out_client_lock;
> > +	clp = ses->se_client;
> > +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
> > +		status = nfserr_badsession;
> > +		spin_lock(&clp->cl_cs_lock);
> > +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
> > +		spin_unlock(&clp->cl_cs_lock);
> > +		goto out_put_session;
> > +	}
> > +
> >  	status = nfserr_wrong_cred;
> >  	if (!nfsd4_mach_creds_match(ses->se_client, r))
> >  		goto out_put_session;
> > @@ -3783,7 +3873,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  	struct nfsd4_compoundres *resp = rqstp->rq_resp;
> >  	struct xdr_stream *xdr = resp->xdr;
> >  	struct nfsd4_session *session;
> > -	struct nfs4_client *clp;
> > +	struct nfs4_client *clp = NULL;
> >  	struct nfsd4_slot *slot;
> >  	struct nfsd4_conn *conn;
> >  	__be32 status;
> > @@ -3893,6 +3983,15 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  	if (conn)
> >  		free_conn(conn);
> >  	spin_unlock(&nn->client_lock);
> > +	if (clp && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
> > +		if (status == nfs_ok)
> > +			nfsd4_client_record_create(clp);
> > +		else {
> > +			spin_lock(&clp->cl_cs_lock);
> > +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
> > +			spin_unlock(&clp->cl_cs_lock);
> > +		}
> > +	}
> >  	return status;
> >  out_put_session:
> >  	nfsd4_put_session_locked(session);
> > @@ -3929,6 +4028,12 @@ nfsd4_destroy_clientid(struct svc_rqst *rqstp,
> >  	spin_lock(&nn->client_lock);
> >  	unconf = find_unconfirmed_client(&dc->clientid, true, nn);
> >  	conf = find_confirmed_client(&dc->clientid, true, nn);
> > +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
> > +		spin_lock(&conf->cl_cs_lock);
> > +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &conf->cl_flags);
> > +		spin_unlock(&conf->cl_cs_lock);
> > +		conf = NULL;
> > +	}
> >  	WARN_ON_ONCE(conf && unconf);
> >  
> >  	if (conf) {
> > @@ -4012,12 +4117,17 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  	struct nfs4_client	*unconf = NULL;
> >  	__be32 			status;
> >  	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> > +	struct nfs4_client *cclient = NULL;
> >  
> >  	new = create_client(clname, rqstp, &clverifier);
> >  	if (new == NULL)
> >  		return nfserr_jukebox;
> >  	spin_lock(&nn->client_lock);
> >  	conf = find_confirmed_client_by_name(&clname, nn);
> > +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
> > +		cclient = conf;
> > +		conf = NULL;
> > +	}
> >  	if (conf && client_has_state(conf)) {
> >  		status = nfserr_clid_inuse;
> >  		if (clp_used_exchangeid(conf))
> > @@ -4048,7 +4158,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  	new = NULL;
> >  	status = nfs_ok;
> >  out:
> > +	if (cclient)
> > +		unhash_client_locked(cclient);
> >  	spin_unlock(&nn->client_lock);
> > +	if (cclient)
> > +		expire_client(cclient);
> >  	if (new)
> >  		free_client(new);
> >  	if (unconf) {
> > @@ -4078,6 +4192,12 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
> >  	spin_lock(&nn->client_lock);
> >  	conf = find_confirmed_client(clid, false, nn);
> >  	unconf = find_unconfirmed_client(clid, false, nn);
> > +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
> > +		spin_lock(&conf->cl_cs_lock);
> > +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &conf->cl_flags);
> > +		spin_unlock(&conf->cl_cs_lock);
> > +		conf = NULL;
> > +	}
> >  	/*
> >  	 * We try hard to give out unique clientid's, so if we get an
> >  	 * attempt to confirm the same clientid with a different cred,
> > @@ -4108,6 +4228,13 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
> >  		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
> >  	} else {
> >  		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
> > +		if (old && test_bit(NFSD4_CLIENT_COURTESY_CLNT,
> > +						&old->cl_flags)) {
> > +			spin_lock(&old->cl_cs_lock);
> > +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &old->cl_flags);
> > +			spin_unlock(&old->cl_cs_lock);
> > +			old = NULL;
> > +		}
> >  		if (old) {
> >  			status = nfserr_clid_inuse;
> >  			if (client_has_state(old)
> > @@ -4691,18 +4818,41 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> >  	return ret;
> >  }
> >  
> > +/*
> > + * Function returns true if lease conflict was resolved
> > + * else returns false.
> > + */
> >  static bool nfsd_breaker_owns_lease(struct file_lock *fl)
> >  {
> >  	struct nfs4_delegation *dl = fl->fl_owner;
> >  	struct svc_rqst *rqst;
> >  	struct nfs4_client *clp;
> >  
> > +	clp = dl->dl_stid.sc_client;
> > +
> > +	/*
> > +	 * need to sync with courtesy client trying to reconnect using
> > +	 * the cl_cs_lock, nn->client_lock can not be used since this
> > +	 * function is called with the fl_lck held.
> > +	 */
> > +	spin_lock(&clp->cl_cs_lock);
> > +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
> > +		spin_unlock(&clp->cl_cs_lock);
> > +		return true;
> > +	}
> > +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> > +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
> > +		spin_unlock(&clp->cl_cs_lock);
> > +		return true;
> > +	}
> > +	spin_unlock(&clp->cl_cs_lock);
> > +
> >  	if (!i_am_nfsd())
> > -		return NULL;
> > +		return false;
> >  	rqst = kthread_data(current);
> >  	/* Note rq_prog == NFS_ACL_PROGRAM is also possible: */
> >  	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
> > -		return NULL;
> > +		return false;
> >  	clp = *(rqst->rq_lease_breaker);
> >  	return dl->dl_stid.sc_client == clp;
> >  }
> > @@ -4735,7 +4885,7 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4
> >  }
> >  
> >  static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
> > -						struct nfsd_net *nn)
> > +			struct nfsd_net *nn)
> >  {
> >  	struct nfs4_client *found;
> >  
> > @@ -4765,6 +4915,9 @@ static __be32 set_client(clientid_t *clid,
> >  	cstate->clp = lookup_clientid(clid, false, nn);
> >  	if (!cstate->clp)
> >  		return nfserr_expired;
> > +
> > +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &cstate->clp->cl_flags))
> > +		nfsd4_client_record_create(cstate->clp);
> >  	return nfs_ok;
> >  }
> >  
> > @@ -4917,9 +5070,89 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
> >  	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
> >  }
> >  
> > -static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
> > +static bool
> > +nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
> > +			bool share_access)
> > +{
> > +	if (share_access) {
> > +		if (!stp->st_deny_bmap)
> > +			return false;
> > +
> > +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
> > +			(access & NFS4_SHARE_ACCESS_READ &&
> > +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
> > +			(access & NFS4_SHARE_ACCESS_WRITE &&
> > +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
> > +			return true;
> > +		}
> > +		return false;
> > +	}
> > +	if ((access & NFS4_SHARE_DENY_BOTH) ||
> > +		(access & NFS4_SHARE_DENY_READ &&
> > +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
> > +		(access & NFS4_SHARE_DENY_WRITE &&
> > +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +
> > +/*
> > + * This function is called to check whether nfserr_share_denied should
> > + * be returning to client.
> > + *
> > + * access:  is op_share_access if share_access is true.
> > + *	    Check if access mode, op_share_access, would conflict with
> > + *	    the current deny mode of the file 'fp'.
> > + * access:  is op_share_deny if share_access is false.
> > + *	    Check if the deny mode, op_share_deny, would conflict with
> > + *	    current access of the file 'fp'.
> > + * stp:     skip checking this entry.
> > + * new_stp: normal open, not open upgrade.
> > + *
> > + * Function returns:
> > + *	true   - access/deny mode conflict with normal client.
> > + *	false  - no conflict or conflict with courtesy client(s) is resolved.
> > + */
> > +static bool
> > +nfs4_conflict_clients(struct nfs4_file *fp, bool new_stp,
> > +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
> > +{
> > +	struct nfs4_ol_stateid *st;
> > +	struct nfs4_client *cl;
> > +	bool conflict = false;
> > +
> > +	lockdep_assert_held(&fp->fi_lock);
> > +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
> > +		if (st->st_openstp || (st == stp && new_stp) ||
> > +			(!nfs4_check_access_deny_bmap(st,
> > +					access, share_access)))
> > +			continue;
> > +
> > +		/* need to sync with courtesy client trying to reconnect */
> > +		cl = st->st_stid.sc_client;
> > +		spin_lock(&cl->cl_cs_lock);
> > +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags)) {
> > +			spin_unlock(&cl->cl_cs_lock);
> > +			continue;
> > +		}
> > +		if (test_bit(NFSD4_CLIENT_COURTESY, &cl->cl_flags)) {
> > +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags);
> > +			spin_unlock(&cl->cl_cs_lock);
> > +			continue;
> > +		}
> > +		/* conflict not caused by courtesy client */
> > +		spin_unlock(&cl->cl_cs_lock);
> > +		conflict = true;
> > +		break;
> > +	}
> > +	return conflict;
> > +}
> > +
> > +static __be32
> > +nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
> >  		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
> > -		struct nfsd4_open *open)
> > +		struct nfsd4_open *open, bool new_stp)
> >  {
> >  	struct nfsd_file *nf = NULL;
> >  	__be32 status;
> > @@ -4935,15 +5168,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
> >  	 */
> >  	status = nfs4_file_check_deny(fp, open->op_share_deny);
> >  	if (status != nfs_ok) {
> > -		spin_unlock(&fp->fi_lock);
> > -		goto out;
> > +		if (status != nfserr_share_denied) {
> > +			spin_unlock(&fp->fi_lock);
> > +			goto out;
> > +		}
> > +		if (nfs4_conflict_clients(fp, new_stp, stp,
> > +				open->op_share_deny, false)) {
> > +			spin_unlock(&fp->fi_lock);
> > +			goto out;
> > +		}
> >  	}
> >  
> >  	/* set access to the file */
> >  	status = nfs4_file_get_access(fp, open->op_share_access);
> >  	if (status != nfs_ok) {
> > -		spin_unlock(&fp->fi_lock);
> > -		goto out;
> > +		if (status != nfserr_share_denied) {
> > +			spin_unlock(&fp->fi_lock);
> > +			goto out;
> > +		}
> > +		if (nfs4_conflict_clients(fp, new_stp, stp,
> > +				open->op_share_access, true)) {
> > +			spin_unlock(&fp->fi_lock);
> > +			goto out;
> > +		}
> >  	}
> >  
> >  	/* Set access bits in stateid */
> > @@ -4994,7 +5241,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
> >  	unsigned char old_deny_bmap = stp->st_deny_bmap;
> >  
> >  	if (!test_access(open->op_share_access, stp))
> > -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
> > +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
> >  
> >  	/* test and set deny mode */
> >  	spin_lock(&fp->fi_lock);
> > @@ -5343,7 +5590,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
> >  			goto out;
> >  		}
> >  	} else {
> > -		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> > +		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
> >  		if (status) {
> >  			stp->st_stid.sc_type = NFS4_CLOSED_STID;
> >  			release_open_stateid(stp);
> > @@ -5577,6 +5824,121 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
> >  }
> >  #endif
> >  
> > +static bool
> > +nfs4_anylock_blocker(struct nfs4_client *clp)
> > +{
> > +	int i;
> > +	struct nfs4_stateowner *so, *tmp;
> > +	struct nfs4_lockowner *lo;
> > +	struct nfs4_ol_stateid *stp;
> > +	struct nfs4_file *nf;
> > +	struct inode *ino;
> > +	struct file_lock_context *ctx;
> > +	struct file_lock *fl;
> > +
> > +	spin_lock(&clp->cl_lock);
> > +	for (i = 0; i < OWNER_HASH_SIZE; i++) {
> > +		/* scan each lock owner */
> > +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
> > +				so_strhash) {
> > +			if (so->so_is_open_owner)
> > +				continue;
> > +
> > +			/* scan lock states of this lock owner */
> > +			lo = lockowner(so);
> > +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
> > +					st_perstateowner) {
> > +				nf = stp->st_stid.sc_file;
> > +				ino = nf->fi_inode;
> > +				ctx = ino->i_flctx;
> > +				if (!ctx)
> > +					continue;
> > +				/* check each lock belongs to this lock state */
> > +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> > +					if (fl->fl_owner != lo)
> > +						continue;
> > +					if (!list_empty(&fl->fl_blocked_requests)) {
> > +						spin_unlock(&clp->cl_lock);
> > +						return true;
> > +					}
> > +				}
> > +			}
> > +		}
> > +	}
> > +	spin_unlock(&clp->cl_lock);
> > +	return false;
> > +}
> > +
> > +static void
> > +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
> > +				struct laundry_time *lt)
> > +{
> > +	struct list_head *pos, *next;
> > +	struct nfs4_client *clp;
> > +	bool cour;
> > +	struct list_head cslist;
> > +
> > +	INIT_LIST_HEAD(reaplist);
> > +	INIT_LIST_HEAD(&cslist);
> > +	spin_lock(&nn->client_lock);
> > +	list_for_each_safe(pos, next, &nn->client_lru) {
> > +		clp = list_entry(pos, struct nfs4_client, cl_lru);
> > +		if (!state_expired(lt, clp->cl_time))
> > +			break;
> > +
> > +		/* client expired */
> > +		if (!client_has_state(clp)) {
> > +			if (mark_client_expired_locked(clp))
> > +				continue;
> > +			list_add(&clp->cl_lru, reaplist);
> > +			continue;
> > +		}
> > +
> > +		/* expired client has state */
> > +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
> > +			goto exp_client;
> > +
> > +		cour = test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> > +		if (cour &&
> > +			ktime_get_boottime_seconds() >= clp->courtesy_client_expiry)
> > +			goto exp_client;
> > +
> > +		if (nfs4_anylock_blocker(clp)) {
> > +			/* expired client has state and has blocker. */
> > +exp_client:
> > +			if (mark_client_expired_locked(clp))
> > +				continue;
> > +			list_add(&clp->cl_lru, reaplist);
> > +			continue;
> > +		}
> > +		/*
> > +		 * Client expired and has state and has no blockers.
> > +		 * If there is race condition with blockers, next time
> > +		 * the laundromat runs it will catch it and expires
> > +		 * the client.
> > +		 */
> > +		if (!cour) {
> > +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> > +			clp->courtesy_client_expiry = ktime_get_boottime_seconds() +
> > +					NFSD_COURTESY_CLIENT_TIMEOUT;
> > +			list_add(&clp->cl_cs_list, &cslist);
> > +		}
> > +	}
> > +	spin_unlock(&nn->client_lock);
> > +
> > +	list_for_each_entry(clp, &cslist, cl_cs_list) {
> > +		spin_lock(&clp->cl_cs_lock);
> > +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags) ||
> > +			!test_bit(NFSD4_CLIENT_COURTESY,
> > +					&clp->cl_flags)) {
> > +			spin_unlock(&clp->cl_cs_lock);
> > +			continue;
> > +		}
> > +		spin_unlock(&clp->cl_cs_lock);
> > +		nfsd4_client_record_remove(clp);
> > +	}
> > +}
> > +
> >  static time64_t
> >  nfs4_laundromat(struct nfsd_net *nn)
> >  {
> > @@ -5610,16 +5972,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> >  	}
> >  	spin_unlock(&nn->s2s_cp_lock);
> >  
> > -	spin_lock(&nn->client_lock);
> > -	list_for_each_safe(pos, next, &nn->client_lru) {
> > -		clp = list_entry(pos, struct nfs4_client, cl_lru);
> > -		if (!state_expired(&lt, clp->cl_time))
> > -			break;
> > -		if (mark_client_expired_locked(clp))
> > -			continue;
> > -		list_add(&clp->cl_lru, &reaplist);
> > -	}
> > -	spin_unlock(&nn->client_lock);
> > +	nfs4_get_client_reaplist(nn, &reaplist, &lt);
> >  	list_for_each_safe(pos, next, &reaplist) {
> >  		clp = list_entry(pos, struct nfs4_client, cl_lru);
> >  		trace_nfsd_clid_purged(&clp->cl_clientid);
> > @@ -6001,6 +6354,15 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> >  	found = lookup_clientid(&cps->cp_p_clid, true, nn);
> >  	if (!found)
> >  		goto out;
> > +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &found->cl_flags)) {
> > +		spin_lock(&found->cl_cs_lock);
> > +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &found->cl_flags);
> > +		spin_unlock(&found->cl_cs_lock);
> > +		if (atomic_dec_and_lock(&found->cl_rpc_users,
> > +					&nn->client_lock))
> > +			spin_unlock(&nn->client_lock);
> > +		goto out;
> > +	}
> >  
> >  	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
> >  			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
> > @@ -6501,6 +6863,43 @@ nfs4_transform_lock_offset(struct file_lock *lock)
> >  		lock->fl_end = OFFSET_MAX;
> >  }
> >  
> > +/**
> > + * nfsd4_fl_lock_conflict - check if lock conflict can be resolved.
> > + *
> > + * @fl: pointer to file_lock with a potential conflict
> > + * Return values:
> > + *   %true: real conflict, lock conflict can not be resolved.
> > + *   %false: no conflict, lock conflict was resolved.
> > + *
> > + * Note that this function is called while the flc_lock is held.
> > + */
> > +static bool
> > +nfsd4_fl_lock_conflict(struct file_lock *fl)
> > +{
> > +	struct nfs4_lockowner *lo;
> > +	struct nfs4_client *clp;
> > +	bool rc = true;
> > +
> > +	if (!fl)
> > +		return true;
> > +	lo = (struct nfs4_lockowner *)fl->fl_owner;
> > +	clp = lo->lo_owner.so_client;
> > +
> > +	/* need to sync with courtesy client trying to reconnect */
> > +	spin_lock(&clp->cl_cs_lock);
> > +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
> > +		rc = false;
> > +	else {
> > +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> > +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
> > +			rc =  false;
> > +		} else
> > +			rc =  true;
> > +	}
> > +	spin_unlock(&clp->cl_cs_lock);
> > +	return rc;
> > +}
> > +
> >  static fl_owner_t
> >  nfsd4_fl_get_owner(fl_owner_t owner)
> >  {
> > @@ -6548,6 +6947,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
> >  	.lm_notify = nfsd4_lm_notify,
> >  	.lm_get_owner = nfsd4_fl_get_owner,
> >  	.lm_put_owner = nfsd4_fl_put_owner,
> > +	.lm_lock_conflict = nfsd4_fl_lock_conflict,
> >  };
> >  
> >  static inline void
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 498e5a489826..5e3e699c8e76 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
> >  #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
> >  
> >  #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
> > +#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
> >  
> >  /*
> >   * The following attributes are currently not supported by the NFSv4 server:
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index e73bdbb1634a..c3c65421d422 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -345,6 +345,9 @@ struct nfs4_client {
> >  #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
> >  #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
> >  					 1 << NFSD4_CLIENT_CB_KILL)
> > +#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */
> > +#define NFSD4_CLIENT_DESTROY_COURTESY	(7)
> > +#define NFSD4_CLIENT_COURTESY_CLNT	(8)
> >  	unsigned long		cl_flags;
> >  	const struct cred	*cl_cb_cred;
> >  	struct rpc_clnt		*cl_cb_client;
> > @@ -385,6 +388,9 @@ struct nfs4_client {
> >  	struct list_head	async_copies;	/* list of async copies */
> >  	spinlock_t		async_lock;	/* lock for async copies */
> >  	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
> > +	int			courtesy_client_expiry;
> > +	spinlock_t		cl_cs_lock;
> > +	struct list_head	cl_cs_list;
> >  };
> >  
> >  /* struct nfs4_client_reset
> > -- 
> > 2.9.5
