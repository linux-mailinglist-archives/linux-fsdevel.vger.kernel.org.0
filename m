Return-Path: <linux-fsdevel+bounces-49815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1913AC32BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 09:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07B97A933F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 07:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02EF1E521B;
	Sun, 25 May 2025 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/aykkFp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9197E1;
	Sun, 25 May 2025 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748158864; cv=none; b=jHKUTRVycvjXFOhpu1H8I5fqv1xkXY9EFqXH3DPt5p925ASnutSA7rpkpSpBewtPIKP1VqH2Ac9+3ZbIB7s2oVeoM/D9M6FSczrmgCk+ye6qXgHhp5ceImUQx62ZVddcRSJ3+5EIIRXiF58+8uS3iwCERORZK6x2W4tBpP/E9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748158864; c=relaxed/simple;
	bh=fgn0HykQIzbReD6dfKCs1g1niIGkKGLhxfwf+OrVzrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QL624XM9RiGsasvImy8NtFGNNmwbKiuM/mk2BjK+KqFndUoIdv6kqYn9tREEXTXO79204o9FDrPXQqnDonxxrZdXJtad8/7HijB22K014E2xDdEkSiwCUojKaoe4XwSN46iBa6GvIHK9jAD/ZC1z8m7MZ2ZefD4/qhO9EKBcY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/aykkFp; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad572ba1347so197584566b.1;
        Sun, 25 May 2025 00:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748158861; x=1748763661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgn0HykQIzbReD6dfKCs1g1niIGkKGLhxfwf+OrVzrY=;
        b=V/aykkFpvyy3B7o3KDzfjuZzo7PIzuIWX0RafUq734aRU3Y+VfOtavcFvJoNHUoasC
         9olyr2wjbyG3jA+HdZfoDD30niJNQmOkOfKk6emVe2FPyZOrRjXBb8E3r2dFKr5Ygcj0
         tz3ZZf9zsUmJknAAD2ZHNruwEsFuZoCRQFpwLM8QXfG8tmqLM9+KxKrn6IDm45OX3QV9
         jdxCGLbux6rrTy35DdMiztmoTt7xu+y6bif+ttpYXZg8ceQIKu4w9nkXty0ZVDePuXqt
         rP/P3PYHCU3JZeMReVVZVHIUmHVJp7F0juMUA5QnwqiORV0edgQgBdmC3WWXbehs4Xsr
         Ea+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748158861; x=1748763661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgn0HykQIzbReD6dfKCs1g1niIGkKGLhxfwf+OrVzrY=;
        b=qKJObz3cDN2Xj4mcjMer3qTnVXhdbixDqIvncEDj9QwQmmBIXSrXed6wDRS6iLHBOG
         OQqZU4xdkL0Ppm7sTpIa25dg4PnuKdXLEcLicTmGvkHFkQ1mrcURofl4HS03mLhlsbCw
         kuUnppmUiG6lGHjBcfX0jg2YfcdbViFa1kNOBGgzLLYfBTIWocvVgiikV7djsD4+gvmq
         SVYOUe8H0F2/ldTmIEQhEY0zl1r79pDCRoQJncrsNp9U9P/AHaWBth4Y9GQ73TykZh3a
         kaTkS3gmS61ETgM6rewW6cBOszc+F4QFYjYQHnp+CU2oRTp1qRa8tLZeFV2tijCDqP7l
         5GeA==
X-Forwarded-Encrypted: i=1; AJvYcCVSOsCXzowC4wp3SA5kAbuhLVpoE/BtUnUdwECh6A2ZXWXRD6PDyys/9xiJn1zAbXu27Q9Moa75@vger.kernel.org, AJvYcCWMqg6AkHBvDISoqqgPNdk5J2fcn0TbbOv5zderIg3SWO7u/vRCa0woxsXxArd3rjTMhAio6SaFAUPAAicn+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDkXzLGva0tIv31PJyPtj6oI2Z0JMCWytPcSRDIcX6F1whHawk
	CkwTzAWNBzwAEx/5abaYcqEVgQVwE9xBCX6J7ce8XrGbRy8GmgytsY7lTgfu0sYyJJU+nzZOd1s
	4uZb2+Geyj47ExmkeYH+K2Sn9Cgsyeo8=
X-Gm-Gg: ASbGnctvmHx0H5FmV9zSymhBQ6I/PVvn9Hs9xb3J8/p6YCfOrAXqqC8N6XGblPwKMUk
	ag/yhgKrv3cUnrHxWm4PWDt8BCTaAlMZ1vYJZ1+8cQK8IjxMalbwGrvQqDU+Zqa2UB2mbaozk7J
	b3m0+ysC3EDqfQamP1+t8msqEyinTCaQWIEAvloK0Mnupfom3daAaCVQ==
X-Google-Smtp-Source: AGHT+IE3k2b9+GE7XtI3hFOiZZJwAgOPlyvuVd04oVWkFT7pp6qVpQRC46dUVP+/WXLED+V5bTK2Mq8kaTSjfoNtXqM=
X-Received: by 2002:a17:906:d54e:b0:ad5:1e70:7150 with SMTP id
 a640c23a62f3a-ad85b03b7b4mr446867366b.2.1748158860431; Sun, 25 May 2025
 00:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509170033.538130-1-amir73il@gmail.com> <CAOQ4uxht8zPuVn11Xfj4B-t8RF2VuSiK3xDJiXkX8zQs7BuxxA@mail.gmail.com>
 <20250523145028.ydcei4rs5djf2qec@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxhxvHpfrd5BVKLFYr3D8=v4z1js-XkcODRhXtr0-tsecw@mail.gmail.com> <20250525053604.k466kgfcumw2s2qx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250525053604.k466kgfcumw2s2qx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 25 May 2025 09:40:49 +0200
X-Gm-Features: AX0GCFtINODT_WjslPLIkqYCw5v2EHMbOx2fDMFlSAGhCyIvTjgMjTlAiMkBe9Q
Message-ID: <CAOQ4uxiQR6j0oTi_Mo9rk8tLP49nQ+eXDC5BgT-EuQDdn_FksQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Tests for AT_HANDLE_CONNECTABLE
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 7:36=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Fri, May 23, 2025 at 07:11:23PM +0200, Amir Goldstein wrote:
> > On Fri, May 23, 2025 at 4:50=E2=80=AFPM Zorro Lang <zlang@redhat.com> w=
rote:
> > >
> > > On Fri, May 23, 2025 at 04:20:29PM +0200, Amir Goldstein wrote:
> > > > Hi Zorro.
> > > >
> > > > Ping.
> > >
> > > Sure Amir, don't worry, this patchset is already in my testing list.
> > > I'll merge it after testing passed :)
> > >
> >
> > Thanks!
>
> Hi Amir,
>
> Although the v2 test passed on tmpfs, but it still fails on nfsv4.2, the
> diff output as [1]. Is that as your expected? Anyway I think this's not
> a big issue, so we still can merge this test case at first (as it's block=
ed
> long time), then fix this failure later :)

It seems like a kernel bug, so the test is good.

Looking at nfsv4.2 implementation, it does not implement fh_to_parent(),
so AT_HANDLE_CONNECTALE should not be supported and the test
should have notrun due to "does not support connectable file handles"

I will post a patch to fix the kernel and setup my env to test nfsv4.2.

Thanks!
Amir.

