Return-Path: <linux-fsdevel+bounces-50785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CFDACF924
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 23:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F9189BCB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 21:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766C427AC48;
	Thu,  5 Jun 2025 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="u7Zb2tJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325C520330
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157929; cv=none; b=VP0v0SKl8lZiEsZamCkSPy3hywT01ypT/933e2GfRfWEKGZB7o/hx1/8mrH/fnP5C37ceODJYiHzUylPKsdy047WeiooUXcIkLzgwZQnVZaheDJ5kWocv6mt4Syq7k9ZYmDFqB9OGMXQyWaYhYWsOENiCAF5VRbeG8ey7QXjhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157929; c=relaxed/simple;
	bh=gTZMr9FFvh7ZnKKmJNpD5keOOw5IKZJT22AQLOzvWk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtuiI03/uCBmhwHfyrAPHausi0FdLAP9e6nQ1WGatkr0zhytgrYIdFZcBstqthVzgnmCT+p6RzlmHTWDbckCs/V0Hv52A3Yf+X8kQ7XZNXU4c7EakSS6d8IyqJX1tAy4s2X6QRH6mMtsVVf2tgw+ItOf7gk7FR8woEF/4DyNKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=u7Zb2tJH; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555L4jAL015887
	for <linux-fsdevel@vger.kernel.org>; Thu, 5 Jun 2025 17:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=Kush5qwyq9/DqRN+b1m8jN+XUrL2KXoC8QLXMDNE4wU=;
 b=u7Zb2tJHdwTWrw7lpbKds/xt7Ei0B3C3pjxluA4tCdj2klqhfEqXfphJPtOmNpniGDSm
 yTWk8eExyo6xnS7CVppsVtSoWfZvuWKcDFVGWHxaG94vdKKXG4NeIMUMLWmx9R0xKsmW
 /3qeeHtzVauQFcuwVw/viETMVeKcs2pRm7StYauVtOXjbd4bCp4yP4d1CZw3gjDqjZal
 GUTHKxZEWITolJ5ss57kuU+RLHCNgR4NIVnZFCRLVwsITLD4wnlGbThmoiL32j2ZWt5X
 YlriJmFTuowwMIqvq2/j8iAJ5GA6SRXCGMCMqzjR3rBP5oT1dvxTSlEakXZtlJZmBgn0 gA== 
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 473emdasg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 17:12:06 -0400
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e707377b3bbso2003871276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 14:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749157925; x=1749762725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kush5qwyq9/DqRN+b1m8jN+XUrL2KXoC8QLXMDNE4wU=;
        b=g3t3Ez7TfRKoE089zEHepfVzo8BSlSUENFe0M+8aTvjk+tb2i0C7hOczJesN6Th1DN
         N2w/jydKJKKpgekkqHV6I77T7teCsi89z2OMmJBnvHoZzU50vEmo0mjigh+1HWzkMG7N
         VPJc4pH+L855POY0sZG/3MCXSvaDnOqEh2LU1gqI9R+S1PD5XXSxiTjQ1M/Kkq/gOVbf
         LVzd8TT4P0YEVTD2wUYKc6FrZS74KPO+PaDyk5FKYdC8HOlAXjwRvjKp7FPSoUwHXs6P
         gioCVGcPJJ+wPK1b/GdiiSXCi8ltc8pBBFiFPsIVDQYaQJx+vxoGDSaLh/qjVqrFy6ha
         gXmw==
X-Forwarded-Encrypted: i=1; AJvYcCXQYWvdchYIWtO2yTTVM71Qf25eAfXQyPIJy71m1WjmvOuVcKWzXRWORCiJyRCpZnlphumdE1A8n5elHAiC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2U2WGD66vYwsyoHl9PbW9nFilu2pUpUU3gTiD72HrT6jlC/Bm
	M9yBPP1YPUfhIywR1Wm7aSlDBhqr3E2ZzSHvUgvv9RZ9saXgeex6lPx0Ny+gocOs4ucNfyTL+Lu
	iRR3LSLLQR58Gos4NT/hEZ0jX/B573WQwgB0lcmGmeVCXh0ytWw5BHo59CNEmL/nUSlU2QCZStA
	5KdGzUL5n5eNEURa6yLx3nMKuRfKrt+vz3nakt5FMjn8nXpfnP
X-Gm-Gg: ASbGncuvFl3iVCIejccjE78aYI+1EHf48vBIt65qwJS/gqIzynaP7Qe89CMKGacIZDs
	oX2adH52uFWzDvfGbJqkI5bztHDg3pkjdFZP7ULj7w4a+HdAd2fk8xdy7Xvr0MV+iSdPKfg==
X-Received: by 2002:a05:6902:1889:b0:e7f:6edc:9a3f with SMTP id 3f1490d57ef6-e81a2546617mr1663382276.38.1749157924968;
        Thu, 05 Jun 2025 14:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG8hbIKU02qfpnzheLHwAIRLhIadezcTaFiXw/C6Jl6lhZS+eyurv6XraXAjePAIr+pl3aGIG62PRNxJdNgig=
X-Received: by 2002:a05:6902:1889:b0:e7f:6edc:9a3f with SMTP id
 3f1490d57ef6-e81a2546617mr1663348276.38.1749157924576; Thu, 05 Jun 2025
 14:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu> <84cf5418-42e9-4ec5-bd87-17ba91995c47@redhat.com>
 <aEBhqz1UgpP8d9hG@x1.local>
In-Reply-To: <aEBhqz1UgpP8d9hG@x1.local>
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 5 Jun 2025 17:11:53 -0400
X-Gm-Features: AX0GCFtlF25ewvTNublXIrjrXRtQHMeIQW9tEnZzcZQU9P8wEJHvMPcfMh1lDXs
Message-ID: <CAKha_sqFV_0TsM1NgwtYYY0=ouDjkO7OOZc2WsR0X5hK5AUOJA@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE5MSBTYWx0ZWRfX55lC5rFiSlS2 CqgjEuSDke86uhlkXyYKs7eDc7ofh/3Fp9SajSTcI3c0Igp0u0NplrKF/Fpvqi2r3SmZsLSaROl BfevqG6A/PczjRt3TTOL3k7E8lJrzPQ7ASxrafkOGaUnfo1Of1Qg7EX83OQb6ZP4Ly3rxwwcP6R
 XrGpW4AZtm3n/HGQAZaJBAIh1aczWdNo01/rG2slYdIUwqhFKzyEKeGUrgV57jI4dV/nc6WQ84f g2bP7wQpSLiu1yIMpn7aehdD7kutUVxI5DJBJ68zpdHfxDrFNlkHVM3HYnWFCHa2uuGcwBpyTZJ xRESBqBq0n5DMnMzy8LwfEBapvlZXhhPpPW6zw9+YPFiPxUIoC3WcSV2OzOCgSHoBGCxcgo/38t Itn6yXld
X-Proofpoint-ORIG-GUID: Cu3tLQZYrx--RrYgtYL4R7KQXevPnJm0
X-Proofpoint-GUID: Cu3tLQZYrx--RrYgtYL4R7KQXevPnJm0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=10 mlxlogscore=999 lowpriorityscore=10
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506050191

On Wed, Jun 4, 2025 at 11:10=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jun 04, 2025 at 03:23:38PM +0200, David Hildenbrand wrote:
> > On 04.06.25 00:14, Tal Zussman wrote:
> > > Currently, a VMA registered with a uffd can be unregistered through a
> > > different uffd asssociated with the same mm_struct.
> > >
> > > Change this behavior to be stricter by requiring VMAs to be unregiste=
red
> > > through the same uffd they were registered with.
> > >
> > > While at it, correct the comment for the no userfaultfd case. This se=
ems
> > > to be a copy-paste artifact from the analagous userfaultfd_register()
> > > check.
> >
> > I consider it a BUG that should be fixed. Hoping Peter can share his
> > opinion.
>
> Agree it smells like unintentional, it's just that the man page indeed
> didn't mention what would happen if the userfaultfd isn't the one got
> registered but only requesting them to be "compatible".
>
> DESCRIPTION
>        Unregister a memory address range from userfaultfd.  The pages in
>        the range must be =E2=80=9Ccompatible=E2=80=9D (see UFFDIO_REGISTE=
R(2const)).
>
> So it sounds still possible if we have existing userapp creating multiple
> userfaultfds (for example, for scalability reasons on using multiple
> queues) to manage its own mm address space, one uffd in charge of a porti=
on
> of VMAs, then it can randomly take one userfaultfd to do unregistrations.
> Such might break.

As I mentioned in my response to James, it seems like the existing behavior
is broken as well, due to the following in in userfaultfd_unregister():

    if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
            goto out_unlock;

where wp_async is derived from ctx, not cur.

Pasting here:

This also seems to indicate that the current behavior is broken and may rej=
ect
unregistering some VMAs incorrectly. For example, a file-backed VMA registe=
red
with `wp_async` and UFFD_WP cannot be unregistered through a VMA that does =
not
have `wp_async` set.

> >
> > >
> > > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory =
externalization")
> > > Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> > > ---
> > >   fs/userfaultfd.c | 15 +++++++++++++--
> > >   1 file changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index 22f4bf956ba1..9289e30b24c4 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -1477,6 +1477,16 @@ static int userfaultfd_unregister(struct userf=
aultfd_ctx *ctx,
> > >   if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
> > >   goto out_unlock;
> > > + /*
> > > + * Check that this vma isn't already owned by a different
> > > + * userfaultfd. This provides for more strict behavior by
> > > + * preventing a VMA registered with a userfaultfd from being
> > > + * unregistered through a different userfaultfd.
> > > + */
> > > + if (cur->vm_userfaultfd_ctx.ctx &&
> > > +    cur->vm_userfaultfd_ctx.ctx !=3D ctx)
> > > + goto out_unlock;
> >
> > So we allow !cur->vm_userfaultfd_ctx.ctx to allow unregistering when th=
ere
> > was nothing registered.
> >
> > A bit weird to set "found =3D true" in that case. Maybe it's fine, just
> > raising it ...
>
> This part should be ok, as found is defined as:
>
> /*
> * Search for not compatible vmas.
> */
> found =3D false;
>
> So it's still compatible VMA even if not registered.
>
> It's just that I'm not yet sure how this change benefits the kernel
> (besides the API can look slightly cleaner).  There seems to still have a
> low risk of breaking userapps.  It could be a matter of whether there can
> be any real security concerns.
>
> If not, maybe we don't need to risk such a change for almost nothing (I
> almost never think "API cleaness" a goal when it's put together with
> compatilibities).
>
> Thanks,
>
> --
> Peter Xu
>

