Return-Path: <linux-fsdevel+bounces-14072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BAF877532
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 04:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5137E1C21147
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 02:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482A11187;
	Sun, 10 Mar 2024 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hevEjtdC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA306F503;
	Sun, 10 Mar 2024 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710039591; cv=none; b=j+xdQ4heKaNKY2ZSyDzKVra+VJE4EqlK4pKrrMSoHCdo5HRh6IJx1IxyqDHZ/8FvDxf/h78k8xNNN3hArrMwGHl1ESNJzUXY6sooGd9x6Ygl9T6rnul3FKe2NCLXufPGLLnwvx2r07e3emPBNPmhaqdhF+/mcPDU1RLPkwOyB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710039591; c=relaxed/simple;
	bh=GfXW4C6GlijK82l5vOoVk6CS8xy/zjIX2B+QiJxYiv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIx7thEx9dJ9wyAJfJK+Hcl5oDsB1eWqUioR1aubbJyis/MPJk68knxkhTcBkLJBweA8Q/0CEUSE4o40/g5NuFvxBKX4tzbyec0TKVckHPo8GSHzkj5LKyfA25JFKYs7tmvp5sI80di3++pAGEhwBHrVada+m3uLXzp5qGQ5hV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hevEjtdC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710039589; x=1741575589;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GfXW4C6GlijK82l5vOoVk6CS8xy/zjIX2B+QiJxYiv4=;
  b=hevEjtdCJBvIuveH/5x50LH5PrXLfOFhU9x4PDE9yAJYYHYNXoBdfU3T
   PUD2m4hQki75dSpKLK8AMWHUIoPNLVcvQ0YckOkceS6dTKxrE6p8CVD5l
   M/CSitwOtaSM65sHxzb3HyKWYA61Q7h5RjtldcFaAiVYu3qO4pz3Jb7oc
   VHUL7p6Y2zY4a45LgEKbHDvRFOti/lx3IvmrzUv7h1XnGkkZb63uqMMxC
   dNjO9tApfS+Dgb01+ia9/lAQDGIj7UAn3Ac9/zd599MAfhBEFTaO5U89P
   gqtB3Je3D4B4kXq6h6m1Q7NXo0s19SZcv05NkQn1tJ+I3wkgC0jq9A3A6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4652779"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="4652779"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 18:59:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="10922168"
Received: from leihuan1-mobl.amr.corp.intel.com (HELO [10.0.2.15]) ([10.124.0.187])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 18:59:48 -0800
Message-ID: <0fcdb6bc-68e6-639b-4710-7aaadda62ae1@linux.intel.com>
Date: Sat, 9 Mar 2024 21:59:33 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] fs/fuse: Fix missing FOLL_PIN for direct-io
To: Miklos Szeredi <miklos@szeredi.hu>,
 Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
 <CAJfpegtX_XAHhHS4XN1-=cOHy0ZUSxuA_OQO5tdujLVJdE1EdQ@mail.gmail.com>
 <a77853da-31e3-4a7c-9e1c-580a8136c3bf@fastmail.fm>
 <CAJfpeguuRXO01hdmEr5ffMUNDyp5VPTYToOENjacYNAd1nu6Rw@mail.gmail.com>
Content-Language: en-US
From: Lei Huang <lei.huang@linux.intel.com>
In-Reply-To: <CAJfpeguuRXO01hdmEr5ffMUNDyp5VPTYToOENjacYNAd1nu6Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you very much, Miklos!

Yes. It is not easy to reproduce the issues in real applications. We 
only observed the issue in our own testing tool which runs multiple 
tests concurrently. We have not been able reproduce it with simple code yet.

-lei

On 3/6/24 07:05, Miklos Szeredi wrote:
> On Wed, 6 Mar 2024 at 12:16, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 3/6/24 11:01, Miklos Szeredi wrote:
>>> On Tue, 29 Aug 2023 at 20:37, Lei Huang <lei.huang@linux.intel.com> wrote:
>>>>
>>>> Our user space filesystem relies on fuse to provide POSIX interface.
>>>> In our test, a known string is written into a file and the content
>>>> is read back later to verify correct data returned. We observed wrong
>>>> data returned in read buffer in rare cases although correct data are
>>>> stored in our filesystem.
>>>>
>>>> Fuse kernel module calls iov_iter_get_pages2() to get the physical
>>>> pages of the user-space read buffer passed in read(). The pages are
>>>> not pinned to avoid page migration. When page migration occurs, the
>>>> consequence are two-folds.
>>>>
>>>> 1) Applications do not receive correct data in read buffer.
>>>> 2) fuse kernel writes data into a wrong place.
>>>>
>>>> Using iov_iter_extract_pages() to pin pages fixes the issue in our
>>>> test.
>>>>
>>>> An auxiliary variable "struct page **pt_pages" is used in the patch
>>>> to prepare the 2nd parameter for iov_iter_extract_pages() since
>>>> iov_iter_get_pages2() uses a different type for the 2nd parameter.
>>>>
>>>> Signed-off-by: Lei Huang <lei.huang@linux.intel.com>
>>>
>>> Applied, with a modification to only unpin if
>>> iov_iter_extract_will_pin() returns true.
>>
>> Hi Miklos,
>>
>> do you have an idea if this needs to be back ported and to which kernel
>> version?
>> I had tried to reproduce data corruption with 4.18 - Lei wrote that he
>> could see issues with older kernels as well, but I never managed to
>> trigger anything on 4.18-RHEL. Typically I use ql-fstest
>> (https://github.com/bsbernd/ql-fstest) and even added random DIO as an
>> option - nothing report with weeks of run time. I could try again with
>> more recent kernels that have folios.
> 
> I don't think that corruption will happen in real life.  So I'm not
> sure we need to bother with backporting, and definitely not before
> when the infrastructure was introduced.
> 
> Thanks,
> Miklos

