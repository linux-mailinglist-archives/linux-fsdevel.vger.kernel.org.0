Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC414EB1FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 18:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbiC2Qo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 12:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbiC2QoP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:44:15 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D49257189;
        Tue, 29 Mar 2022 09:42:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 365597113; Tue, 29 Mar 2022 12:42:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 365597113
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1648572150;
        bh=qqlWKGVmvnjYHsMgbc/sz/vcBibQ93Tvgr7Msv2sgmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=By8rlgmLwj0zEdUw4Lxh3Ttw/VcZu2Cth7myXiqGIOmS2/FauxyKUexB/IiNE37kW
         cUdt+YLav7DLZVhKoUtEKTACTxgAg2o4mJ2+Pnm6ul5g0enVymxKYWVPYr5Ma5Ywz9
         mSVQycQ3NVEXBbVaTk12gNd3PbKnqIY4dOGCUVV8=
Date:   Tue, 29 Mar 2022 12:42:30 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Message-ID: <20220329164230.GA32217@fieldses.org>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
 <1648182891-32599-3-git-send-email-dai.ngo@oracle.com>
 <20220329154750.GE29634@fieldses.org>
 <612ef738-20f6-55f0-1677-cc035ba2fd0d@oracle.com>
 <20220329163011.GG29634@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329163011.GG29634@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 12:30:11PM -0400, J. Bruce Fields wrote:
> On Tue, Mar 29, 2022 at 09:20:02AM -0700, dai.ngo@oracle.com wrote:
> > 
> > On 3/29/22 8:47 AM, J. Bruce Fields wrote:
> > >On Thu, Mar 24, 2022 at 09:34:42PM -0700, Dai Ngo wrote:
> > >>Update nfs4_client to add:
> > >>  . cl_cs_client_state: courtesy client state
> > >>  . cl_cs_lock: spinlock to synchronize access to cl_cs_client_state
> > >>  . cl_cs_list: list used by laundromat to process courtesy clients
> > >>
> > >>Modify alloc_client to initialize these fields.
> > >>
> > >>Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > >>---
> > >>  fs/nfsd/nfs4state.c |  2 ++
> > >>  fs/nfsd/nfsd.h      |  1 +
> > >>  fs/nfsd/state.h     | 33 +++++++++++++++++++++++++++++++++
> > >>  3 files changed, 36 insertions(+)
> > >>
> > >>diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > >>index 234e852fcdfa..a65d59510681 100644
> > >>--- a/fs/nfsd/nfs4state.c
> > >>+++ b/fs/nfsd/nfs4state.c
> > >>@@ -2009,12 +2009,14 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
> > >>  	INIT_LIST_HEAD(&clp->cl_delegations);
> > >>  	INIT_LIST_HEAD(&clp->cl_lru);
> > >>  	INIT_LIST_HEAD(&clp->cl_revoked);
> > >>+	INIT_LIST_HEAD(&clp->cl_cs_list);
> > >>  #ifdef CONFIG_NFSD_PNFS
> > >>  	INIT_LIST_HEAD(&clp->cl_lo_states);
> > >>  #endif
> > >>  	INIT_LIST_HEAD(&clp->async_copies);
> > >>  	spin_lock_init(&clp->async_lock);
> > >>  	spin_lock_init(&clp->cl_lock);
> > >>+	spin_lock_init(&clp->cl_cs_lock);
> > >>  	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
> > >>  	return clp;
> > >>  err_no_hashtbl:
> > >>diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > >>index 4fc1fd639527..23996c6ca75e 100644
> > >>--- a/fs/nfsd/nfsd.h
> > >>+++ b/fs/nfsd/nfsd.h
> > >>@@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
> > >>  #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
> > >>  #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
> > >>+#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
> > >>  /*
> > >>   * The following attributes are currently not supported by the NFSv4 server:
> > >>diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > >>index 95457cfd37fc..40e390abc842 100644
> > >>--- a/fs/nfsd/state.h
> > >>+++ b/fs/nfsd/state.h
> > >>@@ -283,6 +283,35 @@ struct nfsd4_sessionid {
> > >>  #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
> > >>  /*
> > >>+ * CLIENT_  CLIENT_ CLIENT_
> > >>+ * COURTESY EXPIRED RECONNECTED      Meaning                  Where set
> > >>+ * -----------------------------------------------------------------------------
> > >>+ * | false | false | false | Confirmed, active    | Default                    |
> > >>+ * |---------------------------------------------------------------------------|
> > >>+ * | true  | false | false | Courtesy state.      | nfs4_get_client_reaplist   |
> > >>+ * |       |       |       | Lease/lock/share     |                            |
> > >>+ * |       |       |       | reservation conflict |                            |
> > >>+ * |       |       |       | can cause Courtesy   |                            |
> > >>+ * |       |       |       | client to be expired |                            |
> > >>+ * |---------------------------------------------------------------------------|
> > >>+ * | false | true  | false | Courtesy client to be| nfs4_laundromat            |
> > >>+ * |       |       |       | expired by Laundromat| nfsd4_lm_lock_expired      |
> > >>+ * |       |       |       | due to conflict     | nfsd4_discard_courtesy_clnt |
> > >>+ * |       |       |       |                      | nfsd4_expire_courtesy_clnt |
> > >>+ * |---------------------------------------------------------------------------|
> > >>+ * | false | false | true  | Courtesy client      | nfsd4_courtesy_clnt_expired|
> > >>+ * |       |       |       | reconnected,         |                            |
> > >>+ * |       |       |       | becoming active      |                            |
> > >>+ * -----------------------------------------------------------------------------
> 
> By the way, where is a client returned to the normal (0) state?  That
> has to happen at some point.
> 
> How is CLIENT_EXPIRED treated differently from cl_time == 0, and why?
> 
> Why are RECONNECTED clients discarded in so many cases?  (E.g. whenever
> a bind_conn_to_session fails).

A priori I just don't see how it can be right to treat a reconnected
client in any way differently from an normal confirmed client.

Once we've told the client that its lease is still good, we have to
treat it like any other client, don't we?

--b.
