Return-Path: <linux-fsdevel+bounces-56005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E81A2B116C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 04:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E7D7ACD82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAC2233D9C;
	Fri, 25 Jul 2025 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfPsKL7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519FEEAB;
	Fri, 25 Jul 2025 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753412171; cv=none; b=DCsm++b8UI9nEYFCD4WT/L3buWwkWqcARH6TNlTdMokZv0FutJPf/aEX8KYuyJ7RLx52tOksP6kHuy9AV4sgqQqbMfNLeb6iWnUKxt3r9OorPfoR7YUYBviZ+9JkGCvNEJVTFmTYJR1AK7cNwAX6LYuo/BwczSCYh+8a2oJFbWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753412171; c=relaxed/simple;
	bh=e7r351WHBKXYVy/qybPJUX5Acqx5iciPw/mxGw6enRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4U5s3Fd1urDz3ejrqvwdjmw8Et/8DZzcooFYlgEmoZ11U+TzWrUt7NTt76u5KxpZOv/zfubKeuwYRk9hchbfA4vf+W/9AsLOm1kcO/wELA7bHLTLLAR+7rqa4qpPTo6N/FaBH9Q7SihPPtn7NRByGydYsSPC5k/RDNxX78/vJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfPsKL7I; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so3303075a12.0;
        Thu, 24 Jul 2025 19:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753412168; x=1754016968; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzGOuzDhEi3TMJulLXZr4GFUL3lm8OH7E+i1imGtL3w=;
        b=mfPsKL7Ii99GWukQQte4H1qUrRDHnYgo0R6oEdqzqEew5i+TF3cIWlCXwAYRyCCU0l
         F2dkjqLGGWTHhQPUss3feP8iFxvnV7+BZSZ0yqwu8ZVIkWdE9nJ9hfMCphEJgxijKmeM
         1BuICue+h0aLZUKqLgvXOOrDE3sVoGXx5kN5+YlQhTAd9zGzWKja+oilI5q4cQSNvkpq
         JhY6WB/z3GjmxFxcxxghR/j5pIqB0hzvtF7BijXLjSWmFYxg/NS/YDV7GYY0T3kcW6jC
         b/en1kgm9cT5YgnX/03DpxrqBTe5pRJyuuORtvRSjjEVDBk0YWpUFQtfNQVmKyn+oBxu
         sUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753412168; x=1754016968;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FzGOuzDhEi3TMJulLXZr4GFUL3lm8OH7E+i1imGtL3w=;
        b=VF53MSzI9HRjHG9vdDB2B68Gkqp3Hd2XQECIEoAoYRFFScqMqleT9u/3SMNTkR0HRb
         C2kmFzG3PE4HjLxs7At7xdsZJcL+lTUagW6qOVo2uKCR6m/+CzU48uC7zTHam6fWuhjh
         S6zVjEf3N+RoEcuE6qdjRGhZEcfEuElVgGu9lcBmtOsYNJr5sf6UcswkRdDbYdVX2j1l
         MJjXNBFGVJ0m7FSnJPuMguGJZdPCsCkmk8QgxEn6TxcOWW4MD5NVYkrnAXGb5yhBO6ZX
         RVxOoHh3xoIf1Cb6y7MW5kUrZ+0BGzyC7prJQAwJfO1tzupMcdz+/e/UXnoxdpjtFDU3
         c+oA==
X-Forwarded-Encrypted: i=1; AJvYcCXEz66Ai7vHk0AWOf/UQFSpqBVl2HuwrVSC0tuCq4AngZtFyAkYtC1+tPNVujnfhWn7v8AITi2LlyQknOqX@vger.kernel.org
X-Gm-Message-State: AOJu0YyH5f9eKeYBia0/3FDL6XXw2lnHuK/APK42MEHvE2u7PnWZBRzi
	bvoaTUKai9Ef5GvZHY0Uk6zWz/i/uY36MWXaHzIaIUSUoKGPfWmpJWSu
X-Gm-Gg: ASbGncuupW3J5Ej6Bm/lOSDRFXSK15ccTDhFg8/4tkAPDCV5UISk3eZ1zpuOAAUCkJ8
	2nEOqybmw1uz53zj7eaxrGd/Q3np3IV2gXllLNDgv+/Q9e0MgLidND44JKNMpWcKijK3hyGnTXV
	rGwmZYZd4iiJKrydK+1T/ES9SwqT7Iva00GjVlLJQSZK33ho4vU36jh6T5/s3D+7NN6kqDJub3G
	WDUN7aE9Xn2Bca7GKL280rc2ydeo9pw8htN1Dpph8rI4I7tpFjqE4yi3ZPvJLJYEnrB2D3g72J5
	CPLZPwdYlU8ZQ5jtfyhL89YnwZk7FzbwKFaxkfj9Dj1dr6IDiWVCjWVboeclIFQxzg4RTzrDpA0
	DBjRw4lvsZDkTfRonchbN8Eu2Rtv3ooe/
X-Google-Smtp-Source: AGHT+IHhkClQ6+YPICgV57QIRUaI7tNGak2Dw44PbpFkJLABqr49v5gkdZqRJ5Z7WHZCF0LZz7A43Q==
X-Received: by 2002:a17:907:3e1d:b0:ade:4593:d7cd with SMTP id a640c23a62f3a-af61c8a6743mr34848666b.13.1753412167981;
        Thu, 24 Jul 2025 19:56:07 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f44d85esm196204966b.89.2025.07.24.19.56.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jul 2025 19:56:07 -0700 (PDT)
Date: Fri, 25 Jul 2025 02:56:07 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
	Lance Yang <lance.yang@linux.dev>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v2 2/9] mm/huge_memory: move more common code into
 insert_pud()
Message-ID: <20250725025607.vi7n6wvwmzajcv3q@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-3-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Jul 17, 2025 at 01:52:05PM +0200, David Hildenbrand wrote:
>Let's clean it all further up.
>
>No functional change intended.
>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>Reviewed-by: Alistair Popple <apopple@nvidia.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

