Return-Path: <linux-fsdevel+bounces-57454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A40B7B21BE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 05:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C861A20459
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 03:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0782DA779;
	Tue, 12 Aug 2025 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hihrJ1bu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1A2DAFA2
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754971122; cv=none; b=VfF3p53+NpuJgi2q85oxx3Tp74JbHrchsf3JqkX78YxGDJYbBLuCxDQkCQHmFfNT1am+bfxWjh4V29g5lVP14mXqhi8kZRu6udI+RrGUIww8pLK6rubzSILi3RAzDTLJ+HjzEWV+fpnq/ADX59SlYeidQ2sBUqhdsjSDHNxPe3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754971122; c=relaxed/simple;
	bh=QDW6PgcfQGmvnuZamnjvlDuDj/nN6/r+CzeVaCn9PhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQY9vzykcSYtKT2dS21j0zz/x1ThmUEnoEfUbvXwZclT+8Yywpd5y0g3wRh/HXeADcwqebKm0xhh0etid8r8k7evT26C73gMBaj59KbLqY+KXLbqi7E9ElxplIFo6VxQ8CS6x0iKavU3/yd1/+ZD/iXGTe+6pgjt991PsVYgjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hihrJ1bu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3214762071bso6154054a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 20:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754971121; x=1755575921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsF4i7owr2w64jophO+zO+eW0GN81ddWs4iypkKqJ00=;
        b=hihrJ1bu6sELq8z9mjr/kEdkySRitX2ZcqISoR0PTSKkyQSbp0BF4WtJYLR1JKXZCO
         j83CRm4GSIM3w9rtEMXObIjJkARbBU//RsdBZhHcW3pDcXe+4g6tZr1tqzW3BrA3olCP
         +24KObsBsiVGVgc6BvpbTO1aSlUMd+mMaYNrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754971121; x=1755575921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsF4i7owr2w64jophO+zO+eW0GN81ddWs4iypkKqJ00=;
        b=fOo/K0sDYasUQAm4KZRzU/GdsqFGuz8IdoSwJPSyaKLJy6A9lGkXhRQeqJV31plnHX
         iXOlz+rRaPvgcKk0eCGF1jCW7rHPwnhlPNg1f5WiWt6/IjHeGIFbLrz/r69mykIdo5bL
         MRf1mho+Uc4mF8QtM7UtMRJ/da8aeoa6I89cseIMvxW/VY/1dtPNrCGu11p3tNFzmAp0
         /Fz2PAQmuBot9ftSg8jo3V0JKmeSLVATAPxjdmqiC2hbtj+/7FDNZ61nmNWm+lTQHawu
         THdkcqcL4CLHudHXhwzd7ajOWGeAArk3zZQEpDZ7oNZy4jleeIHaBsrENN1mmEdQzoX7
         sYYg==
X-Forwarded-Encrypted: i=1; AJvYcCWGI43THIWGNT7BK3OUgvxFIUmU8vqUgegXKPKd6PQUlUms4KS0/KVk4EeqJ7dOfcB8Pd7OvbvDsXkLo4cP@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHite7BzzM4U5jZVyY4oxPM3jFW2Tu9LWySMSlt9mdF6fpcF0
	2c/NtoqTUu0+D/+GUKoyzLT69pHuee51nf113X0E6lMMuWAMrDNt0afcnq2LJ8xTng==
X-Gm-Gg: ASbGncvhx5x7C+B8iqvJSvz5fiHEEftUrULjPweGiJi/4UtgUDWE83/O3YvYcpH4mbr
	EKq8hFI4vHPkVROxnSj1vRP189Jx7RsKp7fkBlacIK+pHVRWyS9lcGHm9VGTGQKByvH9v5J/xQk
	GCvB1Jec7PpbBz9CD4gEEcBTbMFDRfpWQUUj7/gJFxBn1v8LPv/PaJJC/xExa/BrieHEfEkTi0+
	ytpIqLwDH9M9hEmU8X85EWxJL2ERIQUPwor0NrSNGlQEHOdmF4Iu+Bbp52u9GhkqQppsmvBloXb
	/MWKx3epr6ssRgsokODBb0xVVVykAfh8sRi/aepUEwrZtm9LR+d8VoCUSveZNmtP4YkRd+o8CnS
	OqA1+WbB0Z7jecDxhPq9/VxZaRDDSUzw6dz5S
X-Google-Smtp-Source: AGHT+IE0YyrVY5Vt8OKrl33IrgQwBQBekiXEdcW95C5mTt17WuM8Sondsrrkn0NdMV5pujBh12Fm4w==
X-Received: by 2002:a17:90b:2251:b0:31f:1a3e:fe31 with SMTP id 98e67ed59e1d1-321c0a11aa9mr3103600a91.11.1754971120678;
        Mon, 11 Aug 2025 20:58:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e529:c59e:30f9:11d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321611d846esm16436888a91.8.2025.08.11.20.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 20:58:40 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:58:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Dave Kleikamp <shaggy@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1 2/2] treewide: remove MIGRATEPAGE_SUCCESS
Message-ID: <lky6lmpq5hsflc4rcs2hev5i3gctvbrppysttnzo22r6oiryw4@edfre7sprwk5>
References: <20250811143949.1117439-1-david@redhat.com>
 <20250811143949.1117439-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811143949.1117439-3-david@redhat.com>

On (25/08/11 16:39), David Hildenbrand wrote:
> At this point MIGRATEPAGE_SUCCESS is misnamed for all folio users,
> and now that we remove MIGRATEPAGE_UNMAP, it's really the only "success"
> return value that the code uses and expects.
> 
> Let's just get rid of MIGRATEPAGE_SUCCESS completely and just use "0"
> for success.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

FWIW,
Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org> [zsmalloc]

