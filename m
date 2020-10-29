Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028B429F190
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 17:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgJ2QaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 12:30:01 -0400
Received: from mail.hallyn.com ([178.63.66.53]:32858 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgJ2QaA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:30:00 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Oct 2020 12:29:57 EDT
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id C24CF11F1; Thu, 29 Oct 2020 11:23:17 -0500 (CDT)
Date:   Thu, 29 Oct 2020 11:23:17 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Miklos Szeredi <miklos@szeredi.hu>, smbarber@chromium.org,
        Christoph Hellwig <hch@infradead.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-ext4@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        selinux@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        David Howells <dhowells@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Theodore Tso <tytso@mit.edu>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        containers@lists.linux-foundation.org,
        Jonathan Corbet <corbet@lwn.net>,
        linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alban Crequy <alban@kinvolk.io>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 00/34] fs: idmapped mounts
Message-ID: <20201029162317.GA12461@mail.hallyn.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <87pn51ghju.fsf@x220.int.ebiederm.org>
 <20201029161231.GA108315@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029161231.GA108315@cisco>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:12:31AM -0600, Tycho Andersen wrote:
> Hi Eric,
> 
> On Thu, Oct 29, 2020 at 10:47:49AM -0500, Eric W. Biederman wrote:
> > Christian Brauner <christian.brauner@ubuntu.com> writes:
> > 
> > > Hey everyone,
> > >
> > > I vanished for a little while to focus on this work here so sorry for
> > > not being available by mail for a while.
> > >
> > > Since quite a long time we have issues with sharing mounts between
> > > multiple unprivileged containers with different id mappings, sharing a
> > > rootfs between multiple containers with different id mappings, and also
> > > sharing regular directories and filesystems between users with different
> > > uids and gids. The latter use-cases have become even more important with
> > > the availability and adoption of systemd-homed (cf. [1]) to implement
> > > portable home directories.
> > 
> > Can you walk us through the motivating use case?
> > 
> > As of this year's LPC I had the distinct impression that the primary use
> > case for such a feature was due to the RLIMIT_NPROC problem where two
> > containers with the same users still wanted different uid mappings to
> > the disk because the users were conflicting with each other because of
> > the per user rlimits.
> > 
> > Fixing rlimits is straight forward to implement, and easier to manage
> > for implementations and administrators.
> 
> Our use case is to have the same directory exposed to several
> different containers which each have disjoint ID mappings.
> 
> > Reading up on systemd-homed it appears to be a way to have encrypted
> > home directories.  Those home directories can either be encrypted at the
> > fs or at the block level.  Those home directories appear to have the
> > goal of being luggable between systems.  If the systems in question
> > don't have common administration of uids and gids after lugging your
> > encrypted home directory to another system chowning the files is
> > required.
> > 
> > Is that the use case you are looking at removing the need for
> > systemd-homed to avoid chowning after lugging encrypted home directories
> > from one system to another?  Why would it be desirable to avoid the
> > chown?
> 
> Not just systemd-homed, but LXD has to do this, as does our
> application at Cisco, and presumably others.
> 
> Several reasons:
> 
> * the chown is slow
> * the chown requires somewhere to write the delta in metadata (e.g. an
>   overlay workdir, or an LV or something), and there are N copies of
>   this delta, one for each container.
> * it means we need to have a +w filesystem at some point during
>   execution.
> * it's ugly :). Conceptually, the kernel solves the uid shifting
>   problem for us for most other kernel subsystems (including in a
>   limited way fscaps) by configuring a user namespace. It feels like
>   we should be able to do the same with the VFS.

And chown prevents the same inode from being shared by different
containers through different id mappings.  You can overlay, but then
they can't actually share updates.

-serge
