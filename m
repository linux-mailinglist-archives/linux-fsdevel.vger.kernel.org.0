Return-Path: <linux-fsdevel+bounces-21894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB890D97B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 18:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9570628685D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15B67F482;
	Tue, 18 Jun 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCJs97BY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8457374070;
	Tue, 18 Jun 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728839; cv=none; b=Hs+Hb27kgGURiXt9gEJ/86Doe2fk3vlZvdjTh6o9uLQQNCXKVkQTC4Ej0xkOI1sYcJXllLTMuxLJXlA0r+f681E5muq7qXbO/gVFnKpcOkn4+O+6fbm7eiGBn1G4lyFZc8x84eENQf0N//8KYS1MWiyYoCNVXFvmYEybW8jm5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728839; c=relaxed/simple;
	bh=OwxC3S19dopA5PlP4y+XYkiojTfqjif0NyiAvdYxeUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSWrPna/Qqoey49ZTCLgS+9PHpc8EjEDT6oU1NsL1oytZyBH/oKJduhVkv6EcKvglzn7mHJ5K23MslBk6NM2WnkV204cR3DUgrcUnJbMMfFSfdghDUARCBK7h+2NKz/OL9WGEW9FQF/OzhSrSuLW4YBtbqr9LOvahR97Jaw2KSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCJs97BY; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so1569363a12.3;
        Tue, 18 Jun 2024 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718728836; x=1719333636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbjVgCulRo1Vco8eVnD2Q4EDoqgEDO/7yOIxjMGR0KM=;
        b=XCJs97BYzoXBVchCAeF3I0nH46/WqT5nukyixSsGVeHwzlJpRo59gze6uFp/vZmtKo
         7pHYrT28K/KSXnUufAnfHCh+5AK/Yc+A2UuDa5wh/UM8OCjewJp4b7YJYiWJbEoA5OiD
         v8EdAzERHkmJNFZ1xNjs77ncevhBjSvxrjp5LuTM9P4hX838DYnGgFQd8BrJ3/LRNqi9
         H0ITM2egRU71ElyerHi6PgXu260VnVXCeuPzz7v8kC+vdyoXG4eWOTr1Jzh1kdDLJ8Fy
         e4CZJ3p+e1bILvuH0esEh/3WVhpWywI9/IrDMTR2zCwVBvU2fh6bzjdsdxzRHO20EiOy
         N+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718728836; x=1719333636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbjVgCulRo1Vco8eVnD2Q4EDoqgEDO/7yOIxjMGR0KM=;
        b=hfK2XFwcDl+p86lpntqlemmmP69UmJCXXg2F/RvfgRz/9u1ndf07IZWP6LQT6rFSFo
         HFRfKQkpv1qUv94G1LWUllJRdooiKWtv+kuMhfeF8ktxIJ8akDHttIXkBjGp3G5vpKlX
         D5o0UHTlGbhJGFighNFiBDSAuNGcXMEbmb517mG48aVdUnPpORjRAHZee0zvAAmDuAyy
         y4zAC9vL2Pwj/C4bxwmQNTNz3Ea1hovjuAEYR/eLwHrrfcI59/cjipIDPpIXNb2enq42
         JZxoEFNaLlAUQBk6Px8tZxTCFzQ06UBMo48nkIKUze8qqmq/zVqSgxf71l8WktL4ElXV
         1BBw==
X-Forwarded-Encrypted: i=1; AJvYcCVtXpVVhG781NDZYLw8TVk6MSjqxFTQhIRZNgvm/OScvvtT3HUFqgBknKIxp7TZze1m4OQM0IsYS6EWc72ucjCZRE+9f4sFrKA7
X-Gm-Message-State: AOJu0Yz09VGzrD0CGJtyMhkBfxVGXCafHB5+C9zLlJTYdMMNJ9HuInKc
	QUAY5+rMJnzPmT9+G9uWUF8QlJBY3Q1ycjA3an2gkVbtTwOQH9kZkpPdviIeksKgzYV+MREYhgC
	m14uPvbJudbBDDL/FWp4VxXl2hwjHADUXRJlt1Q==
X-Google-Smtp-Source: AGHT+IH1UiFGx2mq2KW5eXnZQiDr/5YShiRqGBtJpDsAfkAPVON5m/62TfC/yWJ3xz5XDQ0OtxBLnIDKNIWXl5BLb2c=
X-Received: by 2002:a50:cdc4:0:b0:57c:6d1c:3cee with SMTP id
 4fb4d7f45d1cf-57d07e7bba6mr21174a12.14.1718728835488; Tue, 18 Jun 2024
 09:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618113505.476072-1-sunjunchao2870@gmail.com> <20240618162327.GE103034@frogsfrogsfrogs>
In-Reply-To: <20240618162327.GE103034@frogsfrogsfrogs>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Tue, 18 Jun 2024 12:40:23 -0400
Message-ID: <CAHB1NajUvCmPK_fTVgpdXz--Qn69Ttx5W4k9Xbq18MbarzUfVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] xfs: reorder xfs_inode structure elements to remove
 unneeded padding.
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	chandan.babu@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Darrick J. Wong <djwong@kernel.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=BA=8C 12:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 18, 2024 at 07:35:04PM +0800, Junchao Sun wrote:
> > By reordering the elements in the xfs_inode structure, we can
> > reduce the padding needed on an x86_64 system by 8 bytes.
>
>
> > Does this result in denser packing of xfs_inode objects in the slab
> > page?

No. Before applying the patch, the size of xfs_inode is 1800 bytes
with my config, and after applying the patch, the size is 1792 bytes.
This slight reduction does not result in a denser packing of xfs_inode
objects within a single page.

>
> --D
>
> > Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
> > ---
> >  fs/xfs/xfs_inode.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > index 292b90b5f2ac..3239ae4e33d2 100644
> > --- a/fs/xfs/xfs_inode.h
> > +++ b/fs/xfs/xfs_inode.h
> > @@ -40,8 +40,8 @@ typedef struct xfs_inode {
> >       /* Transaction and locking information. */
> >       struct xfs_inode_log_item *i_itemp;     /* logging information */
> >       struct rw_semaphore     i_lock;         /* inode lock */
> > -     atomic_t                i_pincount;     /* inode pin count */
> >       struct llist_node       i_gclist;       /* deferred inactivation =
list */
> > +     atomic_t                i_pincount;     /* inode pin count */
> >
> >       /*
> >        * Bitsets of inode metadata that have been checked and/or are si=
ck.
> > --
> > 2.39.2
> >
> >



--=20
Junchao Sun <sunjunchao2870@gmail.com>

