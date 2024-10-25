Return-Path: <linux-fsdevel+bounces-32884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2DA9B0331
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 14:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27950B21EB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9D92064F9;
	Fri, 25 Oct 2024 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3pvA4Bk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD162064EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860857; cv=none; b=u0Ot6SHUZsGJzgoCZLzBB7hFSd2ckC25kCfF8qrV5TYedMRDaMbKaw9cY+hBZRt1t0+xZpDTDkoUGdVgXfm0k6zeKogPracWiFbJHOn2KQHMseHG5sDy4J+ze/mnzAhPt6pGI4j7SHt149v1w/bhlhxWnp1ScIS9j/3m3E2okV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860857; c=relaxed/simple;
	bh=x1ryZBWZmSmtZwTLPUx2BCjTD2Hje+3IfAMndcXxCvE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJ+vM38w/ZW7ZHZrv9yg3SZ+PK2pZxL5G4QuoiWdCj/Bd/hCsnRbzOtHluTdiSv6gJz0Th/3r3E17AX6ySQ6ocOrOY06bhEfSjiiltzcmzOjv142nS/YQ6WLP7efcVtibdftdRwQS5+UAq7FPXXMJ3EQ3jK7xiF5hk1eLUqq2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3pvA4Bk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7edb3f93369so1110265a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729860855; x=1730465655; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5E+5IGmjD5RYhRDoYf+p51x7iks9smyytpRiSxJ79eU=;
        b=i3pvA4BkjZ9KBauiIzcETD4SokcUv6iaS77OAAafpz84CdlD1hvaCatGyxuJwFL6Es
         e/grt6kTPzZap4B3fwF5+7RxvA5z4C0U57gCkJst/nT4XfTMHBkqsSQGiwiDYuChtrYt
         f6nBVrIgFUahSL5/x8QaJJBVjUwsKFxyIVaEaPlOXqizA/RSs0MiSqlVAEp9fLbUWrMS
         Dl7eKMXobLzfmGJzvnWGavRCR8lNd/V2Dw37QoKEL7TNujezQb/8Xna/nvhI21TgDTNT
         9ucLg+CpU/FMIRKWOvvNFQOnKEG1+AcaiCSLe1zHnl8NcmsnGkh4I/0FMZE1gWSUfNX+
         jLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729860855; x=1730465655;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5E+5IGmjD5RYhRDoYf+p51x7iks9smyytpRiSxJ79eU=;
        b=MTk955bz74m2essvlHkK+8u8sI8AU0pABGQlaT8uo+kjVu9fTGzjN/E+vDwm480f1F
         3sDJq3jjZm5HadCwRdzHRsJLEox7ahF5WM2Z4SmDLwb3m4URkk8eMbeNjP6XG0SIC5KM
         a4xmZBokWSF/PZhbdUvnLDIHPTihfofvAEzhSN0j2IF6G7WvviLr11IVNEqxcXae+kS6
         P2MoDnmtjLmDKWrZygwwx92lxOKrny8OG6ZzZdci0hHUTWVCWjgsUXshQfQV6AwJkYuH
         J9r9jkljOaVLt6ZUJOgjudG1lAO4RUTe6/qhd7gszJONXvjFaUlVwzvXFlW0TfUGccbC
         lw7g==
X-Forwarded-Encrypted: i=1; AJvYcCX1Uo28OgDo0E5r6tMHMicbEbPNFnnUT8KEM5ZsrdrE4EEUJrT6eNtyQIqwwUYCM4+wU5OyMSjJwWWaDDtF@vger.kernel.org
X-Gm-Message-State: AOJu0YxuKg++leFrMg7ySM8cadUrahcLTRXTG79xWJoYvEGknQ6/Pj/u
	4JBZQ7pBiycdAvl44ZgqZlzRN8hNt1ZZ3Tzn7HyLgKTkfBdo3MDF
X-Google-Smtp-Source: AGHT+IEJsV32RYzl+idFh+LcUZ24o+g7OnwiMcuwcZxoiEpCuqxm4D5Rp6MG7Ye+xrL21cJwGYJ3oQ==
X-Received: by 2002:a05:6a20:d808:b0:1d4:fc66:30e8 with SMTP id adf61e73a8af0-1d978aeaee5mr11694975637.10.1729860854632;
        Fri, 25 Oct 2024 05:54:14 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0d025sm991964b3a.101.2024.10.25.05.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 05:54:13 -0700 (PDT)
Date: Fri, 25 Oct 2024 21:54:09 +0900
Message-ID: <m2v7xgny1a.wl-thehajime@gmail.com>
From: Hajime Tazaki<thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	ricarkol@google.com,
	ebiederm@xmission.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <d24d5197bff15d64e6ac14f538f9718403e478f6.camel@sipsolutions.net>
References: <cover.1729770373.git.thehajime@gmail.com>
	<db0cc5bc7e55431f1ac6580aa1d983f8cfc661fb.1729770373.git.thehajime@gmail.com>
	<d24d5197bff15d64e6ac14f538f9718403e478f6.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


Hello Johannes,

On Fri, 25 Oct 2024 17:56:51 +0900,
Johannes Berg wrote:
> 
> On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
> > 
> > +#ifndef CONFIG_MMU
> > +#include <asm-generic/bug.h>
> 
> Not sure that makes so much sense in the middle of the file, no harm
> always having it?

agree.

> > +static inline const struct user_regset_view *task_user_regset_view(
> > +	struct task_struct *task)
> 
> What happened to indentation here ;-)
> 
> static inline const ..... *
> task_user_regset_view(....)
> 
> would be far easier to read.

fine, will fix it in the next revision.

> > +++ b/arch/x86/um/asm/module.h
> > @@ -2,23 +2,6 @@
> >  #ifndef __UM_MODULE_H
> >  #define __UM_MODULE_H
> >  
> > -/* UML is simple */
> > -struct mod_arch_specific
> > -{
> > -};
> > -
> > -#ifdef CONFIG_X86_32
> > -
> > -#define Elf_Shdr Elf32_Shdr
> > -#define Elf_Sym Elf32_Sym
> > -#define Elf_Ehdr Elf32_Ehdr
> > -
> > -#else
> > -
> > -#define Elf_Shdr Elf64_Shdr
> > -#define Elf_Sym Elf64_Sym
> > -#define Elf_Ehdr Elf64_Ehdr
> > -
> > -#endif
> > +#include <asm-generic/module.h>
> >  
> >  #endif
> 
> That seems like a worthwhile cleanup on its own, but you should be able
> to just remove the file entirely?

agree. will add module.h to arch/um/include/asm/Kbuild.

-- Hajime

