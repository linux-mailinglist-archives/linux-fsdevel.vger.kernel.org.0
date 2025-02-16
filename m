Return-Path: <linux-fsdevel+bounces-41801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB01A3776B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 21:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0417A36C0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6090A1A238B;
	Sun, 16 Feb 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POVmy4Io"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD41442E8;
	Sun, 16 Feb 2025 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739737090; cv=none; b=Vv7xiZR6UVxD8DiJ3F3Z5XsJbzcChUycNyJDMdjGOBTckHz8hmCgl9QX7GIggZOWO+SfUKTjlwdo7KOkFyaOqEkF2y6TAfd174FYTxj+yZXeNb4yxbQhvO6hYXPRcMyMeRhn8ehamaWtdlROaeVFtN9qya7jHqxCbwqbK/9XA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739737090; c=relaxed/simple;
	bh=NB0QhsQOFBr5gBqalO0z/Cl2Q7zM3XxL3dN+Pae5AhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeuZZ5u4uprtAjBxlHqTRaNU/rSJZMQtAFl//awpX4gczptE8DkN6aoFRO6vfei0CZWCCdDsRIH+TBjlydJ/mptIOkl4HY5i88tXgWh+eqkYDkf4TgJ3OwJPM87mwi7t91re5JH7/mCSaEzKc4pEl3WvbI/wGaZvCObPXLn78/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POVmy4Io; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb8e405640so88491966b.0;
        Sun, 16 Feb 2025 12:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739737087; x=1740341887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MTbnbtlsv7ZvzsO8udhAtLIFoLXmm5zxerQZC4bmGU=;
        b=POVmy4Io5+8gsnZF/YeEppcfc8dsfZSmI4AEmPtA636adQt+cf3gNME0HIori29Vkt
         4N+xN945c8RMaq3OenimGLJLYhYhMF0B+9u4yF+pdtQ5A+7IhYSTE5THui/uKSBUCgcu
         q4Fn5omdKMal/bD9v6dsOL748DgdDc3OHC5eZjCEOu+ONiPJDc76IOnL/9xj5OA1lZnL
         oDBAX9PNx2t5gj2bEzAlW6ugvrgPfOrT6RIJmhSKUfZ2I9hEARBCBwGeA3zCKpfDNaiT
         Dnpj9Rkv4405AXJLBs4NxuctUBF6dwfxosBUQRpWMJUHMesnvjm7UEMJUU7ZKJRhSQ1r
         Y7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739737087; x=1740341887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MTbnbtlsv7ZvzsO8udhAtLIFoLXmm5zxerQZC4bmGU=;
        b=qpvSEBRRD+Sa8JRzoWGECSMPaWmjDtGzLmdBUMh+wxophodKvhY8TSbl8XLsnwmahA
         PuuxqHpStNKm3x/csynRNppFJL7uG8F3OaSsgoDI/w3M8EBQP3TAojblLgfeLUGbLj0a
         Ac0GFcfPEFbtcmtbBvJB3yYF2uTx9tNN/hCzCH1FqL1yMkFMnAInLGiCjZvh5xVLnPjh
         Zml59RMct1yJciR+c35lVV89KU0FndYF0SoBrb4VdxVb/d4X6OYyfoKbJMRXrba0nP9P
         7fcD9zH9P+nymPGW+9a4dn6u5EHFCTjohrynaDHwGx3js9GAQWgTr6SLh4CC1DKErWSG
         0U+g==
X-Forwarded-Encrypted: i=1; AJvYcCVXOq+rPrsUFBBdmxcMJv7kTmJxFUouMkvfGg3ptGQvzBwqgm/9wqcJUQRUcK/V7E1rCXM4cTHnvoizb3ZKNQ==@vger.kernel.org, AJvYcCVcJ0imZVRKT8hgrPeHGGXbHcBTILPnEKiMol1P2q0rpXisbK9evnhx3ChXUXXeZwc4ltkt9CzpBVzN@vger.kernel.org, AJvYcCXY0O/mUHATXIMoC5OqNmyJoYm2gwSfMIGTTTh01VCL5x+q40mJ34TmZ2G6cbfHWSATDAvB/BxRXrqLEp5a@vger.kernel.org
X-Gm-Message-State: AOJu0YybZ3gHz3w16Tk0lfYTrBSYD409LoF9dycB+NVK7WMnWHRo0Bmn
	tbUQl2ECDYIfDjiAulYszFIq2NU1j8nM1WVndwY3rvs5dTYkFmrlX8vcBviuIfmFWJ1WYNPjn6T
	0lIzMpVgqh5sNG/dYM+shIiUf1Yc=
X-Gm-Gg: ASbGncu5nZIx32RKw4RilWP12Sphh4g1oD+xc7EaLxe6PD8SYInv7n8jjibIQ7KwOkV
	H1WnVoyVZGYyYsTYeIUMhWeFynVjgrKuhcpgtuNgAtpwSpLrBjyTs6K8aEZlTziXPa9e2AgNc
X-Google-Smtp-Source: AGHT+IGF1VMyH3LhI3tNgU/V3onDXnvGxqD9tYrvi1dhpucP4c9QdDKTfPNzWyv6hJFeShA1EKRF0FXRxiUVslvUHLY=
X-Received: by 2002:a17:907:7ba4:b0:ab7:eead:57ad with SMTP id
 a640c23a62f3a-abb70de4097mr665289566b.52.1739737087051; Sun, 16 Feb 2025
 12:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216164029.20673-1-pali@kernel.org> <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain>
In-Reply-To: <20250216183432.GA2404@sol.localdomain>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 16 Feb 2025 21:17:55 +0100
X-Gm-Features: AWEUYZnom1AJnFYuknh9-pu4go-A_jsHI1q4jlpGAaZLYjeSVNgq7DZ7I9GQ7LM
Message-ID: <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
To: Eric Biggers <ebiggers@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 7:34=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Sun, Feb 16, 2025 at 05:40:26PM +0100, Pali Roh=C3=A1r wrote:
> > This allows to get or set FS_COMPR_FL and FS_ENCRYPT_FL bits via FS_IOC=
_FSGETXATTR/FS_IOC_FSSETXATTR API.
> >
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>
> Does this really allow setting FS_ENCRYPT_FL via FS_IOC_FSSETXATTR, and h=
ow does
> this interact with the existing fscrypt support in ext4, f2fs, ubifs, and=
 ceph
> which use that flag?

As far as I can tell, after fileattr_fill_xflags() call in
ioctl_fssetxattr(), the call
to ext4_fileattr_set() should behave exactly the same if it came some
FS_IOC_FSSETXATTR or from FS_IOC_SETFLAGS.
IOW, EXT4_FL_USER_MODIFIABLE mask will still apply.

However, unlike the legacy API, we now have an opportunity to deal with
EXT4_FL_USER_MODIFIABLE better than this:
        /*
         * chattr(1) grabs flags via GETFLAGS, modifies the result and
         * passes that to SETFLAGS. So we cannot easily make SETFLAGS
         * more restrictive than just silently masking off visible but
         * not settable flags as we always did.
         */

if we have the xflags_mask in the new API (not only the xflags) then
chattr(1) can set EXT4_FL_USER_MODIFIABLE in xflags_mask
ext4_fileattr_set() can verify that
(xflags_mask & ~EXT4_FL_USER_MODIFIABLE =3D=3D 0).

However, Pali, this is an important point that your RFC did not follow -
AFAICT, the current kernel code of ext4_fileattr_set() and xfs_fileattr_set=
()
(and other fs) does not return any error for unknown xflags, it just
ignores them.

This is why a new ioctl pair FS_IOC_[GS]ETFSXATTR2 is needed IMO
before adding support to ANY new xflags, whether they are mapped to
existing flags like in this patch or are completely new xflags.

Thanks,
Amir.

