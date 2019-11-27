Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D43A710AAC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 07:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfK0GrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 01:47:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbfK0GrJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 01:47:09 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 028AC1D2611040F19A2B;
        Wed, 27 Nov 2019 14:47:05 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 27 Nov 2019
 14:46:56 +0800
Subject: Re: [PATCH] mm/shmem.c: don't set 'seals' to 'F_SEAL_SEAL' in
 shmem_get_inode
To:     Hugh Dickins <hughd@google.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
References: <20191127040051.39169-1-yukuai3@huawei.com>
 <alpine.LSU.2.11.1911262008330.2204@eggly.anvils>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <f4ffdbc2-6728-1838-1a82-c0de4c484a54@huawei.com>
Date:   Wed, 27 Nov 2019 14:46:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1911262008330.2204@eggly.anvils>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/11/27 12:24, Hugh Dickins Wrote:
> On Wed, 27 Nov 2019, yu kuai wrote:
> 
>> 'seals' is set to 'F_SEAL_SEAL' in shmem_get_inode, which means "prevent
>> further seals from being set", thus sealing API will be useless and many
>> code in shmem.c will never be reached. For example:
> 
> The sealing API is not useless, and that code can be reached.
> 
>>
>> shmem_setattr
>> 	if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
>> 	    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
>> 		return -EPERM;
>>
>> So, initialize 'seals' to zero is more reasonable.
>>
>> Signed-off-by: yu kuai <yukuai3@huawei.com>
> 
> NAK.
> 
> See memfd_create in mm/memfd.c (code which originated in mm/shmem.c,
> then was extended to support hugetlbfs also): sealing is for memfds,
> not for tmpfs or hugetlbfs files or SHM.  Without thinking about it too
> hard, I believe that to allow sealing on tmpfs files would introduce
> surprising new behaviors on them, which might well raise security issues;
> and also be incompatible with the guarantees intended by sealing.

Thank you for your response.
Yu Kuai

