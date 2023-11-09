Return-Path: <linux-fsdevel+bounces-2619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112E87E714F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 19:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62A6B20E8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38147347C9;
	Thu,  9 Nov 2023 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rZdWSURd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A61E51E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 18:20:53 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B691FF6
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 10:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+1XudUvqm/WIWBS4EvGNVAwXp3WObNE1Fgj0Rzze6ic=; b=rZdWSURdB2Kgt2FSshUSi7pFz/
	HV1Rg2oVQfiLVsewH/3Dx4+E9LVxBjzZz8eS0zCnaeiPGRevB3eW5XQlr5BkiP9EQ4nS7ppvUWQFs
	nVicA3ub04gInw9xfudAkB3sR08Hq7HyHU+ShAsPQmM/bR26Imz5epKtXAKkvDFXRvn5KTCNZhL7P
	4pYB2hyBS3jSepG4g4Oo/JuXa1v1lagk9PNWANBWVU7KxbH/CzYPtI+vlysxM6tCTiNBW7DF0dmOX
	1KlusVIaM7J8GpA1uSlEduFbOKput1FoBH1Ws1NjxtCQqcsL+hRLLLftPKk1QJPDnNN3T5pI4o20T
	zG/lXmJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r19e6-00DXgq-1v;
	Thu, 09 Nov 2023 18:20:50 +0000
Date: Thu, 9 Nov 2023 18:20:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 17/22] don't try to cut corners in shrink_lock_dentry()
Message-ID: <20231109182050.GA1957730@ZenIV>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-17-viro@zeniv.linux.org.uk>
 <CAHk-=wgapOW-HfnpE-UEfROxMB6ec84bDUDHcKWxyxp1v1o2Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgapOW-HfnpE-UEfROxMB6ec84bDUDHcKWxyxp1v1o2Uw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 09, 2023 at 09:39:09AM -0800, Linus Torvalds wrote:
> On Wed, 8 Nov 2023 at 22:23, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >  static struct dentry *__lock_parent(struct dentry *dentry)
> >  {
> >         struct dentry *parent;
> > -       rcu_read_lock();
> > -       spin_unlock(&dentry->d_lock);
> >  again:
> >         parent = READ_ONCE(dentry->d_parent);
> >         spin_lock(&parent->d_lock);
> 
> Can we rename this while at it?
> 
> That name *used* to make sense, in that the function was entered with
> the dentry lock held, and then it returned with the dentry lock *and*
> the parent lock held.
> 
> But now you've changed the rules so that the dentry lock is *not* held
> at entry, so now the semantics of that function is essentially "lock
> dentry and parent". Which I think means that the name should change to
> reflect that.
> 
> Finally: it does look like most callers actually did hold the dentry
> lock, and that you just moved the
> 
>         spin_unlock(&dentry->d_lock);
> 
> from inside that function to the caller. I don't hate that, but now
> that I look at it, I get the feeling that what we *should* have done
> is
> 
>   static struct dentry *__lock_parent(struct dentry *dentry)
>   {
>         struct dentry *parent = dentry->d_parent;
>         if (try_spin_lock(&parent->d_lock))
>                 return parent;
>         /* Uhhuh - need to get the parent lock first */
>         .. old code goes here ..
> 
> but that won't work with the new world order.

Can't - currently lock_for_kill() uses it in a loop.  Can't have trylocks
in there, or realtime setups will get unhappy.  More to the point, the whole
function is gone by the end of the series.  Along with lock_parent().

The only reason why we needed that thing is that we lock the parent too
early; that's where the last commit in the series is a big win.  There
we remove from the parent's list of children in the very end, when we'd
already made the victim negative (and unlocked it); there ->d_parent
is stable and we can simply lock that, then lock dentry.

We still need a loop in lock_for_kill() to get the inode locked along
with dentry, but that's less convoluted (the ordering between two
->d_lock can change; ->i_lock is always safe to take before ->d_lock).

> So I get the feeling that maybe instead of renaming it for the new
> semantics, maybe the old semantics of "called with the dentry lock
> held" were simply better"

lock_parent() goes aways when d_prune_alias() is switched to shrink list;
after that __lock_parent() is used only in that loop in lock_for_kill()
and only until (22/22) when lock_for_kill() stops touching the parent.
After that it's simply gone.

