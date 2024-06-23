Return-Path: <linux-fsdevel+bounces-22193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9526091375F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 04:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5189C2834FC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 02:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962E6C8D1;
	Sun, 23 Jun 2024 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7XzTOa9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C68038C;
	Sun, 23 Jun 2024 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719109810; cv=none; b=d8oMMWPKHtTiCtTso8NTE7SB3lprnQNLOTQFnXcOUFTAx3rSQoHhzj99G9rn0cCDa3zF8HSLBnC9M3vVz4KwF3S1AD4mrrSo/CfQshLtHFRRsZzlfvwHSC4GQrdEuo9/h4CUXOz0xVvm+FLjj0P1r5EH6j0CdtkYStxdQyrFwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719109810; c=relaxed/simple;
	bh=WM541qVAnGiANIIksD1Xne6uz5S+eheGdJIN5eBGE8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msRwO7kdXsdgnolCdJL7ZVGlXAoAQC0E/AESyH9nBFRnrdzFCXqauGK5ijD+G3r6+jyo8H2fABCsMmO4a9yHAp1DJDlZoBp8UFeLETXc+/BdeRQJJwGrxD+R1KJw6sITsQHsUkjWHcDKr6N97WPOfGiEA+tDMrryB32Eb/p1HIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7XzTOa9; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b5031d696dso15869526d6.3;
        Sat, 22 Jun 2024 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719109807; x=1719714607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WM541qVAnGiANIIksD1Xne6uz5S+eheGdJIN5eBGE8Y=;
        b=a7XzTOa9ZvP9S5y6QfYnNtSQOueIHgwSXE+JFZeEtuVVsOuVU+YbgyUMEOa6YX33XX
         M/BCIXVDTJic2SdKdm4o4LqmKat6JnLR8rkGX0Nnbju9Ku3fVBYH9WQnidVuziNy3yoI
         TZshswascL5r5mEEm5zyo0HYBQWFoKWA40d9PUq2l0819be8P80ZF9OOynDOWQFlbfIx
         2YgzKuMVVyS7D1xEZNb/UNOCGxBiQnCBijMewazLLk7uTZmFx42H6ixza5uF3rclF5kn
         SRVM1I8fhhQvsnRbBtOTu4O1z1S/paFPUljP1GRanR+ZFZnassg9mCAt0YYmgg1L6X4h
         l74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719109807; x=1719714607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WM541qVAnGiANIIksD1Xne6uz5S+eheGdJIN5eBGE8Y=;
        b=jnYVMh3Xhu3eikGQ1sfpwoYEozMfND7BFJu9mlF15q5UTQBMr65uROVOsEjBHttS+k
         AQbYjN5gmRJZUgRhAerJKn/8Dq+jG5iXNACusug83EUTekq7WdtGjTsOInPnZV4uWkjP
         KscnQCK0WsXzF472l6RCmRAysVkARlb0A0LLKdo0Vu9NiPLBqf8Rp2QN0Xp+B0m80l5w
         6gUQDVOYTPwPwkI9Ivf8G2t/RzJMdtTs/0YvBrNbgnf8+totCT+TvngNagZzYf9nusuS
         vM+77k0GKe+O2JSimJmYSObZNQtowAkZc4ROckZSHW18p/4NTC38I18EVrrcCOI0TZse
         0ziw==
X-Forwarded-Encrypted: i=1; AJvYcCU7+uaOCOxZBSC8yYXaHM9pbf+zkzTUHHVfe3sU2BXY6qsDX6Nqy6trJ0CKKbGrL71+HAp1QBMXpJJx8+TQlyzmcptksQ6NRYhnGwTbGfcY+P1tIK/NPkKIS9lM/tJ/DwUkbl9qN9kFz+hv9j6zt9xCYFfFK8s6O+Gelpk/tlo5l89U8pD3D8cOrpqEp6y7l/qwdxGSeLqiY/73xKUn/vwckyDjlFfRp88ogjA7kPTKfM9eENCTiinArmCoKh7GkcC5cMUhdUMGqI5aLHEbZe1Uy9RrjDxirEnLI/3cujyoQcIVHBWwZ2WRyjEBB0glTjtuyO0+Lg==
X-Gm-Message-State: AOJu0YyZbv/Qr2Qw/A9eu7F2XkUrJ8RxUqEgwbLAEeXscEHyJUBhfGIr
	yEmicCwtFtMBFTHNCM56A0NEgwSg/tj0pdr62J9WR0BuxtlBdbfyZq6pkdGmPXUbHlFIebJ3zmq
	kJaEaSgTlyJLSb3xB1X+KZDgwXBs=
X-Google-Smtp-Source: AGHT+IEeabbh6/EMckVo526ehLQ90tgELbRwQuFwnoLikHZJL17E+5jYV7YmCBYvSb5so7hxOyIwV/nrsBs0ESAd1BE=
X-Received: by 2002:a0c:e1d3:0:b0:6b4:35fa:cc17 with SMTP id
 6a1803df08f44-6b5409c7b57mr14480146d6.20.1719109806997; Sat, 22 Jun 2024
 19:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621022959.9124-1-laoar.shao@gmail.com> <20240621022959.9124-7-laoar.shao@gmail.com>
 <ZnWGsw4d9aq5mY0S@casper.infradead.org>
In-Reply-To: <ZnWGsw4d9aq5mY0S@casper.infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 23 Jun 2024 10:29:30 +0800
Message-ID: <CALOAHbC0ta-g2pcWqsL6sVVigthedN04y8_tH-cS9TuDGEBsEg@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
To: Matthew Wilcox <willy@infradead.org>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	akpm@linux-foundation.org, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 9:57=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Jun 21, 2024 at 10:29:54AM +0800, Yafang Shao wrote:
> > +++ b/mm/internal.h
>
> Why are you putting __kstrndup in a header file when it's only used
> in util.c?

I want to make it always inlined. However, it is not recommended to
define an inline function in a .c file, right ?

>
> Also, I think this function is actually __kmemdup_nul(), not
> __kstrndup().
>

Good suggestion. Will use __kmemdup_nul() instead.

--=20
Regards
Yafang

