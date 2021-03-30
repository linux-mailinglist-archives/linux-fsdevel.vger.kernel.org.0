Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BEE34E7FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 14:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhC3Mx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 08:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232077AbhC3Mxk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:53:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1170F619B1;
        Tue, 30 Mar 2021 12:53:38 +0000 (UTC)
Date:   Tue, 30 Mar 2021 14:53:36 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark
 mask
Message-ID: <20210330125336.vj2hkgwhyrh5okee@wittgenstein>
References: <20210328155624.930558-1-amir73il@gmail.com>
 <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
 <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 03:33:23PM +0300, Amir Goldstein wrote:
> On Tue, Mar 30, 2021 at 3:12 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Sun, Mar 28, 2021 at 06:56:24PM +0300, Amir Goldstein wrote:
> > > Add a high level hook fsnotify_path_create() which is called from
> > > syscall context where mount context is available, so that FAN_CREATE
> > > event can be added to a mount mark mask.
> > >
> > > This high level hook is called in addition to fsnotify_create(),
> > > fsnotify_mkdir() and fsnotify_link() hooks in vfs helpers where the mount
> > > context is not available.
> > >
> > > In the context where fsnotify_path_create() will be called, a dentry flag
> > > flag is set on the new dentry the suppress the FS_CREATE event in the vfs
> > > level hooks.
> >
> > Ok, just to make sure this scheme would also work for overlay-style
> > filesystems like ecryptfs where you possible generate two notify events:
> > - in the ecryptfs layer
> > - in the lower fs layer
> > at least when you set a regular inode watch.
> >
> > If you set a mount watch you ideally would generate two events in both
> > layers too, right? But afaict that wouldn't work.
> >
> > Say, someone creates a new link in ecryptfs the DENTRY_PATH_CREATE
> > flag will be set on the new ecryptfs dentry and so no notify event will
> > be generated for the ecryptfs layer again. Then ecryptfs calls
> > vfs_link() to create a new dentry in the lower layer. The new dentry in
> > the lower layer won't have DCACHE_PATH_CREATE set. Ok, that makes sense.
> >
> > But since vfs_link() doesn't have access to the mnt context itself you
> > can't generate a notify event for the mount associated with the lower
> > fs. This would cause people who a FAN_MARK_MOUNT watch on that lower fs
> > mount to not get notified about creation events going through the
> > ecryptfs layer. Is that right?  Seems like this could be a problem.
> >
> 
> Not sure I follow what the problem might be.
> 
> FAN_MARK_MOUNT subscribes to get only events that were
> generated via that vfsmount - that has been that way forever.
> 
> A listener may subscribe to (say) FAN_CREATE on a certain
> mount AND also also on a specific parent directory.
> 
> If the listener is watching the entire ecryptfs mount and the
> specific lower directory where said vfs_link() happens, both
> events will be reported. One from fsnotify_create_path() and
> the lower from fsnotify_create().
> 
> If one listener is watching the ecryptfs mount and another
> listener is watching the specific ecryptfs directory, both
> listeners will get a single event each. They will both get
> the event that is emitted from fsnotify_path_create().
> 
> Besides I am not sure about ecryptfs, but overlayfs uses
> private mount clone for accessing lower layer, so by definition

I know. That's why I was using ecryptfs as an example which doesn't do
that (And I think it should be switched tbh.). It simply uses
kern_path() and then stashes that path.

My example probably would be something like:

mount -t ext4 /dev/sdb /A

1. FAN_MARK_MOUNT(/A)

mount --bind /A /B

2. FAN_MARK_MOUNT(/B)

mount -t ecryptfs /B /C

3. FAN_MARK_MOUNT(/C)

let's say I now do

touch /unencrypted/bla

I may be way off here but intuitively it seems both 1. and 2. should get
a creation event but not 3., right?

But with your proposal would both 1. and 2. still get a creation event?

> users cannot watch the underlying overlayfs operations using
> a mount mark. Also, overlayfs suppresses fsnotify events on
> underlying files intentionally with FMODE_NONOTIFY.

Probably ecryptfs should too?

Christian
