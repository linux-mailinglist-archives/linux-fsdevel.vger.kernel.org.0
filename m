Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4BB70B33B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 04:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjEVCbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 22:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjEVCbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 22:31:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7710CD2;
        Sun, 21 May 2023 19:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C8EE60EF4;
        Mon, 22 May 2023 02:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C86C433D2;
        Mon, 22 May 2023 02:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684722663;
        bh=Pr+PNDJPQJhrn1uDvFCY9xKw4nL2zASGfsfXfglBhQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UAaai/hiCie7MXZ8OtqhS6L6cuC6C0wa9VXN2aRXcpdR5wKbYfdvLx/MIY6+z2Ki2
         b7lzpneCCnpzjxSeh4K0ivz/tvjhpPHrdTRBDCrqF7bsilEfvImLKZRX8gu2TTKDgt
         2TTOhXlSd4ENIJNiH9idmhyPeRU5dZDpxZ4r7Hfgtwjqca+JzT6UDTOnqvTyTda6u8
         Sbpp4CUEPqgx9iFsBcL0QjBCTE4lkKE/WZWC8XGPU0PY2RU0Y+BpI3Awu1BhHtWZc6
         0sGYGOdx+PVlNEOwTuhgE1rxRxLOx6GwwqivoK3j9ZhzwDQG6jD+f2tgOqksOAC94N
         0F0YWncRKrOog==
Date:   Sun, 21 May 2023 22:31:00 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] NFSD: handle GETATTR conflict with write
 delegation
Message-ID: <ZGrT5G+H9HJYJQKn@manet.1015granger.net>
References: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
 <1684618595-4178-4-git-send-email-dai.ngo@oracle.com>
 <d3ae1575dcdc44d1822a5b6a4ffd09b12c600374.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3ae1575dcdc44d1822a5b6a4ffd09b12c600374.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 21, 2023 at 07:08:43PM -0400, Jeff Layton wrote:
> On Sat, 2023-05-20 at 14:36 -0700, Dai Ngo wrote:
> > If the GETATTR request on a file that has write delegation in effect
> > and the request attributes include the change info and size attribute
> > then the write delegation is recalled and NFS4ERR_DELAY is returned
> > for the GETATTR.
> > 
> > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > ---
> >  fs/nfsd/nfs4xdr.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 76db2fe29624..e069b970f136 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -2920,6 +2920,46 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
> >  	return nfserr_resource;
> >  }
> >  
> > +static struct file_lock *
> > +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
> > +{
> > +	struct file_lock_context *ctx;
> > +	struct file_lock *fl;
> > +
> > +	ctx = locks_inode_context(inode);
> > +	if (!ctx)
> > +		return NULL;
> > +	spin_lock(&ctx->flc_lock);
> > +	if (!list_empty(&ctx->flc_lease)) {
> > +		fl = list_first_entry(&ctx->flc_lease,
> > +					struct file_lock, fl_list);
> > +		if (fl->fl_type == F_WRLCK) {
> > +			spin_unlock(&ctx->flc_lock);
> > +			return fl;
> > +		}
> > +	}
> > +	spin_unlock(&ctx->flc_lock);
> > +	return NULL;
> > +}
> > +
> > +static __be32
> > +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode)
> > +{
> > +	__be32 status;
> > +	struct file_lock *fl;
> > +	struct nfs4_delegation *dp;
> > +
> > +	fl = nfs4_wrdeleg_filelock(rqstp, inode);
> > +	if (!fl)
> > +		return 0;
> > +	dp = fl->fl_owner;
> > +	if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker))
> > +		return 0;
> > +	refcount_inc(&dp->dl_stid.sc_count);
> 
> Another question: Why are you taking a reference here at all? AFAICT,
> you don't even look at the delegation again after that point, so it's
> not clear to me who's responsible for putting that reference.

I had the same thought, but I assumed I was missing something.


> > +	status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> > +	return status;
> > +}
> > +
> >  /*
> >   * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
> >   * ourselves.
> > @@ -2966,6 +3006,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
> >  		if (status)
> >  			goto out;
> >  	}
> > +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> > +		status = nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry));
> > +		if (status)
> > +			goto out;
> > +	}
> >  
> >  	err = vfs_getattr(&path, &stat,
> >  			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
