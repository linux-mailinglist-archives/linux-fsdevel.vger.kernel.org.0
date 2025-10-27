Return-Path: <linux-fsdevel+bounces-65671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E1FC0C467
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 09:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C820D19A0455
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 08:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFFC2E7BB2;
	Mon, 27 Oct 2025 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4a5ss/L5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB31C6A3
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553259; cv=none; b=myM/l1ZwY3aVRRiKf527Nb1AqfjDvjN3h+36LTgJZiZ0L+TSkD+15E03AvCnU1MOxTac0QHEkhxLcYQe/ydmxiV5MBODnLgrCD73hGXnasGyX5Ba9c1zfIDLTsviI2NvEx8qk5vc5wF6kd9+8yG/yhwS+e3S3BZYE94EEDfXrRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553259; c=relaxed/simple;
	bh=ECPu/wJw4iKhTKTaEfb6pK0kQ1b8vXYUKnijBY/H8PY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D+Oms0L6gdLWw6UI71aw4cfESfsvIwKKF8I+DgdrlrrIfAyr53anE5ANJKTfzLcUp6qegtGfOctBOqZ6pT2rXYbYC4pJBZ5OLxt0MDic272EfVKGZ9OstupjMguYz07//5qeC6u/eQwSU3pB6rq+pdXGA3vBo7kUddtUzIzPUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4a5ss/L5; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63e17c0fefbso4644483d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761553256; x=1762158056; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8i9V9XN9hg6qjjGZ1kzhc0nrYJh0IgUWRXxrYjVsEk=;
        b=4a5ss/L5jfuk5NGsxlz/gxyVJjsWnDZCkd4cDJZn8nRADDjmAx5q+8HtXHLdB5yjHD
         b2LDLaCyppvh30NcPlROse9am4B7tjI8rfVixEpoqDNMz+Brr3eTGWXnon8/2461cjEq
         JgoNvO59BfbOkp4iqzzqxW1uFaLVJ4ZeXwmXZxrGhrrYbjrDwUv4TdDy4LQ3dNRpLuQA
         V1uB4WX8WNk85JGOpdSKAmAUcIvkyV/d2YU3LHRMdGUhdEn0WHOcj2gixoGDaVfDh47s
         C9JDBdL3BjIlzsTBq17JIx0DDgZFv7AUMASs5PR6JdstQM1l21zCCNtsrIssujIXsRA/
         lgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761553256; x=1762158056;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8i9V9XN9hg6qjjGZ1kzhc0nrYJh0IgUWRXxrYjVsEk=;
        b=AtV42gjRuE75r36NKGbyOTUgfNKDsOTzMNe/02bVK3QsCQfF4fN1cyq5h4uCM3TojM
         DVOeeJ+2l7wSaiyYAXchPWxzvAHhcNA7zD6HauGmo5NsI8O2yp92X1CMzr+0o/ShOJnZ
         MCd1VwxUsd+4vg2JQ+9IJTtooTw29X/q7Y5nG46LkM9AFWkyuvX0aRt2huGH2gMtviVr
         9tIH6LNyg+1eerkcOfuKx9Ka6426bssiOlgXIcdgcjhZKq4HFoAxsVgKzCpFHaE0vmSZ
         tw/GagYiqdbjGxjH4b3tp2Yuc/uFMyj2i32sQy+Xd0H2arWONXnA/dlI7Hoid2gaatvE
         XaCA==
X-Forwarded-Encrypted: i=1; AJvYcCV2SfMOSiNeyoy2sLxAkhCSw9QGZJT6cMVqM+Wup//EWk6OvcslF/HEAmbnI5Pa4ASJ2JjpSUfOBZoW+VoH@vger.kernel.org
X-Gm-Message-State: AOJu0YymDbQLCjvk7f9hTcy+ck2fE56GxJmNjhCDTstGfTpZM+yCbUJq
	1fOAOVlC7AiHi/drIPkrbtSjd5/Mv09Jf5MHzbpUODtpnM8t7fmiXvm6AbDFqMfXbg==
X-Gm-Gg: ASbGncsbwmvB8wYpOu39ZMwn/D+iSwN6qttsAotSAT4RSLyZj6oOzuX0X5mJHPxB5A8
	xpihBswPet8w85/yuo1kgxuw3kmUIUVr9sj9klloqfyDjZhT37ZOYPPVpfSmZyqi4eIDtWLFZ36
	Tvx8WIl/JJHUzZqWX8zYPF8r/ETjGlqwNYzPh/I9tq3l07iFJU8lTm+YsVmv+J9dUUgEyxfFQ6A
	QTNcgusasRnpJpcwFGgs99zztE1p3wbr74wfoTIIOnMJDTCiBeBeRvl0+z9bXOtncrKDA7FnfQf
	PXw9nzdyIzexBx+bgsa9QfCPqZsXI2s7OaiFvPCvLQbdW3Mv4zhb/YD6PRQ0aY9qUZWyJY7vntI
	ymCgeyJrv2msPZHLEm76aZTBsMFgH1A8AeTEwS+NkA76pwZBFMsj1EB2nPS4aB9s3wmdGfcbQiw
	dDaRJhu5w/Tvl+oDp2Yb3L9rdx7etLuDjDlrRVpMz51iR87+IMMO1TbUTmzgpQ
X-Google-Smtp-Source: AGHT+IEkrjgBL/rVFsJvctj6nF95xlm6ZoesSRoLMtXTNJL5ue1ifqY7ixGqz6500hmN62Bj943W/w==
X-Received: by 2002:a05:690e:258d:b0:63e:e3c:ea59 with SMTP id 956f58d0204a3-63f4357cd79mr6910825d50.56.1761553256284;
        Mon, 27 Oct 2025 01:20:56 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c3bc6e3sm2081958d50.3.2025.10.27.01.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:20:54 -0700 (PDT)
Date: Mon, 27 Oct 2025 01:20:42 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
In-Reply-To: <20251023093251.54146-2-kirill@shutemov.name>
Message-ID: <96102837-402d-c671-1b29-527f2b5361bf@google.com>
References: <20251023093251.54146-1-kirill@shutemov.name> <20251023093251.54146-2-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Oct 2025, Kiryl Shutsemau wrote:

> From: Kiryl Shutsemau <kas@kernel.org>
> 
> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> supposed to generate SIGBUS.
> 
> Recent changes attempted to fault in full folio where possible. They did
> not respect i_size, which led to populating PTEs beyond i_size and
> breaking SIGBUS semantics.
> 
> Darrick reported generic/749 breakage because of this.
> 
> However, the problem existed before the recent changes. With huge=always
> tmpfs, any write to a file leads to PMD-size allocation. Following the
> fault-in of the folio will install PMD mapping regardless of i_size.
> 
> Fix filemap_map_pages() and finish_fault() to not install:
>   - PTEs beyond i_size;
>   - PMD mappings across i_size;

Sorry for coming in late as usual, and complicating matters.

> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
> Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")

ACK to restoring the correct POSIX behaviour to those filesystems
which are being given large folios beyond EOF transparently,
without any huge= mount option to permit it.

> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")

But NAK to regressing the intentional behaviour of huge=always
on shmem/tmpfs: the page size, whenever possible, is PMD-sized.  In
6.18-rc huge=always is currently (thanks to Baolin) behaving correctly
again, as it had done for nine years: I insist we do not re-break it.

Andrew, please drop this version (and no need to worry about backports).

I'm guessing that yet another ugly shmem_file() or shmem_mapping()
exception should be good enough - I doubt you need to consider the
huge= option, just go by whether there is a huge folio already there -
though that would have an implication for the following patch.

(But what do I mean by "huge folio" above?  Do I mean large or do
I mean pmd_mappable?  It's the huge=always pmd_mappable folios I
care not to break, the mTHPy ones can be argued either way.)

Hugh

