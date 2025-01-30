Return-Path: <linux-fsdevel+bounces-40417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BD8A23340
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 18:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985FA1883873
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965811F03D3;
	Thu, 30 Jan 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAXsUcpb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A6B1EF0A1;
	Thu, 30 Jan 2025 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258806; cv=none; b=QS8VxvbPZe+LeD4bt+MgcoaDg6LYcAfluuBjL21kYKOHFVVFKl1UMJuVsCTTNm8rlHXOo8IU3pHRnliJ0hCFE1bIiB8IbsOnVQ1ubrYDy786/didXD6IikASIzh8RERx2IOYGItG7vq1pHulvXA/U+GjMefjREQ1H/CGGIDiZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258806; c=relaxed/simple;
	bh=fOyS2SgUQBtaRtcTvGzojZKstYzn/7x6VS/0J+NwWk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQkaCsfyfInoRQV809cZGtJmrfh6GFRgc4FqXGJCOPfqix6+vQ6vvBTPyoFuGKhu2n2tN3vim5ME45BD9fzOI+nZIKmwdDtDfOttEAeXgVPye0OvhGcqhnYnVzRajZi3EoEiWvBrzMs2H+WvR4pH2smoOEpFjYaTyDc+kynq4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAXsUcpb; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46785fbb949so11733711cf.3;
        Thu, 30 Jan 2025 09:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738258803; x=1738863603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOyS2SgUQBtaRtcTvGzojZKstYzn/7x6VS/0J+NwWk4=;
        b=gAXsUcpbB5/gIZxCpCL7g0uzUd++ACA/TNH8RcUa6dLivjE/lnfbeJPW6WdshCsju2
         97M1pNtCgAPBtpV/bVg0cgeHdOUl32zhAdDSAJ81v1u1KpBHFBdxmhdNiH4z76dPPx8C
         yL3kUZWcMebPUITyJ0y7h50YeQj2FheCFhHuDmM9zzrf+CRXqsNo+fQkTNUPZ+BmeU/a
         3J5NZf5iJFynDbjNN2YHZrCIf6FBCcFwgsphZmYkHXoNiJoxRxF1H4tEX4eCP+JYIfiW
         ko03sJlyHj4nc8OpgjiTHDkWy9aEHEnTI8h+znPw4ztQJvnv5UmAwX+j2EAZuB+OvgPX
         oLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738258803; x=1738863603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOyS2SgUQBtaRtcTvGzojZKstYzn/7x6VS/0J+NwWk4=;
        b=Rw/iR9AKRxlpxWRiYC5LIxvCm1nKzvzk/cr3J5B2p3/tBa3olWtNEf/fQWeZG3sVeZ
         ur68kckwyXoN6wYyGRLYoJk9UafkcDG34reCLAQD6n6O4wanU631oEbUkLtjCV3fEy02
         3XJX8U4ZhdN3piQOM3qyWkVI+zh/0Y+fzMaXWK9FBHgT0/oLcYZH7wNF1A4NCu3OA9c/
         GKjKOFslcrGWD+y99WJzq2wauASdI7MA9Zyoh1OlYgGPYU+aAfjyVle8IDs4y5XGiO/p
         IJKESwTNrE2b0O5R2guyCj9YELQcxa9R7GEzH4lairhWADhtbP6ONv3RWUsWuoQyXIpe
         An9g==
X-Forwarded-Encrypted: i=1; AJvYcCWFBACDpCUD0OBrEBh2As3kHI8pb2Pc5PKQH45jo/eh1lSP72JY17AHxXBz8H481UWCmUHUkyG0HNGpq9OE@vger.kernel.org, AJvYcCWi1CeKAvtAY1BO/CP7aWFd5aVAhwd1tW4bYOj6IR/aRtr130umAROeI2bFdroNnNK2CZRQsV3B9QuqIw4N5tL9UTmw@vger.kernel.org, AJvYcCXRZtW63KF6smfpHjOGFp/3BozC1UN7tMwwKudvXNAi/W7Nm3h0dgpylW2YkGdSYd63uR1sLbHNhRIVPVFG@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+0KTepwVoCa9tQAMQRzIkxY2qxo1gZPb8DGRF4qD9hUyCjRY
	5K/QywBw4IB4hUXt20aOieNImVLJj1OCjCUCpBy/DBici11BODGhF0Ho0cdV6w7jQ5tpxTl1N4z
	CL1BTmQcxIuSOTEG9cCSS/11pb9I=
X-Gm-Gg: ASbGncuLQ99+rkHnsVkHpHPQNy0f03rMS22Rj82yXE/lbG5MoTiDw5VMFZFlYVqq7Ds
	a8AgYrC4GJg+W5wfkByDKV4nKRmOPOvypOLIB3PMr8JHGWxZTK6SZeKAGoNsFafLebCP9oUG7gZ
	W+hj597PKugeOs3ENMU2K1LhX3saIF
X-Google-Smtp-Source: AGHT+IE6pqda5eKDzRAyzpwontPmN7eYd0zcmoX6OYSqt3IrbDhFMaTFRiKg3Ru2dzaKD+7BQ6lfXTG07MedePcTXtg=
X-Received: by 2002:a05:6214:1310:b0:6e1:a51d:e96f with SMTP id
 6a1803df08f44-6e243bef7cemr117873546d6.8.1738258803328; Thu, 30 Jan 2025
 09:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com> <20250130100050.1868208-5-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250130100050.1868208-5-kirill.shutemov@linux.intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 30 Jan 2025 09:39:52 -0800
X-Gm-Features: AWEUYZnhGHhGD14z9UZ4qeG3B1M4JKsk80YTUhLoPK-rRv81OyfD8wOiyVhXCtw
Message-ID: <CAKEwX=POeBSHBXxdNWua5cPJ=7+P6x4qG6gWgN0HnT2K+_ULtQ@mail.gmail.com>
Subject: Re: [PATCHv3 04/11] mm/zswap: Use PG_dropbehind instead of PG_reclaim
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Airlie <airlied@gmail.com>, David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Oscar Salvador <osalvador@suse.de>, 
	Ran Xiaokai <ran.xiaokai@zte.com.cn>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Simona Vetter <simona@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 2:02=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> The recently introduced PG_dropbehind allows for freeing folios
> immediately after writeback. Unlike PG_reclaim, it does not need vmscan
> to be involved to get the folio freed.

Neat!

>
> Instead of using folio_set_reclaim(), use folio_set_dropbehind() in
> zswap_writeback_entry().
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Nhat Pham <nphamcs@gmail.com>

