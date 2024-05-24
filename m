Return-Path: <linux-fsdevel+bounces-20082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD76E8CDF97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 04:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40291C20897
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 02:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFD92C694;
	Fri, 24 May 2024 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAV0vN9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281012AD38;
	Fri, 24 May 2024 02:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716519112; cv=none; b=ur/v18lqRGinqmeetDLG01j4UnrkIGsWsYTrH0HuHTp/IrdE2o3nqbSK8cat8Kjbu/du8FdIZfD7DHKnzXikLXHcfPZ4RNdxvZ83Klm6l7m6DlV4pPEiUcUvgV7pX9K0mgLk9vnR+gRMeMpywyrPDyAHD8R8kvFJdMOkz+KG0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716519112; c=relaxed/simple;
	bh=S7lfU0LQOJowvwgodqk1V+XzD2xIflQoQMwKIN1DDc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCKg5S+wvQMVCrVYS04EbTZM/hpeqF/wPqugjgdfQyIJfz9jIc+3HjrrI79YzD8CUbkoNlX2Yfj8fH+JZHrp+zPqehYmacccOeecP0ep2V/2JhzaE+rC6TsQrHKpbYmla1lBqC2OGiAtQYH7rapwpyUVZ+IS2lBjQ6VZtNn8vfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAV0vN9O; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f32864bcc7so17890455ad.3;
        Thu, 23 May 2024 19:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716519109; x=1717123909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0aIA4JbAL5o7MlZB87B0BS088s3emBdOeNgUtzCvOg=;
        b=kAV0vN9Om8AFyzlTTqPYgLP8IdkFZhfOQyXMJ1ePnfNiOX9TU13nV7yiFdXuxsdR4h
         b8YaDi2HYON2nKvlnEnuNicW7ivKGv31QGou2u7ejv3MVQnTXCam9mPF4Xis2HjE1Myu
         dCh/OKq2Abri72Edk2kVW4wph2NACvOoQwVMO73uT6dleFDe12RfEpLNngZ7Lv6VSWvf
         4iCx6BxoirHrSxIagHFL20gNjU7dx0Z+bQqhh2WM/O30b6NrCZTAqZcXgCq3l55zwH+o
         y+1os/vsKOYMMyfKCrpu+Is3j5g13T4Us/RZJxrTJ5mSEHDv39Ad7qv0fcBhbhi2DL2O
         1Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716519109; x=1717123909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0aIA4JbAL5o7MlZB87B0BS088s3emBdOeNgUtzCvOg=;
        b=X3tDFa4sSFkUJpufKKQOv2KsQ3K6Yh7uyhYSPo8Aa/OJEWYhxcqbOo0g8V+MmpCxcZ
         JuwAPQz2t4P3eO5499OTLAvehw/YYAiw94wMIopFOFtz2PfoADOG6H7szfiQcKSa+juf
         yJ4QNdcZ0HyBM/WJkZ5V+pomXQbqtyNiToLZ9KY0rvq7fyrptzf2lZ8qEE2hKTEYbF0m
         9y1FLFP4dXA3OPmxKn1KeCXrUQmT1B44hLtFD0KKo0ozWPIP7quvq1srEWoqPNBSxl2S
         /Hy3cNBZMYObA12f1/Z5wmkrcqopb1ThZeuJbot9XvDeVig+QQQxyqJwAzlAZJzu/prI
         uQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6WWv8pBUGuvZKRobCxTou7ryQHyBl8tpHRro0BJ9TBPYHkob8tKqRyqkQh94jRB7oaxW9bVy/xp1+tZdSrkJgFq2OyMUwNqQF3cn3AoJSgeHCKSUgJx6koA4R2RwuES0VbOMLbcP6
X-Gm-Message-State: AOJu0YyxQhT+oZigu9exAt4277k1kbvUjhB9Ysp7E+bclGtw6qXa8ZQP
	dyRUYMlI9IDQqOw23mN3WFmEAqSuGmod9PXrSPfLyfE9lhyI++pUZnkjQdwus+LKFxnnlqcCkJv
	QIhOKQMsM+EpFmFcB60UgcHT8pp+eGcvdLKaU
X-Google-Smtp-Source: AGHT+IGOElhLilkLxL5XQA/v8Jeb6CklMrqwDK/92vH1KpNbF26x2h7AhubzoApQG89zXvjoOJsSwckpCnL0R8NKpmU=
X-Received: by 2002:a17:902:cecd:b0:1f2:f4e6:cdb6 with SMTP id
 d9443c01a7336-1f4486ed3bcmr13060685ad.23.1716519109073; Thu, 23 May 2024
 19:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412161000.33148-1-lostzoumo@gmail.com> <CAHfrynPTuNDH7J4=mVcya7nVMg-0ovkwewciTXbS-hSX7G1cAw@mail.gmail.com>
 <CAHfrynM7+7RqhrGPqg=+uT8rCUH+8hvTRZg9vGz_xcSr-3Xtbw@mail.gmail.com>
In-Reply-To: <CAHfrynM7+7RqhrGPqg=+uT8rCUH+8hvTRZg9vGz_xcSr-3Xtbw@mail.gmail.com>
From: Mo Zou <lostzoumo@gmail.com>
Date: Fri, 24 May 2024 10:51:37 +0800
Message-ID: <CAHfrynPN3h=h8dhPrnN=pks=oAeD9FxRaWmOO4PekO8tbe_WbQ@mail.gmail.com>
Subject: Re: [PATCH] Docs: fs: prove directory locking more formally
To: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>, 
	"corbet@lwn.net" <corbet@lwn.net>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, dd_nirvana@sjtu.edu.cn, 
	mingkaidong@sjtu.edu.cn, haibochen@sjtu.edu.cn, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The Linux kernel currently *lacks* formal specification and proof. But
it seems no one takes this seriously.

A quote from the RefFS paper (OSDI'24):"we found this flaw (commit
28eceeda130f) when we failed to define the dynamic layering
specification for the scheme. Indeed, having a formal specification that
effectively captures lock dependencies is crucial. Such a specification
not only aids in conducting formal proofs but also enhances our
fundamental understanding of the system. Interestingly, even without
engaging in code proofs, the specification itself can help uncover
practical bugs and vulnerabilities".

Mo Zou <lostzoumo@gmail.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=886=E6=97=A5=E5=
=91=A8=E4=B8=80 20:29=E5=86=99=E9=81=93=EF=BC=9A
>
> > > Instead of proof by contradiction, this proof more intuitively explai=
ns
> > > the order that the locking rules want to enforce. If the developers w=
ant
> > > to update the locking rules, they would be forced to come up with the
> > > corresponding order that justifies deadlock-freedom, otherwise, the
> > > proof won't pass. As a evidence of effectiveness, the authors of RefF=
S
> > > paper firstly report the bug from commit 28eceeda130f ("fs: Lock move=
d
> > > directories") through this formal approach.
> >
> > Any comments on this proof? BTW, it would be okay to keep both the
> > by-contradiction proof and by-order proof as both proofs may find their
> > audience.
>
> Continuously seeking for comments.
>
> Mo Zou <lostzoumo@gmail.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=8830=E6=97=A5=
=E5=91=A8=E4=BA=8C 09:44=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > Instead of proof by contradiction, this proof more intuitively explai=
ns
> > > the order that the locking rules want to enforce. If the developers w=
ant
> > > to update the locking rules, they would be forced to come up with the
> > > corresponding order that justifies deadlock-freedom, otherwise, the
> > > proof won't pass. As a evidence of effectiveness, the authors of RefF=
S
> > > paper firstly report the bug from commit 28eceeda130f ("fs: Lock move=
d
> > > directories") through this formal approach.
> >
> > Any comments on this proof? BTW, it would be okay to keep both the
> > by-contradiction proof and by-order proof as both proofs may find their
> > audience.
> >
> > Mo Zou <lostzoumo@gmail.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=8813=E6=97=
=A5=E5=91=A8=E5=85=AD 00:10=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > The directory locking proof should and could be made more formal.
> > > Specifically, the locking rules for rename are very intricate and
> > > subtle. The current proof shows deadlock-freedom by contradiction, i.=
e.,
> > > if a deadlock is possible, where could go wrong. There is no denying
> > > that the proof is detailed with all possible cases considered. Howeve=
r,
> > > it gives less intuition on why the locking rules are correct and may =
be
> > > hard to maintain. Developers and even experts may still make mistakes
> > > without realizing that the proof is no longer correct. See commit
> > > 28eceeda130f ("fs: Lock moved directories") for such a case.
> > >
> > > A recent academia paper RefFS from OSDI 2024 has proposed a formal wa=
y
> > > to prove the correctness of locking scheme with machine-checkable pro=
of
> > > (see https://ipads.se.sjtu.edu.cn/projects/reffs for a preprint of th=
e
> > > paper). The core idea is to formally define the locking order of the
> > > rules. Actually, the existing proof has the same idea but fails to
> > > define the internal ranking for directories. The difficulty is that t=
he
> > > ranking for directories is not static but dynamic. In this patch, we
> > > follow the idea from the paper to dynamically define the internal
> > > ranking of directories and shows that operations always take director=
ies
> > > in order of increasing rank so that deadlocks are never possible.
> > > Instead of proof by contradiction, this proof more intuitively explai=
ns
> > > the order that the locking rules want to enforce. If the developers w=
ant
> > > to update the locking rules, they would be forced to come up with the
> > > corresponding order that justifies deadlock-freedom, otherwise, the
> > > proof won't pass. As a evidence of effectiveness, the authors of RefF=
S
> > > paper firstly report the bug from commit 28eceeda130f ("fs: Lock move=
d
> > > directories") through this formal approach.
> > >
> > > Signed-off-by: Mo Zou <lostzoumo@gmail.com>
> > > ---
> > >  .../filesystems/directory-locking.rst         | 224 +++++++++-------=
--
> > >  1 file changed, 113 insertions(+), 111 deletions(-)
> > >
> > > diff --git a/Documentation/filesystems/directory-locking.rst b/Docume=
ntation/filesystems/directory-locking.rst
> > > index 05ea387bc9fb..94e358d71986 100644
> > > --- a/Documentation/filesystems/directory-locking.rst
> > > +++ b/Documentation/filesystems/directory-locking.rst
> > > @@ -44,7 +44,7 @@ For our purposes all operations fall in 6 classes:
> > >         * decide which of the source and target need to be locked.
> > >           The source needs to be locked if it's a non-directory, targ=
et - if it's
> > >           a non-directory or about to be removed.
> > > -       * take the locks that need to be taken (exlusive), in inode p=
ointer order
> > > +       * take the locks that need to be taken (exclusive), in inode =
pointer order
> > >           if need to take both (that can happen only when both source=
 and target
> > >           are non-directories - the source because it wouldn't need t=
o be locked
> > >           otherwise and the target because mixing directory and non-d=
irectory is
> > > @@ -135,12 +135,13 @@ If no directory is its own ancestor, the scheme=
 above is deadlock-free.
> > >  Proof:
> > >
> > >  There is a ranking on the locks, such that all primitives take
> > > -them in order of non-decreasing rank.  Namely,
> > > +them in order of increasing rank.  Namely,
> > >
> > >    * rank ->i_rwsem of non-directories on given filesystem in inode p=
ointer
> > >      order.
> > > -  * put ->i_rwsem of all directories on a filesystem at the same ran=
k,
> > > -    lower than ->i_rwsem of any non-directory on the same filesystem=
.
> > > +  * put ->i_rwsem of all directories on a filesystem lower than ->i_=
rwsem
> > > +    of any non-directory on the same filesystem and the internal ran=
king
> > > +    of directories are defined later.
> > >    * put ->s_vfs_rename_mutex at rank lower than that of any ->i_rwse=
m
> > >      on the same filesystem.
> > >    * among the locks on different filesystems use the relative
> > > @@ -149,92 +150,120 @@ them in order of non-decreasing rank.  Namely,
> > >  For example, if we have NFS filesystem caching on a local one, we ha=
ve
> > >
> > >    1. ->s_vfs_rename_mutex of NFS filesystem
> > > -  2. ->i_rwsem of directories on that NFS filesystem, same rank for =
all
> > > +  2. ->i_rwsem of directories on that NFS filesystem, internal ranki=
ng
> > > +     defined later
> > >    3. ->i_rwsem of non-directories on that filesystem, in order of
> > >       increasing address of inode
> > >    4. ->s_vfs_rename_mutex of local filesystem
> > > -  5. ->i_rwsem of directories on the local filesystem, same rank for=
 all
> > > +  5. ->i_rwsem of directories on the local filesystem, internal rank=
ing
> > > +     defined later
> > >    6. ->i_rwsem of non-directories on local filesystem, in order of
> > >       increasing address of inode.
> > >
> > > -It's easy to verify that operations never take a lock with rank
> > > -lower than that of an already held lock.
> > > -
> > > -Suppose deadlocks are possible.  Consider the minimal deadlocked
> > > -set of threads.  It is a cycle of several threads, each blocked on a=
 lock
> > > -held by the next thread in the cycle.
> > > -
> > > -Since the locking order is consistent with the ranking, all
> > > -contended locks in the minimal deadlock will be of the same rank,
> > > -i.e. they all will be ->i_rwsem of directories on the same filesyste=
m.
> > > -Moreover, without loss of generality we can assume that all operatio=
ns
> > > -are done directly to that filesystem and none of them has actually
> > > -reached the method call.
> > > -
> > > -In other words, we have a cycle of threads, T1,..., Tn,
> > > -and the same number of directories (D1,...,Dn) such that
> > > -
> > > -       T1 is blocked on D1 which is held by T2
> > > -
> > > -       T2 is blocked on D2 which is held by T3
> > > -
> > > -       ...
> > > -
> > > -       Tn is blocked on Dn which is held by T1.
> > > -
> > > -Each operation in the minimal cycle must have locked at least
> > > -one directory and blocked on attempt to lock another.  That leaves
> > > -only 3 possible operations: directory removal (locks parent, then
> > > -child), same-directory rename killing a subdirectory (ditto) and
> > > -cross-directory rename of some sort.
> > > -
> > > -There must be a cross-directory rename in the set; indeed,
> > > -if all operations had been of the "lock parent, then child" sort
> > > -we would have Dn a parent of D1, which is a parent of D2, which is
> > > -a parent of D3, ..., which is a parent of Dn.  Relationships couldn'=
t
> > > -have changed since the moment directory locks had been acquired,
> > > -so they would all hold simultaneously at the deadlock time and
> > > -we would have a loop.
> > > -
> > > -Since all operations are on the same filesystem, there can't be
> > > -more than one cross-directory rename among them.  Without loss of
> > > -generality we can assume that T1 is the one doing a cross-directory
> > > -rename and everything else is of the "lock parent, then child" sort.
> > > -
> > > -In other words, we have a cross-directory rename that locked
> > > -Dn and blocked on attempt to lock D1, which is a parent of D2, which=
 is
> > > -a parent of D3, ..., which is a parent of Dn.  Relationships between
> > > -D1,...,Dn all hold simultaneously at the deadlock time.  Moreover,
> > > -cross-directory rename does not get to locking any directories until=
 it
> > > -has acquired filesystem lock and verified that directories involved =
have
> > > -a common ancestor, which guarantees that ancestry relationships betw=
een
> > > -all of them had been stable.
> > > -
> > > -Consider the order in which directories are locked by the
> > > -cross-directory rename; parents first, then possibly their children.
> > > -Dn and D1 would have to be among those, with Dn locked before D1.
> > > -Which pair could it be?
> > > -
> > > -It can't be the parents - indeed, since D1 is an ancestor of Dn,
> > > -it would be the first parent to be locked.  Therefore at least one o=
f the
> > > -children must be involved and thus neither of them could be a descen=
dent
> > > -of another - otherwise the operation would not have progressed past
> > > -locking the parents.
> > > -
> > > -It can't be a parent and its child; otherwise we would've had
> > > -a loop, since the parents are locked before the children, so the par=
ent
> > > -would have to be a descendent of its child.
> > > -
> > > -It can't be a parent and a child of another parent either.
> > > -Otherwise the child of the parent in question would've been a descen=
dent
> > > -of another child.
> > > -
> > > -That leaves only one possibility - namely, both Dn and D1 are
> > > -among the children, in some order.  But that is also impossible, sin=
ce
> > > -neither of the children is a descendent of another.
> > > -
> > > -That concludes the proof, since the set of operations with the
> > > -properties requiered for a minimal deadlock can not exist.
> > > +.. _RefFS: https://ipads.se.sjtu.edu.cn/projects/reffs
> > > +
> > > +The ranking above is mostly static except the internal ranking of
> > > +directories. Below we will focus on internal ranking of directories =
on
> > > +the same filesystem and present a way to dynamically define ranks of
> > > +directories such that operations still take locks in order of
> > > +increasing rank, i.e., operations always take a lock with rank highe=
r
> > > +than that of any already held locks. Note that the idea of dynamic
> > > +ranking has a formal basis and more details can be found in the
> > > +academia paper RefFS_ from OSDI 2024.
> > > +
> > > +
> > > +First, without considering cross-directory renames, a directory's ra=
nk
> > > +is defined as its distance from the root, i.e., root directory has r=
ank
> > > +0 and each child directory's rank equals one plus its parent
> > > +directory's rank. Because no directory is its own ancestor, every
> > > +directory's rank can be uniquely determined starting from root to it=
s
> > > +descendants. This ranking accounts for the (locks parent, then child=
)
> > > +nested locking in directory removal and same-directory rename.
> > > +
> > > +Then, consider the most complex case in a cross-directory rename, wh=
ere the
> > > +most locks need to be acquired. The rename may perform the following
> > > +nested locking (only show lock statements for convenience). Here, di=
r1
> > > +and dir2 are the two parents and according to the locking rules, we
> > > +know dir2 is not ancestor to dir1. child1 and child2 are source and
> > > +target in a order according to the rules above and may not necessari=
ly
> > > +correspond to the child of dir1 and dir2. Ignore things in angle
> > > +brackets for now. The locking order here can not be predetermined. F=
or
> > > +instance, rename(/a/x,/b/y) and rename(/b/y,/a/x) would acquire /a a=
nd
> > > +/b in different order because neither parent is an ancestor of the
> > > +other and we lock the parent of source first. But the observation is
> > > +that after acquiring the filesystem lock, the precise locking order
> > > +becomes known. We introduce a ghost state edge to help define the
> > > +ranks (ghost state is a commonly used technique in verification whic=
h
> > > +has no influence on the program execution and its only role is to
> > > +assist the proof).
> > > +
> > > +  1. lock filesystem (->s_vfs_rename_mutex);
> > > +  2. lock dir1->i_rwsem; <set edge to (dir1, dir2)>
> > > +  3. lock dir2->i_rwsem; <set edge to (non-parent, child1) if child1=
 is
> > > +     a directory and non-parent is the one in dir1 and dir2 that is =
not
> > > +     parent to child1, otherwise, set edge to None>
> > > +  4. lock child1->i_rwsem; <set edge to (child1, child2) if chil1 an=
d
> > > +     child2 are directories, otherwise, set edge to None>
> > > +  5. lock child2->i_rwsem; <set edge to None>
> > > +
> > > +The value of edge is either None or (inode1,inode2)
> > > +representing a possible lock dependency from inode1 to inode2, i.e.,
> > > +some thread may request lock of inode2 with lock of inode1 held. The=
re
> > > +is only ever one edge value in a filesystem with edge set to None wh=
en
> > > +the s_vfs_rename_mutex is not held and edge set to a determined valu=
e
> > > +when s_vfs_rename_mutex is held. When edge is None, the ranking rule=
s
> > > +are the same as before (root is 0 and child is one plus its parent).
> > > +When edge is (inode1, inode2), only the ranking rule for inode2
> > > +changes: inode2's rank is one plus the larger rank of inode2's paren=
t
> > > +and inode1. Intuitively, a directory's rank is the longest distance
> > > +from root in the filesystem tree extended with edge.
> > > +
> > > +Now let's check the setting of edge in angle brackets in above code =
to
> > > +see how it ensures cross-directory rename takes locks in increasing
> > > +order in this case. After the lock statement at line 2, edge is set =
to
> > > +(dir1,dir2). Because dir2 is not ancestor to dir1, the rank of dir1
> > > +stays the same and the rank of dir2 (as well as every other
> > > +directories) can be uniquely determined. So at line 3, dir2's rank i=
s
> > > +higher than dir1's. Before the code acquires child1 at line 4, it
> > > +already holds dir1 and dir2. We know one of dir1 and dir2 is parent =
to
> > > +child1, so we update edge to (the non-parent of child1, child1).
> > > +Because child1 cannot be ancestor to dir1 or dir2, every directory's
> > > +rank is still uniquely defined (for the same reason as above). So at
> > > +line 4, we ensure child1 has higher rank than dir1 and dir2. Similar=
ly,
> > > +we update edge to (child1, child2) so that at line 5, child2 has hig=
her
> > > +rank than held locks (dir1, dir2 and child1). We reset edge to None
> > > +whenever we have acquired all directory locks.
> > > +
> > > +In a less complex case of cross-directory rename, the code may execu=
te
> > > +a prefix of above lines and we always reset edge to None after havin=
g
> > > +acquired all directory locks.
> > > +
> > > +The ranking of directories may change under following cases:
> > > +
> > > +  * directory removal/creation: a directory's rank is removed/added
> > > +  * rename: the effect of rename is either (1) moving a subtree unde=
r a
> > > +    node that is outside of the subtree (the directories in the subt=
ree are
> > > +    all recalculated based on the node whose rank is not influenced)
> > > +    and potentially removing target (a directory's rank is removed) =
or
> > > +    (2) in case of RENAME_EXCHANGE, two subtrees exchange their
> > > +    positions. Because source is not a descendent of the target and
> > > +    target is not a descendent of source, the parents of the two
> > > +    subtrees cannot not be in these subtrees so the ranks of parents
> > > +    are not influenced. The two subtrees' ranks are recalculated bas=
ed
> > > +    on their parents
> > > +  * edge updates in a cross-directory rename: setting edge to
> > > +    (inode1,inode2) or resetting edge to None modify the ranks of th=
e
> > > +    inode2 subtree
> > > +
> > > +Initially in a filesystem, no directory is its own ancestor and
> > > +directories' ranks can be uniquely determined. All these changes
> > > +preserve the fact that at every time, the ranking of every directory
> > > +can be uniquely determined. Thus no directory is its own ancestor
> > > +(because if a directory is its own ancestor, its rank cannot be
> > > +determined) and we prove the premise. Plus the fact that operations
> > > +always take locks in order of increasing rank (can be easily verifie=
d).
> > > +We can conclude the locking rules above are deadlock-free.
> > > +
> > >
> > >  Note that the check for having a common ancestor in cross-directory
> > >  rename is crucial - without it a deadlock would be possible.  Indeed=
,
> > > @@ -247,33 +276,6 @@ distant ancestor.  Add a bunch of rmdir() attemp=
ts on all directories
> > >  in between (all of those would fail with -ENOTEMPTY, had they ever g=
otten
> > >  the locks) and voila - we have a deadlock.
> > >
> > > -Loop avoidance
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -
> > > -These operations are guaranteed to avoid loop creation.  Indeed,
> > > -the only operation that could introduce loops is cross-directory ren=
ame.
> > > -Suppose after the operation there is a loop; since there hadn't been=
 such
> > > -loops before the operation, at least on of the nodes in that loop mu=
st've
> > > -had its parent changed.  In other words, the loop must be passing th=
rough
> > > -the source or, in case of exchange, possibly the target.
> > > -
> > > -Since the operation has succeeded, neither source nor target could h=
ave
> > > -been ancestors of each other.  Therefore the chain of ancestors star=
ting
> > > -in the parent of source could not have passed through the target and
> > > -vice versa.  On the other hand, the chain of ancestors of any node c=
ould
> > > -not have passed through the node itself, or we would've had a loop b=
efore
> > > -the operation.  But everything other than source and target has kept
> > > -the parent after the operation, so the operation does not change the
> > > -chains of ancestors of (ex-)parents of source and target.  In partic=
ular,
> > > -those chains must end after a finite number of steps.
> > > -
> > > -Now consider the loop created by the operation.  It passes through e=
ither
> > > -source or target; the next node in the loop would be the ex-parent o=
f
> > > -target or source resp.  After that the loop would follow the chain o=
f
> > > -ancestors of that parent.  But as we have just shown, that chain mus=
t
> > > -end after a finite number of steps, which means that it can't be a p=
art
> > > -of any loop.  Q.E.D.
> > > -
> > >  While this locking scheme works for arbitrary DAGs, it relies on
> > >  ability to check that directory is a descendent of another object.  =
Current
> > >  implementation assumes that directory graph is a tree.  This assumpt=
ion is
> > > --
> > > 2.30.1 (Apple Git-130)
> > >

