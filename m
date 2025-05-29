Return-Path: <linux-fsdevel+bounces-50082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD7CAC8152
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 18:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D031733BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D7622DFB1;
	Thu, 29 May 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acMS++PZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232F519F10A;
	Thu, 29 May 2025 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537864; cv=none; b=UYwSY7buHkhH+dELnAkbnZEXSvOYs12n970bOI06zy44QrLkL8dNjM7nLOfmfDXQWyAnkPcSv4hkDOWzWm9OnD1Suj/OefAFtOJUmp+bWqJodaqqRQPdRroHOCY2YDqSV68c6v5ss8TWL/9jh+vzNgnpLSgYQPCs9l4UmdIoWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537864; c=relaxed/simple;
	bh=9DkbmaEIvNk0ugkMfkqcpOOKnf3ro24TRtCPW4ya6yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8IBbcoGTK8P8/4yWgzpp2uuLywrOUSfR3k7nEsuTzmo+7wIxZ0Til+2HMz/LTYp85YAt8J9a+eU6la5UOMgJefNZklWJZbEyhWgSpwHm95+6tMiEFxMUEZbTE0NN54Td7owpSSLGUM2n9Ody16rkERcu0DHzUH7MD1zXgPyv6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acMS++PZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so7482355e9.3;
        Thu, 29 May 2025 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748537861; x=1749142661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tlaedw1wPG+l7WJkoD3ml2WNnXiVLOkbbwWSAjtPghU=;
        b=acMS++PZB6s9FBkal/XQyF+vj6HwDm1je1OXoa/LQ78BlqynkpgrQHk6OMyh5CRgYz
         Y53bbzS2/m6lVTeOuEigHYgrIHYsmmJDZi0XOSsjnFBLhxeQjsoBF2oiLthpacaGVUOQ
         kAtMxgYYWZiMh6lbulId3BcXIvkwWxu+eOvXLfD50dL1L6MAXsP4c4LANe9vmovCbrfR
         AeKpDkPGN/kfxRZnnS9eDMtXgyPwzUIPdtnUNhANssms7NdIZNw0ZhAjwdpO0Ga+XT5R
         ngjskjXUTl3Sr/XcI9GzhjUuMZfv9sz8Kzy80a9UG5DhizQq8KBdFNfbHdkSe4V8DQ8p
         iJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748537861; x=1749142661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tlaedw1wPG+l7WJkoD3ml2WNnXiVLOkbbwWSAjtPghU=;
        b=TPnfkzHhrMvhd5KNWDgR29xUuamgeW6FgVTaz7P5Q3ByzQ/+DND3/x+8xcFYn8k3if
         dVRODvNMqrT+uw1QyoauOf7OyRFK30de/cWWpq8pFuFYmOIwbM0WjIZ/0HtK5ybv+zFb
         CsNOVm94iYt4860M8B8ont+h21S3AK9j8l2wERo7tX7RFF+EJ3SNqoKw+cLK4oWPmEJd
         rq9E9gNUIjIMnmV8BzD80FOD3xA1gX/6efM6TVvHlS5BeKB0SZytQq0ma6v//kFetMAm
         L0CkpFQiLc5h0uzzHcqpK9XvOjlqmsTEBXBAGDO6dUwVoIJj/4E525ALtsg/d8SJNDYX
         Xdhw==
X-Forwarded-Encrypted: i=1; AJvYcCUslMmOWSXKNWIB9B4lyqGw/TA8yuqHnavRMfGZgQ7zrYCabJ6kekWWFAbLk7CUuYaBbP04vRD1jK1oJVp1@vger.kernel.org, AJvYcCWn8MNluOrmPVu5L0pWWS0IWpkcpZqi9aRYIriulCAQUgZdSyXBJ68/I43inaajQVOJ0Wk=@vger.kernel.org, AJvYcCWnlIO7XOpVsJqHPEhYHDskgIWRpQjGJxr1G65AZO2Y7WEQu5TkHAekgR0+umouRaoT9qOcfGK/CUeNXzKx2Q==@vger.kernel.org, AJvYcCXrx9UJPwVdrJvj5R4caSh8B8rnShZ4i1GC42oIGXRtaN+T3G76bWebX+Th3gYteTNSZGWxOmBAOCx+VbTJIivGPHsV0qKu@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9Ho1zvKya6rLmbyjnJJ+9mKn477M0gEbRomvlZSrvQRxjHNn
	7WMcG/YTofgYL/zWhYuD/jFF651/6z0LQuDOEFxq4yvSk83mRPOl003TmIHy3KJEaS+AjUDvuRy
	HaOjWGDSO7mlfE2nEQ9v90dT4KOUACeA=
X-Gm-Gg: ASbGnctan2wtUk+juVrteDUiAv/em7vOYIS9BItyWc26h3/ZGqPDf2QDXefeqg27uhy
	WCZI7lGHK6SkAvyLExfLiw2bldwqNiNZb8EIrnvRdgSi3t2LyfPnfo4OGcMOXkAq3hiJxTnZa5U
	4eamIAnOlPMOok9QcQybeLQ/N7vL1L+cAmx+E2JgBsaA1eVEvw
X-Google-Smtp-Source: AGHT+IExBPpbdOvNzLi5XmcXjVoFDVQ3Fa2Ox6f/v0xfdDLiI1Xt2+uCkz187dZtfZj4dGt0B7FB+o+wLI5A7Fq1d3o=
X-Received: by 2002:a05:6000:1447:b0:3a4:e6b4:9c4b with SMTP id
 ffacd0b85a97d-3a4f7a3dfe7mr18288f8f.1.1748537861078; Thu, 29 May 2025
 09:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528222623.1373000-1-song@kernel.org> <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV> <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
In-Reply-To: <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 May 2025 09:57:29 -0700
X-Gm-Features: AX0GCFuy_ylN-SekKUAz6Fy4L1iXyZs5NIEFUwj27OIrmibgjehEcBRz2eM78vo
Message-ID: <CAADnVQ+UGsvfAM8-E8Ft3neFkz4+TjE=rPbP1sw1m5_4H9BPNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Song Liu <song@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Christian Brauner <brauner@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, repnop@google.com, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 9:53=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> Hi Al and Jan,
>
> Thanks for your review!
>
> On Thu, May 29, 2025 at 4:58=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 28-05-25 23:37:24, Al Viro wrote:
> > > On Wed, May 28, 2025 at 03:26:22PM -0700, Song Liu wrote:
> > > > Introduce a path iterator, which reliably walk a struct path.
> > >
> > > No, it does not.  If you have no external warranty that mount
> > > *and* dentry trees are stable, it's not reliable at all.
> >
> > I agree that advertising this as "reliable walk" is misleading. It is
> > realiable in the sense that it will not dereference freed memory, leak
> > references etc. As you say it is also reliable in the sense that withou=
t
> > external modifications to dentry & mount tree, it will crawl the path t=
o
> > root. But in presence of external modifications the only reliability it
> > offers is "it will not crash". E.g. malicious parallel modifications ca=
n
> > arbitrarily prolong the duration of the walk.
>
> How about we describe this as:
>
> Introduce a path iterator, which safely (no crash) walks a struct path.
> Without malicious parallel modifications, the walk is guaranteed to
> terminate. The sequence of dentries maybe surprising in presence
> of parallel directory or mount tree modifications and the iteration may
> not ever finish in face of parallel malicious directory tree manipulation=
s.

Hold on. If it's really the case then is the landlock susceptible
to this type of attack already ?
landlock may infinitely loop in the kernel ?

