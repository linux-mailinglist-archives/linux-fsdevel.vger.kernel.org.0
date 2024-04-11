Return-Path: <linux-fsdevel+bounces-16628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E2B8A04C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C1C1C2239D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48251FB2;
	Thu, 11 Apr 2024 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Klz/PE8L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41463D
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794868; cv=none; b=e3yvqKHRgjwspemM+77/9UGRYpX8pqlNnJrWXu14puOV+zNaPh2hFKqXBFDhhTYoMqL3y/+qC0czXIHW/Nz4ClNIDylncuZXkCdAVxH91G5g0zuEUkJJYmO2BjknAuFfV9jJEBV+cFvpjjCVM/ARoJ/8rgOaq7NOeSIs3MXeTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794868; c=relaxed/simple;
	bh=dPs4r908+OxuV3XTEJi5fKHrHGqtIvKelez5+yi+JLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1wvJ4r/wUYYV+Mt+OslmrGMHWCFFqueBqOd7wRy0P/OhA6ea4eq7q2EArqQQsLhsuFTy/K5AYzlAp4hynaT4iYNQTJdVSI6ne7BDJoBI1hvt8PIPUQePViflqHqVm5tY2tOBa1qNVe4odtHbtdLZoGP681QQ/OYEozpe/d8xtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Klz/PE8L; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4702457ccbso930026366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 17:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712794864; x=1713399664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D53dlX+N0OwY316dEgjLrCd5tFTXcxUOaqixuP9aphk=;
        b=Klz/PE8LBY2qexUxcZqYSuatsxrUVp7pIoEcmtZ2nyUtzEHHgsWalkntpE21fXDank
         McqInEIgpL/rucV1H7pVNqkUCdP1Oq4irmtb5ddqmemqYqtKKxHsLXMFZ2HNs2STRGGY
         Cz1mrjn5ntdUQ5F5BMYgRzS/pxszmR2blGKyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794864; x=1713399664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D53dlX+N0OwY316dEgjLrCd5tFTXcxUOaqixuP9aphk=;
        b=XUvqOTIF2GU5raAyqLyOarDFKBqEsH11CqUwlfee5ranPtYFRCKswal8hRsC3BJs22
         z5ND8/hxgkAFt993EnOBJmqW6X8LN+AwW069af2cBqK48czlkv5yIJLxCs+d9DaG5qR1
         ii919CkDyRM1Cd7ByeLV7w/ve+tZm5c+hxMLmir8JDrbiCW7iAruOn7Qz75/E4mrEdrv
         /NKZmpIjLN0RvXW9aqKwsaNi4gbWSYCCgSdg063yabqFUVAd85QpXDGyJZJXQpNm2HQq
         03qZ/SXyh0frnKTqJp9rmp3bpGsGebYhZecZgifOclYpfjjFKlh2Q8a50jNXmJlT3a7s
         qTvQ==
X-Gm-Message-State: AOJu0YzZZYkYh9hwtPljIBF2kmBAJNR9awemsbJtSEUn4to6hgalCfvj
	L3JPE0OkU/IEdn0UzOrbnA7AZ8rL2NtD7S3xQ5eIRfikj4Qu4GDpM7uR6ctuE1hLrYqRZfAetvx
	+QOjOUg==
X-Google-Smtp-Source: AGHT+IH1HdhuFjMhfstfsiCeqyeZbF8qrcesF4jxN3MFHLoSjQ80HLASf9nLjVxOJ5KjGE0tNexp2g==
X-Received: by 2002:a17:907:980f:b0:a51:c747:531d with SMTP id ji15-20020a170907980f00b00a51c747531dmr3078848ejc.64.1712794864521;
        Wed, 10 Apr 2024 17:21:04 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id wn5-20020a170907068500b00a4e4c944e77sm200975ejb.40.2024.04.10.17.21.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 17:21:03 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso7235384a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 17:21:03 -0700 (PDT)
X-Received: by 2002:a17:906:cccf:b0:a47:2087:c26f with SMTP id
 ot15-20020a170906cccf00b00a472087c26fmr2601353ejb.73.1712794863170; Wed, 10
 Apr 2024 17:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
In-Reply-To: <20240411001012.12513-1-torvalds@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Apr 2024 17:20:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguGg0Eirx7gA81Gm1qdkviHbAaF_zJbF2qMqLBG8zkyw@mail.gmail.com>
Message-ID: <CAHk-=wguGg0Eirx7gA81Gm1qdkviHbAaF_zJbF2qMqLBG8zkyw@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 at 17:10, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>    "The definition of insanity is doing the same thing over and over
>     again and expecting different results=E2=80=9D

Note that I'm sending this patch out not because I plan to commit it,
but to see if people can shoot holes in the concept.

There's a reason why people have tried to do this for decades.

There's also a reason why it has not worked out well.

             Linus

