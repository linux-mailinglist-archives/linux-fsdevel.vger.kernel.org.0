Return-Path: <linux-fsdevel+bounces-1592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4517DC25E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 23:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898B628146F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 22:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855E01D68B;
	Mon, 30 Oct 2023 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YN/ELC7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339841A738
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 22:18:54 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31F8C6
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 15:18:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso751161666b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 15:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698704327; x=1699309127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LYuSOnyprjp+HG33EwdMVYAFQkLMSlMk0vWQ/4nUeFI=;
        b=YN/ELC7T16nTgmu2H007nBICGNZzqxAAMvF6CcNSnZ8+K4m/DImkZw/sjTKE4R8vB5
         zeUFmfupie2OpzbK8Ui1bYH4q44OVJBKdMgZk0xAfijml3ohZDwK0rFmgqvMJEHCAvOO
         QeYjiS7ibguBU6KxVNdSVzwf2/jC11wefPU2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698704327; x=1699309127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYuSOnyprjp+HG33EwdMVYAFQkLMSlMk0vWQ/4nUeFI=;
        b=SqZdKglm84LayrYGP76YEy1YModdazdbZxFJKRI0P7jrblgDSerEQBeUp0iF+XYecw
         ++laGH7msoa5/Z9ZyHmlrcgc9MmZQcgmfGMhvHBUg9wjHOkYnvvsn9Algk0YgEgPKgqU
         LlohB/4EfcfMMuMgKpXCJ8mO0btj25LI2HRCz38nRXkhcSGo4qRCIBTnyXKlwXFT365Q
         XSVk2QOuxwfXFzxvLh9FasvAd0ma1McCKV3lL5/KnndXMBisjSujG4ToOCfAzMQGAjUt
         EGhltI8LdMjMws0N2PKCY1llgVmVzdTN06EWA0+LomMaNs2AK5zZ97U089p/CaQyIa0E
         IOXg==
X-Gm-Message-State: AOJu0Yw7hnMWHQlQu+hQMnhAJdF2EOpfkApLSsko5FRAilJJnIkORA7V
	qmcmxxQMK1q6DvZLkbsFz6TsrzIGqVvDvpSnb3NNuA==
X-Google-Smtp-Source: AGHT+IHSjxyjrgC/MYSNCyOVSuFTj9wgW0lqW3hTE9A/EAVPlEnVZVnGLFS/YFFen2qcMwI4Gtz/qw==
X-Received: by 2002:a17:907:6d19:b0:9c6:64be:a3c9 with SMTP id sa25-20020a1709076d1900b009c664bea3c9mr9253725ejc.39.1698704327128;
        Mon, 30 Oct 2023 15:18:47 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id n14-20020a170906688e00b009bf7a4d591dsm6547573ejr.32.2023.10.30.15.18.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 15:18:46 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso751158666b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 15:18:45 -0700 (PDT)
X-Received: by 2002:a17:907:8690:b0:9c7:5c46:3987 with SMTP id
 qa16-20020a170907869000b009c75c463987mr10267571ejc.63.1698704325631; Mon, 30
 Oct 2023 15:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030003759.GW800259@ZenIV> <20231030215315.GA1941809@ZenIV>
In-Reply-To: <20231030215315.GA1941809@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Oct 2023 12:18:28 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
Message-ID: <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Oct 2023 at 11:53, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> After fixing a couple of brainos, it seems to work.

This all makes me unnaturally nervous, probably because it;s overly
subtle, and I have lost the context for some of the rules.

I like the patch, because honestly, our current logic for dput_fast()
is nasty, andI agree with you that the existence of d_op->d_delete()
shouldn't change the locking logic.

At the same time, I just worry. That whole lockref_put_return() thing
has horrific semantics, and this is the only case that uses it, and I
wish we didn't need it.

[ Looks around. Oh. Except we have lockref_put_return() in fs/erofs/
too, and that looks completely bogus, since it doesn't check the
return value! ]

At the same time, that whole fast_dpu() is one of the more critical
places, and we definitely don't want to take the lock just because the
ref goes down to zero (and we still leave it around).

End result: I *think* that patch is an improvement, but this code just
makes me unreasonably nervous.

               Linus

