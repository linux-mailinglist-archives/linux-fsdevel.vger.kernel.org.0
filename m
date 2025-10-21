Return-Path: <linux-fsdevel+bounces-64990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B238BF831E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 21:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F6354314A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 19:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA4A34E74E;
	Tue, 21 Oct 2025 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt+50a3T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C734D925
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073685; cv=none; b=VcNkM62BnFLYW9ng7TGjsM5v7+7LarTa6X28nY7ZMJvyW8LuVZ1x4fgPtWI6TJRb0MYo+nbXXlodfZpOzv7z0+t0k3yqcyxUAIX2DOQStsGGI/NxUfai7MI/37WzleS1SWXshjkSitC3yWWkJScTvUgNe4TkrUfe7dGOfEihMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073685; c=relaxed/simple;
	bh=g2dJ/u8Sne5OzCu7UQjFntaGV3803V5eDu2XYCBZC/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMHjX2iasIBBWIK4g1P816A/LROyEuxImeNybyByJDx6zepyKoS05pwgPOZhMqNTGD5zQRFkTDMf5zK+rgc9rUkO/uyqzel5W2g7sNQG9cC5a7cfhViLOVcHs+9QMbPMFOBR5/ZlFYoi7/OKXeKfb7fdp6ZQNmHSFRkTorhRITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bt+50a3T; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-89018e97232so1396040241.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761073683; x=1761678483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih1Ch3iw7RIxA9JcjZCICBR9PPRDjzjVXI5AMkESEI0=;
        b=bt+50a3TPtx4/YxNVNnKpmLgvQtk36R1FFsXGmf0LdJO4v+Lk+YcGjmq2SVpqjtOws
         Qj7pNCdIvKMwGZgH6+MBCdFg4uXrAIDTq7R6eCSuuXlpqqNvZyhH+WN1hZORIaY9eqv2
         eB1IPk2+lj+YZsugVQVGOPKcTCbB3NhMxN8xSEwMShuM8juucx+3SKHXWZO2enb/xmyp
         /M343fCGohSo3yTB0J87YNLT7d22A5rmuBgL3vNAFQkQZBlclFWbPUnUS9H4szdoXAjn
         k2EPkxco/AawaHCF+0RTA/w2oiK+d1AOOIhEVhGzVQ72HSGCQTW3hZcLR9ZzjWeQyubP
         /QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761073683; x=1761678483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ih1Ch3iw7RIxA9JcjZCICBR9PPRDjzjVXI5AMkESEI0=;
        b=f7vh5LhuMBBjkYUu+kKbrfwBhvc0nn5g7eEjbQpEuG5Z3ZZDTdbMxMy+hOPGMeKeC6
         m6WWcbnOdSlRlsiY5jixjEWz/nKTN0oWxmnQOeNqAf4N1ZT6B8a3vrHU56qx+Jwvm8LR
         9vLqz7a+ByGH0IAL5B1QtHwIOSFxO4PxZjRaQ5nhJ5IS4oFqBRrMXLCCFZ2oS4tXi8xe
         YazACjeI9pIbaD3aVGUeGoshbGhmH1iabd/7bL6zwCUuHLcgprWpMpaWNOxJNijd4Pxa
         9+67dToMlugXNVyi338ws+uIGpm6rW7cyMmFVri7W5SIS+HzUwX70vnGhnepHAHzMWcB
         201w==
X-Forwarded-Encrypted: i=1; AJvYcCWjM4ZmWkkGicGoGoQ0qN5g5TDmwPdIO3Gk6VWhG0myaOsOwpq3M7WH4m2nJ3csZt5E8khZBbZH0JnkKH6X@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQ5gKwm4a9K3Xr7xffUL/CUyRLkD3oerosU5pn5EaAhtD91Kc
	5yRUxpfdUhNlOhCbh1lRgrsz2mzRVURns/TZTWTXlHJh11yrXtU5Q/C3goOtiM2zUPdIXmZ6tFv
	Pg396QVkZw4JxDfCioZu6EvmCYcldDms=
X-Gm-Gg: ASbGncvRHc2lr/lbnzJ6rcN3zVztc+M/H6PoQbjNPB0f2cDWxB/LCHfrvzFe/NnjaH5
	UJyu9Ua6OkeDGVKF2zxnyYNST4rbJq8zDcKPp8bJ0xcwyo3P8kzP/jM5i/Qztos0/OLXvj+CFur
	m6bTMo6r6rjIeNUO5E761PMLSOvRjOJ7KyAgylLx/XrWoVgi3bkpeGreBC7Dz1IG3dRuezTADlV
	CRvkIuQdMZLi89XAOAU2Th6+U8LYQdV8zvk5EL4fWt9wvYUgVBol+ZYKLHqasEvw7aqcvtkIw==
X-Google-Smtp-Source: AGHT+IFlj4r2CIdxYmWU/Zi9ZOv/Fra2dbdRQSIRCL+DLRP4lrjPe1dkhMd8vBIZJF7+BrBOdoskf6mJVBs9ZM2ndC0=
X-Received: by 2002:a05:6102:512b:b0:5d7:bc22:f9af with SMTP id
 ada2fe7eead31-5d7dd6a5227mr4503063137.25.1761073682915; Tue, 21 Oct 2025
 12:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016033452.125479-1-ziy@nvidia.com> <20251016033452.125479-3-ziy@nvidia.com>
 <CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com>
 <5EE26793-2CD4-4776-B13C-AA5984D53C04@nvidia.com> <CAHbLzkp8ob1_pxczeQnwinSL=DS=kByyL+yuTRFuQ0O=Eio0oA@mail.gmail.com>
 <A4D35134-A031-4B15-B7A0-1592B3AE6D78@nvidia.com> <b353587b-ef50-41ab-8dd2-93330098053e@redhat.com>
 <893332F4-7FE8-4027-8FCC-0972C208E928@nvidia.com> <595b41b0-428a-4184-9abc-6875309d8cbd@redhat.com>
 <6ACA0358-4C83-430A-892C-F0A6CC1DC8EA@nvidia.com>
In-Reply-To: <6ACA0358-4C83-430A-892C-F0A6CC1DC8EA@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 21 Oct 2025 12:07:49 -0700
X-Gm-Features: AS18NWBQm40401R-3eSStXerP5YpXnZxigPk8j1z8V14Yb_RrXNCxRz1tuxoYTs
Message-ID: <CAHbLzkqDt0FfNaG7-rxqz4y=3Wu8yiL38FQiH6hVEsAfRBRvuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/memory-failure: improve large block size folio handling.
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linmiaohe@huawei.com, jane.chu@oracle.com, 
	kernel@pankajraghav.com, 
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org, mcgrof@kernel.org, 
	nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:58=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 21 Oct 2025, at 14:28, David Hildenbrand wrote:
>
> > On 21.10.25 17:55, Zi Yan wrote:
> >> On 21 Oct 2025, at 11:44, David Hildenbrand wrote:
> >>
> >>> On 21.10.25 03:23, Zi Yan wrote:
> >>>> On 20 Oct 2025, at 19:41, Yang Shi wrote:
> >>>>
> >>>>> On Mon, Oct 20, 2025 at 12:46=E2=80=AFPM Zi Yan <ziy@nvidia.com> wr=
ote:
> >>>>>>
> >>>>>> On 17 Oct 2025, at 15:11, Yang Shi wrote:
> >>>>>>
> >>>>>>> On Wed, Oct 15, 2025 at 8:38=E2=80=AFPM Zi Yan <ziy@nvidia.com> w=
rote:
> >>>>>>>>
> >>>>>>>> Large block size (LBS) folios cannot be split to order-0 folios =
but
> >>>>>>>> min_order_for_folio(). Current split fails directly, but that is=
 not
> >>>>>>>> optimal. Split the folio to min_order_for_folio(), so that, afte=
r split,
> >>>>>>>> only the folio containing the poisoned page becomes unusable ins=
tead.
> >>>>>>>>
> >>>>>>>> For soft offline, do not split the large folio if it cannot be s=
plit to
> >>>>>>>> order-0. Since the folio is still accessible from userspace and =
premature
> >>>>>>>> split might lead to potential performance loss.
> >>>>>>>>
> >>>>>>>> Suggested-by: Jane Chu <jane.chu@oracle.com>
> >>>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>>>>>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> >>>>>>>> ---
> >>>>>>>>    mm/memory-failure.c | 25 +++++++++++++++++++++----
> >>>>>>>>    1 file changed, 21 insertions(+), 4 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >>>>>>>> index f698df156bf8..443df9581c24 100644
> >>>>>>>> --- a/mm/memory-failure.c
> >>>>>>>> +++ b/mm/memory-failure.c
> >>>>>>>> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned =
long pfn, struct page *p,
> >>>>>>>>     * there is still more to do, hence the page refcount we took=
 earlier
> >>>>>>>>     * is still needed.
> >>>>>>>>     */
> >>>>>>>> -static int try_to_split_thp_page(struct page *page, bool releas=
e)
> >>>>>>>> +static int try_to_split_thp_page(struct page *page, unsigned in=
t new_order,
> >>>>>>>> +               bool release)
> >>>>>>>>    {
> >>>>>>>>           int ret;
> >>>>>>>>
> >>>>>>>>           lock_page(page);
> >>>>>>>> -       ret =3D split_huge_page(page);
> >>>>>>>> +       ret =3D split_huge_page_to_list_to_order(page, NULL, new=
_order);
> >>>>>>>>           unlock_page(page);
> >>>>>>>>
> >>>>>>>>           if (ret && release)
> >>>>>>>> @@ -2280,6 +2281,7 @@ int memory_failure(unsigned long pfn, int =
flags)
> >>>>>>>>           folio_unlock(folio);
> >>>>>>>>
> >>>>>>>>           if (folio_test_large(folio)) {
> >>>>>>>> +               int new_order =3D min_order_for_split(folio);
> >>>>>>>>                   /*
> >>>>>>>>                    * The flag must be set after the refcount is =
bumped
> >>>>>>>>                    * otherwise it may race with THP split.
> >>>>>>>> @@ -2294,7 +2296,14 @@ int memory_failure(unsigned long pfn, int=
 flags)
> >>>>>>>>                    * page is a valid handlable page.
> >>>>>>>>                    */
> >>>>>>>>                   folio_set_has_hwpoisoned(folio);
> >>>>>>>> -               if (try_to_split_thp_page(p, false) < 0) {
> >>>>>>>> +               /*
> >>>>>>>> +                * If the folio cannot be split to order-0, kill=
 the process,
> >>>>>>>> +                * but split the folio anyway to minimize the am=
ount of unusable
> >>>>>>>> +                * pages.
> >>>>>>>> +                */
> >>>>>>>> +               if (try_to_split_thp_page(p, new_order, false) |=
| new_order) {
> >>>>>>>
> >>>>>>> folio split will clear PG_has_hwpoisoned flag. It is ok for split=
ting
> >>>>>>> to order-0 folios because the PG_hwpoisoned flag is set on the
> >>>>>>> poisoned page. But if you split the folio to some smaller order l=
arge
> >>>>>>> folios, it seems you need to keep PG_has_hwpoisoned flag on the
> >>>>>>> poisoned folio.
> >>>>>>
> >>>>>> OK, this means all pages in a folio with folio_test_has_hwpoisoned=
() should be
> >>>>>> checked to be able to set after-split folio's flag properly. Curre=
nt folio
> >>>>>> split code does not do that. I am thinking about whether that caus=
es any
> >>>>>> issue. Probably not, because:
> >>>>>>
> >>>>>> 1. before Patch 1 is applied, large after-split folios are already=
 causing
> >>>>>> a warning in memory_failure(). That kinda masks this issue.
> >>>>>> 2. after Patch 1 is applied, no large after-split folios will appe=
ar,
> >>>>>> since the split will fail.
> >>>>>
> >>>>> I'm a little bit confused. Didn't this patch split large folio to
> >>>>> new-order-large-folio (new order is min order)? So this patch had
> >>>>> code:
> >>>>> if (try_to_split_thp_page(p, new_order, false) || new_order) {
> >>>>
> >>>> Yes, but this is Patch 2 in this series. Patch 1 is
> >>>> "mm/huge_memory: do not change split_huge_page*() target order silen=
tly."
> >>>> and sent separately as a hotfix[1].
> >>>
> >>> I'm confused now as well. I'd like to review, will there be a v3 that=
 only contains patch #2+#3?
> >>
> >> Yes. The new V3 will have 3 patches:
> >> 1. a new patch addresses Yang=E2=80=99s concern on setting has_hwpoiso=
ned on after-split
> >> large folios.
> >> 2. patch#2,
> >> 3. patch#3.
> >
> > Okay, I'll wait with the review until you resend :)
> >
> >>
> >> The plan is to send them out once patch 1 is upstreamed. Let me know i=
f you think
> >> it is OK to send them out earlier as Andrew already picked up patch 1.
> >
> > It's in mm/mm-new + mm/mm-unstable, AFAIKT. So sure, send it against on=
e of the tress (I prefer mm-unstable but usually we should target mm-new).
>
> Sure.
> >
> >>
> >> I also would like to get some feedback on my approach to setting has_h=
wpoisoned:
> >>
> >> folio's has_hwpoisoned flag needs to be preserved
> >> like what Yang described above. My current plan is to move
> >> folio_clear_has_hwpoisoned(folio) into __split_folio_to_order() and
> >> scan every page in the folio if the folio's has_hwpoisoned is set.
> >
> > Oh, that's nasty indeed ... will have to think about that a bit.
> >
> > Maybe we can keep it simple and always set folio_set_has_hwpoisoned() o=
n all split folios? Essentially turning it into a "maybe_has" semantics.
> >
> > IIUC, the existing folio_stest_has_hwpoisoned users can deal with that?
>
> folio_test_has_hwpoisoned() direct users are fine. They are shmem.c
> and memory.c, where the former would copy data in PAGE_SIZE instead of fo=
lio size
> and the latter would not install PMD entry for the folio (impossible to h=
it
> this until we have > PMD mTHPs and split them to PMD THPs).
>
> The caller of folio_contain_hwpoisoned_page(), which calls
> folio_test_has_hwpoisoned(), would have issues:
>
> 1. shmem_write_begin() in shmem.c: it returns -EIO for shmem writes.
> 2. thp_underused() in huge_memory.c: it does not scan the folio.
> 3. shrink_folio_list() in vmscan.c: it does not reclaim large hwpoisoned =
folios.
> 4. do_migrate_range() in memory_hotplug.c: it skips the large hwpoisoned =
folios.
>
> These behaviors are fine for folios truly containing hwpoisoned pages,
> but might not be desirable for false positive cases. A scan to make sure
> hwpoisoned pages are indeed present is inevitable. Rather than making
> all callers to do the scan, scanning at split time might be better, IMHO.

Yeah, I was trying to figure out a simpler way too. For example, we
can defer to set this flag to page fault time when page fault sees the
poisoned page when installing PTEs. But it can't cover most of the
cases mentioned by Zi Yan above. We may run into them before any page
fault happens.

Thanks,
Yang

>
> Let me send a patchset with scanning at split time. Hopefully, more peopl=
e
> can chime in to provide feedbacks.
>
>
> --
> Best Regards,
> Yan, Zi

