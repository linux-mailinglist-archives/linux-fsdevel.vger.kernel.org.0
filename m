Return-Path: <linux-fsdevel+bounces-22606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2563691A27C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 11:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494A51C21869
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66151139584;
	Thu, 27 Jun 2024 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njhLamgu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B429CA;
	Thu, 27 Jun 2024 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479821; cv=none; b=COPSbSFN8CHXGgyLQvyspFXBRFwac0r1nB00Fog9riR4HbcURZLDDE1Ju4gZf8E7DhUMpr410ZfHptzTnc/70DjwRmp+BBIn0pEYP1aqhj7GaKX/yBYZl7MCRuUcKoiUADBe+4yp4WobF2l9MWxgDMojz3sQYQQczGpv/NI7XLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479821; c=relaxed/simple;
	bh=/DrwWYXVvlpK2Bc2B3DQSpfwDtONn7jhYBJ06ipvmlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxvdAjLzgkBRyAL3Of/sb+kyTreU2PBc6FaCu5xexmF+Pz7TryV9/o+2umvawZ9iHfzSOvmdtCHKCf90Loq93KlGb2lwp0DvbU7AJoFViLS00uAN5tyADm5wf8RtQJ1bpXgpbVwwyewoGXjtK9oY22Ki82pDG0aB2Vt1RBiNdcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njhLamgu; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48f48a5df47so1427472137.0;
        Thu, 27 Jun 2024 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719479819; x=1720084619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laUAmHHeAWLZesmoRpJPc1jRFT5y8CgDrTpEQBOLTsA=;
        b=njhLamguNTkX29tcjPWsR4iHKr61t+0V/VQQ9rFU4qqEX5Xih1vjtQQKKfBlbstL0s
         GYl7Uw/UV6/I1oFuxgtxzSg+E+Tq/L7cxw3gQaCXRReV091q1rG7YLd7tjzjgFIz9TJy
         ygwHY1DlASmC4EORAuzemz/a9fCveyOHN7vyRDHiKPPMDGrDfrSlssHBZc9QJ4He+p0u
         gNiZLFfyjSHyehli6DqKHlN903iiPynSx31vIqEalICOJq1yWHNNUmJrGp0KhXLo8YTk
         b3EkJOlYaOktfilCQnTnAaaN1UExRRbN2ec/jz8LyBKA5DiUQTDcLgAoOdMHEGRaom5m
         pMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719479819; x=1720084619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laUAmHHeAWLZesmoRpJPc1jRFT5y8CgDrTpEQBOLTsA=;
        b=HM+0JemmoFrMXOgcI/USDuWNnmKGesef3U22VM7zA54zi5W2aFL+fGSrU40bWkRpM+
         IXHwky+o6zxqJx7DexrVcrWz3+Cr+yetuANSVZ3yPd+WF+v9wFVkhNBsxqldHDuzdut/
         qHYJ3pGSuYHNJ1Pjt/dpgV0JXiSwzGfDJRAlExN9J2lt6bnqA8O4gyM9tKd42o7jHYq2
         PSKZYI3t4lwJb1l7o/7m5Ndz2XRs/k8zjjRpsgPNIWO6+hnVuH7rMTapWPJWHcEwBsTC
         uihSuCcHLdCKdcYq1MDjMLVPkb917wNZAm7emSyGxUURVqJkTNUR8xPxrmSrkIaaKl+9
         zBFA==
X-Forwarded-Encrypted: i=1; AJvYcCWOJzsAm4SeQT32X+GQjtry1pnJSE5icD1bTJNaxUe9uSZRUJGkqx2oN2VFI4xkzJeYMYHOoEINb8D6CjLfVHhABmdgwwdMX/n3CMsW0m8gabdhooM7/Q0lKv/JaJ1hkYxkir3TtzI1TgLKrw==
X-Gm-Message-State: AOJu0YwFOcs162J5k9SEJXggyxivpKUqTRbcXIUuiL3ypjSEqXTQ38O0
	tnRx+8wySLa84lxruZzkF8DMQ55+Sk+a4bRuBEG/o6utKMERSlqvGicRZs4HiqFz84NH0ZKFUes
	WW3XiQkIpgUX2Oi+JVQtdZr3oQMc=
X-Google-Smtp-Source: AGHT+IGDLHfABvb02LaUhvggwzZRRRzaS6X1WS7h/Jy/1gtYvCD5PesYN8abGcl17/Mxznh8eEfXyqeLXliAPtLH/WE=
X-Received: by 2002:a67:b449:0:b0:48f:454b:f4d3 with SMTP id
 ada2fe7eead31-48f4ee77999mr11567186137.2.1719479818969; Thu, 27 Jun 2024
 02:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
 <20240626024924.1155558-3-ranxiaokai627@163.com> <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
 <1907a8c0-9860-4ca0-be59-bec0e772332b@arm.com> <D2A0ZD1AOJDA.3OLNZCHJAXRK8@nvidia.com>
 <CAGsJ_4wCymN=YQt7cDBZ-xB8Kr4C7hSnDaWNevnhiNC76pXd-A@mail.gmail.com> <fceebb14-49de-4bfb-8a3a-3ce9c7dee0e6@arm.com>
In-Reply-To: <fceebb14-49de-4bfb-8a3a-3ce9c7dee0e6@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 27 Jun 2024 21:16:46 +1200
Message-ID: <CAGsJ_4ycXcwnK4RMqj7WpW5hMOGdSaN3fec9K6HFKusxP9hrXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Zi Yan <ziy@nvidia.com>, ran xiaokai <ranxiaokai627@163.com>, akpm@linux-foundation.org, 
	willy@infradead.org, vbabka@suse.cz, svetly.todorov@memverge.com, 
	ran.xiaokai@zte.com.cn, peterx@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 8:39=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 27/06/2024 05:10, Barry Song wrote:
> > On Thu, Jun 27, 2024 at 2:40=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On Wed Jun 26, 2024 at 7:07 AM EDT, Ryan Roberts wrote:
> >>> On 26/06/2024 04:06, Zi Yan wrote:
> >>>> On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
> >>>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >>>>>
> >>>>> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compoun=
d
> >>>>> pages, which means of any order, but KPF_THP should only be set
> >>>>> when the folio is a 2M pmd mappable THP.
> >>>
> >>> Why should KPF_THP only be set on 2M THP? What problem does it cause =
as it is
> >>> currently configured?
> >>>
> >>> I would argue that mTHP is still THP so should still have the flag. A=
nd since
> >>> these smaller mTHP sizes are disabled by default, only mTHP-aware use=
r space
> >>> will be enabling them, so I'll naively state that it should not cause=
 compat
> >>> issues as is.
> >>>
> >>> Also, the script at tools/mm/thpmaps relies on KPF_THP being set for =
all mTHP
> >>> sizes to function correctly. So that would need to be reworked if mak=
ing this
> >>> change.
> >>
> >> + more folks working on mTHP
> >>
> >> I agree that mTHP is still THP, but we might want different
> >> stats/counters for it, since people might want to keep the old THP cou=
nters
> >> consistent. See recent commits on adding mTHP counters:
> >> ec33687c6749 ("mm: add per-order mTHP anon_fault_alloc and anon_fault_=
fallback
> >> counters"), 1f97fd042f38 ("mm: shmem: add mTHP counters for anonymous =
shmem")
> >>
> >> and changes to make THP counter to only count PMD THP:
> >> 835c3a25aa37 ("mm: huge_memory: add the missing folio_test_pmd_mappabl=
e() for
> >> THP split statistics")
> >>
> >> In this case, I wonder if we want a new KPF_MTHP bit for mTHP and some
> >> adjustment on tools/mm/thpmaps.
> >
> > It seems we have to do this though I think keeping KPF_THP and adding a
> > separate bit like KPF_PMD_MAPPED makes more sense. but those tools
> > relying on KPF_THP need to realize this and check the new bit , which i=
s
> > not done now.
> > whether the mTHP's name is mTHP or THP will make no difference for
> > this case:-)
>
> I don't quite follow your logic for that last part; If there are 2 separa=
te
> bits; KPF_THP and KPF_MTHP, and KPF_THP is only set for PMD-sized THP, th=
at
> would be a safe/compatible approach, right? Where as your suggestion requ=
ires
> changes to existing tools to work.

Right, my point is that mTHP and THP are both types of THP. The only differ=
ence
is whether they are PMD-mapped or PTE-mapped. Adding a bit to describe how
the page is mapped would more accurately reflect reality. However, this cha=
nge
would disrupt tools that assume KPF_THP always means PMD-mapped THP.
Therefore, we would still need separate bits for THP and mTHP in this case.

I saw Willy complain about mTHP being called "mTHP," but in this case, call=
ing
it "mTHP" or just "THP" doesn't change anything if old tools continue to as=
sume
that KPF_THP means PMD-mapped THP.

>
> Thinking about this a bit more, I wonder if PKF_MTHP is the right name fo=
r a new
> flag; We don't currently expose the term "mTHP" to user space. I can't th=
ink of
> a better name though.

Yes.  If "compatibility" is a requirement, we cannot disregard it.

> I'd still like to understand what is actually broken that this change is =
fixing.
> Is the concern that a user could see KPF_THP and advance forward by
> "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size / getpagesize()" entr=
ies?
>

Maybe we need an example which is thinking that KPF_THP is PMD-mapped.

> >
> >>
> >>
> >> --
> >> Best Regards,
> >> Yan, Zi
> >>
> >

Thanks
Barry

