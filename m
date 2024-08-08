Return-Path: <linux-fsdevel+bounces-25388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D45D94B553
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 05:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F49B20B64
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 03:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3AA347B4;
	Thu,  8 Aug 2024 03:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fv0kefRA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFC929D1C
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723086414; cv=none; b=lAqn+crg1A4FuSeRMpnKqh+fKIiViIjS2oTa9Ctms097Ixp0upAnahGET60A3ee2Kj2wCzT3y7L6qVUDS75xCWXT7nyTnvK/bhw/zA13uIrFABwVNAvPlYi6bVylem5L5+Q6jfyagMWborhEPUKSkiIJl/jFAwiCdy1Gfxd1dKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723086414; c=relaxed/simple;
	bh=s8z+KWgdz2MWkm8Wv0BC9ZBW3mUoBZxS5o6qig9N1g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beCJm+53/K0UJ4CbSm0ZHZL4YXP2NN/VqcyT2L8L7u4FZD1rcv3y3kQYTavA9gaEd3CXaREQ3C9PFM+271lTdbRaXvllfVhpg4/zwprIHuhQIYs7DMWwzhK6avH5Er4JTR9MPqv7TDzmEFWCSDVKA3eL5cXRj8H9TMYzH9nDjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fv0kefRA; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f189a2a7f8so4727071fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 20:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723086410; x=1723691210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OXhWXg6CXw5qrP7zX26KAVz58lUPBrEyObS3llUphxw=;
        b=Fv0kefRAPZ79SEswXqAt/YqJLbN6EJtmg1lSCD6yok1Cj6RrpTLCLGq4VxkNEE5hr2
         UxhCs2oh635SX5nV43llWNa/CWFKa5JJvfyE15KPEKHnDme82Wmj4NVwGO3q8LBApbC6
         DgVkdgmwg6Qv3e6X/l7AeLlrvZdU6BFNWJC8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723086410; x=1723691210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXhWXg6CXw5qrP7zX26KAVz58lUPBrEyObS3llUphxw=;
        b=nQxl0VhANW9VOJBpYsG0r106AcwtqM8UF7yY6poLtk3bWhksJDF28pvqf6OBDrvrBC
         GFRvmzp1ZON/7qnSydJg5aj5OIwWQyTweB6LyRwb0nJb7blVI4QPJi7zt6IrHDlU9FfE
         DZC5WAZc16cNGJhrP6tCHiKlE8+VVCvEMkxbMeaYjBDUuO75L8Rh+nH6MXpZuoVP87jh
         gCoVsIR90ZWLYSmxh9dYe7qZBkDOcxLYsFzcXvVmpp/pkLKF/eATu++FsktfMYZ5GTsL
         O5lRl0ttObmc4Hu91rA/WEB22Wjjz93WbNB9og3rSWs/T+zCFDFP3MxFzE7ixi0oalw+
         aeqg==
X-Gm-Message-State: AOJu0YwVyaGfTcGWXwDfHRI5jhXi1GJGrzQIUwy0/ZvZaLKNGrXSwTzW
	TiB04hlboH6gk2Tvl+ZAmG9WXyBubA5G+Ua74kM/iMYqNm3fv5BF3zekEHYyOwmtNuiWDgW9k1p
	4n4M=
X-Google-Smtp-Source: AGHT+IEKGDASRoI20versLlgtOxfkOCDQPTChcxYNj4sirIX/9nv1LMkeMcgYjfe4MkN/l20j1twFQ==
X-Received: by 2002:a2e:a583:0:b0:2ef:24a9:a75d with SMTP id 38308e7fff4ca-2f19de2e151mr2544541fa.14.1723086410048;
        Wed, 07 Aug 2024 20:06:50 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1ae060sm20483231fa.41.2024.08.07.20.06.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 20:06:49 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-530c2e5f4feso427007e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 20:06:49 -0700 (PDT)
X-Received: by 2002:a05:6512:10ce:b0:52c:8596:5976 with SMTP id
 2adb3069b0e04-530e5896995mr276201e87.55.1723086408781; Wed, 07 Aug 2024
 20:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808025029.GB5334@ZenIV>
In-Reply-To: <20240808025029.GB5334@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Aug 2024 20:06:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgse0ui5sJgNGSvqvYw_BDTcObqdqcwN1BxgCqKBiiGzQ@mail.gmail.com>
Message-ID: <CAHk-=wgse0ui5sJgNGSvqvYw_BDTcObqdqcwN1BxgCqKBiiGzQ@mail.gmail.com>
Subject: Re: [RFC] why do we need smp_rmb/smp_wmb pair in fd_install()/expand_fdtable()?
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Aug 2024 at 19:50, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What's the problem with droping both barriers and turning that
> into
>         expanded = expand_fdtable(files, nr);
>         smp_store_release(&files->resize_in_progress, false);
> and
>         if (unlikely(smp_load_acquire(&files->resize_in_progress))) {
>                 ....
>                 return;
>         }

That should be fine. smp_store_release()->smp_load_acquire() is the
more modern model, and the better one. But I think we simply have a
long history of using the old smp_wmb()->smp_rmb() model, so we have a
lot of code that does that.

On x86, there's basically no difference - in all cases it ends up
being just an instruction scheduling barrier.

On arm64, store_release->load_acquire is likely better, but obviously
micro-architectural implementation issues might make it a wash.

On other architectures, there probably isn't a huge difference, but
acquire/release can be more expensive if the architecture is
explicitly designed for the old-style rmb/wmb model.

So on alpha, for example, store_release->load_acquire ends up being a
full memory barrier in both cases (rmb is always a full memory barrier
on alpha), which is hugely more expensive than wmb (well, again, in
theory this is all obviously dependent on microarchitectures, but wmb
in particular is very cheap unless the uarch really screwed the pooch
and just messed up its barriers entirely).

End result: wmb/rmb is usually never _horrific_, while release/acquire
can be rather expensive on bad machines.

But release/acquire is the RightThing(tm), and the fact that alpha
based its ordering on the bad old model is not really our problem.

So I'm ok with just saying "screw bad memory orderings, go with the
modern model"

             Linus

