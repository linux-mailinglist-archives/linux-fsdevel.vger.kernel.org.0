Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9590B46D8A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 17:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhLHQnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 11:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbhLHQnJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:43:09 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE6C061746;
        Wed,  8 Dec 2021 08:39:37 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6132C6214; Wed,  8 Dec 2021 11:39:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6132C6214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638981577;
        bh=Q6vFzrWeE9t9ubeT9gGU4ImXIj+9fjWbNpeuIbsfxAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5bUP7LPhcYRWgzH5r8y9uyqgolrqMpiZoem/rPjBfEGRZ0asORgX4g+9mUG5YT/q
         +ZGhf9vJiV474GAFte4B41urcLm6xSNnjzOgDut+/GyUkQiBJW4GjEAao7AOhQwBMA
         GQHUnuZEOLOYiCf4U1XqYwbb3zXwRKtQtlmA31yI=
Date:   Wed, 8 Dec 2021 11:39:37 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211208163937.GA29555@fieldses.org>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
 <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
 <f6d65309-6679-602a-19b8-414ce29c691a@oracle.com>
 <ba637e0c64b6a2b53c8b5bf197ce02d239cdc0d2.camel@hammerspace.com>
 <605c2aef-3140-6e1a-4953-fd318dbcc277@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <605c2aef-3140-6e1a-4953-fd318dbcc277@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 08:25:28AM -0800, dai.ngo@oracle.com wrote:
> 
> On 12/8/21 8:16 AM, Trond Myklebust wrote:
> >On Wed, 2021-12-08 at 07:54 -0800, dai.ngo@oracle.com wrote:
> >>On 12/6/21 11:55 AM, Chuck Lever III wrote:
> >>
> >>>>+
> >>>>+/*
> >>>>+ * Function to check if the nfserr_share_denied error for 'fp'
> >>>>resulted
> >>>>+ * from conflict with courtesy clients then release their state to
> >>>>resolve
> >>>>+ * the conflict.
> >>>>+ *
> >>>>+ * Function returns:
> >>>>+ *      0 -  no conflict with courtesy clients
> >>>>+ *     >0 -  conflict with courtesy clients resolved, try
> >>>>access/deny check again
> >>>>+ *     -1 -  conflict with courtesy clients being resolved in
> >>>>background
> >>>>+ *            return nfserr_jukebox to NFS client
> >>>>+ */
> >>>>+static int
> >>>>+nfs4_destroy_clnts_with_sresv_conflict(struct svc_rqst *rqstp,
> >>>>+                       struct nfs4_file *fp, struct
> >>>>nfs4_ol_stateid *stp,
> >>>>+                       u32 access, bool share_access)
> >>>>+{
> >>>>+       int cnt = 0;
> >>>>+       int async_cnt = 0;
> >>>>+       bool no_retry = false;
> >>>>+       struct nfs4_client *cl;
> >>>>+       struct list_head *pos, *next, reaplist;
> >>>>+       struct nfsd_net *nn = net_generic(SVC_NET(rqstp),
> >>>>nfsd_net_id);
> >>>>+
> >>>>+       INIT_LIST_HEAD(&reaplist);
> >>>>+       spin_lock(&nn->client_lock);
> >>>>+       list_for_each_safe(pos, next, &nn->client_lru) {
> >>>>+               cl = list_entry(pos, struct nfs4_client, cl_lru);
> >>>>+               /*
> >>>>+                * check all nfs4_ol_stateid of this client
> >>>>+                * for conflicts with 'access'mode.
> >>>>+                */
> >>>>+               if (nfs4_check_deny_bmap(cl, fp, stp, access,
> >>>>share_access)) {
> >>>>+                       if (!test_bit(NFSD4_COURTESY_CLIENT, &cl-
> >>>>>cl_flags)) {
> >>>>+                               /* conflict with non-courtesy
> >>>>client */
> >>>>+                               no_retry = true;
> >>>>+                               cnt = 0;
> >>>>+                               goto out;
> >>>>+                       }
> >>>>+                       /*
> >>>>+                        * if too many to resolve synchronously
> >>>>+                        * then do the rest in background
> >>>>+                        */
> >>>>+                       if (cnt > 100) {
> >>>>+                               set_bit(NFSD4_DESTROY_COURTESY_CLIE
> >>>>NT, &cl->cl_flags);
> >>>>+                               async_cnt++;
> >>>>+                               continue;
> >>>>+                       }
> >>>>+                       if (mark_client_expired_locked(cl))
> >>>>+                               continue;
> >>>>+                       cnt++;
> >>>>+                       list_add(&cl->cl_lru, &reaplist);
> >>>>+               }
> >>>>+       }
> >>>Bruce suggested simply returning NFS4ERR_DELAY for all cases.
> >>>That would simplify this quite a bit for what is a rare edge
> >>>case.
> >>If we always do this asynchronously by returning NFS4ERR_DELAY
> >>for all cases then the following pynfs tests need to be modified
> >>to handle the error:
> >>
> >>RENEW3   st_renew.testExpired                                     :
> >>FAILURE
> >>LKU10    st_locku.testTimedoutUnlock                              :
> >>FAILURE
> >>CLOSE9   st_close.testTimedoutClose2                              :
> >>FAILURE
> >>
> >>and any new tests that opens file have to be prepared to handle
> >>NFS4ERR_DELAY due to the lack of destroy_clientid in 4.0.
> >>
> >>Do we still want to take this approach?
> >NFS4ERR_DELAY is a valid error for both CLOSE and LOCKU (see RFC7530
> >section 13.2 https://urldefense.com/v3/__https://datatracker.ietf.org/doc/html/rfc7530*section-13.2__;Iw!!ACWV5N9M2RV99hQ!f8vZHAJophxXdSSJvnxDCSBSRpWFxEOZBo2ZLvjPzXLVrvMYR8RKcc0_Jvjhng$
> >) so if pynfs complains, then it needs fixing regardless.
> >
> >RENEW, on the other hand, cannot return NFS4ERR_DELAY, but why would it
> >need to? Either the lease is still valid, or else someone is already
> >trying to tear it down due to an expiration event. I don't see why
> >courtesy locks need to add any further complexity to that test.
> 
> RENEW fails in the 2nd open:
> 
>     c.create_confirm(t.word(), access=OPEN4_SHARE_ACCESS_BOTH,
>                      deny=OPEN4_SHARE_DENY_BOTH)     <<======   DENY_BOTH
>     sleeptime = c.getLeaseTime() * 2
>     env.sleep(sleeptime)
>     c2 = env.c2
>     c2.init_connection()
>     c2.open_confirm(t.word(), access=OPEN4_SHARE_ACCESS_READ,    <<=== needs to handle NFS4ERR_DELAY
>                     deny=OPEN4_SHARE_DENY_NONE)
> 
> CLOSE and LOCKU also fail in the OPEN, similar to the RENEW test.
> Any new pynfs 4.0 test that does open might get NFS4ERR_DELAY.

So it's a RENEW test, not the RENEW operation.

A general-purpose client always has to be prepared for DELAY on OPEN.
But pynfs isn't a general-purpose client, and it assumes that it's the
only one touching the files and directories it creates.

Within pynfs we've got a problem that the tests don't necessarily clean
up after themselves completely, so in theory a test could interfere with
later results.

But each test uses its own files--e.g. in the fragment above note that
the file it's testing gets the name t.word(), which is by design unique
to that test.  So it shouldn't be hitting any conflicts with state held
by previous tests.  Am I missing something?

--b.
