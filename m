Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D421E71FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 03:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438357AbgE2BQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 21:16:15 -0400
Received: from fieldses.org ([173.255.197.46]:36924 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438352AbgE2BQN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 21:16:13 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 2C4A51510; Thu, 28 May 2020 21:16:12 -0400 (EDT)
Date:   Thu, 28 May 2020 21:16:12 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: The file_lock_operatoins.lock API seems to be a BAD API.
Message-ID: <20200529011612.GF20602@fieldses.org>
References: <87a71s8u23.fsf@notabene.neil.brown.name>
 <20200528220112.GD20602@fieldses.org>
 <87y2pb7dvc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2pb7dvc.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 11:01:59AM +1000, NeilBrown wrote:
> On Thu, May 28 2020, J. Bruce Fields wrote:
> 
> > On Thu, May 28, 2020 at 04:14:44PM +1000, NeilBrown wrote:
> >> I don't think we should just fix all those bugs in those filesystems.
> >> I think that F_UNLCK should *always* remove the lock/lease.
> >> I imaging this happening by  *always* calling posix_lock_file() (or
> >> similar) in the unlock case - after calling f_op->lock() first if that
> >> is appropriate.
> >> 
> >> What do people think?  It there on obvious reason that is a non-starter?
> >
> > Isn't NFS unlock like close, in that it may be our only chance to return
> > IO errors?
> 
> Is it?  fcntl() isn't documented as returning ENOSPC, EDQUOT or EIO.

I'm probably wrong.  Writes have to be acknowledged before we return
from unlock, but that doesn't mean that's our only chance to return any
errors we find at that point.

> > But I guess you're not saying that unlock can't return errors, just that
> > it should always remove the lock whether it returns 0 or not.
> 
> No I wasn't, but I might.
> One approach that I was considering for making the API more robust was
> to propose a separate "unlock" file_operation.  All unlock requests
> would go through this, and it would have a 'void' return type.
> Would that be sufficient to encourage programmers to handle their own
> errors and not think they can punt?

Maybe I regret bringing up errors....  As you say, the important thing
is making sure the lock's cleaned up, and doing that in common code
sounds like the way to guarantee it.

> But yes - even if unlock returns an error, it should (locally) remove
> any locks - much as 'close()' will always close the fd (if it was
> actually open) even if it reports an error.

That makes sense to me.

--b.
