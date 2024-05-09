Return-Path: <linux-fsdevel+bounces-19193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486D88C11C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044F328198A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C87515E81F;
	Thu,  9 May 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dgJJeTI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBB1157A41;
	Thu,  9 May 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267584; cv=none; b=MzR4woCna3AMJTmrl5Mt+aDcu966QpO3iSYyhnKDYj3GY17htC3fWjqRxzWLFaE6SzDyyvsa2zGSH4YoI+tdneX5avsh6Siob8xU66QUqZPdY4JE12BLLkE1A61QWGfnUXpop1z/9ZfuMgOy1NcEgVwOniehwJJwMDBo5A638/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267584; c=relaxed/simple;
	bh=8lKKZpJbPGF4Ani9x2yzwoaFUOf2+SAvjrEoKCY/6b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqFrPz2emip760tz/O+bAEPaocavX5CeXBo3tspq3Nmg/AW1VhmXWCYuYK8gysxIyU+YKS9LvxBYm/jksn8/VnX7GdhTGaIOp+9y1HTMKLAHkCYVUtV+6PNfZb2dNKnsC9tvQiWlPMOCV2WhbL7kwfEGptQ1po09jqFWjyvHdqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dgJJeTI4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715267579;
	bh=8lKKZpJbPGF4Ani9x2yzwoaFUOf2+SAvjrEoKCY/6b8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dgJJeTI4VC6HVio0YMhzY2T/au6hlCtrozPI+CNVt9+bbNmx7HV+7eTrkp3qvF7kR
	 QyNmye2Lkapq9CscALNuaRXLgwOCpbO4sZhMqgJojh4C4+QzYxmTiw5KQ+DfQhLcmv
	 v2ilcycsTHH47XGOKy93eeD+j6coEkrPM2GFG7Md+k7TM9aX4xvMYmOQCg1INx2coG
	 BQCTviXy0QnDpUJM1VAMBcgrPnsM8uPSiO/qXBS6do9tGlv0BfaioyLkHUaLWN0NON
	 8BWw4ahwv4cJSteFjaqjBCktxCjac4BPjx+SkeUUVdKnnXN1N/V6+VQ8XgWYZTKC7I
	 dL1xcKQoBLx1w==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 80E7737811CD;
	Thu,  9 May 2024 15:12:58 +0000 (UTC)
Message-ID: <1c4eae9a-ad82-4a89-9c0e-a0d61a4667f1@collabora.com>
Date: Thu, 9 May 2024 18:12:57 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/9] Cache insensitive cleanup for ext4/f2fs
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, tytso@mit.edu,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, jaegeuk@kernel.org,
 chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, ebiggers@kernel.org
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <Zg_sF1uPG4gdnJxI@casper.infradead.org>
 <ec3a3946-d6d6-40e1-8645-34b258d8b507@collabora.com>
 <87le5r3gw7.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <87le5r3gw7.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Krisman,

On 4/5/24 19:37, Gabriel Krisman Bertazi wrote:
> Eugen Hristev <eugen.hristev@collabora.com> writes:
> 
>> On 4/5/24 15:18, Matthew Wilcox wrote:
>>> On Fri, Apr 05, 2024 at 03:13:23PM +0300, Eugen Hristev wrote:
>>>> Hello,
>>>>
>>>> I am trying to respin the series here :
>>>> https://www.spinics.net/lists/linux-ext4/msg85081.html
>>>
>>> The subject here is "Cache insensitive cleanup for ext4/f2fs".
>>> Cache insensitive means something entirely different
>>> https://en.wikipedia.org/wiki/Cache-oblivious_algorithm
>>>
>>> I suspect you mean "Case insensitive".
>>
>> You are correct, I apologize for the typo.
> 
> Heh. I completely missed it in the previous submissions. I guess we both
> just mentally auto-corrected.
> 
> Since we are here, I think I contributed to the typo in the cover letter
> with the summary lines of patch 1 and 2.  Differently from the rest of
> the series, these two are actually working on a "cache of
> casefolded strings".  But their summary lines are misleading.
> 
> Can you rename them to:
> 
> [PATCH v16 1/9] ext4: Simplify the handling of cached casefolded names
> [PATCH v16 2/9] f2fs: Simplify the handling of cached casefolded names
> 
> From a quick look, the series is looking good and the strict mode issue
> pointed in the last iteration seems fixed, though I didn't run it yet.
> I'll take a closer look later today and fully review.
> 

Have you managed to take a look ? What would be the future of the series ? I didn't
want to send another version for just a subject change, but I can if that's the
only change required .

Thanks,
Eugen

