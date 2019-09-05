Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3190CAAA59
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 19:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbfIERrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 13:47:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39040 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbfIERrv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:47:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i5vrE-0003dN-2e; Thu, 05 Sep 2019 17:47:44 +0000
Date:   Thu, 5 Sep 2019 18:47:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     jack@suse.cz, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        renxudong1@huawei.com, Li Jun <jun.li@nxp.com>
Subject: Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190905174744.GP1131@ZenIV.linux.org.uk>
References: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
 <20190903154007.GJ1131@ZenIV.linux.org.uk>
 <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 04, 2019 at 02:15:58PM +0800, zhengbin (A) wrote:
> >>
> >> Confused...  OTOH, I might be misreading that table of yours -
> >> it's about 30% wider than the widest xterm I can get while still
> >> being able to read the font...
> 
> The table is my guess. This oops happens sometimes
> 
> (We have one vmcore, others just have log, and the backtrace is same with vmcore, so the reason should be same).
> 
> Unfortunately, we do not know how to reproduce it. The vmcore has such a law:
> 
> 1、dirA has 177 files, and it is OK
> 
> 2、dirB has 25 files, and it is OK
> 
> 3、When we ls dirA, it begins with ".", "..", dirB's first file, second file... last file,  last file->next = &(dirB->d_subdirs)

Hmm...  Now, that is interesting.  I'm not sure it has anything to do
with that bug, but lockless loops over d_subdirs can run into trouble.

Look: dentry_unlist() leaves the ->d_child.next pointing to the next
non-cursor list element (or parent's ->d_subdir, if there's nothing
else left).  It works in pair with d_walk(): there we have
                struct dentry *child = this_parent;
                this_parent = child->d_parent;

                spin_unlock(&child->d_lock);
                spin_lock(&this_parent->d_lock);

                /* might go back up the wrong parent if we have had a rename. */
                if (need_seqretry(&rename_lock, seq))
                        goto rename_retry;
                /* go into the first sibling still alive */
                do {
                        next = child->d_child.next;
                        if (next == &this_parent->d_subdirs)
                                goto ascend;
                        child = list_entry(next, struct dentry, d_child);
                } while (unlikely(child->d_flags & DCACHE_DENTRY_KILLED));
                rcu_read_unlock();

Note the recheck of rename_lock there - it does guarantee that even if
child has been killed off between unlocking it and locking this_parent,
whatever it has ended up with in its ->d_child->next has *not* been
moved elsewhere.  It might, in turn, have been killed off.  In that
case its ->d_child.next points to the next surviving non-cursor, also
guaranteed to remain in the same directory, etc.

However, lose that rename_lock recheck and we'd get screwed, unless
there's some other d_move() prevention in effect.

Note that all libfs.c users (next_positive(), move_cursor(),
dcache_dir_lseek(), dcache_readdir(), simple_empty()) should be
safe - dcache_readdir() is called with directory locked at least
shared, uses in dcache_dir_lseek() are surrounded by the same,
move_cursor() and simple_empty() hold ->d_lock on parent,
next_positive() is called only under the lock on directory's
inode (at least shared).  Any of those should prevent any
kind of cross-directory moves - both into and out of.

<greps for d_subdirs/d_child users>

Huh?
In drivers/usb/typec/tcpm/tcpm.c:
static void tcpm_debugfs_exit(struct tcpm_port *port)
{
        int i;

        mutex_lock(&port->logbuffer_lock);
        for (i = 0; i < LOG_BUFFER_ENTRIES; i++) {
                kfree(port->logbuffer[i]);
                port->logbuffer[i] = NULL;
        }
        mutex_unlock(&port->logbuffer_lock);

        debugfs_remove(port->dentry);
        if (list_empty(&rootdir->d_subdirs)) {
                debugfs_remove(rootdir);
                rootdir = NULL;
        }
}

Unrelated, but obviously broken.  Not only the locking is
deeply suspect, but it's trivially confused by open() on
the damn directory.  It will definitely have ->d_subdirs
non-empty.

Came in "usb: typec: tcpm: remove tcpm dir if no children",
author Cc'd...  Why not remove the directory on rmmod?
And create on insmod, initially empty...

fs/nfsd/nfsctl.c:
static void nfsdfs_remove_files(struct dentry *root)
{
        struct dentry *dentry, *tmp;

        list_for_each_entry_safe(dentry, tmp, &root->d_subdirs, d_child) {
                if (!simple_positive(dentry)) {
                        WARN_ON_ONCE(1); /* I think this can't happen? */
                        continue;
It can happen - again, just have it opened and it bloody well will.
Locking is OK, though - parent's inode is locked, so we are
safe from d_move() playing silly buggers there.

fs/autofs/root.c:
static void autofs_clear_leaf_automount_flags(struct dentry *dentry)
{
...
        /* Set parent managed if it's becoming empty */
        if (d_child->next == &parent->d_subdirs &&
            d_child->prev == &parent->d_subdirs)
                managed_dentry_set_managed(parent);

Same bogosity regarding the check for emptiness (that one might've been my
fault).  Locking is safe...  Not sure if all places in autofs/expire.c
are careful enough...

So it doesn't look like this theory holds.  Which filesystem had that
been on and what about ->d_parent of dentries in dirA and dirB
->d_subdirs?
