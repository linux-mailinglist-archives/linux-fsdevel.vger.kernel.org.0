Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414CA2FD075
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 13:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389872AbhATMj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 07:39:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43216 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbhATM2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:28:51 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2CCh-0006rZ-My; Wed, 20 Jan 2021 12:03:15 +0000
Date:   Wed, 20 Jan 2021 13:03:10 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
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
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Barber <smbarber@chromium.org>,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-xfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 15/42] fs: add file_user_ns() helper
Message-ID: <20210120120310.6tczonwl3rdtnyu3@wittgenstein>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210112220124.837960-16-christian.brauner@ubuntu.com>
 <CAG48ez3Ccr77+zH56YGimESf9jdy_xnQrebypn1TXEP3Q+xw=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez3Ccr77+zH56YGimESf9jdy_xnQrebypn1TXEP3Q+xw=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 04:05:00PM +0100, Jann Horn wrote:
> On Wed, Jan 13, 2021 at 1:52 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > Add a simple helper to retrieve the user namespace associated with the
> > vfsmount of a file. Christoph correctly points out that this makes
> > codepaths (e.g. ioctls) way easier to follow that would otherwise
> > dereference via mnt_user_ns(file->f_path.mnt).
> >
> > In order to make file_user_ns() static inline we'd need to include
> > mount.h in either file.h or fs.h which seems undesirable so let's simply
> > not force file_user_ns() to be inline.
> [...]
> > +struct user_namespace *file_user_ns(struct file *file)
> > +{
> > +       return mnt_user_ns(file->f_path.mnt);
> > +}
> 
> That name is confusing to me, because when I think of "the userns of a
> file", it's file->f_cred->user_ns. There are a bunch of places that
> look at that, as you can see from grepping for "f_cred->user_ns".
> 
> If you really want this to be a separate helper, can you maybe give it
> a clearer name? file_mnt_user_ns(), or something like that, idk.

Done.
