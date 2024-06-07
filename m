Return-Path: <linux-fsdevel+bounces-21173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D28DC90030F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5700B284E24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FF419066E;
	Fri,  7 Jun 2024 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoR8h1Wp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2215ADB3
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762311; cv=none; b=EuTO1UcCv2jz8x7zF3hFwNKV6a73SBlnwSinXNef5LrBtXrYD5EekxxXiTYY/5azEuDvbuBG5B7j92zQx8t0UbjkBDUdd+mvQl0kY2/L4o7xP4bfZFcCdpmzt46ZvdW3taLIhn7e8Mvv3DBZOgRS4pidfw/w4fC4R37A924A0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762311; c=relaxed/simple;
	bh=0HTN8oa2Ps7CA9NVx35HXEkZjld8Z37tJ6PvDyEnIEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxqHSfFUNMtJpB/442zc1Gi5UbLfogbkQWP6t3/gO8CZP4Sr/YoUXgjujwDTVxNFUngsA0aif1o06lgnE08PXRH2ZaTxPp5O55aB5NU+EfvSA7QgNGvxdUJlNWT40BunMOk5nfCowGZsdf2eTtB6HAahL9ojCt+lqXJzmBzuQ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoR8h1Wp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so2560992a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jun 2024 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717762308; x=1718367108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UEpT76SZrP8c7rHEWVUTR8+0xsKPiMcCO7tHtPgxQA=;
        b=HoR8h1Wp694feaWThJY5VwLX18pn31sJuXRB3ajAROfoOa9+zkz2uGPY3CR7Xf5fu/
         7MflcJpCJ/lCkd3ZSsY9HnzEgRzL5YH0ABAtWZk3ovabeye2wWYlp1s4gn5kZ1lG5oix
         jPO2/2IZykkeSvrQ2q4IzDzBDtCfOoTTYMqLIqZyk66R69PkF30fNiP0US014U/+oucY
         6Tfjv+/FOkSHb4FE2/3URe4734FB4yFlv+OHSot38RcNAtbJfOFGiWDygBdlHCP4WezL
         quzIEmZaxrqEtW2xcees5n0QGqey4FP9+WV51pTQNSzVjYd+M6aNNmvK1ijoFfBqEVKO
         1m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717762308; x=1718367108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UEpT76SZrP8c7rHEWVUTR8+0xsKPiMcCO7tHtPgxQA=;
        b=TVZU+fsxbx1tlk1inCb10Yfh8gUAbucQ2aeBu66yAfIoRC+lTJeXWm94xAhlc+ifEJ
         ymqCF1P2JTfOwFjp7ktpt/EfuPe+RdMMIrAmvkkAWVaK6QZWKiegh2mmCRHr58kYnRno
         ZZ9m8TOCrSJnyMqFpcjckozeWZMs92oWTbV0XPj6KMaGwz2hAf450L/7M5X4oNUDIy3F
         6u7ghB+0JfUNLc7FcO1JncecBtLvYQseOcYKIbhYf0OWjUT0avezds8Zt1hWxeQfWkbA
         XIFJuCUki/unecpIwASM9I4+imFua0sgdIVfwJNQc6O7smsrOYf2oS+94ZnhdyFfiKEu
         HGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqwLvFTNvsaZZi9DlulUXDvSWI3rHfQSqlc/2moJafPtZ0BfqXjeg1J0AuGcyguKGTPp1syGaSF8L0ZI2JWOJmoRERk7GkBJYY1/ZLeg==
X-Gm-Message-State: AOJu0YyomWWLxaNdjBU8SHft4vAyCdfoV8q/sk8r10duFzIMXvdAGwER
	nyAmcQvyzopC3wbzPE04XHaQJVSZtiJfnBdMeTsdsjCfGYqoyM8XoQi800lMHbuhjfzUWYbUGjc
	zo/bU3TScmRTg4x3z3clC5JgNJ1M=
X-Google-Smtp-Source: AGHT+IFZohFiNWZgvHoDk5azeYlemr4TEXDNY9D6J2XzBFWQE34LSO8xZlLtKWbV8MSK8zDc4Sb/U9/DPdoDxgviWu0=
X-Received: by 2002:a50:d61b:0:b0:57c:41e1:6e59 with SMTP id
 4fb4d7f45d1cf-57c50924b9bmr1525639a12.23.1717762307709; Fri, 07 Jun 2024
 05:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
 <CAJfpegsELV80nfYUP0CvbE=c45re184T4_WtUEhhfRGVmpmpcQ@mail.gmail.com>
 <CAHB1NaiddGRxh7UjaXejWsYnJY52dYDvaB2oZpqQXqVocxTm+w@mail.gmail.com>
 <20240604092757.k5kkc67j3ssnc6um@quack3> <CAHB1NahP14FAMj04D-T-bWs7JAn_mXfmXSeKUEkRbALZrLeqAA@mail.gmail.com>
 <20240605102945.q4nu67xpdwfziiqd@quack3> <CAHB1NajZEy5kPXTcVu9G88WO-uZ5_Q6x3-EkFR4mfG0+XQWD3A@mail.gmail.com>
 <20240606161016.62eskqpsowwb5se2@quack3>
In-Reply-To: <20240606161016.62eskqpsowwb5se2@quack3>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Fri, 7 Jun 2024 20:11:36 +0800
Message-ID: <CAHB1NajyGmgSjo7WVy5CmZAotBaOwyK-hnaVhTD0YycWz71YmA@mail.gmail.com>
Subject: Re: Is is reasonable to support quota in fuse?
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B46=E6=9C=887=E6=97=A5=E5=91=A8=
=E4=BA=94 00:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu 06-06-24 11:14:48, JunChao Sun wrote:
> > Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B46=E6=9C=885=E6=97=A5=E5=
=91=A8=E4=B8=89 18:29=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue 04-06-24 21:49:20, JunChao Sun wrote:
> > > > Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B46=E6=9C=884=E6=97=A5=
=E5=91=A8=E4=BA=8C 17:27=E5=86=99=E9=81=93=EF=BC=9A
> > > > > On Tue 04-06-24 14:54:01, JunChao Sun wrote:
> > > > > > Miklos Szeredi <miklos@szeredi.hu> =E4=BA=8E2024=E5=B9=B46=E6=
=9C=884=E6=97=A5=E5=91=A8=E4=BA=8C 14:40=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > On Mon, 3 Jun 2024 at 13:37, JunChao Sun <sunjunchao2870@gmai=
l.com> wrote:
> > > > > > >
> > > > > > > > Given these challenges, I would like to inquire about the c=
ommunity's
> > > > > > > > perspective on implementing quota functionality at the FUSE=
 kernel
> > > > > > > > part. Is it feasible to implement quota functionality in th=
e FUSE
> > > > > > > > kernel module, allowing users to set quotas for FUSE just a=
s they
> > > > > > > > would for ext4 (e.g., using commands like quotaon /mnt/fuse=
fs or
> > > > > > > > quotaset /mnt/fusefs)?  Would the community consider accept=
ing patches
> > > > > > > > for this feature?
> > > > > > >
> > > > > > >
> > > > > > > > I would say yes, but I have no experience with quota in any=
 way, so
> > > > > > > > cannot help with the details.
> > > > > >
> > > > > > Thanks for your reply. I'd like try to implement this feature.
> > > > >
> > > > > Nice idea! But before you go and spend a lot of time trying to im=
plement
> > > > > something, I suggest that you write down a design how you imagine=
 all this
> > > > > to work and we can talk about it. Questions like: Do you have par=
ticular
> > > > > usecases in mind? Where do you plan to perform the accounting /
> > > > > enforcement? Where do you want to store quota information? How do=
 you want
> > > > > to recover from unclean shutdowns? Etc...
> > > >
> > > > Thanks a lot for your suggestions.
> > > >
> > > > I am reviewing the quota code of ext4 and the fuse code to determin=
e
> > > > if the implementation method used in ext4 can be ported to fuse. Ba=
sed
> > > > on my current understanding, the key issue is that ext4 reserves
> > > > several inodes for quotas and can manage the disk itself, allowing =
it
> > > > to directly flush quota data to the disk blocks corresponding to th=
e
> > > > quota inodes within the kernel.
> > >
> > > Yes.
> > >
> > > > However, fuse does not seem to manage
> > > > the disk itself; it sends all read and write requests to user space
> > > > for completion. Therefore, it may not be possible to directly flush
> > > > the data in the quota inode to the disk in fuse.
> > >
> > > Yes, ext4 uses journalling to keep filesystem state consistent with q=
uota
> > > information. Doing this within FUSE would be rather difficult (essent=
ially
> > > you would have to implement journal within FUSE with will have rather=
 high
> > > performace overhead).
> > >
> > >
> > > > But that's why I'm asking for usecases. For some usecases it may be=
 fine
> > > > that in case of unclean shutdown you run quotacheck program to upda=
te quota
> > > > information based on current usage - non-journalling filesystems us=
e this
> > > > method. So where do you want to use quotas on a FUSE filesystem?
> >
> > Please allow me to ask a silly question. I'm not sure if I correctly
> > understand what you mean by 'unclean shutdown'. Do you mean an
> > inconsistent state that requires using fsck to repair, like in ext4
> > after a sudden power loss, or is it something else only about quota?
>
>
> > No, I mean cases like sudden power loss or kernel crash or similar. How=
ever
> > note that journalling filesystems (such as ext4 or xfs or many others) =
do
> > not require fsck after such event. The journal allows them to recover
> > automatically.

Thanks for your clarification. I understand.

>
> > In my scenario, FUSE (both the kernel and user space parts) acts
> > merely as a proxy. FUSE is based on multiple file systems, and a
> > user's file and directory exists in only one of these file systems. It
> > does not even have its own superblock or inode metadata. When a user
> > performs read or write operations on a specific file, FUSE checks the
> > directory corresponding to this file on each file system to see if the
> > user's file is there; if one is not, it continues to check the next
> > file system.
>
>
> > I see. So your usecase is kind of a filesystem unioning solution and yo=
u
> > want to add quotas on top of that?

Exactly. And all files were written by root, the underlying
filesystem(btrfs) does't support project quota also.

>
> > > > I am considering whether it would be feasible to implement the quot=
a
> > > > inode in user space in a similar manner. For example, users could
> > > > reserve a few regular files that are invisible to actual file syste=
m
> > > > users to store the contents of quota. When updating the quota, the
> > > > user would be notified to flush the quota data to the disk. The
> > > > benefit of this approach is that it can directly reuse the quota
> > > > metadata format from the kernel, users do not need to redesign
> > > > metadata. However, performance might be an issue with this approach=
.
> > >
> > > Yes, storing quota data in some files inside the filesystem is probab=
ly the
> > > easiest way to go. I'd just not bother with flushing because as you s=
ay
> > > the performance would suck in that case.
> >
> > What about using caching and asynchronous updates? For example, in
> > FUSE, allocate some pages to cache the quota data. When updating quota
> > data, write to the cache first and then place the task in a work
> > queue. The work queue will then send the request to user space to
> > complete the actual disk write operation. When there are read
> > requests, the content is read directly from the cache.
>
>
> > So how quota works for filesystems without journaling is that we keep q=
uota
> > information for cached inodes in memory (struct dquot - this is per ID
> > (uid/gid/projid) structure). The quota information is written back to q=
uota
> > file on events like sync(2) (which also handles unmount) or when last i=
node
> > referencing particular dquot structure is reclaimed from memory. There =
is
> > no periodic background writeback for quota structures.

Thanks a lot for your explanation. Got it. I saw that the
f2fs_quota_write() function in f2fs does exactly what you described;
it just writes the data into the page cache. And ioctl Q_SYNC command
or umount syncs all quota data to disk.
Maybe using this method in Fuse is also appropriate.

>
> > The problem with this approach is that asynchronous updates might lead
> > to loss of quota data in the event of a sudden power failure. This
> > seems acceptable to me, but I am not sure if it aligns with the
> > definition of quota. Additionally, this assumes that the quota file
> > will not be very large, which I believe is a reasonable
> > assumption.Perhaps there are some drawbacks I haven't considered?
>
>
> > Yes, quota files are pretty small (for today's standards) as they scale
> > with the number of filesystem users which isn't generally too big. As y=
ou
> > observe, quota information will not be uptodate in the event of powerfa=
il
> > or similar. That is the reason why administrator (or init scripts) are
> > responsible for calling quotacheck(8) for filesystems when unclean shut=
down
> > is detected. Quotacheck(8) scans the whole filesystem, summarizes disk
> > usage for each user, group, etc. and updates the information in the quo=
ta
> > file.

So the time it takes to execute quotacheck is also directly
proportional to the size of the file system, right? The larger the
file system, the longer quotacheck takes to run, regardless of the
number of users or groups, because quotacheck needs to scan the entire
file system.

>
> > Regarding the enforcement of quota limits, I plan to perform this in
> > the kernel. For project quotas, the kernel can know how much space and
> > how many inodes are being used by the corresponding project ID. For
> > now, I only want to implement project quota because I believe that
> > user and group quotas can be simulated using project quotas.
>
>
> > This is not true. First and formost, owner of a file can arbitrarily ch=
ange
> > its projid while unpriviledged user cannot set file's owner. So there i=
s no
> > way for user to escape user quota accounting while project quota accoun=
ting
> > is more or less cooperative space tracking feature (this is different w=
ith
> > user namespaces but your usecase does not sound like it depends on them=
).
> > Similarly file's group can be set only to groups user is a member of.
> > Finally you can have smaller user limits and bigger group limits which
> > constrain a group of users which is not possible to do just with projec=
t
> > quotas.

Yes, you're right. They work in conjunction. User quotas cannot be
replaced by project quotas.

>
> > Additionally, users' definitions of file system users and groups might
> > differ from file UID and GID. Users can freely use project IDs to
> > define file system users and groups.
>
>
> > Well, if UIDs in the filesystem do not match current system view of use=
rs,
> > you have a larger problem be permission checking etc. So I'm not sure I
> > understand your comment here. But anyway if you are convinced project
> > quotas are the right solution for your usecase then I don't object. Fro=
m
> > kernel POV there's no fundamental difference.

Yes, the permission checking was done by upper applications.
Thanks again for your comments! They are really helpful.

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


Best regards,
--=20
Junchao Sun <sunjunchao2870@gmail.com>

