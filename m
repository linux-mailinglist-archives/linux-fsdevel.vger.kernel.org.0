Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CDA7B4AC5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjJBC24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBC24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:28:56 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E94AB
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kESrUhoABhY20LoA9ovCGXw2bH6PI2RDEzgO2tt2KRI=; b=AU/qnKXM8TQ6A7ds82x3UQyspG
        Dkv+Ze81vA9EPqQCGep4Frr5IPEeErdNk6n9IEXDZvh+wA+0xvM8aOH3I1SZkwmCJ5O3CSkGL0hAn
        /VsQlnOHXQ1u0ioajy0JXj+c0d2wJhPkIaY0dxKvb218LEs3DO+AesXHz/kjX0ItOmeMsKRFIUygf
        UTeD3BZeXaiyLl6xNuLkVmJW6Nrmprnz5B7LXVY8rE4fE7UBQZkS+mMOdHn8YIz/TjdNfel6ZjxX9
        NAidwKlEXqiH16WeU254nHc2VEnW8IWJUI5azHM9SSH1+lJCCqgmvKmib55tLgLCZIQlja6BSZ2AV
        yclDCTcA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8fu-00EDnc-1u;
        Mon, 02 Oct 2023 02:28:46 +0000
Date:   Mon, 2 Oct 2023 03:28:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC][PATCHES] fixes in methods exposed to rcu pathwalk
Message-ID: <20231002022846.GA3389589@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002022815.GQ800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Patchset summary follows; patches themselves - in followups.

1/15) rcu pathwalk: prevent bogus hard errors from may_lookup()
	That's one in the core pathwalk logics; basically, treat
errors from RCU permission() calls as "trust hard errors only if
the object is still there".  More for the sake of ->permission()
instances (similar to ->d_compare() et.al. the only thing they
need to care about when called on inode that is getting torn
down is not to crash; specific error value doesn't matter),
but there's also a narrow race where RCU pathwalk yields EACCES
while refwalk would fail with ENOTDIR.

2/15) exfat: move freeing sbi, upcase table and dropping nls into rcu-delayed helper
	Several UAF in their ->d_hash/->d_compare

3/15) affs: free affs_sb_info with kfree_rcu()
	UAF in ->d_hash/->d_compare

4/15) hfsplus: switch to rcu-delayed unloading of nls and freeing ->s_fs_info
	UAF and oops in ->d_hash/->d_compare

5/15) cifs_get_link(): bail out in unsafe case
	GFP_KERNEL allocation under rcu_read_lock in ->get_link()

6/15) procfs: move dropping pde and pid from ->evict_inode() to ->free_inode()
7/15) procfs: make freeing proc_fs_info rcu-delayed
	UAF in ->d_revalidate/->permission

8/15) gfs2: fix an oops in gfs2_permission()
	What it says...

9/15) nfs: make nfs_set_verifier() safe for use in RCU pathwalk
	race and oops in nfs_set_verifier() when used in RCU mode.
	Short version of the story - holding ->d_lock does *not*
	guarantee that ->d_parent->d_inode is non-NULL, unless you
	have your dentry pinned.

10/15) nfs: fix UAF on pathwalk running into umount
	Several UAF in ->d_revalidate/->permission/->get_link

11/15) fuse: fix UAF in rcu pathwalks
	UAF in ->permission/->get_link; accesses ->s_fs_info->fc,
	and ->s_fs_info points to struct fuse_mount which gets
	freed synchronously by fuse_mount_destroy(), from the end of
	->kill_sb().  It proceeds to accessing ->fc, but that part
	is safe - ->fc freeing is done via kfree_rcu() (called via
	->fc->release()) after the refcount of ->fc drops to zero.
	That can't happen until the call of fuse_conn_put() (from
	fuse_mount_destroy() from ->kill_sb()), so anything rcu-delayed
	from there won't get freed until the end of rcu pathwalk.
		
	Unfortunately, we also dereference fc->user_ns (pass it
	to current_in_userns).  That gets dropped via put_user_ns()
	(non-rcu-delayed) from the final fuse_conn_put() and it
	needs to be delayed.

	Possible solution: make freeing in ->release() synchronous
	and do call_rcu(delayed_release, &fc->rcu), with
	delayed_release() doing put_user_ns() and calling
	->release().
	This one is relatively intrusive and I'd really like comments
	from Miklos...

12/15) afs: fix __afs_break_callback() / afs_drop_open_mmap() race
	->d_revalidate/->permission manage to step on this one.
	We might end up doing __afs_break_callback() there,
	and it could race with afs_drop_open_mmap(), leading to
	stray queued work on object that might be about to be
	freed, with nothing to flush or cancel the sucker.
	To fix that race, make sure that afs_drop_open_mmap()
	will only do the final decrement while under ->cb_lock;
	since the entire __afs_break_callback() is done under
	the same, it will either see zero mmap count and do
	nothing, or it will finish queue_work() before afs_drop_open_mmap()
	gets to its flush_work().

13/15) overlayfs: move freeing ovl_entry past rcu delay
	Used to be done by kfree_rcu() from ->d_release(),
	got moved to ->destroy_inode() without any delays;
	move freeing to ->free_inode().

14/15) ovl_dentry_revalidate_common(): fetch inode once
	d_inode_rcu() is right - we might be in rcu pathwalk;
	however, OVL_E() hides plain d_inode() on the same dentry...
	
15/15) overlayfs: make use of ->layers safe in rcu pathwalk
	ovl_permission() accesses ->layers[...].mnt; we can't have ->layers
	freed without an RCU delay on fs shutdown.  Fortunately, kern_unmount_array()
	used to drop those mounts does include an RCU delay, so freeing is
	delayed; unfortunately, the array passed to kern_unmount_array() is
	formed by mangling ->layers contents and that happens without any
	delays.

	Use a separate array instead; local if we have a few layers,
	kmalloc'ed if there's a lot of them.  If allocation fails,
	fall back to kern_unmount() for individual mounts; it's
	not a fast path by any stretch of imagination.
