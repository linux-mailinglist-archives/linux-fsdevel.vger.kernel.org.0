Return-Path: <linux-fsdevel+bounces-18829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645C28BCDF7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 14:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873871C2191F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 12:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D303D1448EE;
	Mon,  6 May 2024 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTeZ/H3G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4114F143C5B;
	Mon,  6 May 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998557; cv=none; b=o5a16rqeER3s9kj6ZEL3bIeirXrWDL7zv5/J3QvGqEQEgKRkQ1LnrG04VcuIrQVU6/6sA+hLKE27lLLjoZZqXMeTvxQmF1JUhK8Na/pdcxhIWvzSlh4K1Krm8k2RgY6RdjZ/HiVvubehOyImyeH5tqQuN18dWJUq6uil3jEeeKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998557; c=relaxed/simple;
	bh=KMEZe17zNIRXv/b8kSkt5pd8afzY+EPOD0JKZc0qdRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxvnBhiCwO6VrEEruJ3s81bD/zifQrf2XuqU6myOJDw2/652FZHrtwG9r4lSVKlBtkiZrP38Jburv2P90pmx03ghSSoENe3WLAEuW0ty2xF95sHqssRBYCx4DRn5xYFB+SmGXet8po/Q33h3xL9toeUsntpi8OvI+gM8YBSfZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTeZ/H3G; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-618a2b12dbbso2844368a12.0;
        Mon, 06 May 2024 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714998554; x=1715603354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CYJeqB0SYRIcAUwnJc7TVQJK+VWFq8wLzsz1YwlsyQ=;
        b=CTeZ/H3G9j3fXI4FijWFNZO5cUQYVhSraiXqLtjRefzul8g8gn0ijDhQDHhFIwRWYT
         3cpkXgssXOhZSHyoNHprR6eARay500SOLea/F8gJq4mFj7ab6FOAWYvCfdhJJFytUepV
         sa83dKhTDogOuMTHBQ4ZD01UwBMdDpNHVT99Dl7vDKY6jqaDj5M1Yw+MDq64XxbhXRm2
         /CUes7m7Htz+Dl2KKMgtPwbIN23mMDMLnVvH6PfxU7q/wwPw1mbNgDg7N/R/Y84qOSDd
         NfCDmu4cFHlEx36h77BilyLxRESINHmI3Fu4A1e03MCdQcrOkF9VxQwe0UOCQkK1s065
         D70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714998554; x=1715603354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CYJeqB0SYRIcAUwnJc7TVQJK+VWFq8wLzsz1YwlsyQ=;
        b=jscLoOgFXpAItpUlFbV5uY9Lrg/fIHDhhWY3WQbaOsZBNH/Vm1p8os6DPaewxEgEVr
         nkmN8c9Lr8o3vqIJiMv0/xxAGIBHA9jR9PKFYD+Pak/1yfHqbvlz5DaZSvzZuSRkq51f
         NwK24Mz1IAT/AuG/kn1abim+MqOLC6wRoYrDWy5wi7lH/cQ8loNoBpcBMygWOMQAL9PK
         HcFYe4eBh2KyeKMvzhmQPCoZuNNqtsNhfuIlLPnfGA5zvC+rK+1ruzLvBN7ETnzMc+x4
         LhAAkQB0G9Ip8ADye0g3JLI+QL1wIVC1d8iyFXArS0thWyIrC8xr4ihgz25YVDbtE4M8
         yX4w==
X-Forwarded-Encrypted: i=1; AJvYcCVaisrdTSBGOye4SEvMMoykrSLWwd0vfDc8INfN5v+sftN0SLXIg4HFRvmEGj5yOWh03zdTGRQ95Pmw7MkEEGBJO14qMocq2+UJToGwqQpEPH5o1I8ccKc+8eLyC7hiJelITG0G0jiI
X-Gm-Message-State: AOJu0Yy8rMQrfnh2sepPrcI3CefM8Qxj4im40sFzaXhBuB4gHiGmC16f
	KNyHPq264n4Rw2Eu9BcKjyggGwBIThrCGyKigkYWkuF5ZAsxoHIWI/e+RolmthaSkxnSNL234OT
	SMLsw76rCI1b9JuyY55qtzQjTLLvMCriWZuCt
X-Google-Smtp-Source: AGHT+IHZXRFbzhtExgtxYx9W4BMHmiekvLdQAKwUgPghnrogZRHBInURn+QBGxXxClQyVR/RXb36Qui0HFB6HPua2lQ=
X-Received: by 2002:a17:90b:1295:b0:2a5:df97:b with SMTP id
 fw21-20020a17090b129500b002a5df97000bmr15003720pjb.18.1714998554225; Mon, 06
 May 2024 05:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412161000.33148-1-lostzoumo@gmail.com> <CAHfrynPTuNDH7J4=mVcya7nVMg-0ovkwewciTXbS-hSX7G1cAw@mail.gmail.com>
In-Reply-To: <CAHfrynPTuNDH7J4=mVcya7nVMg-0ovkwewciTXbS-hSX7G1cAw@mail.gmail.com>
From: Mo Zou <lostzoumo@gmail.com>
Date: Mon, 6 May 2024 20:29:01 +0800
Message-ID: <CAHfrynM7+7RqhrGPqg=+uT8rCUH+8hvTRZg9vGz_xcSr-3Xtbw@mail.gmail.com>
Subject: Re: [PATCH] Docs: fs: prove directory locking more formally
To: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>, 
	"corbet@lwn.net" <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org, dd_nirvana@sjtu.edu.cn, 
	mingkaidong@sjtu.edu.cn, haibochen@sjtu.edu.cn, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > Instead of proof by contradiction, this proof more intuitively explains
> > the order that the locking rules want to enforce. If the developers wan=
t
> > to update the locking rules, they would be forced to come up with the
> > corresponding order that justifies deadlock-freedom, otherwise, the
> > proof won't pass. As a evidence of effectiveness, the authors of RefFS
> > paper firstly report the bug from commit 28eceeda130f ("fs: Lock moved
> > directories") through this formal approach.
>
> Any comments on this proof? BTW, it would be okay to keep both the
> by-contradiction proof and by-order proof as both proofs may find their
> audience.

Continuously seeking for comments.

Mo Zou <lostzoumo@gmail.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=8830=E6=97=A5=E5=
=91=A8=E4=BA=8C 09:44=E5=86=99=E9=81=93=EF=BC=9A
>
> > Instead of proof by contradiction, this proof more intuitively explains
> > the order that the locking rules want to enforce. If the developers wan=
t
> > to update the locking rules, they would be forced to come up with the
> > corresponding order that justifies deadlock-freedom, otherwise, the
> > proof won't pass. As a evidence of effectiveness, the authors of RefFS
> > paper firstly report the bug from commit 28eceeda130f ("fs: Lock moved
> > directories") through this formal approach.
>
> Any comments on this proof? BTW, it would be okay to keep both the
> by-contradiction proof and by-order proof as both proofs may find their
> audience.
>
> Mo Zou <lostzoumo@gmail.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=8813=E6=97=A5=
=E5=91=A8=E5=85=AD 00:10=E5=86=99=E9=81=93=EF=BC=9A
> >
> > The directory locking proof should and could be made more formal.
> > Specifically, the locking rules for rename are very intricate and
> > subtle. The current proof shows deadlock-freedom by contradiction, i.e.=
,
> > if a deadlock is possible, where could go wrong. There is no denying
> > that the proof is detailed with all possible cases considered. However,
> > it gives less intuition on why the locking rules are correct and may be
> > hard to maintain. Developers and even experts may still make mistakes
> > without realizing that the proof is no longer correct. See commit
> > 28eceeda130f ("fs: Lock moved directories") for such a case.
> >
> > A recent academia paper RefFS from OSDI 2024 has proposed a formal way
> > to prove the correctness of locking scheme with machine-checkable proof
> > (see https://ipads.se.sjtu.edu.cn/projects/reffs for a preprint of the
> > paper). The core idea is to formally define the locking order of the
> > rules. Actually, the existing proof has the same idea but fails to
> > define the internal ranking for directories. The difficulty is that the
> > ranking for directories is not static but dynamic. In this patch, we
> > follow the idea from the paper to dynamically define the internal
> > ranking of directories and shows that operations always take directorie=
s
> > in order of increasing rank so that deadlocks are never possible.
> > Instead of proof by contradiction, this proof more intuitively explains
> > the order that the locking rules want to enforce. If the developers wan=
t
> > to update the locking rules, they would be forced to come up with the
> > corresponding order that justifies deadlock-freedom, otherwise, the
> > proof won't pass. As a evidence of effectiveness, the authors of RefFS
> > paper firstly report the bug from commit 28eceeda130f ("fs: Lock moved
> > directories") through this formal approach.
> >
> > Signed-off-by: Mo Zou <lostzoumo@gmail.com>
> > ---
> >  .../filesystems/directory-locking.rst         | 224 +++++++++---------
> >  1 file changed, 113 insertions(+), 111 deletions(-)
> >
> > diff --git a/Documentation/filesystems/directory-locking.rst b/Document=
ation/filesystems/directory-locking.rst
> > index 05ea387bc9fb..94e358d71986 100644
> > --- a/Documentation/filesystems/directory-locking.rst
> > +++ b/Documentation/filesystems/directory-locking.rst
> > @@ -44,7 +44,7 @@ For our purposes all operations fall in 6 classes:
> >         * decide which of the source and target need to be locked.
> >           The source needs to be locked if it's a non-directory, target=
 - if it's
> >           a non-directory or about to be removed.
> > -       * take the locks that need to be taken (exlusive), in inode poi=
nter order
> > +       * take the locks that need to be taken (exclusive), in inode po=
inter order
> >           if need to take both (that can happen only when both source a=
nd target
> >           are non-directories - the source because it wouldn't need to =
be locked
> >           otherwise and the target because mixing directory and non-dir=
ectory is
> > @@ -135,12 +135,13 @@ If no directory is its own ancestor, the scheme a=
bove is deadlock-free.
> >  Proof:
> >
> >  There is a ranking on the locks, such that all primitives take
> > -them in order of non-decreasing rank.  Namely,
> > +them in order of increasing rank.  Namely,
> >
> >    * rank ->i_rwsem of non-directories on given filesystem in inode poi=
nter
> >      order.
> > -  * put ->i_rwsem of all directories on a filesystem at the same rank,
> > -    lower than ->i_rwsem of any non-directory on the same filesystem.
> > +  * put ->i_rwsem of all directories on a filesystem lower than ->i_rw=
sem
> > +    of any non-directory on the same filesystem and the internal ranki=
ng
> > +    of directories are defined later.
> >    * put ->s_vfs_rename_mutex at rank lower than that of any ->i_rwsem
> >      on the same filesystem.
> >    * among the locks on different filesystems use the relative
> > @@ -149,92 +150,120 @@ them in order of non-decreasing rank.  Namely,
> >  For example, if we have NFS filesystem caching on a local one, we have
> >
> >    1. ->s_vfs_rename_mutex of NFS filesystem
> > -  2. ->i_rwsem of directories on that NFS filesystem, same rank for al=
l
> > +  2. ->i_rwsem of directories on that NFS filesystem, internal ranking
> > +     defined later
> >    3. ->i_rwsem of non-directories on that filesystem, in order of
> >       increasing address of inode
> >    4. ->s_vfs_rename_mutex of local filesystem
> > -  5. ->i_rwsem of directories on the local filesystem, same rank for a=
ll
> > +  5. ->i_rwsem of directories on the local filesystem, internal rankin=
g
> > +     defined later
> >    6. ->i_rwsem of non-directories on local filesystem, in order of
> >       increasing address of inode.
> >
> > -It's easy to verify that operations never take a lock with rank
> > -lower than that of an already held lock.
> > -
> > -Suppose deadlocks are possible.  Consider the minimal deadlocked
> > -set of threads.  It is a cycle of several threads, each blocked on a l=
ock
> > -held by the next thread in the cycle.
> > -
> > -Since the locking order is consistent with the ranking, all
> > -contended locks in the minimal deadlock will be of the same rank,
> > -i.e. they all will be ->i_rwsem of directories on the same filesystem.
> > -Moreover, without loss of generality we can assume that all operations
> > -are done directly to that filesystem and none of them has actually
> > -reached the method call.
> > -
> > -In other words, we have a cycle of threads, T1,..., Tn,
> > -and the same number of directories (D1,...,Dn) such that
> > -
> > -       T1 is blocked on D1 which is held by T2
> > -
> > -       T2 is blocked on D2 which is held by T3
> > -
> > -       ...
> > -
> > -       Tn is blocked on Dn which is held by T1.
> > -
> > -Each operation in the minimal cycle must have locked at least
> > -one directory and blocked on attempt to lock another.  That leaves
> > -only 3 possible operations: directory removal (locks parent, then
> > -child), same-directory rename killing a subdirectory (ditto) and
> > -cross-directory rename of some sort.
> > -
> > -There must be a cross-directory rename in the set; indeed,
> > -if all operations had been of the "lock parent, then child" sort
> > -we would have Dn a parent of D1, which is a parent of D2, which is
> > -a parent of D3, ..., which is a parent of Dn.  Relationships couldn't
> > -have changed since the moment directory locks had been acquired,
> > -so they would all hold simultaneously at the deadlock time and
> > -we would have a loop.
> > -
> > -Since all operations are on the same filesystem, there can't be
> > -more than one cross-directory rename among them.  Without loss of
> > -generality we can assume that T1 is the one doing a cross-directory
> > -rename and everything else is of the "lock parent, then child" sort.
> > -
> > -In other words, we have a cross-directory rename that locked
> > -Dn and blocked on attempt to lock D1, which is a parent of D2, which i=
s
> > -a parent of D3, ..., which is a parent of Dn.  Relationships between
> > -D1,...,Dn all hold simultaneously at the deadlock time.  Moreover,
> > -cross-directory rename does not get to locking any directories until i=
t
> > -has acquired filesystem lock and verified that directories involved ha=
ve
> > -a common ancestor, which guarantees that ancestry relationships betwee=
n
> > -all of them had been stable.
> > -
> > -Consider the order in which directories are locked by the
> > -cross-directory rename; parents first, then possibly their children.
> > -Dn and D1 would have to be among those, with Dn locked before D1.
> > -Which pair could it be?
> > -
> > -It can't be the parents - indeed, since D1 is an ancestor of Dn,
> > -it would be the first parent to be locked.  Therefore at least one of =
the
> > -children must be involved and thus neither of them could be a descende=
nt
> > -of another - otherwise the operation would not have progressed past
> > -locking the parents.
> > -
> > -It can't be a parent and its child; otherwise we would've had
> > -a loop, since the parents are locked before the children, so the paren=
t
> > -would have to be a descendent of its child.
> > -
> > -It can't be a parent and a child of another parent either.
> > -Otherwise the child of the parent in question would've been a descende=
nt
> > -of another child.
> > -
> > -That leaves only one possibility - namely, both Dn and D1 are
> > -among the children, in some order.  But that is also impossible, since
> > -neither of the children is a descendent of another.
> > -
> > -That concludes the proof, since the set of operations with the
> > -properties requiered for a minimal deadlock can not exist.
> > +.. _RefFS: https://ipads.se.sjtu.edu.cn/projects/reffs
> > +
> > +The ranking above is mostly static except the internal ranking of
> > +directories. Below we will focus on internal ranking of directories on
> > +the same filesystem and present a way to dynamically define ranks of
> > +directories such that operations still take locks in order of
> > +increasing rank, i.e., operations always take a lock with rank higher
> > +than that of any already held locks. Note that the idea of dynamic
> > +ranking has a formal basis and more details can be found in the
> > +academia paper RefFS_ from OSDI 2024.
> > +
> > +
> > +First, without considering cross-directory renames, a directory's rank
> > +is defined as its distance from the root, i.e., root directory has ran=
k
> > +0 and each child directory's rank equals one plus its parent
> > +directory's rank. Because no directory is its own ancestor, every
> > +directory's rank can be uniquely determined starting from root to its
> > +descendants. This ranking accounts for the (locks parent, then child)
> > +nested locking in directory removal and same-directory rename.
> > +
> > +Then, consider the most complex case in a cross-directory rename, wher=
e the
> > +most locks need to be acquired. The rename may perform the following
> > +nested locking (only show lock statements for convenience). Here, dir1
> > +and dir2 are the two parents and according to the locking rules, we
> > +know dir2 is not ancestor to dir1. child1 and child2 are source and
> > +target in a order according to the rules above and may not necessarily
> > +correspond to the child of dir1 and dir2. Ignore things in angle
> > +brackets for now. The locking order here can not be predetermined. For
> > +instance, rename(/a/x,/b/y) and rename(/b/y,/a/x) would acquire /a and
> > +/b in different order because neither parent is an ancestor of the
> > +other and we lock the parent of source first. But the observation is
> > +that after acquiring the filesystem lock, the precise locking order
> > +becomes known. We introduce a ghost state edge to help define the
> > +ranks (ghost state is a commonly used technique in verification which
> > +has no influence on the program execution and its only role is to
> > +assist the proof).
> > +
> > +  1. lock filesystem (->s_vfs_rename_mutex);
> > +  2. lock dir1->i_rwsem; <set edge to (dir1, dir2)>
> > +  3. lock dir2->i_rwsem; <set edge to (non-parent, child1) if child1 i=
s
> > +     a directory and non-parent is the one in dir1 and dir2 that is no=
t
> > +     parent to child1, otherwise, set edge to None>
> > +  4. lock child1->i_rwsem; <set edge to (child1, child2) if chil1 and
> > +     child2 are directories, otherwise, set edge to None>
> > +  5. lock child2->i_rwsem; <set edge to None>
> > +
> > +The value of edge is either None or (inode1,inode2)
> > +representing a possible lock dependency from inode1 to inode2, i.e.,
> > +some thread may request lock of inode2 with lock of inode1 held. There
> > +is only ever one edge value in a filesystem with edge set to None when
> > +the s_vfs_rename_mutex is not held and edge set to a determined value
> > +when s_vfs_rename_mutex is held. When edge is None, the ranking rules
> > +are the same as before (root is 0 and child is one plus its parent).
> > +When edge is (inode1, inode2), only the ranking rule for inode2
> > +changes: inode2's rank is one plus the larger rank of inode2's parent
> > +and inode1. Intuitively, a directory's rank is the longest distance
> > +from root in the filesystem tree extended with edge.
> > +
> > +Now let's check the setting of edge in angle brackets in above code to
> > +see how it ensures cross-directory rename takes locks in increasing
> > +order in this case. After the lock statement at line 2, edge is set to
> > +(dir1,dir2). Because dir2 is not ancestor to dir1, the rank of dir1
> > +stays the same and the rank of dir2 (as well as every other
> > +directories) can be uniquely determined. So at line 3, dir2's rank is
> > +higher than dir1's. Before the code acquires child1 at line 4, it
> > +already holds dir1 and dir2. We know one of dir1 and dir2 is parent to
> > +child1, so we update edge to (the non-parent of child1, child1).
> > +Because child1 cannot be ancestor to dir1 or dir2, every directory's
> > +rank is still uniquely defined (for the same reason as above). So at
> > +line 4, we ensure child1 has higher rank than dir1 and dir2. Similarly=
,
> > +we update edge to (child1, child2) so that at line 5, child2 has highe=
r
> > +rank than held locks (dir1, dir2 and child1). We reset edge to None
> > +whenever we have acquired all directory locks.
> > +
> > +In a less complex case of cross-directory rename, the code may execute
> > +a prefix of above lines and we always reset edge to None after having
> > +acquired all directory locks.
> > +
> > +The ranking of directories may change under following cases:
> > +
> > +  * directory removal/creation: a directory's rank is removed/added
> > +  * rename: the effect of rename is either (1) moving a subtree under =
a
> > +    node that is outside of the subtree (the directories in the subtre=
e are
> > +    all recalculated based on the node whose rank is not influenced)
> > +    and potentially removing target (a directory's rank is removed) or
> > +    (2) in case of RENAME_EXCHANGE, two subtrees exchange their
> > +    positions. Because source is not a descendent of the target and
> > +    target is not a descendent of source, the parents of the two
> > +    subtrees cannot not be in these subtrees so the ranks of parents
> > +    are not influenced. The two subtrees' ranks are recalculated based
> > +    on their parents
> > +  * edge updates in a cross-directory rename: setting edge to
> > +    (inode1,inode2) or resetting edge to None modify the ranks of the
> > +    inode2 subtree
> > +
> > +Initially in a filesystem, no directory is its own ancestor and
> > +directories' ranks can be uniquely determined. All these changes
> > +preserve the fact that at every time, the ranking of every directory
> > +can be uniquely determined. Thus no directory is its own ancestor
> > +(because if a directory is its own ancestor, its rank cannot be
> > +determined) and we prove the premise. Plus the fact that operations
> > +always take locks in order of increasing rank (can be easily verified)=
.
> > +We can conclude the locking rules above are deadlock-free.
> > +
> >
> >  Note that the check for having a common ancestor in cross-directory
> >  rename is crucial - without it a deadlock would be possible.  Indeed,
> > @@ -247,33 +276,6 @@ distant ancestor.  Add a bunch of rmdir() attempts=
 on all directories
> >  in between (all of those would fail with -ENOTEMPTY, had they ever got=
ten
> >  the locks) and voila - we have a deadlock.
> >
> > -Loop avoidance
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -These operations are guaranteed to avoid loop creation.  Indeed,
> > -the only operation that could introduce loops is cross-directory renam=
e.
> > -Suppose after the operation there is a loop; since there hadn't been s=
uch
> > -loops before the operation, at least on of the nodes in that loop must=
've
> > -had its parent changed.  In other words, the loop must be passing thro=
ugh
> > -the source or, in case of exchange, possibly the target.
> > -
> > -Since the operation has succeeded, neither source nor target could hav=
e
> > -been ancestors of each other.  Therefore the chain of ancestors starti=
ng
> > -in the parent of source could not have passed through the target and
> > -vice versa.  On the other hand, the chain of ancestors of any node cou=
ld
> > -not have passed through the node itself, or we would've had a loop bef=
ore
> > -the operation.  But everything other than source and target has kept
> > -the parent after the operation, so the operation does not change the
> > -chains of ancestors of (ex-)parents of source and target.  In particul=
ar,
> > -those chains must end after a finite number of steps.
> > -
> > -Now consider the loop created by the operation.  It passes through eit=
her
> > -source or target; the next node in the loop would be the ex-parent of
> > -target or source resp.  After that the loop would follow the chain of
> > -ancestors of that parent.  But as we have just shown, that chain must
> > -end after a finite number of steps, which means that it can't be a par=
t
> > -of any loop.  Q.E.D.
> > -
> >  While this locking scheme works for arbitrary DAGs, it relies on
> >  ability to check that directory is a descendent of another object.  Cu=
rrent
> >  implementation assumes that directory graph is a tree.  This assumptio=
n is
> > --
> > 2.30.1 (Apple Git-130)
> >

