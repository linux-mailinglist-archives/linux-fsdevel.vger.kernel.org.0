Return-Path: <linux-fsdevel+bounces-3501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7907F55C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 02:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A5F1C20C2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 01:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83DE17D8;
	Thu, 23 Nov 2023 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Wxreso/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A6193;
	Wed, 22 Nov 2023 17:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PY9S8RVi0dnKEfdrmFsdECJKTXexMrbF0x58rHr1R88=; b=Wxreso/B/Dh4LiFC6ky64hsoHG
	DKfrqS4iEfOeCiGHQM3PUKYAigdumD8QkqkM/jQrNnbtL9PALDBmElowJuy/vjcngWK/ssk9wCGgQ
	9pha+U/3DXFwYydFhuh4n7vom/JGSpqnpVBwi+vRhCN8hnowSDsERumqVCzFcF7HL6DLpsuRZubIe
	uJoNVzHTqKya2IYBdJncmhtD0Bn+TQOhAMAr00YOEQHEi8wtDoZdFTERTgT8I5sMuO+JlcgvipYjn
	EkSBN+YD++43nTzDFqkcoWXhZ5Q2CL49AFsyyFeDNtwvVfXowGcRIQ0Ki4Id8+pI9hJb3vx5I5gQL
	SNSRS68A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5yGG-001rH6-1H;
	Thu, 23 Nov 2023 01:12:08 +0000
Date: Thu, 23 Nov 2023 01:12:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Gabriel Krisman Bertazi <krisman@suse.de>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231123011208.GK38156@ZenIV>
References: <20230816050803.15660-1-krisman@suse.de>
 <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV>
 <20231122211901.GJ38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122211901.GJ38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 22, 2023 at 09:19:01PM +0000, Al Viro wrote:
> On Tue, Nov 21, 2023 at 02:27:34AM +0000, Al Viro wrote:
> 
> > I will review that series; my impression from the previous iterations
> > had been fairly unpleasant, TBH, but I hadn't rechecked since April
> > or so.
> 
> The serious gap, AFAICS, is the interplay with open-by-fhandle.
> It's not unfixable, but we need to figure out what to do when
> lookup runs into a disconnected directory alias.  d_splice_alias()
> will move it in place, all right, but any state ->lookup() has
> hung off the dentry that had been passed to it will be lost.
> 
> And I seriously suspect that we want to combine that state
> propagation with d_splice_alias() (or its variant to be used in
> such cases), rather than fixing the things up afterwards.
> 
> In particular, propagating ->d_op is really not trivial at that
> point; it is safe to do to ->lookup() argument prior to d_splice_alias()
> (even though that's too subtle and brittle, IMO), but after
> d_splice_alias() has succeeded, the damn thing is live and can
> be hit by hash lookups, revalidate, etc.
> 
> The only things that can't happen to it are ->d_delete(), ->d_prune(),
> ->d_iput() and ->d_init().  Everything else is fair game.
> 
> And then there's an interesting question about the interplay with
> reparenting.  It's OK to return an error rather than reparent,
> but we need some way to tell if we need to do so.

Hmm... int (*d_transfer)(struct dentry *alias, struct dentry *new)?
Called if d_splice_alias() picks that sucker, under rename_lock,
before the call of __d_move().  Can check IS_ROOT(alias) (due to
rename_lock), so can tell attaching from reparenting, returning
an error - failed d_splice_alias().

Perhaps would be even better inside __d_move(), once all ->d_lock
are taken...  Turn the current bool exchange in there into honest
enum (exchange/move/splice) and call ->d_transfer() on splice.
In case of failure it's still not too late to back out - __d_move()
would return an int, ignored in d_move() and d_exchange() and
treated as "fail in unlikely case it's non-zero" in d_splice_alias()
and __d_unalias()...

Comments?  Note that e.g.
        res = d_splice_alias(inode, dentry);
        if (!IS_ERR(fid)) {
                if (!res)
                        v9fs_fid_add(dentry, &fid);
                else if (!IS_ERR(res))
                        v9fs_fid_add(res, &fid);
                else
                        p9_fid_put(fid);
        }

in 9p ->lookup() would turn into

	v9fs_fid_add(dentry, &fid);
        return d_splice_alias(inode, dentry);

with ->d_transfer(alias, new) being simply

	struct hlist_node *p = new->d_fsdata;
	hlist_del_init(p);
	__add_fid(alias, hlist_entry(p, struct p9_fid, dlist));
	return 0;

assuming the call from __d_move()...

