Return-Path: <linux-fsdevel+bounces-1603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026307DC3FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 02:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9720CB20E71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 01:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF333EC0;
	Tue, 31 Oct 2023 01:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="H0vgMiIF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA25A36D
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 01:54:02 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0168F10D
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 18:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zVvFwciZVilBv0hBTgskNwDEYc6PyqbRXRxVip7sNNY=; b=H0vgMiIFWtZ5Fo2fXFNqKHz8L+
	8I0MOT9qBCWEfbb4gL3Hf/6Z8RlYStoMCPzbE1vq/mptExu7G2+bC5FYIHJH66m1/ob4NgXZD+7xq
	ZBmn2MV2Et283qruM8ROGPxxCYuAwCS156eXgE1NAKI0BoMoRPVUZ1uuG6Os7cqY5P0PIE8z9fXFS
	8p0yvYCHq1V+C/LvzSPi8KeIq12AyuxbBipjdpghC6C46G6b1PH3kWQ+TN71L0+Rqmo+Z02HEQCSq
	GrCA3RZKwwmuvZCtwre035A10XaihSPvNzNeU/4HX5ntABiiL3NhstD+EdJWg/Vntv4m4gOhtl/+g
	fYGFMcjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qxdx1-008FIS-1i;
	Tue, 31 Oct 2023 01:53:51 +0000
Date: Tue, 31 Oct 2023 01:53:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
Message-ID: <20231031015351.GA1957730@ZenIV>
References: <20231030003759.GW800259@ZenIV>
 <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <20231031001848.GX800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031001848.GX800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 31, 2023 at 12:18:48AM +0000, Al Viro wrote:
> On Mon, Oct 30, 2023 at 12:18:28PM -1000, Linus Torvalds wrote:
> > On Mon, 30 Oct 2023 at 11:53, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > After fixing a couple of brainos, it seems to work.
> > 
> > This all makes me unnaturally nervous, probably because it;s overly
> > subtle, and I have lost the context for some of the rules.
> 
> A bit of context: I started to look at the possibility of refcount overflows.
> Writing the current rules for dentry refcounting and lifetime down was the
> obvious first step, and that immediately turned into an awful mess.
> 
> It is overly subtle.  Even more so when you throw the shrink lists into
> the mix - shrink_lock_dentry() got too smart for its own good, and that
> leads to really awful correctness proofs.  The next thing in the series
> is getting rid of the "it had been moved around, so somebody had clearly
> been taking/dropping references and we can just evict it from the
> shrink list and be done with that" crap - the things get much simpler
> if the rules become
> 	* call it under rcu_read_lock, with dentry locked
> 	* if returned true
> 		dentry, parent, inode locked, refcount is zero.
> 	* if returned false
> 		dentry locked, refcount is non-zero.
> It used to be that way, but removal of trylock loops had turned that
> into something much more subtle.  Restoring the old semantics without
> trylocks on the slow path is doable and it makes analysis much simpler.

It's also a perfect match to what we want in dentry_kill(), actually.
And looking into that has caught another place too subtle for its own
good:
        if (!IS_ROOT(dentry)) {
                parent = dentry->d_parent;
                if (unlikely(!spin_trylock(&parent->d_lock))) {
                        parent = __lock_parent(dentry);
                        if (likely(inode || !dentry->d_inode))
                                goto got_locks;
                        /* negative that became positive */
                        if (parent)
                                spin_unlock(&parent->d_lock);
                        inode = dentry->d_inode;
                        goto slow_positive;
                }
        }
        __dentry_kill(dentry);
        return parent;

slow_positive:
        spin_unlock(&dentry->d_lock);
        spin_lock(&inode->i_lock);
        spin_lock(&dentry->d_lock);
        parent = lock_parent(dentry);
got_locks:

That code (in dentry_kill()) relies upon the assumption that
positive dentry couldn't have become negative under us while
__lock_parent() had it unlocked.  Which is only true because
we have a positive refcount here.

IOW, the patch is broken as posted upthread.  It's really
not hard to fix, fortunately, and what we end up in dentry_kill()
looks a lot better that way -

static struct dentry *dentry_kill(struct dentry *dentry)
        __releases(dentry->d_lock) __releases(rcu)
{
        struct dentry *parent = NULL;
	if (likely(shrink_lock_dentry(dentry))) {
		if (!IS_ROOT(dentry))
			parent = dentry->d_parent;
		rcu_read_unlock();
		__dentry_kill(dentry);
	} else {
		rcu_read_unlock();
		spin_unlock(&dentry->d_lock);
	}
	return parent;
}

Carving that series up will be interesting, though...

