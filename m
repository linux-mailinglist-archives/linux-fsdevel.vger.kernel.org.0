Return-Path: <linux-fsdevel+bounces-10077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00CD847983
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5302916ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9081742;
	Fri,  2 Feb 2024 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGsC+oWq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124F81732
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901213; cv=none; b=tECSnqWgNTyohwXrAh7J2ElI/D/cm5CR6/DtxMV8B0ovviH0PlvrT0kGejF+wmQyQFBYtevkYjQLDcwRD24dp91kQA8Wxex1HRlrtfhhkk/DuCFeoglvD3TaQGGkxkfbDuX7f1zvk3OCqWTLRJvPT1ueUCd7WnzDgwgMSXrchIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901213; c=relaxed/simple;
	bh=SX/1kOEJ3Ax/hWf0xgUvpBYNBAwAbB0XQf4SpCcsEO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGxGaKdc5nyDxN1BmZZz747Bqh/O56nnieIGBszkGBCl5PSkkdmkb6GDunn7DSxdBENdNtELjajl1Qe9iLexhtvnEQXtm8fgCFP+BnNm/+2pKu6CMZRMabLj4Ao1nVvfSf34s4Y9yKCY2D9kFq/S0r3vS66+UBscEVt16Qi9B5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fGsC+oWq; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51124d43943so3904419e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 11:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706901206; x=1707506006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzRl/p/zBM55V3qi6ZzeQftf/q51vbL6S+/zvQ3KD1E=;
        b=fGsC+oWqI+tXN4krWjbjiW1iDJ0NLvgaKZujuNHwvkVd3eJg3L/7BESZI2rayoPYuJ
         mTTQCxUQTlgD0Z2ob1598wD5WwwpFaYZaLhrTf67mt8WuLcv2YtdpgCK0aAkOFbDIYfp
         Y/Cp+5SkFBAcqEr07vQ6r836mf0j5yxGx2tDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706901206; x=1707506006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzRl/p/zBM55V3qi6ZzeQftf/q51vbL6S+/zvQ3KD1E=;
        b=cqV2A1TswrDI0C8/zkSmSure0hkSU2T7BHujydLsqfwvthjS9LhYFHmKRn8gKpTV2a
         w5MmAWv8G1JE4CaDy7Yp4GWZUoLEsa0gI4C5A1zgGmUYougjv96O5vGhNsZpzwohWYM1
         Cu5lBsTfEakKM8QAORXxSHGNIDH8mvD4089p2AfTgAVL5gSCvu4mQvaHUuecpuJAw30z
         vzoT8QXW9kdZYngSVs48k1IrYZOPynsI8ST5UKFCsGbt7NIfiJRNGXR3ruB735QIl59F
         QwSW5zPM0k9DsYbE5weJsMNLkiphYg6MvGI4ZEYEPNvq10yHov4ajGyLQec0raV1dPa6
         n2eA==
X-Gm-Message-State: AOJu0YxCXPiNgD0EdXeXt0KpeBrnlpo5D5WOJagttqxdLcCyOmUopHud
	5TH3Eqt9xHcRaQ0quh5ZFnxXlgPlef8LhvDgChLA8tUqwDaJar9NM+b5qJ9iKvGM6q7sKzU03y6
	oa2vS
X-Google-Smtp-Source: AGHT+IFF4ZMvQd/WzDKU61Nznx5vpOdp5i6KDVniE+yYfNbjssk4ufL4FHTxZ5Sggx48KktM8PyZ2Q==
X-Received: by 2002:a05:651c:205a:b0:2d0:6364:fd73 with SMTP id t26-20020a05651c205a00b002d06364fd73mr1837091ljo.33.1706901206082;
        Fri, 02 Feb 2024 11:13:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUoYshSmlB+an5GzNHB/92CmFSgu77xV4tJ9SM6A6izssG1RtmK7bdID8yFS2lYiumaUZxteamiDtnvhs3K2BB9b101hzrQ+K0JGVnMOQ==
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id o4-20020aa7c504000000b0055efaddeafdsm1035542edq.86.2024.02.02.11.13.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 11:13:25 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40f00adacfeso6575e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 11:13:24 -0800 (PST)
X-Received: by 2002:a05:600c:6016:b0:40f:cb0d:4dd1 with SMTP id
 az22-20020a05600c601600b0040fcb0d4dd1mr54895wmb.6.1706901204019; Fri, 02 Feb
 2024 11:13:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <20240202012249.GU2087318@ZenIV> <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV> <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
 <20240202034925.GW2087318@ZenIV> <20240202040503.GX2087318@ZenIV>
 <CAD=FV=X93KNMF4NwQY8uh-L=1J8PrDFQYu-cqSd+KnY5+Pq+_w@mail.gmail.com>
 <20240202164947.GC2087318@ZenIV> <20240202165524.GD2087318@ZenIV> <Zb0vem7KC28gmT5U@e133380.arm.com>
In-Reply-To: <Zb0vem7KC28gmT5U@e133380.arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 2 Feb 2024 11:13:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XDg2Q2Gkv0pnngfUMJUOctXhe7f_33DW4TpLxTdG7KBw@mail.gmail.com>
Message-ID: <CAD=FV=XDg2Q2Gkv0pnngfUMJUOctXhe7f_33DW4TpLxTdG7KBw@mail.gmail.com>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
To: Dave Martin <Dave.Martin@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 2, 2024 at 10:08=E2=80=AFAM Dave Martin <Dave.Martin@arm.com> w=
rote:
>
> So, if the only reason for trying to migrate to vmalloc() is to cope
> with an insanely sized regset on arm64, I think somehow or other we can
> avoid that.

Right. The only reason for the patch to switch to vmalloc() was in
reaction to seeing the order 7 memory allocation. If we can decrease
that to something sensible then I'm happy enough keeping the
allocation as kmalloc().


> Options:
>
>  a) bring back ->get_size() so that we can allocate the correct size
> before generating the regset data;
>
>  b) make aarch64_regsets[] __ro_after_init and set
> aarch64_regsets[REGSET_SVE].n based on the boot-time probed maximum size
> (which will be sane); or
>
>  c) allow membufs to grow if needed (sounds fragile though, and may be
> hard to justify just for one arch?).
>
>
> Thoughts?
>
> If people don't want to bring back get_size(), then (b) doesn't look
> too bad.

Either a) or b) sounds fine to me, but I'm just a visitor to this code
so maybe I'll let the adults in the room chime in with their opinions.
;-) Also: if you think it's fruitful for me to try to write a patch to
do either of those then I can, but I also wouldn't object at all to
someone else writing a patch to fix this and I can just provide a
Tested-by and/or Reviewed-by. Let me know.

-Doug

