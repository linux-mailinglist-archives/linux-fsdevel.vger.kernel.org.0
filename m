Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BBC415515
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 03:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbhIWBT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 21:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238793AbhIWBT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:19:56 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E11C061574;
        Wed, 22 Sep 2021 18:18:25 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 715C07032; Wed, 22 Sep 2021 21:18:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 715C07032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632359904;
        bh=kq+IggbwR7xbOWMrU163CV8szClq4pTT+SlrS13L7/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1gco0OLPEY7uRmwj8/tIlS50me1AYMwkMp18aQM/x1gOn/e9RyGpTtG04Zk4grB8
         ApW03WSFlbc0B8deFUTOQQSx3CrvxyHt2k+DkKBwNCx7PidtifmtWYmXGJYJ8EOhV4
         XQIovmFPdsARu4aUGUj7QaT5dQ0uRbN9mjSaKIJA=
Date:   Wed, 22 Sep 2021 21:18:24 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
Message-ID: <20210923011824.GD22937@fieldses.org>
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210916182212.81608-3-dai.ngo@oracle.com>
 <20210922211444.GC22937@fieldses.org>
 <f38c8587-d5db-d07e-6e28-351221be4a69@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f38c8587-d5db-d07e-6e28-351221be4a69@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 03:16:34PM -0700, dai.ngo@oracle.com wrote:
> 
> On 9/22/21 2:14 PM, J. Bruce Fields wrote:
> >On Thu, Sep 16, 2021 at 02:22:11PM -0400, Dai Ngo wrote:
> >>+/*
> >>+ * If the conflict happens due to a NFSv4 request then check for
> >>+ * courtesy client and set rq_conflict_client so that upper layer
> >>+ * can destroy the conflict client and retry the call.
> >>+ */
> >>+static bool
> >>+nfsd_check_courtesy_client(struct nfs4_delegation *dp)
> >>+{
> >>+	struct svc_rqst *rqst;
> >>+	struct nfs4_client *clp = dp->dl_recall.cb_clp;
> >>+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> >>+	bool ret = false;
> >>+
> >>+	if (!i_am_nfsd()) {
> >>+		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> >>+			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
> >>+			mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> >>+			return true;
> >>+		}
> >>+		return false;
> >>+	}
> >>+	rqst = kthread_data(current);
> >>+	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
> >>+		return false;
> >>+	rqst->rq_conflict_client = NULL;
> >>+
> >>+	spin_lock(&nn->client_lock);
> >>+	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) &&
> >>+				!mark_client_expired_locked(clp)) {
> >>+		rqst->rq_conflict_client = clp;
> >>+		ret = true;
> >>+	}
> >>+	spin_unlock(&nn->client_lock);
> >Check whether this is safe; I think the flc_lock may be taken inside of
> >this lock elsewhere, resulting in a potential deadlock?
> >
> >rqst doesn't need any locking as it's only being used by this thread, so
> >it's the client expiration stuff that's the problem, I guess.
> 
> mark_client_expired_locked needs to acquire cl_lock. I think the lock
> ordering is ok, client_lock -> cl_lock. nfsd4_exchange_id uses this
> lock ordering.

It's flc_lock (see locks.c) that I'm worried about.  I've got a lockdep
warning here, taking a closer look....

nfsd4_release_lockowner takes clp->cl_lock and then fcl_lock.

Here we're taking fcl_lock and then client_lock.

As you say, elsewhere client_lock is taken and then cl_lock.

So that's the loop, I think.

--b.
