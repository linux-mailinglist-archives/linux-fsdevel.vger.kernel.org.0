Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95762D1750
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 18:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgLGRPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 12:15:43 -0500
Received: from verein.lst.de ([213.95.11.211]:42865 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgLGRPm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:15:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7E27C67373; Mon,  7 Dec 2020 18:14:56 +0100 (CET)
Date:   Mon, 7 Dec 2020 18:14:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
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
        selinux@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 06/40] fs: add mount_setattr()
Message-ID: <20201207171456.GC13614@lst.de>
References: <20201203235736.3528991-1-christian.brauner@ubuntu.com> <20201203235736.3528991-7-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203235736.3528991-7-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	switch (attr->propagation) {
> +	case 0:
> +		kattr->propagation = 0;
> +		break;
> +	case MS_UNBINDABLE:
> +		kattr->propagation = MS_UNBINDABLE;
> +		break;
> +	case MS_PRIVATE:
> +		kattr->propagation = MS_PRIVATE;
> +		break;
> +	case MS_SLAVE:
> +		kattr->propagation = MS_SLAVE;
> +		break;
> +	case MS_SHARED:
> +		kattr->propagation = MS_SHARED;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

This can be shortened to:

#define MOUNT_SETATTR_PROPAGATION_FLAGS \
	(MS_UNBINDABLE | MS_PRIVATE | MS_SLAVE | MS_SHARED)

	if (attr->propagation & ~MOUNT_SETATTR_PROPAGATION_FLAGS)
		return -EINVAL;
	if (hweight32(attr->propagation & MOUNT_SETATTR_PROPAGATION_FLAGS) > 1)
		return -EINVAL;
	kattr->propagation = attr->propagation;

> +asmlinkage long sys_mount_setattr(int dfd, const char __user *path, unsigned int flags,

Overly long line.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
