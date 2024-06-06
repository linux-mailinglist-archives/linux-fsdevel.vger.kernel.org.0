Return-Path: <linux-fsdevel+bounces-21076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0458FDBA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 02:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F0F1C21DB4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 00:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD641EEC5;
	Thu,  6 Jun 2024 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9WPi2D2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A98DDDC
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635081; cv=none; b=ioZEijuYhEsOwkQPqdGXRSD0lGM+szru5dWE3pkfCgPE1y2qNM8MhLuUVkou6LAc8C79qvXmRCv7jDSJyKBPm9CVA5xVHn++vdDw6A/78MX27d8oWeUGTcCz4sU32wT916yoaRHMfhe3FsOSzzI5PfjFRKUMqYcJeWJ7C7OhppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635081; c=relaxed/simple;
	bh=GRqVKXcsJh/sEtGC6AlRPdUI8v4SOfb2fFYrbfnYbr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhJ2uGhG5tJm2XqGnij/BrvxizDWZg6A0rU3B9g1H+6j8K951b5F02iU7FRkTsSk4WpTYErmIXmKV+NQA2u/q6ae1QiT8nxsZJoJYcuKNNG5FPAp7zRjMdgVvl3Jxew92H8ecAYftJLvxjl6blFNX3pjd/WXazFUIT3FjT6xPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i9WPi2D2; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dfa4ad7f6dfso451771276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2024 17:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717635079; x=1718239879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+cCaO4GQQZF5arDTs75VRTDY7XKwvZ01IHsyj7Khdo=;
        b=i9WPi2D2SIQOws4z/n+I+Q4kv5gk6biurZkPtultB9YREs33YDKujY5qfmjPqMveh3
         sR9lZDet4kOmLTzlwwi1mxNx9gLQmV0hVDDV6chHA/TYO1vQD3Ek7hyxPnlXxdFUpXrq
         uPOVI9r7fU1fPc9oJ/QMcnv02wAkExLI9qKyWEuD2c8LsksEIgu2Z4o0wEJ5BzY/aEJA
         8zTgELWgU1blvN0M7xa+2PJWPNLOXbTd+ud3XN+Eb2Z5CEPyApsLG1JrlEJgXw9KOgUR
         N8w6qDWZAfX7CeOuG0UnTAd0fp5htp0JbnLhrsGOfA6RHcG/Yefl+sBq+EbSuj363lDK
         2kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717635079; x=1718239879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+cCaO4GQQZF5arDTs75VRTDY7XKwvZ01IHsyj7Khdo=;
        b=TXOlEnrM6z1IJHrh2mzPzYAAaO5J+AAU03L8FbqBWti8mFvdlSEPAdvAG25qWGA0+X
         jcLh1RYd7mEsh2aokcu8rIjAuoADG2qH/yVeOyONMc0R1YuLzdVuC1WjCMrCI5wJrTlB
         kYl2GPdiZbxV4O5HdvjUZ/ocfWYh0wRRkRNaxnbb32ah31GUj0kKGbgfolQ6OlZu6yrz
         u1eVhuenJ6aYcimlRPp4k5Y4H2ihDehg2NiadVnGR6N6zWdFrlOkqkXsHW8861+yeekr
         ssR47UDEbwG1/IQVmO7JKxSM+TWRlGvFWaPAP/ZIOdwpqd8Z9KKg87iFdLLLLuflPdAv
         3ROg==
X-Forwarded-Encrypted: i=1; AJvYcCUH5v8nxWDA+lF4SfaY8yIXc/eixXFdGwgRasnsh/Ovi7Ql2fKbvl1GJd8wpEEGoaEGUJqZR+F7gWNeGXM4jbL+Wfvue/VYmLrrM8ih5A==
X-Gm-Message-State: AOJu0YyMLbUH/uhQMLJuk1oXLVsVicu8VT85ew1bc7WF0vNxjecfwIBK
	5qKV39/qGEXhZsmkzTrpu1mlXqyvNs1OvlxojEyBGwDfoRJjBDhYHSm9ycXrnglrZXbBmu1MsW1
	N9qKnvvTinYT9hTCosSSjzC9aGEoDLk1B8GFJ
X-Google-Smtp-Source: AGHT+IEsn/LiMweS6R6p+zt8kRJUiTPyCnADdmFz9d/yv/LTm6IC2uClrAE9Un5+DNW2ZVH+y0uZPZJi/Z0fKwigOaM=
X-Received: by 2002:a05:6902:4c4:b0:dfa:e131:2a8e with SMTP id
 3f1490d57ef6-dfae1313607mr704141276.47.1717635078316; Wed, 05 Jun 2024
 17:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com> <20240531163217.1584450-2-Liam.Howlett@oracle.com>
In-Reply-To: <20240531163217.1584450-2-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 5 Jun 2024 17:51:05 -0700
Message-ID: <CAJuCfpHqDNGM=6+TX4xE-YY91fETSM+r70ZdgxUyw=9X+3qQCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mm/mmap: Correctly position vma_iterator in __split_vma()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	sidhartha.kumar@oracle.com, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 9:33=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> The vma iterator may be left pointing to the newly created vma.  This
> happens when inserting the new vma at the end of the old vma
> (!new_below).
>
> The incorrect position in the vma iterator is not exposed currently
> since the vma iterator is repositioned in the munmap path and is not
> reused in any of the other paths.
>
> This has limited impact in the current code, but is required for future
> changes.
>
> Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 83b4682ec85c..31d464e6a656 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2442,6 +2442,9 @@ static int __split_vma(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
>         /* Success. */
>         if (new_below)
>                 vma_next(vmi);
> +       else
> +               vma_prev(vmi);
> +

IIUC the goal is to always point vmi to the old (original) vma? If so,
then change LGTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>         return 0;
>
>  out_free_mpol:
> --
> 2.43.0
>

