Return-Path: <linux-fsdevel+bounces-53808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C30AF78A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 16:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28ADE1CA090B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76512ED17E;
	Thu,  3 Jul 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXCos5Wk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE3126BFF;
	Thu,  3 Jul 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554225; cv=none; b=BIG2qIk6AnYhU7i0yNaJgG934tA2kPGumkQK9jSS8QwXy7AMQcnlkK+LuBjxKMwDBoWel/A8vgaCO3m07uFqTDZViZnnnLJerNZKAO39MmSMziHSIPsdTaY4ezMM/US4JGPWraUC8eOf8P7QU92w5deqUdMd+0eaHIhB31m/9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554225; c=relaxed/simple;
	bh=wAu0Srl3KlrnuOT7XKfRmg7X9fvoPiPkkGiyEdQ4yjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7ol+aHT38OZOczjTXFOBN52P8rjoEHx1QSC14z+4CFmmAR7V7cpo/om9z/7oZ3rpSNP/ucX98y3wdjexuDP9Ocfg+dmME1ft4BnKZSivS3A0QpL8jln6BjfYgdgNI7m4jK6sjXX/q4m/WofZHkOdpZJ1jDtk3ljePoOouZfY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXCos5Wk; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so95093996d6.3;
        Thu, 03 Jul 2025 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751554222; x=1752159022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAu0Srl3KlrnuOT7XKfRmg7X9fvoPiPkkGiyEdQ4yjw=;
        b=NXCos5Wk4jvJPPIGntAKmdZtpiymu1+RKsOOIPmfV1FbwTvQ+ow/8BHGg7ADXKHM7U
         SRA+yu12jnbaxJGgwUEHKMQQOasB2nFOzjnaO6fJO0lX2wrHOK7kEJngHD+B9WdUweaA
         vTOtFZ/lhITBf2Y6RGNiQxChDl8qBGJxC6iruHED4Rr1tLj0ZCMLJG5F2uv85qn/eYxY
         gKdjzjrxo3Ep2vXOrgajnCmSdNAkPboPGrCSkIscZtxiCFDBzmoqySKuYU7smUkb5WeY
         C7mGtV5X2ne/BG0su3pIEXXrGNF2/GUcbKm1SXUFaeAN3jAzwbriYy7l06pT8h0EBm2m
         CPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751554222; x=1752159022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAu0Srl3KlrnuOT7XKfRmg7X9fvoPiPkkGiyEdQ4yjw=;
        b=EufkUfSb+EZ8IdWq85H4rLadOyKvbyw0U27UHXylumM2XOPTc95Pas6APc1v5ov0yD
         6T0LmnAsUpYp8CnxzTXViSBFhZevWJQxprKT+dV8chmOntoKy/FsmXaFW/8YoM5tx29b
         TvnUOHVVrCldSZSxDYYfgZDeoxnUxzu+/qQtaB1GgDJayeAGCMf1+aaYO/Hij6dJgdnv
         uEHGprjyEqCOQVcq9cDiOCzh4ck2EXzNKA4nC03dQflpT3jn5dosR/wuHGOSn+iuMf/5
         ZsHNZuCJ5Xkm8TffMec8FmdtpBeEKXI8mI90KrI868xNC7BFlQQg+9JpiU3zNgOVvAwH
         YLjg==
X-Forwarded-Encrypted: i=1; AJvYcCWGDiGnc2GFx3XOHW/moCQUtOda7nflhEQJBZONLRDLMJEEW1bNBiKEvcOc73+s+ZmpBYXm5JbJpbrLhb/F@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFXGDkoSDGJZtTRtsfZTXoGWgbWRtRpksFx4GC5C6PIu8OUwz
	JGDxqzIFmlpn3+WL43Z+AAjg+YukNvVfslOriz5LuCOkb5lSxuy8qOs2Q21BarhEqb6cFrkMoff
	AcwMoDCk6FuMmu9vX31/3IR2E7ID9TIU=
X-Gm-Gg: ASbGncv9nPYWRT5JKYJfR7yRZ1S+XsBjPGP49HA8Zv1ZR6kk6c69G0jK5/rmP4WaeNN
	dh3QizctqcqWrtUdtQfxdJZpFIMiLIBFzTYk479KnT/kHTcf2RMJvJc59xo2MrDcHFlB4ao7EFH
	PdCEzpO6ZP6QY/QveuCu2BHQsoDvSNocWI3zHi+OCGIDZxroc=
X-Google-Smtp-Source: AGHT+IHam6lHXqujRmliCd8fP53JY0cmIKecpqja2QUPkFqqfyOqhuHsgnCtrvS2/8TMwwLErUkaLQ0u6woBONIJHz8=
X-Received: by 2002:ad4:5966:0:b0:6ff:16da:ae22 with SMTP id
 6a1803df08f44-702bc8c8946mr56172046d6.17.1751554222280; Thu, 03 Jul 2025
 07:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617154345.2494405-1-david@redhat.com> <20250617154345.2494405-2-david@redhat.com>
In-Reply-To: <20250617154345.2494405-2-david@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 3 Jul 2025 22:50:09 +0800
X-Gm-Features: Ac12FXy9pobZ-Tyl0lhkLRCeovsWyWwet9l7NdvI0FrXp3EdnqPiHRcREj1ytcE
Message-ID: <CABzRoyaea-qmw4JsA85H4QgRAEPPXWKuq2z2Bi41hEXMKifnjg@mail.gmail.com>
Subject: Re: [PATCH RFC 01/14] mm/memory: drop highest_memmap_pfn sanity check
 in vm_normal_page()
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, nvdimm@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Dan Williams <dan.j.williams@intel.com>, 
	Alistair Popple <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 11:44=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> In 2009, we converted a VM_BUG_ON(!pfn_valid(pfn)) to the current
> highest_memmap_pfn sanity check in commit 22b31eec63e5 ("badpage:
> vm_normal_page use print_bad_pte"), because highest_memmap_pfn was
> readily available.
>
> Nowadays, this is the last remaining highest_memmap_pfn user, and this
> sanity check is not really triggering ... frequently.
>
> Let's convert it to VM_WARN_ON_ONCE(!pfn_valid(pfn)), so we can
> simplify and get rid of highest_memmap_pfn. Checking for
> pfn_to_online_page() might be even better, but it would not handle
> ZONE_DEVICE properly.
>
> Do the same in vm_normal_page_pmd(), where we don't even report a
> problem at all ...
>
> What might be better in the future is having a runtime option like
> page-table-check to enable such checks dynamically on-demand. Something
> for the future.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM. Feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>

Thanks,
Lance

