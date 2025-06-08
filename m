Return-Path: <linux-fsdevel+bounces-50923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E97BDAD10CF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 05:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB1816AC5B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 03:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6715D14386D;
	Sun,  8 Jun 2025 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AxnBtN1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12F033EA;
	Sun,  8 Jun 2025 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749351652; cv=none; b=bcrH2YW9mwaPnv0jX4bwQ4FqTPg9cHyE5QvIfyChcBtXk/ybmtqee/HS+ZvgWTxaxo6L3Rr5pjfo38FrxQyZxZMWnJBKsNVifp5G3auxttiwekPUHII4NKKlbA5fVRwFk5COFQB+TqAx8xRwBCNxTxWLYGJ3ZRj5IB5+KsT4YVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749351652; c=relaxed/simple;
	bh=pgEoYaq96UXgGee9vy6B9Zidl+Bge6LCL0GYfN27rhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvYkIafKFrhcPUbxn08Yq2K54lfDP2yYPzbt7KKK7bfFiuIbQF6H1iiNI9L3F4Azz09sZINjiDaEPv8soVgGmLlcqxiOEYItjHGlcaFd4klTFjgg63JWfGnyQ6YZV01vcJnM6O5HzOS3dIBiyLN5y0eq0FKqefjweOXmR9+q/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AxnBtN1O; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=fPPBCNno/uF5ptgaVsdNA9rWtdVD95OvWeemkyZaP1E=;
	b=AxnBtN1OkJHr3gYSnMuDGe0QlU57M+88By4pm/U7+wC51O+AZk3b66ejpb51R9
	DRKua2cZS+QAzR5AtixdR/i/QkAiNUvl2Y0vDvjXQlPcynMEY+AmeqkElPhCZv0K
	jxQSfxX6IcwpxuiiI3Z/03I8GK6gapr/XhNTS86L7TePA=
Received: from [192.168.5.16] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXX+C1_ERotDS5Gw--.4957S2;
	Sun, 08 Jun 2025 11:00:06 +0800 (CST)
Message-ID: <41302742-921f-44c3-819d-8ad044a7f206@163.com>
Date: Sun, 8 Jun 2025 11:00:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] readahead: fix return value of page_cache_next_miss()
 when no hole is found
To: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20250605054935.2323451-1-chizhiling@163.com>
 <qbuhdfdvbyida5y7g34o4rf5s5ntx462ffy3wso3pb5f3t4pev@3hqnswkp7of6>
 <20250605145152.9ae3edb99f29ef46b30096e4@linux-foundation.org>
 <i2zcz37av7oon464vj4jqvmyz53j46kpd6427xmpamukcqekro@hg566sdiruba>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <i2zcz37av7oon464vj4jqvmyz53j46kpd6427xmpamukcqekro@hg566sdiruba>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXX+C1_ERotDS5Gw--.4957S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFW8uw4xKr15JFykZrWfGrg_yoWktFb_XF
	40y3Z8CFn09FW7Zr4DtrsxKrWDta1UKr15t3y5tr15t395Ca93WF4kAryS9rn7Krn2krZ8
	JFy5XFZxKr10gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj3fH5UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiTxVmnWhE8d7ARAAAsm

On 2025/6/6 18:54, Jan Kara wrote:
> On Thu 05-06-25 14:51:52, Andrew Morton wrote:
>> On Thu, 5 Jun 2025 10:22:23 +0200 Jan Kara <jack@suse.cz> wrote:
>>
>>> On Thu 05-06-25 13:49:35, Chi Zhiling wrote:
>>>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>>>
>>>> max_scan in page_cache_next_miss always decreases to zero when no hole
>>>> is found, causing the return value to be index + 0.
>>>>
>>>> Fix this by preserving the max_scan value throughout the loop.
>>>>
>>>> Fixes: 901a269ff3d5 ("filemap: fix page_cache_next_miss() when no hole found")
>>>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>>>
>>> Indeed. Thanks for catching this. Don't know how I missed that. Feel free
>>> to add:
>>>
>>> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks

>>>
>>
>> Thanks.  It's a simple patch - do we expect it to have significant
>> runtime effects?
> 
> I'm not sure if Chi Zhiling observed some practical effects. From what I
> know and have seen in the past, wrong responses from page_cache_next_miss()
> can lead to readahead window reduction and thus reduced read speeds.
> 
> 								Honza

TBH, in my simple sequential reading test, I did not see any significant 
speed improvement.


