Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EBE32C501
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355109AbhCDASy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:18:54 -0500
Received: from verein.lst.de ([213.95.11.211]:35428 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355863AbhCCHCF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 02:02:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 16AAD68CFC; Wed,  3 Mar 2021 08:01:06 +0100 (CET)
Date:   Wed, 3 Mar 2021 08:01:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
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
Subject: Re: [PATCH v6 39/40] xfs: support idmapped mounts
Message-ID: <20210303070103.GA7866@lst.de>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com> <20210121131959.646623-40-christian.brauner@ubuntu.com> <20210301200520.GK7272@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301200520.GK7272@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 12:05:20PM -0800, Darrick J. Wong wrote:
> > +	if (breq->mnt_userns != &init_user_ns) {
> > +		xfs_warn_ratelimited(breq->mp,
> > +			"bulkstat not supported inside of idmapped mounts.");
> > +		return -EINVAL;
> 
> Shouldn't this be -EPERM?
> 
> Or -EOPNOTSUPP?

-EINVAL is what we return for all our nor suppored ioctls, so I think it
is the right choice here, and should generally trigger the right
fallbacks.

> Also, I'm not sure why bulkstat won't work in an idmapped mount but
> bulkstat_single does?  You can use the singleton version to stat inodes
> that aren't inside the submount.

Looking at it again I think we should fail BULKSTAT_SINGLE as well.
I had somehow assumed BULKSTAT_SINGLE would operate on the inode of
the open file, in which case it would be fine.  But it doesn't so that
argument doesn't count.
