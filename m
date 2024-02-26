Return-Path: <linux-fsdevel+bounces-12799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56369867519
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26031F253DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7EC7FBAF;
	Mon, 26 Feb 2024 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdmWH2sB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D17F7F8
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950887; cv=none; b=aaYCVShvbpVMyl2v7VCK6zLwdpq9GkASNUiYIqBx9CWKWMAkjg4OdAheAYinvHuEGVvPncCHCFJtXlGgg2VBx2UeT5UGlVC6VNxCabtb3hga8/tMMYYToY/b8NX6ACXvDstJlxJYYY5E9YofjU9nkRhYuq8hcNWM7CXbnNdaBc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950887; c=relaxed/simple;
	bh=IwOWGInh8O+XEgvvDmIgkM5v2LIb59AyFst2SKCN9RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URCixdvcc/3f4f5sAJjsb5Qrh847iyZj6mRZYRaYB6KPwGEGhfZe53aCuaArQWC6mqSuaJWMAL3gdiHmvTJ+X4SLrnxl8YR5J6jgp7tYu54Hrwva5qciQHemLG9ERkzo/hxJYsYItI+oW1X/iC0DEgk5kKNsCsTGGpfp255wUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdmWH2sB; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-781753f52afso192618285a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 04:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708950884; x=1709555684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GYXuW0S141vY9u9jWVu2+CyF0XW87te7rNLegsLKu8=;
        b=XdmWH2sBzN6gIbj79m0pa8bYqJ9g35EaOQdka3sWDwZq46dzagPQv0sU45vPDFRSJj
         /pnIkkA9BNtfZr2SwggeNqdX5mPNgAXjRNVW0lqGCL7DImQNnHgAq1ZqW25waJrdV8A9
         D8BD+pC5Hm3p6pwmodmfqMdaxosM7m5OFxrNHlShOo84BAf9RtUYbNH/GNvz3UaHjeX1
         cWTyE0GG+MilZSrOAWDaci40CyI0jW2myKhoFrdOmxafdSYVJl3PCcHHyV+y2gMJ8z5Q
         dI6+JgASKXNB41Q3X96CUrjT11ridytb0Owd7uO1LZfudq0KF74/ArAWaZEJilmHttiC
         8j6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708950884; x=1709555684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GYXuW0S141vY9u9jWVu2+CyF0XW87te7rNLegsLKu8=;
        b=YC+tkFqkkJx+PQpc0K+DxBPiu+/YbgqxCg8cXi4I+kUSUjO3AtoXoNYWS9BMvQxEB/
         xrUPYGiXlnSW3B0XWn6xrE/4/pdmVZGW7A1QaTHTBs0VeFxAcsRhFBlI3qqOrEyZobGR
         amtdd0Q1FJRVpMAtBqucsO9VtPq5rPcfV8t99mjPrkcjhZcT0FgGutL6XdCr4sl8VvUq
         wLJgedyGedHH/1Lfay+YiZ5TTfbPODxVeAHA0DkfrDh0QCSeJSK0sFBaIUMolIMYprsr
         RpqMqugU0EwXDM6KUUa8Z/8PzPYa6T5vceo3HJ+EgJym/GLiS2sro0YsHX7AojPZTpe5
         nrNg==
X-Forwarded-Encrypted: i=1; AJvYcCUDXKasdANUz+hszA6KUJpv+4V1Th+uGvfqsjPkEiPnvMSsn/8icwZaNXvQknQwn49cTDbgl9vSuPefmbYHHkOoajczpGBoAHUBK6j82Q==
X-Gm-Message-State: AOJu0YxE6Nk3NhGgBv+A40PfGQb+Wubv5wqaZpqGUQAS4KuSiw7yxSxZ
	EOfq9Izg5LTDVu4VbMzi8r5jV7Ne81Kl+k8NA9klMn1/Oc8YjzBFNpjzPpP7irwXPNnkjLl9WQi
	g8z+pPJTbSDezhYUWoEizLZpjG0S3Rh7SEugohYhzgls=
X-Google-Smtp-Source: AGHT+IExBjtf5VYOaTxnq5i5Kzn7N22HZ6tzwriBeK8kQENZLNjTBv9Wte/MFW70b+CNI7+fO81Gm4Yvas64gimCaxs=
X-Received: by 2002:a0c:f04e:0:b0:68f:f634:f1ed with SMTP id
 b14-20020a0cf04e000000b0068ff634f1edmr5299204qvl.55.1708950883981; Mon, 26
 Feb 2024 04:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225114204.50459-1-laoar.shao@gmail.com> <ZdwQ0JXPG4aFHxeg@casper.infradead.org>
In-Reply-To: <ZdwQ0JXPG4aFHxeg@casper.infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 26 Feb 2024 20:34:07 +0800
Message-ID: <CALOAHbCaBkqZ1Z9WJ_FqjTkzvCOv2X0iBv9D=M2hkuEO4-8AeQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Add reclaim type to memory.reclaim
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeelb@google.com, muchun.song@linux.dev, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 12:17=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Sun, Feb 25, 2024 at 07:42:04PM +0800, Yafang Shao wrote:
> > In our container environment, we've observed that certain containers ma=
y
> > accumulate more than 40GB of slabs, predominantly negative dentries. Th=
ese
> > negative dentries remain unreclaimed unless there is memory pressure. E=
ven
> > after the containers exit, these negative dentries persist. To manage d=
isk
> > storage efficiently, we employ an agent that identifies container image=
s
> > eligible for destruction once all instances of that image exit.
>
> I understand why you've written this patch, but we really do need to fix
> this for non-container workloads.  See also:
>
> https://lore.kernel.org/all/20220402072103.5140-1-hdanton@sina.com/
>
> https://lore.kernel.org/linux-fsdevel/1611235185-1685-1-git-send-email-ga=
utham.ananthakrishna@oracle.com/
>
> https://lore.kernel.org/all/YjDvRPuxPN0GsxLB@casper.infradead.org/
>
> I'm sure theer have been many other threads on this over the years.

Thank you for sharing your insights. I've reviewed the proposals and
related discussions. It appears that a consensus has not yet been
reached on how to tackle the issue. While I may not fully comprehend
all aspects of the discussions, it seems that the challenges stemming
from slab shrinking can be distilled into four key questions:

- When should the shrinker be triggered?
- Which task is responsible for performing the shrinking?
- Which slab should be reclaimed?
- How many slabs should be reclaimed?

Addressing all these questions within the kernel might introduce
unnecessary complexity. Instead, one potential approach could be to
extend the functionality of memory.reclaim or introduce a new
interface, such as memory.shrinker, and delegate decision-making to
userspace based on the workload. Since memory.reclaim is also
supported in the root memcg, it can effectively address issues outside
of container environments. Here's a rough idea, which needs
validation:

1. Expose detailed shrinker information via debugfs
We've already exposed details of the slab through
/sys/kernel/debug/slab, so extending this to include shrinker details
shouldn't be too challenging. For example, for the dentry shrinker, we
could expose /sys/kernel/debug/shrinker/super_cache_scan/{shrinker_id,
kmem_cache, ...}.

2. Shrink specific slabs with a specific count
This could be implemented by extending memory.reclaim with parameters
like "shrinker_id=3D" and "scan_count=3D". Currently, memory.reclaim is
byte-based, which isn't ideal for shrinkers due to the deferred
freeing of slabs. Using scan_count to specify the number of slabs to
reclaim could be more effective.

These are preliminary ideas, and I welcome any feedback.

Additionally, since this patch offers a straightforward solution to
address the issue in container environments, would it be feasible to
apply this patch initially?

--=20
Regards
Yafang

