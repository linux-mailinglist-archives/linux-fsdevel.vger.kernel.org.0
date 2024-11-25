Return-Path: <linux-fsdevel+bounces-35790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2C19D85AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 13:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72595289C7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98581A7060;
	Mon, 25 Nov 2024 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzLlGuCr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2B1714AC;
	Mon, 25 Nov 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539341; cv=none; b=q2+/31laIJJ8eH2SfkHl95Dtt5Uvf+skOS6xOlQ6k93rKS/qjow5nlBj2JlGVAVc2Ju6wwrcYu/mX80g/lexyh8xMEZT5QSH4SxvijDMOxrKWJVLjgrDX1WQfexC/WZ1ggsoX/pdECYuC7EEEIbtweRrx59K9VwkdSWNJocVWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539341; c=relaxed/simple;
	bh=7ZxerCMT4df627wc/dzOlE/AUo4LirhD9vT/0Nrw0vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRIRP1aflvQo73wHaFU9cM7qPWd3ozhAfkcSUfYcJRGKii3Q4hD6JJKAMyn9IxpEHkJ7mr6WdNCQ6ozzXK1oKa4E35/10IDnydInhvkgzIAu94Mhx8usVXwFGM+IaEAdBpjb1WAksdC8cXwB0BitvOFeaoEdlHmTapQ2ATaLHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzLlGuCr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa51d32fa69so406833366b.2;
        Mon, 25 Nov 2024 04:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732539336; x=1733144136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOdOYpXKu7Z0DySNDSX74S/kCTbVmfvQivyUmYVTtSE=;
        b=bzLlGuCr7FHbSfm8xA8xe+KVte26U/bw3IoOGmBq2j2q/EPwEjyPSxvLs9Zb+by4iF
         nPUMzBMGfopA4yBcYvNySGUCHUvPXE5Iiv8rhCk0puGmSu5GqA8yo7I/CrqmEcAsSzj3
         EoJAhvMR0nboBTeMMswujMQdP3SpM9WP3E73bhChalk0hwIXzbUxN0Zej+Aicut45o/b
         KAiOkz6O5TDDn/tkEX5HTKgfr8CWGbvq9st6GibyqfFRtFBs541rqgCqQYtOSlFZLp7W
         d7vpPa/6XIF5awoyz8SY/aokxPLBMCW8SeFkrOl2ghBDAroUThbGCmJQukHdG8CYzqDe
         iwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732539336; x=1733144136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOdOYpXKu7Z0DySNDSX74S/kCTbVmfvQivyUmYVTtSE=;
        b=n79VrHGGeI46Ek5/3dt/mF6enROGB33eoWMV1j5TL2bYIoLS3BFHtZf6VzjO2kgK/H
         IxKE+uZv6ylion+FGp9Lm3LveyDXAfjbw7pcTwvxp2j4gXJ1to5SdgxA4ekCee2PuJIM
         4e0skme/z4MljGRLy7uJyq0cBh/eqWyKfQi3+Erjk7WWzvhT2bM3mtRDueRtnZllBQlJ
         gMWAuf7kw7GtnIiK+5OJjLBa41PVc1IK+gfpPk7F72AK8JFvhXWZMnfEC8zqLlod4DBH
         IadIu6an6C/pvZoozhWZqPTneJW+5zsfrrOWS4TSe12f17B2BZie4Rb5OU+YRGAgWcna
         w96A==
X-Forwarded-Encrypted: i=1; AJvYcCU23ujTp4+gfjqMptjck6SAFJF+ScazDB2qFBlsRT0OYP/DosVMjDcHQogeasld+XexoO7LKkvCeCxl9Qq3@vger.kernel.org, AJvYcCXz4t5hw2NEXBrrWAJ0S04v/MWk+S6ucP9of2oa6w9Mkvrr1lm7DGIQGp41cTuDQ1en61svDlkhCI+9p57/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7hCRPw2A9l+8xnwNw5ln63f/BnLTS3U4RcVrPZkxW12kzg5mj
	Yxxpih27yosnBuJzUKRSz4p2RNfyJMIgXj0CWW1+wHKlpJspr1u3yD907wkm6NlAkeCNgUnlDVe
	r5O8qeCsdFkDZjqAtqjIS7lDaCW8=
X-Gm-Gg: ASbGncvqPxHl3ZAmm8oLmbDXsXRiQat4dWLxf6nRygEz24e7vyJysg9bfb1mmfy5XXu
	wdZtDBHTis/bTW3/Ba/7G+SQd9kcAULw=
X-Google-Smtp-Source: AGHT+IHOQpOxf2C5pywg16wsMCNbEqf3GfEX+Qf32suCnfr6AabrykR++zOlktuh5rcQQE+Bwjj1aEJKziec5auQOmw=
X-Received: by 2002:a17:907:7758:b0:aa5:3591:4208 with SMTP id
 a640c23a62f3a-aa5359144e5mr598051266b.12.1732539336217; Mon, 25 Nov 2024
 04:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whoEWma-c-ZTj=fpXtD+1EyYimW4TwqDV9FeUVVfzwang@mail.gmail.com>
 <20241124-work-cred-v1-0-f352241c3970@kernel.org> <CAHk-=wi5ZxjGBKsseL2eNHpDVDF=W_EDZcXVfmJ2Dk2Vh7o+nQ@mail.gmail.com>
In-Reply-To: <CAHk-=wi5ZxjGBKsseL2eNHpDVDF=W_EDZcXVfmJ2Dk2Vh7o+nQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 Nov 2024 13:55:25 +0100
Message-ID: <CAOQ4uxgYf2kEkYSz=AC++B6cb643Aq82En5QjwDwsSpPRf+A6w@mail.gmail.com>
Subject: Re: [PATCH 00/26] cred: rework {override,revert}_creds()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 7:00=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 24 Nov 2024 at 05:44, Christian Brauner <brauner@kernel.org> wrot=
e:
> >
> > This series does all that. Afaict, most callers can be directly
> > converted over and can avoid the extra reference count completely.
> >
> > Lightly tested.
>
> Thanks, this looks good to me. I only had two reactions:
>
>  (a) I was surprised that using get_new_cred() apparently "just worked".
>
> I was expecting us to have cases where the cred was marked 'const',
> because I had this memory of us actively marking things const to make
> sure people didn't play games with modifying the creds in-place (and
> then casting away the const just for ref updates).
>
> But apparently that's never the case for override_creds() users, so
> your patch actually ended up even simpler than I expected in that you
> didn't end up needing any new helper for just incrementing the
> refcount on a const cred.
>
>  (b) a (slight) reaction was to wish for a short "why" on the
> pointless reference bumps
>
> partly to show that it was thought about, but also partly to
> discourage people from doing it entirely mindlessly in other cases.
>
> I mean, sometimes the reference bumps were just obviously pointless
> because they ended up being right next to each other after being
> exposed, like the get/put pattern in access_override_creds().
>
> But in some other cases, like the aio_write case, I think it would
> have been good to just say
>
>  "The refcount is held by iocb->fsync.creds that cannot change over
> the operation"
>
> or similar. Or - very similarly - the binfmt_misc uses "file->f_cred",
> and again, file->f_cred is set at open time and never changed, so we
> can rely on it staying around for the file lifetime.
>
> I actually don't know if there were any exceptions to this (ie cases
> where the source of the override cred could actually go away from
> under us during the operation) where you didn't end up removing the
> refcount games as a result.

I was asking myself the same question.

I see that cachefiles_{begin,end}_secure() bump the refcount, but they
mostly follow a very similar pattern to the cases that do not bump the refc=
ount,
so I wonder if you left this out because they were hidden in those
inline helpers
or because of the non-trivial case of  cachefiles_determine_cache_security(=
)
which replaces the 'master' cache_creds?

Other that that, I stared at the creds code in nfsd_file_acquire_local() an=
d
nfsd_setuser() more than I would like to admit, with lines like:

        /* discard any old override before preparing the new set */
        put_cred(revert_creds(get_cred(current_real_cred())));

And my only conclusion was this code is complicated enough,
so it'd better not use borrowed creds..

Thanks,
Amir.

