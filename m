Return-Path: <linux-fsdevel+bounces-25220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03AC949EB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 05:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC8228C822
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 03:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2420619006D;
	Wed,  7 Aug 2024 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMGvBrCw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09DE364A0;
	Wed,  7 Aug 2024 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723003043; cv=none; b=awUYKDfb/YBd0RidgWnnlcdX19+JFzW9b88TCASbH5TT5gjTuoPpa27wVEommnB1KUnVIRgDDp7SEPV8QpoCARFAOTDvTK30NGo0To/vBtMi7lUNmOYy5yHU25+kLhw6ypyvfyOtE6G2N5dPHpPVMST/mpIEyO6A6awHPpzGy04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723003043; c=relaxed/simple;
	bh=HonGmK+AzQAB2kggFATza4eyYEQ8IslypHEtZ9AtvVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9icRqrgMb6NtXEaFGgCqDAIhsyr/792hmBpjv0CHzRCBpBB3zWH017f+UItvY2IJlmV8ec2kJ0omjG+MlkaJzt8pyqkXHuWFabymLTxX1uPvywBfdU9Dx8l/U9SDGaYGLALqorY3ULWlIPveQC6thfMjTBOWNtFohhj7eNYCd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMGvBrCw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso153562966b.0;
        Tue, 06 Aug 2024 20:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723003040; x=1723607840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iA7JRuIalfZ4ro9OHsli9F2Iw3AeOGyZ0oFc/7wxQU=;
        b=FMGvBrCw8bm+XHL3Xos251H2Ym8mqGUO8MIUfGe/LGt9zT9RpPPRWJ5bxPLROsF52X
         wW867eeEeKeChpD000nPLpf/RTUZOVYL3M+zTLInbjEf0Eb6dddCSPX4qg+tk0o7bFEs
         G3fHa55R+VpwJ94oPdMw/MxXxIZQ39bB0AMWlNrZCy0Q0QlL1LBU+qClSErjsJJR+1d9
         1Dkmp/R65dTX3wFNlfIxZrQ7lwQrShEREnXcwzVIzU3xiE49Gj3naYjlPYwH9vWeTj8F
         YyOkRVPjip8alr8biXFBGFuM+gWsZTrFI63JfECrLDcTGElskqI80LrrbUz3FShA17kk
         M8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723003040; x=1723607840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iA7JRuIalfZ4ro9OHsli9F2Iw3AeOGyZ0oFc/7wxQU=;
        b=Sy6vRYJOs1+ukwG24KNE3sDBpLBX0SfDTKF5rRlDWazgUI5seor2Xk4PWY4+KbGdLX
         iIdWhJZ8y1Z44/RfQyx7f6wQBq8XSBVsWlYr1Dzhru1UkjvfTZ79yjqM9s0ofvsX+nZw
         JHPXTaSr50g7T4YiAmQe9vpKaUM4zQd2mtEGK1h3FQDCzuTZvblXrkd2hqYZ5rA0VxWv
         fOA2wWObrZxst8h3gpgjQQNv9TLFfMRDRq2kR/kX0Qscytqj4yeNnd8ZUgVPubFOi1DK
         D95p6ZQFQnIwJUkERkjL1yqyg4hO24RlUrXoatLWzvn6u4yM7lby9SPQgver6P4BF/wz
         mNVA==
X-Forwarded-Encrypted: i=1; AJvYcCX1BFADDbY25ALDI6DcQWJ9QvAG/0TiYdGUmc4HqRinY20WRtkrobN+4OUGZerPAkziWZAANdgh4x13sJ+YK2WRx6MaV1LhpDrkL1Cwm4BW7n7NM1PvabrAlVCCTjU3PMvpO6ETeruJ3bNrYA==
X-Gm-Message-State: AOJu0Yykv0bFIEnr1KY3x6Rcq35bD/rifOYWrLVk9cmUvpBdg/ikyYQU
	3b7KHKQLesqBgEcEV49IRYpX79F8ai+kGHRd3gGrLtYTuoWt8lzPErA7nCp4r0dS58Jx5KLHmrP
	qLEBr+t5TjUdaDUmNfYcWFl6xTB0=
X-Google-Smtp-Source: AGHT+IHNkGE6nn2QzzK0+S8Jl+HE9EWgUq3bVzznRf2JdX4epa6R/3+ecepXG5DUH+1IiepTwn56KyfgRSayfe292/I=
X-Received: by 2002:a17:907:7e8a:b0:a7d:a080:bb1 with SMTP id
 a640c23a62f3a-a7dc517991emr1256020966b.43.1723003039691; Tue, 06 Aug 2024
 20:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806144628.874350-1-mjguzik@gmail.com> <20240806155319.GP5334@ZenIV>
 <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com> <20240807033820.GS5334@ZenIV>
In-Reply-To: <20240807033820.GS5334@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 7 Aug 2024 05:57:07 +0200
Message-ID: <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 5:38=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Tue, Aug 06, 2024 at 06:09:43PM +0200, Mateusz Guzik wrote:
>
> > It is supposed to indicate that both nd->path.mnt and nd->path.dentry
> > are no longer usable and must not even be looked at. Ideally code
> > which *does* look at them despite the flag (=3D=3D there is a bug) trap=
s.
> >
> > However, I did not find a handy macro or anything of the sort to
> > "poison" these pointers. Instead I found tons of NULL checks all over,
> > including in lookup clean up.
>
> Unless I'm misreading you, those existing NULLs have nothing to do with
> poisoning of any sort.  Or any kind of defensive programming, while we ar=
e
> at it.  Those are about the cleanups on failed transition from lazy mode;
> if we have already legitimized some of the references (i.e. bumped the
> refcounts there) by the time we'd run into a stale one, we need to drop
> the ones we'd grabbed on the way out.  And the easiest way to do that
> is to leave that until terminate_walk(), when we'll be out of RCU mode.
> The references that were *NOT* grabbed obviously should be left alone
> rather than dropped.  Which is where those NULL assignments come from.

Yes, this is my understanding of the code and part of my compliant. :)

Things just work(tm) as is with NULLified pointers, but this is error-prone=
.

I was looking for an equivalent of the following feature from $elsewhere:
/*
 * Trap accesses going through a pointer. Moreover if kasan is available tr=
ap
 * reading the pointer itself.
 *
 * Sample usage: you have a struct with numerous fields and by API contract
 * only some of them get populated, even if the implementation temporary wr=
ites
 * to them. You can use DEBUG_POISON_POINTER so that the consumer which sho=
uld
 * no be looking at the field gets caught.
 *
 * DEBUG_POISON_POINTER(obj->ptr);
 * ....
 * if (obj->ptr !=3D NULL) // traps with kasan, does not trap otherwise
 * ....
 * if (obj->ptr->field) // traps with and without kasan
 */
extern caddr_t poisoned_buf;
#define DEBUG_POISON_POINTER_VALUE poisoned_buf

#define DEBUG_POISON_POINTER(x) ({                              \
        x =3D (void *)(DEBUG_POISON_POINTER_VALUE);               \
        kasan_mark(&x, 0, sizeof(x), KASAN_GENERIC_REDZONE);    \
})

As a hypothetical suppose there is code executing some time after
vfs_open which looks at nd->path.dentry and by finding the pointer is
NULL it concludes the lookup did not work out.

If such code exists *and* the pointer is poisoned in the above sense
(notably merely branching on it with kasan already traps), then the
consumer will be caught immediately during coverage testing by
syzkaller.
If such code exists but the pointer is only nullified, one is only
going to find out the hard way when some functionality weirdly breaks.

Anyhow, this is really beyond the scope of the patch and I should not
have done the half-assed thing abandoned mid-effort. I'm going to get
back to this later(tm).

See the v2 which just gets to the point concerning eliding the extra ref tr=
ip.

--=20
Mateusz Guzik <mjguzik gmail.com>

