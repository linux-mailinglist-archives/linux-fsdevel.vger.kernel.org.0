Return-Path: <linux-fsdevel+bounces-12724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E178C862BB6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 17:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FF01F2163E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 16:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32271179A7;
	Sun, 25 Feb 2024 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iogBR9kG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1E12B71;
	Sun, 25 Feb 2024 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708878461; cv=none; b=d7RzV6hkweEPkup3xup5o+wLIWmD0AGzAvO96gnxFDtpPssP4ph4oqNsBaJarxay2zPKsW90TSX6gGMhbhfrUV4X6jp3eGfvjiKAW3LGkMtUgxISavYmPJYGv+GCg5G6gY34vBUpsr7nXn+CM2b2RXQRfvtyp1gWLXYE3gvqRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708878461; c=relaxed/simple;
	bh=gb5bJtceNND73BjHmlyG5x/sd65hla0KFc09jMWSpVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL0q8gUvnFuC8EcLD5+V5MhITpsJ6qvr2d2yVHQw4A9yFSN7hd7u3J+JoRMWkMmXgOsHHrgbqoTKtxdfEARCerUFEi3i/QUL9WnKuOTyyofTPmC/bAXY8NZ4OyItSs6/Ppyuk5Z6FlEne8902ejm+O60AbFXI8SyS8YXCWs2xeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iogBR9kG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso352034166b.1;
        Sun, 25 Feb 2024 08:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708878458; x=1709483258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghE9UsVsRsht5B+PMQ24QOGWHn/KsoHJpuMVm6m8Dp4=;
        b=iogBR9kGlhcx1/ZaEBqSgdrb+xoCbfeQbr5zMrpVOK70yoZx0h5/h0jmpVZSziDpBe
         VrEkDzP5esCrs9xtRwOH+nNPGuXvcYK4Gtt69e3rZAWMQbR6Mn4H5McQLuvn50jPqNlC
         iX/RMivTM+l3R9JR+JBjnXsHLNr5z3g+OcYcI4O9/bDpLm6Jl4djbO/R1U4g6YVl6MCt
         dBw1HVO6KYPEUTdXhACnF+SZmO2Z8Dn8BS6nGaP9yVehNDZ4DAvySQQNY4zXnAdYKlIY
         NhRfdVVBcrJ4M9r7RtRTBDxC+2VycpDMM9V8PAaUdB87Pd0z8nGKKQVzDG4V9Cb2MPrk
         JiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708878458; x=1709483258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghE9UsVsRsht5B+PMQ24QOGWHn/KsoHJpuMVm6m8Dp4=;
        b=tS88AZZvxoS0LWXog9VGceCF1HXLkoCh0PCLpSoSc+OTmtgIDAnhnSqonoqBMwX7Hg
         WF8K5DwaxKl8Fst1G6Fnl8P2AyF8KP8s/Qqk8m9dPxkkhhOsX3URB30YITg2jPNq0XYG
         rL9AJY/IppvL5KH9q3Vy+c2RPt66VxzwEi4/nesQUxIE2ecPhXRL7pxxm3xCrh+9MdW5
         eWQs4n3eo16Fcbjt7yruddC1qAIRZCJAabfYVS4D7wkEPrPKdaaezV6QLWj+jPMB81kU
         mJ2B9YS1bsi83qzweQOodqUZLzPWkCoTC80BfS+hrGm3sXgv4olPcw+c56qtB9SQOKZI
         dVxA==
X-Forwarded-Encrypted: i=1; AJvYcCW4+CEvemtedzyp4quQh7tSHhI+0njEG3N5CwyBtPsBd6/rGV9FZa6G0MwN7ppMX1ZbB4P4ABG9rllVrhHqEkvwGWFZs+pVdOY113sYVF4VwjScPpW5J+4pr/p+rO3Zd3b//zmbIEo4tf5rnBvPE6Du2PLOOKjHLC13FUIUFiGdfwo8NBIBYjM=
X-Gm-Message-State: AOJu0YxfEXkBZYYtB3emM9ohxno8AfQXTbDOBhaFdgIoH7TjJIeChQtN
	hRZOB2II0Lzt4Z3BSpTnmM0GTVYJRWj2RBE+E58OGWbEnvncAhs=
X-Google-Smtp-Source: AGHT+IF6qtjt1TQl8ufgEE/ZnsMaI0DH+4cDDo62prPueo40PGvMvPsZECLMJg21tbqPccNwbPbY0A==
X-Received: by 2002:a17:907:20b4:b0:a3e:599:ae86 with SMTP id pw20-20020a17090720b400b00a3e0599ae86mr4230693ejb.9.1708878458166;
        Sun, 25 Feb 2024 08:27:38 -0800 (PST)
Received: from p183 ([46.53.252.131])
        by smtp.gmail.com with ESMTPSA id un6-20020a170907cb8600b00a433f470cf1sm376549ejc.138.2024.02.25.08.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:27:37 -0800 (PST)
Date: Sun, 25 Feb 2024 19:27:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: WARNING: fs/proc/generic.c:173 __xlate_proc_name
Message-ID: <fe33dcf1-79c0-4f56-8848-474caa014c10@p183>
References: <CACVxJT8T8u+XK7GnyCus19KDVqfquGbAM-0x8bSFgKTeqhD2Ug@mail.gmail.com>
 <c51a282a-bdbf-4ced-9fcf-e38a33152761@gmx.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c51a282a-bdbf-4ced-9fcf-e38a33152761@gmx.net>

On Sun, Feb 25, 2024 at 11:47:30AM +0100, Stefan Wahren wrote:
> Hi Alexey,
> 
> Am 25.02.24 um 11:37 schrieb Alexey Dobriyan:
> > > WARNING: CPU: 0 PID: 429 at fs/proc/generic.c:173
> > > __xlate_proc_name+0x78/0x98 name 'R1/S1'
> > proc_mkdir() didn't find 'R1' directory.
> > 
> > In other words, you can't have slashes in irq names.
> we already came to the point in the discussion before (link in my last
> mail). The problem is no libgpiod user (userspace) is aware of this.

Changing '/' to '-' or '.' should be OK. Whatever you do, don't change
to '!' because it will make these paths annoying to use in bash.

> So the next question is where it should be fixed?

libgpiod silently weren't getting directory inside /proc/irq/${irq}
and nobody noticed until now.

I think returning error may be too harsh but replacing characters is not.

> Sorry, i took my original message because posting the last message to
> linux-fsdevel without context would be pointless.

