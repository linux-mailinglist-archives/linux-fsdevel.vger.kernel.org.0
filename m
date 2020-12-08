Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146DD2D290D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 11:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgLHKh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 05:37:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38573 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgLHKh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:37:58 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kmaMp-0003ta-EI; Tue, 08 Dec 2020 10:37:11 +0000
Date:   Tue, 8 Dec 2020 11:37:07 +0100
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
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH v4 06/40] fs: add mount_setattr()
Message-ID: <20201208103707.px6buexwuusn6d3f@wittgenstein>
References: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
 <20201203235736.3528991-7-christian.brauner@ubuntu.com>
 <20201207171456.GC13614@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207171456.GC13614@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 06:14:56PM +0100, Christoph Hellwig wrote:
> > +	switch (attr->propagation) {
> > +	case 0:
> > +		kattr->propagation = 0;
> > +		break;
> > +	case MS_UNBINDABLE:
> > +		kattr->propagation = MS_UNBINDABLE;
> > +		break;
> > +	case MS_PRIVATE:
> > +		kattr->propagation = MS_PRIVATE;
> > +		break;
> > +	case MS_SLAVE:
> > +		kattr->propagation = MS_SLAVE;
> > +		break;
> > +	case MS_SHARED:
> > +		kattr->propagation = MS_SHARED;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> 
> This can be shortened to:
> 
> #define MOUNT_SETATTR_PROPAGATION_FLAGS \
> 	(MS_UNBINDABLE | MS_PRIVATE | MS_SLAVE | MS_SHARED)
> 
> 	if (attr->propagation & ~MOUNT_SETATTR_PROPAGATION_FLAGS)
> 		return -EINVAL;
> 	if (hweight32(attr->propagation & MOUNT_SETATTR_PROPAGATION_FLAGS) > 1)
> 		return -EINVAL;
> 	kattr->propagation = attr->propagation;

Looks good! I've applied that.

> 
> > +asmlinkage long sys_mount_setattr(int dfd, const char __user *path, unsigned int flags,
> 
> Overly long line.

Folded after @path now.

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, I've pushed out the changes to:
https://git.kernel.org/brauner/h/idmapped_mounts
the original v4 can now be found at:
https://git.kernel.org/brauner/h/idmapped_mounts_v4

You want a v5 with the changes you requested before you continue
reviewing? Otherwise I'll just let you go through v4.

Thanks!
Christian
