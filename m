Return-Path: <linux-fsdevel+bounces-25741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A31E94FAEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 03:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF97A1F222B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 01:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C41B6FB6;
	Tue, 13 Aug 2024 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N889tVKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB755684;
	Tue, 13 Aug 2024 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723511137; cv=none; b=gSGOTdKSodR1umJrXc5qC1fvSQUKvzldTxdUClCbamv8gVIiLwQEmLcdUW18zterGb3ujj5k9jMHfvdGY2eHg0yvrprfbswPuFPzwkTFnV9wMrBLQ5UilSIL9m3seIWetkK1yJLQs7XBYtQApv7PCiF3CJKL6pEreSEdsp9zgXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723511137; c=relaxed/simple;
	bh=vdyumgG6GaPweNqJcS+FHLGTeAQeLwrgo8qmGYnF2hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCTQAbokiPhA9dQM8XpVds8VdqvHtSRkSGg1mPJwz2oP4ok6SlI+EI0yFpdhsGk4bwVmPyTz3tPb6Fpg3WiIYLhsmBEuUhDasm5ya/1sQuYIEaHIteXO9BmLnIH/2oGWqyYW9qwROgyvsnFig20oaTREODF+VA6ERkQMhS8MaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N889tVKg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723511135; x=1755047135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vdyumgG6GaPweNqJcS+FHLGTeAQeLwrgo8qmGYnF2hs=;
  b=N889tVKgtw9XzJxkEoAgIhIZcim8dHWCEOXslzGI8gNC8hcOmKB0L/Tn
   Wj+9ex8AkDYvKr1Bt3tt8L5PRvTYoVmbChDFsRDmDiyDaGcecw15YhCvB
   09vQjjrU5vVuDIMskTu4oyLKlz6XXYl35WJ6vdvw72BsvxOewDkE8/mBi
   mBY706PEGGvBzCmnOyJSqXxB6/eHl18G7spFR6edP4hfAVHC/Dy3HTs6W
   ciI8OG+FJLZXkImuRIfSrxo7KFUbBXd1RZxAqxee/vIq2QyY6xaI7jVqk
   kzkhS80LSaR9d3xVC9L+cn32DqUaZjwdP1FyvjT6nliV9j1dvCsscCpwU
   w==;
X-CSE-ConnectionGUID: kINLNHvDSL2TkK4xBNIjpA==
X-CSE-MsgGUID: PoUIgF/oSZGYWd97Fmj7UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="24558047"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="24558047"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 18:05:35 -0700
X-CSE-ConnectionGUID: AST0ePnZS1aKP5kdK4yi7w==
X-CSE-MsgGUID: mCNn/OkNQQKhCuYwHu4Fng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="63334906"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 18:05:35 -0700
Date: Mon, 12 Aug 2024 18:05:33 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	osandov@osandov.com, song@kernel.org, jannh@google.com,
	linux-fsdevel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v5 bpf-next 09/10] bpf: wire up sleepable bpf_get_stack()
 and bpf_get_task_stack() helpers
Message-ID: <ZrqxXfZE5bFy-5qv@tassilo>
References: <20240813002932.3373935-1-andrii@kernel.org>
 <20240813002932.3373935-10-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813002932.3373935-10-andrii@kernel.org>

On Mon, Aug 12, 2024 at 05:29:31PM -0700, Andrii Nakryiko wrote:
> Add sleepable implementations of bpf_get_stack() and
> bpf_get_task_stack() helpers and allow them to be used from sleepable
> BPF program (e.g., sleepable uprobes).

Is missing the header actually a real problem you saw?

I presume the user tools do have a fallback to read the
build by themselves if it happens


