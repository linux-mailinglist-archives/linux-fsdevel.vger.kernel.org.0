Return-Path: <linux-fsdevel+bounces-2643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28B27E739E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0FC1C209E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D7338DF0;
	Thu,  9 Nov 2023 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pi7piQV6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4904D38DE5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:30:00 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AA63C15
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/U/3500/n3VOeMyAJVP0woVzIwelpXFNdK7EkGCiuos=; b=pi7piQV63KrUhENk868sZCdj25
	2aaL3Wrkel6JkxkAMB5IYvltR7GM3jnElTvBQyusNaePn9rCmbJpeNgP1s6Dw+cEbKlt3R4KS78c+
	8/WZm89j2xaC89Ci6Lo9QCGTHjnYpvD/iRxO/NeJYMgB24npcJe/lhRcSXM+UsFXZsiOz6FTOXtgs
	5i3xLezj9JPUfR6rEq2rKimli4GMr6D7Qrnf55foQDV/z+GX76yUUNuSBbE2wkYlz/EHvoQQZGWrz
	9r1DpagO9dA9+E8SwaIIIwPH22OY7oFQUcbIc7POv4QGk7Ds53m3REMZsYFTRYr9TPvo+XL4MqV4u
	6tXsSZsw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r1Cb7-00DaoB-08;
	Thu, 09 Nov 2023 21:29:57 +0000
Date: Thu, 9 Nov 2023 21:29:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/22] dentry_kill(): don't bother with retain_dentry()
 on slow path
Message-ID: <20231109212957.GG1957730@ZenIV>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-14-viro@zeniv.linux.org.uk>
 <20231109-lager-oberwasser-268dae3e4e02@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109-lager-oberwasser-268dae3e4e02@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 09, 2023 at 04:53:07PM +0100, Christian Brauner wrote:
> On Thu, Nov 09, 2023 at 06:20:48AM +0000, Al Viro wrote:
> > We have already checked it and dentry used to look not worthy
> > of keeping.  The only hard obstacle to evicting dentry is
> > non-zero refcount; everything else is advisory - e.g. memory
> > pressure could evict any dentry found with refcount zero.
> > On the slow path in dentry_kill() we had dropped and regained
> > ->d_lock; we must recheck the refcount, but everything else
> > is not worth bothering with.
> > 
> > Note that filesystem can not count upon ->d_delete() being
> > called for dentry - not even once.  Again, memory pressure
> > (as well as d_prune_aliases(), or attempted rmdir() of ancestor,
> > or...) will not call ->d_delete() at all.
> > 
> > So from the correctness point of view we are fine doing the
> > check only once.  And it makes things simpler down the road.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> 
> Ok, that again relies on earlier patches that ensure that dentry_kill()
> isn't called with refcount == 0 afaiu,

Huh?

There are two reasons to keep dentry alive - positive refcount and
a bunch of heuristics for "it might be nice to keep it around in
hash, even though its refcount is down to zero now".

Breakage on underflows aside, dentry_kill() had always been called with
refcount 1, victim locked and those heuristics saying "no point keeping
it around".  Then it grabs the rest of locks needed for actual killing;
if we are lucky and that gets done just on trylocks, that's it - we
decrement refcount (to 0 - we held ->d_lock all along) and pass the
sucker to __dentry_kill().  RIP.  If we had to drop and regain ->d_lock,
it is possible that somebody took an extra reference and it's no longer
possible to kill the damn thing.  In that case we just decrement the
refcount, drop the locks and that's it - we are done.

So far, so good, but there's an extra twist - in case we had to drop
and regain ->d_lock, dentry_kill() rechecks the "might be nice to
keep it around" heuristics and treats "it might be" same way as it
would deal with finding extra references taken by somebody while
->d_lock had not been held.  That is to say, it does refcount decrement
(to 0 - we'd just checked that it hadn't been increased from 1),
drops the locks and that's it.

The thing is, those heuristics are really "it might be nice to keep" -
there are trivial ways to force eviction of any unlocked dentry with
zero refcount.  So why bother rechecking those?  We have already
checked them just before calling dentry_kill() and got "nah, don't
bother keeping it", after all.  And we would be leaving it in the
state where it could be instantly evicted, heuristics nonwithstanding,
so from correctness standpoint might as well decide not to keep
it and act as if that second call of retain_dentry() returned false.

Previous patches have very little to do with that - the only thing
that affects dentry_kill() is the (now gone) possibility of hitting
an underflow here.  If underflow happened, we were already screwed;
yes, this would've been one of the places where the breakage would
show up, but that's basically "what amusing kinds of behaviour would
that function exhibit on FUBAR data structures".


