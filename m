Return-Path: <linux-fsdevel+bounces-57897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0763B26823
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E155B9E1DAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4898B3019C4;
	Thu, 14 Aug 2025 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVmMjtHj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF48301498;
	Thu, 14 Aug 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179289; cv=none; b=rTb5V07GBWZngK/qCP0C9WgsTwe6o0sQmZsLzHszyi+XWUaRUt3iZrgDNx5CDbWEyYGpjizCyhYyzmh17lvpa8AgUAPiC6IxsbGiXtKa6b7hOK01QjUWE9fOs0VQc73g3sbBocreBgxU1QeergeEYDIlxQXNJl2g3wB0Rjlj+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179289; c=relaxed/simple;
	bh=3nDch1TwnwnOFxnyGs00pASm7HAHD3urGrnQFPRpJis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISiDJqpCuCcWbMBThjKavPdFwKr82cnx7yVtYf27l4lUPZqj5bg4C7uErbDQXVNuutY9xYUK2c8GFdj95JfX0k8tEcmEm5SiM18fI2mq2z8H2nyH5rKqGTyF3+Bf+VTqVw0It7uUMRrbpe1gdApk2JeyuvLKaPjcku1MlO8+oaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVmMjtHj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b5b11b2so1238311a12.0;
        Thu, 14 Aug 2025 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755179285; x=1755784085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kknE7rDUjEpODcHDSlY2nJGg21LqzdjsCFp42JS4Ico=;
        b=SVmMjtHjyDWUAv8RYC77foqLZ64FkzLAVO+E5YBxcj8zgauvxcJk6RQKFlux1yLNP3
         3f8HP4YvicdbqH91iKsn5YwEc/Faeoq8bMx9a4nQVr0R1TqBvK7ixdfK8UNiQB1YXv99
         +24TYdIYlFoamRmOz44EZEBIq3rMS3LRQ1PlqRzBUR2ekMDCG5M7X3VoCvLejlYC8xDF
         xLlHn1ESboMXuSUZsbpJOYP7eu65BRT5rJdCXn5jCNPAOao3AaXUUFlojJcc12OxvV7H
         Bdj8/FiIZdn17RsylTeCamTst6WBS6+HDdp6dfOIiRGoRv7plTGlO4lNY/ooVDbO94uy
         rtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179285; x=1755784085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kknE7rDUjEpODcHDSlY2nJGg21LqzdjsCFp42JS4Ico=;
        b=SPVIOlOPdCjDSEM/Ppi851QV7x6H7Rrdcj9Z7+nxnfwRi5lrriGZ10ply2ppexLA9E
         OJutZ01AUg87uKyVwSNzf9VmQAQGewuj4zGHcSylYbqtJ9RC6Gw6H9yYxnDyHpghRhSx
         /yuAdPfLZdTThdE7iBDtXdryOHumP7zHnUMwZ1dV61uKaK4/CpCQKZys9ocjZLu2HA5p
         WBCPLdADBFCPSbNQwpqMfk/9sunTZCSpAu5T08gMWjjtWi7M3QJMgDKxhWfmEW974aLn
         YFlFc8jzZjEPOd4qK7KKxUcglNOBL/4bs6gkfWELJoTewbYtpAanVi5ZbaWO5kfLSguT
         a6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUPPd1yk+8bkQrdGZayvR3aO78+O39btGP4Hg/Vu1+zg9fvek6R30uUMbHgI0Xzm/maRVLIFTbJA44FiBCJhg==@vger.kernel.org, AJvYcCVGOth4jlR3SQK+ZjfZSmXur7Z0B7o+yLMBEt8s7LC5RBhboqwWeU8iZesqAm9zEnU3/t3VOXJc0962@vger.kernel.org, AJvYcCVjuTGjcKpOuYDJ+gJwWPVw1c5ceo70617t82C6UtPyiwjyz9FpDUMnVPtWkrdFSXeSQt2sQ63QfetI@vger.kernel.org, AJvYcCVw87kqUXv8fkx7nEoilm+uwX5s2QVqNhQwS+FOdRA0nS2w2X6R3vRsL5dHarFu6Key81Uq7HjJgiP4+LM2bA==@vger.kernel.org, AJvYcCW4YVL5ezYSSVLmHS7BA9ubQHEnKVVdNceS8VycGNlj4W8XNSygxfo+BTnmFlC4kSM9DD/vPYcdcdVfXNpW@vger.kernel.org, AJvYcCWK+onlHzVxCAewGSF1hJjxiow87uTEGD0HfXpY41jEkD295G0NE6+y/fckuTvoYh4cMgnFjJ6EIOM=@vger.kernel.org, AJvYcCWrlqX8T5H4KCYH05jz+USPJ/2B6g6X+3LKDD8Wgpl5HPtX0FqJyZer/JW286eHzJkIY30GLGqeA7aM@vger.kernel.org, AJvYcCXD0cTu8rngZ1WDlNbtJjQe7YY7IYOl4P9e6IV5cK9E+jORsKjKH0DpkI07YMSJwA9xnDSIwPRiW41PIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjWpIxv9ccUFwMoKZLhoC0Wrop8ActjLNQpy8P6UM47aYKfLK
	ZX3rLpUvYlfSrO0yECTO1djyptq42TM9UEHWhiwT5EDzrlVXzB7UCMFSAipPGnhR0p9KMsCvT0n
	Xx76BT5aGZhJ/gcvO8cdwDrnfYle1pdU=
X-Gm-Gg: ASbGncsJF2IVjEnva+sKKHYhcBv4pR0ab5eZJxUvkm6Cg+LoHAcOh39ibttib2NILjZ
	oKWxN4AR1fbjptTI2L2ZCrdYHavCnuhgbH6eoWrdJ/TPgIjkKGZVHp9yK07lW0hlMJCkSYstbOl
	7A8VrOP6a1OFohWsFoHGJ5upHMu9Zawow2AgoKx424V5ZfqiMnf9hNzwsvxUO5KXzgTzIgsgF/w
	Ev3Ceo=
X-Google-Smtp-Source: AGHT+IEyNlWqeAhk/LpScYt9w4g0zV4KI7o0RDFgyEsYgfPOIWzZIEz6LWnNRfl0s84eTTaO2QcDUYXHT6IzkeoX6zs=
X-Received: by 2002:a05:6402:348e:b0:617:b2ab:fba2 with SMTP id
 4fb4d7f45d1cf-6188c1f81c9mr2881340a12.34.1755179284840; Thu, 14 Aug 2025
 06:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813065333.GG222315@ZenIV> <175513726277.2234665.5395852687971371437@noble.neil.brown.name>
In-Reply-To: <175513726277.2234665.5395852687971371437@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 15:47:53 +0200
X-Gm-Features: Ac12FXwtQAorrE4W3bWM28WxLsn_dOcgt6iMm2QuEDqDEmfUynv58IGzMVEJihs
Message-ID: <CAOQ4uxjOvsfV7o5Mnn_VBKYCR15FkmQBDASvwq0UQKPwxh1H2g@mail.gmail.com>
Subject: Re: [PATCH 11/11] VFS: introduce d_alloc_noblock() and d_alloc_locked()
To: NeilBrown <neil@brown.name>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve French <sfrench@samba.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-afs@lists.infradead.org, netfs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 4:08=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> On Wed, 13 Aug 2025, Al Viro wrote:
> > On Tue, Aug 12, 2025 at 12:25:14PM +1000, NeilBrown wrote:
> > > Several filesystems use the results of readdir to prime the dcache.
> > > These filesystems use d_alloc_parallel() which can block if there is =
a
> > > concurrent lookup.  Blocking in that case is pointless as the lookup
> > > will add info to the dcache and there is no value in the readdir wait=
ing
> > > to see if it should add the info too.
> > >
> > > Also these calls to d_alloc_parallel() are made while the parent
> > > directory is locked.  A proposed change to locking will lock the pare=
nt
> > > later, after d_alloc_parallel().  This means it won't be safe to wait=
 in
> > > d_alloc_parallel() while holding the directory lock.
> > >
> > > So this patch introduces d_alloc_noblock() which doesn't block
> > > but instead returns ERR_PTR(-EWOULDBLOCK).  Filesystems that prime th=
e
> > > dcache now use that and ignore -EWOULDBLOCK errors as harmless.
> > >
> > > A few filesystems need more than -EWOULDBLOCK - they need to be able =
to
> > > create the missing dentry within the readdir.  procfs is a good examp=
le
> > > as the inode number is not known until the lookup completes, so readd=
ir
> > > must perform a full lookup.
> > >
> > > For these filesystems d_alloc_locked() is provided.  It will return a
> > > dentry which is already d_in_lookup() but will also lock it against
> > > concurrent lookup.  The filesystem's ->lookup function must co-operat=
e
> > > by calling lock_lookup() before proceeding with the lookup.  This way=
 we
> > > can ensure exclusion between a lookup performed in ->iterate_shared a=
nd
> > > a lookup performed in ->lookup.  Currently this exclusion is provided=
 by
> > > waiting in d_wait_lookup().  The proposed changed to dir locking will
> > > mean that calling d_wait_lookup() (in readdir) while already holding
> > > i_rwsem could deadlock.
> >
> > The last one is playing fast and loose with one assertion that is used
> > in quite a few places in correctness proofs - that the only thing other
> > threads do to in-lookup dentries is waiting on them (and that - only
> > in d_wait_lookup()).  I can't tell whether it will be a problem without
> > seeing what you do in the users of that thing, but that creates an
> > unpleasant areas to watch out for in the future ;-/
>
> Yeah, it's not my favourite part of the series.
>
> >
> > Which filesystems are those, aside of procfs?
> >
>
> afs in afs_lookup_atsys().  While looking up a name that ends "@sys" it
> need to look up the prefix with various alternate suffixes appended.
> So this isn't readdir related, but is a lookup-within-a-lookup.
>
> The use of d_add_ci() in xfs is the same basic pattern.
>
> overlayfs does something in ovl_lookup_real_one() that I don't
> understand yet but it seems to need a lookup while the directory is
> locked.

We decoded a connected real directory path (from file handle) and we
are trying to lookup in overlay a directory that is referencing the
underlying real dir that we decoded.

This is the context. Not sure what problem exactly this code gives you.

>
> ovl_cache_update is in the ovl iterate_shared code (which in fact holds
> an exclusive lock).  I think this is the same pattern as procfs in that
> an inode number needs to be allocated at lookup time, but there might be
> more too it.
>

It's kind of a hack I guess.
ovl has those rules (see xino) to compose a consistent inode number
from real inode number and layer number.
lookup of children during readdir composes the child stack to realize
the consistent xino.

We could do this internally in ovl by doing lookups on the real layers
and composing the xino, but calling lookup on ovl during readdir was
so much easier :/

Thanks,
Amir.

