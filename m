Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69802A2B98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 14:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgKBNdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 08:33:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48935 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBNdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:33:38 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kZZxl-0007ym-Lt; Mon, 02 Nov 2020 13:33:33 +0000
Date:   Mon, 2 Nov 2020 14:33:31 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        St??phane Graber <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH 01/34] namespace: take lock_mount_hash() directly when
 changing flags
Message-ID: <20201102133331.66v4hxtmlnjrucnn@wittgenstein>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <20201029003252.2128653-2-christian.brauner@ubuntu.com>
 <20201101144108.GA23378@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201101144108.GA23378@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 01, 2020 at 02:41:08PM +0000, Christoph Hellwig wrote:
> > index cebaa3e81794..20ee291a7af4 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -463,7 +463,6 @@ static int mnt_make_readonly(struct mount *mnt)
> >  {
> >  	int ret = 0;
> >  
> > -	lock_mount_hash();
> 
> What about adding a lockdep_assert_lock_held in all the functions
> that used to take the lock to document the assumptions?

Good idea and will do. I wanted to do this but then didn't because I
haven't seen widespread use of lockdep assert in fs/namespace.c.

> 
> >  static int __mnt_unmake_readonly(struct mount *mnt)
> >  {
> > -	lock_mount_hash();
> >  	mnt->mnt.mnt_flags &= ~MNT_READONLY;
> > -	unlock_mount_hash();
> >  	return 0;
> 
> This helper is rather pointless now.

Ok, will remove.

> 
> >  static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
> >  {
> > -	lock_mount_hash();
> >  	mnt_flags |= mnt->mnt.mnt_flags & ~MNT_USER_SETTABLE_MASK;
> >  	mnt->mnt.mnt_flags = mnt_flags;
> >  	touch_mnt_namespace(mnt->mnt_ns);
> > -	unlock_mount_hash();
> 
> In linux-next there is an additional notify_mount after the unlock here.

Thanks! I can try rebasing on -next.

> 
> Also while you touch this lock_mount_hash/unlock_mount_hash could be
> moved to namespace.c and maked static now.

Ok, will try to do that.
