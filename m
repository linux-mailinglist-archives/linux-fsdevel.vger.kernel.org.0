Return-Path: <linux-fsdevel+bounces-50549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1610DACD192
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 02:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36223189AAE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C621DE89A;
	Wed,  4 Jun 2025 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfSIAwF+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ADC18A6DF
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 00:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998371; cv=none; b=AMKv1vJUBpZgucESkHc2MKM3PI1+QBMOalppCRmyv9EcCGflDSluSe+svsG75WnLn+VGHx8JuZDsT9wiR35SE3avRncvTDN8RN8tLIHb8k/Y4vVcyLt+xfCRhXOLdMGqd6Rebtx1kziYsGrwrWSnKxpMETme0HjuHtxo7e6AmNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998371; c=relaxed/simple;
	bh=F0st5f8BGZF7VgFHpGDlSW0JMjLRX3xuISS/+/7ND4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCrvV8NXycpVpnit4mWqCaJxpsgSKWCMrVyLmlD8bSCQgQn8Q4ji398ACqcgCDujhxdf3N1WbdJqhCVtn8Z2eeL/K2IxMZgJoB/ndPKhs9JsnKN3Waxq/F/Pb98KOQuKeA+Xt6KOGPtngHx3mYK8ZOoO2iD1JN0EBiBsB4sjaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=fail smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfSIAwF+; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e75668006b9so5834383276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 17:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748998369; x=1749603169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufdJ7zCVJhXmyO6Hnb5W+3LfKFzQXrWMg7EkU2xzrdU=;
        b=wfSIAwF+BMvXYtfsp8hZtKfKHkLux3CS0REoV8+HS+nHVCnREWqPL8KJytnOgsk86D
         daupgunig/dGF0v7ZSI2uhxC9q2S8XDAM1BpqNLVUf3k9Dvr0LDwF6wJGgjtqkYNr3qj
         JN7eVTQtFprz9kLbdSKPsVJLGKGyIu7O4HkbplNLMdQfJ+Q3GNf4Im7QyMl4Rxsj5M/g
         P8ODgEFRMLuEvlfAdgMhkwyM9JXWSCqT1ieXqKG6UVLklyXG3F8D7qASba4cV36vPQUG
         fR3pzL1YEaTyZ5O4C9Q0qUM7MB/4PAYn29ZG0/5ZJl6RoLEJJ/W3lVnFXNcL+DvHAYu7
         A7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748998369; x=1749603169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufdJ7zCVJhXmyO6Hnb5W+3LfKFzQXrWMg7EkU2xzrdU=;
        b=mPyYhHvVd/gMBZFQox1aR1w/KxBd/qh2G3GMFrtV7Q5Za2bXPM1tQ61Ej16okI8kx6
         omn3oHEze04UUtQZ+uA20Uw36/nFTrinSOQ7DyhV7+6qCguxEiE4bN8/RfkpFvaS8cxa
         F4xGEA7k5AEkUwvbVztLEFYZlDTFwFAzXTuRJlkNo1uPUDvpQax4I5tspssVOijgMz7b
         n0JuBVmp6TrDVm4gDAhAP3LE94XM0woopcfL63ZmVdlHQ2oW4vCF2bS8qEOiY3s18hCQ
         fh8j3FAI+dLKE5DyRocufmTSiyR0Y46T9ajdedt4NyjPbVua5gxXmUtzlD8Jo8Vb8r2Q
         Vh6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+prSqPkqKvxUUU2o7xe2o9kIbfvGG1LpWLRJWSX4Mybt+hd0DVda9Jf2IEWqdoECIpwONr9CP1gIVv7FU@vger.kernel.org
X-Gm-Message-State: AOJu0YwYcpgfkkRc88GB8W5jDpMPqE4A8Zz9X/D/5XFnx/OTfFFo3V6F
	DJlUQpkNRSkUOAqSslSFpmSu0qAcwMGtCA95/fPOTNjJFo01kkhYRn+5wQZ2h9qJOlFs11ONhbh
	MFOacMYdf6ZjgeunsyMAIAfYTrZG/nd3g2QY8OjMs
X-Gm-Gg: ASbGncsiskuPSRl++MTGYJ0d/ogr/AyargKrWsJUuBlbo7bjo1NIJkYw707cmtFy+6M
	hHpzz3MjSj1mWzhQ4YOiLg7S8P3U/6MhIFcgFVL0r0W6d6+K52jk+Tge8R2D7JHNzPVb89oXSHC
	29RohV7O1+ZIB/Y1pf/72DbBYSaVZXT10NFdKtoBm/vl8xz+4ohvKLJ77s4rqbXnFEnqII3AFnK
	A==
X-Google-Smtp-Source: AGHT+IEnDQtfQo5x5DIJYs2UH2zoxENxePjxDZ00t7iisvDN9qp9tZqmkNYduYRzTjcj7MnmSchmbiJHQmlMkZYa+Go=
X-Received: by 2002:a05:6902:18d0:b0:e7d:c87a:6249 with SMTP id
 3f1490d57ef6-e8179dbababmr1390646276.36.1748998368683; Tue, 03 Jun 2025
 17:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu> <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu>
In-Reply-To: <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu>
From: James Houghton <jthoughton@google.com>
Date: Tue, 3 Jun 2025 17:52:12 -0700
X-Gm-Features: AX0GCFvhX97qdJoaP_U5MjbCXqe-defL5vJZdiAvYUJ8X717AX3GBN57TvbH-7A
Message-ID: <CADrL8HWM9zmJY=paJjWYPZkw5gYXHMH7MmEMhzHoMpcETEJiUg@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, David Hildenbrand <david@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Pavel Emelyanov <xemul@parallels.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:15=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> wr=
ote:
>
> Currently, a VMA registered with a uffd can be unregistered through a
> different uffd asssociated with the same mm_struct.
>
> Change this behavior to be stricter by requiring VMAs to be unregistered
> through the same uffd they were registered with.
>
> While at it, correct the comment for the no userfaultfd case. This seems
> to be a copy-paste artifact from the analagous userfaultfd_register()
> check.
>
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory exte=
rnalization")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Thanks, Tal! I like this patch, but I can't really meaningfully
comment on if it's worth it to change the UAPI.

> ---
>  fs/userfaultfd.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 22f4bf956ba1..9289e30b24c4 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1477,6 +1477,16 @@ static int userfaultfd_unregister(struct userfault=
fd_ctx *ctx,
>                 if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
>                         goto out_unlock;
>
> +               /*
> +                * Check that this vma isn't already owned by a different
> +                * userfaultfd. This provides for more strict behavior by
> +                * preventing a VMA registered with a userfaultfd from be=
ing
> +                * unregistered through a different userfaultfd.
> +                */
> +               if (cur->vm_userfaultfd_ctx.ctx &&
> +                   cur->vm_userfaultfd_ctx.ctx !=3D ctx)
> +                       goto out_unlock;
> +

Very minor nitpick: I think this check should go above the
!vma_can_userfault() check above, as `wp_async` was derived from
`ctx`, not `cur->vm_userfaultfd_ctx.ctx`.

>                 found =3D true;
>         } for_each_vma_range(vmi, cur, end);

I don't really like this for_each_vma_range() for loop, but I guess it
is meaningful to the user: invalid unregistration attempts will fail
quickly instead of potentially making some progress. So unfortunately,
without a good reason, I suppose we can't get rid of it. :(

>         BUG_ON(!found);
> @@ -1491,10 +1501,11 @@ static int userfaultfd_unregister(struct userfaul=
tfd_ctx *ctx,
>                 cond_resched();
>
>                 BUG_ON(!vma_can_userfault(vma, vma->vm_flags, wp_async));
> +               BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
> +                      vma->vm_userfaultfd_ctx.ctx !=3D ctx);

IMO, this new BUG_ON should either be
(1) moved and should not be a BUG_ON. See the WARN_ON_ONCE() below,
OR
(2) removed.

Perhaps the older BUG_ON() should be removed/changed too.

>
>                 /*
> -                * Nothing to do: this vma is already registered into thi=
s
> -                * userfaultfd and with the right tracking mode too.
> +                * Nothing to do: this vma is not registered with userfau=
ltfd.
>                  */
>                 if (!vma->vm_userfaultfd_ctx.ctx)
>                         goto skip;

if (WARN_ON_ONCE(vmx->vm_userfaultfd_ctx.ctx !=3D ctx)) {
    ret =3D -EINVAL;
    break;
}

where the WARN_ON_ONCE() indicates that the VMA should have been
filtered out earlier. The WARN_ON_ONCE() isn't even really necessary.


>
> --
> 2.39.5
>
>

