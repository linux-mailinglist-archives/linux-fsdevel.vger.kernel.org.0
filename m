Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C9A2CB9F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 11:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbgLBJ6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 04:58:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35480 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388027AbgLBJ6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:58:36 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kkOtQ-0004uq-9l; Wed, 02 Dec 2020 09:57:48 +0000
Date:   Wed, 2 Dec 2020 10:57:45 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
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
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org, fstests@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH v3 04/38] fs: add mount_setattr()
Message-ID: <20201202095745.bhazopysyw5kbiee@wittgenstein>
References: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
 <20201128213527.2669807-5-christian.brauner@ubuntu.com>
 <20201201104907.GD27730@lst.de>
 <20201202094218.ym5zqnulwz6gj6eo@wittgenstein>
 <20201202094751.GA6129@lst.de>
 <20201202095547.GA6408@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202095547.GA6408@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:55:47AM +0100, Christoph Hellwig wrote:
> On Wed, Dec 02, 2020 at 10:47:51AM +0100, Christoph Hellwig wrote:
> > On Wed, Dec 02, 2020 at 10:42:18AM +0100, Christian Brauner wrote:
> > > > > +	if (upper_32_bits(attr->attr_set))
> > > > > +		return -EINVAL;
> > > > > +	if (build_attr_flags(lower_32_bits(attr->attr_set), &kattr->attr_set))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	if (upper_32_bits(attr->attr_clr))
> > > > > +		return -EINVAL;
> > > > > +	if (build_attr_flags(lower_32_bits(attr->attr_clr), &kattr->attr_clr))
> > > > > +		return -EINVAL;
> > > > 
> > > > What is so magic about the upper and lower 32 bits?
> > > 
> > > Nothing apart from the fact that they arent't currently valid. I can
> > > think about reworking these lines. Or do you already have a preferred
> > > way of doing this in mind?
> > 
> > Just turn the attr_flags argument to build_attr_flags into a u64 and
> > the first sanity check there will catch all invalid flags, no matter
> > where they are places.  That should also generate more efficient code.
> 
> And while we're at it:  the check for valid flags in the current
> code is a little weird, given that build_attr_flags checks for
> them, and but sys_fsmount also has its own slightly narrower checks.
> 
> I think it might make sense to split the validity check out of
> build_attr_flags. E.g. something like:

Sounds good!
If we make this a preparatory patch do you want to be recorded in the
author field?

> 
> static unsigned int attr_flags_to_mnt_flags(u64 attr_flags)
> {
> 	unsigned int mnt_flags = 0;
> 
> 	if (attr_flags & MOUNT_ATTR_RDONLY)
> 		mnt_flags |= MNT_READONLY;
> 	if (attr_flags & MOUNT_ATTR_NOSUID)
> 		mnt_flags |= MNT_NOSUID;
> 	if (attr_flags & MOUNT_ATTR_NODEV)
> 		mnt_flags |= MNT_NODEV;
> 	if (attr_flags & MOUNT_ATTR_NOEXEC)
> 		mnt_flags |= MNT_NOEXEC;
> 	if (attr_flags & MOUNT_ATTR_NODIRATIME)
> 		mnt_flags |= MNT_NODIRATIME;
> 
> 	return mnt_flags;
> }
> 
> #define MOUNT_SETATTR_VALID_FLAGS \
> 	(MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV | \
> 	 MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME | MOUNT_ATTR_NODIRATIME | \
> 	 MOUNT_ATTR_IDMAP)
> 
> static int build_mount_kattr(const struct mount_attr *attr, size_t usize,
> 			     struct mount_kattr *kattr, unsigned int flags)
> {
> 	...
> 
> 	if ((attr->attr_set | attr->attr_clr) & ~MOUNT_SETATTR_VALID_FLAGS)
> 		return -EINVAL;
> 	kattr->attr_set = attr_flags_to_mnt_flags(attr->attr_set);
> 	kattr->attr_clr = attr_flags_to_mnt_flags(attr->attr_clr);
> 	...
> }
