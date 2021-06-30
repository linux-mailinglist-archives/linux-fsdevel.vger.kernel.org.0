Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0E83B8554
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhF3Ouo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 10:50:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48599 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235715AbhF3OuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:50:19 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15UEld0I027764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 10:47:40 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8FD6615C3C8E; Wed, 30 Jun 2021 10:47:39 -0400 (EDT)
Date:   Wed, 30 Jun 2021 10:47:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Daniel Walsh <dwalsh@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
Message-ID: <YNyECw/1FzDCW3G8@mit.edu>
References: <YNn4p+Zn444Sc4V+@work-vm>
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <20210629173530.GD5231@redhat.com>
 <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com>
 <YNvvLIv16jY8mfP8@mit.edu>
 <YNwmXOqT7LgbeVPn@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNwmXOqT7LgbeVPn@work-vm>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 09:07:56AM +0100, Dr. David Alan Gilbert wrote:
> * Theodore Ts'o (tytso@mit.edu) wrote:
> > On Tue, Jun 29, 2021 at 04:28:24PM -0400, Daniel Walsh wrote:
> > > All this conversation is great, and I look forward to a better solution, but
> > > if we go back to the patch, it was to fix an issue where the kernel is
> > > requiring CAP_SYS_ADMIN for writing user Xattrs on link files and other
> > > special files.
> > > 
> > > The documented reason for this is to prevent the users from using XATTRS to
> > > avoid quota.
> > 
> > Huh?  Where is it so documented?
> 
> man xattr(7):
>        The  file permission bits of regular files and directories are
>        interpreted differently from the file permission bits of special
>        files and symbolic links.  For regular files and directories the
>        file permission bits define access to the file's contents,
>        while for device special files they define access to the device
>        described by the special file.  The file permissions of symbolic
>        links are not used in access checks.

All of this is true...

>         *** These differences would
>        allow users to consume filesystem resources in a way not
>        controllable by disk quotas for group or world writable special
>        files and directories.****

Anyone with group write access to a regular file can append to the
file, and the blocks written will be charged the owner of the file.
So it's perfectly "controllable" by the quota system; if you have
group write access to a file, you can charge against the user's quota.
This is Working As Intended.

And the creation of device special files take the umask into account,
just like regular files, so if you have a umask that allows newly
created files to be group writeable, the same issue would occur for
regular files as device files.  Given that most users have a umask of
0077 or 0022, this is generally Not A Problem.

I think I see the issue which drove the above text, though, which is
that Linux's syscall(2) is creating symlinks which do not take umask
into account; that is, the permissions are always mode ST_IFLNK|0777.

Hence, it might be that the right answer is to remove this fairly
arbitrary restriction entirely, and change symlink(2) so that it
creates files which respects the umask.  Posix and SUS doesn't specify
what the permissions are that are used, and historically (before the
advent of xattrs) I suspect since it didn't matter, no one cared about
whether or not umask was applied.

Some people might object to such a change arguing that with
pre-existing file systems where there are symlinks which
world-writeable, this might cause people to be able to charge up to
32k (or whatever the maximum size of the xattr supported by the file
system) for each symlink.  However, (a) very few people actually use
quotas, and this would only be an issue for those users, and (b) the
amount of quota "abuse" that could be carried out this way is small
enough that I'm not sure it matters.

     	    	  	      	  - Ted
