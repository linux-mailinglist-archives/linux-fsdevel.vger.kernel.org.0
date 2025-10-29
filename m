Return-Path: <linux-fsdevel+bounces-66383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3867BC1DA08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AEAD1892BA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 22:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0132E228C;
	Wed, 29 Oct 2025 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DVV1V16p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496092E1F00
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778440; cv=none; b=dLCBYUz6hb5r4QGJxm5lvH1s4OCExQj7zkZqexqGLXrPwg6wuN++jO7h+AbEPmlQC2VrOb/fBbvkKRDcT0DBhST/CBOb/A7mN11SHSPbTMZc+gVYSXRnOvl4j3fB1R8D9hFOpFh/dc+kXpjHEqlhXMmtzyftXHRpHvbXC9CIVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778440; c=relaxed/simple;
	bh=kdNNBM6lcL6vwfZAgX0UdbIS/fpKRmbsinz5ctbBKFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coLLMiCmvAbwsz78IpfqHHRicqVkwnvVEeBdO9wDcB0LvUHvpkLKYW0roAj4p3nhRohnvPfgaPGEkBqr7gXtwexYrk+9AeK7ZDIb0k6KUOh7Gqlt2wm75WfY7EMtU6Cwb2mJ6jYP7VVIY2h6ei+wbAlSsIafdfVSPcTj3T+JawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DVV1V16p; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7042e50899so103298066b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761778436; x=1762383236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iI0bSg1UjmEl/K8c5bJoL0kjm3B4I+PTE1O53XpPOgM=;
        b=DVV1V16pmmkFpnIg8Dd4o0uwOfAEsjkIrggnyhNsdSev35axxtoT/SdEEh0qtERrn5
         pInZmbGoNYfXe7alyb4pBQRmhMss/91Y+pGOU66W9LNhk+KpT6vqTrTk+dP6nlkzI/St
         NAfjIVCzAVFFsCVmGOJeHpfb3zrkEes43D7Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761778436; x=1762383236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iI0bSg1UjmEl/K8c5bJoL0kjm3B4I+PTE1O53XpPOgM=;
        b=nl0W2gSuBbcgv0eQjdcwl54ipf21+L1p/84sUy+V4EPGMYlPDODVcBTAkqyXiGgTSm
         BbgIxLvA4WgGbjrmEh39U11vJt7o3xH/+RfYUxNnm1AjUHGwYBPu2zSmvBliuheCJ+KH
         Ogd+xawa0RqE2x2yhrHWk0BhNaoCXvsWYeTOEBnl24PNv/6bxVX/3SJ5Qgj1UoIJs2va
         s03U/cJa/XkMBZ2D527GoI5TzywbXdUnTfMJpiuCbPm+JiWYzLxBK7PZrjkDm06YDDAG
         gWuqc857/ybBNg1vEKvS+LGoMJCmm/IUiC+FlFowO5welPf2YcTWzgv6bn4y5LhJVVW+
         lPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwXRxISWup6LZHbKSkbwIPLs3aikyPbTVxK9QPaXPkoyIul6g0X8cT5MJmWIQ+UYFkx+6KO0WlJ6oyNrBp@vger.kernel.org
X-Gm-Message-State: AOJu0YwV818yZhSrt7wAXAQT3d6R0lftGDlPWsSJKCiiOJkhVGRVJoci
	XiI/YVLYKr7kcBe9oebKnQId0afJznMaqjzmCosLLugjAv7pBXePTKqneCQ7PCr3A+VJAPilrMD
	3K1AAbVE=
X-Gm-Gg: ASbGnctpsmFF12ha40KHTxA12watuzF6wWVFLc5dLTBUferTyY89tKeqjw+Quz2O9xO
	LAi47AwjOVZN9Uy1twHtbXhdO9NA5S3OUeNJZVi6x2zUU8cIftYjSSqQEj1U9+5REIlv3s8gqK3
	ghZFaQXD0Z8Hz2E+iOZ5Hw/MjmEK2kv38Lm4fAJdttUU56TlKQnvFy94bgql/uoOtC+ubeUVVLh
	3rLejccf6QMb2C5/SqSK31h2eDQXUkPPzwZmc7EOfs5AjTvRra5y4gCElCfvAAtVl6Z+dGIBJlu
	PLphlmMi94diloJzRhy6D5pDULXjGuwhrfMD3vMQZlw6iexBq+FDDRGRdnZzU8lKiGuOyV+z4Yc
	uUemEB9lMmTvJQw8AlTm5zjgcx6j4Dmk++iSjAhmAoNZxtNVLM6sdcLJYU5UEzCo0VrXkOErIsw
	v1yqVRgsauIrDH+mlaBvOaalBHOJM37egc8jxbbVa84WECRZ5FXw==
X-Google-Smtp-Source: AGHT+IEmgWEODkUlJdiSMnWqK9nnHBCv+jSgfDTPTcFV+sdABA/IFDymcrhPGea9TZWiXgBGO3m5Qw==
X-Received: by 2002:a17:907:d2a:b0:b5c:5df7:be60 with SMTP id a640c23a62f3a-b703d581954mr431699466b.52.1761778436246;
        Wed, 29 Oct 2025 15:53:56 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6da1e2226fsm1154236566b.20.2025.10.29.15.53.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 15:53:55 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso750493a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 15:53:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyHGJQjRbIFBNflaBba1eCOp1fvfwpylcunEdCwNbDPC//wXPVQgdDOCqIY7dyfuVWhLFsY0iasIRgLf43@vger.kernel.org
X-Received: by 2002:a05:6402:2794:b0:640:2f98:c00a with SMTP id
 4fb4d7f45d1cf-640441c6915mr3749620a12.13.1761778435389; Wed, 29 Oct 2025
 15:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>
 <20251029-redezeit-reitz-1fa3f3b4e171@brauner> <20251029173828.GA1669504@ax162>
 <20251029-wobei-rezept-bd53e76bb05b@brauner>
In-Reply-To: <20251029-wobei-rezept-bd53e76bb05b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Oct 2025 15:53:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGcos7LACF0J40x-Dwf4beOYj+mhptD+xcLte1RG91Ug@mail.gmail.com>
X-Gm-Features: AWmQ_bnilKb6JtBCLxMS2OjuS6zTMwl7TaRmJaxYXYP0hjivAWUl2_eMnvUSCbI
Message-ID: <CAHk-=wjGcos7LACF0J40x-Dwf4beOYj+mhptD+xcLte1RG91Ug@mail.gmail.com>
Subject: Re: [PATCH] fs/pipe: stop duplicating union pipe_index declaration
To: Christian Brauner <brauner@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Oct 2025 at 15:25, Christian Brauner <brauner@kernel.org> wrote:
>
> Meh, I thought it was already enabled.
> Are you pushing this as a new feature for v6.19 or is Linus ok with
> enabling this still during v6.18?

I wasn't planning on doing any conversions for 6.18, but if it makes
things easier for people to start doing this, I could certainly take
just the "add new compiler flags" at any time.

Alternatively, maybe Rasmus/Nathan could just expose that commit
778740ee2d00 ("Kbuild: enable -fms-extensions") as a shared stable
branch.

That commit seems to be directly on top of 6.18-rc2, so people who
want it could just pull that commit instead.

               Linus

