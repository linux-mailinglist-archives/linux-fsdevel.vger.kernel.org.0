Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DACC2C00CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 08:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgKWHpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 02:45:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33563 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKWHpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 02:45:12 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kh6X5-0007Jl-9M; Mon, 23 Nov 2020 07:45:07 +0000
Date:   Mon, 23 Nov 2020 08:45:05 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Paul Moore <paul@paul-moore.com>
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
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 14/39] commoncap: handle idmapped mounts
Message-ID: <20201123074505.ds5hpqo5kgyvjksb@wittgenstein>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
 <20201115103718.298186-15-christian.brauner@ubuntu.com>
 <CAHC9VhRqk1WMXyHTsrLcJnpxMPgJs_CxeG2uCaaBGgHqK_jj=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhRqk1WMXyHTsrLcJnpxMPgJs_CxeG2uCaaBGgHqK_jj=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 22, 2020 at 04:18:55PM -0500, Paul Moore wrote:
> On Sun, Nov 15, 2020 at 5:39 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > When interacting with user namespace and non-user namespace aware
> > filesystem capabilities the vfs will perform various security checks to
> > determine whether or not the filesystem capabilities can be used by the
> > caller (e.g. during exec), or even whether they need to be removed. The
> > main infrastructure for this resides in the capability codepaths but they
> > are called through the LSM security infrastructure even though they are not
> > technically an LSM or optional. This extends the existing security hooks
> > security_inode_removexattr(), security_inode_killpriv(),
> > security_inode_getsecurity() to pass down the mount's user namespace and
> > makes them aware of idmapped mounts.
> > In order to actually get filesystem capabilities from disk the capability
> > infrastructure exposes the get_vfs_caps_from_disk() helper. For user
> > namespace aware filesystem capabilities a root uid is stored alongside the
> > capabilities.
> > In order to determine whether the caller can make use of the filesystem
> > capability or whether it needs to be ignored it is translated according to
> > the superblock's user namespace. If it can be translated to uid 0 according
> > to that id mapping the caller can use the filesystem capabilities stored on
> > disk. If we are accessing the inode that holds the filesystem capabilities
> > through an idmapped mount we need to map the root uid according to the
> > mount's user namespace.
> > Afterwards the checks are identical to non-idmapped mounts. Reading
> > filesystem caps from disk enforces that the root uid associated with the
> > filesystem capability must have a mapping in the superblock's user
> > namespace and that the caller is either in the same user namespace or is a
> > descendant of the superblock's user namespace. For filesystems that are
> > mountable inside user namespace the container can just mount the filesystem
> > and won't usually need to idmap it. If it does create an idmapped mount it
> > can mark it with a user namespace it has created and which is therefore a
> > descendant of the s_user_ns. For filesystems that are not mountable inside
> > user namespaces the descendant rule is trivially true because the s_user_ns
> > will be the initial user namespace.
> >
> > If the initial user namespace is passed all operations are a nop so
> > non-idmapped mounts will not see a change in behavior and will also not see
> > any performance impact.
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> ...
> 
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 8dba8f0983b5..ddb9213a3e81 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -1944,7 +1944,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
> >         if (!dentry)
> >                 return 0;
> >
> > -       rc = get_vfs_caps_from_disk(dentry, &caps);
> > +       rc = get_vfs_caps_from_disk(&init_user_ns, dentry, &caps);
> >         if (rc)
> >                 return rc;
> >
> > @@ -2495,7 +2495,8 @@ int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
> >         ax->d.next = context->aux;
> >         context->aux = (void *)ax;
> >
> > -       get_vfs_caps_from_disk(bprm->file->f_path.dentry, &vcaps);
> > +       get_vfs_caps_from_disk(mnt_user_ns(bprm->file->f_path.mnt),
> > +                              bprm->file->f_path.dentry, &vcaps);
> 
> As audit currently records information in the context of the
> initial/host namespace I'm guessing we don't want the mnt_user_ns()
> call above; it seems like &init_user_ns would be the right choice
> (similar to audit_copy_fcaps()), yes?

Ok, sounds good. It also makes the patchset simpler.
Note that I'm currently not on the audit mailing list so this is likely
not going to show up there.

(Fwiw, I responded to you in your other mail too.)

Christian
