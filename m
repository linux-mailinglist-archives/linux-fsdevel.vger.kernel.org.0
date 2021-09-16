Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D6440EB31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 21:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbhIPT5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 15:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbhIPT5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:57:08 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C750C061574;
        Thu, 16 Sep 2021 12:55:48 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 87F47702A; Thu, 16 Sep 2021 15:55:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 87F47702A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1631822146;
        bh=pjFm5gzMzz0KBjJnwmyWUPs1TwQqzMcBQeuF11Yef0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSsZI69fH5SXLqmzj2cFixYGpdME+501U3MqibEpAszxazdRtb2ZIhFRR93aGRLdJ
         bexAERtPs5lqbwPwmFJQHA+iDAgfUyYnXiBEl8WAILDnEMhWRQ5hbRV30DDDCz/cZn
         EDhQkl7KUU/+gfGvND51cgistaMHVsXEj1X7trkQ=
Date:   Thu, 16 Sep 2021 15:55:46 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] nfsd: back channel stuck in
 SEQ4_STATUS_CB_PATH_DOWN
Message-ID: <20210916195546.GA32690@fieldses.org>
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210916182212.81608-4-dai.ngo@oracle.com>
 <8EB546E2-124E-4FB5-B72B-15E0CB66798F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8EB546E2-124E-4FB5-B72B-15E0CB66798F@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 07:00:20PM +0000, Chuck Lever III wrote:
> Bruce, Dai -
> 
> > On Sep 16, 2021, at 2:22 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > 
> > When the back channel enters SEQ4_STATUS_CB_PATH_DOWN state, the client
> > recovers by sending BIND_CONN_TO_SESSION but the server fails to recover
> > the back channel and leaves it as NFSD4_CB_DOWN.
> > 
> > Fix by enhancing nfsd4_bind_conn_to_session to probe the back channel
> > by calling nfsd4_probe_callback.
> > 
> > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> 
> I'm wondering if this one is appropriate to pull into v5.15-rc.

I think so.

Dai, do you have a pynfs test for this case?

--b.

> > ---
> > fs/nfsd/nfs4state.c | 16 +++++++++++++---
> > 1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 54e5317f00f1..63b4d0e6fc29 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -3580,7 +3580,7 @@ static struct nfsd4_conn *__nfsd4_find_conn(struct svc_xprt *xpt, struct nfsd4_s
> > }
> > 
> > static __be32 nfsd4_match_existing_connection(struct svc_rqst *rqst,
> > -				struct nfsd4_session *session, u32 req)
> > +		struct nfsd4_session *session, u32 req, struct nfsd4_conn **conn)
> > {
> > 	struct nfs4_client *clp = session->se_client;
> > 	struct svc_xprt *xpt = rqst->rq_xprt;
> > @@ -3603,6 +3603,8 @@ static __be32 nfsd4_match_existing_connection(struct svc_rqst *rqst,
> > 	else
> > 		status = nfserr_inval;
> > 	spin_unlock(&clp->cl_lock);
> > +	if (status == nfs_ok && conn)
> > +		*conn = c;
> > 	return status;
> > }
> > 
> > @@ -3627,8 +3629,16 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
> > 	status = nfserr_wrong_cred;
> > 	if (!nfsd4_mach_creds_match(session->se_client, rqstp))
> > 		goto out;
> > -	status = nfsd4_match_existing_connection(rqstp, session, bcts->dir);
> > -	if (status == nfs_ok || status == nfserr_inval)
> > +	status = nfsd4_match_existing_connection(rqstp, session,
> > +			bcts->dir, &conn);
> > +	if (status == nfs_ok) {
> > +		if (bcts->dir == NFS4_CDFC4_FORE_OR_BOTH ||
> > +				bcts->dir == NFS4_CDFC4_BACK)
> > +			conn->cn_flags |= NFS4_CDFC4_BACK;
> > +		nfsd4_probe_callback(session->se_client);
> > +		goto out;
> > +	}
> > +	if (status == nfserr_inval)
> > 		goto out;
> > 	status = nfsd4_map_bcts_dir(&bcts->dir);
> > 	if (status)
> > -- 
> > 2.9.5
> > 
> 
> --
> Chuck Lever
> 
> 
