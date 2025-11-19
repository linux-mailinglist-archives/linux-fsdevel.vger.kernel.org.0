Return-Path: <linux-fsdevel+bounces-69083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37112C6E85E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 9E614292A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 12:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5537D359F8F;
	Wed, 19 Nov 2025 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="czIQrg8q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44A33C187
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555836; cv=none; b=tW4g9luBSqG8AseRidaTMnld96cXezqV86ZI+jxWIqSSommuNFhum9mdkdo3e7V6JlEOEWexlmqdQTSmZt5n38+p6pQHm8WxMtcKr+z1KiSHnsmf6GoScHKl6LEYAsii33ms9+dqUfp3GjS9zqmy5VKLazg+bA7XNiO83R7upHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555836; c=relaxed/simple;
	bh=cvBlKjUi3la4FRQ842NLzR324mE7CJQHgUXi3+al4ow=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=STjuV+ug88ySzpAYsbeHnHXp1V+Oqg+I1NAvGSBc22T80lIn3rEyRUIGVGf47DdnytKmRt6oycgeU+mNTN0qDLwlo0cR0yQkKX4r3pTGhA1P3tz+48bim/U2C0dKNaEQ9hqQn09umfBAEWyCvvHQ7YutWrs/K1Qt5+QoTYU8iLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=czIQrg8q; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b2e9ac45aso4318540f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 04:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763555833; x=1764160633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UbNuZv/5Za3Oc7Abgb1kuQDSQgL1n6Sh6FodFTL94fI=;
        b=czIQrg8qpRkCW0UMUEWkAU/Jdv4W5odJCGNE/s5pmXVW+16AKwG9xzRBmjssa7D0NS
         wVX2tOw+oNHkDi4/s1pJUgXKbxix448iRsjubluVJc2jKoY4P2rrdb3+Fs6fk1fs1MUI
         B6VlcEGT6RoYcgTiP+HjJGTY1jjMWqNiKrogCa0X2pg7vHAbVYp3JE+fZRmGiEI6R2DI
         ju5F6jpPC/RGsLfguO4TjtS0O/YIWL1/nk/QVA9p6R6G9OBHOox/jLWKQaA5g1MFEHz/
         cOqog2Oa5KhaeoisKwnOg+2yMLO8nMEexP2/nBbDC8BRwY/gEERRdXGDYIWEr7rGJg1W
         ZfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555833; x=1764160633;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbNuZv/5Za3Oc7Abgb1kuQDSQgL1n6Sh6FodFTL94fI=;
        b=UWi/4Ua7Y2RBroqEd6H2lBt+o8aD2580KcgSS0fKcmNDB2h7D0paL0N8Jn42an4qMw
         sd/Bzp8deZeeLxu5yH+GW1+9DQtLz4FwCgqx6/j39us1Pkboma3MDyt8fZ67wXbXvmMT
         I4fFhDMx/qKoYrVDXTNzgpZPXtdGRDmnOcu00KewQG3H0k30foGlqIZ64zGXbldz8pJV
         vD0BYctIuOTfCxxtVrZZc5rko9I9dJ5oHoAWs/Nxd8kedcF33ouYSRerskg9W4nIQDW2
         iG3IuAXOInZTX2kFbhmtPN0Vzn5LhCPj7askZHQlozPsTZlRKVW4/UebJDprY9aQQINE
         KOLw==
X-Forwarded-Encrypted: i=1; AJvYcCUxPnudNt2YmdV1nX63vgfyp0Y4Bkjhyx2v7OfBhPfbc6jPLMZcVT+qo4rq2Lhg2kK9i3LhASzm2geCHQDX@vger.kernel.org
X-Gm-Message-State: AOJu0YwyTJyF0X4Mrqz0d05lQQa/N34iUWoTN8YFIgP5ml0OfPuxowQ6
	u3mcZyEgVDu4oLsd8st54cSDSYhYPITx8J7WFhHPxJaQmjkRqhi1r+quxU37eeVD/q0=
X-Gm-Gg: ASbGncuR/zGVMa0Ilt+86U3BdeibESqq/237dUaWBMviFDmA6WxGbs9G2kpmGpKi7zC
	br96ON7FBJB3iVni7Wqah/WCGEO4VQJk9ViT29zIoPzLM5pvbY6qEzHZMyssm5M/EBjldjvwhoH
	V7Aw6Ny7WGYuSolajH7rndhwIsB0SzkiiRUgEDU7umUBTPVwFB0YvMS1fv/TMsUY+enY+ltWGCm
	5dl6cW+kH8i5N4CUc4I6I0UTjkOXR9rEqPbN09gpgLEGwric5UO9WpKvMjg9to8G9wqdXe7h3hg
	qdMYtJ1KNG4xNdi1ew4QAwpS05ZpuqajtpnQgi28UNrtOIJfAA+WR1isAetHk817dLiqHPKRa+y
	6MNi9mIEZogSXfgDPowUKy5vKReU8PGJZzxl0jT65YL8lJMrq8nVNiZSNXfoM6FMBLjFd2PcpM6
	rLpKHm6gs9Pj1/S6IWfepNObzlyt8=
X-Google-Smtp-Source: AGHT+IEkeW7AYIkdag7V6zOou3VntsZM8Hgog/jx8e0yYhvUx47QmrZwYx5wIGi3mp9Al3RK8NbQFQ==
X-Received: by 2002:a05:6000:40c9:b0:429:8b01:c093 with SMTP id ffacd0b85a97d-42b5934f642mr18648197f8f.15.1763555833162;
        Wed, 19 Nov 2025 04:37:13 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42b53e846afsm36908546f8f.13.2025.11.19.04.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:37:12 -0800 (PST)
Date: Wed, 19 Nov 2025 15:37:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Wei Yang <richard.weiyang@gmail.com>,
	willy@infradead.org, akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH] mm/huge_memory: consolidate order-related checks into
 folio_split_supported()
Message-ID: <202511151652.GKPwEctt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114075703.10434-1-richard.weiyang@gmail.com>

Hi Wei,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Yang/mm-huge_memory-consolidate-order-related-checks-into-folio_split_supported/20251114-155833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251114075703.10434-1-richard.weiyang%40gmail.com
patch subject: [PATCH] mm/huge_memory: consolidate order-related checks into folio_split_supported()
config: i386-randconfig-141-20251115 (https://download.01.org/0day-ci/archive/20251115/202511151652.GKPwEctt-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511151652.GKPwEctt-lkp@intel.com/

smatch warnings:
mm/huge_memory.c:3696 folio_split_supported() warn: signedness bug returning '(-22)'

vim +3696 mm/huge_memory.c

aa27253af32c74 Wei Yang 2025-11-06  3690  bool folio_split_supported(struct folio *folio, unsigned int new_order,
                                          ^^^^
This is a bool function.

aa27253af32c74 Wei Yang 2025-11-06  3691  		enum split_type split_type, bool warns)
58729c04cf1092 Zi Yan   2025-03-07  3692  {
ab62f1bb0caaa5 Wei Yang 2025-11-14  3693  	const int old_order = folio_order(folio);
ab62f1bb0caaa5 Wei Yang 2025-11-14  3694  
ab62f1bb0caaa5 Wei Yang 2025-11-14  3695  	if (new_order >= old_order)
ab62f1bb0caaa5 Wei Yang 2025-11-14 @3696  		return -EINVAL;

s/-EINVAL/false/

ab62f1bb0caaa5 Wei Yang 2025-11-14  3697  
58729c04cf1092 Zi Yan   2025-03-07  3698  	if (folio_test_anon(folio)) {
58729c04cf1092 Zi Yan   2025-03-07  3699  		/* order-1 is not supported for anonymous THP. */
58729c04cf1092 Zi Yan   2025-03-07  3700  		VM_WARN_ONCE(warns && new_order == 1,
58729c04cf1092 Zi Yan   2025-03-07  3701  				"Cannot split to order-1 folio");
28753037121116 Zi Yan   2025-11-05  3702  		if (new_order == 1)
28753037121116 Zi Yan   2025-11-05  3703  			return false;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


