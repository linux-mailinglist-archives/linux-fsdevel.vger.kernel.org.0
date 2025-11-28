Return-Path: <linux-fsdevel+bounces-70170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58142C92C4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 18:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749FA3A2105
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896BD2D1319;
	Fri, 28 Nov 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XlpRAoZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9072571A1
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349635; cv=none; b=Ogvx2bpRTMMx7VOFzW7Lls81z4w50NiunIkZMurPgmHWn17VHpIhimJwFKYmfdiQqsXW9nN+X28w6LpKolPZhIy6LfPpgQ21DTBl66KAc1/VEpHNl7ewbGYdMeT94w68GXhBGSoEoJTEBGcj4+1O5pBsi+KDzdtxhK8FUL8pr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349635; c=relaxed/simple;
	bh=rGLEF0ENLoOZkJ9i8LuAkma8UwpbrhDLgIMxS8jSKO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4wchJrQkzYY6kPh6XMyAJ8hqQENf/b/SnJmbLi9JLNPBoszkii35+HWQGD5GaFqvjFY690L50EQNb7mIxKtuhdX7Ge8H1o95IMJ6OKQ0NUEHHgX3mxFHhI7yRB27hfNkTmTHs0FOCRds/xv5o92c5JgLVbpNttptmw60HnOV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XlpRAoZ8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7697e8b01aso421570966b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 09:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764349630; x=1764954430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dHxMvjmHeLuvFpkAzdRAX3YAUaEt7mxZ79bySuiEqcc=;
        b=XlpRAoZ8qf3HDOhr7YgMc/vWvFB6Ce8PxB03tVBNmJhy4y/+NIoJksofdlzLwXyU/e
         Qw1RyKdHQPVJOfGhm0SnfUKqcaGgTgPcMsyhKOd1LjJmg8D7xIls/SC92f6IchgYh1mD
         RCaB2tXQkK3b6w/3CpDWZO8jLIYbo3HHN1DuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764349630; x=1764954430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHxMvjmHeLuvFpkAzdRAX3YAUaEt7mxZ79bySuiEqcc=;
        b=pLgOceKl2dvzszuD9bLFeQnWcUQKq0r3B8UEbZWURluoOyitDXS5pv29NoTyNMwWTZ
         NTfWF31EwtFbZvIbri5ahOh47LB8IFjDk1vh/YdFPfIp4V0GedWowg93sNwmNgbTXkYq
         L4DciloFBgSz1/jMvyktkI/rR798UpTZDIrDI/dmWuPbBwSRA8SK7SPyDZcIkuE5Q49F
         WkWqXG6Mkrc1jq3TFKxqc5w/YVOUYn8XJaGX8ynbctyDbirIETxMEkrp3JVOkfS1FbpU
         RWE9vNxCLHnOaeA/Jp+8pZaC41iBr59ETqDgaVB3nabMzZGaiU+L+aFyRrS+go4v9Sqy
         S8WA==
X-Forwarded-Encrypted: i=1; AJvYcCXjmLMVTEDxaGnIEaBkLxBPfGLuFqW62ZicEnXN4t0Ip+EGYrMoO1F4wLGfmQnvtOMQPATnyzpchGqz3dEm@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3EDocB8CJIMt4G+94rzjIdehyMzTz3cq08Ln1VNmobImu9t2
	3g9FtsPKR57bjauNSvEalZKPCnX+9bQqMgCaXaNiYRJUd7bsbggwqGaZ00H3oWNX/fyE83LkfO6
	lY9xGsys=
X-Gm-Gg: ASbGncuAzeP8iIHQSmX+XpdqJJR8zWR4yMXnxD9RbNiZDbccyuNrF1v3+coCNFRYdtI
	u1hB9LQdccRSNM7GcezI+vSCkVjKwWql8vzL21GPzMd+MDhwWI6wlGvRSincYPHMBWo8k9Nkqqb
	hCE4q3qEmCYVJhO1s4v4xqjrQe8Q+wXYZeyOc/S5+0i55RwYLWUTR9n5d6uxqYzD1Otk6ff84aS
	sy/KuxSIakiDd3EclGZlbEs2pCOf0n9umFAgSRyryg3aBCH4V8tBmZ/6255dUwxNUdhVGfhlwW5
	gZjyGOcQi5RSYcudZZRvIQdIvNEiNtMzPXYEuPEEUL41PP70Iy9cK65v032pL9ksGJSbzykt2KW
	xq2wPo4+OAOL9BtBbrKW4CzJBgH9+sdNOds8U40DJqR+wV1NE8bKYQu3nN0AFG1eNK/S5UcnD2D
	fzfOX6OrKfPN6SP4LpQGEqYU5cBKHgrq1JEHulmkPC5fDK+TSGxT248tDTR6r3
X-Google-Smtp-Source: AGHT+IEoXG1L7RYSP1rLGnoys17wdNZdAvhgRVWnzifrBfFfc2nRjk2u8tnL3AbTI/+htOtF3j1d8g==
X-Received: by 2002:a17:906:4fc7:b0:b73:4fbb:37a8 with SMTP id a640c23a62f3a-b76715159f4mr3264298866b.12.1764349630138;
        Fri, 28 Nov 2025 09:07:10 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59e8612sm471961066b.52.2025.11.28.09.07.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 09:07:07 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so3535471a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 09:07:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUukl+8wlQahlis6Q1vu82oDo1at2vaZwNpOApK/9+dO/XzE3OCUXWGF+S0156K+nxB6LY0seRQqjFwLyeV@vger.kernel.org
X-Received: by 2002:a05:6402:2708:b0:63b:f0b3:76cf with SMTP id
 4fb4d7f45d1cf-64555b85bb5mr26149888a12.2.1764349626340; Fri, 28 Nov 2025
 09:07:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <33ab4aef-020e-49e7-8539-31bf78dac61a@huaweicloud.com> <CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com>
 <aSgut4QcBsbXDEo9@shell.armlinux.org.uk>
In-Reply-To: <aSgut4QcBsbXDEo9@shell.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 28 Nov 2025 09:06:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com>
X-Gm-Features: AWmQ_bmE-6XAFAPa0-eSPLJJDbgRImzhoDMUlnAscfmarz6vBK22IDNiLQ8b6yM
Message-ID: <CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com>
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Zizhi Wo <wozizhi@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, jack@suse.com, brauner@kernel.org, hch@lst.de, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, yangerkun@huawei.com, 
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com, xieyuanbin1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Nov 2025 at 02:58, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Ha!
>
> As said elsewhere, it looks like 32-bit ARM has been missing updates to
> the fault handler since pre-git history - this was modelled in the dim
> and distant i386 handling, and it just hasn't kept up.

I actually have this dim memory of having seen something along these
lines before, and I just had never realized how it could happen,
because that call to do_page_fault() in do_translation_fault()
visually *looks* like the only call-site, and so that

        if (addr < TASK_SIZE)
                return do_page_fault(addr, fsr, regs);

looks like it does everything correctly. That "do_page_fault()"
function is static to the arch/arm/mm/fault.c file, and that's the
only place that appears to call it.

The operative word being "appears".

Becuse I had never before realized that that fault.c then also does that

  #include "fsr-2level.c"

and then that do_page_fault() function is exposed through those
fsr_info[] operation arrays.

Anyway, I don't think that the ARM fault handling is all *that* bad.
Sure, it might be worth double-checking, but it *has* been converted
to the generic accounting helpers a few years ago and to the stack
growing fixes.

I think the fix here may be as simple as this trivial patch:

  diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
  index 2bc828a1940c..27024ec2d46d 100644
  --- a/arch/arm/mm/fault.c
  +++ b/arch/arm/mm/fault.c
  @@ -277,6 +277,10 @@ do_page_fault(unsigned long addr, ...
        if (interrupts_enabled(regs))
                local_irq_enable();

  +     /* non-user address faults never have context */
  +     if (addr >= TASK_SIZE)
  +             goto no_context;
  +
        /*
         * If we're in an interrupt or have no user
         * context, we must not take the fault..

but I really haven't thought much about it.

> I'm debating whether an entire rewrite would be appropriate

I don't think it's necessarily all that big of a deal. Yeah, this is
old code, and yeah, it could probably be cleaned up a bit, but at the
same time, "old and crusty" also means "fairly well tested". This
whole fault on a kernel address is a fairly unusual case, and as
mentioned, I *think* the above fix is sufficient.

Zizhi Wo - can you confirm that that patch (whitespace-damaged, but
simple enough to just do manually) fixes things for your test-case?

           Linus

