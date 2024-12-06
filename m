Return-Path: <linux-fsdevel+bounces-36606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CF59E66F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 06:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4408D1884D18
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 05:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5A3198A39;
	Fri,  6 Dec 2024 05:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu5aOwi8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE09196C6C
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463573; cv=none; b=rQP3lvFPX9WGgJ9v5Icn5z5Ig5KKjsFaq9eEhN2D4j8F4eUeF2OqKI4sXRtEP8E4zhRztuLgSQHLLOGAkETbDKQxC8FwRDUKgq8fXj85oUKE3cHA7w5q12NFXcPtR/KkwYrWMjjLKDyUHVeUiLDQWM2ENOWR8E4xieEGD+FoaFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463573; c=relaxed/simple;
	bh=yh8QahYVf+iuYpEWfLmJQpp6cLg8k/jJ7I00d8UqlV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkIgwX+7hJjVw4WCJ215bSu22Jr10c24/WmsX6KGT6NqS5c4LTsEH6883XdZaVggaCYRdpzrSdGkln1EL8SfwzwJ6dLJgzpd9ChSuyHghxGdqqVuv6rVpOhLKKAYYQJRxcxlvnlMnceumve2osrxv2Q5lh35crvGGtLxvj37CIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gu5aOwi8; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8a3e99e32so15023006d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 21:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733463569; x=1734068369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1UVn7wGFmECPF2lNGZ84JYvzvAH/5Lwkzha/A+P6gc=;
        b=Gu5aOwi830kPjXDxR8/L/DhDtQWqgR7dFyVTiDnK5KJcZpAxd9pZ/SyeDff1XLvtnK
         HQBFMcVZ7tfWCRdSbwxP7MtUbZD5PDBmCC/YLMMSuU7Mb5Y4fLm5ZosKHMJCc/0wIkBc
         leZejDxhvHdqr7/shln5iQDWW1pxhAFpvg/ZGT8E8Q/azSdRz1JwQO7NZmDUARrpReIH
         bWLS4ieHIKElCj2WhXAWdo3hhiD90CWYYzcwBlnO4MIGReNfMIHwqPg6/DihUmthr4kj
         gNHpI1naQivecgVOfDcS1YtQNrG3mwJfcYhPxlNdcTdz8Z9GQ0HGxnBQs3Aep/y51uEz
         slNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733463569; x=1734068369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1UVn7wGFmECPF2lNGZ84JYvzvAH/5Lwkzha/A+P6gc=;
        b=GNVQvkw11Z9cjLe4pDDK1EzqPSl4WMEzJLf7TUC7vfSx+pvoiRcM6ixET0vLmG+rSk
         oWTqChvBpuMDxbuoIk6hao5fKZzbjL7c/Kicwi4nrlyy0kk2gg+MffIkiLLFLnu4ZPxv
         TXhxKOwq/AA8M95/tMX1cTnlswtzSDETWlbwcSw8J9yLt+x230OHKSXmSe6bk4cBJiNy
         TjiXt5kmhkxnlb075rswXlnJsMBZpML1hxXqYQGlOSr6x6ttSO10kZeYTgrJ6e3lKhdV
         txO+xqacJbnVG68NWGATBP9BBSZcf5sFzbQ5NqtoFAn5vxbxQwBhRIeslgkMzkXkSL1B
         Mzuw==
X-Forwarded-Encrypted: i=1; AJvYcCXW4UEq8m45SsXdMAIB9l2gVYVrfHDYuTfvRCnrqfqxUZMLDR1Dzj4onlKTHN+QQ5uHIyUQOkZJbhe+dbuu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+0LGC3J1miV8TBNA7xJYijptrXvH+5RHi7640qCcHeAMjD9Dw
	2FSXM3Y0N4dUNu1NIgCuHeaR8qvonfrufiv/r+SMoZ8ni1yjouo7fKFP0XNod5v6gg8VRhepscB
	8/tWm0CywMg/3n3etFVrekP9gWTo=
X-Gm-Gg: ASbGnctOMxs+p0fgeLP33H7ohDZjHX8HvWF/la9sFRe0D3CNzK3/AmsGIv3qF3aM+Lc
	kzGGjBMqoBCdi9GDhA5aw7idu3ZiAj3LpQA==
X-Google-Smtp-Source: AGHT+IEspmmFXD1CBuAp6TP0iqvhJQ+EhlurQHA2WeBZbn3qlyvkG1cL6PVLnrmpXxWRK3cuL+Gp946nsTWoaQP8rSQ=
X-Received: by 2002:a05:6214:4003:b0:6d8:97ea:4362 with SMTP id
 6a1803df08f44-6d8e71fefe5mr24912836d6.38.1733463569030; Thu, 05 Dec 2024
 21:39:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411292300.61edbd37-lkp@intel.com> <CALOAHbABe2DFLWboZ7KF-=d643keJYBx0Es=+aF-J=GxqLXHAA@mail.gmail.com>
 <Z051LzN/qkrHrAMh@xsang-OptiPlex-9020> <CALOAHbDq8yBuCEMsoL=Xr+_QHQ39-=XHK+PEN5KxncxmL=nhYw@mail.gmail.com>
 <Z1Jg+vcpFKGSfx25@xsang-OptiPlex-9020>
In-Reply-To: <Z1Jg+vcpFKGSfx25@xsang-OptiPlex-9020>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 6 Dec 2024 13:38:53 +0800
Message-ID: <CALOAHbCXx_sQqpVMS0Z1B+dkGMHL3vAPBT_1udRRy-0ivy3FKw@mail.gmail.com>
Subject: Re: [linux-next:master] [mm/readahead] 13da30d6f9: BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:27=E2=80=AFAM Oliver Sang <oliver.sang@intel.com>=
 wrote:
>
> hi, Yafang,
>
> On Tue, Dec 03, 2024 at 05:33:16PM +0800, Yafang Shao wrote:
> > On Tue, Dec 3, 2024 at 11:04=E2=80=AFAM Oliver Sang <oliver.sang@intel.=
com> wrote:
> > >
> > > hi, Yafang,
> > >
> > > On Tue, Dec 03, 2024 at 10:14:50AM +0800, Yafang Shao wrote:
> > > > On Fri, Nov 29, 2024 at 11:19=E2=80=AFPM kernel test robot
> > > > <oliver.sang@intel.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > Hello,
> > > > >
> > > > > kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![usem=
em:#]" on:
> > > > >
> > > > > commit: 13da30d6f9150dff876f94a3f32d555e484ad04f ("mm/readahead: =
fix large folio support in async readahead")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git =
master
> > > > >
> > > > > [test failed on linux-next/master cfba9f07a1d6aeca38f47f1f472cfb0=
ba133d341]
> > > > >
> > > > > in testcase: vm-scalability
> > > > > version: vm-scalability-x86_64-6f4ef16-0_20241103
> > > > > with following parameters:
> > > > >
> > > > >         runtime: 300s
> > > > >         test: mmap-xread-seq-mt
> > > > >         cpufreq_governor: performance
> > > > >
> > > > >
> > > > >
> > > > > config: x86_64-rhel-9.4
> > > > > compiler: gcc-12
> > > > > test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 838=
0H CPU @ 2.90GHz (Cooper Lake) with 192G memory
> > > > >
> > > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > > >
> > > > >
> > > > >
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a =
new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > | Closes: https://lore.kernel.org/oe-lkp/202411292300.61edbd37-lk=
p@intel.com
> > > > >
> > > > >
> > >
> > > [...]
> > >
> > > >
> > > > Is this issue consistently reproducible?
> > > > I attempted to reproduce it using the mmap-xread-seq-mt test case b=
ut
> > > > was unsuccessful.
> > >
> > > in our tests, the issue is quite persistent. as below, 100% reproduce=
d in all
> > > 8 runs, keeps clean on parent.
> > >
> > > d1aa0c04294e2988 13da30d6f9150dff876f94a3f32
> > > ---------------- ---------------------------
> > >        fail:runs  %reproduction    fail:runs
> > >            |             |             |
> > >            :8          100%           8:8     dmesg.BUG:soft_lockup-C=
PU##stuck_for#s![usemem:#]
> > >            :8          100%           8:8     dmesg.Kernel_panic-not_=
syncing:softlockup:hung_tasks
> > >
> > > to avoid any env issue, we rebuild kernel and rerun more to check. if=
 still
> > > consistently reproduced, we will follow your further requests. thanks
> >
> > Although I=E2=80=99ve made extensive attempts, I haven=E2=80=99t been a=
ble to
> > reproduce the issue. My best guess is that, in the non-MADV_HUGEPAGE
> > case, ra->size might be increasing to an unexpectedly large value. If
> > that=E2=80=99s the case, I believe the issue can be resolved with the
> > following additional change:
> >
> > diff --git a/mm/readahead.c b/mm/readahead.c
> > index 9b8a48e736c6..e30132bc2593 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -385,8 +385,6 @@ static unsigned long get_next_ra_size(struct
> > file_ra_state *ra,
> >                 return 4 * cur;
> >         if (cur <=3D max / 2)
> >                 return 2 * cur;
> > -       if (cur > max)
> > -               return cur;
> >         return max;
> >  }
> >
> > @@ -644,7 +642,11 @@ void page_cache_async_ra(struct readahead_control =
*ractl,
> >                         1UL << order);
> >         if (index =3D=3D expected) {
> >                 ra->start +=3D ra->size;
> > -               ra->size =3D get_next_ra_size(ra, max_pages);
> > +               /*
> > +                * For the MADV_HUGEPAGE case, the ra->size might be la=
rger than
> > +                * the max_pages.
> > +                */
> > +               ra->size =3D max(ra->size, get_next_ra_size(ra, max_pag=
es));
> >                 ra->async_size =3D ra->size;
> >                 goto readit;
> >         }
> >
> > Could you please test this if you can consistently reproduce the bug?
>
> by this patch, we confirmed the issue gone on both platforms.
>
> Tested-by: kernel test robot <oliver.sang@intel.com>

Great! Thanks for your work. I'll send a new version.


--
Regards
Yafang

