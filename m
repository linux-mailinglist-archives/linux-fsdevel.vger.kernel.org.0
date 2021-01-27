Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC84305304
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 07:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhA0GPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 01:15:07 -0500
Received: from mail.hallyn.com ([178.63.66.53]:60370 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233843AbhA0FwB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 00:52:01 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 55466864; Tue, 26 Jan 2021 23:50:12 -0600 (CST)
Date:   Tue, 26 Jan 2021 23:50:12 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
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
        smbarber@chromium.org, Phil Estes <estesp@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 23/40] exec: handle idmapped mounts
Message-ID: <20210127055012.GA32153@mail.hallyn.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
 <20210121131959.646623-24-christian.brauner@ubuntu.com>
 <875z3l0y56.fsf@x220.int.ebiederm.org>
 <20210125164404.aullgl3vlajgkef3@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125164404.aullgl3vlajgkef3@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 05:44:04PM +0100, Christian Brauner wrote:
> On Mon, Jan 25, 2021 at 10:39:01AM -0600, Eric W. Biederman wrote:
> > Christian Brauner <christian.brauner@ubuntu.com> writes:
> > 
> > > When executing a setuid binary the kernel will verify in bprm_fill_uid()
> > > that the inode has a mapping in the caller's user namespace before
> > > setting the callers uid and gid. Let bprm_fill_uid() handle idmapped
> > > mounts. If the inode is accessed through an idmapped mount it is mapped
> > > according to the mount's user namespace. Afterwards the checks are
> > > identical to non-idmapped mounts. If the initial user namespace is
> > > passed nothing changes so non-idmapped mounts will see identical
> > > behavior as before.
> > 
> > This does not handle the v3 capabilites xattr with embeds a uid.
> > So at least at that level you are missing some critical conversions.
> 
> Thanks for looking. Vfs v3 caps are handled earlier in the series. I'm
> not sure what you're referring to here. There are tests in xfstests that
> verify vfs3 capability behavior.
> 
> Christian

So fwiw I just tested it manually as well.  Scenario:

uid 1000 user ubuntu
uid 1001 user u2
sudo ./mount-idmapped --map-mount b:1000:1001:1 /home/ubuntu/ /mnt
su - u2
  cp /usr/bin/id /mnt/
  unshare -Urm
    setcap cap_setuid=pe /mnt/id
At this point, from init_user_ns,
ubuntu@fscaps:~/mount-idmapped$ /home/u2/rcap /mnt/id
v3, rootid is 1001
ubuntu@fscaps:~/mount-idmapped$ /home/u2/rcap //home/ubuntu/id
v3, rootid is 1000

-serge
