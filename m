Return-Path: <linux-fsdevel+bounces-70451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C04E0C9B65F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 12:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C6813461AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6231E316198;
	Tue,  2 Dec 2025 11:54:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D918310631;
	Tue,  2 Dec 2025 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676484; cv=none; b=MFQV5fstyrbkegsjHASqr6ExbI6sfmGqI5ILAH46Lqw5+paedZEy5R6IBStGloHdKWTzBQsS5Sauxh8/VTSCYXm+yXQjknT+NDegbmluQmgtbkz6jquvnsWYFst1JJMbNu/79AnHcFDFVCgvCqOuWwFUMibA66wapeaRmbHlrCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676484; c=relaxed/simple;
	bh=j1RddwWki4/IMfV0PprJIsyZKtU/vBhGoxgZ0bfGDnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAfKuT9ovvreP4aj3AEIMoSSCu3CIiVaI9hPVzR9UGncJUEm2QUhWnsneZpAn7NiKI896rq8C/Cn8cG8aqeIhd8USL2RX/VGbESuXBG4PmhoEaVv0cPjNzXU79fyNRMMz58Je3RnADm/lU6neWA6FwB21lMOAcV/n1t6bPsiNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dLK26097KzYQtnf;
	Tue,  2 Dec 2025 19:54:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A03541A0359;
	Tue,  2 Dec 2025 19:54:39 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgCXNb9+0y5ppmRYAQ--.16551S2;
	Tue, 02 Dec 2025 19:54:39 +0800 (CST)
Message-ID: <919c6fc0-afd5-49ea-ad83-aa643cc1b999@huaweicloud.com>
Date: Tue, 2 Dec 2025 19:54:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: switch to css_is_online() helper
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 jackmanb@google.com, ziy@nvidia.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251202025747.1658159-1-chenridong@huaweicloud.com>
 <dzp6jxmf5ggidkhmqabuttaotyrkxzf6ohiuzgcdn6oppkcmfc@vrjeeypoppwe>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <dzp6jxmf5ggidkhmqabuttaotyrkxzf6ohiuzgcdn6oppkcmfc@vrjeeypoppwe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCXNb9+0y5ppmRYAQ--.16551S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW5JVWrJwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVW8ZVWrXwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/2 19:01, Jan Kara wrote:
> On Tue 02-12-25 02:57:47, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Use the new css_is_online() helper that has been introduced to check css
>> online state, instead of testing the CSS_ONLINE flag directly. This
>> improves readability and centralizes the state check logic.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 

Thank you.

-- 
Best regards,
Ridong


