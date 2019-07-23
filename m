Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C476E72316
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 01:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfGWXae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 19:30:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50106 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfGWXad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 19:30:33 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hq4Ea-00010p-D2; Tue, 23 Jul 2019 23:30:16 +0000
Date:   Wed, 24 Jul 2019 00:30:16 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     James Morris <jmorris@namei.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts
 around
Message-ID: <20190723233016.GD1131@ZenIV.linux.org.uk>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
 <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp>
 <20190708131831.GT17978@ZenIV.linux.org.uk>
 <874l3wo3gq.fsf@xmission.com>
 <20190708180132.GU17978@ZenIV.linux.org.uk>
 <20190708202124.GX17978@ZenIV.linux.org.uk>
 <alpine.LRH.2.21.1907240744080.16974@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1907240744080.16974@namei.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 24, 2019 at 07:45:07AM +1000, James Morris wrote:
> On Mon, 8 Jul 2019, Al Viro wrote:
> 
> > On Mon, Jul 08, 2019 at 07:01:32PM +0100, Al Viro wrote:
> > > On Mon, Jul 08, 2019 at 12:12:21PM -0500, Eric W. Biederman wrote:
> > > 
> > > > Al you do realize that the TOCTOU you are talking about comes the system
> > > > call API.  TOMOYO can only be faulted for not playing in their own
> > > > sandbox and not reaching out and fixing the vfs implementation details.
> > 
> > PS: the fact that mount(2) has been overloaded to hell and back (including
> > MS_MOVE, which goes back to v2.5.0.5) predates the introduction of ->sb_mount()
> > and LSM in general (2.5.27).  MS_BIND is 2.4.0-test9pre2.
> > 
> > In all the years since the introduction of ->sb_mount() I've seen zero
> > questions from LSM folks regarding a sane place for those checks.  What I have
> > seen was "we want it immediately upon the syscall entry, let the module
> > figure out what to do" in reply to several times I tried to tell them "folks,
> > it's called in a bad place; you want the checks applied to objects, not to
> > raw string arguments".
> > 
> > As it is, we have easily bypassable checks on mount(2) (by way of ->sb_mount();
> > there are other hooks also in the game for remounts and new mounts).
> 
> What are your recommendations for placing these checks?

For MS_MOVE: do_move_mount(), after lock_mount(), when the mount tree is stable
and pathnames are resolved.
For MS_BIND: do_loopback(), ditto.
Incidentally, for pivot_root(2) I would also suggest moving that past the
lock_mount(), for the same reasons.
For propagation flag changes: do_change_type(), after namespace_lock().
For per-mount flag changes: do_reconfigure_mnt(), possibly after having
grabbed ->s_umount.
For fs remount: IMO it should be handled purely in ->sb_remount().

For new mount: really depends upon the filesystem type, I'm afraid.  There's
nothing type-independent that can be done - in the best case you can say
"no mounting block filesystems from that device"; note that for NFS the
meaning of the argument is entirely different and you *can* have something
like foo.local.org: as a name of symlink (or directory), so blanket "you can
mount foo.local.org:/srv/nfs/blah" is asking for trouble -
mount -t ext4 foo.local.org:/srv/nfs/blah /mnt can bloody well end up
successfully mounting a very untrusted usb disk.

Note, BTW, that things like cramfs can be given
	* mtd:mtd_device_name
	* mtd<decimal number>
	* block device pathname
The last one needs to be resolved/canonicalized/whatnot.
The other two must *NOT* - there's nothing to stop the
attacker from ln -s /dev/mtdblock0 ./mtd12 and confusing
the fsck out of your LSM (it would assume that we are
trying to get mtd0 when in reality it'll mount mtd12).

The rules really need to be type-dependent; ->sb_set_mnt_opts() has the
state after the fs has been initialized to work with, but anything trying
to stop the attempt to set the damn thing up in the first place (as
current ->sb_mount() would) must be called from the inside of individual
->get_tree()/->mount() instance (or a helper used by such).
