Return-Path: <linux-fsdevel+bounces-56235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6B7B14991
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 09:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3DE189F788
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 07:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5726B2DA;
	Tue, 29 Jul 2025 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co27IN4D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329FA265CAB;
	Tue, 29 Jul 2025 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775617; cv=none; b=afMSuwVHQfoOH+IvFhtBUKAx/+hI1iBEF/slSjb6j88UYfYW+5Qo9YTS7rlNLJeLQYqnbsGOAqfxK3EtD2no/nVRQJHqFkrIcHe5O5TVJFzZw8oztBnkh4Tuc+36JLjdbN7gOErtQENSamw9OM5P3g5Suwgvg8Juj8E/tLfGnd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775617; c=relaxed/simple;
	bh=aes4PlrG7u8ZTpHznRKhnbdzYLwksa7kjjCc3G53RK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8Pbw7tzAEij3QxkC29GwjiYtw9GRT9RJqW0FrPjqV+u+rZ38Y39C4dmGunuhK7S88N0TAnP+pVjfG4FddFExWtuGdK1SWVevyto5p32O30wkDV9YauBTSqPgmV5XkOcsGe76QG4TVNQ7gSp+J3q83xbfnTJ/MrzsId8bdWoed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co27IN4D; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso3378209a12.1;
        Tue, 29 Jul 2025 00:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753775614; x=1754380414; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsVo12V6n1cHZPjfQGvjTgS28eByrDkHggKW6JJVbsg=;
        b=Co27IN4DYslceBDIRO0O2CQizu2QrH6p9i9ZtacEvjsWfxQdCUjNgwUhS3y24wuZzd
         q3AtQwbx7oyimNBH2Rg+hZ9Ksjttg/r9MAnfuu5xqd7Z32+gc7Hnnfn7sQx3zxajNAbb
         IO30X+vzr58BMiKPtUzkX0gLbmDqBcMKNj9wXTP0/0HO3mITg9D/5EIbLWyNBchtDrVl
         cGWwa1a4KjwvfDe3ukQZDJJPsoUTLq54SuVDjzLvaVh40g4IK+3ZkA5WFQHK16ZehllA
         xDQUqllyoDFD8qMAZwMFEy9lmEERKE9R4yWGCCV2e6IX7eMukuG7MGPFAizP7g9L3QRh
         D/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753775614; x=1754380414;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xsVo12V6n1cHZPjfQGvjTgS28eByrDkHggKW6JJVbsg=;
        b=VU+u5/PyVP+AT9i2GLqpdpu/KXY8HQA//4/LH5KiVPvoQHkEKHrEpmPv48yFOBWOl4
         EuIWN3Hz0kTbKGTc1XsIsXdHMSij0voyEC/ST23nGXccyWdzjzRCFeyqWf+5dHNYg5ch
         5ECTyi4WYvZzc0lletgxn4HtHn0MZzSkN2j+UksZlcnNibj4SaI+KwM4rlUUStZt1eth
         ugGfuADDtmXNqUsENUo6H01ul8Zk/CNU8SmH2CDWoHqu11koiZ2RfMWNs/rUjqS9jdPM
         o5sjpisxt5vnh6MSq2HSVqJmapqi+vC1zJwyWKSq01EchVlsgmQPa2TXg7txI8GQfxuG
         Y12A==
X-Forwarded-Encrypted: i=1; AJvYcCWEyxVyxDUWAWz3DNDA9DA+pNACfzsFSlDeRmPwbO1rA3nv0TR4jcX9QEz+I941WqgAS2AgVa5KM/RQ6MxO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7KmAG00HVqqJiTMWUiITMF7PdNU7PTrUrxTeTXe7Ai11XmbXa
	MA2dWeiEnwetceL5/kPqWX2zx7Kel/R7MdnJaDeTEYPvbGUo558bAtG2
X-Gm-Gg: ASbGncsLibWYy7HA8JjzuQOIOUMJQK9csM7C2D7zJ+ms6+Hg0N/LEDIEOD173qoFpP+
	YbXXWW0gnU7fJVdZtz6xjWrHYz7Q5kKMGxQoC34K/g4kFLR/3TDQ9zstSoKJo6FL72nIc01CLnl
	ShwupM2Jz4fqw+k/6DuxxnZLJOyyKkg5deII1rOCQFSxDEoVRk8Unf4EtNfjQ9+t5FvVve6fbZv
	rV88o9j/jFEG7Wy5lVqLxzCpPSaBmSgVJuqM7WJfAJCMCdmPzwgHxV4T9pwe4QBTy+65/8TET9Z
	mdUhXG2fGJ2fOqfyM1AA2wTlYLjQc/05Zrwp2yArNdCb0lfZGO8lnaYwkNzCiVqJf2uzzhatnY+
	V3WPAfkVFJGY2ftn4rFrZ2g==
X-Google-Smtp-Source: AGHT+IGAnknk8rhP20f+2sNuwxA4iW0E1pa7hcWsSRXI9dwJsSvI+o2WMSlmcCRhgf1zJ9FE5orwQQ==
X-Received: by 2002:a05:6402:2789:b0:615:4655:c74c with SMTP id 4fb4d7f45d1cf-6154655ca5emr5234235a12.31.1753775614152;
        Tue, 29 Jul 2025 00:53:34 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61556326ee7sm1444188a12.55.2025.07.29.00.53.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jul 2025 00:53:33 -0700 (PDT)
Date: Tue, 29 Jul 2025 07:53:33 +0000
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
	David Vrabel <david.vrabel@citrix.com>
Subject: Re: [PATCH v2 9/9] mm: rename vm_ops->find_special_page() to
 vm_ops->find_normal_page()
Message-ID: <20250729075333.47jnxp7fly5wfx6n@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-10-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-10-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Jul 17, 2025 at 01:52:12PM +0200, David Hildenbrand wrote:
>... and hide it behind a kconfig option. There is really no need for
>any !xen code to perform this check.
>
>The naming is a bit off: we want to find the "normal" page when a PTE
>was marked "special". So it's really not "finding a special" page.
>
>Improve the documentation, and add a comment in the code where XEN ends
>up performing the pte_mkspecial() through a hypercall. More details can
>be found in commit 923b2919e2c3 ("xen/gntdev: mark userspace PTEs as
>special on x86 PV guests").
>
>Cc: David Vrabel <david.vrabel@citrix.com>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

