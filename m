Return-Path: <linux-fsdevel+bounces-12687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F2A862880
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 00:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24171F218B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 23:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89814EB23;
	Sat, 24 Feb 2024 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P1n2qbfR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8196F4DA0C
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708818244; cv=none; b=c1K49++/9Nj4DIywiPlGhmjRNo7KtOUfWNOKY/iVaCe+LX7yVmFIZbiCBgR0hLECLQXI1/EmCfquKs6436u6DM44aMLZId73f2pquAO8JdeQH7iT++E9TXAdE2CtCapaiJ8hyJ3ENMEHvNTBEeJmefTWfy60SacVYGmQ0pnqYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708818244; c=relaxed/simple;
	bh=0ndlmRNxvgqmudYDAQDRY+8XWH+i1OJkw4ZkBFWvYg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b30pN3p2Hov0baKPESs8B0peHQKYQFLA5h3BQ4HAS8jTuQkvQ8bqibvGsInb9AGkbnNqMJB7gb/Rhh7Mr1TduQN+6MoR8s9wpoFQIFMffwgO3AErcr+aE2YLI5tS6dR14rYTvCHpWlcJBWjVV+zpgkejVGr5uFVpJ1G9skJ/hbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P1n2qbfR; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512b700c8ebso2489264e87.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 15:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708818240; x=1709423040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kqv7MLKTQYTKAbyJaXLJ3NjnKr158GpyjOGnut0vOtM=;
        b=P1n2qbfRPOAoXDIL93Z1Z2Cr/McC+kkfO1mhGiCIoV9IvzZxV0/SYKk6gTXzWU8jql
         7F2GA+u+ap3nY3gouplc2TfoATHLlu8cv/83lPU/cqSxYWOYUWeeoLwT8GTl2DELSY2L
         CqmEOIIJrsmhEzthp6DHUFSSlcXer73fNMG+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708818240; x=1709423040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kqv7MLKTQYTKAbyJaXLJ3NjnKr158GpyjOGnut0vOtM=;
        b=lbuY6WUf6kSd6w1LuuLnUl9So5LRVy6mI98002XwopWOKbmXN5nUO6sz03LXc0n0fw
         XNwTzqeBRw9YOZYWGRESDxJf0L/4kiC5v2rFNduHnP6FHsHEekUn+fbPdyAtmqCFhRTa
         r7thQJnZz6pFrF/MF/hMwaMSndrW69HxoctxlMLsd1hfxFzlcVQmDF/imlR95qw2IyiP
         OOSyEp/GSV/2cEzI3Y4Et7cRgCHS+7xz8LCLkYuPLml8k8J8+nu9KDkxNqO+DqHRwZ17
         ceZWNKprIe1Rz/miYV+h06oWQ56AWbQOZVL8JFj/mjPRpSI3P52itrFrXe0lQAWyIw7n
         060w==
X-Forwarded-Encrypted: i=1; AJvYcCUEcg1YXt3bNITtWQTVwo9ZFFV+qbueFsTCwJdiH4VRUS5RqOJSgLLwO3JlA9R4hwf910vVjuofD9Mrxt/10PkQ23qrBpRl3m0JCk4h5Q==
X-Gm-Message-State: AOJu0YxyCGcIeV3pVPb1k4LRVAatFrpxow5t6OHYIUOkPKK5Ao6l4caY
	Npyr7slPEAKEP/RT4FELHosm72fP7nbhZwYMIcu6bT8BqgOAsxEZhs/Qh7oeutVvHDp1BB7G297
	8TM0=
X-Google-Smtp-Source: AGHT+IFfxneAWH0oqFAFv134x2FqQxWx8ebhU9eEIW+0iLuSNT9gGaayucF4GJoD2jWau85sABdnsQ==
X-Received: by 2002:ac2:58e2:0:b0:511:7256:1a32 with SMTP id v2-20020ac258e2000000b0051172561a32mr1951688lfo.49.1708818240636;
        Sat, 24 Feb 2024 15:44:00 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id kq5-20020a170906abc500b00a416fbd0184sm985723ejb.115.2024.02.24.15.43.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 15:43:59 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3eafbcb1c5so244560766b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 15:43:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8so4nPQsD+Cd+Zenqj8spAvvneL6wSdSCB1mwJVkzBH5Efi/rOJXPu5aOLubZt0j+DSIzaplkQHsyWVYf8ggul9QAP4m2cUorwoQWWQ==
X-Received: by 2002:a17:906:c7d4:b0:a43:20ae:9123 with SMTP id
 dc20-20020a170906c7d400b00a4320ae9123mr202316ejb.50.1708818239390; Sat, 24
 Feb 2024 15:43:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a150ddd-3267-4f89-81bd-6807700c57c1@redhat.com>
 <652928aa-0fb8-425e-87b0-d65176dd2cfa@redhat.com> <9b92706b-14c2-4761-95fb-7dbbaede57f4@leemhuis.info>
 <e733c14e-0bdd-41b2-82aa-90c0449aff25@redhat.com> <f15ee051-2cfe-461f-991d-d09fd53bad4f@leemhuis.info>
 <c0cbf518-c6d4-4792-ad04-f8b535d41f4e@leemhuis.info>
In-Reply-To: <c0cbf518-c6d4-4792-ad04-f8b535d41f4e@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Feb 2024 15:43:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9nqLqxr7bPFt4CUzb+w4TqENb+0G1-yJfZbwvRhi29A@mail.gmail.com>
Message-ID: <CAHk-=wg9nqLqxr7bPFt4CUzb+w4TqENb+0G1-yJfZbwvRhi29A@mail.gmail.com>
Subject: Re: [REGRESSION] 6.8-rc process is unable to exit and consumes a lot
 of cpu
To: Linux regressions mailing list <regressions@lists.linux.dev>, Al Viro <viro@kernel.org>
Cc: "Christian Brauner (Microsoft)" <brauner@kernel.org>, Matt Heon <mheon@redhat.com>, 
	Ed Santiago <santiago@redhat.com>, Linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Paul Holzinger <pholzing@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 23:00, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> TWIMC, the quoted mail apparently did not get delivered to Al (I got a
> "48 hours on the queue" warning from my hoster's MTA ~10 hours ago).

Al's email has been broken for the last almost two weeks - the machine
went belly-up in a major way.

I bounced the email to his kernel.org email that seems to work, but I
also think Al ends up being busy trying to get through everything else
he missed, in addition to trying to get the machine working again...

             Linus

