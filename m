Return-Path: <linux-fsdevel+bounces-12753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6909D866B8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 08:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D657284F6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 07:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659491CD12;
	Mon, 26 Feb 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DMLTTTea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76E1CD05;
	Mon, 26 Feb 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934295; cv=none; b=kOi6TWHvXwXUQ+yoZPOy7r3nFPcNX6EAFhjLy/WLyhygEPo1WWSbBBnrBFDXeeiXB/LxY6H13B5DBVVW1mpcOtrFHqdNfwdK9tobnTViq0niu2Q7Keylm2hrBNDJ9l+NdYliP8tjfCFdDpKYG2W9r/jXAFsM1blcnLWmHm4sQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934295; c=relaxed/simple;
	bh=GIR7mZoHwXp7M5bCErTApfEly69x95b+qEwILGlUFFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caVq35W77FEtFE9qmzdgydN5n8Quw7jSovT6nFtCwlbJ72RMQCV75AZ6Hj4261cf07dymwLF9JAQzcgxeQ9A+RLuc7G2KvfNeEeY9tmo/Vg2hzs1RbR0+2GUtXCiPNDwLLdmM3dMCRdKaSqTp6g+kuuxaaYxzlTspI1reybDbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DMLTTTea; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LrZrVei2YRSLH+uZ66rIukQ7qSqg617hRV3V2qnVT88=; b=DMLTTTeabW55R3w/JnqOz3e3U6
	KdcDiyFVw2MulyqqGCac9uTxYg1k64VT6cXi/yGSP0tTT6fGHORV4gWmNKJFyicTawoVCv89+4+gp
	S1lqKYXM0B7vnkOuuU1Ov2Mg35lpQVZcgGRePL40n8BUUL+OpPMYXzJ2ApvuYtpOKZtTeOzQD5Ahh
	boNkyrD8CHEhiupwIEAYYEOFEsVe1Nj/GyyDZogOPr4ncY4d/fhH5h5v0mARbGJNvvRLWhkhYZxAp
	SLluliZ63kh+eK9GY0z3FDwjZMR5uINIKPe00LnFXNDDEaqFIn8JHUcCprbSwbT40c+589am4fj87
	quFECiWQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reVsL-0000000Gtpa-0uO8;
	Mon, 26 Feb 2024 07:58:13 +0000
Message-ID: <836eec34-5f6b-4df0-aed1-ddd4fbebd61e@infradead.org>
Date: Sun, 25 Feb 2024 23:58:12 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] documentation on filesystem exposure to RCU pathwalk from
 fs maintainers' POV
Content-Language: en-US
To: Al Viro <viro@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
References: <Zdu58Jevui1ySBqa@duke.home>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Zdu58Jevui1ySBqa@duke.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Al,

Just some editing suggestions below...


On 2/25/24 14:06, Al Viro wrote:
> 	The text below is a rough approximation to what should, IMO,
> end up in Documentation/filesystems/rcu-exposure.rst.  It started
> as a part of audit notes.  Intended target audience of the text is
> filesystem maintainers and/or folks who are reviewing fs code;
> I hope the current contents is already useful to an extent, but
> I'm pretty certain that it needs more massage before it could
> go into the tree.
> 
> 	Please, read and review - comments and suggestions would be
> very welcome, both for contents and for markup - I'm *not* familiar
> with ReST or the ways it's used in the kernel (in particular, footnotes
> seem to get lost in PDF).
> 
> 
> ===================================================================
> The ways in which RCU pathwalk can ruin filesystem maintainer's day
> ===================================================================
> 
> The problem: exposure of filesystem code to lockless environment
> ================================================================
> 
> Filesystem methods can usually count upon VFS-provided warranties
> regarding the stability of objects they are called to act upon; at the
> very least, they can expect the dentries/inodes/superblocks involved to
> remain live throughout the operation.
> 
> Life would be much more painful without that; however, such warranties
> do not come for free.  The problem is that access patterns are heavily
> biased; every system call getting an absolute pathname will have to
> start at root directory, etc.  Having each of them in effect write
> "I'd been here" on the same memory objects would cost quite a bit.
> As the result, we try to keep the fast path stores-free, bumping
> no refcounts and taking no locks.  Details are described elsewhere,
> but the bottom line for filesystems is that some methods may be called
> with much looser warranties than usual.  Of course, from the filesystem
> POV each of those is a potential source of headache - you are asked to
> operate on an object that might start to be torn down right under you,
> possibly along with the filesystem instance it lives on.
> 
> The last possibility might sound surprising, but a lazy pathwalk really
> can run into a dentry on a filesystem that is getting shut down.
> 
> Here's one of the scenarios for that to happen:
> 
> 	1. have two threads sharing fs_struct chdir'ed on that filesystem.
> 	2. lazy-umount it, so that the only thing holding it alive is
> 	   cwd of these threads.
> 	3. the first thread does relative pathname resolution
> 	   and gets to e.g. ->d_hash().  It's holding rcu_read_lock().
> 	4. at the same time the second thread does fchdir(), moving to
> 	   different directory.
> 
> In fchdir(2) we get to set_fs_pwd(), which set the current directory
> to the new place and does mntput() on the old one.  No RCU delays here,
> we calculate the refcount of that mount and see that we are dropping
> the last reference.  We make sure that the pathwalk in progress in
> the first thread will fail when it comes to legitimize_mnt() and do this
> (in mntput_no_expire())::
> 
> 	init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
> 	if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
> 		return;
> 
> As we leave the syscall, we have __cleanup_mnt() run; it calls cleanup_mnt()
> on our mount, which hits deactivate_super().  That was the last reference to
> superblock.
> 
> Voila - we have a filesystem shutdown right under the nose of a thread
> running in ->d_hash() of something on that filesystem.  Mutatis mutandis,
> one can arrange the same for other methods called by rcu pathwalk.
> 
> It's not easy to hit (especially if you want to get through the
> entire ->kill_sb() before the first thread gets through ->d_hash()),
> and it's probably impossible on the real hardware; on KVM it might be
> borderline doable.  However, it is possible and I would not swear that
> other ways of arranging the same thing are equally hard to hit.
> 
> The bottom line: methods that can be called in RCU mode need to
> be careful about the per-superblock objects destruction.
> 
> 
> Opting out
> ==========
> 
> To large extent a filesystem can opt out of RCU pathwalk; that loses all
> scalability benefits whenever you filesystem gets involved in pathname

                                your

> resolution, though.  If that's the way you choose to go, just make sure
> that
> 
> 1. any ->d_revalidate(), ->permission(), ->get_link() and ->get_inode_acl()
> instance bails out if called by RCU pathwalk (see below for details).
> Costs a couple of lines of boilerplate in each.
> 
> 2. if some symlink inodes have ->i_link set to a dynamically allocated
> object, that object won't be freed without an RCU delay.  Anything
> coallocated with inode is fine, so's anything freed from ->free_inode().
> Usually comes for free, just remember to avoid freeing directly
> from ->destroy_inode().
> 
> 3. any ->d_hash() and ->d_compare() instances (if you have those) do
> not access any filesystem objects.
> 
> 4. there's no ->d_automount() instances in your filesystem.
> 
> If your case does not fit the above, the easy opt-out is not for you.
> If so, you'll have to keep reading...
> 
> 
> What methods are affected?
> ==========================
> 
> 	The list of the methods that could run into that fun:
> 
> ========================	==================================	=================
> 	method			indication that the call is unsafe	unstable objects
> ========================	==================================	=================
> ->d_hash(d, ...) 		none - any call might be		d
> ->d_compare(d, ...)		none - any call might be		d
> ->d_revalidate(d, f)		f & LOOKUP_RCU				d
> ->d_manage(d, f)		f					d
> ->permission(i, m)		m & MAY_NOT_BLOCK			i
> ->get_link(d, i, ...)		d == NULL				i
> ->get_inode_acl(i, t, f)	f == LOOKUP_RCU				i
> ========================	==================================	=================
> 
> 
> Additionally, callback set by set_delayed_call() from unsafe call of
> ->get_link() will be run in the same environment; that one is usually not
> a problem, though.
> 
> For the sake of completeness, three of LSM methods
> (->inode_permission(), ->inode_follow_link() and ->task_to_inode())
> might be called in similar environment, but that's a problem for LSM
> crowd, not for filesystem folks.
> 
> 
> Any method call is, of course, required not to crash - no stepping on
> freed memory, etc.  All of the unsafe calls listed above are done under
> rcu_read_lock(), so they are not allowed to block.  Further requirements
> vary between the methods.
> 
> 
> Before going through the list of affected methods, several notes on
> the things that _are_ guaranteed:
> 
> * if a reference to struct dentry is passed to such call, it will
>   not be freed until the method returns.  The same goes for a reference to
>   struct inode and to struct super_block pointed to by ->d_sb or ->i_sb
>   members of dentry and inode resp.  Any of those might be in process of

please spell out                respectively.

>   being torn down or enter such state right under us; the entire point of
>   those unsafe calls is that we make them without telling anyone they'd
>   need to wait for us.
> 
> * following ->d_parent and ->d_inode of such dentries is fine,
>   provided that it's done by READ_ONCE() (for ->d_inode the preferred
>   form is d_inode_rcu(dentry)).  The value of ->d_parent is never going
>   to be NULL and it will again point to a struct dentry that will not be
>   freed until the method call finishes.  The value of ->d_inode might
>   be NULL; if non-NULL, it'll be pointing to a struct inode that will
>   not be freed until the method call finishes.
> 
> * none of the inodes passed to an unsafe call could have reached
>   fs/inode.c:evict() before the caller grabbed rcu_read_lock().
> 
> * for inodes 'not freed' means 'not entered ->free_inode()', so
>   anything that won't be destroyed until ->free_inode() is safe to access.
>   Anything synchronously destroyed in ->evict_inode() or ->destroy_inode()
>   is not safe; however, one can count upon the call_rcu() callbacks
>   issued in those yet to be entered.  Note that unlike dentries and
>   superblocks, inodes are embedded into filesystem-private objects;
>   anything stored directly in the containing object is safe to access.
> 
> * for dentries anything destroyed by ->d_prune() (synchronously or
>   not) is not safe; the same goes for the things synchronously destroyed
>   by ->d_release().  However, call_rcu() callbacks issued in ->d_release()
>   are yet to be entered.
> 
> * for superblocks we can count upon call_rcu() callbacks issued
>   from inside the ->kill_sb() (including the ones issued from
>   ->put_super()) yet to be entered.  You can also count upon
>   ->s_user_ns still being pinned and ->s_security still not
>   freed.
> 
> * NOTE: we **can not** count upon the things like ->d_parent
>   being positive (or a directory); a race with rename()+rmdir()+mknod()
>   and you might find a FIFO as parent's inode.  NULL is even easier -
>   just have the dentry and its ex-parent already past dentry_kill()
>   (which is a normal situation for eviction on memory pressure) and there
>   you go.  Normally such pathologies are prevented by the locking (and
>   dentry refcounting), but... the entire point of that stuff is to avoid
>   informing anyone that we are there, so those mechanisms are bypassed.
>   What's more, if dentry is not pinned by refcount, grabbing its ->d_lock
>   will *not* suffice to prevent that kind of mess - the scenario with
>   eviction by memory pressure won't be prevented by that; you might have
>   grabbed ->d_lock only after the dentry_kill() had released it, and
>   at that point ->d_parent still points to what used to be the parent,
>   but there's nothing to prevent its eviction.
> 
> 
> ->d_compare()
> -------------
> 
> For ->d_compare() we just need to make sure it won't crash
> when called for dying dentry - an incorrect return value won't harm the
> caller in such case.  False positives and false negatives alike - the
> callers take care of that.  To be pedantic, make that "false positives
> do not cause problems unless they have ->d_manage()", but ->d_manage()
> is present only on autofs and there's no autofs ->d_compare() instances.
> [#f1]_
> 
> There is no indication that ->d_compare() is called in RCU mode;
> the majority of callers are such, anyway, so we need to cope with that.
> VFS guarantees that dentry won't be freed under us; the same goes for
> the superblock pointed to by its ->d_sb.  Name points to memory object
> that won't get freed under us and length does not exceed the size of
> that object.  The contents of that object is *NOT* guaranteed to be
> stable; d_move() might race with us, modifying the name.  However, in
> that case we are free to return an arbitrary result - the callers will
> take care of both false positives and false negatives in such case.
> The name we are comparing dentry with (passed in qstr) is stable,
> thankfully...
> 
> If we need to access any other data, it's up to the filesystem
> to protect it.  In practice it means that destruction of fs-private part
> of superblock (and possibly unicode tables hanging off it, etc.) might
> need to be RCU-delayed.
> 
> *IF* you want the behaviour that varies depending upon the parent
> directory, you get to be very careful with READ_ONCE() and watch out
> for the object lifetimes.
> 
> Basically, if the things get that tricky, ask for help.
> Currently there are two such instances in the tree - proc_sys_compare()
> and generic_ci_d_compare().  Both are... special.
> 
> 
> ->d_hash()
> ----------
> 
> For ->d_hash() on a dying dentry we are free to report any hash
> value; the only extra requirement is that we should not return stray
> hard errors.  In other words, if we return anything other than 0 or
> -ECHILD, we'd better make sure that this error would've been correct
> before the parent started dying.  Since ->d_hash() error-reporting is

no hyphen IMO                                             ^

> usually done to reject unacceptable names (too long, contain unsuitable
> characters for this filesystem, etc.), that's really not a problem -
> hard errors depend only upon the name, not the parent.
> 
> Again, VFS guarantees that freeing of dentry and of the superblock
> pointed to by dentry->d_sb won't happen under us.  The name passed to
> us (in qstr) is stable.  If you need anything beyond that, you are
> in the same situation as with ->d_compare().  Might want to RCU-delay
> freeing private part of superblock (if that's what we need to access),
> might want the same for some objects hanging off that (unicode tables,
> etc.).  If you need something beyond that - ask for help.
> 
> 
> ->d_revalidate()
> ----------------
> 
> For this one we do have an indication of call being unsafe -
> flags & LOOKUP_RCU.  With ->d_revalidate we are always allowed to bail
> out and return -ECHILD; that will have the caller drop out of RCU mode.
> We definitely need to do that if revalidate would require any kind of IO,
> mutex-taking, etc.; we can't block in RCU mode.
> 
> Quite a few instances of ->d_revalidate() simply treat LOOKUP_RCU
> in flags as "return -ECHILD and be done with that"; it's guaranteed to
> do the right thing, but you lose the benefits of RCU pathwalks whenever
> you run into such dentry.
> 
> Same as with the previous methods, we are guaranteed that
> dentry and dentry->d_sb won't be freed under us.  We are also guaranteed
> that ->d_parent (which is *not* stable, so use READ_ONCE) points to a
> struct dentry that won't get freed under us.  As always with ->d_parent,
> it's not NULL - for a detached dentry it will point to dentry itself.
> d_inode_rcu() of dentry and its parent will be either NULL or will
> point to a struct inode that won't get freed under us.	Anything beyond

s/tab/space/

> than that is not guaranteed.  We may find parent to be negative - it can
> happen if we race with d_move() and removal of old parent.  In that case
> just return -ECHILD and be done with that.
> 
> On non-RCU side you could use dget_parent() instead - that
> would give a positive dentry and its ->d_inode would remain stable.
> dget_parent() has to be paired with dput(), though, so it's not usable
> in RCU mode.
> 
> If you need fs-private objects associated with dentry, its parent
> inode(s) or superblock - see the general notes above on how to access
> those.
> 
> 
> ->d_manage()
> ------------
> 
> Can be called in RCU mode; gets an argument telling it if it has
> been called so.  Pretty much autofs-only; for everyone's sanity sake,
> don't inflict more of those on the kernel.  Definitely don't do that
> without asking first...
> 
> 
> ->permission()
> --------------
> 
> Can be called in RCU mode; that is indicated by MAY_NOT_BLOCK
> in mask, and it can only happen for MAY_EXEC checks on directories.
> In RCU mode it is not allowed to block, and it is allowed to bail out
> by returning -ECHILD.  It might be called for an inode that is getting
> torn down, possibly along with its filesystem.	Errors other than -ECHILD

s/tab/space/

> should only be returned if they would've been returned in non-RCU mode;
> several instances in procfs currently (6.5) run afoul of that one.  That's
> an instructive example, BTW - what happens is that proc_pid_permission()
> uses proc_get_task() to find the relevant process.  proc_get_task()
> uses PID reference stored in struct proc_inode our inode is embedded
> into; inode can't have been freed yet, so fetching ->pid member in that
> is safe.  However, using the value you've fetched is a different story
> - proc_evict_inode() would have passed it to put_pid() and replaced
> it with NULL.  Unsafe caller has no way to tell if that is happening
> right under it.  Solution: stop zeroing ->pid in proc_evict_inode()
> and move put_pid() from proc_pid_evict_inode() to proc_free_inode().
> That's not all that is needed (there's access to procfs-private part of
> superblock as well), but it does make a good example of how such stuff
> can be dealt with.
> 
> Note that idmap argument is safe on all calls - its destruction
> is rcu-delayed.
> 
> The amount of headache is seriously reduced (for now) by the fact
> that a lot of instances boil down to generic_permission() (which will
> do the right thing in RCU mode) when mask is MAY_EXEC | MAY_NOT_BLOCK.
> If we ever extend RCU mode to other ->permission() callers, the thing will
> get interesting; that's not likely to happen, though, unless access(2)
> goes there [this is NOT a suggestion, folks].
> 
> 
> ->get_link()
> ------------
> 
> Again, this can be called in RCU mode.	Even if your ->d_revalidate()

s/tab/space/

> always returns -ECHILD in RCU mode and kicks the pathwalk out of it,
> you can't assume that ->get_link() won't be reached [#f2]_.
> NULL dentry argument is an indicator of unsafe call; if you can't handle
> it, just return ERR_PTR(-ECHILD).  Any allocations you need to do (and
> with this method you really might need that) should be done with GFP_ATOMIC
> in the unsafe case.
> 
> Whatever you pass to set_delayed_call() is going to be called
> in the same mode as ->get_link() itself; not a problem for most of the
> instances.  The string you return needs to stay there until the
> callback gets called or, if no callback is set, until at least the
> freeing of inode.  As usual, for an unsafe call the inode might be
> in process of teardown, possibly along with the hosting filesystem.
> The usual considerations apply.  The same, BTW, applies to whatever
> you set in ->i_link - it must stay around at least until ->free_inode().
> 
> 
> ->get_inode_acl()
> -----------------
> 
> Very limited exposure for that one - unsafe call is possible
> only if you explicitly set ACL_DONT_CACHE as cached ACL value.
> Only two filesystems (fuse and overlayfs) even bother.  Unsafe call
> is indicated by explicit flag (the third argument of the method),
> bailout is done by returning ERR_PTR(-CHILD) and the usual considerations
> apply for any access to data structures you might need to do.
> 
> .. rubric:: Footnotes
> 
> .. [#f1]
> 
> Some callers prevent being called for dying dentry (holding ->d_lock and
> having verified !d_unhashed() or finding it in the list of inode's aliases
> under ->i_lock).  For those the scenario in question simply cannot arise.
> 
> Some follow the match with lockref_get_not_dead() and treat the failure
> as mismatch.  That takes care of false positives, and false negatives on
> dying dentry are still correct - we simply pretend to have lost the race.
> 
> The only caller that does not fit into the classes above is
> __d_lookup_rcu_op_compare().  There we sample ->d_seq and verify
> !d_unhashed() before calling ->d_compare().  That is not enough to
> prevent dentry from starting to die right under us; however, the sampled
> value of ->d_seq will be rechecked when the caller gets to step_into(),
> so for a false positive we will end up with a mismatch.  The corner case
> around ->d_manage() is due to the handle_mounts() done before step_into()
> gets to ->d_seq validation...
> 
> .. [#f2]
> 
> binding a symlink on top of a regular file on another filesystem is possible
> and that's all it takes for RCU pathwalk to get there.
> 

Thanks for the documentation.

-- 
#Randy

