Return-Path: <linux-fsdevel+bounces-22800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466691C91B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 00:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A9F1C22D3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 22:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B76A81AB4;
	Fri, 28 Jun 2024 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ndi34ZKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AB61C20;
	Fri, 28 Jun 2024 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719613988; cv=none; b=NPuP9PSXWzQSjdYMwfaU6KGx3M7743Fr8JbuUrB4sLlOJsidUTtwbkDCeNjT9SFYurhI7xvI7cZNGxBQvfWK3Zte2HM9PYxtkO5bLuwKMFIL0nexRfmgqYAwvYynkUFI68HyXhiRpcqE8y2s4jaKaD1YYLPMXdxe0IUpgVtrtx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719613988; c=relaxed/simple;
	bh=dSDpJSnmr/5Y1+i+gv+DoKJW8Sy9VI1KqiHOcb1J1HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQaYvWGEd83fWUL5xbz4AxhSMZ6aTuDNs4++g7fdCP8R0N3yCbsfammgbir7NYr1TlMXsftPrqtY6WY6GsWWWUwViDo9YyuDYeSkyl9gPA4hOiuk+w3XyTzK2RqFr10LrbsLXG+WGNaLNJXhSqotRXHHhjeJGUaVs+8hn8UqOnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ndi34ZKL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719613988; x=1751149988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dSDpJSnmr/5Y1+i+gv+DoKJW8Sy9VI1KqiHOcb1J1HI=;
  b=Ndi34ZKLDUwQOOVDOtEl6T3mVxgD6SNjIb0GbIEq5A0mk9POoj0bmHRH
   QPzYUuVYgp0SweojTjDAqVJSM6kbiPISUP7F2XbtIf4umlehfxtEBmfMg
   qbI6+AB+ai8goLRCzQ4sD6JFGwyBtowdRDMeP9umSm2q92CS9H0R076hw
   jhSmMKXGS8FFMZvjXRsom6qNPYmYhY2f8U+WbP5rplWFfUhIlEPFoeXlR
   NNEZuetvI/u0JZ7RttjWCPcO+V7Ksv11Zo/lxklnQR9vilAM8/a0dxTCY
   OOQTC1sdBxbfCsvB5biVJUwVY8/kiK8LmOQ+ofAueARDEZyz2arATj5zh
   A==;
X-CSE-ConnectionGUID: R5GKTElvQmOwBIPk8Kabkg==
X-CSE-MsgGUID: FbP/5Q7HSoGSMA2/wXLFxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="28204293"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="28204293"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 15:33:07 -0700
X-CSE-ConnectionGUID: n3dHSv0eTzSgfmlQ1Bb9Wg==
X-CSE-MsgGUID: rAs7JF7mTLOVUJxCpcwtSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="82419419"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 15:33:06 -0700
Date: Fri, 28 Jun 2024 15:33:05 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org,
	liam.howlett@oracle.com, surenb@google.com, rppt@kernel.org,
	adobriyan@gmail.com
Subject: Re: [PATCH v6 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY
 API
Message-ID: <Zn86IUVaFh7rqS2I@tassilo>
References: <20240627170900.1672542-1-andrii@kernel.org>
 <20240627170900.1672542-4-andrii@kernel.org>
 <878qyqyorq.fsf@linux.intel.com>
 <CAEf4BzZHOhruFGinsRoPLtOsCzbEJyf2hSW=-F67hEHhvAsNZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZHOhruFGinsRoPLtOsCzbEJyf2hSW=-F67hEHhvAsNZQ@mail.gmail.com>

> Yep, makes sense. I'm currently reworking this whole lib/buildid.c
> implementation to remove all the restrictions on data being in the
> first page only, and making it work in a faultable context more
> reliably. I can audit the code for TOCTOU issues and incorporate your
> feedback. I'll probably post the patch set next week, will cc you as
> well.

Please also add checks that the mapping is executable, to
close the obscure "can check the first 4 bytes of every mapped 
file is ELF\0" hole.

But it will still need the hardening because mappings from
ld.so are not EBUSY for writes.

-Andi

