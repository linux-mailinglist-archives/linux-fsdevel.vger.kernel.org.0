Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154D750EBC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 00:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiDYWY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 18:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343629AbiDYVv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:51:57 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0993AA52;
        Mon, 25 Apr 2022 14:48:51 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A0993713F; Mon, 25 Apr 2022 17:48:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A0993713F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1650923330;
        bh=ro+3219GobOxdET0HO1NlVXmhgPLHK6Z5o8azRU2pis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWm9Fq0eKINA4Eb4MvH7zGE9J+cCPRB3Yh2MLK5xNXRs2XT0MMZK/OrgFfNn8xKO9
         dpIBvDxTV2fHMZ83TRaAdP1gR7RMZvbxKgJEIU1F2jzQFBVJsH09Ib2gv8eMvk96j9
         McjYefoEpqvx+I2BMVyGWvJWeeKF79bHbyZtzdfE=
Date:   Mon, 25 Apr 2022 17:48:50 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v21 1/7] NFSD: add courteous server support for
 thread with only delegation
Message-ID: <20220425214850.GK24825@fieldses.org>
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
 <1650739455-26096-2-git-send-email-dai.ngo@oracle.com>
 <20220425185121.GE24825@fieldses.org>
 <90f5ec04-deff-38d0-2b6f-8b2f48b72d9d@oracle.com>
 <20220425204006.GI24825@fieldses.org>
 <e2b3dfe6-d7c6-3bb1-eebb-0f8cd97c27e7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2b3dfe6-d7c6-3bb1-eebb-0f8cd97c27e7@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 02:35:27PM -0700, dai.ngo@oracle.com wrote:
> On 4/25/22 1:40 PM, J. Bruce Fields wrote:
> >On Mon, Apr 25, 2022 at 12:42:58PM -0700, dai.ngo@oracle.com wrote:
> >>static inline bool try_to_expire_client(struct nfs4_client *clp)
> >>{
> >>         bool ret;
> >>
> >>         spin_lock(&clp->cl_cs_lock);
> >>         if (clp->cl_state == NFSD4_EXPIRABLE) {
> >>                 spin_unlock(&clp->cl_cs_lock);
> >>                 return false;            <<<====== was true
> >>         }
> >>         ret = NFSD4_COURTESY ==
> >>                 cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
> >>         spin_unlock(&clp->cl_cs_lock);
> >>         return ret;
> >>}
> >So, try_to_expire_client(), as I said, should be just
> >
> >   static bool try_to_expire_client(struct nfs4_client *clp)
> >   {
> >	return COURTESY == cmpxchg(clp->cl_state, COURTESY, EXPIRABLE);
> >   }
> >
> >Except, OK, I did forget that somebody else could have already set
> >EXPIRABLE, and we still want to tell the caller to retry in that case,
> >so, oops, let's make it:
> >
> >	return ACTIVE != cmpxchg(clp->cl_state, COURTESY, EXPIRABLE);
> 
> So functionally this is the same as what i have in the patch, except this
> makes it simpler?

Right.

And my main complaint is still about the code that fails lookups of
EXPIRABLE clients.  We shouldn't need to modify find_in_sessionid_hastbl
or other client lookups.

> Do we need to make any change in try_to_activate_client to work with
> this change in try_to_expire_client?
> 
> >
> >In other words: set EXPIRABLE if and only if the state is COURTESY, and
> >then tell the caller to retry the operation if and only if the state was
> >previously COURTESY or EXPIRABLE.
> >
> >But we shouldn't need the cl_cs_lock,
> 
> The cl_cs_lock is to synchronize between COURTESY client trying to
> reconnect (try_to_activate_client) and another thread is trying to
> resolve a delegation/share/lock conflict (try_to_expire_client).
> So you don't think this is necessary?

Correct, it's not necessary.

The only synchronization is provided by mark_client_expired_locked and
get_client_locked.

We don't need try_to_activate_client.  Just set cl_state to ACTIVE in
get_client_locked.

--b.
