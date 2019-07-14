Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C077F67CE9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2019 06:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbfGNEAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jul 2019 00:00:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34994 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfGNEAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jul 2019 00:00:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hmVej-000695-Co; Sun, 14 Jul 2019 03:58:41 +0000
Date:   Sun, 14 Jul 2019 04:58:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org,
        rgb@redhat.com, paul@paul-moore.com, raven@themaw.net,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v9 05/10] namei: O_BENEATH-style path resolution flags
Message-ID: <20190714035826.GQ17978@ZenIV.linux.org.uk>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-6-cyphar@cyphar.com>
 <20190712043341.GI17978@ZenIV.linux.org.uk>
 <20190712105745.nruaftgeat6irhzr@yavin>
 <20190712123924.GK17978@ZenIV.linux.org.uk>
 <20190712125552.GL17978@ZenIV.linux.org.uk>
 <20190712132553.GN17978@ZenIV.linux.org.uk>
 <20190712150026.GO17978@ZenIV.linux.org.uk>
 <20190713024153.GA3817@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713024153.GA3817@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 13, 2019 at 03:41:53AM +0100, Al Viro wrote:
> On Fri, Jul 12, 2019 at 04:00:26PM +0100, Al Viro wrote:
> > On Fri, Jul 12, 2019 at 02:25:53PM +0100, Al Viro wrote:
> > 
> > > 	if (flags & LOOKUP_BENEATH) {
> > > 		nd->root = nd->path;
> > > 		if (!(flags & LOOKUP_RCU))
> > > 			path_get(&nd->root);
> > > 		else
> > > 			nd->root_seq = nd->seq;
> > 
> > BTW, this assignment is needed for LOOKUP_RCU case.  Without it
> > you are pretty much guaranteed that lazy pathwalk will fail,
> > when it comes to complete_walk().
> > 
> > Speaking of which, what would happen if LOOKUP_ROOT/LOOKUP_BENEATH
> > combination would someday get passed?
> 
> I don't understand what's going on with ->r_seq in there - your
> call of path_is_under() is after having (re-)sampled rename_lock,
> but if that was the only .. in there, who's going to recheck
> the value?  For that matter, what's to guarantee that the thing
> won't get moved just as you are returning from handle_dots()?
> 
> IOW, what does LOOKUP_IN_ROOT guarantee for caller (openat2())?

Sigh...  Usual effects of trying to document things:

1) LOOKUP_NO_EVAL looks bogus.  It had been introduced by commit 57d4657716ac
(audit: ignore fcaps on umount) and AFAICS it's crap.  It is set in
ksys_umount() and nowhere else.  It's ignored by everything except
filename_mountpoint().  The thing is, call graph for filename_mountpoint()
is
	filename_mountpoint()
		<- user_path_mountpoint_at()
			<- ksys_umount()
		<- kern_path_mountpoint()
			<- autofs_dev_ioctl_ismountpoint()
			<- find_autofs_mount()
				<- autofs_dev_ioctl_open_mountpoint()
				<- autofs_dev_ioctl_requester()
				<- autofs_dev_ioctl_ismountpoint()
In other words, that flag is basically "was filename_mountpoint()
been called by umount(2) or has it come from an autofs ioctl?".
And looking at the rationale in that commit, autofs ioctls need
it just as much as umount(2) does.  Why is it not set for those
as well?  And why is it conditional at all?

1b) ... because audit_inode() wants LOOKUP_... as the last argument,
only to remap it into AUDIT_..., that's why.  So audit needs something
guaranteed not to conflict with LOOKUP_PARENT (another flag getting
remapped).  So why do we bother with remapping those, anyway?  Let's look
at the callers:

fs/namei.c:933: audit_inode(nd->name, nd->stack[0].link.dentry, 0);
fs/namei.c:2353:                audit_inode(name, path->dentry, flags & LOOKUP_PARENT);
fs/namei.c:2394:                audit_inode(name, parent->dentry, LOOKUP_PARENT);
fs/namei.c:2721:                audit_inode(name, path->dentry, flags & LOOKUP_NO_EVAL);
fs/namei.c:3302:                audit_inode(nd->name, dir, LOOKUP_PARENT);
fs/namei.c:3336:                audit_inode(nd->name, file->f_path.dentry, 0);
fs/namei.c:3371:        audit_inode(nd->name, path.dentry, 0);
fs/namei.c:3389:        audit_inode(nd->name, nd->path.dentry, 0);
fs/namei.c:3490:        audit_inode(nd->name, child, 0);
fs/namei.c:3509:                audit_inode(nd->name, path.dentry, 0);
ipc/mqueue.c:788:       audit_inode(name, dentry, 0);

In all but two of those we have a nice constant value - 0 or AUDIT_INODE_PARENT.
One of two exceptions is in filename_mountpoint(), and there we want
unconditional AUDIT_INODE_NOEVAL (see above).  What of the other?  It's
        if (likely(!retval))
                audit_inode(name, path->dentry, flags & LOOKUP_PARENT);
in filename_lookup().  And that is bogus as well.  filename_lookupat() would
better *NOT* get LOOKUP_PARENT in flags.  And it doesn't - not since
commit 8bcb77fabd7c (namei: split off filename_lookupat() with LOOKUP_PARENT)
back in 2015.  In filename_parentat() introduced there we have
                audit_inode(name, parent->dentry, LOOKUP_PARENT);
and at the same point the call in filename_lookupat() should've become
                audit_inode(name, path->dentry, 0);
It hadn't; my fault.  And after fixing that everything becomes nice and
unconditional - the last argument of audit_inode() is always an AUDIT_...
constant or zero.  Moving AUDIT_... definitions outside of ifdef on
CONFIG_AUDITSYSCALL, getting rid of remapping in audit_inode() and
passing the right values in 3 callers that don't pass 0 and LOOKUP_NO_EVAL
can go to hell.

Any objections from audit folks?

2) comment in namei.h is seriously out of sync with reality.  To quote:
 *  - follow links at the end
OK, that's LOOKUP_FOLLOW (1)
 *  - require a directory
... and LOOKUP_DIRECTORY (2)
 *  - ending slashes ok even for nonexistent files
... used to be about LOOKUP_CONTINUE (eight years dead now)
 *  - internal "there are more path components" flag
... LOOKUP_PARENT (16)
 *  - dentry cache is untrusted; force a real lookup
... LOOKUP_REVAL (32)
 *  - suppress terminal automount
... used to be LOOKUP_NO_AUTOMOUNT (128), except that it's been
replaced with LOOKUP_AUTOMOUNT (at 4) almost eight years ago.  And
the meaning of LOOKUP_AUTOMOUNT is opposite to the comment,
of course.
 *  - skip revalidation
... LOOKUP_NO_REVAL (128)
 *  - don't fetch xattrs on audit_inode
... and that's about soon-to-be dead LOOKUP_NO_EVAL (256)

Note that LOOKUP_RCU (at 64) is quietly skipped and so's the tail
of the list.  If not for "suppress terminal automount" bit, I wouldn't
really care, but that one makes for a really nasty trap for readers.
I'm going to convert that to (accurate) comments next to actual defines...

3) while looking through LOOKUP_AUTOMOUNT users,
in aa_bind_mount() we have
        error = kern_path(dev_name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &old_path);
matching do_loopback(), while tomoyo_mount_acl() has
                if (!dev_name || kern_path(dev_name, LOOKUP_FOLLOW, &path)) {
And yes, that *is* hit on mount --bind.  As well as on new mounts, where
apparmor (and bdev_lookup()) has plain LOOKUP_FOLLOW.

->sb_mount() is garbage by design (not the least because of the need to
have pathname lookups in the first place, as well as having to duplicate the
demultiplexing parts of do_mount() without fucking it up)...
