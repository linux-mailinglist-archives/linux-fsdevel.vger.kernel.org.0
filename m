Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9EC3BA013
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 13:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhGBLxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 07:53:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9446 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhGBLxB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 07:53:01 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GGYGZ6gZlzZmnq;
        Fri,  2 Jul 2021 19:47:18 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Jul 2021 19:50:27 +0800
Received: from [127.0.0.1] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 2 Jul 2021
 19:50:26 +0800
Subject: Re: [PATCH -next 1/1] iomap: Fix a false positive of UBSAN in
 iomap_seek_data()
To:     Christoph Hellwig <hch@infradead.org>
CC:     "Darrick J . Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210702092109.2601-1-thunder.leizhen@huawei.com>
 <YN7dn08eeUXfixJ7@infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2ce02a7f-4b8b-5a86-13ee-097aff084f82@huawei.com>
Date:   Fri, 2 Jul 2021 19:50:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YN7dn08eeUXfixJ7@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/7/2 17:34, Christoph Hellwig wrote:
> We might as well just kill off the length variable while we're at it:

Hi, Christoph:
  Maybe you need to write a separate patch. Because the patch I sent is
to modify function iomap_seek_data(). I didn't look at the other functions.
In fact, both iomap_seek_data() and iomap_seek_hole() need to be modified.
The iomap_seek_data() may not be intuitive to delete the variable 'length'.

I'm now analyzing if the "if (length <= 0)" statement in iomap_seek_data()
is redundant (the condition is never true).

> 
> 
> diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
> index dab1b02eba5b7f..942e354e9e13e6 100644
> --- a/fs/iomap/seek.c
> +++ b/fs/iomap/seek.c
> @@ -35,23 +35,21 @@ loff_t
>  iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
>  {
>  	loff_t size = i_size_read(inode);
> -	loff_t length = size - offset;
>  	loff_t ret;
>  
>  	/* Nothing to be found before or beyond the end of the file. */
>  	if (offset < 0 || offset >= size)
>  		return -ENXIO;
>  
> -	while (length > 0) {
> -		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
> -				  &offset, iomap_seek_hole_actor);
> +	while (offset < size) {
> +		ret = iomap_apply(inode, offset, size - offset, IOMAP_REPORT,
> +				  ops, &offset, iomap_seek_hole_actor);
>  		if (ret < 0)
>  			return ret;
>  		if (ret == 0)
>  			break;
>  
>  		offset += ret;
> -		length -= ret;
>  	}
>  
>  	return offset;
> 
> .
> 

