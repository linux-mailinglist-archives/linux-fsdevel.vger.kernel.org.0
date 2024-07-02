Return-Path: <linux-fsdevel+bounces-22985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3464924C02
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 01:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61230B21815
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 23:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27D017A5AB;
	Tue,  2 Jul 2024 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSVc0O6r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF9F17A58B;
	Tue,  2 Jul 2024 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719961715; cv=none; b=QntbAHsjro53UYAPw5ZLkVFebO860+6qA77WQKhPilUcOm6ojZsxn8LRrxBs0l/nIYq3sl8sRIKOzlRVFRm2Ww0UbwXm5g5ejZ41LB2r+htOnuweQzI8rN0TDt7kFwxzShuroBPRmGeR7YWLY8sQqb+0prlyN8OCCTwlFOYc+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719961715; c=relaxed/simple;
	bh=EQsZHPSLuHnOui19pQmJ+cHXC6DD1ZYxjH0AnaaR3Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FS2VfUaditvZEZ21M+llGG1Am5ZkyzJ3nw4kzzicylh1F97YeYObxm80JMaiTB1CUw6TU6+DhRmi5761Bz7raLIcesYblVago6MDSUHBeBTKkNU+7ugK1YD4SSmjCFE0pVDf8cEKR0CH01jSwraCMR23sIAnS5yl5krN6tK9Pb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSVc0O6r; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7066a3229f4so3148244b3a.2;
        Tue, 02 Jul 2024 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719961713; x=1720566513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQsZHPSLuHnOui19pQmJ+cHXC6DD1ZYxjH0AnaaR3Ik=;
        b=bSVc0O6r46Xjr334U+HmOtJjhxZHZPjC29u3/xWOAAG1gE6mMtMUudcA8SFa6MsYEV
         lNEWa9pkVo/fwOozZ/tQnE3NaZGHtzMTy5bdOYX1zZG86I+bMBRnOBXCTPBP37sN36f9
         hXs/DEaiqv9czlj3ZcBcPxW1AI989LeCHHCS+xM8vDPwtEnrX0qIzRS7jpJLMf/imCvV
         //4vbCoEbvF72tUsLHYFzGBRW+ziRoYeF7+NoTiI8P2g+4mVcGF5j7vVDcg6FLrUPGZk
         6hqYP0IYuEXLGulHk1tAjxOSqWCTnhH2l+cXsZqujh4tclFSmhsjeAn+iALcnlzrK6K0
         DQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719961713; x=1720566513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQsZHPSLuHnOui19pQmJ+cHXC6DD1ZYxjH0AnaaR3Ik=;
        b=IgpxoOtmFzQwnrra9t5tbxXfsY+E0twkgK9xayu0akNKji9pdFZK04cVaSjzrYp0u8
         BFw7Pw1xTw21i+2lJPMq3nuLjJ9Lb4iRWRF3vMVoXP4wwrEjh5vvd+3ZXeQb1Q+CMC8l
         lVfSfDHmGOzqjIZ+uF4k5BZexvWu+ZiykN7GDIlLCIR1Cg+prS3iByc6ascEoaXEfvcr
         DpYQJHaLZ3scc+E9RPDufy9uCGcOz84b9g3K/dPfsaLyevh0QIcNSnY4dHo2TYnK1R35
         6mS+PpDjMcldoosRbw3xugmY9tr9QCIVg9j8oT0VfoXIdCL/1FD4HUWTrvYg6Lialgvu
         J3pw==
X-Forwarded-Encrypted: i=1; AJvYcCWOz135gp/R+Sk11/QDEjfb2T4JhmsRD6paUBBFrTHsyr0UTJA6Vp1Qs7IRKURLwBeXl+rq+USu1NYcthvp8CCoQQ53usEC6trZ8zi5zBvQoJJFH6fjP0JFBffHcCYSLtyNnorRAwRsEi1RsNXQwkPjfoB5pZE1rLC4Q86ChYQ03g==
X-Gm-Message-State: AOJu0YwXLmxXyD/5AS7L+Cv/ZDJBFkoyiHkoh21RYlOqAOU3G7ehidNY
	BEctoYhEVOScKjhJP+aCSgaDuivdLsyz3QXP1OYgDG+XKFi4UwW/5mnnKT2cxoRET1pPTRVnvGD
	7bsv+IH5/VuhV8b52t+J/P+umXFU=
X-Google-Smtp-Source: AGHT+IF62KepZG9zhiSnwIcBUc8jO8tEH7cP6XYJ/8YYop6rGd5cjdUizZ76OvaAyZWOZUNGhUxiQ8LI8At1xFO9kOQ=
X-Received: by 2002:a05:6a00:22cf:b0:706:6331:f56c with SMTP id
 d2e1a72fcca58-70aaaf32f31mr9978215b3a.32.1719961713057; Tue, 02 Jul 2024
 16:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627170900.1672542-1-andrii@kernel.org> <20240627170900.1672542-4-andrii@kernel.org>
 <878qyqyorq.fsf@linux.intel.com> <CAEf4BzZHOhruFGinsRoPLtOsCzbEJyf2hSW=-F67hEHhvAsNZQ@mail.gmail.com>
 <Zn86IUVaFh7rqS2I@tassilo> <CAEf4Bzb3CnCKZi-kZ21F=qM0BHvJnexgajP0mHanRfEOzzES6A@mail.gmail.com>
 <ZoQTlSLDwaX3u37r@tassilo>
In-Reply-To: <ZoQTlSLDwaX3u37r@tassilo>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 16:08:21 -0700
Message-ID: <CAEf4BzZx428C4v4D3MWVJa-ySOYKd4tny=JdDE2u-7DTtPYS3w@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY API
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com, 
	rppt@kernel.org, adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:50=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wrot=
e:
>
> > 1) non-executable file-backed VMA still has build ID associated with
> > it. Note, build ID is extracted from the backing file's content, not
> > from VMA itself. The part of ELF file that contains build ID isn't
> > necessarily mmap()'ed at all
>
> That's true, but there should be at least one executable mapping
> for any useful ELF file.
>
> Basically such a check guarantee that you cannot tell anything
> about a non x mapping not related to ELF.
>

Ok, I can add this check. If you know off the top of your head how to
do that for struct address_space, I'd appreciate the pointer. Quick
glance didn't show anything useful in linux/fs.h, but I'll dig deeper
a bit later.

> >
> > 2) What sort of exploitation are we talking about here? it's not
> > enough for backing file to have correct 4 starting bytes (0x7f"ELF"),
> > we still have to find correct PT_NOTE segment, and .note.gnu.build-id
> > section within it, that has correct type (3) and key name "GNU".
>
> There's a timing side channel, you can tell where the checks
> stop. I don't think it's a big problem, but it's still better to avoid
> such leaks in the first place as much as possible.
>
> >
> > I'm trying to understand what we are protecting against here.
> > Especially that opening /proc/<pid>/maps already requires
> > PTRACE_MODE_READ permissions anyways (or pid should be self).
>
> While that's true for the standard security permission model there might
> be non standard ones where the relationship is more complicated.
>

Presumably non-standard ones will have more and custom security checks
(LSM, seccomp, etc) involved. Basically, I acknowledge your point, but
I'm not sure it changes anything about adding this API.

> -Andi

