Return-Path: <linux-fsdevel+bounces-58568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15444B2EB4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 04:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3907BAA2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667AC24DCE3;
	Thu, 21 Aug 2025 02:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FSbeAIC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C541D6DB6
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 02:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743870; cv=none; b=G4tcoj98lV3JaxJnYppX7AYKDwlMLPrL4HUXAgoCcXenwgPHPIpoP+RESfTc3ZHky5we6Ik7VDcFb7L0tEKzq9t1rb5GJS+GGpB8oGmLB5d66Y/BZCpQc86s1thQMtXrsdYZmk/eCeZgYN+fr93vaSPHOGT3ffLQ22K0OP68+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743870; c=relaxed/simple;
	bh=1fMxBcKPiSCdv73AYzPxutUiexFdNph38D46svR6vgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtGMvGID5HK/H6noS68dS277kxqJjdl4vOpdVdIwSxvY9NGfFc8oRIDmmgcb/S13MpPVENW9VWYO3szvSuZiET3ZT4sQDUfCJBVVi9cAZSkhPIPcJ989CyI6KMWdkIWKU4OMVSquIVUJ/c2iCRLiSVEBHofNzuA84sgt0QFSlrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FSbeAIC/; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e934b5476a0so545348276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 19:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755743867; x=1756348667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abh2xcvKhDlXl1t9fYOL5sKBFiJJIgTsOOzA5RbYIDk=;
        b=FSbeAIC/4NKN3xo40IjLRtooNBa518z1VGtmyS4mY4uUMZ6Z51DnXNQFDRVEibxbcI
         0LI27fdtw5DVsMfykgaVX87girRVHW00XFPj0d2H+IJ5QwLkU6lK837Wtl1HBTRN2iwe
         QYYR4kvTdOockqe96JYNzOfGkl4A0FwAnq95PuVgx14PiRCWSKITkMsgQEUJp/KaRwUE
         QXa0mDk2n8oUVJ4EOzPHgq/wuSOPNQOnaAF46vFtgZitFU1BtgOnASCUJh6Cm7+d4gL2
         E0v8ZxzZ75DAsjdL8hGyqyjeOeS67jJNXIVOE5n6/RKqRGWPpPhcyYtnQ2x1WhyOyMdU
         +yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755743867; x=1756348667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abh2xcvKhDlXl1t9fYOL5sKBFiJJIgTsOOzA5RbYIDk=;
        b=LLewK6y6puRhkkyKBDf6bmCVJgRWls/AXBlHll+kf/DXr6qHdKUcxoHenGSodK+wov
         Q38xNTM8F1vSDQoy6ru4Uhf9732dhq1yPa/hFu1+5QbLdF/NcFPv4U0IcgEiilMnPV7h
         w8qZ9zeh5N7a3BLUvgvAy9UtaxT6CG3ReVYnG/fYbts4XJvgz5JgD2Nbauv+xxgdo1sc
         uI2H5a9Pr6WgXkZEsJccwU4uoF9JK+6gPmCca0pz5nv8YqWES3hq16HdWJejckA3Fnmd
         lo+3D5tu/+ApzmONDDg6Aao5Fk+iVPTaYk/b1zGBt4L/wINmV0ZnDeNeqNmtwIFj4wJ1
         2Mfg==
X-Gm-Message-State: AOJu0Yw7ld1gYc3BsfcY6ySjhrnh+UjVIHfBF1sanAwfBJPC9n/IZ6dh
	oBYHMvydze3YhZaJJMCV3D1OG40n2CSESyASm8yDxsF4iXftrsv6LHcavjnuThbsn+n6ns01v/l
	xTPXlk8cfX997QYelhK0S3fZULxnD63Oyv+gN1knSKA==
X-Gm-Gg: ASbGncuza5x78e00x5ZImLNEwcaFnpCsSESsPbO+qDaQtvq4KxzstqqVVW5U5Lr9YZK
	Tcs3FEm4RJU2jcAhSJ64CGw9xrb3HnPhVn3+WEe0cUgOQo9SheSPVHWCZ2sPtV5SdJPdst17xHE
	PdpjkBao070s7QR0mI5p2zasEvOXRpoR+tspLQOg5TbzKJwkITQt51DbDKHoLmmaiZDQNl5yWc/
	zC9ty6zBsvELiRuMwbou4wK
X-Google-Smtp-Source: AGHT+IHCZNM4nTpXJUz1hJfdzdPWtXBh+kRu6t2ury4CxvcEnKPHsqTQn2/FJDN7atiu1mu07hpYTwH60fyZrCS/jtQ=
X-Received: by 2002:a05:6902:100e:b0:e93:3f08:86ea with SMTP id
 3f1490d57ef6-e95088e6681mr875780276.9.1755743866982; Wed, 20 Aug 2025
 19:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820111940.4105766-1-sunjunchao@bytedance.com> <24119aa3-f6ef-4467-80a0-475989e19625@gmail.com>
In-Reply-To: <24119aa3-f6ef-4467-80a0-475989e19625@gmail.com>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Thu, 21 Aug 2025 10:37:36 +0800
X-Gm-Features: Ac12FXyXvaqjw3gI0Ir1dBlPUBer24i_H2Sh9AFObdRH69tVXEonw0jQu0JZo9E
Message-ID: <CAHSKhtch+eT2ehQ5weRGEJwTj1sw0vo0_4Tu=bfBuSsHXGm3ZQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/3] memcg, writeback: Don't wait writeback completion
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, axboe@kernel.dk, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, thanks for your review.

On Wed, Aug 20, 2025 at 8:17=E2=80=AFPM Giorgi Tchankvetadze
<giorgitchankvetadze1997@gmail.com> wrote:
>
> Could we add wb_pending_pages to memory.events?
> Very cheap and useful.
> A single atomic counter is already kept internally; exposing it is one
> line in memcontrol.c plus one line in the ABI doc.

Not sure what do you mean by wb_pending_pages? Another counter besides
existing MEMCG_LOW MEMCG_HIGH MEMCG_MAX, etc.? And AFAIK there's no
pending pages in this patch set. Could you give more details?

Thanks,
>
>
> On 8/20/2025 3:19 PM, Julian Sun wrote:
> > This patch series aims to eliminate task hangs in mem_cgroup_css_free()
> > caused by calling wb_wait_for_completion().
> > This is because there may be a large number of writeback tasks in the
> > foreign memcg, involving millions of pages, and the situation is
> > exacerbated by WBT rate limiting=E2=80=94potentially leading to task ha=
ngs
> > lasting several hours.
> >
> > Patch 1 is preparatory work and involves no functional changes.
> > Patch 2 implements the automatic release of wb_completion.
> > Patch 3 removes wb_wait_for_completion() from mem_cgroup_css_free().
> >
> >
> > Julian Sun (3):
> >    writeback: Rename wb_writeback_work->auto_free to free_work.
> >    writeback: Add wb_writeback_work->free_done
> >    memcg: Don't wait writeback completion when release memcg.
> >
> >   fs/fs-writeback.c                | 22 ++++++++++++++--------
> >   include/linux/backing-dev-defs.h |  6 ++++++
> >   include/linux/memcontrol.h       |  2 +-
> >   mm/memcontrol.c                  | 29 ++++++++++++++++++++---------
> >   4 files changed, 41 insertions(+), 18 deletions(-)
> >
>

