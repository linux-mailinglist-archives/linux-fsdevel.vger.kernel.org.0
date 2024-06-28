Return-Path: <linux-fsdevel+bounces-22792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C313791C233
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EF41F21C21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0981C233B;
	Fri, 28 Jun 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TygS0awq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC841BF336
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587611; cv=none; b=dBmwKR7lEUO09lT1r+Q9Fe7l9CZ7eraSjIroBChTYlJglRJA/JQtmOfCTYEM5wN/+/8ujV1OHw91u+o/XLO/8mq4v42MYca2WCorrFqL4qfAn3N/MVqi/zluIKfqIS6PWJ+7zX3Rwd5HMcp2V7gFoGDLgdNG8kKk0QzfR+Padpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587611; c=relaxed/simple;
	bh=/RsLrIy7792uAmwaSU0cpjm4eTNuzbhKlWq/Nw06Kdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnvtXw+MCmj9ON0ijcmCOD8q72azJNjDBMCvwGkSpo0/tz+lRbfw9eH6Cmk5B3k5alOSNyryUouMUp7PT7Gc+EX+48V8Dy+POisIPt7WcEaA2Nw+zbV0AssVF7KDUB43dR3GdIWinP9MoGfBLnA5DocwkpsDcWezJ6uMo3hRh7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TygS0awq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719587608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrMxFlkvF5Xx3kyh2gKy3OS40cVo8d/2WmP45b5pzjM=;
	b=TygS0awqTjIQBGBO5qwP6b69F8RgPhGGC+K+1wGvircz4YBCsWLJsFL2cBINxdLIQZTlMI
	bZFV8pTDbGA/dlvYdth5OvD7NW4tBJxC2tyj0IAdvEHC5/A6SgcH2b3UCA/SiFPiY8nd+7
	XJhDhzyEvZdm5PXkaEzmABHksA9QA+0=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-4pjVzqnhPSCELFRs4SLV7Q-1; Fri, 28 Jun 2024 11:13:25 -0400
X-MC-Unique: 4pjVzqnhPSCELFRs4SLV7Q-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-375beb12e67so8121805ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 08:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587602; x=1720192402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrMxFlkvF5Xx3kyh2gKy3OS40cVo8d/2WmP45b5pzjM=;
        b=AxUcW1w0rS/t6AluH5zVjAOP0LtaAXX787AJKDuuq9DWfMqP7DJRy05tqe71SP8bTs
         wuDQC7MBBO1HDymDmYuY+ZEpJFdI5tk2LAiGt4hOfYWAQCzctrZs+Xl2tYYg3P0g4lt5
         1JHcPbup516NLP7KSvcWDxLakb86gbfErRsuBaIvs60oiwq3+7jsV/fsdDv9cwd7wrCH
         TcUMtTz2vIP/UCbqN8NyNwVnyYOeZzHnPz3pNx7d5q0m+1sAmXT8TNKtz6QKG6bVnxg8
         VvIYq9102e5mvF6Fvlw/3BZ4a6ik4cmwtuM8/eSz9HerECDCRkqZ2Oar0qbrbg/1FPvy
         k1DQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9+dZPqcmw8505PgUBtLGCYqdEqLA4bxwesjtFMol/9sc9wtOK3W5Ob+sUgesecPaqq0JoYh3nTW/o8BllxF38NRFBYiu3LP3KGeoiDA==
X-Gm-Message-State: AOJu0YwWVIMtnnm+suhejf3byjag0CexeQYNeWcXEXj9JfMP7Zd3KEM/
	Z4k+ESM1+MM19jV3yXe0g7Yt13pIJ6/HChZNx/kz4V0bMUoB3Zim2UnH3I46fhEKcJQIy9Xc6V2
	l0uJrFMhek0Nts61LR305PDkq+cGPA0dwZE7pflqfUPbA5KuuCVrW670+uvQtvyllmvCnlkGDzU
	IBk7aqU1/aLdiX24qNWq++Oc/fWupAVPEqQyM9lFg9x+WL+Q==
X-Received: by 2002:a05:6e02:1a84:b0:374:a14e:1485 with SMTP id e9e14a558f8ab-3763f605265mr200274495ab.11.1719587601841;
        Fri, 28 Jun 2024 08:13:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKmwTuaYeKLPivP+QG5odpKM3D6WTn+vaMZ3Tdn8xSndTcK66bsRPw0+hVD1sOv0XQNOn7pKlz3aoefpWuMLQ=
X-Received: by 2002:a05:6e02:1a84:b0:374:a14e:1485 with SMTP id
 e9e14a558f8ab-3763f605265mr200274205ab.11.1719587601450; Fri, 28 Jun 2024
 08:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626201129.272750-2-lkarpins@redhat.com> <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org> <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3> <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com> <20240628-gelingen-erben-0f6e14049e68@brauner>
In-Reply-To: <20240628-gelingen-erben-0f6e14049e68@brauner>
From: Alexander Larsson <alexl@redhat.com>
Date: Fri, 28 Jun 2024 17:13:10 +0200
Message-ID: <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>
Cc: Ian Kent <ikent@redhat.com>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk, raven@themaw.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Chanudet <echanude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 2:54=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Jun 28, 2024 at 11:17:43AM GMT, Ian Kent wrote:
> >
> > On 27/6/24 23:16, Christian Brauner wrote:
> > > On Thu, Jun 27, 2024 at 01:54:18PM GMT, Jan Kara wrote:
> > > > On Thu 27-06-24 09:11:14, Ian Kent wrote:
> > > > > On 27/6/24 04:47, Matthew Wilcox wrote:
> > > > > > On Wed, Jun 26, 2024 at 04:07:49PM -0400, Lucas Karpinski wrote=
:
> > > > > > > +++ b/fs/namespace.c
> > > > > > > @@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_af=
ter_init;
> > > > > > >    static DECLARE_RWSEM(namespace_sem);
> > > > > > >    static HLIST_HEAD(unmounted);    /* protected by namespace=
_sem */
> > > > > > >    static LIST_HEAD(ex_mountpoints); /* protected by namespac=
e_sem */
> > > > > > > +static bool lazy_unlock =3D false; /* protected by namespace=
_sem */
> > > > > > That's a pretty ugly way of doing it.  How about this?
> > > > > Ha!
> > > > >
> > > > > That was my original thought but I also didn't much like changing=
 all the
> > > > > callers.
> > > > >
> > > > > I don't really like the proliferation of these small helper funct=
ions either
> > > > > but if everyone
> > > > >
> > > > > is happy to do this I think it's a great idea.
> > > > So I know you've suggested removing synchronize_rcu_expedited() cal=
l in
> > > > your comment to v2. But I wonder why is it safe? I *thought*
> > > > synchronize_rcu_expedited() is there to synchronize the dropping of=
 the
> > > > last mnt reference (and maybe something else) - see the comment at =
the
> > > > beginning of mntput_no_expire() - and this change would break that?
> > > Yes. During umount mnt->mnt_ns will be set to NULL with namespace_sem
> > > and the mount seqlock held. mntput() doesn't acquire namespace_sem as
> > > that would get rather problematic during path lookup. It also elides
> > > lock_mount_hash() by looking at mnt->mnt_ns because that's set to NUL=
L
> > > when a mount is actually unmounted.
> > >
> > > So iirc synchronize_rcu_expedited() will ensure that it is actually t=
he
> > > system call that shuts down all the mounts it put on the umounted lis=
t
> > > and not some other task that also called mntput() as that would cause
> > > pretty blatant EBUSY issues.
> > >
> > > So callers that come before mnt->mnt_ns =3D NULL simply return of cou=
rse
> > > but callers that come after mnt->mnt_ns =3D NULL will acquire
> > > lock_mount_hash() _under_ rcu_read_lock(). These callers see an eleva=
ted
> > > reference count and thus simply return while namespace_lock()'s
> > > synchronize_rcu_expedited() prevents the system call from making
> > > progress.
> > >
> > > But I also don't see it working without risk even with MNT_DETACH. It
> > > still has potential to cause issues in userspace. Any program that
> > > always passes MNT_DETACH simply to ensure that even in the very rare
> > > case that a mount might still be busy is unmounted might now end up
> > > seeing increased EBUSY failures for mounts that didn't actually need =
to
> > > be unmounted with MNT_DETACH. In other words, this is only inocuous i=
f
> > > userspace only uses MNT_DETACH for stuff they actually know is busy w=
hen
> > > they're trying to unmount. And I don't think that's the case.
> > >
> > I'm sorry but how does an MNT_DETACH umount system call return EBUSY, I
> > can't
> >
> > see how that can happen?
>
> Not the umount() call is the problem. Say you have the following
> sequence:
>
> (1) mount(ext4-device, /mnt)
>     umount(/mnt, 0)
>     mount(ext4-device, /mnt)
>
> If that ext4 filesystem isn't in use anymore then umount() will succeed.
> The same task can immediately issue a second mount() call on the same
> device and it must succeed.
>
> Today the behavior for this is the same whether or no the caller uses
> MNT_DETACH. So:
>
> (2) mount(ext4-device, /mnt)
>     umount(/mnt, MNT_DETACH)
>     mount(ext4-device, /mnt)
>
> All that MNT_DETACH does is to skip the check for busy mounts otherwise
> it's identical to a regular umount. So (1) and (2) will behave the same
> as long as the filesystem isn't used anymore.
>
> But afaict with your changes this wouldn't be true anymore. If someone
> uses (2) on a filesystem that isn't busy then they might end up getting
> EBUSY on the second mount. And if I'm right then that's potentially a
> rather visible change.

This is rather unfortunate, as the synchronize_rcu call is quite
expensive. In particular on a real-time kernel where there are no
expedited RCUs. This is causing container startup to be slow, as there
are several umount(MNT_DETACH) happening during container setup (after
the pivot_root, etc).

Maybe we can add a umount flag for users that don't need the current
behaviour wrt EBUSY? In the container usecase the important part is
that the old mounts are disconnected from the child namespace and not
really what the mount busy state is (typically it is still mounted in
the parent namespace anyway).

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com


