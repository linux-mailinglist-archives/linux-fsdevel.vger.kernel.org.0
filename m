Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DDD48CB53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 19:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbiALSxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 13:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241913AbiALSx2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:53:28 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E62BC06173F;
        Wed, 12 Jan 2022 10:53:28 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 905247306; Wed, 12 Jan 2022 13:53:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 905247306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642013607;
        bh=S4P06q/HztrcXqQuR6afTAX+euXXAUsicN336T79Jf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Utf0mgspp8a7heEEYSXF/VRMDNC9XH7o277BkDi+ynWrGSunyv1FsATwxaEqB1sMq
         Z5xDIzYFLoq6IoPogIGiQ2iO31zZPdda8aP1gWVaxmXhKMFiq2Uq3/DZEFwhZyG81c
         woYtyE7h5Vg+Ytjt38NmSZuePyltwmhgqWvKZ0co=
Date:   Wed, 12 Jan 2022 13:53:27 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v9 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220112185327.GA10518@fieldses.org>
References: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
 <1641840653-23059-3-git-send-email-dai.ngo@oracle.com>
 <E70D7FE7-59BA-4200-BF31-B346956C9880@oracle.com>
 <f5ba01ea-33e8-03e9-2cee-8ff7814abceb@oracle.com>
 <D2CF771C-FF71-4356-8567-33427EAC0DA9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2CF771C-FF71-4356-8567-33427EAC0DA9@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 03:49:19PM +0000, Chuck Lever III wrote:
> > On Jan 10, 2022, at 8:03 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > I think this is something you and Bruce have been discussing
> > on whether when we should remove and add the client record from
> > the database when the client transits from active to COURTESY
> > and vice versa. With this patch we now expire the courtesy clients
> > asynchronously in the background so the overhead/delay from
> > removing the record from the database does not have any impact
> > on resolving conflicts.
> 
> As I recall, our idea was to record the client as expired when
> it transitions from active to COURTEOUS so that if the server
> happens to reboot, it doesn't allow a courteous client to
> reclaim locks the server may have already given to another
> active client.
> 
> So I think the server needs to do an nfsdtrack upcall when
> transitioning from active -> COURTEOUS to prevent that edge
> case. That would happen only in the laundromat, right?
> 
> So when a COURTEOUS client comes back to the server, the server
> will need to persistently record the transition from COURTEOUS
> to active.

Yep.  The bad case would be:

	- client A is marked DESTROY_COURTESY, client B is given A's
	  lock.
	- server goes down before laundromat thread removes the
	  DESTROY_COURTESY client.
	- client A's network comes back up.
	- server comes back up and starts grace period.

At this point, both A and B believe they have the lock.  Also both still
have nfsdcltrack records, so the server can't tell which is in the
right.

We can't start granting A's locks to B until we've recorded in stable
storage that A has expired.

What we'd like to do:

	- When a client transitions from active to courteous, it needs
	  to do nfsdcltrack upcall to expire it.
	- We mark client as COURTESY only after that upcall has
	  returned.
	- When the client comes back, we do an nfsdcltrack upcall to
	  mark it as active again.  We don't remove the COURTESY mark
	  until that's returned.

--b.
