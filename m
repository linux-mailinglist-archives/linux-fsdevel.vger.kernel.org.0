Return-Path: <linux-fsdevel+bounces-8210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E39830F7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 23:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92FC1F22E4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 22:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE01E88E;
	Wed, 17 Jan 2024 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgcUy59G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A881F1E87D
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531596; cv=none; b=YA9BxmJNAn8T/n4xzqfzCVEyLuBxzDWVfFO3IOCHdydx3fkVRg/taLPtvn/Lw6lRoSn1SFjvWIh06ExH9ZO17lhoFFlxsHDXsPhcP4zLrcXdhrc4awGdyxFefbBgHT9jibEuM4ghP0JTC5N9rAkrinTtzAP/Sq5dllrsNtTrEwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531596; c=relaxed/simple;
	bh=iUlscJeTm4pbcg+uiIT41dxgdS0KpwW/iR3/zKnUo08=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=FUuTZJHUj7ttDOQpwQPmwMPMCRpHdvIhZn7JbJ9RKkBpGHw2XoU8coZIsA8ngMJlJvcEH7eu1UVD+1tHAdAnhlytdtC1Vefyi/lWNac1mXzVNMUVCQpJ4pamZwBVAbn77PXvYQ2URY/fJBY5XxdOVW1cXRgg6QwZ/nUTNaFTUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgcUy59G; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ff7a098ab8so6302877b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 14:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705531593; x=1706136393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEtfKHM4jQzQLGyBhBaXBaAlBL+U+MX7o4RckoJKRd4=;
        b=lgcUy59GfI7bWRPKu3lW8abUo3M6xXsWdT/t+UVqA0OsOM+ooeizGyQf6KVBM/wJxH
         x9tObR0CybXihTbypLnrMphrQVgUo/d/BPMTRIAeLfl4RUYmSuQnBzvcwBurSgH2qRVx
         rq5h2oao5h4FkWrCecVQYbMWilz0vb8pV5FxjBHzH2cZkaCtf+L2qrE6fERccn33tHlz
         5yq9CyrZuruj6xzNbI5I2IJYZjLMdTCIHO4DdZEC4oOyM9iV7eSVQ1oSlztyc3zKBEfI
         ERPnZP4DYK7fPeKxKAxW5Ex+HYGQVojbP0VH0nafFqEXqqY48dPdt8WrhTDUzNlrzC41
         Nq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705531593; x=1706136393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEtfKHM4jQzQLGyBhBaXBaAlBL+U+MX7o4RckoJKRd4=;
        b=W5VplAa4OKKFobI8Bb2cehiF8dAasEi4ussq11jppw/qOungBiOtAnd1FVsDEGnBir
         ekor107xAMs8MoQ7g+X4Q4R/lHkkZ1YStkS1fq96N733fDeCyk+yB1e7nw5f/VUigLtX
         5MEzNSzmxGC3LoqFaUJfF+8jdQ7Q3eu5n/SjkxUKwaI8s3kGgaIlF8kuOuHzG1uJjSmq
         NFtBGAWIPULbdwSGmtrJGr1PX9c62raSrlLyi2XORFo0Z8qQO1JQ0ovMUFJUDBgK0yE/
         E/dETK8skLxD9O5xy0nPMX9AKlp5OkQ+uYsj1mDkc1pHzz5muRRaGLiBG5GS620wn4jd
         IpzQ==
X-Gm-Message-State: AOJu0Ywnv0KcoATRytT4GGtPqeTSGpVDj8jO1I4cYlnmaTaxGAa7eQ37
	ezOtnCyly7kOobGMAPdTtOgfZIJek6PHrzI8zSU7/mZxLJyW
X-Google-Smtp-Source: AGHT+IFcNPtuzXeyNaWzcBsBS0yPnJacNDAP6RyfSMO6gLFv7R5OR5rMNmfvyQmUVgCL03Ny0eXHwuHfVLL4PqulmvY=
X-Received: by 2002:a81:ed02:0:b0:5f3:dd8d:4646 with SMTP id
 k2-20020a81ed02000000b005f3dd8d4646mr7819257ywm.81.1705531593500; Wed, 17 Jan
 2024 14:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117223922.1445327-1-lokeshgidra@google.com>
In-Reply-To: <20240117223922.1445327-1-lokeshgidra@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jan 2024 14:46:22 -0800
Message-ID: <CAJuCfpHFNBSteck_bWxHwXDzeqC7QLn6hks5PoMC4ytWbJO4tQ@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: fix return error if mmap_changing is
 non-zero in MOVE ioctl
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 2:39=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> To be consistent with other uffd ioctl's returning EAGAIN when
> mmap_changing is detected, we should change UFFDIO_MOVE to do the same.
>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Looks correct. Thanks for catching it!

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  fs/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 959551ff9a95..05c8e8a05427 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2047,7 +2047,7 @@ static int userfaultfd_move(struct userfaultfd_ctx =
*ctx,
>                         ret =3D move_pages(ctx, mm, uffdio_move.dst, uffd=
io_move.src,
>                                          uffdio_move.len, uffdio_move.mod=
e);
>                 else
> -                       ret =3D -EINVAL;
> +                       ret =3D -EAGAIN;
>
>                 mmap_read_unlock(mm);
>                 mmput(mm);
> --
> 2.43.0.429.g432eaa2c6b-goog
>

