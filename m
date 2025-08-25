Return-Path: <linux-fsdevel+bounces-59020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5671B33F29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA231A8230D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E0E1482E8;
	Mon, 25 Aug 2025 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VlQCwF7+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB40F128816
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124270; cv=none; b=cFEpZkNKMhuoyzJ5nIaioD5AsD8Szsu8X9tYdqd90Z9ojnhdbAs6wLHNO1oVFrNNstZvb8R19IycpH//gayVC8eVuvwIwmioSiZUPnFKVvgZCrJtdgXEQM/idMOXbwm9GvnIHtm3B2gLe94b3LF3DLuFm/nZ5uUNd69bsFVMBYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124270; c=relaxed/simple;
	bh=e8LYWHxz7LbhsdTuFIlFQsJ40N+ctFVeeW031XZAOwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LY96nVanZy+kypz+gAyNx++ocwpPaUkAoOdjv7JxdhfyxMWQ9NnCfYQvqcd28RnrfKt8vNU/M5YH2e5wd5nsoqudrZctqO4BPScLUECVWRq8u5yB0A5VdUEapJ0kX6SVdNgva78+NhmEE8S+nRFGGsW0KFVXbaojOZk94qqUH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VlQCwF7+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so8980215a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 05:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756124267; x=1756729067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ceo5tC7e+mg6tvHXZBK5TWVaAtx3yIYvZGJwSDmUJwM=;
        b=VlQCwF7+JILaxP7RWhh7Ycq9KM4YA7xIGiVzpDrxnFI51jvCzq1okMBluhztl8TSsa
         U4CJGeVLF/ITKSZvfUC63WOgO7H0eL3G12GaHMn4SAMBdFuy9JvqWm9rYgGOKgKPylqs
         pPGWK8Rb0/pmqLCPI0Utw+X5TpQLYWiay6PcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756124267; x=1756729067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ceo5tC7e+mg6tvHXZBK5TWVaAtx3yIYvZGJwSDmUJwM=;
        b=KljQsL80NnFxihx/lS+8qZGwocJj9yXmdlEGMIq+TaRivoy0XiIbtcFFkPgT3utMnL
         yt6DwEJ+Ci3k+5kcMgIWsrij8v4W8wMVWKOBjudRZE8DPvl1we7x5cGMYGiMUFueJ/0w
         5yQ+oyj0Eem3c9PNn02bFrrOMQTNjzWT7fsXMAyMPiUpDPYDE9NQjao6JgIpzJiXWseF
         jtTFJsZEXwFJT63lnSl889QUhiEkC4eshLilf2fAcBc8kyOViYTH4ZzKeGUbtqZcBym7
         3a1DPXIXXPy2o74ZgpvhPKCTGHI7AbcdoLL9koX0rTuEgWJLAnKz5lRrJbl2AhfizeUm
         Vaog==
X-Gm-Message-State: AOJu0Yy7p8Pk+/MTqqMiRWUUe/VQPqVvr5gb+ZmluK+XdxJjv2spP+sw
	pu5o3Tc8xojCxzSx3mmwT4M5c3E9uHA6DYsERtnKpZJLlD/Yfyvd9N1Oz0ELhowE3bfI03oVC0s
	FP1crWs8=
X-Gm-Gg: ASbGnct3hmviYs2i8wgVhk2MH07aeNVy8VlQ9N8waO2cJIW0Igx4Z/4Tg0Bvv3xJgCN
	qnD+amusheZ8jykPqKTX2leGAaaKDDrzl16cH3CJglkMrTE3U2LF0098zfZpGnyGEHZ2COyAaTh
	rVZXN4x7bjTsZ7fzZ9r6ceMHQ3B2NSh0xCMoU2rLQ3MNeaxkiEicavwiKLs+5T9mlfyKbmw7mx3
	kDeiOtpTAn9swK4BeAeZnUiHO1Q+HLKBmdygNDZTf1pvNtpcHPptUQTB9Gn2io5eYFjr+05GuHG
	PKPx7+HpJveoYYUokrFYp12pczQdb2HFCqb6Dksnhc5gHWMuuGv06hVWIihl1AGLbiISnLS4MGM
	Y/OhYoLjI/4s9q72PARLVek0Q2ZzhelSq7+bpTe12V7+PGm5As56HnVbo6aWLPGYV9m9M81Y0
X-Google-Smtp-Source: AGHT+IE8rFY+uV612pH4xRY0sL3RBtj8/gMR2FnWFNixwBT2f6q1oDuM9MH8+ryyB0C5zwrB0wnyug==
X-Received: by 2002:a05:6402:a0cb:b0:61a:967f:55f9 with SMTP id 4fb4d7f45d1cf-61c1b492cb4mr10413694a12.10.1756124266897;
        Mon, 25 Aug 2025 05:17:46 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c316f4f45sm4881231a12.36.2025.08.25.05.17.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 05:17:46 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso5488638a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 05:17:46 -0700 (PDT)
X-Received: by 2002:a05:6402:21c1:b0:61b:fca1:b80f with SMTP id
 4fb4d7f45d1cf-61c1b49e81emr8946593a12.11.1756124265056; Mon, 25 Aug 2025
 05:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825044046.GI39973@ZenIV> <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-20-viro@zeniv.linux.org.uk> <CAHk-=witRb_kEiWmwuaF4Fxz7gWuefn8Nxer05SHMOYxePUZSg@mail.gmail.com>
In-Reply-To: <CAHk-=witRb_kEiWmwuaF4Fxz7gWuefn8Nxer05SHMOYxePUZSg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Aug 2025 08:17:28 -0400
X-Gmail-Original-Message-ID: <CAHk-=whxLCf8ExPhinc7WgTisc1=ka=t6JKLEvTRgkjAr3KWhg@mail.gmail.com>
X-Gm-Features: Ac12FXw-a_CLN9K7byp7YEu3kCZ9SipMrSjrjN2zmLY4Qv0qlpbX_I_MRbQgm_I
Message-ID: <CAHk-=whxLCf8ExPhinc7WgTisc1=ka=t6JKLEvTRgkjAr3KWhg@mail.gmail.com>
Subject: Re: [PATCH 20/52] move_mount(2): take sanity checks in 'beneath' case
 into do_lock_mount()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Aug 2025 at 08:10, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, *this* would look a lot cleaner with a
> "scoped_guard(mount_locked_reader)", but you didn't do that for some
> reason. Am I missing something?

Ahh. You rewrite it to look very different in 34/52.

            Linus

