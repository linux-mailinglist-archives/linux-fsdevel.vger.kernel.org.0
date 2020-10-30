Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0737829FB20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 03:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgJ3CSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 22:18:09 -0400
Received: from mail.hallyn.com ([178.63.66.53]:38118 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgJ3CSJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:18:09 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 027D69B4; Thu, 29 Oct 2020 21:18:05 -0500 (CDT)
Date:   Thu, 29 Oct 2020 21:18:05 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
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
        Seth Forshee <seth.forshee@canonical.com>,
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
Message-ID: <20201030021805.GA20489@mail.hallyn.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <87pn51ghju.fsf@x220.int.ebiederm.org>
 <20201029155148.5odu4j2kt62ahcxq@yavin.dot.cyphar.com>
 <87361xdm4c.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87361xdm4c.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:37:23AM -0500, Eric W. Biederman wrote:
> Aleksa Sarai <cyphar@cyphar.com> writes:
> 
> > On 2020-10-29, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> Christian Brauner <christian.brauner@ubuntu.com> writes:
> >> 
> >> > Hey everyone,
> >> >
> >> > I vanished for a little while to focus on this work here so sorry for
> >> > not being available by mail for a while.
> >> >
> >> > Since quite a long time we have issues with sharing mounts between
> >> > multiple unprivileged containers with different id mappings, sharing a
> >> > rootfs between multiple containers with different id mappings, and also
> >> > sharing regular directories and filesystems between users with different
> >> > uids and gids. The latter use-cases have become even more important with
> >> > the availability and adoption of systemd-homed (cf. [1]) to implement
> >> > portable home directories.
> >> 
> >> Can you walk us through the motivating use case?
> >> 
> >> As of this year's LPC I had the distinct impression that the primary use
> >> case for such a feature was due to the RLIMIT_NPROC problem where two
> >> containers with the same users still wanted different uid mappings to
> >> the disk because the users were conflicting with each other because of
> >> the per user rlimits.
> >> 
> >> Fixing rlimits is straight forward to implement, and easier to manage
> >> for implementations and administrators.
> >
> > This is separate to the question of "isolated user namespaces" and
> > managing different mappings between containers. This patchset is solving
> > the same problem that shiftfs solved -- sharing a single directory tree
> > between containers that have different ID mappings. rlimits (nor any of
> > the other proposals we discussed at LPC) will help with this problem.
> 
> First and foremost: A uid shift on write to a filesystem is a security
> bug waiting to happen.  This is especially in the context of facilities
> like iouring, that play very agressive games with how process context
> makes it to  system calls.
> 
> The only reason containers were not immediately exploitable when iouring
> was introduced is because the mechanisms are built so that even if
> something escapes containment the security properties still apply.
> Changes to the uid when writing to the filesystem does not have that
> property.  The tiniest slip in containment will be a security issue.
> 
> This is not even the least bit theoretical.  I have seem reports of how
> shitfs+overlayfs created a situation where anyone could read
> /etc/shadow.
> 
> If you are going to write using the same uid to disk from different
> containers the question becomes why can't those containers configure
> those users to use the same kuid?

Because if user 'myapp' in two otherwise isolated containers both have
the same kuid, so that they can write to a shared directory, then root
in container 1 has privilege over all files owned by 'myapp' in
container 2.

Whereas if they can each have distinct kuids, but when writing to the
shared fs have a shared uid not otherwise belonging to either container,
their rootfs's can remain completely off limits to each other.

> What fixing rlimits does is it fixes one of the reasons that different
> containers could not share the same kuid for users that want to write to
> disk with the same uid.
> 
> 
> I humbly suggest that it will be more secure, and easier to maintain for
> both developers and users if we fix the reasons people want different
> containers to have the same user running with different kuids.
> 
> If not what are the reasons we fundamentally need the same on-disk user
> using multiple kuids in the kernel?
> 
> Eric
