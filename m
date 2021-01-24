Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAEC301F5D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Jan 2021 23:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbhAXWpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jan 2021 17:45:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47673 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbhAXWps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jan 2021 17:45:48 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l3o7r-0007VN-AX; Sun, 24 Jan 2021 22:44:55 +0000
Date:   Sun, 24 Jan 2021 23:44:50 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
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
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 05/39] namei: make permission helpers idmapped mount
 aware
Message-ID: <20210124224450.3dtdgvwxpdf5niuz@wittgenstein>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
 <20210121131959.646623-6-christian.brauner@ubuntu.com>
 <20210122222632.GB25405@fieldses.org>
 <20210123130958.3t6kvgkl634njpsm@wittgenstein>
 <20210124221854.GA1487@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210124221854.GA1487@fieldses.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 24, 2021 at 05:18:54PM -0500, J. Bruce Fields wrote:
> On Sat, Jan 23, 2021 at 02:09:58PM +0100, Christian Brauner wrote:
> > On Fri, Jan 22, 2021 at 05:26:32PM -0500, J. Bruce Fields wrote:
> > > If I NFS-exported an idmapped mount, I think I'd expect idmapped clients
> > > to see the mapped IDs.
> > > 
> > > Looks like that means taking the user namespace from the struct
> > > svc_export everwhere, for example:
> > > 
> > > On Thu, Jan 21, 2021 at 02:19:24PM +0100, Christian Brauner wrote:
> > > > index 66f2ef67792a..8d90796e236a 100644
> > > > --- a/fs/nfsd/nfsfh.c
> > > > +++ b/fs/nfsd/nfsfh.c
> > > > @@ -40,7 +40,8 @@ static int nfsd_acceptable(void *expv, struct dentry *dentry)
> > > >  		/* make sure parents give x permission to user */
> > > >  		int err;
> > > >  		parent = dget_parent(tdentry);
> > > > -		err = inode_permission(d_inode(parent), MAY_EXEC);
> > > > +		err = inode_permission(&init_user_ns,
> > > > +				       d_inode(parent), MAY_EXEC);
> > > 
> > > 		err = inode_permission(exp->ex_path.mnt->mnt_userns,
> > > 				      d_inode(parent, MAY_EXEC);
> > 
> > Hey Bruce, thanks! Imho, the clean approach for now is to not export
> > idmapped mounts until we have ported that part of nfs similar to what we
> > do for stacking filesystems for now. I've tested and taken this patch
> > into my tree:
> 
> Oh good, thanks.  My real fear was that we'd fix this up later and leave
> users in a situation where the server exposes different IDs depending on
> kernel version, which would be a mess.  Looks like this should avoid
> that.
> 
> As for making idmapped mounts actually work with nfsd--are you planning
> to do that, or do you need me to?  I hope the patch is straightforward;

I'm happy to do it or help and there's other people I know who are also
interested in that and would likely be happy to do the work too.

> I'm more worried testing it.

This whole series has a large xfstest patch associated with it that
tests regular vfs behavior and vfs behavior with idmapped mounts. Iirc,
xfstests also has infrastructure to test nfs. So I'd expect we expand
the idmapped mounts testsuite to test nfs behavior as well.
So far it has proven pretty helpful and has already unconvered an
unrelated setgid-inheritance xfs bug that Christoph fixed a short time
ago.
