Return-Path: <linux-fsdevel+bounces-52561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31631AE4144
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4043B3713
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA97248F46;
	Mon, 23 Jun 2025 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzEWrlF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF42BB1D;
	Mon, 23 Jun 2025 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683258; cv=none; b=pUXB5C6fPeWrSsKzlS6sPqjIVIXGghgWTmf1PanF8BlbWfT9sT8GzJdIr53OiIESwbmX2jcvN8dUNCfiygZJ3DzqMbXti0fClSF+LOHov0vCIw0KhoCnKYaIYosDGR/kFo6sObQTwUhQTKCcPs8T3tmKVlycyY4MX3q1rcOws9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683258; c=relaxed/simple;
	bh=0eKCwiVs6Dhcq3+vpFZt/td1Mic+jHQ/fFFv3YFAZpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spmSUzjp/kfJgSoF9gl1n9pm1t0n3O0tjqzsky229XfpaifOgtQlUkF1+v5wWN1R9aDM7CEo03s9u7b1E/kc0D8wIMNYQVCSNEnoS39drcLuGydmSTJu2Po9TldamxTXYXlr3f72wlhEtGNjxk3FtGrRoQAX2h8UU74A8ahjbaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzEWrlF0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acbb85ce788so797704466b.3;
        Mon, 23 Jun 2025 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750683254; x=1751288054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDBoguKo1f7y5XT8NHz6BqdNW/slqgU7CYLp65HT+Xs=;
        b=YzEWrlF0DnBX2ZqYnPMvW/0u2UfpglKcfSdFOi0tbObvFSvl5ysq6jZxBKRLaAWclV
         MXOEBt7bDREqLwfUNKyMzx7YQktlA7jG4F1Nt7yn5Rx0N5N9+lQvXWMPJ1WRJhv/UeNa
         +6EILEpF7FF4P3uVF+dZFjIvF6fa8eht9xGkNB70KYydXgFYYRXqWv8bvENLrtgw4idh
         oucxz25w8Xo5MYwGrBJdbL9+7jlY/TdzVKhqKU2RbrA/SYlx70lCOs3ix3So5A3qcvGD
         GzWQVxgDtZ+2BwEBY3t02XEZC7sWBnvdYkPZGosMMtEVC4DSWkX694fYP9EJZh4snl0t
         Nvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750683254; x=1751288054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDBoguKo1f7y5XT8NHz6BqdNW/slqgU7CYLp65HT+Xs=;
        b=ly9g5lF5k4OJWDRWeDeP2XXry2mKRleZ6RWOwDpzw0tM9rnmeAYi5DvqwnAETCMzFX
         6FUbr7Mu4+OShkUJBxGJqvvNk/z2kpxA/PlLwRQUeVr2itra4XxGqoLlqOxqIhefydSq
         68a1tQR2gg/TcIBh5PyI3VHTvRgAvRxsd62OGE+5QlUNIu6hKtJwN1ZW8KyY19Owpm1n
         NHd3TwP6qv/yJqTXVfvveOW0SFGi4iGh2R87SWzIJE0qK9M6hsf5/8XzPu/XdFey5PYH
         8/6ALdNRzO5YKCkOdKWj5YMbOw22n8Y7cE6227Y3JwJAls7NQ6sxV+y31MUJqPTJ3UWS
         pdzg==
X-Forwarded-Encrypted: i=1; AJvYcCUg3MIIjgSZpTr8OAhBKQC4kIcNKh35FCP9Wcto9bwYO/1WTwxZO7sD+zBd38VnEHZPdCiGIw8V5AWd@vger.kernel.org, AJvYcCXNCxiHdPN32DHapfAUD9I254lQ+W6I7junY9L4T5DHmBXDUZOf/8CUvaepcoQvt1oZA1DN8pfh8F6B2V/A@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf3VpUsuFj7MW59bR/ZTpi59QuxrhxUECeOHNmcpsX+8+44Q2A
	SHWzPPfOLjKuqz7iO864h/6+CH37ix6jUslpx7Zv/kLwbmCMbLKvB8GyatCg6Q5nUXXaydH7eWX
	ie8Mg5K+vWL7lt9MBJ3pV7Tzx/lyXhAQ9GYsgQ5Q=
X-Gm-Gg: ASbGncuDIxu9cPjFu82/gcdFR13r/jGM9rzxZhFZseuDU52HQglu7g1LN5ON0h739zt
	LYRHaruHKLFg6hAEVmV2MOl/gtRpg5l0mUaoqG5HN4bIkBn7YdLYVpfulJTDsEDtCPT8w6RQmoD
	qTcskjftoAKfwTvw2aB6foW7JY1HPVysF3pns1qt7H+Lc=
X-Google-Smtp-Source: AGHT+IEwFlSwRYjkoi9rNLm8j/T3AFGwPTrws+nG10DKIhfYbNm+NTJ14P1VYVG0qgo9AdO/0uwl3j1FP61N0IYgM6g=
X-Received: by 2002:a17:907:2d27:b0:ad5:749b:a735 with SMTP id
 a640c23a62f3a-ae057a2859cmr1284148466b.27.1750683253921; Mon, 23 Jun 2025
 05:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-8-75899d67555f@kernel.org>
 <ipk5yr7xxdmesql6wqzlbs734jjvn3had5vzqrck6e2ke4zanu@6sotvp4bd5lu> <20250623-wegnehmen-fragen-9dfdfdf0b2af@brauner>
In-Reply-To: <20250623-wegnehmen-fragen-9dfdfdf0b2af@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Jun 2025 14:54:00 +0200
X-Gm-Features: AX0GCFv_58W6yAZ_DTbjeyHw-rnqxCtHkDOcWYRGmZtE1j3X8894hh5K5NcxJYM
Message-ID: <CAOQ4uxjZy8tc_tOChJ_r_FPkUxE0qrz0CxmKeJj2MZ7wyhLpBw@mail.gmail.com>
Subject: Re: [PATCH 8/9] fhandle, pidfs: support open_by_handle_at() purely
 based on file handle
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 2:25=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Jun 23, 2025 at 02:06:43PM +0200, Jan Kara wrote:
> > On Mon 23-06-25 11:01:30, Christian Brauner wrote:
> > > Various filesystems such as pidfs (and likely drm in the future) have=
 a
> > > use-case to support opening files purely based on the handle without
> > > having to require a file descriptor to another object. That's especia=
lly
> > > the case for filesystems that don't do any lookup whatsoever and ther=
e's
> > > zero relationship between the objects. Such filesystems are also
> > > singletons that stay around for the lifetime of the system meaning th=
at
> > > they can be uniquely identified and accessed purely based on the file
> > > handle type. Enable that so that userspace doesn't have to allocate a=
n
> > > object needlessly especially if they can't do that for whatever reaso=
n.
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> >
> > Hmm, maybe we should predefine some invalid fd value userspace should p=
ass
> > when it wants to "autopick" fs root? Otherwise defining more special fd
> > values like AT_FDCWD would become difficult in the future. Or we could =
just
>
> Fwiw, I already did that with:
>
> #define PIDFD_SELF_THREAD               -10000 /* Current thread. */
> #define PIDFD_SELF_THREAD_GROUP         -20000 /* Current thread group le=
ader. */
>
> I think the correct thing to do would have been to say anything below
>
> #define AT_FDCWD                -100    /* Special value for dirfd used t=
o
>
> is reserved for the kernel. But we can probably easily do this and say
> anything from -10000 to -40000 is reserved for the kernel.
>
> I would then change:
>
> #define PIDFD_SELF_THREAD               -10000 /* Current thread. */
> #define PIDFD_SELF_THREAD_GROUP         -10001 /* Current thread group le=
ader. */
>
> since that's very very new and then move
> PIDFD_SELF_THREAD/PIDFD_SELF_THREAD_GROUP to include/uapi/linux/fcntl.h
>
> and add that comment about the reserved range in there.
>
> The thing is that we'd need to enforce this on the system call level.
>
> Thoughts?
>
> > define that FILEID_PIDFS file handles *always* ignore the fd value and
> > auto-pick the root.
>
> I see the issue I don't think it's a big deal but I'm open to adding:
>
> #define AT_EBADF -10009 /* -10000 - EBADF */
>
> and document that as a stand-in for a handle that can't be resolved.
>
> Thoughts?

I think the AT prefix of AT_FDCWD may have been a mistake
because it is quite easy to confuse this value with the completely
unrelated namespace of AT_ flags.

This is a null dirfd value. Is it not?

FD_NULL, FD_NONE?

You could envision that an *at() syscalls could in theory accept
(FD_NONE , "/an/absolute/path/only", ...

or MOUNTFD_NONE if we want to define a constant specifically for
this open_by_handle_at() extension.

Thanks,
Amir.

