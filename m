Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EA751550A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 21:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380469AbiD2UCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 16:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378695AbiD2UCu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:02:50 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B49BCB4F;
        Fri, 29 Apr 2022 12:59:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 07D0C7140; Fri, 29 Apr 2022 15:59:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 07D0C7140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651262370;
        bh=9cERD43aQDAggW+W43xzFi8iScoiz/K0W/yWtLBaydk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w2V4kpIadmYv7Qqg7SWcOoIGr2gIsGFT7l/R4Rg+b3i61iG0HuAt0oCL1uVqiD0Tq
         O1ttbXQsa9Lpb5g1afnR/9rqxP4qM296OQidBSdtNsPwTHIBupy6U/O6zMeyCZrpXV
         eBV4f/s6LIWGeK+xyvX6Ei2k/ZbeWUR55jbVBH6k=
Date:   Fri, 29 Apr 2022 15:59:30 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v23 1/7] NFSD: add courteous server support for
 thread with only delegation
Message-ID: <20220429195930.GJ7107@fieldses.org>
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
 <1651129595-6904-2-git-send-email-dai.ngo@oracle.com>
 <20220429145543.GD7107@fieldses.org>
 <6ce5af72-52ba-7cf0-8295-7929b9b0b4a8@oracle.com>
 <20220429195510.GH7107@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429195510.GH7107@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 29, 2022 at 03:55:10PM -0400, J. Bruce Fields wrote:
> On Fri, Apr 29, 2022 at 10:21:21AM -0700, dai.ngo@oracle.com wrote:
> > 
> > On 4/29/22 7:55 AM, J. Bruce Fields wrote:
> > >On Thu, Apr 28, 2022 at 12:06:29AM -0700, Dai Ngo wrote:
> > >>+static bool client_has_state_tmp(struct nfs4_client *clp)
> > >Why the "_tmp"?
> > >
> > >>+{
> > >>+	if (!list_empty(&clp->cl_delegations) &&
> > >>+			!client_has_openowners(clp) &&
> > >>+			list_empty(&clp->async_copies))
> > >I would have expected
> > >
> > >	if (!list_empty(&clp->cl_delegations) ||
> > >		client_has_openowners(clp) ||
> > >		!list_empty(&clp->async_copies))
> > 
> > In patch 1, we want to allow *only* clients with non-conflict delegation
> > to be in COURTESY state, not with opens and locks. So for that, we can not
> > use the existing client_has_state (until patch 6), so I just created
> > client_has_state_tmp for it.
> 
> Got it, so, I recommend just moving this logic into
> nfs4_anylock_blockers instead, and replacing the call to
> client_has_state_tmp() with a call to client_has_state().
> 
> The logic of nfs4_anylock_blockers() is then basically "return true if anyone
> might be waiting on this client; and if the client has some class of
> state that we don't handle yet, just assume it might have someone
> waiting on it."

And, yeah, the end result is probably the same, but this would just make
the patches easier to read.

--b.
