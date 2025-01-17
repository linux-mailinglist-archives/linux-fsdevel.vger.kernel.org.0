Return-Path: <linux-fsdevel+bounces-39471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD572A14B5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 09:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CC13A1FB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 08:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A641F91CD;
	Fri, 17 Jan 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDuxVj4e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A481F754C;
	Fri, 17 Jan 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737103359; cv=none; b=Ht9SgNl04Qp4nCUr0IFSHmSCNlWn2sV901apNP9yQeE8UF/ll1uVxmKzPthNNM3y4EUhwvcWcwHhAhSOFXGLpdTkYY7zOYeja+nFgPV0x1RQK0a9dDU1fnc/uSnPzo6+FlzRQCKpAg9NpJl4jxMzTEakb6VKDBQVH5V6x0oIxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737103359; c=relaxed/simple;
	bh=28NiPYsFXE32MP2Q2BME0MlX1uv69uodnGAvgVz5KwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ1HNJ46HvZcojyFi9hUW3s1/Ks5Faf8pPUr+T0NfUSD/cTxn9hsgMlAR2e45KHxh4lVr42n9rN1xA7x9BYRKxdbLCeiua4dN53oyFwo8IsD1QJGgP/mS4FsDoAh7YD+jqphm5ANKpt5Oi2kbSdqQa/Lth9IQCTHs5iMErf+GPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDuxVj4e; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737103358; x=1768639358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=28NiPYsFXE32MP2Q2BME0MlX1uv69uodnGAvgVz5KwQ=;
  b=eDuxVj4eGvM2xsFyifJXkKdwMmvqVp/17ghbc9gfsInLKpHe6plo/N/j
   F2lX9Et73vlE18RujZL1tgSjAdbi9YP1+m3T+X30vOmDTFP3hwzpTlrEt
   0xaqL6S2Tjo2R6o6hGEVC9H3yEZvTWLVPc1rR6Gu5WC11bc9LDaQJF+OX
   LYhHV6Lj6OqylZoql/mS/S2CV+ZIrRUNVDA6Tdfw8RrIAPipeAz5CPvAW
   svm3xbn3W8lMlEnntwtxeGfSVa3EDuP72uZBA12YBfbEX1JlnZmGinQP6
   aMQwBsUce//11u7ROmcJ/SH9gnJavy6e480MnGAQVB7RJZENPMqCQYjh0
   g==;
X-CSE-ConnectionGUID: tgOXEpEQSi+1OqMXQI2cJQ==
X-CSE-MsgGUID: 7HY4Se5VRlC5/h7clGQh5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48923415"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="48923415"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 00:42:36 -0800
X-CSE-ConnectionGUID: e1YD5/pBSvOBI/os6GkRkA==
X-CSE-MsgGUID: 3A6q1Mm2TpybOA1rY5fzPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106634486"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 17 Jan 2025 00:42:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7B06510F; Fri, 17 Jan 2025 10:42:26 +0200 (EET)
Date: Fri, 17 Jan 2025 10:42:26 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
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
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 11/11] mm: Rename PG_dropbehind to PG_reclaim
Message-ID: <w6x4k6mjv6x5kjiuxszdhl56ldrem5cfhygkjrko3u5vqufylo@krcva5mltyre>
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com>
 <20250115093135.3288234-12-kirill.shutemov@linux.intel.com>
 <Z4ikqJBQ-fBFM6UL@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4ikqJBQ-fBFM6UL@infradead.org>

On Wed, Jan 15, 2025 at 10:18:16PM -0800, Christoph Hellwig wrote:
> On Wed, Jan 15, 2025 at 11:31:35AM +0200, Kirill A. Shutemov wrote:
> > Now as PG_reclaim is gone, its name can be reclaimed for better
> > use :)
> > 
> > Rename PG_dropbehind to PG_reclaim and rename all helpers around it.
> 
> Why?  reclaim is completely generic and reclaim can mean many
> different things.  dropbehind is much more specific.

Dropbehind is somewhat obscure name. You need fair bit of context to
understand what it does.

But I don't care that much. We can keep it as PG_dropbehind.

Anybody else has opinion on this?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

