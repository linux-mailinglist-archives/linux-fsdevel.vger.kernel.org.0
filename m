Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4E4D9E64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 16:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiCOPOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 11:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiCOPOf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:14:35 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B390E25C76;
        Tue, 15 Mar 2022 08:13:23 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4C8B6BCE; Tue, 15 Mar 2022 11:13:23 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4C8B6BCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1647357203;
        bh=kJ52u48wi08KaSGC/VruwvxHTnck6Q3QOYOZyof+rPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g5VVpWgUiGwEuAaBQ159n/tEELYGmcR8vXEK0i5frARCMCMSMUYx57529CVfRlX6i
         cfgSSB/7OW5KWVEnW0QQczhoo+jhkw8FR0Ami+QwAfsZvUC5pJ7kyEDtMMk6zB8F4f
         KhwyGHSlJPc6THjY1PoCtuuHAM2hoAjp02rXNgYg=
Date:   Tue, 15 Mar 2022 11:13:23 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v16 04/11] NFSD: Update nfsd_breaker_owns_lease() to
 handle courtesy clients
Message-ID: <20220315151323.GB19168@fieldses.org>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
 <1647051215-2873-5-git-send-email-dai.ngo@oracle.com>
 <EEB335C0-818A-4510-AA51-547CB9F57DF4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EEB335C0-818A-4510-AA51-547CB9F57DF4@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 13, 2022 at 04:04:21PM +0000, Chuck Lever III wrote:
> 
> 
> > On Mar 11, 2022, at 9:13 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > 
> > Update nfsd_breaker_owns_lease() to handle delegation conflict
> > with courtesy clients. If conflict was caused by courtesy client
> > then discard the courtesy client by setting CLIENT_EXPIRED and
> > return conflict resolved. Client with CLIENT_EXPIRED is expired
> > by the laundromat.
> > 
> > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > ---
> > fs/nfsd/nfs4state.c | 26 ++++++++++++++++++++++++++
> > 1 file changed, 26 insertions(+)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 583ac807e98d..2beb0972de88 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4713,6 +4713,28 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> > 	return ret;
> > }
> > 
> > +static bool
> > +nfs4_check_and_expire_courtesy_client(struct nfs4_client *clp)
> > +{
> > +	/*
> > +	 * need to sync with courtesy client trying to reconnect using
> > +	 * the cl_cs_lock, nn->client_lock can not be used since this
> > +	 * function is called with the fl_lck held.
> > +	 */
> > +	spin_lock(&clp->cl_cs_lock);
> > +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
> > +		spin_unlock(&clp->cl_cs_lock);
> > +		return true;
> > +	}
> > +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> > +		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
> > +		spin_unlock(&clp->cl_cs_lock);
> > +		return true;
> > +	}
> > +	spin_unlock(&clp->cl_cs_lock);

Same comment as on the previous patch.  ALso, this is the second time
we've used this logic, please define a

	static bool expire_client_if_courtesy(struct nfs4_client *clp)

and call it from both places.

> > +	return false;
> > +}
> > +
> > /**
> >  * nfsd_breaker_owns_lease - Check if lease conflict was resolved
> >  * @fl: Lock state to check
> > @@ -4727,6 +4749,10 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
> > 	struct svc_rqst *rqst;
> > 	struct nfs4_client *clp;
> > 
> > +	clp = dl->dl_stid.sc_client;
> > +	if (nfs4_check_and_expire_courtesy_client(clp))
> 
> Since you'll need to fix the kernel robot issue in 1/11, when you
> repost, can you also just pass dl->dl_stid.sc_client directly to
> nfs4_check_and_expire_courtesy_client() here?

Agreed.

This client is quite different from the one we look up from the task a
little later, and I'd just rather not have both represented by the same
variable.

--b.
