Return-Path: <linux-fsdevel+bounces-31310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A883C9945AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF6C1F2579C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED011C2443;
	Tue,  8 Oct 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmBeJqXi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D271C231E;
	Tue,  8 Oct 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384208; cv=none; b=Vf35sSED2HaheCzsWs27c3tLEU4XnTmuL+DQBWaawizv1upqgftJ33NgXiZ4rief+U7DAsNzoGglXuDXaQhbske8odEzA7rkpiiU4IF51xhkESVfVM8ZVs+OJhJtUQ2i+P3adJn3VFQjMx/lOwmvq2HIvpGw3XKZoPdzNaGwTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384208; c=relaxed/simple;
	bh=WDT04npk/A0Vg2Gn7fQERZ2D5ZV98JKGrtSjDchkzKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMuq3jD2tqHMDiNPVtOqSHrxcaairrBUWQn9Hk3o/oNyY+A5m+/wN2sVxFNMquDy+OyweosuVB4xBVqX/obZjk903zSS6XvE3pJLPhABTCxeZFdCk6v3/5OFmC1shCRYNGYtQS9JfZqb60aKjm+rpUFaUCgPABOgu66FHuPOc2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmBeJqXi; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a99e4417c3so453860785a.1;
        Tue, 08 Oct 2024 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728384205; x=1728989005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oeSMwl58MfmoEEm04Dh6ZMfg2AmumAWMgCTT72MAhI=;
        b=UmBeJqXiYCgeknnwa+lKGX43hbU3F32ENf4cBRccgRlevbmvW5bFc3vTAKUKGlGdou
         YjXVR4MehXXty0b64z282SDtbrQkN/op8+Vm5eGdBZal8W232YmTYXubSPAkLF3Ey/eY
         Z07ehHlH/35jGamP+fD7yamy5YResxq+osDKFRCN5BpzuO3F6Eg29snZFA/eYsVNZ7CB
         elXB59Nw6SrWyO90tcnmMTd5lk+/ZkhiPYJrMbJIRnSxILb8UCS2fGbQXu4Qm7GG/OcI
         LrEVCZFg4zMHAE0vSB3jVaOYTsrnERnBEZYbSYPc8c4j1+uKfd1EM2z9RAy/RCyFAI7J
         /1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728384205; x=1728989005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oeSMwl58MfmoEEm04Dh6ZMfg2AmumAWMgCTT72MAhI=;
        b=cJZ4MaC4YNVjMu0eTslSJmpRLXaJckJXfD2y/3WJHKXQNuR1kQcs7RLgPZbSINYJ0l
         G9T7q7z+Xu5JD5t3yuMsrdXZQb+vaMvK+44TneuxbSIwTdLI/nOGHDZvGyN1iVjWIBGm
         /aw58ip3pe2FH9BstrWyiAqTRr1rFZLjJY2pvP57zR1+e77pjiP5aPyuh/Apfk7eECbN
         8s4blQgYlTyCOmxvogXQ7O2EKUiwgKtZaULgae8e6Y4C3sQPjhLroKDJnoIcp2W5/aXy
         bih9uf6Moh63z1l9UvIORvDezhWMsR238b3qfPaaaby3P3SQKQ1mzQ3h4s0KtoXw2b9r
         HamA==
X-Forwarded-Encrypted: i=1; AJvYcCUHJOHOtKJR+LCu58KTr4S8EiefcuD5hzM1g4nO1fInUyYimg/hhdYeryrhkgyBrr+QEoaROuelKEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVpyIAk60kSYH+YZ2d2UP8Cn41XDSylfo5uipT1WZPco/ZctaF
	0GwxjFTfboR+dVsoS83tLs1jssc+fTF4Hm459Dm7B9DUwFsdki2KejS8lFbB6B6z/B1dPKIinka
	jgeJB+sVYb/bCVeU9SX9pOV2FwRUoGwGo3q4=
X-Google-Smtp-Source: AGHT+IH6WcJriWJ0sToprFytbx99NuygaxS/QBRM9GHpQYmBJXjRj/KUhWNW10KLel110VkM9FGoE7rDPXae3Xn5Q4Y=
X-Received: by 2002:a05:620a:29d2:b0:7a9:bf31:dbc7 with SMTP id
 af79cd13be357-7ae6f493a39mr2504323885a.53.1728384205275; Tue, 08 Oct 2024
 03:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923082829.1910210-1-amir73il@gmail.com> <20240925-seeufer-atheismus-6f7e6ab4965f@brauner>
 <CAOQ4uxiBwtEs_weg67MHP4TOsXN7hVi0bDCUe_C7b2tHqohtAQ@mail.gmail.com> <F27FAEB3-666C-4063-A2AD-C5348146CAEF@oracle.com>
In-Reply-To: <F27FAEB3-666C-4063-A2AD-C5348146CAEF@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 8 Oct 2024 12:43:11 +0200
Message-ID: <CAOQ4uxgj1tmSaZ+swdRG7gJ_1V+mEWzGnEUychEL8HnnV36x_Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] API for exporting connectable file handles to userspace
To: Chuck Lever III <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 8:09=E2=80=AFPM Chuck Lever III <chuck.lever@oracle.=
com> wrote:
>
>
>
> > On Oct 7, 2024, at 11:26=E2=80=AFAM, Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > On Wed, Sep 25, 2024 at 11:14=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> >>
> >>> open_by_handle_at(2) does not have AT_ flags argument, but also, I fi=
nd
> >>> it more useful API that encoding a connectable file handle can mandat=
e
> >>> the resolving of a connected fd, without having to opt-in for a
> >>> connected fd independently.
> >>
> >> This seems the best option to me too if this api is to be added.
> >
> > Thanks.
> >
> > Jeff, Chuck,
> >
> > Any thoughts on this?
>
> I don't have anything clever to add.
>

Sometimes that's a good thing ;)

FYI, I wrote a draft for the would be man page update to go with the
proposed flag:

   name_to_handle_at()
       The name_to_handle_at() system call returns a file handle and a moun=
t ID
       corresponding to the file specified by the dirfd and pathname argume=
nts.
...
       When  flags  contain  the  AT_HANDLE_FID (since Linux 6.5) flag,
       the caller indicates that the returned file_handle is needed to
identify the filesystem object,
       and not for opening the file later,
       so it should be expected that a subsequent call to open_by_handle_at=
()
       with the returned file_handle may fail.

+     When flags contain the AT_HANDLE_CONNECTABLE (since Linux 6.x) flag,
+     the caller indicates that the returned file_handle is needed to
open a file with known path later,
+     so it should be expected that a subsequent call to open_by_handle_at(=
)
+     with the returned  file_handle may fail if the file was moved,
but otherwise,
+     the path of the opened file is expected to be visible from the
/proc/pid/fd/* magic link.
+     This flag can not be used in combination with the flags
AT_HANDLE_FID, and AT_EMPTY_PATH.
...
       ESTALE The specified handle is not valid for opening a file.
              This error will occur if, for example, the file has been dele=
ted.
              This error can also occur if the handle was acquired
using the AT_HANDLE_FID flag
              and the filesystem does not support open_by_handle_at().
+            This error can also occur if the handle was acquired
using the AT_HANDLE_CONNECTABLE
+            flag and the file was moved to a different parent.
--

Apropos man page,

Aleksa,

Are you planning to post a man page patch for AT_HANDLE_MNT_ID_UNIQUE?
I realize that there is no man page maintainer at the moment, but I myself
would love to have this patch in my man-page updates queue,
until a man-page maintainer shows up, because, well, my update to
AT_HANDLE_CONNECTABLE depends on it and so will my changes to
fanotify to support mount/unmount events if/when I will get to them.

Thanks,
Amir.

