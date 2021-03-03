Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84132C544
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450655AbhCDATz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36438 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbhCCOGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:06:38 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lHS7v-0001mB-LN; Wed, 03 Mar 2021 14:05:23 +0000
Date:   Wed, 3 Mar 2021 14:05:22 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Tycho Andersen <tycho@tycho.ws>,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/40] xattr: handle idmapped mounts
Message-ID: <20210303140522.jwlzrmhhho3lvpmv@wittgenstein>
References: <20210121131959.646623-10-christian.brauner@ubuntu.com>
 <20210121131959.646623-1-christian.brauner@ubuntu.com>
 <2129497.1614777842@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2129497.1614777842@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 03, 2021 at 01:24:02PM +0000, David Howells wrote:
> Christian Brauner <christian.brauner@ubuntu.com> wrote:
> 
> > diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
> > index 72e42438f3d7..a591b5e09637 100644
> > --- a/fs/cachefiles/xattr.c
> > +++ b/fs/cachefiles/xattr.c
> > @@ -39,8 +39,8 @@ int cachefiles_check_object_type(struct cachefiles_object *object)
> >  	_enter("%p{%s}", object, type);
> >  
> >  	/* attempt to install a type label directly */
> > -	ret = vfs_setxattr(dentry, cachefiles_xattr_cache, type, 2,
> > -			   XATTR_CREATE);
> > +	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache, type,
> > +			   2, XATTR_CREATE);
> 

Hey David,

(Ok, recovered from my run-in with the swapfile bug. I even managed to
get my emails back.)

> Actually, on further consideration, this might be the wrong thing to do in
> cachefiles.  The creds are (or should be) overridden when accesses to the
> underlying filesystem are being made.
> 
> I wonder if this should be using current_cred()->user_ns or
> cache->cache_cred->user_ns instead.

Before I go into the second question please note that this is a no-op
change. So if this is wrong it was wrong before. Which is your point, I
guess.

Please also note that the mnt_userns is _never_ used for (capability)
permission checking, only for idmapping vfs objects and permission
checks based on the i_uid and i_gid. So if your argument about passing
one of those two user namespaces above has anything to do with
permission checking on caps it's most likely wrong. :)

In order to answer this more confidently I need to know a bit more about
how cachefiles are supposed to work.

From what I gather here it seemed what this code is trying to set here
is an internal "CacheFiles.cache" extended attribute on the indode. This
extended attribute doesn't store any uids and gids or filesystem
capabilities so the user namespace isn't relevant for that since there
doesn't need to be any conversion.

What I need to know is what information do you use for cachefiles to
determine whether someone can set that "Cachefiles.cache" extended
attribute on the inode:
- Is it the mnt_userns of a/the mount of the filesystem you're caching for?
- The mnt_userns of the mnt of struct cachefiles_cache?
- Or the stashed or current creds of the caller?

Christian
