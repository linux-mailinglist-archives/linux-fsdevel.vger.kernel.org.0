Return-Path: <linux-fsdevel+bounces-38302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001729FF07B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 17:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1CD161EB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5AF1885B8;
	Tue, 31 Dec 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WglXZryR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6B1C683
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735661380; cv=none; b=Kj/mdZGCUEg1ih7OYkkelMy4lqoQL6MBHt3sucDFsaiNAwdgzSue4jF20n7piHAELQzK3a5U+0Hh91o4ZijkzplI+k8r7ijRq2n5X/cUz/h61DgGZ0sHpNHOIRU42hELiw+rgbFE+6li702FJq/MsYqjarMF1R7lzGn7Y6WfDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735661380; c=relaxed/simple;
	bh=FY9Hr1rzJfKVwS/irh3zSkwFgTVAD8psrn8HECyPpgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJb6jHWjJWba+lAuNDk5oaiXGsnNmpjZq4Jh7WdQbMlPVvIbuLTgcdZxw4xEJoCYJine4XtOijNQhzHt3Ty0WsVwxiPxsAw4EaRvFHBeOjT0Mh+nKrl1CoXy6VFWFMvi59ul+1l6FnMo/WPOAbW3z7nItWn9HxIFcTe8boRFWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WglXZryR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d8de655efaso2267998a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 08:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735661377; x=1736266177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTOnaZX9rz0b8k+gvm1masJuad1WTgo5kMnJEAYOmoM=;
        b=WglXZryRmFp6phT9XNtzvCEVSKon3UT/XKcx7HNh71r52xI1z2x7ClLDBFKyJFK2mx
         l/lPm1wScsAbDqzgQqDh1ViQHYBtSAA+r1/5uIJLNsf3gP8aihkDLnHIKMxvYStch8U5
         7F7fzhEtmmaeYG7JyM5NVIKBW+916EdWX9kiJ109yNA6B6Jcae1qRA2glL/szLhd6C99
         H043fXWb1qDHgkLrggJDE8qtMH9BlhMiHPgn6W5I9AmAJ6ywiXzu/uOk6s65WnyNuJA9
         7h/hG5Nn8TdJHtf01nuAp3YTy5yLlsPJiAK5fzWLyrgqtuZDPw5tVP3CvStQtC9d/FQ5
         tS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735661377; x=1736266177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTOnaZX9rz0b8k+gvm1masJuad1WTgo5kMnJEAYOmoM=;
        b=ZzfNhviQOXheiNdEvjQgK+Ekkp90oND/+IfbUBwmn6TuOH1+sqJLlahCHuAyB84rSR
         wH4cOdy0P3pegkWULTt8vw9FM8dBBsom22gsoEDWmDN1eNEhXKLLNfnQQaHjMq0EzylM
         xr/GWHRYN9z0XvVjUcVlHI2243KEpMMs9kDAxnZAUKELeLszagnoY04B86iCRJMbpBAt
         ZHn6SlRqP1RNWB4/2Yozae0J+AWliLzs1yyJELc8YjkFD4VzcNvkQ40iFuEAVi+OAvIH
         T5RgWOo7SBY/Tr36nlQnU4/AMc9hFpPCVaKy1Ozdl5yRSQCsLapCLwUVXryOpn5c9c/K
         Vhvg==
X-Forwarded-Encrypted: i=1; AJvYcCVq6uJiSiRJ0ah0fBlUdsPDN0bw/Noh7Xry+aL42pSOhNzM+qlBJJsR1bhf0BzwSdy3F8ANI93LYC8/eFac@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqKqGixWG+l3Ty2MSh5pag+38pA/lCAEV2EW1+je3cgHmjcYC
	UK5czTc9WGrzZrrutgoUSlADHN3mFJCSsdFcsiD4KLtvqHK/Jj44fJwNg7sadstOHD4LP0ljrH7
	7ACY9NmqyEZDOiqf/UfXAcGZ8R0v1YBuy
X-Gm-Gg: ASbGncvCJ1tnFpCpbv26CPJ3jYtbe/1jbQv1TRjhNaA3pxyRQIrDhNu2umD+lj5QlEL
	batKav14Hm0HIvhiFQYipUgDoBGJ3pwxlDS0eiQ==
X-Google-Smtp-Source: AGHT+IFpTE5qOLeDrAQ1ZlGhzIyeCVtY9dopdd3a5y8WbFuajwE/Whp6IiYoC4fyXQiNtl+9OvfJAvSbZxZ1RADOLVc=
X-Received: by 2002:a05:6402:254f:b0:5cf:e71c:ff97 with SMTP id
 4fb4d7f45d1cf-5d81ddfbe45mr28457024a12.24.1735661376639; Tue, 31 Dec 2024
 08:09:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEW=TRr7CYb4LtsvQPLj-zx5Y+EYBmGfM24SuzwyDoGVNoKm7w@mail.gmail.com>
 <3d7e9844-6f6e-493a-a93a-4d2407378395@bsbernd.com> <CAEW=TRriHeY3TG-tep29ZnkRjU8Nfr5SHmuUmoc0oWRRy8fq3A@mail.gmail.com>
 <CAOQ4uxhch3DUj3BtYBaZx6X3Jvpw4OqjcdnkXA_qQh2AQwAo1A@mail.gmail.com>
In-Reply-To: <CAOQ4uxhch3DUj3BtYBaZx6X3Jvpw4OqjcdnkXA_qQh2AQwAo1A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 31 Dec 2024 17:09:25 +0100
Message-ID: <CAOQ4uxjM1pkA+w8XF_cJBC-q5n0_9G1g-JYm7dOt2uSRLX8m4w@mail.gmail.com>
Subject: Re: Fuse: directory cache eviction stopped working in the linux 6.9.X
 and onwards
To: Prince Kumar <princer@google.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	Charith Chowdary <charithc@google.com>, Mayuresh Pise <mpise@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 5:03=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Dec 31, 2024 at 4:36=E2=80=AFAM Prince Kumar <princer@google.com>=
 wrote:
> >
> > Thanks Bernd for looking into this!
> >
> > I think 6.9 added passthrough support. Are you using that?
> > > Not yet, but we have plans to try this out.
> >
> > FOPEN_CACHE_DIR is default when there is no fuse-server open method
> > defined - does your implementation have an open/dir_open?
> > > Yes, here is the implementation in GCSFuse (internally uses jacobsa/f=
use library) - https://github.com/GoogleCloudPlatform/gcsfuse/blob/b0ca9c5b=
2c0a35aeb8a48fe7a36120d7b33216aa/internal/fs/fs.go#L2328
> > Here, op.CacheDir maps to FOPEN_CACHE_DIR and op.KeepCache maps to
> > FOPEN_KEEP_CACHE.
> >
> > I think the only user of FOPEN_CACHE_DIR is in fs/fuse/readdir.c and
> > that always checks if it is set - either the flag gets set or does not
> > come into role at all, because passthrough is used?
> > > Being honest, I don't have much idea of linux source code. As a user,=
 to me the FOPEN_CACHE_DIR flag is working as expected.
> > The problem is with the FOPEN_KEEP_CACHE flags, setting this should
> > evict the dir cache, but it's not happening for linux 6.9.x and above.
> > Although I see  a line in fs/fuse/dir.c
> > (https://github.com/torvalds/linux/blob/ccb98ccef0e543c2bd4ef1a72270461=
957f3d8d0/fs/fuse/dir.c#L718)
> > which invalidates the inode pages if FOPEN_KEEP_CACHE is not set.
> >
> > So my ultimate question would be:
> > (1) Do you see such recent changes in fs/fuse which explains the above
> > regression?
> > (2) If the changes are intentional, what should be the right way for
> > fuse-server to evict the dir-cache (other than auto eviction due to
> > change in dir-content, e.g., addition of new file inside a dir)?
> >
>
> Hi Prince,
>
> The change is not international.
> It is a regression due to commit
> 7de64d521bf92 ("fuse: break up fuse_open_common()") that missed the fact
> the fuse_dir_open() may need to clean the page cache.
>
> Can you test the attached fix patch?
> It is only compile tested.
> Due to holidays, I had no time to verify the fix.
>

Miklos, FYI, in case you plan to send a fixes PR,
pushed my untested patch to branch fuse-fixes in my github.

Prince, if you can, please provide Tested-by.

Thanks,
Amir.

