Return-Path: <linux-fsdevel+bounces-53325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90420AEDB20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E8F189B208
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 11:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D8925CC6E;
	Mon, 30 Jun 2025 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="X/PNxRlw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F201C23E354
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283226; cv=none; b=Z/FQQnO0GjctmQ2qyFv0MZOzOazdQa/4r/UKgh/JQ2BWII86ptKCNMiCBF1bOrhbd6KjToGxCkJ3AcQ68Oxar5meliQlDAh2x1BjQxnpm+ylJHf219jhafH7CapoyoDIT2gNhrFkQVFpJ8XExrD1xGZUw7prlyE6oadRI251lIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283226; c=relaxed/simple;
	bh=07uvHHlnHh0VVlz+DTGdO0oIjOnV9WfuBssw90x/cmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXLE3lcVKv+ZdYIjZORtRL/R8fXXF+hJlxRQL8d5VMYc1o1HAhGso3mAujWSU/RUFwsBXuapn2MtNP0iUe8bHba7lUdTBLFX/+71YLvQvMqCq240Rk9murUD74Em4dVisgz31RyybYD/QezjUzYrqbKIeyymWTC0sInZtgB17Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=X/PNxRlw; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a8244e897fso2662641cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 04:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751283222; x=1751888022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tus3vRMIGbFaFYmjva5uehJWq4zAy8HIVgAKqkn9hyU=;
        b=X/PNxRlw+BPPT66c+eE0je+x1TF5uIfAcJgJmoghc5walIca25O564PA5NozUc1qmJ
         yAyys6FiNL5XYjN8xj1aqggKK7VckoNZZLCnTLdKx4+ANDvoU/j631L0g6yKz74cyzRW
         Juj+5M4eDzsgluC/digkuAD3Tp9yFim9k4cDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751283222; x=1751888022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tus3vRMIGbFaFYmjva5uehJWq4zAy8HIVgAKqkn9hyU=;
        b=JSV65IG6yUJsnGZLpf/2fhH3FaL43DG8M0AdXXGYXGJhttPhs1mS+rLXwblf4HcKm7
         U+fGhdwox+0kvvdXgJToGLDv1O0+9yo/G+c8nsAPfcpFDCdrnWGlQKoDfR0sCwrJZkfs
         9cswdlJfvWr4yED8QrJS7e41mmQE+wdd9TMTJZcVizaZmR7Khj2ePHjue1bZixlmltoN
         AguSh4sDA7l3LYhN+IDXQYFNL1iufXS4C67sTIzuDwb1S/QdwmyhiUQt0j7rVoL9RcB1
         mW403drqIm5k7mHSAnkJaoqMGD2O5lU6JmOgDGxY1bvfBFpa/eLqB54tpZldDoKjh6W4
         0GOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqgtVXnyVyTPrGIzJUXJm8Rp2R9U6gbqV2wIJluf7R13Anf2nGXJ1QZqKZHDU7WadV2JBd0lWE7e1hpsZj@vger.kernel.org
X-Gm-Message-State: AOJu0YxkADzpwlsUtn3EBfSQQJlaDsNF8hTmKeZ9N+5c05W/l0ZVmRgs
	6sCT9Wj9LoXtM222pMJJnuRD+zXTPswF9TeOVqGSw7dBmra8yNufFvOdRrPAxJBl6najMrcLvde
	StxGX++nqxEHjo6eUP/qA6XwCv28Ffk3wJFqRUfBmBg==
X-Gm-Gg: ASbGncs3wHQSiCaT2aRRJoFHFfKLxm0CVwvDfTRVEltYEgk1bz3BnB+3Mfy+7HqG1LM
	44gjduNk87xcSHASq1FjDSZxgJEG9ivYjp7dxIM7Y8QsQHluJh3S9Gw+YjnbF5jPP35fYjVrdxV
	sAURT2EL6JxxhPOHqIUpz+9Hx9RuZYkNDoWTOd/wdi/QZUxiDbZ7Ot4F3wlRhy5WRdM9UtCrYD0
	tznyLNjkvhoKZo=
X-Google-Smtp-Source: AGHT+IH9S55JU/IjYeFl/Z9WS+ibedaf/OWKjQe36UGqm71pSeJDJpYTI0bR1VDPa8cUCW+zm0MzMiI9xe4hyKaQPzY=
X-Received: by 2002:a05:622a:58c8:b0:4a6:c5ee:6ced with SMTP id
 d75a77b69052e-4a7fc9d5233mr236155911cf.4.1751283221667; Mon, 30 Jun 2025
 04:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602171702.1941891-1-amir73il@gmail.com>
In-Reply-To: <20250602171702.1941891-1-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 30 Jun 2025 13:33:30 +0200
X-Gm-Features: Ac12FXxsltcku95DZYoyPdjCaYcmBLG80SjGKx7yduWUYQ-n3cbod1rF4rohhpw
Message-ID: <CAJfpegsx8to=HK7Cu5_9hrgTddrROSSOuCU=cSkhBs_5On33OA@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable filesystems
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Jun 2025 at 19:17, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Case folding is often applied to subtrees and not on an entire
> filesystem.
>
> Disallowing layers from filesystems that support case folding is over
> limiting.
>
> Replace the rule that case-folding capable are not allowed as layers
> with a rule that case folded directories are not allowed in a merged
> directory stack.
>
> Should case folding be enabled on an underlying directory while
> overlayfs is mounted the outcome is generally undefined.
>
> Specifically in ovl_lookup(), we check the base underlying directory
> and fail with -ESTALE and write a warning to kmsg if an underlying
> directory case folding is enabled.
>
> Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> Link: https://lore.kernel.org/linux-fsdevel/20250520051600.1903319-1-kent.overstreet@linux.dev/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Looks good.  Thanks for taking care of this.

The only think I don't like is the pr_warn_ratelimited().  I totally
understand why you did it, and I'd love to have generic infrastructure
for returning extra error info without spamming dmesg.   Oh well.

Thanks,
Miklos

