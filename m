Return-Path: <linux-fsdevel+bounces-21669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0B8907BCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 20:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDF81F24307
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAEC14B960;
	Thu, 13 Jun 2024 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="chiYTzFs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69F414AD22
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304997; cv=none; b=OYjne3Vnn+TYQ7vUM7mCLe/JqZpVpDDwWq/5dOLSbx6RuyKQOVnQMkaiWnMVuxTVoXfYaIBujFBKzwPAVzPZ44BahCsxziD7OsIR2Zbp6ZuitedKMrRGi3JHbdRfS7mCCG+b1UflSrONsGPBnB9vTH3+LHBf44/r5D4XwhhkKWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304997; c=relaxed/simple;
	bh=xV7HcjHmeGtaHXHk72PhiXUzx2a5TJihz657tRWxpT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVgPge//E4nQwDI3cVKQP8WeyjR41Mn3wp04qptk2/1B6026ec9pv4t2IZUZmj/tjeXoeyus08+SE9+t8BGnvvPvZ/bSuh9A/MtuulEvIB98DJffyivSRBsK5ZnppSxZNfv16pg0/s4f8BKB6yPqQP68E1SLGcDmbBXp83PCwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=chiYTzFs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6efae34c83so185315266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718304994; x=1718909794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=co9iiUYPpsDeUP6dIKaNWZ4aIlC8pyYiOIMGYN9qN5s=;
        b=chiYTzFs2WOiKpXm5DLxBnpoQvkb3MGE41nOAvqTveDlROzXKXms0bpqkOZE/tDB+1
         8WZpXISs5ZKz62zgLO/dSJIYF8vwN4R5cusx96CTX3aiIIkCS5FCHMXy7nDMvtlUh6Gr
         DW1cy8s0HJuPny7BfTqnMgyGFAcZDd9S7f+hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718304994; x=1718909794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=co9iiUYPpsDeUP6dIKaNWZ4aIlC8pyYiOIMGYN9qN5s=;
        b=vTgKkhS0fYIgohkRE3oHvoXQek8v5XsvEy8tcEx0sUChluyOurXxZ9F45FJbRoPZ5e
         xXZlAwINLxLv3vep6XnApPoxQurY4dObDPJW1XFR+NYfzoQqCw5zpY5v3ji+1vbAahNz
         guPkW46gh/gGMSUgnW5N4w2T6V/NFIb5x71UVrzNN3PDvUG5rGiik+CMiH2qjKGhFktd
         kLOM97IpxbgmbELjS0uyY2kV3V9mAJz9CPPkmERDXMEqj8zf1Zo5R9riX0vw9tXZoKTT
         Mz9DBIe2IznExppLGFrMXY2wMI6K3GbyOjPyhgpKACfA15Bt9H0t5XZwXbx4hJnUhTx+
         CqMg==
X-Forwarded-Encrypted: i=1; AJvYcCUdyv4+Phe0QtKE0EOM+PfDCjav1LlV46sO3oTrvBB5vlKEVdrxzOdMNMd5yY+/X70/4RJ4be++nzKhf0CpAsSr8la2/bPNbBnEIkzKQw==
X-Gm-Message-State: AOJu0Yzil6vw8pQS34Gol4dYnmL3fiZXBbwUC47mA5xJ2MChP5IqmKPV
	Ta6KiYKAQqyBoEnk90zs0ySijJ8nK5fDsJR3+BcHW3w2gbzv4CPUAuXjeeCLm80OIYtssOKT+5X
	ZO49hYg==
X-Google-Smtp-Source: AGHT+IHT6hu4QDgXhTLXonNUNOWUaPvablIuPZisqlub6k3gzShefmj/ZpoxtGq1gr13sglch7B+tw==
X-Received: by 2002:a17:906:3749:b0:a6f:2d3c:6b94 with SMTP id a640c23a62f3a-a6f60dc8956mr38525166b.49.1718304993882;
        Thu, 13 Jun 2024 11:56:33 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6dfesm99649866b.87.2024.06.13.11.56.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 11:56:33 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f1c4800easo185011366b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 11:56:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIh049iOVv6EZyliJEc79Fj48VeQ8EdFn6xT7YaDjgM20yp8tAjUWYobV+8nHPmStPdEW5PF3kHOxrbfqAcoGr5aCml1dcGRpkD13x/A==
X-Received: by 2002:a17:906:a849:b0:a6f:4be5:a661 with SMTP id
 a640c23a62f3a-a6f60d460e3mr38707166b.46.1718304993085; Thu, 13 Jun 2024
 11:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
 <20240613-pumpen-durst-fdc20c301a08@brauner> <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
 <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com>
 <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com> <CAGudoHGdWQYH8pRu1B5NLRa_6EKPR6hm5vOf+fyjvUzm1po8VQ@mail.gmail.com>
In-Reply-To: <CAGudoHGdWQYH8pRu1B5NLRa_6EKPR6hm5vOf+fyjvUzm1po8VQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 11:56:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjwqO+HSv8P4zvOyX=WNKjcXsiquT=DOaj_fQiidb3rQ@mail.gmail.com>
Message-ID: <CAHk-=whjwqO+HSv8P4zvOyX=WNKjcXsiquT=DOaj_fQiidb3rQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 11:48, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> perhaps lockdep in your config?

Yes, happily it was just lockdep, and the fact that my regular tree
doesn't have debug info, so I looked at my allmodconfig tree.

I didn't *think* anything in the dentry struct should care about
debugging, but clearly that sequence number thing did.

But with that fixed, it's still the case that "we used to know about
this", but what you actually fixed is the case of larger names than 8
bytes.

You did mention the name clashing in your commit message, but I think
that should be the important part in the code comments too: make them
about "these fields are hot and pretty much read-only", "these fields
don't matter" and "this field is hot and written, and shouldn't be
near the read-only ones".

The exact byte counts may change, the basic notion doesn't.

(Of course, putting it at the *end* of the structure then possibly
causes cache conflicts with the next one - we don't force the dentries
be cacheline aligned even if we've tried to make them generally work
that way)

             Linus

