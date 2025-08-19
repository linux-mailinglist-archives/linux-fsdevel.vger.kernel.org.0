Return-Path: <linux-fsdevel+bounces-58270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0CFB2BBFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80552189924D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 08:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1CE3115A7;
	Tue, 19 Aug 2025 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kYinJ/4U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00767220F5E
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592551; cv=none; b=u9JV+xl0xcR0Yf84NiLCKZbYepranCcVf5+VTwaK75Aq3jJhegDr48nhEPW/Q6sMV914xje7qAGLIII780qkGF8Ke9itaYybF6XrW7HzDmk8ZOCnozOwiY6ORJy/yL+pATU31uqNiFbYPfS+/RC58qKqn0i9AvVkPMa2OyIczlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592551; c=relaxed/simple;
	bh=n3alcAyH+MBzakUd0oXHZj75N+3iUdpBZfKrIcc+GvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1QzWzfK161DmIuoOU60lrg3seZnixlIjquZQafrHV/PtQrivbN0XwEY7hiz8mATPd21K6zDg5IfsDdJXcNVeGrAWbOtE1xXzC2RNDP6PO/VdC/eflyrVIc+eTf64AliA7IuOw6sz+i+GOBCJ91bCxKFhzDy0gxS8fe5dGh9T1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kYinJ/4U; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e86f90d162so504532485a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755592547; x=1756197347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n3alcAyH+MBzakUd0oXHZj75N+3iUdpBZfKrIcc+GvI=;
        b=kYinJ/4UdRt57tIN6AuMR4ytcaSnix/F0FMqncBEOHCLMmh/tKeLlObpbYP2b5yOIH
         TETki21myptQMsbRO4a4jPEeJJEzRhnheijnXcb6oyKW7qHcFYeQMUwenVbvCAFaE+Ec
         3/J/ZelT5ZnYywYv9LojaCgfTVezMywH5i3LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592547; x=1756197347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3alcAyH+MBzakUd0oXHZj75N+3iUdpBZfKrIcc+GvI=;
        b=JWL0eoQwagFCEt3oD0tvPO4vx466R7xVKblh4vMiUV5m5QgPKKCZhJvaOc4s0qvBwO
         xfQC5raG803gvct9Xi9meN1P6oUn2mCrolWjDe3T9oY+7JRGcPtl9ziqLrLIl+YYhX0c
         r+w9eK297Zol9e+KY/B2SLmiTqEflywmGDvhwZKgZn83jjXbrF1n+0NG//v6nyyESpBR
         cwOmI7G9cOYwOMqTyulFWK7oqlrcFzsTay5rURlofSwU7Ngxqiy9FhIQmStRup0S/3xy
         pg4e3q2j9dwx2+mrC2Ti9eOcDkx3lGwCUc0D9tM8Tkpd/aMI7KpqNNNk9igTnm/qE6M/
         2ZJg==
X-Forwarded-Encrypted: i=1; AJvYcCXjeyN/g4vE0jzauKlBX1CnJ1w2Tg5ul2zp7ovxO7tiDTwhvE9wSqCOkDgAVzxkoDgrRqHABFAvyPUDRaAK@vger.kernel.org
X-Gm-Message-State: AOJu0YxrN/mWTe0BAmrsqNnSoBTkXxIv7GWv/qZWpPG5O7uQC0QOFv/y
	mT/1razgKI3hRpUopY3oZvLOGAOKeNGx4CuShcKBrMTEw+EfXyvht7eyojH4YcvhjTu0V6jITbf
	ztD5phIr+eOl31PTFZLmVFz8BbApwuwRCiex/+ljPbA==
X-Gm-Gg: ASbGncv/JthOuehwQwva77dvwmayL7EwYx2yZzHCaZ3KKInprBNblOXNVSN5Om8D18r
	TKGTDhkflZ3x64/Qh/Xh8ZKtTfgYH02brkuhzDcd7jNQ6TGOj2WXnevPLstcZt8LSOadRJs+N3n
	to98xLIrm0Yoo8NhpNrphuyWzPVrRk2BLrzs5jfVQnYZBh4duecihqH5EcJjJhjwU87PJ5/hNNT
	mYVeCqC7A==
X-Google-Smtp-Source: AGHT+IGUqPcwrqcmPbOAFVKxMVxNqYPtBs0UqG4ctRoM9mpS4gA6iGRbfUsVpL/17ZweHQlEu7Zt8pvjjuwRmz0sZe8=
X-Received: by 2002:a05:620a:17a9:b0:7e9:f820:2b31 with SMTP id
 af79cd13be357-7e9f8205bebmr34702285a.38.1755592547513; Tue, 19 Aug 2025
 01:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815182539.556868-1-joannelkoong@gmail.com> <20250819-inbegriff-titelbild-8c0421cf4bbd@brauner>
In-Reply-To: <20250819-inbegriff-titelbild-8c0421cf4bbd@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Aug 2025 10:35:36 +0200
X-Gm-Features: Ac12FXxssO1q2YZYdIs-GeC7Lv78SIS9BYOGsYgx0hQG1M54hxFmM7mb7TawnKQ
Message-ID: <CAJfpegsCoPNy2c9=Zt=0d6R8TnvAVYh+7uRK84duNXdb2wrzYw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] fuse: inode blocksize fixes for iomap integration
To: Christian Brauner <brauner@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 10:26, Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Aug 15, 2025 at 11:25:37AM -0700, Joanne Koong wrote:
> > These 2 patches are fixes for inode blocksize usage in fuse.
> > The first is neededed to maintain current stat() behavior for clients in the
> > case where fuse uses cached values for stat, and the second is needed for
> > fuseblk filesystems as a workaround until fuse implements iomap for reads.
> >
> > These patches are on top of Christian's vfs.fixes tree.
>
> Thanks! This all looks straightforward to me.

I'll take these into the fuse tree to avoid conflicts with other work.

Thanks,
Miklos

