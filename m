Return-Path: <linux-fsdevel+bounces-42046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A1BA3B2DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 08:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B99171B4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFDE1C4A3B;
	Wed, 19 Feb 2025 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrmAu3ub"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8730C1C173F;
	Wed, 19 Feb 2025 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951741; cv=none; b=clDJ3sj7sIRN4zbAtaySTZKcYBFiEQJXt6bRZSfNWRElCB4iofGjTP5DO611LjT7/fsgiHi5jmCNn3D6wLYe7CQ28M9PN1qf595hkNrwAfsNI4GyQrxY79cYf/CXpVOsfCHCKm0oVgEetEnKPYr7fdjJeyA1zpDo9PtPFpXpuhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951741; c=relaxed/simple;
	bh=EbHYomzEGqBM/6gcsBpWHw7Pd+SrgcF93ylJpz/8wak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euE+6C/2T4bFwo8MBLdMaDam6E9cXnWDoDkbf5IZEtgTsU4wrG6c2uXJyuXJPaZ4mGo4xbio1DaUlXd63gL04NfWZi28mA73BxSehBn1Audc0JDoQ2dQV+rc2/eGP98K1a/Qpvhm1lsZb7KUHlL6h4M230Nuxfau+yaf/F2SWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrmAu3ub; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ded46f323fso8400225a12.1;
        Tue, 18 Feb 2025 23:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739951738; x=1740556538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbHYomzEGqBM/6gcsBpWHw7Pd+SrgcF93ylJpz/8wak=;
        b=RrmAu3ubJWb5junSC/4qqCzgS62q4vxIoOVtv9yCgEFUvuMqkF3faPVGdYP1Xyzcdz
         zTVZaa44yHTZgKLBoHbNZJJ5SR4NhozRO0QNm1SvV3bkv9X6ZH+C0D9lt6kxajxhftQK
         tOmd1IONN5q586sNiAwWJL3aKzSJx6AlH2NaxT1Nh3aMscBtkmsVWrBD0wzEdecHzJxc
         gTmlnJdLaSbIqCgpK0H1h37HfLa8qUstwY9s2UplDs3c7WI4uBRwJ3JtjJaV7BxO8cZc
         i2jmPp2u0EmVoY9sZYXquVuAYug37uiva+wMaA8l43bpk0/CK90PwaKAwSH2m5KU1fyW
         yhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739951738; x=1740556538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbHYomzEGqBM/6gcsBpWHw7Pd+SrgcF93ylJpz/8wak=;
        b=pI6qS1qrDNlTOYHLZ9nmlxrrezX1zhaQDvrrWe2bziv8SUHE/a/DMn4BFwSq/dGvXq
         S91MCE1MPIL1hVoUoQaC9mNuWHl0JbpVmNxKnErN/nGoSyp/5GzsKsT51XTx227KYZbx
         XwaCEsS5P/NZDHyGMFJEx4ltJA9Ezh5g7TP1ZXHiuqgh3HDAdzXsWtzGSYS9H9mhLZpg
         xhtTZSfzCCf3ktyZxi8TOQHFmbJFTdCXJ9+RyubjNF8WDzwPUPLT6QT5oJjcSQBjtfT0
         d5Ld2PwMtvidqPphvdeY6sGUS9ccRoE70z28zu2yKYl+acU6l9+pw5U/iiO3PwX/pauq
         taTA==
X-Forwarded-Encrypted: i=1; AJvYcCUyljzxfsQPaUjkFrMXzGw/8fgxhce3bLqnoLAsn6aUteVNBL2qfWN8UP6x/TD1rorHquLraajKrCui@vger.kernel.org, AJvYcCVIWbhN+Tko2Py71/LnOyqkZi0dq+prFmO0BTQ85tq0qQMUnYhBBuRF+DKDa4M8putwKsLrNcwBSo3TUXt1qA==@vger.kernel.org, AJvYcCVPy1aCjjLsrDIUeE+2i86rqVk+FTQ1igAjzE+z+kXsVkwUgD13xfPB6RoYggY2eB6z4FLitQA18+m23VKv@vger.kernel.org
X-Gm-Message-State: AOJu0YyNqt+4hcGhotndZFuooe2m7YK2QohH/yWSID/dZufElV7bGgs4
	vN/kn2nKZO+ZrnTlBH3ufCpiDXeeNKIj9+rejZvMYP8sX39kgctrI00jVrgaNMJDJEBgvflwcvx
	ck/USaMwO83KnZy7tuupxlT47Wi0=
X-Gm-Gg: ASbGncuaH8cT30t0OVMuubvqtzV69gG4x/nzpPb8+TYbwwnlrSE/J3y+NMwYK1Ucr3u
	JJzEpYCQJqGIck9cRt2zb5Pqvp6yZec0FoPrZHJMTJ5Uu9OprbddSvCRRJbPRzaHz0dKA64ha
X-Google-Smtp-Source: AGHT+IE3aGxD6kSsZVNJxjQH8TGu4ReOyuVVJu1bMp8BPJ5HJ+l+n0dg4eEt8BRWfqenNWmrM0AaBc+z55xXgVbLjWc=
X-Received: by 2002:a05:6402:50ca:b0:5e0:4a92:6b34 with SMTP id
 4fb4d7f45d1cf-5e089516998mr2204298a12.12.1739951737416; Tue, 18 Feb 2025
 23:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216164029.20673-1-pali@kernel.org> <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain> <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali> <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <Z7Pjb5tI6jJDlFZn@dread.disaster.area> <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
 <20250218192701.4q22uaqdyjxfp4p3@pali> <Z7UQHL5odYOBqAvo@dread.disaster.area> <20250218230643.fuc546ntkq3nnnom@pali>
In-Reply-To: <20250218230643.fuc546ntkq3nnnom@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 19 Feb 2025 08:55:26 +0100
X-Gm-Features: AWEUYZk6LPVJ6yh4ABnF4RMKDHcNJh_qDgkcHF5dnokJG42zcEIX4XZjn92Do0w
Message-ID: <CAOQ4uxiAU7UorH1FLcPgoWMXMGRsOt77yRQ12Xkmzcxe8qYuVw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 12:06=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> =
wrote:
>
> On Wednesday 19 February 2025 09:56:28 Dave Chinner wrote:
> > On Tue, Feb 18, 2025 at 08:27:01PM +0100, Pali Roh=C3=A1r wrote:
> > > On Tuesday 18 February 2025 10:13:46 Amir Goldstein wrote:
> > > > > and there is no need for whacky field
> > > > > masks or anything like that. All it needs is a single bit to
> > > > > indicate if the windows attributes are supported, and they are al=
l
> > > > > implemented as normal FS_XFLAG fields in the fsx_xflags field.
> > > > >
> > >
> > > If MS adds 3 new attributes then we cannot add them to fsx_xflags
> > > because all bits of fsx_xflags would be exhausted.
> >
> > And then we can discuss how to extend the fsxattr structure to
> > implement more flags.
> >
> > In this scenario we'd also need another flag bit to indicate that
> > there is a second set of windows attributes that are supported...
> >
> > i.e. this isn't a problem we need to solve right now.
>
> Ok, that is possible solution for now.
>
> > > Just having only one FS_XFLAGS_HAS_WIN_ATTRS flag for determining win=
dows
> > > attribute support is not enough, as it would not say anything useful =
for
> > > userspace.
> >
> > IDGI.
> >
> > That flag is only needed to tell userspace "this filesystem supports
> > windows attributes". Then GET will return the ones that are set,
> > and SET will return -EINVAL for those that it can't set (e.g.
> > compress, encrypt). What more does userspace actually need?

Let me state my opinion clearly.
I think this API smells.
I do not object to it, but I think we can do better.

I do however object to treating different flags in fsx_xflags
differently - this is unacceptable IMO.

The difference I am referring to is a nuance, but IMO an important one -

It's fine for GET to raise a flag "this filesystem does not accept SET
of any unknown flags".

It's not fine IMO for GET to raise a flag "this filesystem does not accept
SET of unknown flags except for a constant subset of flags that filesystem
may ignore".
It's not fine IMO, because it makes userspace life harder for no good reaso=
n.

This former still allows filesystems to opt-in one by one to the extended A=
PI,
but it does not assume anything about the subset of windows attributes
and legacy Linux attributes that need to be supported.

For example, adding support for set/get hidden/system/archive/readonly
fo fs/fat, does not require supporting all FS_XFLAG_COMMON by fs/fat
and an attempt to set unsupported FS_XFLAG_COMMON flags would
result in -EINVAL just as an attempt to set an unsupported win flag.

But if we agree on setting one special flag in GET to say "new SET
semantics", I do not understand the objection to fsx_xflags_mask.

Dave, if you actually object to fsx_xflags_mask please explain why.
"What more does userspace actually need?" is not a good enough
reason IMO. Userspace could make use of fsx_xflags_mask.

>
> Userspace backup utility would like to backup as many attributes as
> possible by what is supported by the target filesystem. What would such
> utility would do if the target filesystem supports only HIDDEN
> attribute, and source file has all windows attributes set? It would be
> needed to issue 2*N syscalls in the worst case to set attributes.
> It would be combination of GET+SET for every one windows attribute
> because userspace does not know what is supported and what not.
>
> IMHO this is suboptimal. If filesystem would provide API to get list of
> supported attributes then this can be done by 2-3 syscalls.

I agree that getting the "attributes supported by filesystem" is important
and even getting the "gettable" subset and "settable" subset and I also
agree with Dave that this could be done once and no need to do it for
every file (although different file types may support a different subsets).

Let's stop for a moment to talk about statx.

I think you should include a statx support path in your series - not later.
If anything, statx support for exporting those flags should be done
before adding the GET/SET API.

Why? because there is nothing controversial about it.
- add a bunch of new STATX_ATTR_ flags
- filesystems that support them will publish that in stx_attributes_mask
- COMPR/ENCRYPT are already exported in statx

With that, backup/sync programs are able to query filesystem support
even without fsx_xflags_mask.

I think this is a hacky way around a proper GET/SET API, but possible.

Thanks,
Amir.

