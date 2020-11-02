Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513032A2B81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 14:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgKBN3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 08:29:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48786 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKBN3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:29:40 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kZZtu-0007a7-Ep; Mon, 02 Nov 2020 13:29:34 +0000
Date:   Mon, 2 Nov 2020 14:29:32 +0100
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
Subject: Re: [PATCH 05/34] fs: introduce MOUNT_ATTR_IDMAP
Message-ID: <20201102132932.pseijsddvxo5hgpf@wittgenstein>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <20201029003252.2128653-6-christian.brauner@ubuntu.com>
 <20201101144544.GC23378@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201101144544.GC23378@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 01, 2020 at 02:45:44PM +0000, Christoph Hellwig wrote:
> On Thu, Oct 29, 2020 at 01:32:23AM +0100, Christian Brauner wrote:
> > Introduce a new mount bind mount property to allow idmapping mounts. The
> > MOUNT_ATTR_IDMAP flag can be set via the new mount_setattr() syscall
> > together with a file descriptor referring to a user namespace.
> 
> Shouldn't this go to the end of the series once all the infrastructure
> is in place?

Yeah, good idea. (I mostly did it to keep compile-times short when
rebasing.)

> 
> > +config IDMAP_MOUNTS
> > +	bool "Support id mappings per mount"
> > +	default n
> 
> n is the default default.

Ah, thanks.

> 
> But why do we need a config option here anyway?

My main concern was people complaining about code they want to compile
out. I've been burnt by that before but I'm happy to remove the config
option and make this unconditional.

> 
> > +#ifdef CONFIG_IDMAP_MOUNTS
> > +		if (kattr->attr_set & MNT_IDMAPPED) {
> > +			struct user_namespace *user_ns;
> > +			struct vfsmount *vmnt;
> 
> All the code here looks like it should go into a helper.

Will do.

> 
> > +				struct user_namespace *user_ns = READ_ONCE(m->mnt.mnt_user_ns);
> > +				WRITE_ONCE(m->mnt.mnt_user_ns, get_user_ns(kattr->userns));
> 
> More unreadable long lines.

Will wrap. I have somewhat adapted to the more lax 100 limit but I'm
happy to stick to 80.

> 
> > +	if (attr->attr_set & MOUNT_ATTR_IDMAP) {
> > +		struct ns_common *ns;
> > +		struct user_namespace *user_ns;
> > +		struct file *file;
> > +
> > +		file = fget(attr->userns);
> 
> The code here looks like another candidate for a self contained helper.

Noted.

> 
> > +
> > +static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
> > +{
> > +#ifdef CONFIG_IDMAP_MOUNTS
> > +	return READ_ONCE(mnt->mnt_user_ns);
> > +#else
> > +	return &init_user_ns;
> > +#endif
> 
> How is the READ_ONCE on a pointer going to work?

Honestly, this is me following a pattern I've seen in other places and
it's mostly about visually indicating concurrency but I'll drop it.

Christian
