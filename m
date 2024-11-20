Return-Path: <linux-fsdevel+bounces-35345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439B39D405E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 17:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62ED1F225AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354CA19E7E0;
	Wed, 20 Nov 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDK50TSC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA67A155C9E;
	Wed, 20 Nov 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121051; cv=none; b=nkhA6qQCO4sDu4Lz975kORcK6i/y8v/v3BIFNst1GAZIbq6sLAw9jfHUlDvEr3E4FO/bIeGxerZlr+j7uDxSvSYq+3Hy8ZbErzoALp/ScizateGMiMDYEyxwcduItbD0EqcEAfDax7FBcQ5/y/siviqrUUU7H0ggcZIId0f7w6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121051; c=relaxed/simple;
	bh=DpSstyBNXehAIdkVgYzcUY0JA+H/10s65svDrFNR7zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKhc/r5PgeN5ovZRGt/67TrP0/WFPeFQD5l5yhyiV9Tacv9RpyEMpBQlLyp7HgbaJ45vdZXjJr9sBSLFbvzd4f6uB2pRO9GIIBJUqNLaO5q5F51plu6ZbGouzEeKvHEWr9AxOSq9cD+4DhSWPd8PXMFscVjbSOTg80/+Yo635Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDK50TSC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so1149779266b.0;
        Wed, 20 Nov 2024 08:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732121048; x=1732725848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWVEODKI+88+Agjr2ZU2Q9hWiLJ3T/8rKLt5bQ4kjxA=;
        b=KDK50TSCebJysaOiwXl2i/jfgKWdgn12d6lO9daOAgWJEHadPe7+bckkOFG2PreN67
         hnUGIf0k7Le/JVDXrjtpxVi2jNl3Qu/HcngiWmr1nzIojLz/lxJgez37LLlcWNcoWMOW
         LBKaPCTDu6AGEGrSfliG0FRpiu1D0yjxx9vdLLSlOsjCr2eK2ALZ9U9+kNj4c0KQHhg+
         +Y2CLtEbWnvWproiKyfXyWwKsV6NSniTiXG5usLTJaMQhVW5qvFJixQQhdJkZ9Kt+O2r
         udObIn1s+4ldwpTRCDO5KSCttPhIrTe9DmxPQdnCpzNjvc8pGk5JRS/iySBaIQeWyPiV
         1gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732121048; x=1732725848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWVEODKI+88+Agjr2ZU2Q9hWiLJ3T/8rKLt5bQ4kjxA=;
        b=abzJ5BrHgs+s4S9zf/SIANU0iK6yXPOzmjjuEUeQl1K6HcnSERZp5nRsMOWbnLRFUu
         T5aB60BLVpfUOQ1scofNa6xn3xaR+FbD5Q5QzOjJ76lqBE+pwQJSoouuVSi/6swOFsGc
         2A/tiObVSsXedgNqWAO0kwqWEzdJH9J/A0XSzLuRl9nEfjUpqosqJMBiavXiUIUdTNir
         1RS/6rJjd3GhEMriyC8eHFex5P5/Fj7evTEFbFP4OHuq3ZkBnBhWONMz7m2PYQVzAafg
         TpbKCPVVxXtIkvsU3TphepvBOe/vBeWX5u3L/GDkc0akOfysPURIgU+SKi6NJ2rVojPx
         xZUw==
X-Forwarded-Encrypted: i=1; AJvYcCUBFgSZhZz4D6rjANww+gC9nMyVYfXj+0qsN3LYqOcSFMjjUm26fqMZibm8gGn1oEPGO5BY8ugOYd6oihj71Q==@vger.kernel.org, AJvYcCUGyYMwNhPUXVhQHy0527yPAudyBpp0nWS51Smu+dnaYInOHUFZyBdPMUdYvXng7ZX2lkbGjhkSvYXguw==@vger.kernel.org, AJvYcCUqDETnSZrnUOTEf6QXpMnUIngzAEucEQAFcZZBmZUgR57SwtP59GoHNCw4EvDYuL4kRNLPLUva3DLERw==@vger.kernel.org, AJvYcCVj+nUHhFdGiEJgw59tcHWcX0yppQEBqxliUqfnqE1O9va3cLXJtuGtLwIf/8bYIAB51Q+juV9Z+iEN@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7nLtpH6iEWja+ywJV0c6DayEhIHWCLSQsMH2CBW7vwbUg+s9
	Mv6nED1wubSWbwc6rXM7zsAi1FJTIu2sAWbYMoU8J1RpUCeCXxkbpVHeLKcUc0Ccb/tiTI7piRG
	G2f3KCLNpXZSGd8AVidLcAc2N10QDzfNp
X-Google-Smtp-Source: AGHT+IFRj2qVclJYRDudeqZEjpO92T0D0Sk7p9QgbbdfOz7d553nkrCjYZfuL1UJBGykslPgM/P8DEqHCvh1hl8Y+bU=
X-Received: by 2002:a17:907:7287:b0:a9e:c446:c284 with SMTP id
 a640c23a62f3a-aa4dd761e13mr357796566b.55.1732121047806; Wed, 20 Nov 2024
 08:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <657f50e37d6d8f908c13f652129bcdd34ed7f4a9.1731684329.git.josef@toxicpanda.com>
 <20241120154448.onc2q5rsusfs4zsm@quack3>
In-Reply-To: <20241120154448.onc2q5rsusfs4zsm@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Nov 2024 17:43:56 +0100
Message-ID: <CAOQ4uxjLraeWK78d69DRTpuAWWmaPSaHmi-15hW2KRLES6M4qQ@mail.gmail.com>
Subject: Re: [PATCH v8 13/19] fanotify: add a helper to check for pre content events
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 4:44=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 15-11-24 10:30:26, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > We want to emit events during page fault, and calling into fanotify
> > could be expensive, so add a helper to allow us to skip calling into
> > fanotify from page fault.  This will also be used to disable readahead
> > for content watched files which will be handled in a subsequent patch.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  include/linux/fsnotify.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > index 08893429a818..d5a0d8648000 100644
> > --- a/include/linux/fsnotify.h
> > +++ b/include/linux/fsnotify.h
> > @@ -178,6 +178,11 @@ static inline void file_set_fsnotify_mode(struct f=
ile *file)
> >       }
> >  }
> >
> > +static inline bool fsnotify_file_has_pre_content_watches(struct file *=
file)
> > +{
> > +     return file && unlikely(FMODE_FSNOTIFY_HSM(file->f_mode));
> > +}
> > +
>
> I was pondering about this and since we are trying to make these quick
> checks more explicit, I'll probably drop this helper. Also the 'file &&'
> part looks strange (I understand page_cache_[a]sync_ra() need it but I'd
> rather handle it explicitely there).

Makes sense.

Thanks,
Amir.

