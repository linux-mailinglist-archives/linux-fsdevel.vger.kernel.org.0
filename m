Return-Path: <linux-fsdevel+bounces-60479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF14B484CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588D8189AF4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 07:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805812E3AE6;
	Mon,  8 Sep 2025 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmZjwRPU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206C63B7A8
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315360; cv=none; b=EJrGfwn2No1Mjzf67ES2ZxvHFs7pvzjp872qVYXdoeeATyiId2jJrHn8F2F9sQw9L5QzsJJ//j4LmPOT0MfCXZt6wCkfMYpqtVO5rtePsbpYLKDinhw52WcHw9xCfPbC9hxGrCcQjcVEygvUilgeiisWHiv2/dsvaeHxvQOZOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315360; c=relaxed/simple;
	bh=m1M5d14TRNaIu3tPjXJOmy1RXkqYM3pS7VFfyJHpz9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U15muJM7qANYbdIdOQyv+L4l3t+QPd8Jcd4WGUidXZM34Kibyc07eRZMZaBVYG1NZsYXIbNZdQYuyvLmZY+8aENF5JPw+AXEomdLohzBNIRuiOjyVCeYP15xHggsmSXEFI+pvjw2H4JLBCl+wocg93n+BDgx5YCL4/SXCUoacqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmZjwRPU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b04271cfc3eso550143566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Sep 2025 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757315357; x=1757920157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjOt7lbujIKT5HiahgbSCYSdWv/nA9zcsRUCoM30KYw=;
        b=bmZjwRPUggIF4R+RXaPOKg5PxyRepb6NgmpiiXibkeylCCHmTVfRQNmMqTI7xeRXAA
         RhPs9kX9+8HDBPp0hNMFwNUrsfT6C2zxkPqhvV0k4EjVdYP0r1jnUAdXzYKokPSc1qs6
         QqJEY4k0g2bnG0sFMMK0nd0jYfNPI2qE//nsa5Ofe2PxvjWg7zUc4eCfzPpTgClOvEHM
         ZknOSm9BWx7CWoFgZAwD0c6+3DthOLABfBVlFzKunzODpIyLTFN35EbqsO5cFtDIKS71
         Eg9320zqmOmXJ68wehK9V0IKUjF3mnQJpf9gsGxoOLcEbORAqP3UtBgja1wGAn44mfzY
         erxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757315357; x=1757920157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjOt7lbujIKT5HiahgbSCYSdWv/nA9zcsRUCoM30KYw=;
        b=MVisxEr7MLTJLMh17j5LsZqKRThojytiK5xWJgUngrWdbaaqcuvwNZfh6X8pRhHJLz
         od3naWJoxQsEqh2nuqYiRxqNPEBNs2h+2LhxVuh/Gi+w4cLLh+YzHzNBT/MKtGCBmUxE
         EAI8499cd+HvoSxSota/MC51A7toYdGN2myMoRQoiaVaZ6Xky3OkPBN64jvqfrTqy1gG
         JqbFniwOSqFpotW8C/sXqqlcrnHgBWEFwoB2vlIIq3cpjPqFYAix7FLKWFgXohuHIsy9
         wV+5auqfJdy6UoF+0OCu5rUBY7WdMz1lOnTIpipOhDKEZF55DL9flZBYTvaTnG3I0md7
         SPqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWewb/MBfdBCb3hjrDGbQpHpuPiSil/UzdN+7nVJwLtbUOuapx/2h7QJvXzbu5DE2aBCsun8lQSibSY3gr0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0IV04mJxH/abBJGjzYqGpNRz2x+6HDDmObq5ivjLwnApW3Rz
	5lp+mTsKlzB3Kj2QVlAXCbr8oSQiE0BviVWpg3jcwvdfBsoHyvSxBpemqwN+aEClcwd0Rk+EyVB
	EezHhkbGy6ivNrKDpiGY9EOT3q2UqZxs=
X-Gm-Gg: ASbGncuHcjPOjVm9TtHYlhNnmGQn1Vx+bKJuY4vUoXIew8Z/h/F/3oqbJEOtnx5ZNgv
	OhxVMOGcPLSsOFXy1+mahGt7Pd32Is8c4pTu6zbxZ0xCUiy/V9WQqVM0QY5ydl2rhrQ/I4obC36
	O79IAzcTsytXVQYRvIzO2SArQ7PnGbCH8GtD7z8b6hJYmAa+jw1dtgo5C/EE/3A9b6YAivY4mwC
	Je5w7zl8+h3oqNxjA==
X-Google-Smtp-Source: AGHT+IEV6+//eUjc7g7m7jTYBlgcICPdKCA6Ozms2rhmo+rI9u6PordLmuVfY8ChLsLEXppTsFWNcWN5T4TN6G2NPVs=
X-Received: by 2002:a17:906:6a16:b0:aff:17a2:629 with SMTP id
 a640c23a62f3a-b04b13d0af1mr679406366b.3.1757315357125; Mon, 08 Sep 2025
 00:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhnvYeJiZ9Bd73kwu3y4VCeeJCvNN1K+GExxF4koA+bxA@mail.gmail.com>
 <175729725709.2850467.826431423203156062@noble.neil.brown.name>
In-Reply-To: <175729725709.2850467.826431423203156062@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 8 Sep 2025 09:09:05 +0200
X-Gm-Features: Ac12FXzvaUlaK8eU7ndXvqxcpUgkZeKJEwrrgSl6yqhoAp2gpy9V80mzNbbkZGk
Message-ID: <CAOQ4uxh8E9G=JH3S-SMFe9RHFTy7J3jHg-Kw5-pApJF1UmOV-Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] VFS/ovl: add lookup_one_positive_killable()
To: NeilBrown <neilb@ownmail.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 4:07=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> On Sat, 06 Sep 2025, Amir Goldstein wrote:
> > On Sat, Sep 6, 2025 at 7:00=E2=80=AFAM NeilBrown <neilb@ownmail.net> wr=
ote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > ovl wants a lookup which won't block on a fatal signal.
> > > It currently uses down_write_killable() and then repeated
> > > calls to lookup_one()
> > >
> > > The lock may not be needed if the name is already in the dcache and i=
t
> > > aid proposed future changes if the locking is kept internal to namei.=
c
> > >
> > > So this patch adds lookup_one_positive_killable() which is like
> > > lookup_one_positive() but will abort in the face of a fatal signal.
> > > overlayfs is changed to use this.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> >
> > I think the commit should mention that this changes from
> > inode_lock_killable() to inode_lock_shared_killable() on the
> > underlying dir inode which is a good thing for this scope.
> >
> > BTW I was reading the git history that led to down_write_killable()
> > in this code and I had noticed that commit 3e32715496707
> > ("vfs: get rid of old '->iterate' directory operation") has made
> > the ovl directory iteration non-killable when promoting the read
> > lock on the ovl directory to write lock.
>
> hmmmm....
>
> So the reason that this uses a killable lock is simply because it used
> to happen under readdir and readdir uses a killable lock.  Is that
> right?

I think the semantics were copied from readdir of that moment yes.

>
> So there is no particularly reason that "killable" is important here?

I can think of some reasons -
Maybe overlayfs (ever user mounted overlayfs) has just one process
accessing it but underlying lower layer is remote fs with many processes
accessing it so chances of lower layer dir lock being held by another threa=
d
are much higher than chances of overlayfs dir lock being held.

> So I could simply change it to use lookup_one_positive() and you
> wouldn't mind?
>

I do mind and prefer that you keep this killable as you patch does.
The more important reason to keep this killable IMO is that we can and
should make overlayfs readdir shared lock one day.

> I'd actually like to make all directory/dentry locking killable - I
> don't think there is any downside.  But I don't want to try pushing that
> until my current exercise is finished.
>

The path to making overlayfs readdir shared and killable is
to move the synchronization of ovl readdir cache and
OVL_I(inode)->version from the implicit vfs inode_lock() to
explicit ovl_inode_lock().

The mechanical change is easy.
My concern is from hidden assumptions in the code that
I am not aware of, ones which are not annotated with
inode_is_locked() like ovl_inode_version_get() and
ovl_dir_version_inc() are.

And the fact that noone has yet to complain about overlayfs readdir
scalability makes this conversion non urgent.

If you have other reasons to want to make ovl readdir killable
or shared, we can look into that.

Thanks,
Amir.

