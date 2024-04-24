Return-Path: <linux-fsdevel+bounces-17666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246E38B1355
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 21:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B892C1F2193A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC4774420;
	Wed, 24 Apr 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgPqxNSS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21CE2D058;
	Wed, 24 Apr 2024 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986129; cv=none; b=inMOEjWR9ZVfYdAPEakuoUunjyG7xsmSpKtcL5QeVBBpOtXNCpjumGfS6GVSURXH0awo/ieHQUz1DMvLopiLa5vD+j+JYCOzzdp3pq0r3pydJ7bYs56iFsX9E1niPq1aReKiTCE7WCncTljJ8TPhNxOrjge1NSQkYIfZOgIBTmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986129; c=relaxed/simple;
	bh=lOEH5OW0djs2D1y/2qbmQpF/LbkgEdvTCeeoT+uKu5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M9SRRntr1/79dnSvECv5zKc3PRIOB7NZqnoLOakXjj5GqVqp7v/Ek/tnwLyCKtjip8ZUnb6P9cFrqPOqxXBo5QoYD9gdsQTHpw8ygK+O1zujgvpYdxZjOob/o2SXXESMdr/cv6+RmheVL8TARFNN24inGl7byOQOGUavaiHA5ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgPqxNSS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713986128; x=1745522128;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lOEH5OW0djs2D1y/2qbmQpF/LbkgEdvTCeeoT+uKu5Y=;
  b=SgPqxNSS6Dyg6lmiEO1VjEEOb2s6judy/efH0JXYcpYOt3DCH9PzBt02
   gnkdxjmAVANoIHF6dYjaY6teFCza/92+60cZovC2I5Fd9raD0UOVdq6SV
   wafiBEZDoLsN1M0eM6W6UvnOehp7VCweaSCRokTb3Bjl4f9D+t2qQ45YT
   R+XfrIWOsF4qAsayCSW9Ylzazfux2eavWb6SbpIt1cfbmHQhBzyqUJVB8
   QFDj0ywEwYDTGWDR5uk8++aI4U7/e6xt5Gz6Hx2rATX7U+eAZM6xmsthH
   p7bIWubKX5pwLZRR/s9ztiXb5x/MILsMU9lmHWh4KiKuoC2sqRsy2EVIF
   g==;
X-CSE-ConnectionGUID: wVfTZXczSnuOA2BZ0Mmspg==
X-CSE-MsgGUID: YGaXZQXzRr+ySGNMWkAk8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="21052415"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="21052415"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 12:15:27 -0700
X-CSE-ConnectionGUID: X0N0OLMuReuSRx/PRcj7Bw==
X-CSE-MsgGUID: e/ijHY5+TLyvOAkq7nwXgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29447834"
Received: from unknown (HELO vcostago-mobl3) ([10.124.220.153])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 12:15:26 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: amir73il@gmail.com, hu1.chen@intel.com, miklos@szeredi.hu,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] overlayfs: Optimize override/revert creds
In-Reply-To: <20240424-befund-unantastbar-9b0154bec6e7@brauner>
References: <20240403021808.309900-1-vinicius.gomes@intel.com>
 <20240424-befund-unantastbar-9b0154bec6e7@brauner>
Date: Wed, 24 Apr 2024 12:15:25 -0700
Message-ID: <87a5liy3le.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Brauner <brauner@kernel.org> writes:

> On Tue, Apr 02, 2024 at 07:18:05PM -0700, Vinicius Costa Gomes wrote:
>> Hi,
>> 
>> Changes from RFC v3:
>>  - Removed the warning "fixes" patches, as they could hide potencial
>>    bugs (Christian Brauner);
>>  - Added "cred-specific" macros (Christian Brauner), from my side,
>>    added a few '_' to the guards to signify that the newly introduced
>>    helper macros are preferred.
>>  - Changed a few guard() to scoped_guard() to fix the clang (17.0.6)
>>    compilation error about 'goto' bypassing variable initialization;
>> 
>> Link to RFC v3:
>> 
>> https://lore.kernel.org/r/20240216051640.197378-1-vinicius.gomes@intel.com/
>> 
>> Changes from RFC v2:
>>  - Added separate patches for the warnings for the discarded const
>>    when using the cleanup macros: one for DEFINE_GUARD() and one for
>>    DEFINE_LOCK_GUARD_1() (I am uncertain if it's better to squash them
>>    together);
>>  - Reordered the series so the backing file patch is the first user of
>>    the introduced helpers (Amir Goldstein);
>>  - Change the definition of the cleanup "class" from a GUARD to a
>>    LOCK_GUARD_1, which defines an implicit container, that allows us
>>    to remove some variable declarations to store the overriden
>>    credentials (Amir Goldstein);
>>  - Replaced most of the uses of scoped_guard() with guard(), to reduce
>>    the code churn, the remaining ones I wasn't sure if I was changing
>>    the behavior: either they were nested (overrides "inside"
>>    overrides) or something calls current_cred() (Amir Goldstein).
>> 
>> New questions:
>>  - The backing file callbacks are now called with the "light"
>>    overriden credentials, so they are kind of restricted in what they
>>    can do with their credentials, is this acceptable in general?
>
> Until we grow additional users, I think yes. Just needs to be
> documented.
>

Will add some documentation for it, then.

>>  - in ovl_rename() I had to manually call the "light" the overrides,
>>    both using the guard() macro or using the non-light version causes
>>    the workload to crash the kernel. I still have to investigate why
>>    this is happening. Hints are appreciated.
>
> Do you have a reproducer? Do you have a splat from dmesg?

Just to be sure, with this version of the series the crash doesn't
happen. It was only happening when I was using the guard() macro
everywhere.

I just looked at my crash collection and couldn't find the splats, from
what I remember I lost connection to the machine, and wasn't able to
retrieve the splat.

I believe the crash and clang 17 compilation error point to the same
problem, that in ovl_rename() some 'goto' skips the declaration of the
(implicit) variable that the guard() macro generates. And it ends up
doing a revert_creds_light() on garbage memory when ovl_rename()
returns.

(if you want I can try and go back to "guard() everywhere" and try a bit
harder to get a splat)

Does that make sense?


Cheers,
-- 
Vinicius

