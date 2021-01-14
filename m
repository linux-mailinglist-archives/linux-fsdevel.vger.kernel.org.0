Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137A62F6DB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 23:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbhANWLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 17:11:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46492 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbhANWLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:11:41 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l0ApP-0007xM-ND; Thu, 14 Jan 2021 22:10:51 +0000
Date:   Thu, 14 Jan 2021 23:10:48 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 37/42] xfs: support idmapped mounts
Message-ID: <20210114221048.ppf2pfuxrjak4kvm@wittgenstein>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210112220124.837960-38-christian.brauner@ubuntu.com>
 <20210114205154.GL331610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210114205154.GL331610@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 07:51:54AM +1100, Dave Chinner wrote:
> On Tue, Jan 12, 2021 at 11:01:19PM +0100, Christian Brauner wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > Enable idmapped mounts for xfs. This basically just means passing down
> > the user_namespace argument from the VFS methods down to where it is
> > passed to helper.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> ....
> > @@ -654,6 +658,7 @@ xfs_vn_change_ok(
> >   */
> >  static int
> >  xfs_setattr_nonsize(
> > +	struct user_namespace	*mnt_userns,
> >  	struct xfs_inode	*ip,
> >  	struct iattr		*iattr)
> >  {
> > @@ -813,7 +818,7 @@ xfs_setattr_nonsize(
> >  	 * 	     Posix ACL code seems to care about this issue either.
> >  	 */
> >  	if (mask & ATTR_MODE) {
> > -		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
> > +		error = posix_acl_chmod(mnt_userns, inode, inode->i_mode);
> >  		if (error)
> >  			return error;
> >  	}
> > @@ -868,7 +873,7 @@ xfs_setattr_size(
> >  		 * Use the regular setattr path to update the timestamps.
> >  		 */
> >  		iattr->ia_valid &= ~ATTR_SIZE;
> > -		return xfs_setattr_nonsize(ip, iattr);
> > +		return xfs_setattr_nonsize(&init_user_ns, ip, iattr);
> 
> Shouldn't that be passing mnt_userns?

Hey Dave,

Thanks for taking a look.

This is the time updating codepath.

xfs_setattr_size();
-> xfs_setattr_nonsize(&init_user_ns);

The xfs_setattr_size() helper will assert:

ASSERT((iattr->ia_valid & (ATTR_UID|ATTR_GID|ATTR_ATIME|ATTR_ATIME_SET|
	ATTR_MTIME_SET|ATTR_KILL_PRIV|ATTR_TIMES_SET)) == 0);

While the

xfs_setattr_nonsize() helper will further assert:

ASSERT((mask & ATTR_SIZE) == 0);

so xfs_setattr_nonsize() in this callpath is only used to update the

if (!(iattr->ia_valid & (ATTR_CTIME|ATTR_MTIME)))
	return 0;

so there's no interactions with idmappings in any way. Simply passing
mnt_userns might be clearer though.

But if this would be using the wrong idmapping the xfstest suite I added
would've immediately caught that and failed.

But this specific codepath can also be reliably hit from userspace by
doing ftruncate(fd, 0) so just to be extra sure I added truncate tests
to the xfstests now for both the idmapped and non-idmapped case.

Christian
