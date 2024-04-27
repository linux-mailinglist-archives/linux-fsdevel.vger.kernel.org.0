Return-Path: <linux-fsdevel+bounces-17985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0909D8B485E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 23:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40DC28295F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 21:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE19C146596;
	Sat, 27 Apr 2024 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DqnOULJ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEAD47F63
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Apr 2024 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714254044; cv=none; b=bPQCyAQ9TxJPcqRBqI1MBNf9RahL/xnvWUPBSjKHcce0HBrlf1/FdUx9RqXx4mRo2qM5zVa+w7K/SfL12b0iNQHh4YUNqEH1gYl2GoDq0HpPXczyzTKnLODlrvpkV7VFsTtzWo2VXGGNgxVDMj1irhY0rVypXaQOk/8OmIZGNQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714254044; c=relaxed/simple;
	bh=IIGshDaph8veGUjCfHMCr5hhSRQX7mrwk6r+2BogNic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s29OF2DD7kr9iJUpuE37qFhPqDTwLDWsGJ+wj8qEl3eGzcft4q7GIe6aqjwPpOoB5IZGBqwM7pSUqcSUY9OJplInmVYqdlr5JyQpiTz/sLhDpI+nBtal9JeUrEw6AtmMTOD27JXDPKM+mR6aMfRcc1KL4hh8fvtSSkOdHHgikks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DqnOULJ9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a58eb9a42d9so63375566b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Apr 2024 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714254040; x=1714858840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mA6ESoMU41euVvMMgdzVMUo8Y0YkwHfh7I4CxBNPhNU=;
        b=DqnOULJ9dqAM66O2vPpfXP9h4/RTISLzUsRpuasrayesu09yyFLA2iM/KmCT/LCWiA
         JNnmR6CEoccMoaPzEU/pI8WMRxLuVGLXekJqfgKUM/jn0sCdZUCWmIzwuNO7QogEfoIN
         p71K/OpKt5F5f1BuT67/hN0iQj1fi2LxxQ2mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714254040; x=1714858840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mA6ESoMU41euVvMMgdzVMUo8Y0YkwHfh7I4CxBNPhNU=;
        b=B8qiHhKn6/CRY1fq4c6aiwjlfjBS9VcPLMvVANfVJK+W8KwZheT9wKNsMn8EpfKr4L
         beLE0j6b/82mw9JSgl9BA4lTQ7LELUPehal0/415k3mMbZyTMmS6RCGNlJPF/dOYLhg1
         O/VTE10zFar0k30l2fy/OfcatD74MZ6A7RVfU7VwLZ8PxY7U4dmRGL3wE/ttbVHUCZfb
         fTx5v85XDGvl+iBfxS5SEB75bOHRNMXLs+Lkt1Le4F3xKzJqEBU6pFobDq9hoOgktrRD
         YjQnzcgq2k2qHQ/CjVSnCCld/4q5VZnDDj6NZAJodjWM0BpsFnwzgao55sUKGIDtM4vj
         SiVA==
X-Gm-Message-State: AOJu0YzGCgw6ifbyhjgr9CzIjimqRrQECxl9FFSAjrGAWRx/cLwKEyaK
	kW+46yrFSaDDxDg/ghdwaRGx56V8mmlqHmd3zh+/fS1fyK3AYcOpPirkxy8kd1EF8gtHTupAPsd
	EGnw=
X-Google-Smtp-Source: AGHT+IFpZXJPALKIBmX0NFMcui5pbOGS1+cO8SsbzUqwexN6CmFfgwQq1ADbaEpSL2e7Dpd4yHkgMg==
X-Received: by 2002:a17:906:b2d2:b0:a58:eab7:7bab with SMTP id cf18-20020a170906b2d200b00a58eab77babmr1433426ejb.52.1714254040466;
        Sat, 27 Apr 2024 14:40:40 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id y20-20020a170906471400b00a58db2429b5sm1619078ejq.111.2024.04.27.14.40.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 14:40:39 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a58eb9a42d9so63375066b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Apr 2024 14:40:39 -0700 (PDT)
X-Received: by 2002:a17:906:22ce:b0:a55:b99d:74a7 with SMTP id
 q14-20020a17090622ce00b00a55b99d74a7mr3773528eja.11.1714254039321; Sat, 27
 Apr 2024 14:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427210920.GR2118490@ZenIV> <20240427211128.GD1495312@ZenIV>
In-Reply-To: <20240427211128.GD1495312@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Apr 2024 14:40:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
Message-ID: <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
Subject: Re: [PATCH 4/7] swapon(2): open swap with O_EXCL
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	linux-btrfs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Apr 2024 at 14:11, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ... eliminating the need to reopen block devices so they could be
> exclusively held.

This looks like a good change, but it raises the question of why we
did it this odd way to begin with?

Is it just because O_EXCL without O_CREAT is kind of odd, and only has
meaning for block devices?

Or is it just that before we used fiel pointers for block devices, the
old model made more sense?

Anyway, I like it, it just makes me go "why didn't we do it that way
originally?"

                Linus

