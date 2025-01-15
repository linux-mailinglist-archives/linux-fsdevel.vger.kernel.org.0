Return-Path: <linux-fsdevel+bounces-39332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52542A12CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 21:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619271883323
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 20:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D2B1DA309;
	Wed, 15 Jan 2025 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVh7bpVF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89F1D935A
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973830; cv=none; b=eNnLsNi/sU4KXru8usjjK4y6ZBERVhJ7S5j+6vniA+afqSZJpbaupS4gNo8FkIYgLvjeRg/5DglGvuBGmIj+kwnxc9ChOzUgpRvOVy3R/JmrHsqEkOuWGPJSfqGl4CC6pHGw+L1Afar8Sy4oqkSFoKWZCoApwvGEi5VvD+Sfqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973830; c=relaxed/simple;
	bh=DmN+bSaJrXFtcRNihUwnk0h3safybjPC3LRXiDGWxb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/SZYRRVfYakGRWiCoC2EAMiLLIRUQ1JauTjN+hbeo20aARs7+1i8FH6tG9uYUZhnPDphdpUyqd2VWWEwHu+OGcKZS7dKCr8MaLYRqtZXae6D3h4y4pksVvo1Vl84UYMO0/jS89AJh3gTj9TLhjqYuviQ/jc8xSyO0frn5vwwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVh7bpVF; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85c5a913cffso93308241.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 12:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736973827; x=1737578627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmN+bSaJrXFtcRNihUwnk0h3safybjPC3LRXiDGWxb8=;
        b=SVh7bpVFoIsFKb9kpG2Pe8BhY8YLfrRU7Nc8si8TJwA6Zy3mq9GENmR/N0zsNj0mFn
         nzwg79K5LFyFyCg/vDCZC+JBvnpAGpEh0QMxJg4Ig4ThH4oO17Ud2EUi3c4aV3M1R2lh
         0MWlEHNQkeT9jDSiKCPGhkPtIf2WT1XLbXhS9xs5qmBC0TUpDOevY6ZSM34UBJ/B9QA1
         w9hnb4AnyP/CjM0LZ/ZlfkgLiNOthJV1RAUR8mj58z1xul0F772cUr/s93lqSBEIwB45
         qSIo2E+ZmBQrDDEsVKU5dS65Z0HZGWeL+5N59pTZd/3JQqkKUMvxOTDNBqbj7np/x++q
         zkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736973827; x=1737578627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmN+bSaJrXFtcRNihUwnk0h3safybjPC3LRXiDGWxb8=;
        b=aIPM6qAucQ8x5VPoM0SPajQ5vQMdy2SJMZ79vVNPVjO0i2U5l4yCaAVkLjsEwGh0JL
         Vn81yEtqRD7ocVdyvEb8b2xclX4F7lFSI7JQOjndOTnritb1nJ3bE30htypuDtk2Nxet
         HSnb5g9KjHJihgvpvzGnvU5Oy55Yj9rWntgGwfyd2uvUKkMIPtjZldF4wJMoAHJKAvLw
         mTMk0sgJ2ZoLQdqBplhKdvHMBDSDD6V+Z/HdHH+VKaOsTntqO/m9d8PI/c2aUCXp6S2B
         Tk378zPtCC/QIXQDkqSp0Q6nMjrUisEAWBeEiQXNsc2RrdLDpfRpgDxwhlI2/4hI3P65
         E08A==
X-Forwarded-Encrypted: i=1; AJvYcCUPmEl2K5C6XuqvJDdp0Sn7ERwDT/Ngw1A9Q1yOoVU6lfUc83kVpk23MrymsJUDFmrcFO2VPNl6kCEmKr6d@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3S7E5wTOKsq9LiExW0Qay+rGQYkmTvxrIupeQYjik2H6zSTv
	KXovIgUQo+cUzsdz92f36mbiZT59tIIDvvg4uAycQKrYZJ02Q7tBkCcPJFBB9VfmsUxQldx0+eL
	C5Sfjr2/H/0xpix5azjPl3kroIYB+6rttUTc9
X-Gm-Gg: ASbGnctx85148pE5H1wPbPV8l6iqlsPIHvlliFadBTLnhUDbV0nyAQ/Q4kCexog5b0y
	Vt20VbWML8lC3qRLRMvb7mKmsauUMT00d7gpeXVek+VaPc8JuNA2ktdKZJsRlyWW3HM0E
X-Google-Smtp-Source: AGHT+IGi0hs5f6CvB2IN226MXTm0Ra44UaWAgyGn2Hb2ZqR78sF/nuVzUSwuhQqEnx/3viOFB5AlpGvLLyrmeG3geiE=
X-Received: by 2002:a05:6102:26c7:b0:4b1:1a24:e19c with SMTP id
 ada2fe7eead31-4b3d0d9f91emr28490986137.7.1736973827247; Wed, 15 Jan 2025
 12:43:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com> <20250115093135.3288234-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250115093135.3288234-6-kirill.shutemov@linux.intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 15 Jan 2025 13:43:10 -0700
X-Gm-Features: AbW1kvZhKsd-4bholfmYoUBqn5JymeZ06XAaCDHVg7uCmb3oxbCKX29QDQ6N-Rk
Message-ID: <CAOUHufa1vRhiwCNvVa+ztcrFix9keAgbV0E7BxFN9VKAZ+7Z5A@mail.gmail.com>
Subject: Re: [PATCHv2 05/11] mm/truncate: Use folio_set_dropbehind() instead
 of deactivate_file_folio()
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
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 2:32=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> The recently introduced PG_dropbehind allows for freeing folios
> immediately after writeback. Unlike PG_reclaim, it does not need vmscan
> to be involved to get the folio freed.
>
> The new flag allows to replace whole deactivate_file_folio() machinery
> with simple folio_set_dropbehind().
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yu Zhao <yuzhao@google.com>

