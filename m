Return-Path: <linux-fsdevel+bounces-11967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A69859A89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 02:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE22B20C47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 01:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912A82103;
	Mon, 19 Feb 2024 01:27:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1A394;
	Mon, 19 Feb 2024 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708306045; cv=none; b=aPOsKMcymPKFmTPNOSwOT3HBfe3MHF1hKFB8Vryvu2Zj5kD3eo/suvnSlBK+JcZwA8l47urCyfpQi436E1wyMpoU2YWfha1Ls+mL0liUbt1CusV2Bef1vH2xJeA8sfn1u33CmW40jjZ7mAEgFGp/s2h0SeApIJs3/8A0IWvCRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708306045; c=relaxed/simple;
	bh=nZlbLHyY0YVnKcaZOenBPUXzs5bUv0S9z+LEegjabiw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TFhbol7Fj6RmGvduu0/roowRmjyVjDkBLUIhuK0j1EpxCusoeNPqyOKPJuqM9XLSk5gx4+qG2lvhV3jdfjlZCoNPnNX3KfRFB9zRJQA1XM1b3xWVAWHtPhSYUzAlOlvNeKA0mT8wRdBP12VGtaibA//RI4FgelpIizmdbdCRb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TdPz56pTPz4f3jMl;
	Mon, 19 Feb 2024 09:27:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CEEE21A0175;
	Mon, 19 Feb 2024 09:27:18 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBF0rtJlCMbOEQ--.37361S3;
	Mon, 19 Feb 2024 09:27:18 +0800 (CST)
Subject: Re: [RFC PATCH v3 08/26] iomap: add pos and dirty_len into
 trace_iomap_writepage_map
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
 djwong@kernel.org, willy@infradead.org, zokeefe@google.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 wangkefeng.wang@huawei.com
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-9-yi.zhang@huaweicloud.com>
 <Zcm0c7aMoWp7mPST@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <f27e25cb-5407-4bf5-13ce-bae4e5b4c111@huaweicloud.com>
Date: Mon, 19 Feb 2024 09:27:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zcm0c7aMoWp7mPST@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBnOBF0rtJlCMbOEQ--.37361S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYs7kC6x804xWl14x267AKxVW5JVWrJwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
	Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IUbG2NtUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/2/12 14:02, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Can you submit this for inclusion in the vfs tree?
> .
> 
Sure, I will send it out separately.

Thanks,
Yi.


