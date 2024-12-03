Return-Path: <linux-fsdevel+bounces-36321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41FB9E17BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 10:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7477B285D1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F9F1DFE2C;
	Tue,  3 Dec 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkWvxtJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013521DE4FD
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218435; cv=none; b=lSkYi2tTbs2bmB4qWdoECwi5ZdvEIpxymgoZO3eS6Q4x5d5TLoHRwhu8rQu9AMH2zXcwpBhim/8GogPcydVztJad1y5tbSchh75btADBoJhQQ3d5qjdSta6r//GdYjPxU1LrP05FcEpXh6QTNsEl0g8lr4nQ7+qAyxJtpoDhonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218435; c=relaxed/simple;
	bh=z89TXH8M3RnRiRnDUwQNKuorvlS6MdyYOpZ+avQ1d9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDedN1Fuha3fq1FUqPjIgU9siOqRfIiqRZL17yn0lNEg1qtt5u4pWRn4V2RI993+XWzJrAhW/UH1aURqwP9KotD4XJgeTcmAxcHcUCBbCarwijKDRT2jQIlrZ7YxW246OcWuYdDR9/rCyqb/y8g1PMIrA7Vh45vigjz7yzpba60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkWvxtJH; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8a13444fcso17361436d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 01:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733218433; x=1733823233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkLwuq1H6f4LHZCNvaOoqQcCTucWtCr3bsTBx+UFyno=;
        b=YkWvxtJHmPjWqVjJ6WyvIMSXLeUlR507J3zykZC0lLUgNHG3Dz14hy5ZVsGstIPha9
         awJ8T3PGSg5FeUTD8hnRDele/JdMt3Kxmd71NyJnnsjh5UdbqiAqlKzyvKeYUhbk4Dbu
         clX9P8W+/Hm0D4K+p8tvq30vU49WR0NAOPELNDaiJhVHYSlj6aKev+UohMH/2E9Jdxq7
         WBF1HMuDfg7KOzdp+XvaLA2LF4WsM5m+zghHO/BWxZ2p5AWo5PstyDbKOGxHwyaMo/wu
         lWGqR/EQD9lFjCTaPD8nBwCNnS9F07L1QuK6UX4qV7+bdUJsR7Tta7yuLAco0T0m+Q3U
         vfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733218433; x=1733823233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkLwuq1H6f4LHZCNvaOoqQcCTucWtCr3bsTBx+UFyno=;
        b=r0BIkHhi3BPSdExBxIBKbO6ePACvfsTbQwFOD/bMC9QTbyK+3QDHQrF73+KAChuNLG
         +k/irOCEJi5rOaqovhSWRs/m378S3PUO6UESd9k0RN89BblOAFxWfFd11RSrGu7DC5Nu
         RLzQ7oLcsRipD2SQ+4zVvlFdPrExgmVgXADkb52QbR42flX2KjnqUYFEhtY0q1ZTGGSE
         8H/Ocg48ovGri7OuR3RQzIm6IQklQiEijgsKh6mLGtfjndhlm/flGftUNlhTo46CpTfw
         Znq+EzeKf90e2zy/wHSPJyWkDmMQB5E1MiMc0weCHhwsT462I53AkGVXGpOk+oEk3yk4
         CAzw==
X-Forwarded-Encrypted: i=1; AJvYcCXS3adwCKYZWElDv9Zrs2DYjYo7tpPPAS67roADKsaHrPCPdB3WJLm1/OchLm0o9jxYXgAZAn3kPvHqukC2@vger.kernel.org
X-Gm-Message-State: AOJu0YyUoG3ok+adzwrYfg2lXrm2xdcrHgwiQOid0/6YCjRWT/SxC96S
	Pk8uQ79L7W8loUK3suzNGz5UVWXC1Y2qT3iHX662ihF9w13n1BDt/9cVxj7KL9CXTYBbJlWsx6J
	DoAVQwrOk0bqRU/TJKScBFFBkztk4KoH1N9Rik5bx8Qo=
X-Gm-Gg: ASbGncuszV68zni6+nB1CRB9iGpJjvFVt9+aE9uUVmiQZpCF/aGlmWDlBUWLsNVTXO6
	foJfK/nzdnQbUyn6FyZRy7zeX6UIvK/GNSA==
X-Google-Smtp-Source: AGHT+IGRyv8mvf87qtMrjPEFuUPdE5+8CekbfuoSDg1qq43Qtk1kZov9g6zctBvS3SJ85K6yQ16Hz0IL9gfKEC3/HZk=
X-Received: by 2002:a05:6214:2a8c:b0:6d8:a188:369a with SMTP id
 6a1803df08f44-6d8b748dfc9mr19415106d6.48.1733218432859; Tue, 03 Dec 2024
 01:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411292300.61edbd37-lkp@intel.com> <CALOAHbABe2DFLWboZ7KF-=d643keJYBx0Es=+aF-J=GxqLXHAA@mail.gmail.com>
 <Z051LzN/qkrHrAMh@xsang-OptiPlex-9020>
In-Reply-To: <Z051LzN/qkrHrAMh@xsang-OptiPlex-9020>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 3 Dec 2024 17:33:16 +0800
Message-ID: <CALOAHbDq8yBuCEMsoL=Xr+_QHQ39-=XHK+PEN5KxncxmL=nhYw@mail.gmail.com>
Subject: Re: [linux-next:master] [mm/readahead] 13da30d6f9: BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 11:04=E2=80=AFAM Oliver Sang <oliver.sang@intel.com>=
 wrote:
>
> hi, Yafang,
>
> On Tue, Dec 03, 2024 at 10:14:50AM +0800, Yafang Shao wrote:
> > On Fri, Nov 29, 2024 at 11:19=E2=80=AFPM kernel test robot
> > <oliver.sang@intel.com> wrote:
> > >
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![usemem:#=
]" on:
> > >
> > > commit: 13da30d6f9150dff876f94a3f32d555e484ad04f ("mm/readahead: fix =
large folio support in async readahead")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mast=
er
> > >
> > > [test failed on linux-next/master cfba9f07a1d6aeca38f47f1f472cfb0ba13=
3d341]
> > >
> > > in testcase: vm-scalability
> > > version: vm-scalability-x86_64-6f4ef16-0_20241103
> > > with following parameters:
> > >
> > >         runtime: 300s
> > >         test: mmap-xread-seq-mt
> > >         cpufreq_governor: performance
> > >
> > >
> > >
> > > config: x86_64-rhel-9.4
> > > compiler: gcc-12
> > > test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H C=
PU @ 2.90GHz (Cooper Lake) with 192G memory
> > >
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > >
> > >
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202411292300.61edbd37-lkp@in=
tel.com
> > >
> > >
>
> [...]
>
> >
> > Is this issue consistently reproducible?
> > I attempted to reproduce it using the mmap-xread-seq-mt test case but
> > was unsuccessful.
>
> in our tests, the issue is quite persistent. as below, 100% reproduced in=
 all
> 8 runs, keeps clean on parent.
>
> d1aa0c04294e2988 13da30d6f9150dff876f94a3f32
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :8          100%           8:8     dmesg.BUG:soft_lockup-CPU##=
stuck_for#s![usemem:#]
>            :8          100%           8:8     dmesg.Kernel_panic-not_sync=
ing:softlockup:hung_tasks
>
> to avoid any env issue, we rebuild kernel and rerun more to check. if sti=
ll
> consistently reproduced, we will follow your further requests. thanks

Although I=E2=80=99ve made extensive attempts, I haven=E2=80=99t been able =
to
reproduce the issue. My best guess is that, in the non-MADV_HUGEPAGE
case, ra->size might be increasing to an unexpectedly large value. If
that=E2=80=99s the case, I believe the issue can be resolved with the
following additional change:

diff --git a/mm/readahead.c b/mm/readahead.c
index 9b8a48e736c6..e30132bc2593 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -385,8 +385,6 @@ static unsigned long get_next_ra_size(struct
file_ra_state *ra,
                return 4 * cur;
        if (cur <=3D max / 2)
                return 2 * cur;
-       if (cur > max)
-               return cur;
        return max;
 }

@@ -644,7 +642,11 @@ void page_cache_async_ra(struct readahead_control *rac=
tl,
                        1UL << order);
        if (index =3D=3D expected) {
                ra->start +=3D ra->size;
-               ra->size =3D get_next_ra_size(ra, max_pages);
+               /*
+                * For the MADV_HUGEPAGE case, the ra->size might be larger=
 than
+                * the max_pages.
+                */
+               ra->size =3D max(ra->size, get_next_ra_size(ra, max_pages))=
;
                ra->async_size =3D ra->size;
                goto readit;
        }

Could you please test this if you can consistently reproduce the bug?

--
Regards
Yafang

