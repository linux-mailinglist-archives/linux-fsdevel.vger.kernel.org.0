Return-Path: <linux-fsdevel+bounces-3502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE547F55D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 02:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541702816AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 01:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED20E17C4;
	Thu, 23 Nov 2023 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="to4eAhiT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AA8C1;
	Wed, 22 Nov 2023 17:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/mZMOzxCPM/ZibIQSk7rG0+sywHsfsDjvGaZysxq5uU=; b=to4eAhiTPVblR/t8ZNnrZz/2q/
	UszqFZ4wwMC9625WO4oKhBXgmrjEcb5VkbS+vbkBfTy3Ky+UrGGgpKjIMOs2YQ5SqJ8tnxT9Tdh6o
	dAq+luwZ5QaxLd3Wzp14Tr0L/TuBIJf6l1LQYxYtaXFXbOQxSnyG4lQVvtmCK1WYu/ZLeyUG9/AE5
	BvVTh6M1SURTHp26Ns+n6bDBwjavRaHIlaDjZVfhp2TlbjlCRbAv/g8tZQomC/EY9aq0jM+QH/eO3
	3drUHhnp/vaHXH+mLAfPd3ddS0m9k8iXIoa9wWegwnMylSKosBJfM8cLMcj0BqwJKFzRttFry6zXE
	0BuGhHNw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5yQG-001rSd-0s;
	Thu, 23 Nov 2023 01:22:28 +0000
Date: Thu, 23 Nov 2023 01:22:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Gabriel Krisman Bertazi <krisman@suse.de>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231123012228.GL38156@ZenIV>
References: <20230816050803.15660-1-krisman@suse.de>
 <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV>
 <20231122211901.GJ38156@ZenIV>
 <20231123011208.GK38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123011208.GK38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 23, 2023 at 01:12:08AM +0000, Al Viro wrote:
> On Wed, Nov 22, 2023 at 09:19:01PM +0000, Al Viro wrote:
> > On Tue, Nov 21, 2023 at 02:27:34AM +0000, Al Viro wrote:
> > 
> > > I will review that series; my impression from the previous iterations
> > > had been fairly unpleasant, TBH, but I hadn't rechecked since April
> > > or so.
> > 
> > The serious gap, AFAICS, is the interplay with open-by-fhandle.
> > It's not unfixable, but we need to figure out what to do when
> > lookup runs into a disconnected directory alias.  d_splice_alias()
> > will move it in place, all right, but any state ->lookup() has
> > hung off the dentry that had been passed to it will be lost.
> > 
> > And I seriously suspect that we want to combine that state
> > propagation with d_splice_alias() (or its variant to be used in
> > such cases), rather than fixing the things up afterwards.
> > 
> > In particular, propagating ->d_op is really not trivial at that
> > point; it is safe to do to ->lookup() argument prior to d_splice_alias()
> > (even though that's too subtle and brittle, IMO), but after
> > d_splice_alias() has succeeded, the damn thing is live and can
> > be hit by hash lookups, revalidate, etc.
> > 
> > The only things that can't happen to it are ->d_delete(), ->d_prune(),
> > ->d_iput() and ->d_init().  Everything else is fair game.
> > 
> > And then there's an interesting question about the interplay with
> > reparenting.  It's OK to return an error rather than reparent,
> > but we need some way to tell if we need to do so.
> 
> Hmm... int (*d_transfer)(struct dentry *alias, struct dentry *new)?
> Called if d_splice_alias() picks that sucker, under rename_lock,
> before the call of __d_move().  Can check IS_ROOT(alias) (due to
> rename_lock), so can tell attaching from reparenting, returning
> an error - failed d_splice_alias().
> 
> Perhaps would be even better inside __d_move(), once all ->d_lock
> are taken...  Turn the current bool exchange in there into honest
> enum (exchange/move/splice) and call ->d_transfer() on splice.
> In case of failure it's still not too late to back out - __d_move()
> would return an int, ignored in d_move() and d_exchange() and
> treated as "fail in unlikely case it's non-zero" in d_splice_alias()
> and __d_unalias()...
> 
> Comments?  Note that e.g.
>         res = d_splice_alias(inode, dentry);
>         if (!IS_ERR(fid)) {
>                 if (!res)
>                         v9fs_fid_add(dentry, &fid);
>                 else if (!IS_ERR(res))
>                         v9fs_fid_add(res, &fid);
>                 else
>                         p9_fid_put(fid);
>         }
> 
> in 9p ->lookup() would turn into
> 
> 	v9fs_fid_add(dentry, &fid);
>         return d_splice_alias(inode, dentry);
> 
> with ->d_transfer(alias, new) being simply
> 
> 	struct hlist_node *p = new->d_fsdata;
> 	hlist_del_init(p);
> 	__add_fid(alias, hlist_entry(p, struct p9_fid, dlist));
> 	return 0;
> 
> assuming the call from __d_move()...

Incidentally, 9p and this one would not be the only places that could use it -
affs - alias->d_fsdata = new->d_fsdata
afs - ditto
ocfs2 - smells like another possible benefitiary (attaching locks, etc.
would be saner if done before d_splice_alias(), with ->d_transfer()
moving the lock to the alias)...

