Return-Path: <linux-fsdevel+bounces-3928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D5B7FA00F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 13:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B25FB210B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2377B28DA4;
	Mon, 27 Nov 2023 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169DC1B4;
	Mon, 27 Nov 2023 04:53:27 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sf59Z0gMNz4f3js3;
	Mon, 27 Nov 2023 20:53:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EAAAA1A08C3;
	Mon, 27 Nov 2023 20:53:23 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA5CkWRl_EpWCA--.4504S3;
	Mon, 27 Nov 2023 20:53:23 +0800 (CST)
Subject: Re: [PATCH 09/13] iomap: don't chain bios
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Chandan Babu R <chandan.babu@oracle.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20231126124720.1249310-1-hch@lst.de>
 <20231126124720.1249310-10-hch@lst.de>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <0f136350-3242-3e20-3b8a-56a39c66b001@huaweicloud.com>
Date: Mon, 27 Nov 2023 20:53:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231126124720.1249310-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgA3iA5CkWRl_EpWCA--.4504S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry3Cr48uF1fWr1DZr1UWrg_yoWkJrb_Wa
	yfXF18Cw1DXaykZa17KFy7JrWkKrWUX3s5ZrnxJrs3X34rA3s8Zr95KrnI9r1Fq3Z5WF4S
	g3W5W3yUZr42kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi, Christoph.

On 2023/11/26 20:47, Christoph Hellwig wrote:
> Back in the days when a single bio could only be filled to the hardware
> limits, and we scheduled a work item for each bio completion, chaining
> multiple bios for a single ioend made a lot of sense to reduce the number
> of completions.  But these days bios can be filled until we reach the
> number of vectors or total size limit, which means we can always fit at
> least 1 megabyte worth of data in the worst case, but usually a lot more
> due to large folios.  The only thing bio chaining is buying us now is
> to reduce the size of the allocation from an ioend with an embedded bio
> into a plain bio, which is a 52 bytes differences on 64-bit systems.
> 
> This is not worth the added complexity, so remove the bio chaining and
> only use the bio embedded into the ioend.  This will help to simplify
> further changes to the iomap writeback code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

A nice cleanup! I'm just a little curious about the writeback performance
impact of this patch. Do you have any actual test data on xfs?

Thanks,
Yi.


