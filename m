Return-Path: <linux-fsdevel+bounces-14949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44C3881C73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 07:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EB11C211C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 06:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECD3C484;
	Thu, 21 Mar 2024 06:23:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C11B65F;
	Thu, 21 Mar 2024 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711002191; cv=none; b=gjiczCujazb4zGxFxhNnnXJrFlRMn23NLlyPkQcScA+dI+5yjse2yD0QWh8BvSWNEQbhy37mZjrAKiSnzDns7RXGj5u6tPZDQ0Z/ZU1+vzRCWZBBS/jRoI108FbkEeYgs/puPx947RyOSqU8UHulMOwSHEbj6FjT+enNgIAU1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711002191; c=relaxed/simple;
	bh=YEOKa55QNfkiCnm4OazkRensE/FDW6AePGPhek4TBzQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kocOqJQgo9rp0vbqwwQwGnotUA0NgpNSqRuNysQ96g6FPcqz0UuUCbGl77tjkCVkIexUH1jUKrmTuX7OMq5PelSJMO8rDfCI5GlnqydEjNtqXv8RDnAebf0C3xOgvCrzhWeVkaToaadkeDWKgydAGTUxrET3VonoOvycizOQk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V0b3x6PfVz4f3lDd;
	Thu, 21 Mar 2024 14:22:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D10871A0172;
	Thu, 21 Mar 2024 14:23:01 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgAHW21E0vtl4BL1Hg--.50963S2;
	Thu, 21 Mar 2024 14:23:01 +0800 (CST)
Subject: Re: [PATCH 4/6] writeback: add wb_monitor.py script to monitor
 writeback info on bdi
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, bfoster@redhat.com, jack@suse.cz, dsterba@suse.com,
 mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-5-shikemeng@huaweicloud.com>
 <Zfr80KXrxyf_nJAz@mtj.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <c9b3f011-a54e-9a21-4ede-b7d0f596047b@huaweicloud.com>
Date: Thu, 21 Mar 2024 14:22:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zfr80KXrxyf_nJAz@mtj.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHW21E0vtl4BL1Hg--.50963S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr18Kr1fZrW7uF47KF13CFg_yoWxtwc_Z3
	yjy3W8Aa98Ga1rZ3WIgFZxXr1DGws0ka43Xry3Grsxt34FqFWkXF1kZrn3AayxAF1DZFnI
	kF1fuw43Cr45ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/20/2024 11:12 PM, Tejun Heo wrote:
> On Wed, Mar 20, 2024 at 07:02:20PM +0800, Kemeng Shi wrote:
>> Add wb_monitor.py script to monitor writeback information on backing dev
>> which makes it easier and more convenient to observe writeback behaviors
>> of running system.
>>
>> This script is based on copy of wq_monitor.py.
> 
> I don't think I did that when wq_monitor.py was added but would you mind
> adding an example output so that people can have a better idea on what to
> expect?
Sorry for the confusion. What I mean is that wb_monitor.py is initially copy
from wq_monitor.py and then is modified to monitor writeback info. I will
correct the description and add the example outputs.

Thanks

> 
> Thanks.
> 


