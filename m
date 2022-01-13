Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B183848DAD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 16:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbiAMPmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 10:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiAMPmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:42:08 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEFAC061574;
        Thu, 13 Jan 2022 07:42:07 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E288D2218; Thu, 13 Jan 2022 10:42:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E288D2218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642088526;
        bh=EcBqbvK2XpoaDRaInywQRIAI9XW0yhjDWJ2HVdQ18do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRQV2tF2tzZbuadf/z4LnNPv2Pxg4NKidA2ye8TwIpQob/wHyzztZOwTp3Yt/O7qq
         04b9geZuGPnDaeRKf8TbMXeAKwE17X8NV399VSfq6wYniXLxr/Zf5BnRQ79IXDya5g
         C4GQGDf0gO2BtPJZ7RVpZNP1NU/nB5dyhWKJ3Osc=
Date:   Thu, 13 Jan 2022 10:42:06 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v9 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220113154206.GA32679@fieldses.org>
References: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
 <1641840653-23059-3-git-send-email-dai.ngo@oracle.com>
 <20220112194054.GD10518@fieldses.org>
 <11e9d7a9-f2f3-47a9-c76f-dc2b9010d303@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11e9d7a9-f2f3-47a9-c76f-dc2b9010d303@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2022 at 12:51:57AM -0800, dai.ngo@oracle.com wrote:
> 
> On 1/12/22 11:40 AM, J. Bruce Fields wrote:
> >On Mon, Jan 10, 2022 at 10:50:53AM -0800, Dai Ngo wrote:
> >>+		}
> >>+		if (!state_expired(&lt, clp->cl_time)) {
> >>+			spin_unlock(&clp->cl_cs_lock);
> >>  			break;
> >>+		}
> >>+		id = 0;
> >>+		spin_lock(&clp->cl_lock);
> >>+		stid = idr_get_next(&clp->cl_stateids, &id);
> >>+		if (stid && !nfs4_anylock_conflict(clp)) {
> >>+			/* client still has states */
> >I'm a little confused by that comment.  I think what you just checked is
> >that the client has some state, *and* nobody is waiting for one of its
> >locks.  For me, that comment just conufses things.
> 
> will remove.
> 
> >
> >>+			spin_unlock(&clp->cl_lock);
> >Is nn->client_lock enough to guarantee that the condition you just
> >checked still holds?  (Honest question, I'm not sure.)
> 
> nfs4_anylock_conflict_locked scans cl_ownerstr_hashtbl which is protected
> by the cl_lock.

That doesn't answer the question.  Which, I confess, was muddled (I
should have said "clp->cl_cs_lock", not "nn->client_lock".)

Let me try it a different way.  You just checked that the client has
some state, and that nobody is waiting for one of its locks.

After you drop the cl_lock, how do you know that both of those things
are still true?

--b.
