Return-Path: <linux-fsdevel+bounces-26195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8481C9558EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 18:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2221C20DEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22E7154BE0;
	Sat, 17 Aug 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cwhDIYNS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB5154444
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912004; cv=none; b=JO8CkBD5y6LoCO5FD3VdyTwcT2WstgouWZxkhuY/s7EJc/Ke/kw851AjnhIyTi01B8rwZ1fm2EZyAO8FgC9D7XBw1ZkK5OSxosKm1M5Ovk6V5Fxyq2G4P+cg6vc95cXGumGkzslvT8jJMCf0eqSR13J34Cg7XCJwZfGxa5IvH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912004; c=relaxed/simple;
	bh=9dkMY8jFzFQfn6EKGYFPV4tiA60zbFODArOLJ5YzeIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbV+smICeRpt9gCWNS3PMN+t1IZAsBohaI1acNeKf5VOlKBvAk7WLmkpEZg/NBz6ycg9InUu7vbef1CwfO1VBxKW3kPUOniM/dG2KNPFXm+7XDS4DvyUL6+keHpH+PrGU7xvilN+UYr8KZuMUeYfiqgMWxmw79+DMdfKmUnwplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cwhDIYNS; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso44107191fa.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723912000; x=1724516800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=cwhDIYNSIoISsX9G0ssFJ4b5XfsGCZ3GELP4tTqIqAPmBt6ee1vr30jJd8vAyHxr/V
         qLBA/puludwtc4wUalH4fkqJjRNKpY3Xu3CaUFqnRpLkOrZsVru1uqtKV+ux6N8UQfUK
         fvkGXrT/jxAwOJWCL4gTra/n3SGML3rs80A6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723912000; x=1724516800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=l9AXS7Ooy+v1ntpdQIkG3sB8GleI0GYAoU/PUcE5j1aaCOdCSmIjNuQ+OJJXm4RlBo
         uZ9LcZmE/9clVGPJpTVfzg4m2/h1UU2csfDd9L0dRH0RVAhOkI2PzVeiUr5WgPOsWKgu
         lWth+CZ2cfiX8MvKBXfrc5UCRvf+DUSya3KP+kirDg6R2JA83zXXp2D7xwOVHMWC9+Ra
         7bn3/HIVi864nfHuYaDULZZjESzWT0LBis4MJ3pm/UBt6E0aw0a5fqjsihHpLWjRQlXx
         +KsKcrzlf27mVQE54HH2Jq4b18wRRGrVBprjctywQOGzZmf5ujS8GcfIeFGZ4D1ZLJIJ
         fyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHhghtOF8RX1nKFsSmVycn5N1gbuKMIaToJ/9MU/f8DLznvzDr23qkFNu4bjJnvvDOgoytcsW0dZFhgnhwxBs/0qBH1OPWBwaJofghzw==
X-Gm-Message-State: AOJu0Yxt1Sp8pXF7QsMQN0zWEaGUoAS98e3O6vA5R9Xi3Ter+f0S5Jo7
	9m4avNzjpmOBfB2dww/ftwFvuauX1MwhantqCQfwGZ+u76leFy9u1NGdX0VggrE54TXpQyqTOCy
	HK2iRYw==
X-Google-Smtp-Source: AGHT+IE6npAdxLHZ7E0Pg8ijg7ThDeCSMcJMFzt5v/aycal7Ot8lCzfkiRNFXJJBn6vS68KZW57rBA==
X-Received: by 2002:a05:651c:1502:b0:2ef:2f9e:dd19 with SMTP id 38308e7fff4ca-2f3be573087mr58823001fa.2.1723911999963;
        Sat, 17 Aug 2024 09:26:39 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bed0b252b9sm2015875a12.69.2024.08.17.09.26.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2024 09:26:39 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2b1e1so435339a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 09:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQxt0bJZG+mwDOZmEmoxOfvrwDUH9XI5pe/8t49RA3dhZVr3LGfU+fCtmZYqMjsZ+XQO+q6axh2fu/aEOQXeZp7xD6T+ITQgKwgDMwmQ==
X-Received: by 2002:a05:6402:278b:b0:5a1:b6d8:b561 with SMTP id
 4fb4d7f45d1cf-5beca527ec4mr6027442a12.9.1723911998605; Sat, 17 Aug 2024
 09:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817025624.13157-1-laoar.shao@gmail.com> <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
In-Reply-To: <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 17 Aug 2024 09:26:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
To: Alejandro Colomar <alx@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, justinstitt@google.com, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Aug 2024 at 01:48, Alejandro Colomar <alx@kernel.org> wrote:
>
> I would compact the above to:
>
>         len = strlen(s);
>         buf = kmalloc_track_caller(len + 1, gfp);
>         if (buf)
>                 strcpy(mempcpy(buf, s, len), "");

No, we're not doing this kind of horror.

If _FORTIFY_SOURCE has problems with a simple "memcpy and add NUL",
then _FORTIFY_SOURCE needs to be fixed.

We don't replace a "buf[len] = 0" with strcpy(,""). Yes, compilers may
simplify it, but dammit, it's an unreadable incomprehensible mess to
humans, and humans still matter a LOT more.

                Linus

