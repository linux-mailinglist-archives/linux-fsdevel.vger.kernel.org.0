Return-Path: <linux-fsdevel+bounces-37570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A0A9F3F9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 02:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A21F1648A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 01:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E0F20B22;
	Tue, 17 Dec 2024 01:00:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93759749C;
	Tue, 17 Dec 2024 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397199; cv=none; b=dIptsCV/bbEAjHO+VTCh2cYt3vXy/NP6f8ipLWSkCCAo1go99Cfa5i2rnGo/H8phDZG5kT3t0cYQ79ckrCvyjD3ViFKG90K3v5bIx0zGAILe7pu6fMXka5adOvo6KYvoYUKgrHNGFXC57LDmVmZ+XSvbPp5fWZ2fA0ZqN19izuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397199; c=relaxed/simple;
	bh=PmN5/GP7ybgzjspT53z+h4EQv3Om4TXSPX7BJllmejs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=D5u95e7dhu1t0IF7uc33ApapQ8DvBKsKibolgbgebWOR4ly2PQ+MsOvp/hAhI59m0TdGQe/jskB12NQDNLxTAOu48WnLygq1USb8393y5f2F5zSuA448q57TUmBL7Jk7av0o2xXZbRW38i1OML3MZA32Wrmouk/JtrC+7073Rgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YBz3t6TxYz4f3jqM;
	Tue, 17 Dec 2024 08:59:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 53C091A0359;
	Tue, 17 Dec 2024 08:59:53 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgAXd+MHzWBnW3wdEw--.2904S2;
	Tue, 17 Dec 2024 08:59:53 +0800 (CST)
Subject: Re: [PATCH v3 1/5] Xarray: Do not return sibling entries from
 xas_find_marked()
To: Matthew Wilcox <willy@infradead.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org
References: <20241213122523.12764-1-shikemeng@huaweicloud.com>
 <20241213122523.12764-2-shikemeng@huaweicloud.com>
 <1f8b523e-d68f-4382-8b1e-2475eb47ae81@linux.alibaba.com>
 <5d89f26a-8ac9-9768-5fc7-af155473f396@huaweicloud.com>
 <Z2AzgqT7LCcT-BGr@casper.infradead.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <3278a51d-32e0-5c89-a5e5-b6f17af8ebde@huaweicloud.com>
Date: Tue, 17 Dec 2024 08:59:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z2AzgqT7LCcT-BGr@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXd+MHzWBnW3wdEw--.2904S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYx7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
	r21l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
	VFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 12/16/2024 10:04 PM, Matthew Wilcox wrote:
> On Mon, Dec 16, 2024 at 03:05:26PM +0800, Kemeng Shi wrote:
>> Ahhh, right. Thank you for correcting me. Then I would like to use nfs as low-level
>>  filesystem in example and the potential crash could be triggered in the same steps.
> 
> Have you actually seen this crash, or do you just think it can happen?
> 
I just think it can happen. Sorry for confusion...


