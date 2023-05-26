Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B53171305D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 May 2023 01:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjEZX1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 19:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjEZX1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 19:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7E3B6;
        Fri, 26 May 2023 16:27:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7742A653FD;
        Fri, 26 May 2023 23:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B160C433EF;
        Fri, 26 May 2023 23:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685143635;
        bh=EYT3bd4GCNQY8FsiREuXfss/gcs1qIQQqlzl7HskQ+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AhUt+PrgBkiKxDS9BWGY/zyVxmAb1igAaFslkWcSB3wv3oYswXGjWsVmNsjHYJn9A
         RsVt0udwy9jVWLMhwAt5Az28o09KZLreErTyaey6TOz01o6JyE7azbRwi7tK2dvaaT
         la90m5Dxuptxty1RJeFIeGCogjgz2agBV/VofbN5JsbrMTcBGmiCNVI2ntFyrKfKZI
         mQ4UNODGWCeHm3tgH6pEMluapbKhHcsyzBPkHeiMB+1zUPNpDRb3PA4nNGm9BTgUpl
         4duS4i9ZDyfq3AKPOi2z6nLJJHemg+Y6bGRX5BE1doah8vEynsNgu+UfIGXlUXe28p
         ujNvm6+fHFusg==
Date:   Fri, 26 May 2023 19:27:12 -0400
From:   Chuck Lever <cel@kernel.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] NFSD: handle GETATTR conflict with write delegation
Message-ID: <ZHFAUA+PXrZs/BIU@manet.1015granger.net>
References: <1685122722-18287-1-git-send-email-dai.ngo@oracle.com>
 <1685122722-18287-2-git-send-email-dai.ngo@oracle.com>
 <ZHD8lDQADV6wUO4V@manet.1015granger.net>
 <85bc3a7b-7db0-1d83-44d9-c4d4c9640a37@oracle.com>
 <ZHELONbYnZe0wOzh@manet.1015granger.net>
 <3719ffe2-c232-6779-9379-8cdbf94c0ef8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3719ffe2-c232-6779-9379-8cdbf94c0ef8@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 01:54:12PM -0700, dai.ngo@oracle.com wrote:
> 
> On 5/26/23 12:40 PM, Chuck Lever wrote:
> > On Fri, May 26, 2023 at 12:34:16PM -0700, dai.ngo@oracle.com wrote:
> > > On 5/26/23 11:38 AM, Chuck Lever wrote:
> > > > On Fri, May 26, 2023 at 10:38:41AM -0700, Dai Ngo wrote:
> > > > > If the GETATTR request on a file that has write delegation in effect
> > > > > and the request attributes include the change info and size attribute
> > > > > then the write delegation is recalled. The server waits a maximum of
> > > > > 90ms for the delegation to be returned before replying NFS4ERR_DELAY
> > > > > for the GETATTR.
> > > > > 
> > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > ---
> > > > >    fs/nfsd/nfs4state.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >    fs/nfsd/nfs4xdr.c   |  5 +++++
> > > > >    fs/nfsd/state.h     |  3 +++
> > > > >    3 files changed, 56 insertions(+)
> > > > > 
> > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > index b90b74a5e66e..9f551dbf50d6 100644
> > > > > --- a/fs/nfsd/nfs4state.c
> > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > @@ -8353,3 +8353,51 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
> > > > >    {
> > > > >    	get_stateid(cstate, &u->write.wr_stateid);
> > > > >    }
> > > > > +
> > > > > +/**
> > > > > + * nfsd4_deleg_getattr_conflict - Trigger recall if GETATTR causes conflict
> > > > > + * @rqstp: RPC transaction context
> > > > > + * @inode: file to be checked for a conflict
> > > > > + *
> > > > Let's have this comment explain why this is necessary. At the least,
> > > > it needs to cite RFC 8881 Section 18.7.4, which REQUIREs a conflicting
> > > > write delegation to be gone before the server can respond to a
> > > > change/size GETATTR request.
> > > ok, will add the comment.
> > > 
> > > > 
> > > > > + * Returns 0 if there is no conflict; otherwise an nfs_stat
> > > > > + * code is returned.
> > > > > + */
> > > > > +__be32
> > > > > +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
> > > > > +{
> > > > > +	__be32 status;
> > > > > +	int cnt;
> > > > > +	struct file_lock_context *ctx;
> > > > > +	struct file_lock *fl;
> > > > > +	struct nfs4_delegation *dp;
> > > > > +
> > > > > +	ctx = locks_inode_context(inode);
> > > > > +	if (!ctx)
> > > > > +		return 0;
> > > > > +	spin_lock(&ctx->flc_lock);
> > > > > +	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
> > > > > +		if (fl->fl_flags == FL_LAYOUT ||
> > > > > +				fl->fl_lmops != &nfsd_lease_mng_ops)
> > > > > +			continue;
> > > > > +		if (fl->fl_type == F_WRLCK) {
> > > > > +			dp = fl->fl_owner;
> > > > > +			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
> > > > > +				spin_unlock(&ctx->flc_lock);
> > > > > +				return 0;
> > > > > +			}
> > > > > +			spin_unlock(&ctx->flc_lock);
> > > > > +			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> > > > > +			if (status != nfserr_jukebox)
> > > > > +				return status;
> > > > > +			for (cnt = 3; cnt > 0; --cnt) {
> > > > > +				if (!nfsd_wait_for_delegreturn(rqstp, inode))
> > > > > +					continue;
> > > > > +				return 0;
> > > > > +			}
> > > > I'd rather not retry here. Can you can say why a 30ms wait is not
> > > > sufficient for this case?
> > > on my VMs, it takes about 80ms for the the delegation return to complete.
> > I'd rather not tune for tiny VM guests. How long does it take for a
> > native client to handle CB_RECALL and return the delegation? It
> > shouldn't take longer to do so than it would for the other cases the
> > server already handles in under 30ms.
> > 
> > Even 30ms is a long time to hold up an nfsd thread, IMO.
> 
> If the client takes less than 30ms to return the delegation then the
> server will reply to the GETATTR right away, it does not wait for the
> whole 90ms.
> 
> The 90ms is for the worst case scenario where the client/network is slow
> or under load. Even if the server waits for the whole 90ms it's still
> faster to reply to the GETATTR than sending CB_RECALL and wait for
> DELEGRETURN before the server can reply to the GETATTR.

The reason for the short timeout is we can't tie up nfsd threads for
a long time; that can amount to denial of service. I'm not concerned
about a single slow client, but enough clients that don't respond
quickly to CB_RECALL can prevent the server from making forward
progress, even for a short period, and that will be noticeable.

In Linux, generally we optimize for the fastest case, not the slow
cases like this one. Make the fast clients as fast as possible; do
not penalize everyone for the slow cases.

So, please make this function call nfsd_wait_for_delegreturn() only
once, and leave NFSD_DELEGRETURN_TIMEOUT at 30ms.


> > > > > +			return status;
> > > > > +		}
> > > > > +		break;
> > > > > +	}
> > > > > +	spin_unlock(&ctx->flc_lock);
> > > > > +	return 0;
> > > > > +}
> > > > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > > > index b83954fc57e3..4590b893dbc8 100644
> > > > > --- a/fs/nfsd/nfs4xdr.c
> > > > > +++ b/fs/nfsd/nfs4xdr.c
> > > > > @@ -2970,6 +2970,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
> > > > >    		if (status)
> > > > >    			goto out;
> > > > >    	}
> > > > > +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> > > > > +		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
> > > > > +		if (status)
> > > > > +			goto out;
> > > > > +	}
> > > > >    	err = vfs_getattr(&path, &stat,
> > > > >    			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
> > > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > > index d49d3060ed4f..cbddcf484dba 100644
> > > > > --- a/fs/nfsd/state.h
> > > > > +++ b/fs/nfsd/state.h
> > > > > @@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
> > > > >    	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
> > > > >    	return clp->cl_state == NFSD4_EXPIRABLE;
> > > > >    }
> > > > > +
> > > > > +extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
> > > > > +				struct inode *inode);
> > > > >    #endif   /* NFSD4_STATE_H */
> > > > > -- 
> > > > > 2.9.5
> > > > > 
