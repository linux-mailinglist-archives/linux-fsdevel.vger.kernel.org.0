Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349122A0AA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 17:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJ3QDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 12:03:36 -0400
Received: from mail.hallyn.com ([178.63.66.53]:57022 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgJ3QDg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:03:36 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 0CBD712C3; Fri, 30 Oct 2020 11:03:32 -0500 (CDT)
Date:   Fri, 30 Oct 2020 11:03:32 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Lennart Poettering <lennart@poettering.net>,
        smbarber@chromium.org, Phil Estes <estesp@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH 00/34] fs: idmapped mounts
Message-ID: <20201030160332.GA30083@mail.hallyn.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <87pn51ghju.fsf@x220.int.ebiederm.org>
 <20201029155148.5odu4j2kt62ahcxq@yavin.dot.cyphar.com>
 <87361xdm4c.fsf@x220.int.ebiederm.org>
 <20201030150748.GA176340@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030150748.GA176340@ubuntu-x1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:07:48AM -0500, Seth Forshee wrote:
> On Thu, Oct 29, 2020 at 11:37:23AM -0500, Eric W. Biederman wrote:
> > First and foremost: A uid shift on write to a filesystem is a security
> > bug waiting to happen.  This is especially in the context of facilities
> > like iouring, that play very agressive games with how process context
> > makes it to  system calls.
> > 
> > The only reason containers were not immediately exploitable when iouring
> > was introduced is because the mechanisms are built so that even if
> > something escapes containment the security properties still apply.
> > Changes to the uid when writing to the filesystem does not have that
> > property.  The tiniest slip in containment will be a security issue.
> > 
> > This is not even the least bit theoretical.  I have seem reports of how
> > shitfs+overlayfs created a situation where anyone could read
> > /etc/shadow.
> 
> This bug was the result of a complex interaction with several
> contributing factors. It's fair to say that one component was overlayfs
> writing through an id-shifted mount, but the primary cause was related
> to how copy-up was done coupled with allowing unprivileged overlayfs
> mounts in a user ns. Checks that the mounter had access to the lower fs
> file were not done before copying data up, and so the file was copied up
> temporarily to the id shifted upperdir. Even though it was immediately
> removed, other factors made it possible for the user to get the file
> contents from the upperdir.
> 
> Regardless, I do think you raise a good point. We need to be wary of any
> place the kernel could open files through a shifted mount, especially
> when the open could be influenced by userspace.
> 
> Perhaps kernel file opens through shifted mounts should to be opt-in.
> I.e. unless a flag is passed, or a different open interface used, the
> open will fail if the dentry being opened is subject to id shifting.
> This way any kernel writes which would be subject to id shifting will
> only happen through code which as been written to take it into account.

For my use cases, it would be fine to require opt-in at original fs
mount time by init_user_ns admin.  I.e.
    mount -o allow_idmap /dev/mapper/whoozit /whatzit
I'm quite certain I would always be sharing a separate LV or loopback or
tmpfs.

-serge
