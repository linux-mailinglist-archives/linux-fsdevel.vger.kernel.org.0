Return-Path: <linux-fsdevel+bounces-28698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 595ED96D1C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC707B251FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 08:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF91E194C6E;
	Thu,  5 Sep 2024 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQC5wxj+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F9193079;
	Thu,  5 Sep 2024 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524057; cv=none; b=pPDJGmlWwJsRx2Tb/1BvCH5rnOULT9KW+CrJM1xUn+pkaMsWck9U4bbeggYSmovzdXoXwQ3cgsjRuRYb6Pdx3byNwhRngx7gvdCaFE3zEB8SVsArPNsksukWc19bqPrtFU6FflCRxzgNm2bg/swfyeAWiuVVApLu/HHoAV+phyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524057; c=relaxed/simple;
	bh=0Vw11TeXJsR1xXlzKl9emuyRB2EMghGKDWUx1W7c1cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEA+YQVp/yErRpHYcZD05mZfctbT9ZS3PdBLjs8DpJDBu+kIFO3fGZjwLVt+9FFt25Vu2EeVGWWOhrj9mlLqIfEf8T3TWro9k1byPQv+QUM6Nl3NlLKJPS1WNUzl0LIIQeHyHJ4fiL9DiVkoO48Hjgv7Kj4Z/Zj8UbtCqVGFaBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQC5wxj+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a80511d124so31050385a.1;
        Thu, 05 Sep 2024 01:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725524054; x=1726128854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyBCK9InRyMt0WInCHwzobA7WWqSCgMtXck53xCZvD4=;
        b=OQC5wxj+rRDpgOvzvYeRmfsz0Afzz+uG30toJmHRSW/vWUNSsBoTg1lagmn9hRC2yw
         eof1txJ2oeqerhW8AYw/FPiRJ5XY+cO6ns8YAf3JEU1cFQw9OTbXDoqLiDPqWj1RGyTq
         8CJAtyw1XkbfKy14aP7RgFWjvU3DnJl2WANr6VawLO0xGT4OX0mJO+gacui1GJM2MCWv
         NNsC9kGce4qSCwqf1ExmqUnuqVpoyiCAwJGu4+KLEyQlTjSjkiJAzaD39VKXAsj19WeC
         bWAYy0/x3aeF3NCTiVxoNslwZRvx5bqxeZ5eLO2iBoeh4C+3wHuKy2IO0W29PgEa3JR6
         nU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524054; x=1726128854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyBCK9InRyMt0WInCHwzobA7WWqSCgMtXck53xCZvD4=;
        b=KBb8jcAhUCQ+KlqUBmZ/cRIcBnKOzTMqODeaUUgiiPZQCYYs2HPBpYZnLADf+ub0e0
         S5UQiB6c04+ukt6oBo4cmPYfQdokrcaAYZAu+1k7QMhK9s7rjq3j7o4y+vtsMFvVWzJv
         alUm7r48f6/C+SUDdoHic3fGN9symr9s5ul8qU/DNsWqyB9lTjT3ImGKmepnsj1R6PIA
         Yjf6qa3V+D1gT46ZzewPoiOj503yCHbLWDxu6Gu8M8kAvYrPmS35uuNuLmNJ/Ge3hVHI
         sJhJXwkMg/YquEKY1HjfyHtdUtp+Ei5Oy1sks/ZtvYNzi7eWNbk3n1dlAXoSBKiw2ftP
         SgDg==
X-Forwarded-Encrypted: i=1; AJvYcCUKzSkurYibhiULEMkPvb5SnEEQqdwB3GrYQG9DAp3tojRFR/wMb4W1JkMaSgLMMSrvI9qdElzDRPqyWUY=@vger.kernel.org, AJvYcCVE9FFiJeCuamgjHReFMcyUaqf6T4/rlIwfkq5XmJ780QGlXHxyPbwl68wPRdN9oPpNxZW8isJ5chovqUn8vw==@vger.kernel.org, AJvYcCX+5Mgx7X380yVRPxFG7WhDa03PTb24yOJHtrWwWABRn4ZQoI8xM2Q47Knq0QpjdA8/QaCdOUr88kDz@vger.kernel.org, AJvYcCXe9BNjfbeAC0MjEZurjZ+HOrB6ssGVptA/yfKFk2/XdAFnxPRyhhlYZAQrn93TYd0DwQksdT3AQN+Pj3uOsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYT55TPDRoqCQeOtCBBgHTIvqb67lgRWoQ0lNjieAvQ3HsfnIB
	iVVkeAoZ4bgz9zpuJ0vyXeXapDkXkOUFxs48PNor6DEM4O14tH14T3bUgcCHxSvclD0K4mDfiUK
	5++oUdmtkraHd759w2FPhEe3zUXZZWBVH2dQFcg==
X-Google-Smtp-Source: AGHT+IHioFe00Pp0XmEgOtQZaGDRJoBV57MAuA+hhUGAaxnDLKex7wtypkjrpGpwlYIqGtL5aAZry+TjLKdJIPcbpZ8=
X-Received: by 2002:a05:620a:190d:b0:79f:78a:f7b4 with SMTP id
 af79cd13be357-7a902e90175mr1780961985a.42.1725524054468; Thu, 05 Sep 2024
 01:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725481503.git.josef@toxicpanda.com> <80e7221d9679032c2d5affc317957114e5d77657.1725481503.git.josef@toxicpanda.com>
In-Reply-To: <80e7221d9679032c2d5affc317957114e5d77657.1725481503.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Sep 2024 10:14:03 +0200
Message-ID: <CAOQ4uxiOvuVFp7ivBoXC-GygDcQ_m3-un1x_jgg1gWNqzddgVg@mail.gmail.com>
Subject: Re: [PATCH v5 13/18] mm: don't allow huge faults for files with pre
 content watches
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:29=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> There's nothing stopping us from supporting this, we could simply pass
> the order into the helper and emit the proper length.  However currently
> there's no tests to validate this works properly, so disable it until
> there's a desire to support this along with the appropriate tests.
>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  mm/memory.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index d10e616d7389..3010bcc5e4f9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -78,6 +78,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/sysctl.h>
> +#include <linux/fsnotify.h>
>
>  #include <trace/events/kmem.h>
>
> @@ -5252,8 +5253,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vm=
f)
>  static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
> +       struct file *file =3D vma->vm_file;
>         if (vma_is_anonymous(vma))
>                 return do_huge_pmd_anonymous_page(vmf);
> +       /*
> +        * Currently we just emit PAGE_SIZE for our fault events, so don'=
t allow
> +        * a huge fault if we have a pre content watch on this file.  Thi=
s would
> +        * be trivial to support, but there would need to be tests to ens=
ure
> +        * this works properly and those don't exist currently.
> +        */
> +       if (file && fsnotify_file_has_pre_content_watches(file))
> +               return VM_FAULT_FALLBACK;
>         if (vma->vm_ops->huge_fault)
>                 return vma->vm_ops->huge_fault(vmf, PMD_ORDER);
>         return VM_FAULT_FALLBACK;
> @@ -5263,6 +5273,7 @@ static inline vm_fault_t create_huge_pmd(struct vm_=
fault *vmf)
>  static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
> +       struct file *file =3D vma->vm_file;
>         const bool unshare =3D vmf->flags & FAULT_FLAG_UNSHARE;
>         vm_fault_t ret;
>
> @@ -5277,6 +5288,9 @@ static inline vm_fault_t wp_huge_pmd(struct vm_faul=
t *vmf)
>         }
>
>         if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
> +               /* See comment in create_huge_pmd. */
> +               if (file && fsnotify_file_has_pre_content_watches(file))
> +                       goto split;
>                 if (vma->vm_ops->huge_fault) {
>                         ret =3D vma->vm_ops->huge_fault(vmf, PMD_ORDER);
>                         if (!(ret & VM_FAULT_FALLBACK))
> @@ -5296,9 +5310,13 @@ static vm_fault_t create_huge_pud(struct vm_fault =
*vmf)
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&                    \
>         defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
>         struct vm_area_struct *vma =3D vmf->vma;
> +       struct file *file =3D vma->vm_file;
>         /* No support for anonymous transparent PUD pages yet */
>         if (vma_is_anonymous(vma))
>                 return VM_FAULT_FALLBACK;
> +       /* See comment in create_huge_pmd. */
> +       if (file && fsnotify_file_has_pre_content_watches(file))
> +               return VM_FAULT_FALLBACK;
>         if (vma->vm_ops->huge_fault)
>                 return vma->vm_ops->huge_fault(vmf, PUD_ORDER);
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> @@ -5310,12 +5328,16 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vm=
f, pud_t orig_pud)
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&                    \
>         defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
>         struct vm_area_struct *vma =3D vmf->vma;
> +       struct file *file =3D vma->vm_file;
>         vm_fault_t ret;
>
>         /* No support for anonymous transparent PUD pages yet */
>         if (vma_is_anonymous(vma))
>                 goto split;
>         if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
> +               /* See comment in create_huge_pmd. */
> +               if (file && fsnotify_file_has_pre_content_watches(file))
> +                       goto split;
>                 if (vma->vm_ops->huge_fault) {
>                         ret =3D vma->vm_ops->huge_fault(vmf, PUD_ORDER);
>                         if (!(ret & VM_FAULT_FALLBACK))
> --
> 2.43.0
>

