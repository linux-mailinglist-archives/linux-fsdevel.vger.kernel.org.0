Return-Path: <linux-fsdevel+bounces-39059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6DAA0BCFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 17:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2211164249
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A3C20F06D;
	Mon, 13 Jan 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIXQHB73"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305720AF89
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784684; cv=none; b=GsaPg6sM8QHGNmNXJMdOhWGKEq+D/GCUGX446OE5E3Rpyzg38wrTy1N8Xss3duqEEISyApmFDUYjaI4OjHuKMEm2NgGgWtHMCdoSYVBdy+ewS/tkTMEH9yXrfFp1UPe0Z5dnsRhJiLpINk4/wTYo6HiqJARKWDaLzX/pUsPgtLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784684; c=relaxed/simple;
	bh=psxJGpeVFsbrFufxwmUIDo351AmSH3mNDvNXtHO2nq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abzYksavqShVzZ/27eWmqgSqCn0Hnjsj1Igz16I5tcOfSBd2xpAgkEggYIC9WZSwQocBKbGhjm/R90i3qKXEqHh8wTj4d/Xri0qUdbek9OneyWan6Kry3AkRr3fILVxwQLPJ9pcCsvRpwIVQv6YW3VxM5Bm9pGNQ45DakmriFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XIXQHB73; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8f99cb0d9so32515306d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 08:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736784682; x=1737389482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nln6xuSTTaoMOsjO/bzAdYR40fjFobKxVXqk79yIRg=;
        b=XIXQHB73/bEY5a04oXp0dZ2wYzZySyXsuDRQdnh10kK/CJIr0IPEzK2YiJ8mvOwVfT
         EwycpepZyRm3Askly8S6VpfQGsvf3y5EIqidaM5T5MggyC/S4rAaMm7+zCZm/a1rfFhm
         rHSqF3z3BEA7/hWcc8cMFAr37yMV3oF86wPF4M5Rs+1Tml+nhlkgvHhbxDGQV0EoS+uZ
         iybLcpugozsx1kZ8IsEl1ddrHTZxqVKq+rA2poIzC3lcxQo9uuBg9iRbg8JVqav2gHwj
         EyHNWzQfFyXbQtwP/dFABvHufqL8SEe0MDApGbC3UU8KvRs3dmZiRGrqEfnWNda7O/B6
         AA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784682; x=1737389482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nln6xuSTTaoMOsjO/bzAdYR40fjFobKxVXqk79yIRg=;
        b=Ha3H3qP78VNrl+WUmWw2iem+DqRk4tcRZro3WhtIJ6EORQD2h1vxlD6nhu7j/OLeZC
         edrRVN3WPyMQjcxsejgsPC7WQZsR4meORtTsvmQxDrVld80yXBBeNAVCy4c9FxUYpSu0
         bdYza1Wb7XHpdhZAPLfg1EbJU3zYiZ1pLq8fiTCfub9QLaRfKwFW2y/tT3n37+RB6AnX
         hhiyNsKmhiPsUFhZGP/l5mIwm0NxaLIh46fIIgrEXM85lcAmbZRxFTFddmRHKkqRVH1e
         ZbCZFsb1U60Fy5kn91+bzF+Z0Y4ZibclnZFOnKJwlNYfhale+6iSh83Y6OmmI9ySk1mF
         fGig==
X-Forwarded-Encrypted: i=1; AJvYcCUHWPBYAt9jifKwK8a/IgNSzCvJt0rH4CWI6qBUARGk/p2E1DtE6zuM+Xbl2IrCZIpgmt43lUpJS4expi6/@vger.kernel.org
X-Gm-Message-State: AOJu0YzBHCo1+0fGd6rqV3AvTWcO5fDf3/eLaEnPN6PNBOKFQ/ftRLYU
	uqBd2BulaDgk/jc0OAIKULTlLfwuWWV1NwqDtkXjv0lvIkaLE0rf0nQiNB9ApcU0+wmYyaynKbb
	OcmuC1W3Y4pO0ULnkU5wBcSdmIxtlC3q1nrG8
X-Gm-Gg: ASbGncsIfjQOU7U++jniQqJqEWTmE3VhfRjCaO/MOC/mXAQ1Gitlmlzwv0/A4ZoPm2g
	PGj26e2amKCaqZBFFtN2jtXMVkTXZps1uXdE=
X-Google-Smtp-Source: AGHT+IEZHimf0erqHl9P9hdsVm///MN8stQzn+Oj7UFKcLM1rFbaFHquGnXMlUQnxJqTuDGwgck+ox3NI5bhvjgf1ZE=
X-Received: by 2002:ad4:5ca5:0:b0:6d4:25c4:e77d with SMTP id
 6a1803df08f44-6df9b2ddad5mr358474696d6.34.1736784681463; Mon, 13 Jan 2025
 08:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com> <20250113093453.1932083-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250113093453.1932083-4-kirill.shutemov@linux.intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 13 Jan 2025 08:10:45 -0800
X-Gm-Features: AbW1kvYVFjw-APVc_AtsFocTeHs3A7WI3FQm934n3hdXUG8p6Ploc_paz3DXv-A
Message-ID: <CAJD7tkYfh=K1FV2NPFD5P0+Td66PtoMRHAkAcwUJcRwYDKLZjQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] mm/zswap: Use PG_dropbehind instead of PG_reclaim
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Airlie <airlied@gmail.com>, David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 1:35=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> The recently introduced PG_dropbehind allows for freeing folios
> immediately after writeback. Unlike PG_reclaim, it does not need vmscan
> to be involved to get the folio freed.
>
> Instead of using folio_set_reclaim(), use folio_set_dropbehind() in
> zswap_writeback_entry().
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zswap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 167ae641379f..c20bad0b0978 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1096,8 +1096,8 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         /* folio is up to date */
>         folio_mark_uptodate(folio);
>
> -       /* move it to the tail of the inactive list after end_writeback *=
/
> -       folio_set_reclaim(folio);
> +       /* free the folio after writeback */
> +       folio_set_dropbehind(folio);
>
>         /* start writeback */
>         __swap_writepage(folio, &wbc);
> --
> 2.45.2
>

