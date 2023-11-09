Return-Path: <linux-fsdevel+bounces-2630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481317E72C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3006B1C20A8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 20:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797BD374DE;
	Thu,  9 Nov 2023 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eemcfjIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D5374C9
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 20:28:25 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811C544B7
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 12:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gDGO7SI5vD+ft+UdKkrhX1nBpU1e+pN7XRp4ce3KIW0=; b=eemcfjIsBSzUsQ8FfclXD+ec68
	E+4AXTMeynHhf+38ZPgQy+Qeq3/9TGK7KsY3x+3mFln8AHhAuS/loaCY0oK2fhLzG/tKSvqllbl2t
	Sk29+SAIcT8Q2F4BUac9nF8ZSOY+tSHQf0vJwWEn12C8n92DO8sm5sFZzekblqQdkxWSyuc97FmVg
	ewDmrKNptoVhw7IikNU+nzHve/eWw+ChMj5K44w6fPjOJ5xSczOzgh8GSghyLJ1yNnM5Va9TZcNxw
	/sxDsUiWDY+6iQqVhwHlPhya7jgWdtTBNhY9r4FcqMVo2DJM2anPrsaJEvY9FhFfKvzXOfIKuiTNe
	M6DV2wog==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r1BdX-00DZiz-01;
	Thu, 09 Nov 2023 20:28:23 +0000
Date: Thu, 9 Nov 2023 20:28:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/22] shrink_dentry_list(): no need to check that dentry
 refcount is marked dead
Message-ID: <20231109202822.GD1957730@ZenIV>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-7-viro@zeniv.linux.org.uk>
 <20231109-hundstage-barmherzigen-7e97704fede6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109-hundstage-barmherzigen-7e97704fede6@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 09, 2023 at 02:53:04PM +0100, Christian Brauner wrote:
> On Thu, Nov 09, 2023 at 06:20:41AM +0000, Al Viro wrote:
> > ... we won't see DCACHE_MAY_FREE on anything that is *not* dead
> > and checking d_flags is just as cheap as checking refcount.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> 
> Could also be a WARN_ON_ONCE() on d_lockref.count > 0 if DCACHE_MAY_FREE
> is set but probably doesn't matter,

>= 0, actually, but... TBH, in longer run I would rather represent the
empty husk state (instance just waiting for shrink_dentry_list() to remove
it from its list and free the sucker) not by a bit in ->d_flags, but
by a specific negative value in ->d_lockref.count.

After this series we have the following picture: all real instances come
from __alloc_dentry().  Possible states after that
  Busy <-> Retained -> Dying -> Freeing
                         |        ^
			 V        |
			 Husk ----/

Busy and Retained are live dentries, with positive and zero refcount
resp.; that's the pure refcounting land.  Eventually we get to
succesful lock_for_kill(), which leads to call of __dentry_kill().
That's where the state becomes Dying.  On the way out of __dentry_kill()
(after ->d_prune()/->d_iput()/->d_release()) we either switch to Freeing
(only RCU references remain, actual memory object freed by the end of it)
or Husk (the only non-RCU reference is that of a shrink list it's on).
Husk, in turn, switches to Freeing as soon as shrink_dentry_list() gets
around to it and takes it out of its shrink list.  If shrink_dentry_list()
picks an instance in Dying state, it quietly removes it from the shrink
list and leaves it for __dentry_kill() to deal with.

All transitions are under ->d_lock.  ->d_lockref.count for those is
positive in Busy, zero in Retained and -128 in Dying, Husk and Freeing.
Husk is distinguished by having DCACHE_MAY_FREE set.  Freeing has no
visible difference from Dying.

All refcount changes are under ->d_lock.  None of them should _ever_
change the negative values.  If the last part is easy to verify (right
now it's up to "no refcount overflows, all callers of dget_dlock() are
guaranteed to be dealing with Busy or Retained instances"), it might
make sense to use 3 specific negative values for Dying/Husk/Freeing.
What's more, it might make sense to deal with overflows by adding a
separate unsigned long __d_large_count_dont_you_ever_touch_that_directly;
and have the overflow switch to the 4th special negative number indicating
that real counter sits in there.

I'm not 100% convinced that this is the right way to handle that mess,
but it's an approach I'm at least keeping in mind.  Anyway, we need to
get the damn thing documented and understandable before dealing with
overflows becomes even remotely possible.  As it is, it's way too
subtle and reasoning about correctness is too convoluted and brittle.

PS: "documented" includes explicit description of states, their
representations and transitions between them, as well as the objects
associated with the instance in each of those, what references
are allowed in each state, etc.  And the things like in-lookup,
cursor, etc. - live dentries have sub-states as well...

