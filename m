Return-Path: <linux-fsdevel+bounces-51977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C446ADDD72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 22:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6086B1940BF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 20:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816B2E6D33;
	Tue, 17 Jun 2025 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="r2Drjo8u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072391A5B85
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750193439; cv=none; b=HUzhfIPyUBGfqPwn0Ja+cNMHRIOa8LxQ8CnNsZeJrHOk8nHr8+2ITu6jEW7ETyxLamMBKdA5e9hCy5/HZDEBmC3WzzVZeyZ5xLsGKDGbQtCdVyOhun45Mit+vE59ckn9hE++LGgJUe88k49DeisougENYq8JpVBkMT7mGiZZzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750193439; c=relaxed/simple;
	bh=4bcCwaN5jKAqSH6DvVVNHKdZM3oQfNLDpnd/khiCLHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRmKQPUAfZ70L8vgTSq70hJrHGTMG+9xJQoqBBtdY4NJ4BVcfLM7w2X6xF10ZuRhAXshr1q63jv53ivgDLkpTLz09y5vh911dQD1B7oNpLNkLEgVkRtgaXl47vZNSw58O4RMTwpGTYaqX6nbfcOcq+7D2+2V6w7Id+7VAVtL4Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=r2Drjo8u; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HKFlKb001016
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 16:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=kHRW9Nu+63/GeEfAZ+I+V+utb3fXU8IH15wFHQNM6f0=;
 b=r2Drjo8uUKd73xclv/tSGiKeaCM7vYKjKI+7iApuS8jqigfIFZCpuinH4uB3tdRDHC57
 GjjLWhbucWERq+YBbNnimo9857Um/sB/5XhvIaFznS8ZrvzqJIozCTt6rz3oGlG6f/TV
 cJBiEMZB2+OkPrf8SQPuCVSIy4QbFD9W/9BM40mMbRvqpB74vbwIbTX59LkvlQ0qlNaW
 K+auqpCP9ZLLa0eE4Amfxn2SI6gROwf16PYnPGO/YEYp6MM4y85qZVoh6saIjPKnNFTp
 wKf0PlnR0LBLq0EsKMhNsFAcPXHlBPa+qFgQJUdwbeCPwI8YFGK+zBh9cN3Mt8UTvE1A yQ== 
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4794yfjv1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 16:50:34 -0400
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7111d608131so90051637b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 13:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750193434; x=1750798234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHRW9Nu+63/GeEfAZ+I+V+utb3fXU8IH15wFHQNM6f0=;
        b=VymgjOzJ9de8pgMT+JtX7tej0ozYWNsQkQYdlxVNniMIVzqUVoHrwajwiX+CcI/LgD
         gSeew07JfV4UilcMpLlMmCSFhTlAE6BEE/WS8+21tCcCbLOJQGYeT/kP2SBk6yaeBkVx
         cMYIx8EL2sw3K/KqutIv6r3cbodEHQ2/p/0uF+vclM1CLiWIPEkD17rjDnegcaZIave8
         7aSR9gFzifFailXkrvnCNB2riMwCV85nD5FgdIu6+IS306cL01wcTdUOnCwARzebSoJW
         lsBxHcIfWXw6vuJvM0xxMoI2xho8+wz6Mhl7QbFLMfNGJVvUuA1uC0JfB/1k/Ki8HZgD
         USvA==
X-Forwarded-Encrypted: i=1; AJvYcCU4LFzN4CeDiSSEUSrRPsGnvMjqMSSi5uBC8MkINBKhSClGo2vY0VCLnRBcaJNLNjfA80KP+FsKf9OGpf/p@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2tsuX0NY8dCntiPf5pCcqpKsk1MOtp9diFdGQp//BiJukG1DT
	itaw1LLS0HMXlojJ2RKO3Ii6eHLRaB3i8og3HuCe1S89axRaXgQ+MQ9dxmiXn4HYYE4UlfyAYkj
	yazYvHI9//9Y0SjoQAlUL4gTH4AGFSbZMrY70vPQNhQHfctPjIO+Wd1veUlbHneg6V/pisepiqs
	J5IpppS8q/9clO2B8LpByPfcDsHAMWbK+3OUmsEQ==
X-Gm-Gg: ASbGnct9UjIrlkOOxEPeajAZPTpwQsPvj91pjEluPS3W+GIIShrLwnI+PKIaBcEdblX
	mudzZmDQOhcZ/d5cMvJjwHmyVxsbiJ2YGZriNjof4oceEBaT8b0VpHgpcsuFNmIxkLp00zEympb
	kcqed8
X-Received: by 2002:a05:690c:7085:b0:711:33d3:92ed with SMTP id 00721157ae682-7117547e398mr196388487b3.38.1750193433823;
        Tue, 17 Jun 2025 13:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFkuwT+fLR4WKKPymtx1/7iwNyL7yTTLzuBi63mVvFMY8cCKDK7Li4VnZQgIqQeFSw0PwBNF7+bj2If0h+Nvk=
X-Received: by 2002:a05:690c:7085:b0:711:33d3:92ed with SMTP id
 00721157ae682-7117547e398mr196387977b3.38.1750193433443; Tue, 17 Jun 2025
 13:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607-uffd-fixes-v2-0-339dafe9a2fe@columbia.edu>
 <20250607-uffd-fixes-v2-3-339dafe9a2fe@columbia.edu> <cb6f4acf-1eca-4d61-aa70-5edaf89d9763@redhat.com>
In-Reply-To: <cb6f4acf-1eca-4d61-aa70-5edaf89d9763@redhat.com>
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 17 Jun 2025 16:50:22 -0400
X-Gm-Features: AX0GCFuppgQNaMC-wQr2Mt5OwUGedRzgBMvE-W4xD5WFZ25ag1VCaucfpSNRTtk
Message-ID: <CAKha_soChL=TmSAK_yBQYnyjdNRpjp121N5F8XRA=4O9Q+_wvw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 6RJu8_InnV0zX7fpLZZkV06_DAVMnr5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE2NiBTYWx0ZWRfX5NYQ4+HkbZ1Q KaD265TtOJadOA4mGPPEwzKhNs2d3ojxvCPbrXI9I6ttlRlrjNdq1qiF0uuJJabt0SuAkC1qrvc WNBDaDgDyApCmscDaylGyN13p9VET2fhnm1b/MvGjXna3GqE14SsL4oxK/apQajtbv5SMQnQGuw
 u5eDdND1cGCVccf6tFD0VoBI1FP762KRDPGmNga4k+B/ybRYpzLxYF8acoajEH6AdPUXqZxT757 zPDV4gMDM5yOdoLv4lmJ9pPARtgUn8Q87GjIJiV3xZVHdMf6bNsHiDyCm6hw/mdJ3cR9GYZsttp MNW1HmU78FNklBBIRg8ss3o6neHhHaGK9uAjH12GoFqrMtlBDW0c5w+enXpT4FAQgn8dtMFUgqY OTWwFagk
X-Proofpoint-GUID: 6RJu8_InnV0zX7fpLZZkV06_DAVMnr5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 bulkscore=10 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=10 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170166

On Tue, Jun 10, 2025 at 3:31=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 07.06.25 08:40, Tal Zussman wrote:
> > Currently, a VMA registered with a uffd can be unregistered through a
> > different uffd associated with the same mm_struct.
> >
> > The existing behavior is slightly broken and may incorrectly reject
> > unregistering some VMAs due to the following check:
> >
> > if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
> > goto out_unlock;
> >
> > where wp_async is derived from ctx, not from cur. For example, a file-b=
acked
> > VMA registered with wp_async enabled and UFFD_WP mode cannot be unregis=
tered
> > through a uffd that does not have wp_async enabled.
> >
> > Rather than fix this and maintain this odd behavior, make unregistratio=
n
> > stricter by requiring VMAs to be unregistered through the same uffd the=
y
> > were registered with. Additionally, reorder the WARN() checks to avoid
> > the aforementioned wp_async issue in the WARN()s.
> >
> > This change slightly modifies the ABI. It should not be backported to
> > -stable.
>
> Probably add that the expectation is that nobody really depends on this
> behavior, and that no such cases are known.
>
> >
> > While at it, correct the comment for the no userfaultfd case. This seem=
s to
> > be a copy-paste artifact from the analogous userfaultfd_register() chec=
k.
> >
> > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory ex=
ternalization")
>
> Fixes should come before anything else in a series (Andrew even prefers
> a separate series for fixes vs. follow-up cleanups).
>
> > Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> > ---
> >   fs/userfaultfd.c | 17 +++++++++++++----
> >   1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 80c95c712266..10e8037f5216 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1466,6 +1466,16 @@ static int userfaultfd_unregister(struct userfau=
ltfd_ctx *ctx,
> >   VM_WARN_ON_ONCE(!!cur->vm_userfaultfd_ctx.ctx ^
> >   !!(cur->vm_flags & __VM_UFFD_FLAGS));
> >
> > + /*
> > + * Check that this VMA isn't already owned by a different
> > + * userfaultfd. This provides for more strict behavior by
> > + * preventing a VMA registered with a userfaultfd from being
> > + * unregistered through a different userfaultfd.
> > + */
>
> Probably we can shorted to:
>
> /*
>   * Prevent unregistering through another userfaultfd than used for
>   * registering.
>   */
>
> ?
>
> > + if (cur->vm_userfaultfd_ctx.ctx &&
> > +    cur->vm_userfaultfd_ctx.ctx !=3D ctx)
> > + goto out_unlock;
> > +
> >   /*
> >   * Check not compatible vmas, not strictly required
> >   * here as not compatible vmas cannot have an
> > @@ -1489,15 +1499,14 @@ static int userfaultfd_unregister(struct userfa=
ultfd_ctx *ctx,
> >   for_each_vma_range(vmi, vma, end) {
> >   cond_resched();
> >
> > - VM_WARN_ON_ONCE(!vma_can_userfault(vma, vma->vm_flags, wp_async));
> > -
> >   /*
> > - * Nothing to do: this vma is already registered into this
> > - * userfaultfd and with the right tracking mode too.
> > + * Nothing to do: this vma is not registered with userfaultfd.
> >   */
>
> Maybe
>
> /* VMA not registered with userfaultfd. */
>
> The "skip" below is rather clear. :)
>
> >   if (!vma->vm_userfaultfd_ctx.ctx)
> >   goto skip;
> >
> > + VM_WARN_ON_ONCE(vma->vm_userfaultfd_ctx.ctx !=3D ctx);
> > + VM_WARN_ON_ONCE(!vma_can_userfault(vma, vma->vm_flags, wp_async));
> >   WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> >
> >   if (vma->vm_start > start)
> >
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks! Will update with the suggested comment + commit message changes and=
 move
this patch before the VM_WARN changes.

> --
> Cheers,
>
> David / dhildenb
>

