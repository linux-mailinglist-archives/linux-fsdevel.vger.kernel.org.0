Return-Path: <linux-fsdevel+bounces-31085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEA9991B1F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 00:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723E41C21469
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 22:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4722C165EFA;
	Sat,  5 Oct 2024 22:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gXLqMSuF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B47A31
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728165727; cv=none; b=jwLiQvYnWU1m/LQLF350b0TvfenebrGgeUHpQgsiqThBe3PWDGCRNKF7Ww802DUXKw0ygFa/ccd+D2WXdgkl27s6r6dExF/+xDLSQHxzlhEzhbESM3fxyhUFXbyEXgS63zTXf12PrCZjQMb4iiMfy4K3o0ruJvP6nCsaVVrjBvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728165727; c=relaxed/simple;
	bh=9D4CRA52HesEpy03zmdt00c4pBmsEaPZyjjR9tv7whE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZndnicxH5rz/Zam/syJMQXmuFsQCdhAlXbOe9QqkIN5+vLlrgwYsj7y5hHsRu91LlKvSgj25Rs3f1mckiL0gOdJPBQOvHc/Jn8SngXf2W1zdCllOHkj8UuuJ4+qqegVJ/bsE6GfZWaKv+dT+GA1MD57nZi3fDi+dCgPGkDr10I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gXLqMSuF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d3cde1103so429389466b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728165724; x=1728770524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xe6D4KV8Yk9UIlaX1MAl/0lB3rI1xadpLre9LS2tsDo=;
        b=gXLqMSuFhBkTK2miBso350xMbWQ/S9//hgFjvnBgszoAirqFkYR3BkipNOXLw6xeaz
         A1Yn/Zvbp5CmN+K6lqn44gl7HMQimUWF7c1tbvCD2LvnsFaBnoSdwc9FN/rxYJTkRO1G
         J+Z73j5+J7FVgfL5+YZ55q3P4iZfqpKPUmygA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728165724; x=1728770524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xe6D4KV8Yk9UIlaX1MAl/0lB3rI1xadpLre9LS2tsDo=;
        b=BxOomLaybBryZU6DAGex4sl5YY/6ugfxCXh9bkvpfLRbUlFUUn17ruhVstvQQkwYuK
         diMBiGFeqp1kgBu3HFpZ+Ssz8yw+OHeea6qkZoRHCugLCLIqhV1WxHp8xVPeRiM+8SIK
         tzkOZKgCg5lXblxS1ESanuhmTuwULInRv9SCgjPdRMkOW49TSYqhAsJwl9Sbb5ZZSGys
         pbbo/kzVWDNsKZnqXYo3VoPJNjk9s51NhBuBsfziV+d6u5EBeuKLwnVDKv4x9CJZn6Fn
         QRbR8TnjEzpVh2rDq9CY8Bz7BA4TLmCWsViogomNq+qcqPkKLwUkz9j2pcKteabhq4U1
         WSBg==
X-Gm-Message-State: AOJu0YyaKj7jlHX2d9sX+PLhAtpgyxoDgRdgIEDkLZm6d4LuSgGpFUM+
	+ooSNVtLEvnBpSX364eaAH4GdnQ4BKzCL9wwv9Du0olhODr10Ae1r0ZE1Mny7x+ZeEyL3yZrT0v
	rUUAsBA==
X-Google-Smtp-Source: AGHT+IHZFp1sMi0R1inQPFi1+ZxigL+hsVS4eHW0b/8ic68Zq1xSMPo40z+EZeB6GcdxF5Gy/gvVyw==
X-Received: by 2002:a17:907:d07:b0:a86:894e:cd09 with SMTP id a640c23a62f3a-a991bd057a3mr780136066b.9.1728165723785;
        Sat, 05 Oct 2024 15:02:03 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e61da6fsm179157466b.62.2024.10.05.15.02.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 15:02:03 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8ce5db8668so529504266b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 15:02:03 -0700 (PDT)
X-Received: by 2002:a17:907:7f26:b0:a86:9c71:ec93 with SMTP id
 a640c23a62f3a-a991bd40355mr759061866b.24.1728165722532; Sat, 05 Oct 2024
 15:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org> <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
In-Reply-To: <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 15:01:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwPwrao9Bq2SKDExPHXJAYO2QD1F-0C6JMtSaE1_T_ag@mail.gmail.com>
Message-ID: <CAHk-=wgwPwrao9Bq2SKDExPHXJAYO2QD1F-0C6JMtSaE1_T_ag@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] fs: port files to rcuref_long_t
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 14:42, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> and I think that might work, although the zero count case worries me
> (ie 'fput twice').
>
> Currently we avoid the fput twice because we use that
> "inc_not_zero()". So that needs some thinking about.

Actually, it's worse. Even the

        if (ret > 1)

case is dangerous, because we could have two or more threads doing
that atomic_inc_return() on a dead file descriptor at the same time.

So that approach is just broken.

               Linus

