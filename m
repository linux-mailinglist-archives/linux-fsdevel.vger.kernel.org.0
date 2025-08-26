Return-Path: <linux-fsdevel+bounces-59183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D784EB3599E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 11:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86C21B67B79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 09:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431783375AF;
	Tue, 26 Aug 2025 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcxYIypl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DED30F55C;
	Tue, 26 Aug 2025 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202177; cv=none; b=i1z/IH+fhg8NkhkFKoOafNFnSWZgOOUDrdZbS6lB7I1NVw7lJbEd5CFQzbUN2JzPn8cP0oAGa8W/FKv6CBEs9dPO7es3f5RToRuIQBzvR+ndauvlmQXKWctIsCF+rE0SjwNEkVFc60N9cP8RzPaLoK4PMUd61FpsmQVGam0FWaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202177; c=relaxed/simple;
	bh=KGaJkW3lP2CWrkdfdlNMd901qIT4K9GAJ6o2kkTaLaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmqUaw/UjH1YzYOMjS3aGjKvuRm/9p9OgCQQa9/JGA/9bjS8uxRxrDLFCEp/TJjfDao6kmP8IPF3MhUjy04WWLWG7/9e28UfgVF/n7ja0IRtarTV8tsZZrR2XURhPf9hRasPtgC1r2CmZ78tvsMPfmPO9BnjBjUmlsI1GJYE2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcxYIypl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6225DC4CEF1;
	Tue, 26 Aug 2025 09:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756202177;
	bh=KGaJkW3lP2CWrkdfdlNMd901qIT4K9GAJ6o2kkTaLaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DcxYIyplCLql8vhyaK2snbC0wt94mw/fE1fjxaP3rZ8hHCpzsBzZirIWMlf0bVqg0
	 lRIPlqQdj7nfg1gOJdF50R0d/SF9Zls90nJ5IfKbYf0z2s1Gz0IIqeC4sQvExEABYu
	 u+msZ1NMabBw3Tp8+eVCq6svA4Vs6Q1pLBPV+iMp6/XTKxoV4k4Kzf/PfHtoL+C4X/
	 pULvFT/iJqWPfQQBvH+iDMk5CrHqssKYCsuZ8cjnj88R43MMfNXFdBWSzvh4KYKgOI
	 LI42jyTOxUSVaTPJERoPTScaNZkJ2rtrl2h6md7YyYrOfIZ6Z9fK9HJ1K6IPhadK9W
	 +O7KQNDvDACSw==
Date: Tue, 26 Aug 2025 11:56:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 16/50] fs: change evict_inodes to use iput instead of
 evict directly
Message-ID: <20250826-begnadet-vorarbeit-901ad1e2bfa0@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <1198cd4cd35c5875fbf95dc3dca68650bb176bb1.1755806649.git.josef@toxicpanda.com>
 <20250825-entbinden-kehle-2e1f8b67b190@brauner>
 <20250825193502.GB1310133@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825193502.GB1310133@perftesting>

On Mon, Aug 25, 2025 at 03:35:02PM -0400, Josef Bacik wrote:
> On Mon, Aug 25, 2025 at 11:07:55AM +0200, Christian Brauner wrote:
> > On Thu, Aug 21, 2025 at 04:18:27PM -0400, Josef Bacik wrote:
> > > At evict_inodes() time, we no longer have SB_ACTIVE set, so we can
> > > easily go through the normal iput path to clear any inodes. Update
> > 
> > I'm a bit lost why SB_ACTIVE is used here as a justification to call
> > iput(). I think it's because iput_final() would somehow add it back to
> > the LRU if SB_ACTIVE was still set and the filesystem somehow would
> > indicate it wouldn't want to drop the inode.
> > 
> > I'm confused where that would even happen. IOW, which filesystem would
> > indicate "don't drop the inode" even though it's about to vanish. But
> > anyway, that's probably not important because...
> > 
> > > dispose_list() to check how we need to free the inode, and then grab a
> > > full reference to the inode while we're looping through the remaining
> > > inodes, and simply iput them at the end.
> > > 
> > > Since we're just calling iput we don't really care about the i_count on
> > > the inode at the current time.  Remove the i_count checks and just call
> > > iput on every inode we find.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > >  fs/inode.c | 26 +++++++++++---------------
> > >  1 file changed, 11 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index 72981b890ec6..80ad327746a7 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -933,7 +933,7 @@ static void evict(struct inode *inode)
> > >   * Dispose-list gets a local list with local inodes in it, so it doesn't
> > >   * need to worry about list corruption and SMP locks.
> > >   */
> > > -static void dispose_list(struct list_head *head)
> > > +static void dispose_list(struct list_head *head, bool for_lru)
> > >  {
> > >  	while (!list_empty(head)) {
> > >  		struct inode *inode;
> > > @@ -941,8 +941,12 @@ static void dispose_list(struct list_head *head)
> > >  		inode = list_first_entry(head, struct inode, i_lru);
> > >  		list_del_init(&inode->i_lru);
> > >  
> > > -		evict(inode);
> > > -		iobj_put(inode);
> > > +		if (for_lru) {
> > > +			evict(inode);
> > > +			iobj_put(inode);
> > > +		} else {
> > > +			iput(inode);
> > > +		}
> > 
> > ... Afaict, if we end up in dispose_list() we came from one of two
> > locations:
> > 
> > (1) prune_icache_sb()
> >     In which case inode_lru_isolate() will have only returned inodes
> >     that prior to your changes would have inode->i_count zero.
> > 
> > (2) evict_inodes()
> >     Similar story, this only hits inodes with inode->i_count zero.
> > 
> > With your change you're adding an increment from zero for (2) via
> > __iget() so that you always end up with a full refcount, and that is
> > backing your changes to dispose_list() later.
> > 
> > I don't see the same done for (1) though and so your later call to
> > iput() drops the reference below zero? It's accidently benign because
> > iiuc atomic_dec_and_test() will simply tell you that reference count
> > didn't go to zero and so iput() will back off. But still this should be
> > fixed if I'm right.
> 
> Because (1) at this point doesn't have a full reference, it only has an
> i_obj_count reference. The next patch converts this, and removes this bit. I did
> it this way to clearly mark the change in behavior.

Ah, right, I forgot to take the the boolean argument into account.
You're passing that as true in (1). Sure and then sorry about the noise.

> prune_icache_sb() will call dispose_list(&list, true), which will do the
> evict(inode) and iobj_put(inode). This is correct because the inodes on the list
> from prune_icache_sb() will have an i_count == and have I_WILL_FREE set, so it
> will never have it's i_count increased to 1.
> 
> The change here is to change evict_inodes() to simply call iput(), as it calls
> dispose_list(&list, false). We will increase the i_count to 1 from zero via
> __iget(), which at this point in the series is completely correct behavior. Then
> we will call iput() which will drop the i_count back to zero, and then call
> iput_final, and since SB_ACTIVE is not set, it will call evict(inode) and clean
> everything up properly.
> 
> > 
> > The conversion to iput() is introducing a lot of subtlety in the middle
> > of the series. If I'm right then the iput() is a always a nop because in
> > all cases it was an increment from zero. But it isn't really a nop
> > because we still do stuff like call ->drop_inode() again. Maybe it's
> > fine because no filesystem would have issues with this but I wouldn't
> > count on it and also it feels rather unclean to do it this way.
> 
> So I'm definitely introducing another call to ->drop_inode() here, but
> ->drop_inode() has always been a "do we want to keep this inode on the LRU"
> call, calling it again doesn't really change anything.

Right, the first time the inode reference count drops to zero we call
iput_final() and then ->drop_inode() which tells us to put it on the
LRU. And we leave it otherwise in tact. This is the part I forgot.

Once you add it to the LRU you'll have incremented i_obj_count either
when you added it to the cached LRU and moving it from there to the
"actual" LRU or you'll take a new one.

And then dispose_list() for (1) will just need to put the i_obj_count.
Thanks!

> That being said it is a subtle functional change. I put it here specifically
> because it is a functional change. If it bites us in the ass in some unforseen
> way we'll be able to bisect it down to here and then we can all laugh at Josef
> because he missed something.

Yeah, it's good. It's just very confusing because for a brief time we
have to understand two reference counts that are first coupled almost
1:1 and then slowly decoupled which makes this particularly nasty...

> > So, under the assumption, that after the increment from zero you did, we
> > really only have a blatant zombie inode on our hands and we only need to
> > get rid of the i_count we took make that explicit and do:
> > 
> > 	if (for_lru) {
> > 		evict(inode);
> > 		iobj_put(inode);
> > 	} else {
> > 		/* This inode was always incremented from zero.
> > 		 * Get rid of that reference without doing anything else.
> > 		 */
> > 		WARN_ON_ONCE(!atomic_dec_and_test(&inode->i_count));
> > 	}
> 
> We still need the evict() to actually free the inode.  We're just getting there
> via iput_final() now instead of directly calling evict().

Right, thanks!

> 
> > 
> > Btw, for the iobj_put() above, I assume that we're not guaranteed that
> > i_obj_count == 1?
> 
> Right, it's purely dropping the LRU list i_obj_count reference.  Thanks,

Thanks for the comments!

