Return-Path: <linux-fsdevel+bounces-15611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47064890BBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 21:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755601C30BD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 20:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D1B13AD16;
	Thu, 28 Mar 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUxXwm9o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47B13AD09
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658551; cv=none; b=SrhqJywpZZvHPKlLT7Usrd2ce3K8qZQep2nt2Sovli8M2VtvOJXy3C6XG/hpLcMj6J6lLDk2q3A3JpMV04+Ki0Ri5A880SM7cdwZjoAPG1fvYFYk+8p3TrdvWX/brDDuBbW+UduVHM7wFm5DkFkejkLbC6lWlxmNYhvwYwVpxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658551; c=relaxed/simple;
	bh=Xvp2uzp/QTshAzSCZHYKZUXilg18C3KOX1kGmd5mi/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+pADI7Oe90gp2johoIvJgMjkHTW5Xs7pRV8RNE+7cTAGfesG7dRKq1aXcojZh/ZyTL+UaaRnHlAa5GO6QIXf8W4RW0cMYwte5D4fRdcSRBpa2NhLa8jslJYXc5YT6Gh7LyTvSDpYhlNDS6U4qdkkDxinPE8LjI+yT+0/9xgdM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUxXwm9o; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4644bde1d4so178004666b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711658547; x=1712263347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvp2uzp/QTshAzSCZHYKZUXilg18C3KOX1kGmd5mi/k=;
        b=vUxXwm9oJsnXRK86vLRxRSCc8vaNnRtf5+2D6eOe01lrXh8yQq7frJWjr7debMq6al
         LS76w0JG256Zxn7GgaQXYrlPhwD7O9sq0czcbsIu7ny8RSp3UbAGsepCS8ysppufD55s
         3muCOk9S53P7+K/cfzP3jzF8lSQDSD1DakmAGdGlMPAvcdrk1x1enhsBylWCVwMqD13j
         DDIM1A4VHUwCgFqoX403FF8xTSpUfYOxuLXaY5NsG//MLxmqPAfTZGeJThe7TkKudYDq
         WGm4lG/k1U4QMeiqhjzkYcw2ylF/0bONGrmQWUkT9mHpbrCB1PLtuKxS3GkglzpGMkHz
         KfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658547; x=1712263347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvp2uzp/QTshAzSCZHYKZUXilg18C3KOX1kGmd5mi/k=;
        b=R83zaBS+/Q1KbvEtqYHhpAVxrFN9YbupqLM1uGCwIRVrqwGj9+ceJbLx5oAjsOB+A9
         OprWuCQJZrHmPte2xME6VkQ8N1LaBY/cr9KANTE9/d4auZLhK0K1sYbpGbNBfvYTqQFi
         jkzCqhnqVI/n0oPRWTJXeZEbRyoTekVtvb68OSKm95Yau0f7bn9jlDCtLFx8EPRSb34N
         wOzDbuW1MOJbvBDX1W/In5AwcXCQnrUNJe3wllR1sRfJ5/vPcrLwEcwBhiT/X7vZk2Wv
         NLVhanwTfE3PiiEROlBgW+UCXancPuYS8TCKUW/WEZreHl1IiZ9ilEUCfV3Q4tGPqCag
         NAHA==
X-Forwarded-Encrypted: i=1; AJvYcCVeEZRiAhjJiKUxtRdwh/0g+3gxu+6zJrP5inr6sKXxzas2Q7gyzfctM6b8oV53cVpMcpgcPinBWHIz4fxPeXU/u/WVpAivdlS8PNNnJw==
X-Gm-Message-State: AOJu0YzCtAEI4MwhMDUo3JUK1N/pXsTloO8x5T69JXVQavrrmKIJT2Bg
	1lIZp6ulyZMU1rb+8j42dbAGJ2CaVJYVzsE7jSxIdxJ2nf7w0j9jXNXJTZnAoSK12q/b9GBkdiH
	qORMeW62e13WEeRakJsa5lOnYNO3yBBh12tM5Jjc2GxXieAn3c0eVAcA=
X-Google-Smtp-Source: AGHT+IH8/usAUioO+qTpOeTXvg7l2hto6OnlgP6NOT2Q0qO008pCvTP/WT/jXd9Z+X+Kqw0CBmjAO9+FEscgo7LRR4o=
X-Received: by 2002:a17:906:594:b0:a47:32b3:18c5 with SMTP id
 20-20020a170906059400b00a4732b318c5mr203139ejn.68.1711658547456; Thu, 28 Mar
 2024 13:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com> <ZgTMZ1HYheBMDbei@MiWiFi-R3L-srv>
In-Reply-To: <ZgTMZ1HYheBMDbei@MiWiFi-R3L-srv>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 28 Mar 2024 13:42:15 -0700
Message-ID: <CAFhGd8pU-utbgHhU5s_20pC_aNK7xtsJDbf+Ayg4Dck2K=4kag@mail.gmail.com>
Subject: Re: [PATCH] vmcore: replace strncpy with strtomem
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 27, 2024 at 6:48=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
> > Mark these buffers as __nonstring and use strtomem_pad.
>
> Thanks.
>
> I didn't build, wondering if '__nonstring' has to be set so that
> strtomem_pad() can be used.

I do not believe marking buffers as __nonstring is strictly a
requirement. However, the documentation from string.h +302 says we
should do it:
/**
 * strtomem_pad - Copy NUL-terminated string to non-NUL-terminated buffer
 *
 * @dest: Pointer of destination character array (marked as __nonstring)
...

and so does [1] ... "mark the destination buffer variable (or
structure member) with the __nonstring attribute..."

FWIW, this builds just fine without the __nonstring attribute but we
should use it :)

>
> Thanks
> Baoquan
>

[1] https://github.com/KSPP/linux/issues/90

Thanks
Justin

