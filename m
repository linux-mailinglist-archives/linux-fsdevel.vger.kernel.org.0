Return-Path: <linux-fsdevel+bounces-7665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 894F3828EA5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 21:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C83E28802C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 20:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B589D3D98D;
	Tue,  9 Jan 2024 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgVXAAEQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1388D3D0B9
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704833544; x=1736369544;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kjtKnEpnTIb311GdnA0TTfRvaGO8ijaKggG+836s6L0=;
  b=XgVXAAEQB+KQFdCSBJyk1QT+ndCo/IAyx4GQ6xw2PWQ1F5ACeAdkJqFL
   K76iWpD/hJFuo/bA4jC9EuPrTo5HHmR9m1gD3Cs13+KRrPDPDlGX7M4IL
   2bIvpNzZbwpo1vckzHKs1sHhmA92sIA+Q2cj4/YYy4ItAuBOyX7ZtVjgA
   MuEbtG2ZHZHrMKz0sXQmBkRIx9ir+uJuKtYODw23HfaH/e9PE0taokHhK
   ZC8aSLcwsLwNyM2hVVOpO/CHjX+jmtcIT+cegFqLhwNgl1Ui900eUG/Lj
   B5M9dhhmtET/zFul/bGfschB07bbqe4nsbW22pnXhy97zjGk9qSlYXHhl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="16913809"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="16913809"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 12:52:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="758115836"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="758115836"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 09 Jan 2024 12:52:22 -0800
Received: from [10.249.150.124] (mwajdecz-MOBL.ger.corp.intel.com [10.249.150.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 17D16C8381;
	Tue,  9 Jan 2024 20:52:21 +0000 (GMT)
Message-ID: <23907baa-7ee2-41c0-a786-a537a42e844c@intel.com>
Date: Tue, 9 Jan 2024 21:52:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ida: Introduce ida_weight()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
References: <20231102153455.1252-1-michal.wajdeczko@intel.com>
 <20231102153455.1252-2-michal.wajdeczko@intel.com>
 <ZUPgaAN71ERvQ5/F@casper.infradead.org>
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <ZUPgaAN71ERvQ5/F@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02.11.2023 18:46, Matthew Wilcox wrote:
> On Thu, Nov 02, 2023 at 04:34:53PM +0100, Michal Wajdeczko wrote:
>> Add helper function that will calculate number of allocated IDs
>> in the IDA.  This might be helpful both for drivers to estimate
>> saturation of used IDs and for testing the IDA implementation.
> 
> Since you take & release the lock, the value is already somewhat racy.
> So why use the lock at all?  Wouldn't the RCU read lock be a better
> approach?

Actually I'm not so sure that RCU read lock would be sufficient right
now as we might hit UAF while checking bitmap_weight() as that bitmap
could be released in ida_free() before its pointer will be replaced:

	bitmap = xas_load(&xas);

	if (xa_is_value(bitmap)) {
...
	} else {
...
		if (bitmap_empty(bitmap->bitmap, IDA_BITMAP_BITS)) {
			kfree(bitmap);
delete:
			xas_store(&xas, NULL);
		}

