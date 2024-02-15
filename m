Return-Path: <linux-fsdevel+bounces-11773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90405857071
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 23:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5C8286EB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED853145343;
	Thu, 15 Feb 2024 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="warTRfq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0F13B289
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035595; cv=none; b=gaBLzryew+IZ1m6rQpyLARVzib25RPGRUqg64epw8dFll61J6iVlr0bp326TG5vsAmQ+6rdFZaTuGTU4hYqPjXortUdXCkz5TpmIVCu1zAQ/Y69duzaQnW65U71ORdVxHq7lXwbxQ6DCIBd6W+dzTYkTa8HCqJ0ruYMJuxZZk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035595; c=relaxed/simple;
	bh=aF59DJKg+GxnyqLQw5fUxg2rlzvMMS+kzrvQ8I5o6Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnQ0+bE/9Un5QGNv2U6JkgBWZtF1lQ32FqUMLrSK6S290v08VqSATMcwQ6iKAnm6slhrN5T0TpEeJQdviqXG76eN+hJyqRxQ3WCs5epaXKp0HM0FL0XdHsOaJ4Usddom7U7uBl/NAb2zWOoDaACdqU0cwgQkKbLNpeIV6XphVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=warTRfq4; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607d9c4fa90so10704727b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 14:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708035592; x=1708640392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIA+RVykCQtMd4uKP0jMkGSiYfomHvLOKfcmRsJzzt8=;
        b=warTRfq4aGCOluf9txmlSg2EquhkOqio/rOzNniP3AA3Rk81mKe4z5vV/wPNyH/1LJ
         MKf5BB23aVJFp+1NmkdiNO0/Z6nYJwb26nqNdwCalUzLwDOuJe4bAWkfkv1C3TZb1MwM
         KCjLWJTxWmUnbjCKglDkXMi9OJXsrmcrlAyjHMkcCIsGw3DEys6DxyRI6b5v4AnQGmPW
         DAYNvKO1NwSGJ8CJEZihlc+RtYcYiL4USemv489klwmS6zGuZIWebdZIHXTycDnYtoLA
         kS9ErTodhdBFq4gzbABL4Y/WT6zKG6rUDZniPzw261dIe7q0rU+GEqXPI/EEi/6BnhxJ
         ZlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708035593; x=1708640393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIA+RVykCQtMd4uKP0jMkGSiYfomHvLOKfcmRsJzzt8=;
        b=wOBlD9YhWBOnU7fLMcyTe3VPO1oK/kPvgLDUp0HquYMN8ZDDyp3pz59JZj1YwRvgXP
         mhLQNnk+3MmuLW/o3pF5GmVYtOrhOkIQq/39CNLWIZmXglVOVDYv9DY/IjK0Ye8WZHLG
         iqUe1CpFY+IBUmnU482uehIylGcs5UBZ5V2IYzJSqxvy2ST4+tit/gU3Xt+vpG/TsIZS
         Q/07Wk5QIK0Z+9Foyl8GKsgj1D+CIzEqH5DVLPxTfzXIuEVtGJaA++hk1UYD6Fe9jUdk
         IJe/9SIpD2DGt1ZGS2d3LOoMoZTXCjRjBKUbhniRBOWR9JQfsEhR3O63RlP8wH7ZSD7J
         eIeg==
X-Forwarded-Encrypted: i=1; AJvYcCXo2XWuGBfoUcQrJRH455trHgAvyiXde1pKHPi1t8NKCQPfauwdw0zAtZQr05eAhBnuOHUNXAaF3m5rMUNnWxoJGoWbul3kux1V02/LJw==
X-Gm-Message-State: AOJu0YwgXHlzlTM8zK1hrAHpS75hTlhOy7Pyj/jLD7piVmoScigD0+AX
	P9awnPXMaRCFGdeclK86ix04F40SzktbbMkZUb93XtQdY1PqDhJCPhEHr/9nH6j9fqp+XBjVRH3
	HFwxQXiOw7yNVrlFNe+HuMZvUrUWe0Esxq6au
X-Google-Smtp-Source: AGHT+IH5Y8G4M+psLtl5ozUOu2RjeWfSvT5C53fM4Wva+peYjIwy6mOS42gzLlAZlpmBSbzeIubfKTtWZadUROXeA8I=
X-Received: by 2002:a81:a103:0:b0:607:c8fe:c4c3 with SMTP id
 y3-20020a81a103000000b00607c8fec4c3mr3441262ywg.30.1708035592344; Thu, 15 Feb
 2024 14:19:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215182756.3448972-1-lokeshgidra@google.com> <20240215182756.3448972-4-lokeshgidra@google.com>
In-Reply-To: <20240215182756.3448972-4-lokeshgidra@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 14:19:41 -0800
Message-ID: <CAJuCfpFe2spt082fdB99ow+pqGj+DKnep6cHxoVYRVYgyO9uhg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] mm: add vma_assert_locked() for !CONFIG_PER_VMA_LOCK
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:28=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> vma_assert_locked() is needed to replace mmap_assert_locked() once we
> start using per-vma locks in userfaultfd operations.
>
> In !CONFIG_PER_VMA_LOCK case when mm is locked, it implies that the
> given VMA is locked.

Yes, makes sense. With per-vma locks used in more places, this makes
replacing mmap_assert_locked() with vma_assert_locked() very
straight-forward.

>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mm.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3c85634b186c..5ece3ad34ef8 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -781,6 +781,11 @@ static inline struct vm_area_struct *lock_vma_under_=
rcu(struct mm_struct *mm,
>         return NULL;
>  }
>
> +static inline void vma_assert_locked(struct vm_area_struct *vma)
> +{
> +       mmap_assert_locked(vma->vm_mm);
> +}
> +
>  static inline void release_fault_lock(struct vm_fault *vmf)
>  {
>         mmap_read_unlock(vmf->vma->vm_mm);
> --
> 2.43.0.687.g38aa6559b0-goog
>

