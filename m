Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2079355053
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 11:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhDFJts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 05:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233861AbhDFJtr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:49:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01E0F61074;
        Tue,  6 Apr 2021 09:49:37 +0000 (UTC)
Date:   Tue, 6 Apr 2021 11:49:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] cachefiles: use private mounts in cache->mnt
Message-ID: <20210406094935.wg3wrctebqs466hz@wittgenstein>
References: <20210405164603.281189-1-brauner@kernel.org>
 <107463.1617700345@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <107463.1617700345@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 10:12:25AM +0100, David Howells wrote:
> Christian Brauner <brauner@kernel.org> wrote:
> 
> > Besides that - and probably irrelevant from the perspective of a
> > cachefiles developer - it also makes things simpler for a variety of
> > other vfs features. One concrete example is fanotify.
> 
> What about cachefilesd?  That walks over the tree regularly, stats things and
> maybe deletes things.  Should that be in a private mount/namespace too?

You mean running the userspace cachefilesd daemon in a separate mount
namespace? I think that would make a lot of sense. Either the daemon
could manage a separate private mount namespace itself or if you support
systemd service files you could set:

PrivateMounts=yes

in the service file which:

"Takes a boolean parameter. If set, the processes of this unit will be
run in their own private file system (mount) namespace with all mount
propagation from the processes towards the host's main file system
namespace turned off. This means any file system mount points
established or removed by the unit's processes will be private to them
and not be visible to the host."

(Fwiw, Debian still ships /etc/init.d/cachefilesd which seems a bit
antique imho.)

> 
> > This seems a rather desirable property as the underlying path can't e.g.
> > suddenly go from read-write to read-only and in general it means that
> > cachefiles is always in full control of the underlying mount after the
> > user has allowed it to be used as a cache.
> 
> That's not entirely true, but I guess that emergency R/O conversion isn't a
> case that's worrisome - and, in any case, only affects the superblock.
> 
> >  	ret = -EINVAL;
> > -	if (mnt_user_ns(path.mnt) != &init_user_ns) {
> > +	if (mnt_user_ns(cache->mnt) != &init_user_ns) {
> >  		pr_warn("File cache on idmapped mounts not supported");
> >  		goto error_unsupported;
> >  	}
> 
> Is it worth doing this check before calling clone_private_mount()?

Yes, it's safe to do that. It's just my paranoia that made me write it
this way. In order to create an idmapped mount
real_mount(&path->mnt)->mnt_ns->seq must be 0, i.e. an anonymous mount
which can't be found through the fileystem. So in order for path->mnt to
be idmapped it must be already attached to the fileystem and we don't
allow mnt_userns to change (for good reasons).

> 
> > +	cache_path = path;
> > +	cache_path.mnt = cache->mnt;
> 
> Seems pointless to copy all of path into cache_path rather than just
> path.dentry.

Sure, will change to:

cache_path.dentry = path.dentry;
cache_path.mnt = cache->mnt;

Christian
