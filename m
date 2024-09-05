Return-Path: <linux-fsdevel+bounces-28696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC55F96D1BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574061F2A6A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 08:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DB519538D;
	Thu,  5 Sep 2024 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH69s0KT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF4194C95;
	Thu,  5 Sep 2024 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523966; cv=none; b=lQrO+Y++QcnWljCi3WCG3WSIXm3N84kRBfBVzODe5X1ggWTbY9bv+EtoZ5WlFuVp4/CwWEY3jQQQW3bSLbjEAlUmgcVhlaovlOdQp5M6oBrPau1ZJ/1Uog0ZZUF4OoPbwRdSq0l90yCk8ugp9FMo7qOlaRNzIsm6rJbSEppF/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523966; c=relaxed/simple;
	bh=KWwnXA6C66xO1iuavD/yqOjCE1m+koXYlVenYHTEPH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+hXpO1vL5BxS5d36gGPWuBo/Y9GZH5DsNrNCk6o+y7Qy63aJ2+PQqbg5gDG9H4rUd+eIqDhy7XOENTb8LZMWjHKN1HfCa0kxro27G2wAGjfMKccu0Wu/TPrLl4EmpDzgVvWdHjWdh1rwdLca+1bNsX5/bqm7soQUoEKxme0ATI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DH69s0KT; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c524b4f8b9so403596d6.3;
        Thu, 05 Sep 2024 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725523964; x=1726128764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3SsnMubAx7ks+m7hwax9bgPg/0iqPmvzx2xQPBauzc=;
        b=DH69s0KTHSDf5WLFt9nox9GKlUs5gwiPa6J0Qed8A3qWrrqhB543G//dy/FvlOBBYi
         due6EcUganjteURK970kGL/86kRnyR0cjxujuTscI5RnpxX0SF+fwQlYT3YQ7CEJbuUj
         3WF5t1d7Jks7sfjMvyjA4/wqUZsGsc/yVXe/0vhuzk0qQrs1zGYvp3CO+9L8eDqwY4NY
         9Y8Cp5i2i3uO69uqq/txioIJGXTedtzgRVV4orejdiBSu//R+FbvzHQw4NZ+0Z006XoR
         J5tf4bBG7hmhyEYFbBtMbSz+u8Sg5WpZwOkmPydjwahOjzXP/fXPSUzQfGgtXQ/rS8bl
         6KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523964; x=1726128764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3SsnMubAx7ks+m7hwax9bgPg/0iqPmvzx2xQPBauzc=;
        b=uBB0H8qqfIS2Fpf3Wap5m1RYYEWmrL7SDz2kC25KH9DjlSN67OxhmgL3KIfMQ+B7Ui
         QZFTS6tEgU9kKKSXc9ltCPKi5kMQsl8Vm0IePwJ1mcKUqgPDKWPmsCaF/CAAXKjyBVmf
         eHxv5ZW3LVvSgYGJSmKU1pr0bRe6QLoeY1Ks+WsTTVELrtur98CM+y1WnmPZ/pyoCvZZ
         DdGqHh7ozwxE9eTYSxtNHa2onipP//42vZ1fFH2kzWUgAmCz5NLwdj8pNkE5r9bADrMD
         QW0JLfFPuWKacIxKsTzY8qkG/xF1jqkve9cJ7WbbWIK6IK9t6XZ9IoCqJsMR72q1Aih4
         lJJw==
X-Forwarded-Encrypted: i=1; AJvYcCU1h1QYTxI1ZbjpLO69GM6DOT8kZ7NsxGtIV697M/sqqliIqrXRm8m2cSmcLDofydq8aOGmSA0Zzt/LEhY=@vger.kernel.org, AJvYcCV5dNf0bXPHZ/mprrLP7m0muI/bN0CPa0RNcF76i7g46wfgIEELqLD4asUq0haOyUijNcs195DKmsWo@vger.kernel.org, AJvYcCVR83que6RUWoUt5Ufd6XIMPU1GAt4blAgBw9G0HgwX2sibHFAqpVHqVEzBnZoyeAQEW8oAcTAIEZR3NWBz7A==@vger.kernel.org, AJvYcCWTofo7r6OfZjvYKcb5x6VscO6PRw5ARTKgYtziuNSJeTgl/7iw5TzEMIw5HyGoMcu1YUeD4EaYjsz9Dc7xJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8OY1S5ZPsQDEkIqj+QJXc25kweCOaj4zv6mbk4jRShz+kmzfd
	vMduPchsYYEH7CrE9bc4Gzk95h/D/O/wX++KJBtG1X+VbZyuRkbN/KSQagkXwrAF3/blbIecqPH
	FxNRfHIAlzNE+fRsQii9z91c/fL8=
X-Google-Smtp-Source: AGHT+IGpsh3hRiHMo/jg+9RwgJObWYVo9AdnDu3osuPLsfVQq777uJY75mzVjOr5HllSJP/la4CHxUAkjHezWUa9CIc=
X-Received: by 2002:a05:6214:5f0f:b0:6c3:6a89:37e7 with SMTP id
 6a1803df08f44-6c3c629bfa5mr109908126d6.22.1725523963630; Thu, 05 Sep 2024
 01:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725481503.git.josef@toxicpanda.com> <5ce248ad6e7b551c6d566fd4580795f7a3495352.1725481503.git.josef@toxicpanda.com>
In-Reply-To: <5ce248ad6e7b551c6d566fd4580795f7a3495352.1725481503.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Sep 2024 10:12:32 +0200
Message-ID: <CAOQ4uxjwU5g9hRXTyOY_2-KHSGR8eXv4unGrty4Gtj7JMkJffw@mail.gmail.com>
Subject: Re: [PATCH v5 12/18] fanotify: disable readahead if we have
 pre-content watches
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:29=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> With page faults we can trigger readahead on the file, and then
> subsequent faults can find these pages and insert them into the file
> without emitting an fanotify event.  To avoid this case, disable
> readahead if we have pre-content watches on the file.  This way we are
> guaranteed to get an event for every range we attempt to access on a
> pre-content watched file.
>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>


Thanks,
Amir.

> ---
>  mm/filemap.c   | 12 ++++++++++++
>  mm/readahead.c | 13 +++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ca8c8d889eef..8b1684b62177 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3122,6 +3122,14 @@ static struct file *do_sync_mmap_readahead(struct =
vm_fault *vmf)
>         unsigned long vm_flags =3D vmf->vma->vm_flags;
>         unsigned int mmap_miss;
>
> +       /*
> +        * If we have pre-content watches we need to disable readahead to=
 make
> +        * sure that we don't populate our mapping with 0 filled pages th=
at we
> +        * never emitted an event for.
> +        */
> +       if (fsnotify_file_has_pre_content_watches(file))
> +               return fpin;
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         /* Use the readahead code, even if readahead is disabled */
>         if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <=3D MAX_PAGECACH=
E_ORDER) {
> @@ -3190,6 +3198,10 @@ static struct file *do_async_mmap_readahead(struct=
 vm_fault *vmf,
>         struct file *fpin =3D NULL;
>         unsigned int mmap_miss;
>
> +       /* See comment in do_sync_mmap_readahead. */
> +       if (fsnotify_file_has_pre_content_watches(file))
> +               return fpin;
> +
>         /* If we don't want any read-ahead, don't bother */
>         if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
>                 return fpin;
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 817b2a352d78..bc068d9218e3 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -128,6 +128,7 @@
>  #include <linux/blk-cgroup.h>
>  #include <linux/fadvise.h>
>  #include <linux/sched/mm.h>
> +#include <linux/fsnotify.h>
>
>  #include "internal.h"
>
> @@ -674,6 +675,14 @@ void page_cache_sync_ra(struct readahead_control *ra=
ctl,
>  {
>         bool do_forced_ra =3D ractl->file && (ractl->file->f_mode & FMODE=
_RANDOM);
>
> +       /*
> +        * If we have pre-content watches we need to disable readahead to=
 make
> +        * sure that we don't find 0 filled pages in cache that we never =
emitted
> +        * events for.
> +        */
> +       if (ractl->file && fsnotify_file_has_pre_content_watches(ractl->f=
ile))
> +               return;
> +
>         /*
>          * Even if readahead is disabled, issue this request as readahead
>          * as we'll need it to satisfy the requested range. The forced
> @@ -704,6 +713,10 @@ void page_cache_async_ra(struct readahead_control *r=
actl,
>         if (!ractl->ra->ra_pages)
>                 return;
>
> +       /* See the comment in page_cache_sync_ra. */
> +       if (ractl->file && fsnotify_file_has_pre_content_watches(ractl->f=
ile))
> +               return;
> +
>         /*
>          * Same bit is used for PG_readahead and PG_reclaim.
>          */
> --
> 2.43.0
>

