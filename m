Return-Path: <linux-fsdevel+bounces-15835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E11E894486
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 19:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452391F21C1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E715A4D5B0;
	Mon,  1 Apr 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAZKaGtU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5551DFE3
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711994089; cv=none; b=t2cO883Q8PofaaKHoeC2MEoQiGK0p0Op6ZWUtqRVdvYQvmQPoCK25m12JWa1cOzqjwyCO4L+Jgowzh2W9/SUC5AEl9xekWfp1CoinpE9LZFudfxx9tLAYf/Ac5p7SRHhAgNNRL11hMk74cu8RzX7++2vE1rgsJZL0ZpB2vzWwcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711994089; c=relaxed/simple;
	bh=o6pBrkFgBa36aOQgvs2uRQ9sx/GPxetp6qRvYA96clg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1PrF5ALa4gOxxULUeIzAJFXriGYW80dn9pRzHL5DBlBKh/0XOcGcuo4iNXKA5rx9MiwKlzg4VtQZNJrybkv+YZMSBka2gTSEFGAbILIgtcp1/vLPxFo+Qb2lGDq5Q4mGgtaSrzs3QcJfP3nkCX7GiDiIFKl5ZhJAbhRFNAm2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAZKaGtU; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-614cd12d84dso7445437b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Apr 2024 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711994087; x=1712598887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SR1ugTn4UR80SSjFNO0YwFJM6k3RR0xXzQKQgGj97bw=;
        b=nAZKaGtUuwGxNgajWRDgEoLpO3vF3xD70bpD4stMVxPKGmyebr9Nn3lfv3AALroJNm
         kXiByOQjpx5tMlxGvJ5cKmikJN2ya5sjn41UIDzO9cYe2o6csgnVPBLu7A98O/VxoZ7Z
         H9Wt3EmUSqFcPUuBffMuG+E3v0N3rXNJrk+TDCDEwpEzEsGszh/rqvj6OyrApsscvOSF
         ePOuoeD+EBSTAw4e4Bb1YxL7p5waQ/OZlK6jBQZDNyNymHy/wMsMhmuYe4JOaNeQduNp
         oqCgxXl4EPpSH9aybHMdhU7wxvYeMv96/5BVk0SO3ubstpxQYaBpaPVb95vY6Y6DsWQC
         2LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711994087; x=1712598887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR1ugTn4UR80SSjFNO0YwFJM6k3RR0xXzQKQgGj97bw=;
        b=FTtz6NIEdEknCPL+Iwc6QJrh6ivHHpC/WDAOfEbiSLdopxEPLbkpzV2Wgu541gz+oD
         V9SRY88zN0GF3fua3cpsAyMdUSzu9uWJ6jz6JXi6WYAcgB2QtlpamwTZu+1aTIUzg2sa
         jJOk7F4rw68vrds0BIYdHlOIObMF6FZaN+F8YnP+vQ7+RwLHUmkWvUK1nfep7P629sJw
         Wq/cvA3ycf2E4rvOfqrjOgL7IOYX+9YGRBhxdBX8G72BRk7PXvsTPkkFMCsVLXZjIhaM
         Fnu625KT89maoOSqEmx9UeZ6knSulCS0kvASNm1f1XeoaWrdWk4fgdxCeVDw8XbvVRta
         Iz8g==
X-Forwarded-Encrypted: i=1; AJvYcCVVsN/576uKeNgUxFlwAAMsI3f0mWZLfJ5nhTPuCbrRT+R15CLvBl4+Q8xLlyQ7LpyDkmZN3/tOzXUunUo8mJ7QH7mXMCUMcwNueGTtJQ==
X-Gm-Message-State: AOJu0Yz7QGUgPOrujQgB5tZ2jll+FHfM/prGYN4K93ftHVaxc4BB9O6x
	uGc9xU/cf0rXT3EQUK0wTekA7e/Qfcefop8yTO+DS3LWMzzSP/eR
X-Google-Smtp-Source: AGHT+IEDB08AxTFRV08zVyBCfomFaj84XYRClmjXcKo3TBjz4gBR5/luGcJFoJqaI5T9/AJHRjvzWQ==
X-Received: by 2002:a81:528a:0:b0:615:b94:1c7c with SMTP id g132-20020a81528a000000b006150b941c7cmr1027560ywb.18.1711994086784;
        Mon, 01 Apr 2024 10:54:46 -0700 (PDT)
Received: from fedora ([2600:1700:2f7d:1800::23])
        by smtp.gmail.com with ESMTPSA id gt8-20020a05690c450800b00611a4cd615asm2329599ywb.88.2024.04.01.10.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 10:54:46 -0700 (PDT)
Date: Mon, 1 Apr 2024 10:54:42 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Tony Luck <tony.luck@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Benjamin LaHaise <bcrl@kvack.org>, jglisse@redhat.com,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>, Jiaqi Yan <jiaqiyan@google.com>,
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v1 01/11] mm: migrate: simplify __buffer_migrate_folio()
Message-ID: <Zgr04p7jIer7hlfS@fedora>
References: <20240321032747.87694-1-wangkefeng.wang@huawei.com>
 <20240321032747.87694-2-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321032747.87694-2-wangkefeng.wang@huawei.com>

On Thu, Mar 21, 2024 at 11:27:37AM +0800, Kefeng Wang wrote:
> Use filemap_migrate_folio() helper to simplify __buffer_migrate_folio().
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

