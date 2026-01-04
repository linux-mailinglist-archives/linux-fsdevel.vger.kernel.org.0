Return-Path: <linux-fsdevel+bounces-72352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3BCF0865
	for <lists+linux-fsdevel@lfdr.de>; Sun, 04 Jan 2026 03:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB1813011EF8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jan 2026 02:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC4720299B;
	Sun,  4 Jan 2026 02:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx7tPbfW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8984C97
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jan 2026 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767492971; cv=none; b=HdH+1heJwdhOIRbLbAvSNeOLdByXkj/wUXWQRG8raj3GgIQkBR5/+VBarOEq8kEwypgaIKor9eDNMW0xy/YMdg8qJNN5gDuuM2pydDo71yAlFkLlrADoxz2hnYC9l7peLWDldltXvVCzgeb5lRO76hW6ophxEZ/sSU1jqCMCtGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767492971; c=relaxed/simple;
	bh=jyHPORDHjyJzZDcWKOi3filfgpNtq17HwoR/xRt6BBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XApOidhsL+b/f1Vy7Z8tQ+DQWElZ+Gtt4Eenmk8iEN0QqiccBRD2QDWvp7hgkqwOB4JABcns7NeyIPWS1tUJdwKItY92DztVU54+IZf98fE/r14z+6CqiVJWiNbQIF7bra/gIuxkprisrkzjXUnEmoj9/tqu5ij0sGJoCJCdH/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx7tPbfW; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so2041172266b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jan 2026 18:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767492967; x=1768097767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8Af163Qo/BNQaLaWZwKvSgxg8Y1ipyCsfTt0OtHdaY=;
        b=Qx7tPbfWTVUltD7YphNfVJQEmGEvZEG85tyRJSYgnxrCDIl6VSj97+QZycpA/6miA1
         zvU5wFrXthAcSOsBs49bV61Rqf9beb0hA4ZEWVCs3+ge1NPMoQvpC4MHiaB2F7TG7H61
         1d5yW6DsKFPGpyXVfcXwZ/HOULwaJeqPFgB1tIOqpia2u7xbx9NXwBJn5z0aOr+0LpZc
         jjKxdp7qvg/5uvYmf30n4xL6hMfQC8OT71EhWfF6WYZGH76wvCiNqGfS4arL9jjny96a
         LYzqWjrCgpsc7FQbPNW7COH00wBgvvXM8EgvSKMDiJVgDlnOH3c9ifkyqrGwlkalz6Ql
         kJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767492967; x=1768097767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i8Af163Qo/BNQaLaWZwKvSgxg8Y1ipyCsfTt0OtHdaY=;
        b=PvgUmKOgfr1UgR88J7sb1GXAeGLkVIhIFXNSWwgm3kt9w9IBAgaOwD4l8t42hDrZHK
         t1h8xpT7TeLu3viCua+bk5OTKMThKvRJA4L91GfOpXHYZqUS1dYiXSqzJyewXEM70DQz
         lIz45JqrE1Qej38HMHEnihCYEbBpWUKh65NB8mmhs55HiIdd0i0cYZ9CoU9zlYqk+l9L
         PjvcsymUoBlDjJXplfL7eNgFrmArmgUWQK5F8DeEnWZNO7sBRa6jU54RY++kBwVbPGDH
         fgbX5IREaRVD0Q2soqsrOFFWPo1m93XpwKt6DV7iW4Qrduw4WZddXmfHKkR0PlQFqE38
         tM3w==
X-Gm-Message-State: AOJu0YwbXEwnz3AomnG1hZOzxuyxZYlS0qfSBVHjAE9A2XaIBJ0WFG4I
	q7ap0d4NN5XClwaRE+5a93piR+Js3dq2VE3AIatss7/3pFQl+nXts2qLxcozWa22KTKgmP1ZG69
	UyiJ78NY5RXtJP9ZuplrNWvfSkUoQSnYvPcavkMpVYg==
X-Gm-Gg: AY/fxX4OIMkUa1YU52myjASytHQXwos9BrswvqFdC8GWThgPAToH34x19wd/XLSUtP3
	sNNwwYb3evltz/svZYsRAuoAty32fmRP+bd2VuYRlrVQ01fCEGEIkT4SCwM5HmoPqVYf5NnteZM
	wDrMsaFhJU4ZQDcBWOBgpzq2AIHmkwQvakE6CH/VejwXhCfKFfvv8hmz3etjZFz61EvdI9dvPyD
	MPlaUmYffjcj1qipwCBNa153I/lGD7DWFcwUycxLGKdhTO5neq4pVXnnAcq9UyOpc1C
X-Google-Smtp-Source: AGHT+IGrShy0iS+c9fiXvH75EV/l+t2/HB6VFyT+eG8DUV58h/w3OgRp3m6BhWwlVfJCuxRvJZkJHfYPxgTucnb2H6A=
X-Received: by 2002:a17:907:1b12:b0:b80:751:ee62 with SMTP id
 a640c23a62f3a-b8036f0d5cdmr4757178466b.14.1767492967441; Sat, 03 Jan 2026
 18:16:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGmFzSc=YbHdaFbGQOrs_E4-MBXrM7QwXZ0DuKAGW1Ers2q=Rg@mail.gmail.com>
 <CAJnrk1ZOYnXpY0qf3yU41gQUHjyHOdBhAdyRPt_kaBmhvjr_9g@mail.gmail.com>
 <CAGmFzSdQ2Js5xUjb-s2vQkNB75Y5poOr_kTf4_8wqzeSgA6mJg@mail.gmail.com>
 <CAJnrk1Z=kqQc5SM2Z1ObgEMeCttT8J83LjeX19Ysc1jCjvA79A@mail.gmail.com>
 <CAGmFzSe3P3=daObU5tOWxzTQ3jgo_-XTsGE3UN5Z19djhYwhfg@mail.gmail.com> <CAJnrk1a1aT77GugkAVtUixypPpAwx7vUd92cMd3XWHgmHXjYCA@mail.gmail.com>
In-Reply-To: <CAJnrk1a1aT77GugkAVtUixypPpAwx7vUd92cMd3XWHgmHXjYCA@mail.gmail.com>
From: Gang He <dchg2000@gmail.com>
Date: Sun, 4 Jan 2026 10:15:56 +0800
X-Gm-Features: AQt7F2oP7T7TtsrbgB75kOqKEwNBIcudgNaHcz99LXsd4e2eImg3y4J8DA34GJ0
Message-ID: <CAGmFzSc3hidao0aSD9nDT50J4a9ZY053MdEPRF-x_Xfkb730-g@mail.gmail.com>
Subject: Re: feedback: fuse/io-uring: add kernel-managed buffer rings and zero-copy
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joanne,

I used the kernel (v6.19-rc2/9448598b22c) with your 25 patches, there
are few different patches between two kernels.
I used your command "./passthrough_hp /mnt/xfs/ /mnt/fusemnt/
--nopassthrough -o io_uring -o io_uring_bufring -o io_uring_zero_copy
-o io_uring_q_depth=3D8" to mount the fuse file system.
but the ls command was still hanged with the below stack,
root@ub-2504:/zzz/test/libfuse/build/example# cat /proc/2515/stack
[<0>] request_wait_answer+0x166/0x260
[<0>] __fuse_simple_request+0x11f/0x320
[<0>] fuse_do_getattr+0x101/0x240
[<0>] fuse_update_get_attr+0x19a/0x1c0
[<0>] fuse_getattr+0x96/0xe0
[<0>] vfs_getattr_nosec+0xc4/0x110
[<0>] vfs_statx+0xa7/0x160
[<0>] do_statx+0x63/0xb0
[<0>] __x64_sys_statx+0xad/0x100
[<0>] x64_sys_call+0x10c9/0x2360
[<0>] do_syscall_64+0x81/0x500
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

Thanks
Gang

Joanne Koong <joannelkoong@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=883=E6=
=97=A5=E5=91=A8=E5=85=AD 01:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Dec 30, 2025 at 10:55=E2=80=AFPM Gang He <dchg2000@gmail.com> wro=
te:
> >
> > Hi Joanne,
> >
> > I used the latest kernel(v6.19-rc2) + your 25 patches, removed the
> > original liburing2,  installed your liburing(kmbuf branch).
> > Then, built you libfuse code(zero_copy branch).
> > I ran the mount commands like "./passthrough_hp --nopassthrough -o
> > io_uring -o io_uring_bufring -o io_uring_zero_copy /mnt/xfs/
> > /mnt/fusemnt/"
> > or "./passthrough_hp -o io_uring -o io_uring_bufring -o
> > io_uring_zero_copy /mnt/xfs/ /mnt/fusemnt/".
> >
> > But, I encountered a hang problem when I tried to list /mnt directory.
> > it looks there are still some problems for this feature, or I missed
> > any important steps?
>
> Hi Gang,
>
> Are you passing in a queue depth? If you pass in your queue depth
> through -o (eg " -o io_uring_q_depth=3D8"), does that work for you now?
> On my end, I'm running " sudo ~/libfuse/build/example/passthrough_hp
> ~/src ~/mounts/tmp --nopassthrough -o io_uring  -o io_uring_bufring -o
> io_uring_zero_copy -o io_uring_q_depth=3D8" on my VM and I'm not seeing
> the hang. I'm running on top of commit 40fbbd64bba6 (in the io-uring
> tree) with the 25 patches applied.
>
> Thanks,
> Joanne

