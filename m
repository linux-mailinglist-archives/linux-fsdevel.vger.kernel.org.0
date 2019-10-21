Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32280DF8B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 01:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfJUXfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 19:35:54 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45091 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728375AbfJUXfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:35:54 -0400
Received: from dread.disaster.area (pa49-180-40-48.pa.nsw.optusnet.com.au [49.180.40.48])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9FD5536257E;
        Tue, 22 Oct 2019 10:35:48 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iMhDH-0007Pw-Rb; Tue, 22 Oct 2019 10:35:47 +1100
Date:   Tue, 22 Oct 2019 10:35:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Subject: Re: [Project Quota]file owner could change its project ID?
Message-ID: <20191021233547.GA2681@dread.disaster.area>
References: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
 <20191013164124.GR13108@magnolia>
 <CAP9B-Q=SfhnA6iO7h1TWAoSOfZ+BvT7d8=OE4176FZ3GXiU-xw@mail.gmail.com>
 <20191016213700.GH13108@magnolia>
 <648712FB-0ECE-41F4-B6B8-98BD3168B2A4@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <648712FB-0ECE-41F4-B6B8-98BD3168B2A4@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=y881pOMu+B+mZdf5UrsJdA==:117 a=y881pOMu+B+mZdf5UrsJdA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=yPCof4ZbAAAA:8 a=7-415B0cAAAA:8 a=qv8hQ-V9GWQyh8rksBYA:9
        a=TxVqjOB1mW4Srn6y:21 a=cwD_f9e2U_YEHh5S:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 06:28:08PM -0600, Andreas Dilger wrote:
> On Oct 16, 2019, at 3:37 PM, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > 
> > On Wed, Oct 16, 2019 at 07:51:15PM +0800, Wang Shilong wrote:
> >> On Mon, Oct 14, 2019 at 12:41 AM Darrick J. Wong
> >> <darrick.wong@oracle.com> wrote:
> >>> 
> >>> On Sat, Oct 12, 2019 at 02:33:36PM +0800, Wang Shilong wrote:
> >>>> Steps to reproduce:
> >>>> [wangsl@localhost tmp]$ mkdir project
> >>>> [wangsl@localhost tmp]$ lsattr -p project -d
> >>>>    0 ------------------ project
> >>>> [wangsl@localhost tmp]$ chattr -p 1 project
> >>>> [wangsl@localhost tmp]$ lsattr -p -d project
> >>>>    1 ------------------ project
> >>>> [wangsl@localhost tmp]$ chattr -p 2 project
> >>>> [wangsl@localhost tmp]$ lsattr -p -d project
> >>>>    2 ------------------ project
> >>>> [wangsl@localhost tmp]$ df -Th .
> >>>> Filesystem     Type  Size  Used Avail Use% Mounted on
> >>>> /dev/sda3      xfs    36G  4.1G   32G  12% /
> >>>> [wangsl@localhost tmp]$ uname -r
> >>>> 5.4.0-rc2+
> >>>> 
> >>>> As above you could see file owner could change project ID of file its self.
> >>>> As my understanding, we could set project ID and inherit attribute to account
> >>>> Directory usage, and implement a similar 'Directory Quota' based on this.
> >>> 
> >>> So the problem here is that the admin sets up a project quota on a
> >>> directory, then non-container users change the project id and thereby
> >>> break quota enforcement?  Dave didn't sound at all enthusiastic, but I'm
> >>> still wondering what exactly you're trying to prevent.
> >> 
> >> Yup, we are trying to prevent no-root users to change their project ID.
> >> As we want to implement 'Directory Quota':
> >> 
> >> If non-root users could change their project ID, they could always try
> >> to change its project ID to steal space when EDQUOT returns.
> >> 
> >> Yup, if mount option could be introduced to make this case work,
> >> that will be nice.
> > 
> > Well then we had better discuss and write down the exact behaviors of
> > this new directory quota feature and how it differs from ye olde project
> > quota.  Here's the existing definition of project quotas in the
> > xfs_quota manpage:
> > 
> >       10.    XFS  supports  the notion of project quota, which can be
> >              used to implement a form of directory tree  quota  (i.e.
> >              to  restrict  a directory tree to only being able to use
> >              up a component of the filesystems  available  space;  or
> >              simply  to  keep  track  of the amount of space used, or
> >              number of inodes, within the tree).
> > 
> > First, we probably ought to add the following to that definition to
> > reflect a few pieces of current reality:
> > 
> > "Processes running inside runtime environments using mapped user or
> > group ids, such as container runtimes, are not allowed to change the
> > project id and project id inheritance flag of inodes."
> > 
> > What do you all think of this starting definition for directory quotas:
> > 
> >       11.    XFS supports the similar notion of directory quota.  The
> > 	      key difference between project and directory quotas is the
> > 	      additional restriction that only a system administrator
> > 	      running outside of a mapped user or group id runtime
> > 	      environment (such as a container runtime) can change the
> > 	      project id and project id inheritenace flag.  This means
> > 	      that unprivileged users are never allowed to manage their
> >              own directory quotas.
> > 
> > We'd probably enable this with a new 'dirquota' mount option that is
> > mutually exclusive with the old 'prjquota' option.
> 
> I don't think that this is really "directory quotas" in the end, since it
> isn't changing the semantics that the same projid could exist in multiple
> directory trees.


The quota ID associated with a directory is an admin choice - admins
are free to have multiple directories use the same quota ID if
that's how they want to control usage across those directories.

i.e. "directory quota" does not mean "quota IDs must be unique for
different directory heirarchies", it just means quota IDs are
assigned to new directory entries based on the current directory
quota ID.

> The real difference is the ability to enforce existing
> project quota limits for regular users outside of a container.  Basically,
> it is the same as regular users not being able to change the UID of their
> files to dump quota to some other user.

No, no it isn't - project IDs are not user IDs. In fact, UIDs and
permission bits are used to determine if the user has permission to
change the project ID of the file. i.e. anyone who can write data to
the file can change the project ID and "dump quota to some other
user".

That's the way it's always worked, and there are many users out
there that rely on users setting project quotas correctly for their
data sets. i.e. the default project quota is set up as a directory
quota and they are set low to force people creating large data sets
account them to the project that the space is being used for.

IOWs, directory-based project quotas and project-based project quotas
are often used in the same filesystem, and users are expected to
manage them directly.

What is being asked for here is a strict interpretation of directory
quotas to remove the capability of mixing directory and project
based quotas in the one filesystem. That's not the same thing as
an "enforced project quota".

> So rather than rename this "dirquota", it would be better to have a
> an option like "projid_enforce" or "projid_restrict", or maybe some

If only specific admins can change project quotas, then the only way
that project quotas can be used is either:

	1. inherit project ID from parent directory at create time;
	or
	2. admin manually walks newly created files classifying them
	into the correct project after the fact.

#2 is pretty much useless to anyone - who wants to look at thousands
of files a day and classify them to this project or that one? I
haven't seen that admin model in use anywhere in the real world.

Which leaves #1 - default project IDs inherited from the parent
directory, and users can't change them. And that is the very
definition of a strict directory quota...

Quite frankly, people are going to understand what "dirquota" means
and how it behaves intuitively, as opposed to having to understand
what a project quota is, how project IDs work and what the magical
"projid_restrict" mount option does and when you'd want to use it.

They do the same things - one API is easy to understand for users,
the other is a horrible "designed by an engineer to meet a specific
requirement" interface. I know which one I'd prefer as a user...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
