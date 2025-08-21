Return-Path: <linux-fsdevel+bounces-58566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84670B2EB37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 04:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF255E6F11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFA9246786;
	Thu, 21 Aug 2025 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kuOuIegl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D60B244186
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743445; cv=none; b=o1hBgHgZr8iY3BRILo7hGtgIz9VpojjpqRouqaunZ89yxinWahHkTcXXixTG3p1mXys6pCAfMUApdG4Vy3SuP5yeHP8nzAGHUlRtzlcGpPYUtZY42rCj8Q7l1V8M9XykbWzCg2uE7Ox6FkBknE6pVuS/T9DRdNUP4k8NxUeLs3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743445; c=relaxed/simple;
	bh=02fqpgtmXVnZUvEZ4gXKpvgwB2e67UJkxB7WqjsBRcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kk6AGHdYOu6BfyiYQLmnQL77waVuEODXHIET9h058GpTiBRINholu8wpWV4eQATuzkUHL2RsopLi6DzZzdZqY3p8DcG5RLmLsV7rm+gtA03i8turAwBfuuHCjFIQR//qFXyR4m70x9MVcqL4jWJ8awGcxLZ8+JySwiaVfSkSFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kuOuIegl; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e93498d435cso518279276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755743442; x=1756348242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMION88G6TPbiFF7T9DSor/YV4Dhrggsi8E1Q94kAvM=;
        b=kuOuIeglY9D3SiBYMgeJ9y+wTzR9SEHyhhjNq2wchsR60nutnmDXXdhiOAJZ2Edft6
         05jI52cyjT7CEMpEPw8PHfLBgHHUDE6HWCPy6qNXotBAVF4H8YZKoxOhlCkyVm4a2L0i
         ohBL7Y3yst6ZfZTx9nzsg/iz/xGh70Y5WnGVbS4aicfr3Ob3mTwHIrswyeZFCxcLbSKu
         XS2O9+hyZk3MnKySi5Yny4zunB1UyRneaH2x6L1fDhDC7iszE7bgaZFn83gZzU8U7dCt
         EJUkyiciUtGXRMQtwfg3GNfoo8M470TL0rkDcmYxRGPCDyP3U7YWWFd6qjhwfupP264J
         Tgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755743442; x=1756348242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMION88G6TPbiFF7T9DSor/YV4Dhrggsi8E1Q94kAvM=;
        b=XcS8NokRF8PacquVYoZ4iVE82kAQEPBb2vQkwCgFLWINpxL+wVEVDJ2iEVG0LKCACr
         gNqTqMtmURJcMZJaA8PcGKHGzvA6G2flmn1tSr8up3k1V3OhC2fpgRdstG2q1uA0PIK0
         6uEmMsy/ZJpgQ7XIgxK29cwnDe1N3drNtFM9aeG6pSHtEl0KFXr1t/JQMdWb56zr5Y23
         iC4ccuqzdXgAhLECB1UWn1X8UMZ4NvEvhLST8HJ/YosnCAqovJOxM85zTXpm4navUXK9
         SBhlzRY74DgWMb1IiFO67U6eK001xgwpD9M3e4JzcgKRg8FFjCSVvHt9XkJRnxCtMz2g
         cqnQ==
X-Gm-Message-State: AOJu0YymkuGtMa97y12Ox5YkyHPDzfoioi4+J/u49P3PragRz81Ol/me
	Jicuy/gWKokBql1HERmtxzxd5CN4yIJX04SLE+szGNt+1LmmFgTTUyiocF9SrRioGE3Y8DI0D7i
	c7YLytS9i/zt2PZCgfYZ+ej6jfq+MBApiWJ7eZgCc1w==
X-Gm-Gg: ASbGncuu6eVLszP2Jhe1zd8H/Nh6eSRM/hGUDB79sxWhs9MCVHnWbyam0zf6zPDOTg1
	68PUBJsVPUqWFgGpsgA4m3DsepHRSC51wIP+uXhXZhtCv3fO1XI8U/cPCajMvd/87rzoDewRPLi
	8/f5JNiddRrZ0fdl2hROLgac5Cjp57wKebM8rGO9znjHEvnEgCD65LeU5YYqUxeyi4mjx5D9yEx
	dqYaG9rWwLRST/gakcDB+IS
X-Google-Smtp-Source: AGHT+IGHwdE1yoE0p0wXWL0FR3kNcqWuprB5S21pgTsnfmdOOr1XNkU1L5aco2yBQOW+mjqEWdEcfSMHAi8UfBwEZOE=
X-Received: by 2002:a05:6902:1208:b0:e94:ee5b:f698 with SMTP id
 3f1490d57ef6-e95088dc93emr1024460276.5.1755743442340; Wed, 20 Aug 2025
 19:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com> <aKY2-sTc5qQmdea4@slm.duckdns.org>
In-Reply-To: <aKY2-sTc5qQmdea4@slm.duckdns.org>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Thu, 21 Aug 2025 10:30:30 +0800
X-Gm-Features: Ac12FXwn16lFOJCh2AxH5JioHJPOSpdJ0y3PAE3Dn4f0kUvtBjLfueMmyBwUcXs
Message-ID: <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 4:58=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Aug 20, 2025 at 07:19:40PM +0800, Julian Sun wrote:
> > @@ -3912,8 +3921,12 @@ static void mem_cgroup_css_free(struct cgroup_su=
bsys_state *css)
> >       int __maybe_unused i;
> >
> >  #ifdef CONFIG_CGROUP_WRITEBACK
> > -     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
> > -             wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> > +     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> > +             struct wb_completion *done =3D memcg->cgwb_frn[i].done;
> > +
> > +             if (atomic_dec_and_test(&done->cnt))
> > +                     kfree(done);
> > +     }
> >  #endif
>
> Can't you just remove done? I don't think it's doing anything after your
> changes anyway.

Thanks for your review.

AFAICT done is also used to track free slots in
mem_cgroup_track_foreign_dirty_slowpath() and
mem_cgroup_flush_foreign(), otherwise we have no method to know which
one is free and might flush more than what MEMCG_CGWB_FRN_CNT allow.

Am I missing something?

Thanks,
>
> Thanks.
>
> --
> tejun

