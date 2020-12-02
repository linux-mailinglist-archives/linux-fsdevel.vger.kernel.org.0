Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE832CB950
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 10:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgLBJnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 04:43:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35061 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388033AbgLBJnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:43:08 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kkOeS-0003el-Qf; Wed, 02 Dec 2020 09:42:20 +0000
Date:   Wed, 2 Dec 2020 10:42:18 +0100
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
Message-ID: <20201202094218.ym5zqnulwz6gj6eo@wittgenstein>
References: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
 <20201128213527.2669807-5-christian.brauner@ubuntu.com>
 <20201201104907.GD27730@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201104907.GD27730@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:49:07AM +0100, Christoph Hellwig wrote:

Sorry for not responding to this yesterday. I missed most of your mails
because they have been filtered into a dedicated folder (as they should
be) and I would've looked into that folder but somehow gmail let ~3
mails of you into my general inbox and so I didn't bother...

> Lots of crazy long lines in the patch.  Remember that you should only
> go past 80 lines if it clearly improves readability, and I don't
> think it does anywhere in here.

Weird, I did reformat the patch to the 80 char limit and I have dual
display in vim, meaning I have a visible line at 80 chars and 100 chars
whenever I edit a file. I'll go through it again, thanks!


> 
> > index a7cd0f64faa4..a5a6c470dc07 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -82,6 +82,14 @@ int may_linkat(struct path *link);
> >  /*
> >   * namespace.c
> >   */
> > +struct mount_kattr {
> > +	unsigned int attr_set;
> > +	unsigned int attr_clr;
> > +	unsigned int propagation;
> > +	unsigned int lookup_flags;
> > +	bool recurse;
> > +};
> 
> Even with the whole series applied this structure is only used in
> namespace.c, so it might be worth moving there.

Good point. Will do.

> 
> > +static inline int mnt_hold_writers(struct mount *mnt)
> >  {
> > -	int ret = 0;
> > -
> >  	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
> >  	/*
> >  	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
> > @@ -497,15 +495,29 @@ static int mnt_make_readonly(struct mount *mnt)
> >  	 * we're counting up here.
> >  	 */
> >  	if (mnt_get_writers(mnt) > 0)
> > -		ret = -EBUSY;
> > -	else
> > -		mnt->mnt.mnt_flags |= MNT_READONLY;
> > +		return -EBUSY;
> > +
> > +	return 0;
> > +}
> > +
> > +static inline void mnt_unhold_writers(struct mount *mnt)
> > +{
> >  	/*
> >  	 * MNT_READONLY must become visible before ~MNT_WRITE_HOLD, so writers
> >  	 * that become unheld will see MNT_READONLY.
> >  	 */
> >  	smp_wmb();
> >  	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
> > +}
> > +
> > +static int mnt_make_readonly(struct mount *mnt)
> > +{
> > +	int ret;
> > +
> > +	ret = mnt_hold_writers(mnt);
> > +	if (!ret)
> > +		mnt->mnt.mnt_flags |= MNT_READONLY;
> > +	mnt_unhold_writers(mnt);
> >  	return ret;
> >  }
> >  
> > @@ -3438,6 +3450,33 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
> >  	return ret;
> >  }
> 
> This refactoring seems worth a little prep patch.

Will split into separate patch.

> 
> >  
> > +static int build_attr_flags(unsigned int attr_flags, unsigned int *flags)
> > +{
> > +	unsigned int aflags = 0;
> > +
> > +	if (attr_flags & ~(MOUNT_ATTR_RDONLY |
> > +			   MOUNT_ATTR_NOSUID |
> > +			   MOUNT_ATTR_NODEV |
> > +			   MOUNT_ATTR_NOEXEC |
> > +			   MOUNT_ATTR__ATIME |
> > +			   MOUNT_ATTR_NODIRATIME))
> > +		return -EINVAL;
> > +
> > +	if (attr_flags & MOUNT_ATTR_RDONLY)
> > +		aflags |= MNT_READONLY;
> > +	if (attr_flags & MOUNT_ATTR_NOSUID)
> > +		aflags |= MNT_NOSUID;
> > +	if (attr_flags & MOUNT_ATTR_NODEV)
> > +		aflags |= MNT_NODEV;
> > +	if (attr_flags & MOUNT_ATTR_NOEXEC)
> > +		aflags |= MNT_NOEXEC;
> > +	if (attr_flags & MOUNT_ATTR_NODIRATIME)
> > +		aflags |= MNT_NODIRATIME;
> > +
> > +	*flags = aflags;
> > +	return 0;
> > +}
> 
> Same for adding this helper.

Will do.

> 
> > +	*kattr = (struct mount_kattr){
> 
> Missing whitespace before the {.

Good spot, thank you!

> 
> > +	switch (attr->propagation) {
> > +	case MAKE_PROPAGATION_UNCHANGED:
> > +		kattr->propagation = 0;
> > +		break;
> > +	case MAKE_PROPAGATION_UNBINDABLE:
> > +		kattr->propagation = MS_UNBINDABLE;
> > +		break;
> > +	case MAKE_PROPAGATION_PRIVATE:
> > +		kattr->propagation = MS_PRIVATE;
> > +		break;
> > +	case MAKE_PROPAGATION_DEPENDENT:
> > +		kattr->propagation = MS_SLAVE;
> > +		break;
> > +	case MAKE_PROPAGATION_SHARED:
> > +		kattr->propagation = MS_SHARED;
> > +		break;
> > +	default:
> 
> Any reason to not just reuse the MS_* flags in the new API?  Yes, your
> new names are more descriptive, but having different names for the same
> thing is also rather confusing.

I'm not really married to this so I don't see a reason why not.

> 
> > +	if (upper_32_bits(attr->attr_set))
> > +		return -EINVAL;
> > +	if (build_attr_flags(lower_32_bits(attr->attr_set), &kattr->attr_set))
> > +		return -EINVAL;
> > +
> > +	if (upper_32_bits(attr->attr_clr))
> > +		return -EINVAL;
> > +	if (build_attr_flags(lower_32_bits(attr->attr_clr), &kattr->attr_clr))
> > +		return -EINVAL;
> 
> What is so magic about the upper and lower 32 bits?

Nothing apart from the fact that they arent't currently valid. I can
think about reworking these lines. Or do you already have a preferred
way of doing this in mind?

> 
> > +		return -EINVAL;
> > +	else if ((attr->attr_clr & MOUNT_ATTR__ATIME) &&
> > +		 ((attr->attr_clr & MOUNT_ATTR__ATIME) != MOUNT_ATTR__ATIME))
> > +		return -EINVAL;
> 
> No need for the else here.

Thanks!

> 
> That being said I'd reword the thing to be a little more obvious:
> 
> 	if (attr->attr_clr & MOUNT_ATTR__ATIME) {
> 		if ((attr->attr_clr & MOUNT_ATTR__ATIME) != MOUNT_ATTR__ATIME)
> 			return -EINVAL;
> 
> 		... code doing the update of the atime flags here
> 	} else {
> 		if (attr->attr_set & MOUNT_ATTR__ATIME)
> 			return -EINVAL;
> 	}

Will do.

> 
> 
> > +/* Change propagation through mount_setattr(). */
> > +enum propagation_type {
> > +	MAKE_PROPAGATION_UNCHANGED	= 0, /* Don't change mount propagation (default). */
> > +	MAKE_PROPAGATION_UNBINDABLE	= 1, /* Make unbindable. */
> > +	MAKE_PROPAGATION_PRIVATE	= 2, /* Do not receive or send mount events. */
> > +	MAKE_PROPAGATION_DEPENDENT	= 3, /* Only receive mount events. */
> > +	MAKE_PROPAGATION_SHARED		= 4, /* Send and receive mount events. */
> > +};
> 
> FYI, in uapis using defines instead of enums is usually the better
> choice, as that allows userspace to probe for later added defines.
> 
> But if we use MS_* here that would be void anyway.

Indeed.

> 
> > +/* List of all mount_attr versions. */
> > +#define MOUNT_ATTR_SIZE_VER0	24 /* sizeof first published struct */
> > +#define MOUNT_ATTR_SIZE_LATEST	MOUNT_ATTR_SIZE_VER0
> 
> The _LATEST things is pretty dangerous as there basically is no safe
> and correct way for userspace to use it.

Ok, I'll remove the _LATEST.

Thanks for the review (and sorry again for missing your mails)!

Christian
