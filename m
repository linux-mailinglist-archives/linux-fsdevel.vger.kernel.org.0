Return-Path: <linux-fsdevel+bounces-18784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578528BC57D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F7B2815C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 01:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF1C3D387;
	Mon,  6 May 2024 01:36:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC62FB6;
	Mon,  6 May 2024 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714959388; cv=none; b=ZMeaL/3rzcCTLcMipI0GZXoAgq2Pmy1XZX8hy8+Ae2kEDMw4iDtt5Mma55U7jF/l2X81RqkFkSpJ/g9EGmtLpLWmqrT470AS7Kf8HXEGjUWsidIxYl4UjWFhbKTVSlsAq6pMt81sKYK5gD9yq7pq4Kd3f/LJkP44dxZmSpF+kJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714959388; c=relaxed/simple;
	bh=ag6RGZFM7m5plICBEfJons44Wjr75WLDkDSAT15eWdo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mep0QnpMWG1F56GPEEH1y779FS3qSDceav+buJZkBu/WXIJMxAIChdoap3ntnYSIs6U1oVE8JY/pwOZEhZuL98U6k7vWpXWqeORnPJfGDN4tRgxdMIyJJ/xr1wi/xTYGsmUwm36AqdyyKajonFmECCGDCZSDaBLoh8q1oC3GUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VXkWs55kQz4f3khh;
	Mon,  6 May 2024 09:36:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D7C691A016E;
	Mon,  6 May 2024 09:36:17 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgCH_nAQNDhmVahmMA--.56236S2;
	Mon, 06 May 2024 09:36:17 +0800 (CST)
Subject: Re: [PATCH 04/10] writeback use [global/wb]_domain_dirty_avail helper
 in cgwb_calc_thresh
To: Tejun Heo <tj@kernel.org>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
 <20240429034738.138609-5-shikemeng@huaweicloud.com>
 <ZjJ0P2d5v5fW5J7h@slm.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <3bbfdaa6-c212-64eb-702f-7a8e18af2c67@huaweicloud.com>
Date: Mon, 6 May 2024 09:36:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZjJ0P2d5v5fW5J7h@slm.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCH_nAQNDhmVahmMA--.56236S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5R7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UGYL9UUU
	UU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 5/2/2024 12:56 AM, Tejun Heo wrote:
> Hello,
> 
> On Mon, Apr 29, 2024 at 11:47:32AM +0800, Kemeng Shi wrote:
>> Use [global/wb]_domain_dirty_avail helper in cgwb_calc_thresh to remove
>> repeated code.
> 
> Maybe fold this into the patch to factor out domain_dirty_avail()?
> 
>> +	global_domain_dirty_avail(&gdtc, false);
>> +	wb_domain_dirty_avail(&mdtc, false);
> 
> I'd just use domain_dirty_avail(). The compiler should be able to figure out
> the branches and eliminate them and it removes an unnecessary source of
> error.
Sure, will this do this in next version.

Thanks.
> 
> Thanks.
> 


