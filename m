Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1B32C555
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450750AbhCDAUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41600 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbhCCQQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:16:44 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lHU9p-00030o-EU; Wed, 03 Mar 2021 16:15:29 +0000
Date:   Wed, 3 Mar 2021 16:15:28 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Tycho Andersen <tycho@tycho.ws>,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/40] xattr: handle idmapped mounts
Message-ID: <20210303161528.n3jzg66ou2wa43qb@wittgenstein>
References: <20210303140522.jwlzrmhhho3lvpmv@wittgenstein>
 <20210121131959.646623-10-christian.brauner@ubuntu.com>
 <20210121131959.646623-1-christian.brauner@ubuntu.com>
 <2129497.1614777842@warthog.procyon.org.uk>
 <2203252.1614782707@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2203252.1614782707@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 03, 2021 at 02:45:07PM +0000, David Howells wrote:
> Christian Brauner <christian.brauner@ubuntu.com> wrote:
> 
> > In order to answer this more confidently I need to know a bit more about
> > how cachefiles are supposed to work.
> > 
> > From what I gather here it seemed what this code is trying to set here
> > is an internal "CacheFiles.cache" extended attribute on the indode. This
> > extended attribute doesn't store any uids and gids or filesystem
> > capabilities so the user namespace isn't relevant for that since there
> > doesn't need to be any conversion.
> > 
> > What I need to know is what information do you use for cachefiles to
> > determine whether someone can set that "Cachefiles.cache" extended
> > attribute on the inode:
> > - Is it the mnt_userns of a/the mount of the filesystem you're caching for?
> > - The mnt_userns of the mnt of struct cachefiles_cache?
> > - Or the stashed or current creds of the caller?
> 
> Mostly it's about permission checking.  The cache driver wants to do accesses
> onto the files in cache using the context of whatever process writes the
> "bind" command to /dev/cachefiles, not the context of whichever process issued
> a read or write, say, on an NFS file that is being cached.
> 
> This causes standard UNIX perm checking, SELinux checking, etc. all to be
> switched to the appropriate context.  It also controls what appears in the
> audit logs.

(Audit always translates from and to init_user_ns. The changes to make
it aware of user namespaces proper are delayed until the audit id thing
is merged as Paul pointed out to me.)

> 
> There is an exception to this: It also governs the ownership of new files and
> directories created in the cache and what security labels will be set on them.

So from our offline discussion I gather that cachefilesd creates a cache
on a local filesystem (ext4, xfs etc.) for a network filesystem. The way
this is done is by writing "bind" to /dev/cachefiles and pointing it to
a directory to use as the cache.

This directory can currently also be an idmapped mount, say:

mount --bind --idmap /mnt /mnt

and then pointing cachefilesd via a "bind" operation to

/mnt

What I would expect is for cachefilesd to now take that idmapping into
account when creating files in /mnt but as it stands now, it doesn't.
This could leave users confused as the ownership of the files wouldn't
match to what they expressed in the idmapping. Since you're reworking
cachefilesd currently anyway, I would suggest we port cachefilesd to
support idmapped mounts once as part of your rework. I can help there
and until then we do:


diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index dfb14dbddf51..51f21beafad9 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -115,6 +115,12 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
        if (ret < 0)
                goto error_open_root;

+       if (mnt_user_ns(path.mnt) != &init_user_ns) {
+               ret = -EPERM;
+               pr_err("Caches on idmapped mounts are currently not supported\n");
+               goto error_open_root;
+       }
+
        cache->mnt = path.mnt;
        root = path.dentry;

This is safe to do because if a mount is visible in the filesystem it
can't change it's idmapping.

(Might even be worth if you add a helper at this point:

static inline bool mnt_is_idmapped(struct vfsmount *mnt)
{
	return mnt_user_ns(mnt) != &init_user_ns;
}
)

Christian
