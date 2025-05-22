Return-Path: <linux-fsdevel+bounces-49666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3498DAC0911
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 11:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DABC9E4712
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 09:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD0928853B;
	Thu, 22 May 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6p4Ab7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523FE2882DF;
	Thu, 22 May 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907571; cv=none; b=NmWSmtfRjQfhtkzSOl4Ql4k49ua2SgQfAsWqVVMXAxNIdgrSbSoc9CIR4I01U7W4kFJH5CVThTJwNNiqIXUDuwNiiU3J2InASHeuJh3de/qHG1QSyChczCaCUXoSNzy97v56rzmhlasK3Q+KkQuKDJsC8bOlO6RvpgzcLusTOrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907571; c=relaxed/simple;
	bh=0P42Ws2wdHEI3ePjOZCiNK52aa80I5MDc+fP+vCtgUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzfNAvN4XEWVSo2PfhLKxnMODWsCujS308Zp5tc0K2xZ+/IS8wNTM6vVvkXh0BFoZcWXwwzFn0IfOh+JJTbGAUg71xASaFC9TkEP5duUC2J5b3BPUd2l74kKhTagYBjnAK0YCtXKi1oT6ayDgQKEBH5NEqBpJCDgCWgJ7HqTtCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6p4Ab7S; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1319786866b.3;
        Thu, 22 May 2025 02:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747907567; x=1748512367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFMldgZxbMt8xYXVYJ2MRH6uoDi4P08vz9B+U1Xf6mA=;
        b=B6p4Ab7SSsN9ZEVYAarXpa4o5HA85PBfGFp1sosFfZffRraTqFZR3hKLVHdPs5VIjn
         DExKQs1yHoqtl87A9ovPn6AuGM7eAF/ymLjnKC0S1hLG2cok5XuidLo3+vvl73ab9cIL
         gAK4XR8iJemTI+EndvlBaeQZlW8nEguLLQBHCovvhF4YPYEIq+9e+U4F354L2PxpVMfZ
         u/+hZJoOp++ab6Ax2DXNWebAPiLYcWnNlU/BNeHjl89oJ2zDlbm3OlEIX1LkidOqaiOD
         Ur4Qkm9xFZC8Ppinh0vaJkC2yGoCCWzq1voEdu8E/6JvIFDE6K0haFItl/eJe0uS9t3f
         ua3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747907567; x=1748512367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFMldgZxbMt8xYXVYJ2MRH6uoDi4P08vz9B+U1Xf6mA=;
        b=qPyvqlxinWHA2mnBugvs+ZS8oLHvphX6QyedVc161D14YleS6QfDaZhDAgkix966KP
         +x63lbh9hhKEuYPQgOz0ecDFXmMefcTFDGM9QnNymVwvyCVYWHaHwjAxKxbh5hsrBO9l
         rPLGxumTkuCXJXTQgNJfxmlfQmFi/Zpaj1kMwNCMjC1IWfdz+ts+iSAjZsVqBoeVMyd1
         9j2HlzTgo5AjD4aKuyInjd4l0LD/kQgJNQRe/+wZEKWx6XIK2wee3KjpeR/9XlXKwbtZ
         BIrznJ3KNsAZLYI2haptHkiV102HtOGgE16zCkqFgd7FHjvFViotpeb3NoilKFsyNwkv
         JQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0Cld2akj9hLVzW8/1BI/CRTQgHgoUiJWV3hubAxKW4Nsl++5zgJ7Oh7McHRSSgp0F4H/JzqcQfjjUaKqb@vger.kernel.org, AJvYcCWMCbcIPm+AgnnZjMVHq068gOXuG5nBeyoqaAgjrLthGo9AhA66iURlnR1VAz48J52pWis9y1ivCxvaVG/H@vger.kernel.org, AJvYcCWOJGnKdLiyKmEogsQ03Qmfl/7v0kmzJfYBEXX+VmfEG3U8QJCB1aytbrFuM9wj+xXQIJnM1Jwz2zHqgfB7oQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPOYmVA8QqF6ddvRopRV1VxORnoQacxM2iq7l1Z216qQDuY/8
	bHSuX/Iq0gHUhmpaFzwwQRreUK+QDFZJhmg/++sYW9T7asYf/FFTZA/XR3/iZtCWVefNOXfr+Mh
	d9YBiaUQlrLot6Z0TJN/GeZgzNcvql1E=
X-Gm-Gg: ASbGncuI74nf3xD3bWDmPJ6pbTZRWdHuUgISRcUxaW8nHPqUEHOOnX3b8lMyRJByzZu
	CZqN4deX3iCOeiSY/xP7N7PM0wMJ5+SnJ82UXdYb4yFVDKJ6QnnRe0KXNcyHCICLJUUVSXLLEO4
	p+3P+25xWHO0nHefDwbPlAynfiulabU9UW42xaJAtNbIk=
X-Google-Smtp-Source: AGHT+IGB22O25IZ5BcXrqT79641bjrioGzPSWmVeg/H7USqp8VSMzjZNLtn4ydJfnhKIcqE2knE6m/6lgenfM3sjRPI=
X-Received: by 2002:a17:907:7f16:b0:ad5:5210:749c with SMTP id
 a640c23a62f3a-ad5521075fbmr1605236766b.22.1747907566989; Thu, 22 May 2025
 02:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521-ovl_ro-v1-1-2350b1493d94@igalia.com> <CAOQ4uxgXP8WrgLvtR6ar+OncP6Fh0JLVO0+K+NtDX1tGa2TVxA@mail.gmail.com>
 <20250521-blusen-bequem-4857e2ce9155@brauner> <32f30f6d-e995-4f00-a8ec-31100a634a38@igalia.com>
In-Reply-To: <32f30f6d-e995-4f00-a8ec-31100a634a38@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 22 May 2025 11:52:35 +0200
X-Gm-Features: AX0GCFsagP10uSTz4tMfRGU5JVqwaEGgTNn5lkYErEGC14DdVWJ6bUc-4EDUypU
Message-ID: <CAOQ4uxg6RCJf6OBzKgaWbOKn3JhtgWhD6t=yOfufHuJ7jwxKmw@mail.gmail.com>
Subject: Re: [PATCH] ovl: Allow mount options to be parsed on remount
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 8:20=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Hi Christian, Amir,
>
> Thanks for the feedback :)
>
> Em 21/05/2025 08:20, Christian Brauner escreveu:
> > On Wed, May 21, 2025 at 12:35:57PM +0200, Amir Goldstein wrote:
> >> On Wed, May 21, 2025 at 8:45=E2=80=AFAM Andr=C3=A9 Almeida <andrealmei=
d@igalia.com> wrote:
> >>>
>
> [...]
>
> >>
> >> I see the test generic/623 failure - this test needs to be fixed for o=
verlay
> >> or not run on overlayfs.
> >>
> >> I do not see those other 5 failures although before running the test I=
 did:
> >> export LIBMOUNT_FORCE_MOUNT2=3Dalways
> >>
> >> Not sure what I am doing differently.
> >>
>
> I have created a smaller reproducer for this, have a look:
>
>   mkdir -p ovl/lower ovl/upper ovl/merge ovl/work ovl/mnt
>   sudo mount -t overlay overlay -o lowerdir=3Dovl/lower,upperdir=3Dovl/
> upper,workdir=3Dovl/work ovl/mnt
>   sudo mount ovl/mnt -o remount,ro
>

Why would you use this command?
Why would you want to re-specify the lower/upperdir when remounting ro?
And more specifically, fstests does not use this command in the tests
that you mention that they fail, so what am I missing?

> And this returns:
>
>   mount: /tmp/ovl/mnt: fsconfig() failed: overlay: No changes allowed in
>   reconfigure.
>         dmesg(1) may have more information after failed mount system call=
.
>
> However, when I use mount like this:
>
>   sudo mount -t overlay overlay -o remount,ro ovl/mnt
>
> mount succeeds. Having a look at strace, I found out that the first
> mount command tries to set lowerdir to "ovl/lower" again, which will to
> return -EINVAL from ovl_parse_param():
>
>     fspick(3, "", FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) =3D 4
>     fsconfig(4, FSCONFIG_SET_STRING, "lowerdir", "/tmp/ovl/lower", 0) =3D
> -1 EINVAL (Invalid argument)
>
> Now, the second mount command sets just the "ro" flag, which will return
> after vfs_parse_sb_flag(), before getting to ovl_parse_param():
>
>     fspick(3, "", FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) =3D 4
>     fsconfig(4, FSCONFIG_SET_FLAG, "ro", NULL, 0) =3D 0
>
> After applying my patch and running the first mount command again, we
> can set that this flag is set only after setting all the strings:
>
>     fsconfig(4, FSCONFIG_SET_STRING, "lowerdir", "/tmp/ovl/lower", 0) =3D=
 0
>     fsconfig(4, FSCONFIG_SET_STRING, "upperdir", "/tmp/ovl/upper", 0) =3D=
 0
>     fsconfig(4, FSCONFIG_SET_STRING, "workdir", "/tmp/ovl/work", 0) =3D 0
>     fsconfig(4, FSCONFIG_SET_STRING, "uuid", "on", 0) =3D 0
>     fsconfig(4, FSCONFIG_SET_FLAG, "ro", NULL, 0) =3D 0
>
> I understood that the patch that I proposed is wrong, and now I wonder
> if the kernel needs to be fixed at all, or if the bug is how mount is
> using fsconfig() in the first mount command?

Maybe I am not reading your report correctly, but as this commands works:

mount -t overlay overlay -o remount,ro ovl/mnt

and the fstests that call _scratch_remount() work
I don't think there is anything to fix and I do not understand
what is the complaint.

Thanks,
Amir.

