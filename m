Return-Path: <linux-fsdevel+bounces-18789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6595A8BC5B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 04:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A74CCB2152D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 02:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEB43FB89;
	Mon,  6 May 2024 02:15:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84215EAD2;
	Mon,  6 May 2024 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714961721; cv=none; b=j8vEbYinYUicSawowNgppf5t1pajo/Bbu5JL0+kQIGo1iJAMgR9/EUzKp74idjbz0ExiAQdQ9xEyNIlUYfxUrmQORth3kpwrn8Nakf9S/fsJIRwPrv3CDm+jQH2w74XzPfczkFXkGtjXx3TiKxlVPAGEpU+rOHG8YFN8QibKZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714961721; c=relaxed/simple;
	bh=mUDIFPzPharsssWisgRYGdsHHuDz5PMIOIZIsfNsDNQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ET9wJc3qeZRzamk8OhSS7E4rl8RFm75JGrsUFnAxg+5M9LE7rq3ynBrNa8BoSqqDmiq7JYcy4QoxFrM52P1QcgAgyC4kWY8Od3uTnrq9fb+DYWkD9uHx1RQfsKmt3QaCIfu0Js2AVzniJg1Y3+sZS6JIcmrlsruDJl+56OAnrY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VXlNt0ByBz4f3lXb;
	Mon,  6 May 2024 10:15:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 44B631A0572;
	Mon,  6 May 2024 10:15:15 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgB3jgctPThmL6mELw--.10749S2;
	Mon, 06 May 2024 10:15:11 +0800 (CST)
Subject: Re: [PATCH 09/10] writeback: factor out wb_dirty_exceeded to remove
 repeated code
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz, tj@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <6d3471cd-f491-4949-ba75-9fae63198b59@moroto.mountain>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <a86ccc01-dbab-2880-68c3-300c257ce5e4@huaweicloud.com>
Date: Mon, 6 May 2024 10:15:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6d3471cd-f491-4949-ba75-9fae63198b59@moroto.mountain>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB3jgctPThmL6mELw--.10749S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFykXryDWw18uF4DAFy8AFb_yoW8Gw18pF
	4rua98KF4rXr1xtayDJrW7Za1Yqws5Jw17WwnxWw1fZFW29F9Fgr1I9rWagrsF9rn7KryY
	yrsIvFyDtw1UK3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/


on 4/30/2024 3:24 PM, Dan Carpenter wrote:
> Hi Kemeng,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kemeng-Shi/writeback-factor-out-wb_bg_dirty_limits-to-remove-repeated-code/20240429-114903
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240429034738.138609-10-shikemeng%40huaweicloud.com
> patch subject: [PATCH 09/10] writeback: factor out wb_dirty_exceeded to remove repeated code
> config: i386-randconfig-141-20240429 (https://download.01.org/0day-ci/archive/20240430/202404300231.bnb28iB8-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202404300231.bnb28iB8-lkp@intel.com/
> 
> New smatch warnings:
> mm/page-writeback.c:1903 balance_dirty_pages() error: we previously assumed 'mdtc' could be null (see line 1886)
Will fix this in next version. Thanks a lot for the report.

Kemeng


