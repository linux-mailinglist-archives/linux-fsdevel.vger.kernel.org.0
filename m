Return-Path: <linux-fsdevel+bounces-50782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC77ACF8FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 22:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709473AE14D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 20:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E538927EC97;
	Thu,  5 Jun 2025 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="OmVD0gad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF381223DF1
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749156981; cv=none; b=sRqGllBgoM8buPr9r9YldEFufmpFBnqbFMdSuXyGWWZZqTiydZ+p4FqtwSfEL7NHGi5zzMKnl8cLsHcahBkvaGWa28edRrxXXhOPQgiF+77VLlvz+FBwClW0w0x5DpizZtzyvtk5CJMpm7JoSvEfL8PmvIQG2qYjHw3ugYGtKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749156981; c=relaxed/simple;
	bh=DSobZZnWgM17JBG0B1yyZn7k6c2byf3fBmEAKAS/DRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DT271Or7ZYrd+hCzX26chLMFbaeAdf4AdvIjlVHM3EW71s+X0UwBTb7DhqUoikuRYFP0HbNwlpYpjQYEetTEwSusV/k/+xomBe+kugoXbcr6K5YOm+/VqDtB0Rb3/WpM1/GSl+9KX+bcbQIOdEtr6Og2SSpj/6x7g9o6S0qV51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=OmVD0gad; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555KjItg020555
	for <linux-fsdevel@vger.kernel.org>; Thu, 5 Jun 2025 16:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=xm4+j5Ivo2wgP6zUM7+5vhC6Rb1oLpKBdxSCgVg/kKE=;
 b=OmVD0gadQQRw+VbVLnP6EB6eeYJlPT7XFCU5P1NJAsou1AWNcJWefDOQqQ9j+/j7VLGx
 UIheI0KY0kCbU4GwaXXJVpSiyl2g0qpOVMc7gFiW36l/GMj0AlegPdhqkTu2l1qNvZzQ
 JWbSOs4yo1wfr/IV09hJjdxuW8DSJc8cyhE25kCsemiEGpcFwCdVxu+0HXKBvpc/7pK7
 xiO2XqZF5WZ2hwhEaJYxnZqu/ay3xYFNwVZnZAenlL6tMrV4CVe7zRundMdWoXFMCGfO
 gJZqpRi1huHObQfRqARRQYhknGFvjFq+Od4I6Axey9rYfTU1ciwN//B1NnCskO7AtZop +A== 
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 471ethcu7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 16:56:12 -0400
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70e4269de4fso22306357b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 13:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749156971; x=1749761771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm4+j5Ivo2wgP6zUM7+5vhC6Rb1oLpKBdxSCgVg/kKE=;
        b=uVPSizzwRaPpP4kOazF/jsRiWUKPoXV7KQ0yumsG9oPNLqLipbKcf6kUXIGMYMPtBl
         5yY8R7IIfbepn2XTpwnPOfGDO84ANJ6tfYLJZu0gDt6W/0tDtduMbllfFp4VcZTib9LC
         v/V8ut7rMjKzJoC6QRcsPmM06o1LYnkjGrVo1yDBQ83SuJqUmgbgDIgKmb+1iQd2yhIz
         /NmAv+P3l1OFIcZD3SSPexCPQjQ02E7fFiJY5/+02fZpnqjydFoTkiInuVXq2mDj7GT4
         1lYhByKqoitkLJhPg4jMXOdUdhOGwvyocplYvHiTrVw+ha751C/TTBRlYYhhb85XZ5Xv
         bU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUBbjMkJUMdvU4Z+6reeYiyOBkfzeeetgMCHMmqLwjj2RcIxlsGcPTFLG62RKUfRTiUXoHr83CRKvTprtd@vger.kernel.org
X-Gm-Message-State: AOJu0YwKM9P7TcGGJsMbqUli9bDRIAuzmiHoOpcKh1j7zHNolue6zEi5
	52j5pIvyTWAZWvCN6q60Agb5dS1zewSprrKwsWS2YV25EyYB9gniqsUdjGSLfU4EHQ9SlTmMRec
	McgY0SXIEsLYzbbB425X7/CQ0seKMWgLBG+2WVoTIu6pNdyIQq1uMvTTM9inYbednEO8EGgyD74
	kxyZXbVV5Us8xgvS3U4B5Rg0xjUJoCbaDWxOPBpQ==
X-Gm-Gg: ASbGncsMXue29bZbnjMUvMPaepd9lqPOjkMJFXNwK6VF2AYZZXHnwZM0QMJ4i4o+0Ep
	e2388YzvCsKdb+lZjd2n7YnsAyaAsRWCzSA3z02DrywmaBxkVAWnQtNWZzH4AHvHEXccXKQ==
X-Received: by 2002:a05:690c:6711:b0:710:ee42:5c37 with SMTP id 00721157ae682-710f76a075amr14815037b3.17.1749156971108;
        Thu, 05 Jun 2025 13:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeRm2n9CQ9cmSHniujfrPxJWEMnLDbBKF4rJQ6yoAy8eJprBTSY131Rr0KabDbauqak23pCjd3D9jhbArEmGk=
X-Received: by 2002:a05:690c:6711:b0:710:ee42:5c37 with SMTP id
 00721157ae682-710f76a075amr14814857b3.17.1749156970703; Thu, 05 Jun 2025
 13:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu> <CADrL8HWM9zmJY=paJjWYPZkw5gYXHMH7MmEMhzHoMpcETEJiUg@mail.gmail.com>
In-Reply-To: <CADrL8HWM9zmJY=paJjWYPZkw5gYXHMH7MmEMhzHoMpcETEJiUg@mail.gmail.com>
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 5 Jun 2025 16:56:00 -0400
X-Gm-Features: AX0GCFt9W11qCzc-mT2qybe1SfA1xJ_Jio9aAw4Ju_-YhONUSDy6b-R_EmrG9-I
Message-ID: <CAKha_sr1srsvnYTYYQgbPXK4CGmMGfiN9vVPWvGgN+vifFnt9g@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Pavel Emelyanov <xemul@parallels.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Tg35y2dd6GczZSjgW_vLJ5IeDK0MUk9h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE4OSBTYWx0ZWRfX63h+QiZ44T8w RSpVoM2PRm8E/K2y+YKlrdulOCAdsL686gnspwLmSVN/SLMguCIywfO/lbxRNPAvpevC/4xwouB BcbmgHJd0Z+oap73ulSi8YWiKQaUlO5gHGjSt//lY1fgTjinbd9+9DTyNzX1eV4BeqeGFH0uA86
 ufjfOcrUt0snbpWUjYMIiyby8Vs2nwIQiwiFcC9HX7YhxCN+kHONmsS27ssRBHmxUMg9qK73zVU Ao67RgvTL713OgAPZ6uJU8ojExCNkVBqRem56D8ZPnXwpemXNKN3xVBe2xpfcaXqc1QUyzLZF/d RkNKOmxrFjrRmK/KVyXbqWRzOOBOB7G89rF7ogL3wTAnFAfaDHZ7fgzL2yS4ndYoOJZ3fRbmtrv ZpnZQykK
X-Proofpoint-ORIG-GUID: Tg35y2dd6GczZSjgW_vLJ5IeDK0MUk9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=10 phishscore=0
 bulkscore=10 adultscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 mlxlogscore=773 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506050189

On Tue, Jun 3, 2025 at 8:52=E2=80=AFPM James Houghton <jthoughton@google.co=
m> wrote:
>
> On Tue, Jun 3, 2025 at 3:15=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> =
wrote:
> >
> > Currently, a VMA registered with a uffd can be unregistered through a
> > different uffd asssociated with the same mm_struct.
> >
> > Change this behavior to be stricter by requiring VMAs to be unregistere=
d
> > through the same uffd they were registered with.
> >
> > While at it, correct the comment for the no userfaultfd case. This seem=
s
> > to be a copy-paste artifact from the analagous userfaultfd_register()
> > check.
> >
> > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory ex=
ternalization")
> > Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>
> Thanks, Tal! I like this patch, but I can't really meaningfully
> comment on if it's worth it to change the UAPI.
>
> > ---
> >  fs/userfaultfd.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 22f4bf956ba1..9289e30b24c4 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1477,6 +1477,16 @@ static int userfaultfd_unregister(struct userfau=
ltfd_ctx *ctx,
> >                 if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
> >                         goto out_unlock;
> >
> > +               /*
> > +                * Check that this vma isn't already owned by a differe=
nt
> > +                * userfaultfd. This provides for more strict behavior =
by
> > +                * preventing a VMA registered with a userfaultfd from =
being
> > +                * unregistered through a different userfaultfd.
> > +                */
> > +               if (cur->vm_userfaultfd_ctx.ctx &&
> > +                   cur->vm_userfaultfd_ctx.ctx !=3D ctx)
> > +                       goto out_unlock;
> > +
>
> Very minor nitpick: I think this check should go above the
> !vma_can_userfault() check above, as `wp_async` was derived from
> `ctx`, not `cur->vm_userfaultfd_ctx.ctx`.

Thanks, this is a good point! I'll change it for v2.

This also seems to indicate that the current behavior is broken and may rej=
ect
unregistering some VMAs incorrectly. For example, a file-backed VMA registe=
red
with `wp_async` and UFFD_WP cannot be unregistered through a VMA that does =
not
have `wp_async` set.

> >                 found =3D true;
> >         } for_each_vma_range(vmi, cur, end);
>
> I don't really like this for_each_vma_range() for loop, but I guess it
> is meaningful to the user: invalid unregistration attempts will fail
> quickly instead of potentially making some progress. So unfortunately,
> without a good reason, I suppose we can't get rid of it. :(
>
> >         BUG_ON(!found);
> > @@ -1491,10 +1501,11 @@ static int userfaultfd_unregister(struct userfa=
ultfd_ctx *ctx,
> >                 cond_resched();
> >
> >                 BUG_ON(!vma_can_userfault(vma, vma->vm_flags, wp_async)=
);
> > +               BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
> > +                      vma->vm_userfaultfd_ctx.ctx !=3D ctx);
>
> IMO, this new BUG_ON should either be
> (1) moved and should not be a BUG_ON. See the WARN_ON_ONCE() below,
> OR
> (2) removed.
>
> Perhaps the older BUG_ON() should be removed/changed too.

I added this mainly to maintain symmetry with the userfaulfd_register()
implementation. I'm happy to leave it out, so  I'll either convert it, and
the other one, to a VM_WARN_ON_ONCE(), as per David, or remove it.

> >
> >                 /*
> > -                * Nothing to do: this vma is already registered into t=
his
> > -                * userfaultfd and with the right tracking mode too.
> > +                * Nothing to do: this vma is not registered with userf=
aultfd.
> >                  */
> >                 if (!vma->vm_userfaultfd_ctx.ctx)
> >                         goto skip;
>
> if (WARN_ON_ONCE(vmx->vm_userfaultfd_ctx.ctx !=3D ctx)) {
>     ret =3D -EINVAL;
>     break;
> }
>
> where the WARN_ON_ONCE() indicates that the VMA should have been
> filtered out earlier. The WARN_ON_ONCE() isn't even really necessary.
>
>
> >
> > --
> > 2.39.5
> >
> >

