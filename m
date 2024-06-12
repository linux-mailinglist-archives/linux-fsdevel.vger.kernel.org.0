Return-Path: <linux-fsdevel+bounces-21522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B302905157
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 13:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D9E9B22970
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 11:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDC616F0ED;
	Wed, 12 Jun 2024 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5R1ehBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F116F0D6;
	Wed, 12 Jun 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718191464; cv=none; b=afNozXTgV1YrqYX2MN8+Rt24r8y4m+oEyXPsWu3awEhUcYO2P3UfzUWRqZFTW6DISy2KBLh7vUlYRl/cW8A6cLzH/lqENmSCzVFoXNqsG/Re2/UVuUEppG0HMbNHPxivcC8MkWhonWNdFZ2ZS1ShmW1qdXAZBIB0hNnSMVkrXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718191464; c=relaxed/simple;
	bh=t3t5MWO0ICuW3sXXD04RvPPdmQ+TjJEAKo3O2TyNJJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNYFkA0zevda9i046ZAwwbz5L/+jhdpOQWoS9OMQmzzRHS+ohloRdVZlQB2T7OSrc3pn60GFfbGN5ZH0WNcBtlD3LDfvIzbUP7sHRAq0+oyhKZbpoM/szTcOHmH6l6HnZKH4AoEnqzLzY3m7ZkyBkPUSHXw83zN1d3HUYIsC0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5R1ehBD; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7955dc86cacso196553285a.0;
        Wed, 12 Jun 2024 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718191461; x=1718796261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZrOsFWvan+NvZizFQf+yZHV16x+sb5kT5yYbhjfnOQ=;
        b=U5R1ehBDAKDFoJpxHfSaMKCzdQ+2YsAjgvHdfiiA2SPYJPhqbIjaQLUWcwLOnMijrM
         my6wiL2SZ3M6fq/K/7L37fhdOtN7t6gPVgnJi19iUfgb/ML8MtNZTkTNypb7+KoAFauv
         zu3rJAvJq0GJeoPc9MuvlKsXA8JB4eUB0kdwb6CkOZnzBLVxmWjN6aQpQ411i7Ytj0Se
         7TtW+dmtFenGBcygEMEmmOey+3nlHdK+KSbTCpMQtIJDBubjMozphcLwZZhkfHAcu0N6
         gVtCJlL92yr/9rcj++aoNLLnytndA4jt1xxBWrOJRPc2rMGDrEuCUDrD8FZYEWuSQi7H
         LEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718191461; x=1718796261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZrOsFWvan+NvZizFQf+yZHV16x+sb5kT5yYbhjfnOQ=;
        b=CZOZK9zSp6x5aWhHadjLXpDeD37PAObpDGhRlXmb1CeZsEJDvt4XDRueUPyPpX7IBU
         ASZtxtWwbGhf9VRqw2LqLPRGMphR69CD3VtlhSl/ME8vhaChkHjtVLhgkPOyy944WuEQ
         B80e40WI36ox+bySZ+uZpiTNUW2hpJ8/75X2e6eZu5ibY+6jtpgFDZqCOECNzZKU40ga
         IWNJBl0lp+JiqZapsf8a9MXo2XpbL9Lm89VNsbftFc0Xk/RvlMvBtKtzaCjuXFP1hq8K
         6IJnWDOFP5mc5p07Rwni8Cey5y0YYQEPO+ajhMidyF8M03HVu6Vtkz+DfBKm5cCCzZE9
         Bztw==
X-Forwarded-Encrypted: i=1; AJvYcCXhZEVHgC8Mp6jZO9n09ysnZGSmEORfBOzZmA7RxDLOWspvgzpNEXDbIovAycJrfSSTAX770YMjJu1fOzmUxbUdOwO2lgfjB+j5kO/6u5owCyKoCnmd1HFVbThdgxzzRrjbd56gR6yuPQ==
X-Gm-Message-State: AOJu0YxaOPxwXzFiGYVxCycO4tL2CgDKC4Mh5EWsN+Lk0X4sg9qzddEA
	/QDadwt8Ci95u0zX/WR1ABdQdxkz/4njeMscsGp3fDtqGvPbi+I5ON0fpDqeP+MPtNeWvvpP/x5
	NDrTrD8PKu0qXlK1abS+saUvwOdMPzshW
X-Google-Smtp-Source: AGHT+IGQRVErb2rjwPFlzC31ejyEigK7eBe7AJ19lYcEqH4+w0FNe7hOBHTv9OnvJblszjcjRW2keQqqEzZUjy09N8w=
X-Received: by 2002:a05:6214:33c2:b0:6b0:91a4:ecdf with SMTP id
 6a1803df08f44-6b1a6d4d875mr18338976d6.42.1718191461132; Wed, 12 Jun 2024
 04:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524161101.yyqacjob42qjcbnb@quack3> <20240531145204.GJ52987@frogsfrogsfrogs>
 <20240603104259.gii7lfz2fg7lyrcw@quack3> <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs> <20240604085843.q6qtmtitgefioj5m@quack3>
 <20240605003756.GH52987@frogsfrogsfrogs> <CAOQ4uxiVVL+9DEn9iJuWRixVNFKJchJHBB8otH8PjuC+j8ii4g@mail.gmail.com>
 <ZmEemh4++vMEwLNg@dread.disaster.area> <CAOQ4uxgV5V0TmbZk1vqn=bYfSsdLofDRKvBT4O60zU+jXo0YMQ@mail.gmail.com>
 <ZmjgbJcjQeejYeOB@dread.disaster.area>
In-Reply-To: <ZmjgbJcjQeejYeOB@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 12 Jun 2024 14:24:09 +0300
Message-ID: <CAOQ4uxizWXnnHszVCrh=5DscdA3_GzGztJaruZ-ocNTdubNQhA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and FS_IOC_FSGETXATTRAT
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrey Albershteyn <aalbersh@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:40=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Fri, Jun 07, 2024 at 09:17:34AM +0300, Amir Goldstein wrote:
> > On Thu, Jun 6, 2024 at 5:27=E2=80=AFAM Dave Chinner <david@fromorbit.co=
m> wrote:
> > >
> > > On Wed, Jun 05, 2024 at 08:13:15AM +0300, Amir Goldstein wrote:
> > > > On Wed, Jun 5, 2024 at 3:38=E2=80=AFAM Darrick J. Wong <djwong@kern=
el.org> wrote:
> > > > > On Tue, Jun 04, 2024 at 10:58:43AM +0200, Jan Kara wrote:
> > > > > > On Mon 03-06-24 10:42:59, Darrick J. Wong wrote:
> > > > > > > I do -- allowing unpriviledged users to create symlinks that =
consume
> > > > > > > icount (and possibly bcount) in the root project breaks the e=
ntire
> > > > > > > enforcement mechanism.  That's not the way that project quota=
 has worked
> > > > > > > on xfs and it would be quite rude to nullify the PROJINHERIT =
flag bit
> > > > > > > only for these special cases.
> > > > > >
> > > > > > OK, fair enough. I though someone will hate this. I'd just like=
 to
> > > > > > understand one thing: Owner of the inode can change the project=
 ID to 0
> > > > > > anyway so project quotas are more like a cooperative space trac=
king scheme
> > > > > > anyway. If you want to escape it, you can. So what are you exac=
tly worried
> > > > > > about? Is it the container usecase where from within the user n=
amespace you
> > > > > > cannot change project IDs?
> > > > >
> > > > > Yep.
> > > > >
> > > > > > Anyway I just wanted to have an explicit decision that the simp=
le solution
> > > > > > is not good enough before we go the more complex route ;).
> > > > >
> > > > > Also, every now and then someone comes along and half-proposes ma=
king it
> > > > > so that non-root cannot change project ids anymore.  Maybe some d=
ay that
> > > > > will succeed.
> > > > >
> > > >
> > > > I'd just like to point out that the purpose of the project quotas f=
eature
> > > > as I understand it, is to apply quotas to subtrees, where container=
 storage
> > > > is a very common private case of project subtree.
> > >
> > > That is the most modern use case, yes.
> > >
> > > [ And for a walk down history lane.... ]
> > >
> > > > The purpose is NOT to create a "project" of random files in random
> > > > paths.
> > >
> > > This is *exactly* the original use case that project quotas were
> > > designed for back on Irix in the early 1990s and is the original
> > > behaviour project quotas brought to Linux.
> > >
> > > Project quota inheritance didn't come along until 2005:
> > >
> > > commit 65f1866a3a8e512d43795c116bfef262e703b789
> > > Author: Nathan Scott <nathans@sgi.com>
> > > Date:   Fri Jun 3 06:04:22 2005 +0000
> > >
> > >     Add support for project quota inheritance, a merge of Glens chang=
es.
> > >     Merge of xfs-linux-melb:xfs-kern:22806a by kenmcd.
> > >
> > > And full support for directory tree quotas using project IDs wasn't
> > > fully introduced until a year later in 2006:
> > >
> > > commit 4aef4de4d04bcc36a1461c100eb940c162fd5ee6
> > > Author: Nathan Scott <nathans@sgi.com>
> > > Date:   Tue May 30 15:54:53 2006 +0000
> > >
> > >     statvfs component of directory/project quota support, code origin=
ally by Glen.
> > >     Merge of xfs-linux-melb:xfs-kern:26105a by kenmcd.
> > >
> > > These changes were largely done for an SGI NAS product that allowed
> > > us to create one great big XFS filesystem and then create
> > > arbitrarily sized, thin provisoned  "NFS volumes"  as directory
> > > quota controlled subdirs instantenously. The directory tree quota
> > > defined the size of the volume, and so we could also grow and shrink
> > > them instantenously, too. And we could remove them instantenously
> > > via background garbage collection after the export was removed and
> > > the user had been told it had been destroyed.
> > >
> > > So that was the original use case for directory tree quotas on XFS -
> > > providing scalable, fast management of "thin" storage for a NAS
> > > product. Projects quotas had been used for accounting random
> > > colections of files for over a decade before this directory quota
> > > construct was created, and the "modern" container use cases for
> > > directory quotas didn't come along until almost a decade after this
> > > capability was added.
> > >
> >
> > Cool. Didn't know all of this.
> > Lucky for us, those historic use cases are well distinguished from
> > the modern subtree use case by the opt-in PROJINHERIT bit.
> > So as long as PROJINHERIT is set, my assumptions mostly hold(?)
>
> I'm not sure what assumptions you are making, so I can't really
> make any binding statement on this except to say that the existance
> of PROJINHERIT on directories does not mean strict directory quotas
> are being used.
>
> i.e.  PROJINHERIT is just a flag to automatically tag inodes with
> aproject ID on creation. It -can- be used as a directory tree quota
> if specific restrictions in the use of the projinherit flag are
> enforced, but it can also be used for the original project ID use
> case so users don't have to manually tag files they create or move
> to a projet directory with the right project ID after the fact.
>
> IOWs, directories that have the same projid and PROJINHERIT set
> do not need to be in a single hierarchy, and hence  do not fit the
> definition of a directory tree quota. e.g:
>
> /projects/docs/project1
> /projects/docs/project2
> /projects/docs/project3
> /projects/src/project1
> /projects/src/project2
> /projects/src/project3
> /projects/build/project1
> /projects/build/project2
> /projects/build/project3
> .....
> /home/user1/project1
> /home/user2/project3
> /home/user6/project2
>
> Now we have multiple different disjoint directory heirarchies with
> the same project ID because they contain files belonging to a
> specific project. This is still a random collection of files in
> random paths that are accounted to a project ID, but it's also using
> PROJINHERIT to assign the default project ID to files created in the
> respective project directories.
>
> The kernel has no idea that a project ID is associated with a single
> directory tree. The kernel quota accounting itself simple sees
> project IDs on inodes and accounts to that project ID. The create
> and rename code simply see the parent PROJINHERIT bit and so need to
> set up the new directory entry to be accounted to that different
> project ID. It's all just mechanism in the kernel - applying project
> quotas to enforce directory tree quotas is entirely a userspace
> administration constraint....
>
> The only thing we do to help userspace administration is restrict
> changing project IDs to the init namespace, thereby preventing
> containers from being able to manipulate project IDs. This allows
> the init namespace to set the policy for project quota use and hence
> allow it to be used for directory tree quotas for container space
> management. This is essentially an extension of the original NAS
> use case, in that NFS exports were the isolation barrier that hid
> the underlying filesystem structure and project ID quota usage
> from the end users....
>
> > > > My point is that changing the project id of a non-dir child to be d=
ifferent
> > > > from the project id of its parent is a pretty rare use case (I thin=
k?).
> > >
> > > Not if you are using project quotas as they were originally intended
> > > to be used.
> > >
> >
> > Rephrase then:
> >
> > Changing the projid of a non-dir child to be different from the projid
> > of its parent, which has PROJINHERIT bit set, is a pretty rare use case=
(?)
>
> I have no data to indicate how rare it might be - the kernel has
> never enforced a policy that disallows changing project IDs when
> PROJINHERIT is set and any user with write permission can change
> project IDs even when PROJINHERIT is set. Hence we have to assume
> that there are people out there that rely on this behaviour,
> regardless of how rare it is...
>
> > > > If changing the projid of non-dir is needed for moving it to a
> > > > different subtree,
> > > > we could allow renameat2(2) of non-dir with no hardlinks to implici=
tly
> > > > change its
> > > > inherited project id or explicitly with a flag for a hardlink, e.g.=
:
> > > > renameat2(olddirfd, name, newdirfd, name, RENAME_NEW_PROJID).
> > >
> > > Why?
> > >
> > > The only reason XFS returns -EXDEV to rename across project IDs is
> > > because nobody wanted to spend the time to work out how to do the
> > > quota accounting of the metadata changed in the rename operation
> > > accurately. So for that rare case (not something that would happen
> > > on the NAS product) we returned -EXDEV to trigger the mv command to
> > > copy the file to the destination and then unlink the source instead,
> > > thereby handling all the quota accounting correctly.
> > >
> > > IOWs, this whole "-EXDEV on rename across parent project quota
> > > boundaries" is an implementation detail and nothing more.
> > > Filesystems that implement project quotas and the directory tree
> > > sub-variant don't need to behave like this if they can accurately
> > > account for the quota ID changes during an atomic rename operation.
> > > If that's too hard, then the fallback is to return -EXDEV and let
> > > userspace do it the slow way which will always acocunt the resource
> > > usage correctly to the individual projects.
> > >
> > > Hence I think we should just fix the XFS kernel behaviour to do the
> > > right thing in this special file case rather than return -EXDEV and
> > > then forget about the rest of it. Sure, update xfs_repair to fix the
> > > special file project id issue if it trips over it, but other than
> > > that I don't think we need anything more. If fixing it requires new
> > > syscalls and tools, then that's much harder to backport to old
> > > kernels and distros than just backporting a couple of small XFS
> > > kernel patches...
> > >
> >
> > I assume that by "fix the XFS behavior" you mean
> > "we could allow renameat2(2) of non-dir with no hardlinks to implicitly
> >  change its inherited project id"?
> > (in case the new parent has the PROJINHERIT bit)
> > so that the RENAME_NEW_PROJID behavior would be implicit.
>
> No, I meant "fix the original hardlink of an inode with no project ID
> within a PROJINHERIT directory always gets -EXDEV" by allowing
> hard links when the source file has no project ID specified.
>
> Actually, looking at 6.10-rc3, this has been merged already. So IMO
> there's nothing more we need to do here.
>

I don't see it.
Which commit is that?
I agree that would be enough to address the original report.

> > Unlike rename() from one parent to the other, link()+unlink()
> > is less obvious.
> >
> > The "modern" use cases that I listed where implicit change of projid
> > does not suffice are:
> >
> > 1. Share some inodes (as hardlinks) among projects
> > 2. Recursively changing a subtree projid
> >
> > They could be implemented by explicit flags to renameat2()/linkat() and
> > they could be implemented by [gs]etfsxattrat(2) syscalls.
>
> What are you expecting to happen when you hardlink an inode across
> multiple PROJINHERIT directories?  I mean, an inode can only have
> one project ID, so you can't link it into mulitple projects at once
> if you are using PROJINHERIT (xfs_link() expressly forbids it).
>
> So I'm really not sure what problem you are trying to describe or
> solve here. Can you elaborate more?

The problem that Andrey described started with a subtree
that has no projid and then projid was applied to all non-special files.
The suggested change to relax hardlink of projid 0 solves this case.

But a subtree could also be changed by user, say from projid P1
to projid P2 and in that case inherited projid P1 will remain on
the special files, causing a similar failure to link() without the
projid 0 relax rule.

Anyway, this discussion has wandered off too far from the original problem.

If the simple fix is enough for Andrey, it's fine by me.

If other people are interested in syscall or other means to change
fsxattr on special files, it's fine by me as well.

Thanks,
Amir.

