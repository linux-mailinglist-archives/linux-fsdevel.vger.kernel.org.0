Return-Path: <linux-fsdevel+bounces-17663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE87C8B131B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 21:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CE01C22D94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 19:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF1D1DA20;
	Wed, 24 Apr 2024 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8jCInls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944561CD23;
	Wed, 24 Apr 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985320; cv=none; b=TxfrnL6ivfSkLpxun9Gnbz30n6vpQSBXK/qhrBNjUcZzZviyZAn/ZDRbtBnr4Zw7m/cmfZA4PKd46W7gMZIlH3hu6WDwwaXNVh2yT+QwwBeKZ32jvwsPXpQKyafYx4gEKBTYp+LnaRes4vHSdniL2Ru6G/SKX1X3FozofIzeEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985320; c=relaxed/simple;
	bh=Q29+WUKSF1/TImyYIfU6qDFvpXG3ngAxtBKm3rf53yo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WBm6cm+dznZ8lGNT4Ft8LhPgu4Zu7ZNBp+5YoApMpkvQh5SYBiXuYbO9BlSOs0swJzeygixHQm6XyT+BYLh21Ri06+LzY134uRt18FBH+F8kvJ6sNaVFf6lJJyP33ekqlir1oDICB+BC1MHPoBEZBAvmGVs30aOVAwYcd1o5+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8jCInls; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713985318; x=1745521318;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Q29+WUKSF1/TImyYIfU6qDFvpXG3ngAxtBKm3rf53yo=;
  b=K8jCInlsDGfHGLBmaM3hKBGRYTMg8rFSZZan5ZjRuGPTAPCIUIYuQEix
   u7tFCBXQlCDsyBX59uAW60wUKm87oA/+vQLvkhvCf0b3p9IDrx4eM8Pn0
   HsQujXak9s2EwJUQDezrn+x9XqH/ze0r5S1DEuoO3lKQEK6qYg0JyqsPo
   WFpdmQr7R+IuX4664vNs2+6cC4mk1FgYSQLqv8/rvgAP+M4OiHdupdqxW
   lTgQ/hBkmxuA44YlB2ymu5J6np/8wIWHV5lMs8x1FO2qVQblWFCPhYUJ3
   g8V/xY8GtgMY/qwlbKSI3LLdatdF5m0XEol7jB/sZ9OUBb0JOYwlOtwkI
   A==;
X-CSE-ConnectionGUID: Up/6OtC3TKG+7TrC0LfiIA==
X-CSE-MsgGUID: DwCI+BOwTVinKy4nJvQFJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="12573097"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="12573097"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 12:01:57 -0700
X-CSE-ConnectionGUID: So5rGAlLTeCbfb1cfq4ejw==
X-CSE-MsgGUID: gU70sMFeQ+iD9/Gl28NoFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29291859"
Received: from unknown (HELO vcostago-mobl3) ([10.124.220.153])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 12:01:55 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] overlayfs: Optimize override/revert creds
In-Reply-To: <CAJfpeguqW4mPE9UyLmccisTex_gmwq6p9_6_EfVm-1oh6CrEBA@mail.gmail.com>
References: <20240403021808.309900-1-vinicius.gomes@intel.com>
 <CAJfpeguqW4mPE9UyLmccisTex_gmwq6p9_6_EfVm-1oh6CrEBA@mail.gmail.com>
Date: Wed, 24 Apr 2024 12:01:54 -0700
Message-ID: <87frvay47x.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Wed, 3 Apr 2024 at 04:18, Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>
>>  - in ovl_rename() I had to manually call the "light" the overrides,
>>    both using the guard() macro or using the non-light version causes
>>    the workload to crash the kernel. I still have to investigate why
>>    this is happening. Hints are appreciated.
>
> Don't know.  Well, there's nesting (in ovl_nlink_end()) but I don't
> see why that should be an issue.
>
> I see why Amir suggested moving away from scoped guards, but that also
> introduces the possibility of subtle bugs if we don't audit every one
> of those sites carefully...
>
> Maybe patchset should be restructured to first do the
> override_creds_light() conversion without guards, and then move over
> to guards.   Or the other way round, I don't have a preference.  But
> mixing these two independent changes doesn't sound like a great idea
> in any case.

Sounds good. Here's I am thinking:

patch 1: introduce *_creds_light()
patch 2: move backing-file.c to *_creds_light()
patch 3: move overlayfs to *_creds_light()
patch 4: introduce the guard helpers
patch 5: move backing-file.c to the guard helpers
patch 6: move overlayfs to the guard helpers

(and yeah, the subject of the patches will be better than these ;-)

Is this what you had in mind?


Cheers,
-- 
Vinicius

