Return-Path: <linux-fsdevel+bounces-3557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4237F6622
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 19:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E36281DBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 18:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722614BA9E;
	Thu, 23 Nov 2023 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Fabkz98t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BA5D8;
	Thu, 23 Nov 2023 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tzBtdnKUjpPFnRpQQXW79rPDBbblRFlb1WYi8ZvDINo=; b=Fabkz98tmntc9tx+TcR3dogL0S
	9nhgmRAWY4xYIehskIPbIkiFauMkDyDWXNEgb2HZOU2Z6DsuH6P0HOhRJVSzIJLca+iTSSbT0KlId
	lCLtMcwgUjrMwTFYr9KvEiJjCaqcJrtw7F+T2OOPYEjI8ACX1VRwL11rhDsfjG3aCcJ9r99tRGMlm
	BHR/Mo8gapMS45KiEq3XY+fiKdVEnd5530I9NebMuEdijoEWKK6PKRAd+w20V/K30JO3oKjb/Sz0h
	QvMxxD5yme5qv8A6hBrfkvCKeZd/jQNy6tDobkyN3DNbi5myUJuIpPXH14o2XnypfcKYibR6URwLH
	hhQ93KVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6ENG-002CAr-2l;
	Thu, 23 Nov 2023 18:24:26 +0000
Date: Thu, 23 Nov 2023 18:24:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231123182426.GO38156@ZenIV>
References: <20230816050803.15660-1-krisman@suse.de>
 <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV>
 <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV>
 <87h6lcid5k.fsf@>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6lcid5k.fsf@>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 23, 2023 at 12:37:43PM -0500, Gabriel Krisman Bertazi wrote:
> > That's the problem I'd been talking about - there is a class of situations
> > where the work done by ext4_lookup() to set the state of dentry gets
> > completely lost.  After lookup you do have a dentry in the right place,
> > with the right name and inode, etc., but with NULL
> > ->d_op->d_revalidate.
> 
> I get the problem now. I admit to not understanding all the details yet,
> which is why I haven't answered directly, but I understand already how
> it can get borked.  I'm studying your explanation.
> 
> Originally, ->d_op could be propagated trivially since we had sb->s_d_op
> set, which would be set by __d_alloc, but that is no longer the case
> since we combined fscrypt and CI support.
>
> What I still don't understand is why we shouldn't fixup ->d_op when
> calling d_obtain_alias (before __d_instantiate_anon) and you say we
> better do it in d_splice_alias.  The ->d_op is going to be the same
> across the filesystem when the casefold feature is enabled, regardless
> if the directory is casefolded.  If we set it there, the alias already
> has the right d_op from the start.

*blink*

A paragraph above you've said that it's not constant over the entire
filesystem.

Look, it's really simple - any setup work of that sort done in ->lookup()
is either misplaced, or should be somehow transferred over to the alias
if one gets picked.

As for d_obtain_alias()... AFAICS, it's far more limited in what information
it could access.  It knows the inode, but it has no idea about the parent
to be.

The more I look at that, the more it feels like we need a method that would
tell the filesystem that this dentry is about to be spliced here.  9p is
another place where it would obviously simplify the things; ocfs2 'attach
lock' stuff is another case where the things get much more complicated
by having to do that stuff after splicing, etc.

It's not even hard to do:

1. turn bool exchange in __d_move() arguments into 3-value thing - move,
exchange or splice.  Have the callers in d_splice_alias() and __d_unalias()
pass "splice" instead of false (aka normal move).

2. make __d_move() return an int (normally 0)

3. if asked to splice and if there's target->d_op->d_transfer(), let
__d_move() call it right after
        spin_lock_nested(&dentry->d_lock, 2);
	spin_lock_nested(&target->d_lock, 3);
in there.  Passing it target and dentry, obviously.  In unlikely case
of getting a non-zero returned by the method, undo locks and return
that value to __d_move() caller.

4. d_move() and d_exchange() would ignore the value returned by __d_move();
__d_unalias() turn
        __d_move(alias, dentry, false);
	ret = 0;
into
	ret = __d_move(alias, dentry, Splice);
d_splice_alias() turn
				__d_move(new, dentry, false);
				write_sequnlock(&rename_lock);
into
				err = __d_move(new, dentry, Splice);
				write_sequnlock(&rename_lock);
				if (unlikely(err)) {
					dput(new);
					new = ERR_PTR(err);
				}
(actually, dput()-on-error part would be common to all 3 branches
in there, so it would probably get pulled out of that if-else if-else).

I can cook a patch doing that (and convert the obvious beneficiaries already
in the tree to it) and throw it into dcache branch - just need to massage
the series in there for repost...

PS: note, BTW, that fscrypt folks have already placed a hook into
__d_move(), exactly for the case of splice; I wonder if that would be
foldable into the same mechanism - hadn't looked in details yet.

