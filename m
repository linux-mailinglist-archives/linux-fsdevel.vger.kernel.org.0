Return-Path: <linux-fsdevel+bounces-67725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 341A7C48228
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 17:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D44F634A8B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F76531A051;
	Mon, 10 Nov 2025 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P9eB7UWU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642B628642A
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793432; cv=none; b=obn2ZjYju7Wv4kh2Bd3+5Gqzp8KHDqz95kdcG3nHNr6nNYYxf9hlaKAp4Hg1iSJmmsKBMOTnPNEnx8IV3wIZzMTlySQxfuILZSRXrLsZSW+B9o4P8yJCgngiNH84KliwY6CktjZlgJgV9AEtkDSZ1LnproCOIDFDK1tXk8fsfXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793432; c=relaxed/simple;
	bh=XltYOg7k6APNYxmEk9YbYTSDtH+b3EpjGO8HEYY9tKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPlAqHAxiUnsCu/HvUtVfyIMufgSR/3tdit9LeysQP/Js9faCjoniSm4iG8elNM1OITdEY7GFruUrlKfUtydX5jRuC3Yeo4LH3iPjrAXGNehIngtS7R52v8F8TbbNIfqHHUoliGIlVRueoMCVBrb9uc8vlXB6U5ugQo149+e/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P9eB7UWU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso6554572a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 08:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762793428; x=1763398228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DkZN9c+POTwUaLOiQGKa5zH5Hbhc5P5pBlVymH+hWeM=;
        b=P9eB7UWU+twK7fSG145AoH3h8kI70lCdg4NwiDqu0BHulMPUxl5fnFWuMezg3luR1I
         OonG2am+vifDMxkmAbMXey+RibLuAwK6tJIlIHSA1eol1LlJN2v6rSsm3A5Dx8c4Z7i6
         uujAHIOJGiOQtRav3B4AKCD1a+QqYMGvoIMPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793428; x=1763398228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkZN9c+POTwUaLOiQGKa5zH5Hbhc5P5pBlVymH+hWeM=;
        b=b8boFf4SUWpqW/vIRC4xf0nS9Thnsh/ptUWWceKT5FO/qe8D2QeIAZZvXGZeS0bcEr
         cfQkcO558Lsnmw69h++KmCiWpjAjJOLmFIpB7w/XmOpI6gn4Ks5APvO55m3ZJDAH4gzq
         RdrjCuAOwl6JYdDmPOk6DGz4nLH0wwJgcaaHSK3N4sUF8/C7Wq8NGWvPVWMGjE108kMB
         /nsti/GWljkVIpAgeXlOL8GEIlOL3/2XtAPxTFQ9aH6KI9N7m9QM4p7leedVcXR8JBuE
         /jppCN+Uj2eq6dyg8sXGS8mgxivE1ZcWeMTqa1ROV8GVekSyJM8u9JfJzBbF7kDGShad
         YeIQ==
X-Gm-Message-State: AOJu0Yws5Qa17GnwukdxNFYOs7XBYKfUs00iftY1bvckc9GBdCpnxJnO
	uKWy/8gKR7BdgmO9didrsTbgPcHGagG1gSLbFRTsNYUR4TxDNtturORI8BvTIFES6Lg1nPj6uOk
	I09AdrAk=
X-Gm-Gg: ASbGncvn136ISXN9ehO7Hxd74hGplDCcZpfg5Z0Sd5as9s1vR+u8q0kI39ZnPMtk87T
	Ujr28iG2ajzVq55saWIZzfJClT4NM609Kg4Tw4Dg7An96RAXbhLmhsnVvoddCOyi7pzx19rfaFt
	Mw+9lFSJNJ91oJQA1TB0C4o69lTYgPP+f2hZulBoTzH0wKGpwO79YLVgPP3ItYKGvEugvvEQQpf
	ozkvrbyd9GbyR3mdE9rXsJROcnBqm2eP+840b95x/KW1s2wfuYKohLsNPwE9Vtw9JDRHqSAAd08
	84Dz6E3vNDftPaB5KLvmQSwlkMvDoN/YHnR2mEK3dejqvmilDHJbRE8VJsbktNs0Le7mDGbYLEf
	Pt3a/FZJy55E/tP8xIwu6qaippBGwvvF+4CKBPFqt4Lcf/6oQ4bTjrnWoh1LtgZk2j47ZZflfOs
	AdaFiy4zz0etwZYvlykzV8n7Utj74RcxnPLQBTH161glW/uJ8DXw==
X-Google-Smtp-Source: AGHT+IHnrXpXY3Q4aJWb0Hm1Z/kwUj6vLL7DFmukuBV8Uty7xTp61lCnkJPVPcjZ+p8G+U6UJ1EkKw==
X-Received: by 2002:a17:907:3fa8:b0:b70:acd7:2049 with SMTP id a640c23a62f3a-b72e0308518mr963225166b.25.1762793428407;
        Mon, 10 Nov 2025 08:50:28 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa24d2asm1113905666b.70.2025.11.10.08.50.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:50:27 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso6554529a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 08:50:27 -0800 (PST)
X-Received: by 2002:a17:907:da3:b0:b72:a899:168a with SMTP id
 a640c23a62f3a-b72e031d007mr811932266b.28.1762793427368; Mon, 10 Nov 2025
 08:50:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAHk-=wjA=iXRyu1-ABST43vdT60Md9zpQDJ4Kg14V3f_2Bf+BA@mail.gmail.com> <20251110063658.GL2441659@ZenIV>
In-Reply-To: <20251110063658.GL2441659@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Nov 2025 08:50:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxqWfNmPuE59P56Q-U29he2x3BO9C0Q4bUPphBtNdQpg@mail.gmail.com>
X-Gm-Features: AWmQ_bne3SudUbW59AJIrZv5w1KqgWCmrYPp42xrhe0AZmxb-UOp-XffXDbOnBM
Message-ID: <CAHk-=whxqWfNmPuE59P56Q-U29he2x3BO9C0Q4bUPphBtNdQpg@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	mjguzik@gmail.com, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 22:37, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > @@ -258,13 +264,13 @@ struct filename *getname_kernel(const char * filename)
> >
> >               tmp = kmalloc(size, GFP_KERNEL);
> >               if (unlikely(!tmp)) {
> > -                     __putname(result);
> > +                     free_filename(result);
> >                       return ERR_PTR(-ENOMEM);
> >               }
> >               tmp->name = (char *)result;
> >               result = tmp;
>
> That's wrong - putname() will choke on that (free_filename() on result of
> kmalloc()).

Yeah, that's me not doing the right conversion from the old crazy
"turn allocations around".

It should just do

                char *tmp = kmalloc(len, GFP_KERNEL);
                .... NULL check ..
                result->name = tmp;

without any odd games with types. And yeah, that code could be
re-organized to be clearer.

             Linus

