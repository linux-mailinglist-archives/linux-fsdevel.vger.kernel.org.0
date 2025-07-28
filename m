Return-Path: <linux-fsdevel+bounces-56124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67613B136F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 10:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DC318923D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE122D9F7;
	Mon, 28 Jul 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHDogO4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5285F21D5B5;
	Mon, 28 Jul 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692600; cv=none; b=uDL+uEB5irk1YdMN6sGyHX5YUKAw4w5ylos5qfRx84RTEJ9TqWaXE4Fm0kTsn3/cho5sJcd2HqbOGi2XVLVxajn3bgG4kDlG9jVUaSHbpZtl3hZtuwN6uJP48qRI66a5IvCjmuoJ3Hu+zmBAD8u7uzHEwIcNZyt+DtZKnqOO4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692600; c=relaxed/simple;
	bh=TpJPGxKfvXvAjbAFEaZo7FdPosOGcKNZ9WkAuqWCWBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi47UniSGorQFmYS3J+fT85ujdLkOLtFu/tgRIo7wpFAQfdv9I8LRDw8iSPRRP2NUHz/uz79BCVS9/w6rO8RLU9R3FnTIn6lUp3ZTjVjs9S5l0Czz/vXOMJZu/2eHTfjVjHRgLSsrc0KH3o4l5uhBe8SKKy6tNFoSSaD7cEhDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHDogO4p; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so7081426a12.2;
        Mon, 28 Jul 2025 01:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753692597; x=1754297397; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsN7y/1kzG5yx277Iqzf5ufFB3MHq4CNNEmgUnJER1I=;
        b=YHDogO4puMLsf21k97xqH0JiaE/WAeXozYaPrXMIHXed5fw5VXEv32sawCe7cHPpnW
         uUvKpZAOVYfndEiUwW43zaB9GzO7LF/myj50W9zpo6svdDF+dALmlOLpd/wYg1Mj1Ksh
         PPiEet9vnPvnP/MREbLmz1T81Ux4cXIoSvP4eh4PPKe9fRIubEEO07dXejNu6H6xNRCF
         vp6oWBaxpKY9fj3FKGGlUrMdD61sODMIfjfH7P67SdI7Yx6yN+nIDGXAkrJFLBQiGMjF
         Ek/rvLTJk6CmoHC/JX0SreBA0f/SM/cC24CRTP0MjPuzeP3lh6vJncw7n5Gn5K7borKa
         a1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753692597; x=1754297397;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nsN7y/1kzG5yx277Iqzf5ufFB3MHq4CNNEmgUnJER1I=;
        b=m8NRuVLlXbN3H2FEL2c4oIyIpjHbXT06cyFwI8XB+Pmt0VW5gaYUTkLx94fXGpDFEf
         aFECjr3VIPHbb72zoiFigaHY+rhWqbYeojmybjorZ7M0RGRjuB+Z1THS634OkOSSy0ML
         6w92zNdvzivXeKF6GPJUHDEwHXq9gCNqGwf/9nIO36ee6Y4zftYNbYnI9xYQjbGbYP+z
         1tziQHVu3WNOSNz+41T/PXh5E3dx3IN8eTxcRnvM/hoFLPKOjFJ950YJKRg07O6mHSS/
         pUqrswDRKndgblYIxZt1oN/Nn9PpUMClMl/KTM8PJHKBBum/sjG2Y810tTWXCuzWw8LI
         cPOw==
X-Forwarded-Encrypted: i=1; AJvYcCUiaOBGrmvhjoSy14oJPzwA7Av8j2S0uwwTFJ5fJbNO0oMVGnTRU1hDLq47RQnUhRnGCEIvBWO+iDBQRkoF@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHnu3ZTPi64NBhTLlqyMWGBNeM7JkV8JMvaNgmBMDDXnwBlO1
	oWcajCe5wTZWEo53MxrzvKosw6JTzfylwjg1gyfNHcJ7ayCEDwjdPNcb
X-Gm-Gg: ASbGncukadEE65/Kzk/q2ZqDYzJBToTboCEWK2RhluvxmUVdq3JmjkegS5XGOcfLUjs
	rz4Z0U73ckPcsG156SMH2p2X4T1f4e0dn2i8UYSF3nJPBPmJawZ4Wv1WgEbHt4VqHYbMrbgHLYD
	Pc6ynqaMaPuYS1zEf1w+eBqZtIecIqrDZPIxOPf1rrMg0rh9UAElXmG4JRpTu0g3DVP5hn/dAwQ
	OBuXSehGRGPDZeZQHf5ZU2iUZQwCce3R8cHaYiim4vM8uul4TZrLuEG3XzXHkARr/gl9HkX8JSm
	AVO45Bytp+djHcQJQq0h4nPB8PUxA5Kfx3JyR6bSlQikRAE07hmWs2QvU4QpqkgU9GaJw67X2UJ
	T7HlYtuysxtBJZO/0bAbtxQ==
X-Google-Smtp-Source: AGHT+IFaZJsTQLzzOiXfl1Nq1UVtUOTF8P3susmSPp5Bc8zyCjo/DGmP/Cxh+cs7YnmCiD5doe68aA==
X-Received: by 2002:a17:907:3e10:b0:ae0:d798:2ebd with SMTP id a640c23a62f3a-af61940ce29mr1071644666b.35.1753692596383;
        Mon, 28 Jul 2025 01:49:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63589ff78sm394541266b.47.2025.07.28.01.49.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jul 2025 01:49:55 -0700 (PDT)
Date: Mon, 28 Jul 2025 08:49:55 +0000
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
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 5/9] mm/huge_memory: mark PMD mappings of the huge
 zero folio special
Message-ID: <20250728084955.uzobxwoqalcuhk72@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-6-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-6-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Jul 17, 2025 at 01:52:08PM +0200, David Hildenbrand wrote:
>The huge zero folio is refcounted (+mapcounted -- is that a word?)
>differently than "normal" folios, similarly (but different) to the ordinary
>shared zeropage.
>
>For this reason, we special-case these pages in
>vm_normal_page*/vm_normal_folio*, and only allow selected callers to
>still use them (e.g., GUP can still take a reference on them).
>
>vm_normal_page_pmd() already filters out the huge zero folio. However,
>so far we are not marking it as special like we do with the ordinary
>shared zeropage. Let's mark it as special, so we can further refactor
>vm_normal_page_pmd() and vm_normal_page().
>
>While at it, update the doc regarding the shared zero folios.
>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

