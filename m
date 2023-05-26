Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583BD712DBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 21:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbjEZTkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 15:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjEZTkp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 15:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50258A3;
        Fri, 26 May 2023 12:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C18DD63B17;
        Fri, 26 May 2023 19:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D85C433D2;
        Fri, 26 May 2023 19:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685130043;
        bh=Tpxal+N8CC354/mDF2HZETCDUq8ami/8DpxVrdHQPLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i66zxQxKc1ctGTGNYL0sUK8lM07rDzkLu4HlM6CHyanq/01uWI4HuUNJMzDFW9sjP
         ZlulSL7JyhHhFve75IXj9QJZpw2Fvn/n5+ssvfaIMk9m+qRbkqouN9Kmqd6rqeJEhD
         N86rVgHLWj7y5p9WH9nCUR6bjnvYsC7ySzVvnZOYa8+C4QU019cZ1fs21POxig4EPM
         wK3GWMm9Lu7/5zHYiX7Bis4GoprNEDF63hHixIDfhRc+lXOHI6q+lk62jWJ7ULauzK
         p1sLRgnfElqxGUI7RrMs5oxSJsBrynW5/FcVN0rm3XcrhiwBdQW9nSlJgbpnRUEZGO
         8M7e92ZOgsXNg==
Date:   Fri, 26 May 2023 15:40:40 -0400
From:   Chuck Lever <cel@kernel.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] NFSD: handle GETATTR conflict with write delegation
Message-ID: <ZHELONbYnZe0wOzh@manet.1015granger.net>
References: <1685122722-18287-1-git-send-email-dai.ngo@oracle.com>
 <1685122722-18287-2-git-send-email-dai.ngo@oracle.com>
 <ZHD8lDQADV6wUO4V@manet.1015granger.net>
 <85bc3a7b-7db0-1d83-44d9-c4d4c9640a37@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85bc3a7b-7db0-1d83-44d9-c4d4c9640a37@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 12:34:16PM -0700, dai.ngo@oracle.com wrote:
> 
> On 5/26/23 11:38 AM, Chuck Lever wrote:
> > On Fri, May 26, 2023 at 10:38:41AM -0700, Dai Ngo wrote:
> > > If the GETATTR request on a file that has write delegation in effect
> > > and the request attributes include the change info and size attribute
> > > then the write delegation is recalled. The server waits a maximum of
> > > 90ms for the delegation to be returned before replying NFS4ERR_DELAY
> > > for the GETATTR.
> > > 
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   fs/nfsd/nfs4state.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >   fs/nfsd/nfs4xdr.c   |  5 +++++
> > >   fs/nfsd/state.h     |  3 +++
> > >   3 files changed, 56 insertions(+)
> > > 
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index b90b74a5e66e..9f551dbf50d6 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -8353,3 +8353,51 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
> > >   {
> > >   	get_stateid(cstate, &u->write.wr_stateid);
> > >   }
> > > +
> > > +/**
> > > + * nfsd4_deleg_getattr_conflict - Trigger recall if GETATTR causes conflict
> > > + * @rqstp: RPC transaction context
> > > + * @inode: file to be checked for a conflict
> > > + *
> > Let's have this comment explain why this is necessary. At the least,
> > it needs to cite RFC 8881 Section 18.7.4, which REQUIREs a conflicting
> > write delegation to be gone before the server can respond to a
> > change/size GETATTR request.
> 
> ok, will add the comment.
> 
> > 
> > 
> > > + * Returns 0 if there is no conflict; otherwise an nfs_stat
> > > + * code is returned.
> > > + */
> > > +__be32
> > > +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
> > > +{
> > > +	__be32 status;
> > > +	int cnt;
> > > +	struct file_lock_context *ctx;
> > > +	struct file_lock *fl;
> > > +	struct nfs4_delegation *dp;
> > > +
> > > +	ctx = locks_inode_context(inode);
> > > +	if (!ctx)
> > > +		return 0;
> > > +	spin_lock(&ctx->flc_lock);
> > > +	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
> > > +		if (fl->fl_flags == FL_LAYOUT ||
> > > +				fl->fl_lmops != &nfsd_lease_mng_ops)
> > > +			continue;
> > > +		if (fl->fl_type == F_WRLCK) {
> > > +			dp = fl->fl_owner;
> > > +			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
> > > +				spin_unlock(&ctx->flc_lock);
> > > +				return 0;
> > > +			}
> > > +			spin_unlock(&ctx->flc_lock);
> > > +			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> > > +			if (status != nfserr_jukebox)
> > > +				return status;
> > > +			for (cnt = 3; cnt > 0; --cnt) {
> > > +				if (!nfsd_wait_for_delegreturn(rqstp, inode))
> > > +					continue;
> > > +				return 0;
> > > +			}
> > I'd rather not retry here. Can you can say why a 30ms wait is not
> > sufficient for this case?
> 
> on my VMs, it takes about 80ms for the the delegation return to complete.

I'd rather not tune for tiny VM guests. How long does it take for a
native client to handle CB_RECALL and return the delegation? It
shouldn't take longer to do so than it would for the other cases the
server already handles in under 30ms.

Even 30ms is a long time to hold up an nfsd thread, IMO.


> > > +			return status;
> > > +		}
> > > +		break;
> > > +	}
> > > +	spin_unlock(&ctx->flc_lock);
> > > +	return 0;
> > > +}
> > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > index b83954fc57e3..4590b893dbc8 100644
> > > --- a/fs/nfsd/nfs4xdr.c
> > > +++ b/fs/nfsd/nfs4xdr.c
> > > @@ -2970,6 +2970,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
> > >   		if (status)
> > >   			goto out;
> > >   	}
> > > +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> > > +		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
> > > +		if (status)
> > > +			goto out;
> > > +	}
> > >   	err = vfs_getattr(&path, &stat,
> > >   			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
> > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > index d49d3060ed4f..cbddcf484dba 100644
> > > --- a/fs/nfsd/state.h
> > > +++ b/fs/nfsd/state.h
> > > @@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
> > >   	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
> > >   	return clp->cl_state == NFSD4_EXPIRABLE;
> > >   }
> > > +
> > > +extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
> > > +				struct inode *inode);
> > >   #endif   /* NFSD4_STATE_H */
> > > -- 
> > > 2.9.5
> > > 
