Return-Path: <linux-fsdevel+bounces-3860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567247F942F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 17:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639861C20B2F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A814BDDC2;
	Sun, 26 Nov 2023 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ePyYH67E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85801C8
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 08:51:55 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a00191363c1so503858066b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 08:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701017514; x=1701622314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/eKsYk+hPdmglJKfGXEKUKNg1keJlZIMZaKIcJ2j7Gw=;
        b=ePyYH67EmfsyqeZyUS1a7QCQjGScNfP4B/fhTxLfD3B2zMfTxOiV1LF+xKmSRpGz59
         5Cuh1ml9kASU8TyO65PV3JXrvdn/jtZH0pSfzyNvZYS9ZeXy8EBn7MW/0jazUTpfqN/u
         s2a503BmthlfAfx/+MS0TkSW74I7zxyzVE05c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701017514; x=1701622314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eKsYk+hPdmglJKfGXEKUKNg1keJlZIMZaKIcJ2j7Gw=;
        b=wY2QdT1xbdXKHV0zmvreoLVEWEiDAzJzlh+/gkqyb8xGABGTViS1698RTwRTnsEzmu
         +xPm/kUQLbHgcMRvQwyULFAT19GhIJUCI6/iyC5nRNLl/mtTyImFiCWsnAaPyArib8Yz
         cIY+Zjg4kAdxBBzxR00zJ90kEFCsK3fKmxkJ0ECBj8KDuzSpDpisfCCXTD1f4XsF1QWb
         8bJn7fhl57Y4IGpyKAQiVFxJoyWT37+e815xnntV6D9fLE08YPqztgzNK7EBqNifcQKP
         5P6IAJ4jxGjbw34jDTpmJNzK9fx7vklYva/78z7Ve2TRoqsUzdHI7oinTrgB2nWcmtka
         InSg==
X-Gm-Message-State: AOJu0YxI1ZX+GlAfv3biaMupc750Drh1S3u8CmG9s6Yqh0DQmLVGDAa/
	SgZLWTfVPhiTUHyfr7FUgFrzt7oFnTZSeOMxLEeWiKSl
X-Google-Smtp-Source: AGHT+IHHHrWRrUNH4GEgGtZP3TF0Kzim7bonmSxNj8D4jKodcJUIE3jHaAPPD5pFJpKudJokjM5cvQ==
X-Received: by 2002:a17:906:e19:b0:a00:8b77:f621 with SMTP id l25-20020a1709060e1900b00a008b77f621mr7541647eji.22.1701017513777;
        Sun, 26 Nov 2023 08:51:53 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id n27-20020a170906089b00b009fe0902961bsm4673122eje.23.2023.11.26.08.51.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 08:51:53 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso4497277a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 08:51:53 -0800 (PST)
X-Received: by 2002:a50:c04a:0:b0:548:4f67:b8c3 with SMTP id
 u10-20020a50c04a000000b005484f67b8c3mr7286175edd.33.1701017513036; Sun, 26
 Nov 2023 08:51:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031061226.GC1957730@ZenIV> <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk> <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV> <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <ZV2rdE1XQWwJ7s75@gmail.com> <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
 <ZWN0ycxvzNzVXyNQ@gmail.com>
In-Reply-To: <ZWN0ycxvzNzVXyNQ@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 Nov 2023 08:51:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiehwt_aYcmAyZXyM7LWbXsne6+JWqLkMtnv=4CJT1gwQ@mail.gmail.com>
Message-ID: <CAHk-=wiehwt_aYcmAyZXyM7LWbXsne6+JWqLkMtnv=4CJT1gwQ@mail.gmail.com>
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
To: Guo Ren <guoren@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Nov 2023 at 08:39, Guo Ren <guoren@kernel.org> wrote:
>
> Here is my optimization advice:
>
> #define CMPXCHG_LOOP(CODE, SUCCESS) do {                                        \
>         int retry = 100;                                                        \
>         struct lockref old;                                                     \
>         BUILD_BUG_ON(sizeof(old) != 8);                                         \
> +       prefetchw(lockref);                                                     \\

No.

We're not adding software prefetches to generic code. Been there, done
that. They *never* improve performance on good hardware. They end up
helping on some random (usually particularly bad) microarchitecture,
and then they hurt everybody else.

And the real optimization advice is: "don't run on crap hardware".

It really is that simple. Good hardware does OoO and sees the future write.

> Micro-arch could give prefetchw more guarantee:

Well, in practice, they never do, and in fact they are often buggy and
cause problems because they weren't actually tested very much.

                 Linus

