Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2508552BDEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 17:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbiERO1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 10:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiERO1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 10:27:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3CA49F81;
        Wed, 18 May 2022 07:27:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 000F3B82123;
        Wed, 18 May 2022 14:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A895C385A9;
        Wed, 18 May 2022 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652884033;
        bh=dWbiYmzDlDpe+Wd/fdPPNVJYD6Bvgi+M/GAVIlSrzyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsZWgGnWc7nne2hpsLOjiDRW9+IHUQQiaWV6STJHGB4qb3Av7d3MwhuqMd2dCX56V
         h3o+KE+6+gUg4dTVQJbdmQNyJi7Bi1B0OGvxtwDxUIFoKO6qMCTl7hBmVp+sQ2ltuL
         8s22b2dR8wxmvIXuqZsVZZk7m4MzKWdGtExNujaHUulE5fW2nRvm41Ug69X/Au3WoA
         foRrDGh5xY6FQMzGXvTRWmhxBWjHewXyGdzrhhCh7vEUjsG/RwOAVloedZzHdackBf
         d5SWCNNW4DFjab75z1TK+7rQxIo55Tb/JGFYOE2fOQKxv29aUuLVrZE+HjgpDZtPs0
         p5zZ60YdUDwkQ==
Date:   Wed, 18 May 2022 16:27:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, smfrench@gmail.com,
        hyc.lee@gmail.com, senozhatsky@chromium.org
Subject: Re: [PATCH 3/3] ksmbd: fix racy issue from using ->d_parent and
 ->d_name
Message-ID: <20220518142709.iewhrubtqiowdago@wittgenstein>
References: <20220427023245.7327-1-linkinjeon@kernel.org>
 <20220427023245.7327-3-linkinjeon@kernel.org>
 <YoQRypdyLcN60F+X@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoQRypdyLcN60F+X@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 17, 2022 at 09:21:14PM +0000, Al Viro wrote:
> On Wed, Apr 27, 2022 at 11:32:45AM +0900, Namjae Jeon wrote:
> > Al pointed out that ksmbd has racy issue from using ->d_parent and ->d_name
> > in ksmbd_vfs_unlink and smb2_vfs_rename(). and use new lock_rename_child()
> > to lock stable parent while underlying rename racy.
> > Introduce vfs_path_parent_lookup helper to avoid out of share access and
> > export vfs functions like the following ones to use
> > vfs_path_parent_lookup().
> >  - export __lookup_hash().
> >  - export getname_kernel() and putname().
> > 
> > vfs_path_parent_lookup() is used for parent lookup of destination file
> > using absolute pathname given from FILE_RENAME_INFORMATION request.
> 
> First of all, this is seriously broken:
> 
> > -int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry *parent,
> > -			  struct dentry *child)
> > +struct dentry *ksmbd_vfs_lock_parent(struct dentry *child)
> >  {
> > -	struct dentry *dentry;
> > -	int ret = 0;
> > +	struct dentry *parent;
> >  
> > +	parent = dget(child->d_parent);
> >  	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> 
> Do that in parallel with host rename() and you are risking this:
> 
> you: fetch child->d_parent
> 	get preempted away
> another thread: move child elsewhere
> another thread: drop (the last) reference to old parent
> 	memory pressure evicts that dentry and reuses memory
> you: regain the timeslice and bump what you think is parent->d_count.
> 	In reality, it's 4 bytes in completely different data structure.
> 	At that point you already have a memory corruptor.  Worse,
> 	there's a decent chance that subsequent code will revert the
> 	corruption, so it would be hell to debug - you need a race
> 	to reproduce the thing in the first place *and* you need
> 	something else to notice the temporary memory corruption.
> 
> you: fetch what you think is ->d_inode of that dentry.  It actually
> 	isn't anything of that sort.
> you: grab rwsem at hell knows what address (might or might not point
> 	to an rwsem).  Here's another chance to get something
> 	reproducible - e.g. if what you thought was ->d_inode actually
> 	points to unmapped memory, you'll get an oops here.  Won't
> 	be consistent, though.
> 
> > +	if (child->d_parent != parent) {
> you:	->d_parent doesn't point there anymore
> 
> > +		dput(parent);
> 
> you:	decrement those 4 bytes in whatever object it is; if you are
> 	lucky, it won't hit zero and nobody had noticed the temporary
> 	increment.  If you are not, well...
> 
> > +		inode_unlock(d_inode(parent));
> 
> you:	fetch ->d_inode of parent (mind you, it's a bug in its own right -
> 	even if parent hadn't gotten freed before your dget(), after dput()
> 	above it's fair game for getting freed; placing that dput()
> 	before unlocking d_inode() is wrong).  Assuming you've got
> 	the same pointer as the first time around, you proceed to
> 	drop rwsem at the same address where you've grabbed it.
> 
> IOW, you really don't want that in the tree in this form.
> 
> It *might* be partially recoverable if you replace the first dget() with
> dget_parent() and reorder dput() and inode_unlock() in failure case, but...
> some of the callers of that thing are also rather dubious.
> 
> Look: you have smb2_open() calling ksmbd_vfs_may_delete(), which calls
> that thing.  Downstream of this:
> 	if (!file_present) {
> 	...
> 	} else if (!already_permitted) {
> 
> If the parent is *NOT* already locked by that point, just how much is
> your 'file_present' worth?  And if it is, you'd obviously deadlock
> right there and then...
> 
> I'm not sure I like what you've done with added exports - e.g.
> __lookup_hash had been OK as a name of static function, but exporting
> it is asking for clashes.  And honestly, what would you say when running
> into a name like that?  OK, it sounds like it's a (probably low-level)
> lookup in some hash table.  _Maybe_ it would've been fine if we had one
> and only implementation of hash tables in the entire tree and that
> had been a part of it, but it's nothing of that sort.  And "hash" in
> the name is not about doing a hash lookup as opposed to some other
> work (it *does* handle hash misses, allocating dentry, asking filesystem
> to do real on-disk lookup, etc.) - it's actually about "hash function
> of the name is already calculated".  My fault, that - predecessor of
> that thing had been called lookup_one(); it took a string, calculated
> its length and computed hash, then proceeded to do lookups.  The latter
> part could be reused in handling of rmdir et.al., where we already had
> the component length and hash precalculated, so the tail of lookup_one()
> had been carved out into a separate helper.  Circa 2.3.99...
> 
> Anyway, the name is _not_ fit for an export; I'm not sure what to call
> it - lookup_one_qstr(), perhaps?  Additional fun is due to the fact
> that these days it is slightly different from the lookup_one() et.al.
> Those can be called with directory held shared; that allows parallel
> lookups, but it's not free of cost - if we run into a cache miss and need
> to allocate a new dentry and talk to filesystem, we have to recheck the
> hash table after allocation.  __lookup_hash() is called only with parent
> held exclusive and it can skip that fun - hash miss is going to remain
> a miss; nobody else will be able to insert stuff into dcache in that
> directory until we unlock it.
> 
> What I'm worried about is that renaming it to lookup_one_qstr() will
> be an invitation for "oh, we happen to have hash/len already known by the
> time of that lookup_one() call; let's just convert it to lookup_one_qsrt()"
> and if that happens in a place where the parent is held only shared, we'll
> be in trouble.  OTOH, lookup_one_qstr_excl() sounds like an invitation to
> do something painful to whoever's responsible for such name...
> 
> Suggestions, anyone?

Plus, __lookup_hash() doesn't do permission checking so naming it
lookup_one_qstr() seems problematic from that perspective as well...

Don't kill me but:

__excl_qstr_lookup_noperm()

?
