Return-Path: <linux-fsdevel+bounces-8221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3933C831178
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 03:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4843F1C224B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 02:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE032568B;
	Thu, 18 Jan 2024 02:43:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF225395;
	Thu, 18 Jan 2024 02:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705545783; cv=none; b=dG/usc+xSI+IOiuohZ6Qjz+yya5+BiwnUGQd2m52UDp+sotUrkiOE6Q7TDtFN7UzY8FLScNekwDMFxmraV0pINz44e5q4gg8aWDPnZKwU8+ykonnHO9jyv8sm4Qe8SMObE+SsiKsT9emharBuizg71tmId2gxYhiLM4wB+UEzFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705545783; c=relaxed/simple;
	bh=Sp48v75ABExvC+ONuT5IJSIo3WgvpDaJdKPbvchyrsY=;
	h=X-Alimail-AntiSpam:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=dzo50tGvOfyLt7V6dRAfUnHC00Hsgc6diCBf5M47PJ3V3DG/gDURpuCWj32yEMy5kLuTVY2dVYktbmkgNeHg5CjX8QYHCcRoVDr25ed15SbHBWOyT75IznsQg7BZfHUaQ26pbt8QZwJR5xcSqVgxRTcsP6jsx/9ehoRrsOGAcm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W-r3A6E_1705545775;
Received: from 30.97.48.47(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W-r3A6E_1705545775)
          by smtp.aliyun-inc.com;
          Thu, 18 Jan 2024 10:42:56 +0800
Message-ID: <d5979f89-7a84-423a-a1c7-29bdbf7c2bc1@linux.alibaba.com>
Date: Thu, 18 Jan 2024 10:43:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: improve dump_mapping() robustness
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
 jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <937ab1f87328516821d39be672b6bc18861d9d3e.1705391420.git.baolin.wang@linux.alibaba.com>
 <20240118013857.GO1674809@ZenIV>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240118013857.GO1674809@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/18/2024 9:38 AM, Al Viro wrote:
> On Tue, Jan 16, 2024 at 03:53:35PM +0800, Baolin Wang wrote:
> 
>> With checking the 'dentry.parent' and 'dentry.d_name.name' used by
>> dentry_name(), I can see dump_mapping() will output the invalid dentry
>> instead of crashing the system when this issue is reproduced again.
> 
>>   	dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
>> -	if (get_kernel_nofault(dentry, dentry_ptr)) {
>> +	if (get_kernel_nofault(dentry, dentry_ptr) ||
>> +	    !dentry.d_parent || !dentry.d_name.name) {
>>   		pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
>>   				a_ops, ino, dentry_ptr);
>>   		return;
> 
> That's nowhere near enough.  Your ->d_name.name can bloody well be pointing
> to an external name that gets freed right under you.  Legitimately so.
> 
> Think what happens if dentry has a long name (longer than would fit into
> the embedded array) and gets renamed name just after you copy it into
> a local variable.  Old name will get freed.  Yes, freeing is RCU-delayed,
> but I don't see anything that would prevent your thread losing CPU
> and not getting it back until after the sucker's been freed.

Yes, that's possible. And this appears to be a use-after-free issue in 
the existing code, which is different from the issue that my patch 
addressed.

So how about adding a rcu_read_lock() before copying the dentry to a 
local variable in case the old name is freed?

