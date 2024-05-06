Return-Path: <linux-fsdevel+bounces-18786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90BD8BC583
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9441A282649
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 01:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8C63D0C2;
	Mon,  6 May 2024 01:38:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF62FB6;
	Mon,  6 May 2024 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714959514; cv=none; b=pV1bksU5DSXuksZv1LjKlFj3Wqv9L4foeJXzxK+m/1Ttey7Eb67oUGRNGwYy7a7Y5f7T5BCMIRQGDfZMZmwjFHfB/z+QoGvrNdzzG4jxOkXLYq34FbL/ptcm73X5lM1cMfW6x2DaLP9fq4Iws3nt9+L1naGpgBsTBx3hAyjZOts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714959514; c=relaxed/simple;
	bh=oOh2DNq/ALKOxEFuNcYkdDLDowhusytPK/KkdWzJoKI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qDh64SWHeZiWJfq+aQEKG3hIkws1PV898YyBkesG281et+kSi3pf5eTmp+ZWEJK5+wABAKOmwB++cj9HU3qM5MfeijbK/o3cgXzqlEbPkSb9FbwyiyiiwBS0Irn7him4Z4OONxc/pwkA0gKeMmEzf3815WbAnOXDK6oBBiodTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VXkZQ40CGz4f3khk;
	Mon,  6 May 2024 09:38:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A83DB1A058D;
	Mon,  6 May 2024 09:38:30 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgDX8QqWNDhmj06CLw--.5810S2;
	Mon, 06 May 2024 09:38:30 +0800 (CST)
Subject: Re: [PATCH 06/10] writeback: Factor out code of freerun to remove
 repeated code
To: Tejun Heo <tj@kernel.org>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
 <20240429034738.138609-7-shikemeng@huaweicloud.com>
 <ZjJ4pjm9073R-LH0@slm.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <9e18efb9-881e-d8ee-4acf-5e05f4c223ea@huaweicloud.com>
Date: Mon, 6 May 2024 09:38:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZjJ4pjm9073R-LH0@slm.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDX8QqWNDhmj06CLw--.5810S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5R7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UX4SrUUU
	UU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 5/2/2024 1:15 AM, Tejun Heo wrote:
>> +/*
>> + * Throttle it only when the background writeback cannot
>> + * catch-up. This avoids (excessively) small writeouts
>> + * when the wb limits are ramping up in case of !strictlimit.
>> + *
>> + * In strictlimit case make decision based on the wb counters
>> + * and limits. Small writeouts when the wb limits are ramping
>> + * up are the price we consciously pay for strictlimit-ing.
>> + */
> Can you please reflow the above to 80col or at least seventy something?
Sure, will do it in next version. Thanks.


