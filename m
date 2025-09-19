Return-Path: <linux-fsdevel+bounces-62248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F1BB8A8C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 18:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D0F5A7686
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC9031E106;
	Fri, 19 Sep 2025 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgioItWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410E320CC3
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298949; cv=none; b=ndtZ2DoM4TUOTXlGTYAzJEeHv9DhzZ80tfgOVFohbSvCL1LEqkmAQ24RqBj9CFtZFWMy8LQncQzHlu18vn5sjRtcQHtaje7UQrFQ2qywis+AlgnJ7XzU5H6LBXxqdMsz0MYWgsO+2XWtx/K0vpHVed7VJcdn/pGi7Iyu3socoF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298949; c=relaxed/simple;
	bh=BS4KtDrq6Dx+RDukiMH+9r5Pse7avn4XgUu/V7iPc0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oH2VGp5e7wcx4oXbddWVq7Zg6GSp0e0u2AhvqxglJqUA2dXdUckDReDddBLrKFTYDU8heuG6uI50WJmQW/LC6JWAWayqwzFsTDx+9ekce4GIhISiODulHT2PWjrlNAYcZ9X4S5MQg1EryEcj5EjLXmBfXu2AVj/NYsErfj+fCUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgioItWR; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-31d6e39817fso4064528fac.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758298946; x=1758903746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNf4FavrobHnYfMkgvSm3G7G16uS+CH76oyvfIGfz8U=;
        b=hgioItWREHywNAa1DWJSu204ZNPo9/FuPwnOrsiqsWTkzE04/q4kDnHBKU+dDk+vwc
         0p2518CQOjMS6I4mJP00tq5WXkHsp04kTLwUWXyoVmq11iou+V8NNaPceOufRJlVzGIR
         UO8ueoODfVN3CBd88ZwLr+6gMsYqbgetwmOolroLtzXQBh1DTTruqAetkoAr5autyqRk
         j3tZq551pivFMAdvdP4IanwEdONkoUPFPgu+2aJI0LBtD9yBRdrrSzKOtInbElXr/Voy
         aVv2jzemCIaZcyYNM8fhMbTuCjxSPCsDps+LAiZ3diDALkcUV2yb67VwVwinwoGfo9p1
         iPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758298946; x=1758903746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNf4FavrobHnYfMkgvSm3G7G16uS+CH76oyvfIGfz8U=;
        b=P9N0w1ZFAWXBeVWDVfqXf4q6GyQpn9+ggSqXtoDw4GDs9MVXcepfC+EUqMvrJzR2Ch
         sCZbJHOyuQCyxvO1hfYYPAb+c/DKJ2INeXC25DNgun6qSyIjSOh92qDMtc3Q5tex3DMZ
         tKas3VBB2PpCLfAGMA8PpXJlAxwVQ+dcV6xDeDePfuDYR14U1srHVM3qQm6vjQPDuBcM
         pGxYvJKftpS6PnwmcJlRk81DBEjUy/bit8xxp2UmVnTkWsZXA+xeki0Yz1CHdQ5k62y5
         VoN3R+oSQn6QKEXpLYerlVtaVbPeA6sATMVKnjvqEHl3L5gEt2Nv8LfyLdbsxHP0qoFG
         /d7A==
X-Gm-Message-State: AOJu0YxeFbGsUwkr2ca20ITb93sZsheTGLjTqqDunrl8l4f3jY2R4LEj
	2+K4kWtvQaawnEkjUjUpSPcjGTjaulg5qa5RasZm2urAPI9ZlwU93EYghVfUf9CVrraW+++YjcY
	adZlFnOBQ+lhN4UUCCsIV1koKzhI4Jbs=
X-Gm-Gg: ASbGncvpUluVcq9EL/yDKHOpbksAxU718y114sJmEtS3FuvwheXJNHhvu5kE7QxmYfR
	j6HIlFvrg6wONC/w4VXGte2VGEiEgXly3ghzORVWF0VtQlGipDmPKejW4yw2lWFsGDfQOlybh/o
	Yg19UV4NHnMoWSyi7jnFm65vSLt4PpU8kkPOpUYHKfgqWaitzTPS99dzCHz5QIbV85LRm3AVqgw
	hWau4II
X-Google-Smtp-Source: AGHT+IExwi0L9CbXm3iuTEJUU3ZKD9YcdGSXZz5X3ytfvK54XI/i0JSaCP4BDsRoldnppbYnA5wX7dQUAuNpJBB2KAs=
X-Received: by 2002:a05:6871:521f:b0:31a:a3f2:f561 with SMTP id
 586e51a60fabf-33bb3ee7b22mr2004233fac.31.1758298945941; Fri, 19 Sep 2025
 09:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919142106.43527-1-acsjakub@amazon.de>
In-Reply-To: <20250919142106.43527-1-acsjakub@amazon.de>
From: Andrei Vagin <avagin@gmail.com>
Date: Fri, 19 Sep 2025 09:22:14 -0700
X-Gm-Features: AS18NWCw6i9bPS8OTVJYSNm_-cHQyTaqUgLBxnacQlZHln_Y9tAkHn8i9O5pwkU
Message-ID: <CANaxB-yAOhES6j6VJMDybAJJy8JEXM+ZB+ey4-=QVyLBeTYfrw@mail.gmail.com>
Subject: Re: [PATCH] fs/proc/task_mmu: check cur_buf for NULL
To: Jakub Acs <acsjakub@amazon.de>
Cc: linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jinjiang Tu <tujinjiang@huawei.com>, 
	Suren Baghdasaryan <surenb@google.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Muhammad Usama Anjum <usama.anjum@collabora.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 7:21=E2=80=AFAM Jakub Acs <acsjakub@amazon.de> wrot=
e:
>
> When PAGEMAP_SCAN ioctl invoked with vec_len =3D 0 reaches
> pagemap_scan_backout_range(), kernel panics with null-ptr-deref:
>
> [   44.936808] Oops: general protection fault, probably for non-canonical=
 address 0xdffffc0000000000: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> [   44.937797] KASAN: null-ptr-deref in range [0x0000000000000000-0x00000=
00000000007]
> [   44.938391] CPU: 1 UID: 0 PID: 2480 Comm: reproducer Not tainted 6.17.=
0-rc6 #22 PREEMPT(none)
> [   44.939062] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   44.939935] RIP: 0010:pagemap_scan_thp_entry.isra.0+0x741/0xa80
>
> <snip registers, unreliable trace>
>
> [   44.946828] Call Trace:
> [   44.947030]  <TASK>
> [   44.949219]  pagemap_scan_pmd_entry+0xec/0xfa0
> [   44.952593]  walk_pmd_range.isra.0+0x302/0x910
> [   44.954069]  walk_pud_range.isra.0+0x419/0x790
> [   44.954427]  walk_p4d_range+0x41e/0x620
> [   44.954743]  walk_pgd_range+0x31e/0x630
> [   44.955057]  __walk_page_range+0x160/0x670
> [   44.956883]  walk_page_range_mm+0x408/0x980
> [   44.958677]  walk_page_range+0x66/0x90
> [   44.958984]  do_pagemap_scan+0x28d/0x9c0
> [   44.961833]  do_pagemap_cmd+0x59/0x80
> [   44.962484]  __x64_sys_ioctl+0x18d/0x210
> [   44.962804]  do_syscall_64+0x5b/0x290
> [   44.963111]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> vec_len =3D 0 in pagemap_scan_init_bounce_buffer() means no buffers are
> allocated and p->vec_buf remains set to NULL.
>
> This breaks an assumption made later in pagemap_scan_backout_range(),
> that page_region is always allocated for p->vec_buf_index.
>
> Fix it by explicitly checking cur_buf for NULL before dereferencing.
>
> Other sites that might run into same deref-issue are already (directly
> or transitively) protected by checking p->vec_buf.
>
> Note:
> From PAGEMAP_SCAN man page, it seems vec_len =3D 0 is valid when no outpu=
t
> is requested and it's only the side effects caller is interested in,
> hence it passes check in pagemap_scan_get_args().
>
> This issue was found by syzkaller.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and option=
ally clear info about PTEs")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Jinjiang Tu <tujinjiang@huawei.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Penglei Jiang <superman.xpt@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: "Micha=C5=82 Miros=C5=82aw" <mirq-linux@rere.qmqm.pl>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> linux-kernel@vger.kernel.org
> linux-fsdevel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
>
> ---
>  fs/proc/task_mmu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 29cca0e6d0ff..8c10a8135e74 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2417,6 +2417,9 @@ static void pagemap_scan_backout_range(struct pagem=
ap_scan_private *p,
>  {
>         struct page_region *cur_buf =3D &p->vec_buf[p->vec_buf_index];
>
> +       if (!cur_buf)

I think it is better to check !p->vec_buf. I know that vec_buf_index is
always 0 in this case, so there is no functional difference, but the
!p->vec_buf is more readable/obvious.

Thanks,
Andrei

