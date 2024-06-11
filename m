Return-Path: <linux-fsdevel+bounces-21485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B622D9047BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 01:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17DC1C2150B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 23:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D040A155CB8;
	Tue, 11 Jun 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YB+BvVxi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBA680607
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718149234; cv=none; b=fkirbLq5+XZCJg/OGZDJHGoI1lmopV4XDQilFjEcoCpQeZT64qBm6Fc/QaqTOxSfYYZ6gHWIDPhjzUdcd4lHepwCwckuheNaM6F1Fka/Mt1l4PG8kPanmLmwpwXeJFqqODmAntSWRPGzp5Ac1Jo7rMjUKoYvafgyzPVqv1/gW6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718149234; c=relaxed/simple;
	bh=lXJjoQxQwM0CagA/I7BhheE60nGDci7KkytJjqABgx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqdcGJERFodvyhWWFZ7FDTU/FdYUha7CQ9hp28G8F9fL8jAtts++aeKve+R5Hx/MQ9FnWCDkXJ91z9DnuV4OqErSFEls3Va1gJKSMk4xQpd8NcXJt1d7vnIHf7QaUrzrS2klsNb75eXELO6q3kGq+VJ+/zkQVZBgjoKcmQwRU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YB+BvVxi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70413de08c7so1423562b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 16:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1718149231; x=1718754031; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bmfQ4V5qESST45huT2e5Wix3SiAuLXavEEJJgw9zn7I=;
        b=YB+BvVxiFVuPlc0g+5smKDAmbnleCnqjoLp2zTZtgnzhXscMQYJfM8iVTmZRK7fjoA
         wnWm/kyV4WKT9OaeNnpl/hqYDfDvNJw43mk7QChvH25PVv1l/4qkbdZzHmUPim5akhRq
         /5xjguoOHS4DSma8JoOFxQ3v+4o24fzb4PUYvY62FPe7jy9D4mfEOBBN1ZODHvCYaSkn
         KHcFpCWzrJ8Y4w2Z6g4t7Wgfc6ALuC4MRwmT4dSDus4bmrE5fGvCX8ULaSq8XIfQouJJ
         WHOK77qCFHqZi0dJ/GXRpsre2fqhWxt72kEHlBXZynT803bFCWfE8xLra3V3rgyup/yJ
         9wPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718149231; x=1718754031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmfQ4V5qESST45huT2e5Wix3SiAuLXavEEJJgw9zn7I=;
        b=nj4JYPGRSaWYenE1hSraZsbItAkxAjXP6a5ea1V4uk2sqGNLD0vMMcJrxeMwNRZ3tD
         x8UQ7DxwQsRnU4x+9tMuB/DCCV5JEsr3bq94Bec5k/LzIi2/V3Q615RzmbaDMhzFegiL
         MyZmHhsVMUP+XrQaz6pMrPadszldO1AeusONThkll39uklGCqGIHgGQORvN13z+BsS7L
         b615xzKxVXDCxKv6NItRKmR0q+R4XHGdBSYx9UvRTH9xgXi11D7tFnyrMbS4u+60ldPg
         Fm7JQmeN2vj//tRwl2NuB3WEwkuJArw8TlXWlYOJVjHgn+u6zlRWc5BvoIi9gq9Y0JJB
         fN8w==
X-Forwarded-Encrypted: i=1; AJvYcCURB1oueWv3fAD7v/FBugMOFj5s/9/72ULCX2gRTHcHaEdqG4DqC/6o/H6uYgPUup/WI9J8deri5nSKqroaKy5MxhAu3UU2bHvryht/Dg==
X-Gm-Message-State: AOJu0Yxh8YtftV5qdsrpgxR04TzwXUNFV2j9E5D5eeacpMao14gxR4vV
	nOjXeEYX8f27FOfxdYEcpPYBuM3xbP+YVmWnz88eMuctS0OPvTumzyi38pnq4OE=
X-Google-Smtp-Source: AGHT+IE0beWjaBckKwkRudbsv9PKilm/n4WqwtIqNQbLHRQIiGxBGtF5NJGAyxyE4lEZ9VYieJYt3g==
X-Received: by 2002:a05:6a00:1816:b0:705:a781:9893 with SMTP id d2e1a72fcca58-705bcea84c3mr410783b3a.28.1718149231227;
        Tue, 11 Jun 2024 16:40:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705acc13cfdsm1947923b3a.23.2024.06.11.16.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 16:40:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sHB6K-00CiJ4-0J;
	Wed, 12 Jun 2024 09:40:28 +1000
Date: Wed, 12 Jun 2024 09:40:28 +1000
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <ZmjgbJcjQeejYeOB@dread.disaster.area>
References: <20240524161101.yyqacjob42qjcbnb@quack3>
 <20240531145204.GJ52987@frogsfrogsfrogs>
 <20240603104259.gii7lfz2fg7lyrcw@quack3>
 <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs>
 <20240604085843.q6qtmtitgefioj5m@quack3>
 <20240605003756.GH52987@frogsfrogsfrogs>
 <CAOQ4uxiVVL+9DEn9iJuWRixVNFKJchJHBB8otH8PjuC+j8ii4g@mail.gmail.com>
 <ZmEemh4++vMEwLNg@dread.disaster.area>
 <CAOQ4uxgV5V0TmbZk1vqn=bYfSsdLofDRKvBT4O60zU+jXo0YMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgV5V0TmbZk1vqn=bYfSsdLofDRKvBT4O60zU+jXo0YMQ@mail.gmail.com>

On Fri, Jun 07, 2024 at 09:17:34AM +0300, Amir Goldstein wrote:
> On Thu, Jun 6, 2024 at 5:27 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Jun 05, 2024 at 08:13:15AM +0300, Amir Goldstein wrote:
> > > On Wed, Jun 5, 2024 at 3:38 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > On Tue, Jun 04, 2024 at 10:58:43AM +0200, Jan Kara wrote:
> > > > > On Mon 03-06-24 10:42:59, Darrick J. Wong wrote:
> > > > > > I do -- allowing unpriviledged users to create symlinks that consume
> > > > > > icount (and possibly bcount) in the root project breaks the entire
> > > > > > enforcement mechanism.  That's not the way that project quota has worked
> > > > > > on xfs and it would be quite rude to nullify the PROJINHERIT flag bit
> > > > > > only for these special cases.
> > > > >
> > > > > OK, fair enough. I though someone will hate this. I'd just like to
> > > > > understand one thing: Owner of the inode can change the project ID to 0
> > > > > anyway so project quotas are more like a cooperative space tracking scheme
> > > > > anyway. If you want to escape it, you can. So what are you exactly worried
> > > > > about? Is it the container usecase where from within the user namespace you
> > > > > cannot change project IDs?
> > > >
> > > > Yep.
> > > >
> > > > > Anyway I just wanted to have an explicit decision that the simple solution
> > > > > is not good enough before we go the more complex route ;).
> > > >
> > > > Also, every now and then someone comes along and half-proposes making it
> > > > so that non-root cannot change project ids anymore.  Maybe some day that
> > > > will succeed.
> > > >
> > >
> > > I'd just like to point out that the purpose of the project quotas feature
> > > as I understand it, is to apply quotas to subtrees, where container storage
> > > is a very common private case of project subtree.
> >
> > That is the most modern use case, yes.
> >
> > [ And for a walk down history lane.... ]
> >
> > > The purpose is NOT to create a "project" of random files in random
> > > paths.
> >
> > This is *exactly* the original use case that project quotas were
> > designed for back on Irix in the early 1990s and is the original
> > behaviour project quotas brought to Linux.
> >
> > Project quota inheritance didn't come along until 2005:
> >
> > commit 65f1866a3a8e512d43795c116bfef262e703b789
> > Author: Nathan Scott <nathans@sgi.com>
> > Date:   Fri Jun 3 06:04:22 2005 +0000
> >
> >     Add support for project quota inheritance, a merge of Glens changes.
> >     Merge of xfs-linux-melb:xfs-kern:22806a by kenmcd.
> >
> > And full support for directory tree quotas using project IDs wasn't
> > fully introduced until a year later in 2006:
> >
> > commit 4aef4de4d04bcc36a1461c100eb940c162fd5ee6
> > Author: Nathan Scott <nathans@sgi.com>
> > Date:   Tue May 30 15:54:53 2006 +0000
> >
> >     statvfs component of directory/project quota support, code originally by Glen.
> >     Merge of xfs-linux-melb:xfs-kern:26105a by kenmcd.
> >
> > These changes were largely done for an SGI NAS product that allowed
> > us to create one great big XFS filesystem and then create
> > arbitrarily sized, thin provisoned  "NFS volumes"  as directory
> > quota controlled subdirs instantenously. The directory tree quota
> > defined the size of the volume, and so we could also grow and shrink
> > them instantenously, too. And we could remove them instantenously
> > via background garbage collection after the export was removed and
> > the user had been told it had been destroyed.
> >
> > So that was the original use case for directory tree quotas on XFS -
> > providing scalable, fast management of "thin" storage for a NAS
> > product. Projects quotas had been used for accounting random
> > colections of files for over a decade before this directory quota
> > construct was created, and the "modern" container use cases for
> > directory quotas didn't come along until almost a decade after this
> > capability was added.
> >
> 
> Cool. Didn't know all of this.
> Lucky for us, those historic use cases are well distinguished from
> the modern subtree use case by the opt-in PROJINHERIT bit.
> So as long as PROJINHERIT is set, my assumptions mostly hold(?)

I'm not sure what assumptions you are making, so I can't really
make any binding statement on this except to say that the existance
of PROJINHERIT on directories does not mean strict directory quotas
are being used.

i.e.  PROJINHERIT is just a flag to automatically tag inodes with
aproject ID on creation. It -can- be used as a directory tree quota
if specific restrictions in the use of the projinherit flag are
enforced, but it can also be used for the original project ID use
case so users don't have to manually tag files they create or move
to a projet directory with the right project ID after the fact.

IOWs, directories that have the same projid and PROJINHERIT set
do not need to be in a single hierarchy, and hence  do not fit the
definition of a directory tree quota. e.g:

/projects/docs/project1
/projects/docs/project2
/projects/docs/project3
/projects/src/project1
/projects/src/project2
/projects/src/project3
/projects/build/project1
/projects/build/project2
/projects/build/project3
.....
/home/user1/project1
/home/user2/project3
/home/user6/project2

Now we have multiple different disjoint directory heirarchies with
the same project ID because they contain files belonging to a
specific project. This is still a random collection of files in
random paths that are accounted to a project ID, but it's also using
PROJINHERIT to assign the default project ID to files created in the
respective project directories.

The kernel has no idea that a project ID is associated with a single
directory tree. The kernel quota accounting itself simple sees
project IDs on inodes and accounts to that project ID. The create
and rename code simply see the parent PROJINHERIT bit and so need to
set up the new directory entry to be accounted to that different
project ID. It's all just mechanism in the kernel - applying project
quotas to enforce directory tree quotas is entirely a userspace
administration constraint....

The only thing we do to help userspace administration is restrict
changing project IDs to the init namespace, thereby preventing
containers from being able to manipulate project IDs. This allows
the init namespace to set the policy for project quota use and hence
allow it to be used for directory tree quotas for container space
management. This is essentially an extension of the original NAS
use case, in that NFS exports were the isolation barrier that hid
the underlying filesystem structure and project ID quota usage
from the end users....

> > > My point is that changing the project id of a non-dir child to be different
> > > from the project id of its parent is a pretty rare use case (I think?).
> >
> > Not if you are using project quotas as they were originally intended
> > to be used.
> >
> 
> Rephrase then:
> 
> Changing the projid of a non-dir child to be different from the projid
> of its parent, which has PROJINHERIT bit set, is a pretty rare use case(?)

I have no data to indicate how rare it might be - the kernel has
never enforced a policy that disallows changing project IDs when
PROJINHERIT is set and any user with write permission can change
project IDs even when PROJINHERIT is set. Hence we have to assume
that there are people out there that rely on this behaviour,
regardless of how rare it is...

> > > If changing the projid of non-dir is needed for moving it to a
> > > different subtree,
> > > we could allow renameat2(2) of non-dir with no hardlinks to implicitly
> > > change its
> > > inherited project id or explicitly with a flag for a hardlink, e.g.:
> > > renameat2(olddirfd, name, newdirfd, name, RENAME_NEW_PROJID).
> >
> > Why?
> >
> > The only reason XFS returns -EXDEV to rename across project IDs is
> > because nobody wanted to spend the time to work out how to do the
> > quota accounting of the metadata changed in the rename operation
> > accurately. So for that rare case (not something that would happen
> > on the NAS product) we returned -EXDEV to trigger the mv command to
> > copy the file to the destination and then unlink the source instead,
> > thereby handling all the quota accounting correctly.
> >
> > IOWs, this whole "-EXDEV on rename across parent project quota
> > boundaries" is an implementation detail and nothing more.
> > Filesystems that implement project quotas and the directory tree
> > sub-variant don't need to behave like this if they can accurately
> > account for the quota ID changes during an atomic rename operation.
> > If that's too hard, then the fallback is to return -EXDEV and let
> > userspace do it the slow way which will always acocunt the resource
> > usage correctly to the individual projects.
> >
> > Hence I think we should just fix the XFS kernel behaviour to do the
> > right thing in this special file case rather than return -EXDEV and
> > then forget about the rest of it. Sure, update xfs_repair to fix the
> > special file project id issue if it trips over it, but other than
> > that I don't think we need anything more. If fixing it requires new
> > syscalls and tools, then that's much harder to backport to old
> > kernels and distros than just backporting a couple of small XFS
> > kernel patches...
> >
> 
> I assume that by "fix the XFS behavior" you mean
> "we could allow renameat2(2) of non-dir with no hardlinks to implicitly
>  change its inherited project id"?
> (in case the new parent has the PROJINHERIT bit)
> so that the RENAME_NEW_PROJID behavior would be implicit.

No, I meant "fix the original hardlink of an inode with no project ID
within a PROJINHERIT directory always gets -EXDEV" by allowing
hard links when the source file has no project ID specified.

Actually, looking at 6.10-rc3, this has been merged already. So IMO
there's nothing more we need to do here.

> Unlike rename() from one parent to the other, link()+unlink()
> is less obvious.
>
> The "modern" use cases that I listed where implicit change of projid
> does not suffice are:
> 
> 1. Share some inodes (as hardlinks) among projects
> 2. Recursively changing a subtree projid
>
> They could be implemented by explicit flags to renameat2()/linkat() and
> they could be implemented by [gs]etfsxattrat(2) syscalls.

What are you expecting to happen when you hardlink an inode across
multiple PROJINHERIT directories?  I mean, an inode can only have
one project ID, so you can't link it into mulitple projects at once
if you are using PROJINHERIT (xfs_link() expressly forbids it).

So I'm really not sure what problem you are trying to describe or
solve here. Can you elaborate more?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

