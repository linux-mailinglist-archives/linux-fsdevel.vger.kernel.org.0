Return-Path: <linux-fsdevel+bounces-33017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 926829B1915
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 17:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A4F28290C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F55A39FE5;
	Sat, 26 Oct 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QcNiFeI0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BE1C32
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Oct 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729956405; cv=none; b=nbaTLyaOyggLcMIh1knKVvt00uj3zpcTxNaIe69aYN9fQNBdfLL0a50PRBE/+ioN0A9VbS9jeQJyAP6ga0fJo2J4vOlpG6g84S1PCT24qFqqOYpFBAikqFI3+AfFDixDe9WrIgYtufguNW36kjZXNW3lUyRf6Lb/HFoNQUZ2JQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729956405; c=relaxed/simple;
	bh=j+TOt+oBoXAXIref9ySAzCU2ABgXyfapBlEIF4iWO1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BB2qas+LmzMTdUFr5BFatZr93X1rd0Y7NMixWjVtnJwOIrkC+dFU2d6pV8u6yUIXOX9U017j7kZM0R3kmJ1v+dUmA3lenKma0zvl3BVfZzB1St5Yzywq0f6GY3xXYrsXqJ1OkcUWOTYRihcmxKBSpoPV2beUyHqlQNc7z43XYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QcNiFeI0; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4a5ad828a0fso931705137.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Oct 2024 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729956401; x=1730561201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xurp/dzSZiTxc3Q4P+xg6SJq6yioLcLs/RNUwkLIb8=;
        b=QcNiFeI0D+4/GuAlhGXHe9GX8KU08JRwuhTU2KTl9W5MsI5PXZE0hf5chrDmwO4UMr
         5NwN9HrHhG+XIdOOiGWJ15D/+Slyu2ROHE+SryvQgnk5qFU5L7Ljx6Vwkpft1b6NYWGs
         BX/qVMoX1t6hxO5F6HS7tC4/faBNjEpp73nEzZSlL89EbID9AIJDKUF9QtyTTDrKaS7y
         +nIe0QER7LmRaqnjHOGT/dV+taSPp45QW4eOVYtGQ3avFKFWU00pzBkpKmL3cYKltsAG
         BfQkFysK/Jpdcs+l2cSS9fXP52yz4Hgm8+AfPrmB6j+8BacHbVDrJfsY/znkKZPiBYEp
         yM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729956401; x=1730561201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xurp/dzSZiTxc3Q4P+xg6SJq6yioLcLs/RNUwkLIb8=;
        b=Yra8ZB67aIfnpyh0qxYR3rikCWa8sHROjZUVTp67vxAhvQlLiTShiWXEa430CpmZEj
         iJQQL8wNe/nt3gfXigK61D0KTTP9JsfjRhF15QnFsSs7RlwB4KdnJZNzjuMWuFrfnWuE
         AojSNP9v7nsNZsCD/lyFSf41zLmigoh1ITSp5/jCOxC1uJaQTT+0tG5xYrCVt4LxZ8iA
         lf2FHVpYaWC6xfizIw5O6OhuzLIEX5r1IkOyV6xjUZrZYtAGhDAoBeRzkRN8PhvVZOqO
         Ag4in7NleCKu0WUOif1mccbGysuhc+oKE2S+QXNfKPB7NYOVkED6vTSOicVeQ9EsBOQ+
         E7tA==
X-Forwarded-Encrypted: i=1; AJvYcCUi00gG+wDVwmTEr5rPUjQIofDrayE6amY6vs+2zNeGyNv1eZswfgQFbEG2yShRTmbQe8OT2O7UMDSRX84l@vger.kernel.org
X-Gm-Message-State: AOJu0YxExVJO1LRiHkBUiXHgcxBkSMbyEdtG+yXPhhUjl/UlwFRT59Gu
	3zH6iPJOxotnbKY4DW/+9yH4tE+YyNfdZhLNfrDlAtckA6Z/cNYcV0Dwf7BbKvV90ZhECPU9D7l
	7un/+pc9dFtFFcLtt2ZZOZDX1NiGz5oNQmhpZ
X-Google-Smtp-Source: AGHT+IErUT0EIQ3izExbmaeiykyMEE+HsZfO112pFWJqZp8vISP3bZ5byVVQr2RWeeWRFFt6XPR1QkksNOhNbda7Msk=
X-Received: by 2002:a05:6102:5112:b0:4a5:b0d3:cbbe with SMTP id
 ada2fe7eead31-4a8cfb27a5fmr2090677137.1.1729956401467; Sat, 26 Oct 2024
 08:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev> <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
In-Reply-To: <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 26 Oct 2024 09:26:04 -0600
Message-ID: <CAOUHufZexpg-m5rqJXUvkCh5nS6RqJYcaS9b=xra--pVnHctPA@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 12:34=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Thu, Oct 24, 2024 at 06:23:02PM GMT, Shakeel Butt wrote:
> > While updating the generation of the folios, MGLRU requires that the
> > folio's memcg association remains stable. With the charge migration
> > deprecated, there is no need for MGLRU to acquire locks to keep the
> > folio and memcg association stable.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>
> Andrew, can you please apply the following fix to this patch after your
> unused fixup?

Thanks!

> index fd7171658b63..b8b0e8fa1332 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3353,7 +3353,7 @@ static struct folio *get_pfn_folio(unsigned long pf=
n, struct mem_cgroup *memcg,
>         if (folio_nid(folio) !=3D pgdat->node_id)
>                 return NULL;
>
> -       if (folio_memcg_rcu(folio) !=3D memcg)
> +       if (folio_memcg(folio) !=3D memcg)
>                 return NULL;
>
>         /* file VMAs can contain anon pages from COW */
>
>

