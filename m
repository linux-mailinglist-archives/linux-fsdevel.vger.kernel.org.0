Return-Path: <linux-fsdevel+bounces-19489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C41FF8C5F1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 04:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD1F1F2223C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 02:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5102E83F;
	Wed, 15 May 2024 02:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XJ8h8vQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5141F19A
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715740625; cv=none; b=M6B3c3pLKFdegRYJdjPwlelwdZu5I7ImW62gPP4HhJeIKWoFXDuvKMHR5LfpXWcKcS0i/M8p54J1P3VKdo6lAISFlPIwxaDCHDAj3qSStXuxerIDtkPnlkkyygP+MssGsSOLXC3uX71POXglNqxXu2KaV0YohquEG8zsiEASFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715740625; c=relaxed/simple;
	bh=anaYlj5uyzV/yorOyeMGx6FlIcI1J0+ASb7d/ruGMs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLj0rnzkx0UYJ62iV63JIydc7e02hoyi+JL34iDXxE0lFBuEd9smt7MvNz15vFtSud0F3zHyJUeJ4O7dnD4BqwMM4o/Oqzw6/vA8uKDPUR/VPzWXxRLnQX/FvqCc0T8zmhTc0pRl4g8b8J1ZKKvrqO8gjbOr4PqnnB9766YV7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XJ8h8vQp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52192578b95so7394919e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 19:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715740621; x=1716345421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ubGmKRp1xaYVLJwscmD9+YdbS90Exthgnbyo4BQtCwc=;
        b=XJ8h8vQp79a4o8sKqbqdR3xIrX6lJkLSm8OypdpfwyRbexczGoVXWNm6an5K4DtYyT
         ETMDbydHWhj+7H5zdd0/GGmzQ3o3bFYK7cGxJ9bZYtXxIsV1lf6Q1iho/7faOrhGsB3U
         gI6vIVpR0s62rLo4HVX4gahAJI/CxtQ2Lm1FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715740621; x=1716345421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubGmKRp1xaYVLJwscmD9+YdbS90Exthgnbyo4BQtCwc=;
        b=UOQvDSX3BBWxroUce1z5EIqqqIkB6zlMHv02JkUEjEpFi6frkYyGXNZzZYT3MQpLq6
         y0/fAfxvIWeChO+jFev6J24hcEmhN0+SYPGJxUYlArO/occn9IfUWxycXGSWlmpPqL9W
         NS1yx0vyEhqwjVDQ/LAMKLduPNRHEP8Xc9WB8/mEfJa8lMdeXlmVt19nkGLoJNvC2sgh
         7Ki31V3n62xpAJdOT+PwiLcXfjtTX5fBmOfbaiGGRvpzeOywj+hl77L4U11O8/A7UfxR
         CUig4GLq/BMKN7eDxDk7huYi+qC+V5fk5Tkb4xf7rVARP7kiAi54JPMtfZ7vQdHhPiJz
         N7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtEVQQUf+3HPQa7oaE/KuOf3ku0RYot60c860W19PNht/U5vC0Fb2aLpgiWDDpqeA8LPed3RIt6JaTG9qxEVXSstBcq46p9nI7UcSlsQ==
X-Gm-Message-State: AOJu0YygtlEtyjooev0V0uCZPs1h6FO+hl6G+uWgAB5ehdYDtOllYJ4H
	rQEsdAmb3GAeJsPv9J0DG7194lCyz9OChmqnFoheRB5TAKcyCJfcEVCFLyATsSURxHMX2jsUAKh
	d7/E5sQ==
X-Google-Smtp-Source: AGHT+IEolow1PQOmzTPx5pG9gN4eXKFF3HucU/n7u6maYIoGix6OX4VxkQx/UQ1ljB5fAyiQg3W3Ug==
X-Received: by 2002:ac2:5931:0:b0:51c:1fb4:2329 with SMTP id 2adb3069b0e04-5220ff74c2fmr8764238e87.65.1715740621239;
        Tue, 14 May 2024 19:37:01 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2cc6sm2347281e87.261.2024.05.14.19.37.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 19:37:00 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f57713684so7971222e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 19:37:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXf4KAQhlDqLCDWEvRMjpnmdDTnTp+OFZxtzZ9bTPQlZozVhEBGssr6oeb8FrcjATtKSxp88WJBpJYfPKhCYXvxHeoDI6XKrM9U36u/gg==
X-Received: by 2002:a05:6512:238e:b0:523:8cc2:e01a with SMTP id
 2adb3069b0e04-5238cc2e125mr729591e87.2.1715740619970; Tue, 14 May 2024
 19:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511022729.35144-1-laoar.shao@gmail.com> <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
 <CALOAHbCECWqpFzreANpvQJADicRr=AbP-nAymSEeUzUr3vGZMg@mail.gmail.com> <CALOAHbCgMvZR-YCJEpEHDCZVwvgASAenoCOOTTX76B_z-jasfw@mail.gmail.com>
In-Reply-To: <CALOAHbCgMvZR-YCJEpEHDCZVwvgASAenoCOOTTX76B_z-jasfw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 19:36:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHsCLoBsCdv2TiaQB+2TUR+wm2EPkaPHxF=g9Ofki7AQ@mail.gmail.com>
Message-ID: <CAHk-=whHsCLoBsCdv2TiaQB+2TUR+wm2EPkaPHxF=g9Ofki7AQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: dcache: Delete the associated dentry when
 deleting a file
To: Yafang Shao <laoar.shao@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 19:19, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> I believe this change is still necessary. Would you prefer to commit
> it directly, or should I send an official patch?

Sending an official patch just for people to try out sounds good
regardless, but I'd really like some real performance testing on other
loads too before just taking it.

It *may* be acceptable, and it's certainly simple. It's also almost
certainly safe from a correctness angle.

But it might regress performance on other important loads even if it
fixes an issue on your load.

That's why we had the whole discussion about alternatives.

I'm still of the opinion that we should probably *try* this simple
approach, but I really would hope we could have some test tree that
people run a lot of benchmarks on.

Does anybody do filesystem benchmarking on the mm tree? Or do we have
some good tree to just give it a good testing? It feels a bit
excessive to put it in my development tree just to get some
performance testing coverage, but maybe that's what we have to do..

                 Linus

