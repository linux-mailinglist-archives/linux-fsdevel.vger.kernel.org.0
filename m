Return-Path: <linux-fsdevel+bounces-40493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD036A23E86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 14:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28EC3AA179
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 13:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8652F1C5F1E;
	Fri, 31 Jan 2025 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEOF1UwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3CF1C5D64;
	Fri, 31 Jan 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738330692; cv=none; b=Kx6GIWbKu86ll+fcCgrkVy5jsmQvXz/vQ3pBBF68QqTOgWdtbf1C2Ehs1URmhLQxAzo8HpHucH0Z+weFPrQLjgGOBXVxHEcTUjJbCGbMYBTJr0lZAfLtVis1Gx/MYQim96EosUXvgvxC4pheK2yk2X8WfDrD80rcQzS84Dx4aGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738330692; c=relaxed/simple;
	bh=sdAktvye9gszZrotFlv9Jol1M6CpUsq/odpFMNnUQ08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMryqRW4PkceZhcnLoSaWtYCHzo64dDok7TzLAktUovijY5oHU4H79Z8EqnmC618wXCVhKKtfOUiUh5AryswPTSVKUgcyTUtwb2hM05bE+go3knx6fBjDRRuMKK4XGaNFUQgvLLLMvGK5On92tmp0KzDfsxPMu457/O/DvKLKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEOF1UwU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738330690; x=1769866690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sdAktvye9gszZrotFlv9Jol1M6CpUsq/odpFMNnUQ08=;
  b=hEOF1UwUC+NkMr+YEg3HBM5+UEw2i8OZIhAMQBf0TaV6aU+s/MeI7dPN
   HEKlODi9LTFgjjRt3pkWEiSCVG1L1kJ4GotMhv7EXxUFYt8BkkvXSqY5+
   KlhcLcf00crStcPUcQfoHQgsyeRiLniWjc9QG70p8Tz/iEQeXVLjuYyKS
   mjkEuZ05X3y6BXrvm5d9Ds85l2L4HbMEsCptIB+kuocClmvglvUNd+0a1
   en1xQrR6W4etHdJBLpf8mXoPb45mAuG+2lcDXyQnFKEWmJ9pIHY/9OM03
   7pntW+mG53B/Ch3q/ZXJIvJgit+U5afTK+NR4Nf5EMp5eXE62OsrqLDKS
   w==;
X-CSE-ConnectionGUID: ptl9/FRLTJSm1RNT64fgXg==
X-CSE-MsgGUID: 157sUpBRQgC7fNsHgcZVzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="61367916"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="61367916"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 05:38:09 -0800
X-CSE-ConnectionGUID: zpQaMs/cQWqssvq7bbPLfA==
X-CSE-MsgGUID: u+rHSdoJR+y9VNuNhmjpzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113656117"
Received: from dprybysh-mobl.ger.corp.intel.com (HELO intel.com) ([10.245.246.175])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 05:37:57 -0800
Date: Fri, 31 Jan 2025 14:37:53 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Airlie <airlied@gmail.com>,
	David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 02/11] drm/i915/gem: Convert __shmem_writeback() to
 folios
Message-ID: <Z5zSMSBAmPrUTu2A@ashyti-mobl2.lan>
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
 <20250130100050.1868208-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130100050.1868208-3-kirill.shutemov@linux.intel.com>

Hi Kirill,

On Thu, Jan 30, 2025 at 12:00:40PM +0200, Kirill A. Shutemov wrote:
> Use folios instead of pages.
> 
> This is preparation for removing PG_reclaim.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: David Hildenbrand <david@redhat.com>

looks good:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

