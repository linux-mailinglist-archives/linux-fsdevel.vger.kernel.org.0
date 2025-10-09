Return-Path: <linux-fsdevel+bounces-63668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB4FBC9B6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 17:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 247DC345649
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF411F12E9;
	Thu,  9 Oct 2025 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMWKINTX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51D21B81D3;
	Thu,  9 Oct 2025 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022905; cv=none; b=Lq9FDf1wNAPaeqEj5sKXus9KOmFx6jr0pwScDV+z3l2Kzj+yvJq+LbegZ9WnajFWV892Udh0orAApNxfFQgMZMbJ4oF1DU46o9Hnjzol9HkPa52wZyaUYizkJSkpfK2cPR57XKl4+qvqTXsbOch++f2uQc3UTrxu4mi/LQEpcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022905; c=relaxed/simple;
	bh=8j8r/z6+mSAv9jRtQG+nhZw4Ea8UNAt0HcGb1nWfsS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFIkgeu7G/4CgGWyHG8KVnunCRMnxm/+b3od+O/yCt5nt2+BYd0Y8t+/wsdBfKI1V7nrKSk2K4JMw+tBbe3lu4hDj+/7va/1cZk/slK3U/fv2KOMWV3YGJtChpKTJ34PMIvCWiYXbQGbz9XpDGCOtQq8dZkwE+y5ptls06T/n2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMWKINTX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760022904; x=1791558904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8j8r/z6+mSAv9jRtQG+nhZw4Ea8UNAt0HcGb1nWfsS8=;
  b=VMWKINTXjbfGVSnQ7JapKqjx/sJQ5EInlL07dFAbh+iJsmj/3VdOphdn
   dDAVAFGQ8qU1Tl9GMwMEjn6+TYCLNdSNT/sWwSRTYGmfVbGcZLmrOdtCe
   Zt+mHRj9FGpt+EhlAQ//9qNIIvBh6irpi32s1oWVHOBoGKCP4AFxN65QF
   wrsFb1j5LB02wjrBgQZMyUf/Cqq4XNb/I0RPJWMzSqa/xofJh42Jp2UoZ
   7IRE1R1942y1thhEcP9RiVaLpJ0ahq0isdB47KQBirHF/peNNAk3eqXTT
   6JoPb/crfbD9d7oyPuikxL6TRlsL58BSudJCF2hRdZW7VbznNisUI3THy
   A==;
X-CSE-ConnectionGUID: r+bpg4Q+R1+h/o6ygK1O7A==
X-CSE-MsgGUID: Z2sjY5z4RFGcx61FcW1pmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="72915283"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="72915283"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 08:15:02 -0700
X-CSE-ConnectionGUID: jzZtpRVYQyS7NJEG27gY3A==
X-CSE-MsgGUID: vFc4sSeLRhWjzz5bwS2M3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="186004030"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.111.11]) ([10.125.111.11])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 08:15:01 -0700
Message-ID: <486185f6-7da7-4fdc-9206-8f1eebd341cf@intel.com>
Date: Thu, 9 Oct 2025 08:15:00 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: move prefaulting out of hot write path
To: "Darrick J. Wong" <djwong@kernel.org>, alexjlzheng@gmail.com,
 dave.hansen@linux.intel.com
Cc: brauner@kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jinliang Zheng <alexjlzheng@tencent.com>
References: <20251009090851.2811395-1-alexjlzheng@tencent.com>
 <20251009150125.GD6188@frogsfrogsfrogs>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20251009150125.GD6188@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/25 08:01, Darrick J. Wong wrote:
> On Thu, Oct 09, 2025 at 05:08:51PM +0800, alexjlzheng@gmail.com wrote:
>> From: Jinliang Zheng <alexjlzheng@tencent.com>
>>
>> Prefaulting the write source buffer incurs an extra userspace access
>> in the common fast path. Make iomap_write_iter() consistent with
>> generic_perform_write(): only touch userspace an extra time when
>> copy_folio_from_iter_atomic() has failed to make progress.
>>
>> This patch is inspired by commit 665575cff098 ("filemap: move
>> prefaulting out of hot write path").
> Seems fine to me, but I wonder if dhansen has any thoughts about this
> patch ... which exactly mirrors one he sent eight months ago?

I don't _really_ care all that much. But, yeah, I would have expected
a little shout-out or something when someone copies the changelog and
code verbatim from another patch:

	https://lore.kernel.org/lkml/20250129181753.3927F212@davehans-spike.ostc.intel.com/

and then copies a comment from a second patch I did.

But I guess I was cc'd at least. Also, if my name isn't on this one,
then I don't have to fix any of the bugs it causes. Right? ;)

Just one warning: be on the lookout for bugs in the area. The
prefaulting definitely does a good job of hiding bugs in other bits
of the code. The generic_perform_write() gunk seems to have uncovered
a bug or two.

Also, didn't Christoph ask you to make the comments wider the last
time Alex posted this? I don't think that got changed.

	https://lore.kernel.org/lkml/aIt8BYa6Ti6SRh8C@infradead.org/

Overall, the change still seems as valid to me as it did when I wrote the
patch in the first place. Although it feels funny to ack my own
patch.

