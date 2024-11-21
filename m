Return-Path: <linux-fsdevel+bounces-35435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F99D4C1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C4DDB23EF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DCB1E52D;
	Thu, 21 Nov 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9lnfuf6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0E3C47B;
	Thu, 21 Nov 2024 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189162; cv=none; b=KbIDW68AvnZebBhcXXrqAXj9kyngCqbi89yQYPufKXhM+/tnVZ8lMNPKiiIbJco29SxKin80cPfeHtfsYugGbLtFqaBuXieANE2XCBhR0rSEfxex0DwUJqq+PKZlbWgvynH6regcZcps9zvpdQTZ4pE0UZgx2fgUTKgkexuyny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189162; c=relaxed/simple;
	bh=xAYaBEUf9TwtHxHoBr4FgtqZpbowLusqakRP77r9kOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCno/MqgehAKT9PwTv0ISRhGvlLHDqzeSP3x/i6NKY4/SNZ/hw7CPNixhcRJEwvDv82pJHnXp15rjbMfCNH2FRJYIiCFoKR3q1nVGDXRocRg/lJx7d5lAjQ+OGCOlrBVArhn7LUJjT7LglXusboJT8mrxyRi3dnDzGU19dB4cVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9lnfuf6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa1e51ce601so164509466b.3;
        Thu, 21 Nov 2024 03:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732189159; x=1732793959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=flmqqIvHrYVf7qQ/T7+htw1AlPLKr76abtaAFtyx13k=;
        b=K9lnfuf6WIqcBztGoyhzjJcULOQ8WWiSLMEvaJIu1d0yN+u9NixCXxNG+Ym99tzF1V
         8kTQJIDgV66Mbtyq8hYqacdFmJCH8pg4FuG5r5ykXe5Tl47NokZARxL+Mhcvh1vj/72h
         3m8XCbmviYJ8xVpVkHdGooHkEXmc/SQWPzFkxgXU15col4maFGcorO/7OyvIhzDmH6X4
         wKfmHW5Xz4EGMc/dyKcVJEwTj+dT581w2kR82lZtWvrU26cPJA92RnjZZVwZhJem00nE
         bPRtCz8s1YRrZnEWBGMEE8suIPrzff/f2QiZItRjy4oloRN447V5GACVSGyRgZ6LFIUM
         Pfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732189159; x=1732793959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flmqqIvHrYVf7qQ/T7+htw1AlPLKr76abtaAFtyx13k=;
        b=UohRHBrCqAZg/5jVQgx0uBsDlVDuQ1jco+VKmtqA5YVdGimqQpX1MIU42IKzvqxhN1
         a2oloUtSaC8mbldDm7jX0Pb+c45YxoL5M08I91NjziM5yuGFe0YB4KnEil4uyn7hDZDo
         6kQvIXoP6nfOLiwkObia7xl28iM3ZNhykEX1rRHOZMWgFS1YY4DQwixpjGV2Cr55o1mS
         Z7wpFWoSs8FDMa5gquyz8MbjHjMfz4df8DZH1njn+FkoUeDjm87AdjTyHjEI6Ef7b3Mw
         MnWfX6CAJiXCYpELEsBIlQ6Z8eCe0dkvshEH8g7TDU/jLQCylVahQicI5t7VH6CYGHRy
         DP+g==
X-Forwarded-Encrypted: i=1; AJvYcCWD1TvAWkySb8n9Q6lIQtB7TI4isL+uSiavjtzHMEd52asUhOSLVyKDn2Z+BP0o7Cjg1dj2pWvsRuN/cA==@vger.kernel.org, AJvYcCWKJogvt+BqwGESOf8M5+5GKrQ+An+llWHGWDmMFrS8BR6K6lSMdvhFvo5VRFXibzmV8HZphbcjbyQlyg==@vger.kernel.org, AJvYcCWKNlxIQPArCOXT9eZ6pa3EU3hKkubRJHCKsWSdxRP9PAoIxi++YJiB5Pohy79w/NeUmoihwUXgrLDJ@vger.kernel.org, AJvYcCWW3ghwwuADyG22yLCT3XWD+ybE++Cb38jzHr/MZXiBGKfCTK7kqs6SzIiLLHVbrlIxfR4CgUgvkAyjvT5BQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPGikDZqOoi3vp9aTJ3heNvxBA4PkD1SsUt/jyYFp9GL8zp2f8
	+lKV1XcgLdcZ+cEY7OOvfW9GYTr/D895hplLXmIXrQ2lh4E8swnr0UxkWpSMdksiTZtzcnnxt/l
	gW/VFgrk1hVbv1Tk4UCDM2S7FBec=
X-Gm-Gg: ASbGncvXzHHxBpabeD+B0w7zIvTogKt9xSZysfbrB5Q90XfJvaeZf+9IVbImMcr5KmM
	mjabZTIK0lJK0Dz1SDvNcw6zAG8t2Ytk=
X-Google-Smtp-Source: AGHT+IFxJ5PMK5EI0p5RcxskpZT0i1r125FE0cgnA0p0b/AF7qbdGGhs4weZZIOjMWdg/3y0jLQKqWHCYKcLqfZpGX4=
X-Received: by 2002:a17:906:eec8:b0:a99:77f0:51f7 with SMTP id
 a640c23a62f3a-aa4dd799d4bmr586113866b.61.1732189158565; Thu, 21 Nov 2024
 03:39:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <5ea5f8e283d1edb55aa79c35187bfe344056af14.1731684329.git.josef@toxicpanda.com>
 <20241120155309.lecjqqhohgcgyrkf@quack3> <20241121-boxring-abhandeln-c2095863da2d@brauner>
In-Reply-To: <20241121-boxring-abhandeln-c2095863da2d@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Nov 2024 12:39:07 +0100
Message-ID: <CAOQ4uxiu3hkx9KJdcb0EchARyM+mYS-Yz+xU9w4MBRUH6RoDzg@mail.gmail.com>
Subject: Re: [PATCH v8 02/19] fsnotify: opt-in for permission events at file
 open time
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is fine by me. But I want to preemptively caution to please not
> spread the disease of further defines based on such multi-bit defines
> like fanotify does. I'm specifically worried about stuff like:
>
> #define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
>                                   FS_OPEN_EXEC_PERM)
>
> #define FS_EVENTS_POSS_ON_CHILD   (ALL_FSNOTIFY_PERM_EVENTS | \
>                                    FS_ACCESS | FS_MODIFY | FS_ATTRIB | \
>                                    FS_CLOSE_WRITE | FS_CLOSE_NOWRITE | \
>                                    FS_OPEN | FS_OPEN_EXEC)

What do you mean?
Those are masks for event groups, which we test in many cases.
What is wrong with those defined?

For FMODE_, we do not plan to add anymore defined (famous last words).

Thanks,
Amir.

