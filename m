Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEC54EB376
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbiC2SlC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 14:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240150AbiC2SlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:41:00 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A3C186E3;
        Tue, 29 Mar 2022 11:39:17 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id EAE8F7216; Tue, 29 Mar 2022 14:39:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EAE8F7216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1648579156;
        bh=l7hf+/hY3z2Okl7yVX+MQI2MxCbnIn5XMHfzb0XYAfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CXyGzrpPzfOgQD26/tvFUX1jZxJlNrClmD7rl0rveX35xnui2bsN3wShzYdeEas90
         +annabIY58ziGSDYNGzTmznrISzoJSjXHX7xZ1asNmwyLK94gjTW2nO7Tltv87D/ZE
         f7lB1mfOlcw+17HQOiAaDSNfnFjqr2dgfapb2lvI=
Date:   Tue, 29 Mar 2022 14:39:16 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Message-ID: <20220329183916.GC32217@fieldses.org>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
 <1648182891-32599-3-git-send-email-dai.ngo@oracle.com>
 <20220329154750.GE29634@fieldses.org>
 <612ef738-20f6-55f0-1677-cc035ba2fd0d@oracle.com>
 <20220329163011.GG29634@fieldses.org>
 <5cddab8d-dd92-6863-78fd-a4608a722927@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cddab8d-dd92-6863-78fd-a4608a722927@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 11:19:51AM -0700, dai.ngo@oracle.com wrote:
> 
> On 3/29/22 9:30 AM, J. Bruce Fields wrote:
> >On Tue, Mar 29, 2022 at 09:20:02AM -0700, dai.ngo@oracle.com wrote:
> >>On 3/29/22 8:47 AM, J. Bruce Fields wrote:
> >>>On Thu, Mar 24, 2022 at 09:34:42PM -0700, Dai Ngo wrote:
> >>>>Update nfs4_client to add:
> >>>>  . cl_cs_client_state: courtesy client state
> >>>>  . cl_cs_lock: spinlock to synchronize access to cl_cs_client_state
> >>>>  . cl_cs_list: list used by laundromat to process courtesy clients
> >>>>
> >>>>Modify alloc_client to initialize these fields.
> >>>>
> >>>>Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> >>>>---
> >>>>  fs/nfsd/nfs4state.c |  2 ++
> >>>>  fs/nfsd/nfsd.h      |  1 +
> >>>>  fs/nfsd/state.h     | 33 +++++++++++++++++++++++++++++++++
> >>>>  3 files changed, 36 insertions(+)
> >>>>
> >>>>diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >>>>index 234e852fcdfa..a65d59510681 100644
> >>>>--- a/fs/nfsd/nfs4state.c
> >>>>+++ b/fs/nfsd/nfs4state.c
> >>>>@@ -2009,12 +2009,14 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
> >>>>  	INIT_LIST_HEAD(&clp->cl_delegations);
> >>>>  	INIT_LIST_HEAD(&clp->cl_lru);
> >>>>  	INIT_LIST_HEAD(&clp->cl_revoked);
> >>>>+	INIT_LIST_HEAD(&clp->cl_cs_list);
> >>>>  #ifdef CONFIG_NFSD_PNFS
> >>>>  	INIT_LIST_HEAD(&clp->cl_lo_states);
> >>>>  #endif
> >>>>  	INIT_LIST_HEAD(&clp->async_copies);
> >>>>  	spin_lock_init(&clp->async_lock);
> >>>>  	spin_lock_init(&clp->cl_lock);
> >>>>+	spin_lock_init(&clp->cl_cs_lock);
> >>>>  	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
> >>>>  	return clp;
> >>>>  err_no_hashtbl:
> >>>>diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> >>>>index 4fc1fd639527..23996c6ca75e 100644
> >>>>--- a/fs/nfsd/nfsd.h
> >>>>+++ b/fs/nfsd/nfsd.h
> >>>>@@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
> >>>>  #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
> >>>>  #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
> >>>>+#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
> >>>>  /*
> >>>>   * The following attributes are currently not supported by the NFSv4 server:
> >>>>diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> >>>>index 95457cfd37fc..40e390abc842 100644
> >>>>--- a/fs/nfsd/state.h
> >>>>+++ b/fs/nfsd/state.h
> >>>>@@ -283,6 +283,35 @@ struct nfsd4_sessionid {
> >>>>  #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
> >>>>  /*
> >>>>+ * CLIENT_  CLIENT_ CLIENT_
> >>>>+ * COURTESY EXPIRED RECONNECTED      Meaning                  Where set
> >>>>+ * -----------------------------------------------------------------------------
> >>>>+ * | false | false | false | Confirmed, active    | Default                    |
> >>>>+ * |---------------------------------------------------------------------------|
> >>>>+ * | true  | false | false | Courtesy state.      | nfs4_get_client_reaplist   |
> >>>>+ * |       |       |       | Lease/lock/share     |                            |
> >>>>+ * |       |       |       | reservation conflict |                            |
> >>>>+ * |       |       |       | can cause Courtesy   |                            |
> >>>>+ * |       |       |       | client to be expired |                            |
> >>>>+ * |---------------------------------------------------------------------------|
> >>>>+ * | false | true  | false | Courtesy client to be| nfs4_laundromat            |
> >>>>+ * |       |       |       | expired by Laundromat| nfsd4_lm_lock_expired      |
> >>>>+ * |       |       |       | due to conflict     | nfsd4_discard_courtesy_clnt |
> >>>>+ * |       |       |       |                      | nfsd4_expire_courtesy_clnt |
> >>>>+ * |---------------------------------------------------------------------------|
> >>>>+ * | false | false | true  | Courtesy client      | nfsd4_courtesy_clnt_expired|
> >>>>+ * |       |       |       | reconnected,         |                            |
> >>>>+ * |       |       |       | becoming active      |                            |
> >>>>+ * -----------------------------------------------------------------------------
> >By the way, where is a client returned to the normal (0) state?  That
> >has to happen at some point.
> 
> For 4.1 courtesy client reconnects is detected in nfsd4_sequence,
> nfsd4_bind_conn_to_session.

Those are the places where NFSD54_CLIENT_RECONNECTED is set, which isn't
the question I asked.

> >Why are RECONNECTED clients discarded in so many cases?  (E.g. whenever
> >a bind_conn_to_session fails).
> 
> find_in_sessionid_hashtbl: we discard the courtesy client when it
> reconnects and there is error from nfsd4_get_session_locked. This
> should be a rare condition so rather than reverting the client
> state back to courtesy, it is simpler just to discard it.

That may be a rare situation, but I don't believe the behavior of
discarding the client in this case is correct.

> nfsd4_create_session/find_confirmed_client: I think the only time
> the courtesy client sends CREATE_SESSION, before sending the SEQUENCE
> to reconnect after missing its leases, is when it wants to do clientid
> trunking. This should be a rare condition so instead of dealing
> with it we just do not allow it and discard the client for now.

We can't wave away incorrect behavior with "but it's rare".  Users with
heavy and/or unusual workloads hit rare conditions.  Clients may change
their behavior over time.  (E.g., trunking may become more common.)

--b.

> nfsd4_destroy_clientid/find_confirmed_client: instead of destroy
> the courtesy client here we just let the laundromat destroy it
> as if the client already expired.
> 
> nfsd4_setclientid_confirm/find_confirmed_client: there should not
> be any courtesy client found from nfsd4_setclientid_confirm, it
> should be detected and discarded in nfsd4_setclientid.
> 
> -Dai
> 
> >>>These are mutually exclusive values, not bits that may set to 0 or 1, so
> >>>the three boolean columns are confusing.  I'd just structure the table
> >>>like:
> >>>
> >>>	client state	meaning			where set
> >>>	0		Confirmed, active	Default
> >>>	CLIENT_COURTESY	Courtesy state....	nfs4_get_client_reaplist
> >>>	CLIENT_EXPIRED	Courtesy client to be..	nfs4_laundromat
> >>>
> >>>etc.
> >>will fix in v19.
> >>
> >>Thanks,
> >>-Dai
> >>
> >>>--b.
> >>>
> >>>>+ */
> >>>>+
> >>>>+enum courtesy_client_state {
> >>>>+	NFSD4_CLIENT_COURTESY = 1,
> >>>>+	NFSD4_CLIENT_EXPIRED,
> >>>>+	NFSD4_CLIENT_RECONNECTED,
> >>>>+};
> >>>>+
> >>>>+/*
> >>>>   * struct nfs4_client - one per client.  Clientids live here.
> >>>>   *
> >>>>   * The initial object created by an NFS client using SETCLIENTID (for NFSv4.0)
> >>>>@@ -385,6 +414,10 @@ struct nfs4_client {
> >>>>  	struct list_head	async_copies;	/* list of async copies */
> >>>>  	spinlock_t		async_lock;	/* lock for async copies */
> >>>>  	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
> >>>>+
> >>>>+	enum courtesy_client_state	cl_cs_client_state;
> >>>>+	spinlock_t		cl_cs_lock;
> >>>>+	struct list_head	cl_cs_list;
> >>>>  };
> >>>>  /* struct nfs4_client_reset
> >>>>-- 
> >>>>2.9.5
