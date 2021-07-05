Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381483BB60F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 06:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhGEEIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 00:08:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6392 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhGEEIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 00:08:12 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GJBpS5YRFz76sn;
        Mon,  5 Jul 2021 12:02:08 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 12:05:34 +0800
Received: from [127.0.0.1] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 5 Jul 2021
 12:05:33 +0800
Subject: Re: [PATCH -next 1/1] iomap: Fix a false positive of UBSAN in
 iomap_seek_data()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210702092109.2601-1-thunder.leizhen@huawei.com>
 <YN7dn08eeUXfixJ7@infradead.org>
 <2ce02a7f-4b8b-5a86-13ee-097aff084f82@huawei.com>
 <9a619cb0-e998-83e5-8e42-d3606ab682e0@huawei.com>
 <YOJ/2xrQ75Ttp6R3@casper.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a322bf41-f1d0-eac7-20d9-b4273ce122d0@huawei.com>
Date:   Mon, 5 Jul 2021 12:05:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YOJ/2xrQ75Ttp6R3@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/7/5 11:43, Matthew Wilcox wrote:
> On Mon, Jul 05, 2021 at 11:29:44AM +0800, Leizhen (ThunderTown) wrote:
>> I've thought about it, and that "if" statement can be removed as follows:
> 
> I think this really misses Christoph's point.  He's looking for
> something more like this:

Yes, I know that. I need to get rid of the "if" judgment first, and then I can
modify iomap_seek_data() according to Christoph's point. Otherwise there are too
many conversions from "length" to "size - offset" and the code doesn't look clear.

> 
> @@ -83,27 +83,23 @@ loff_t
>  iomap_seek_data(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
>  {
>         loff_t size = i_size_read(inode);
> -       loff_t length = size - offset;
>         loff_t ret;
> 
>         /* Nothing to be found before or beyond the end of the file. */
>         if (offset < 0 || offset >= size)
>                 return -ENXIO;
> 
> -       while (length > 0) {
> +       while (offset < size) {
>                 ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
>                                   &offset, iomap_seek_data_actor);
>                 if (ret < 0)
>                         return ret;
>                 if (ret == 0)
> -                       break;
> +                       return offset;
> 
>                 offset += ret;
> -               length -= ret;
>         }
> 
> -       if (length <= 0)
> -               return -ENXIO;
> -       return offset;
> +       return -ENXIO;
>  }
>  EXPORT_SYMBOL_GPL(iomap_seek_data);
> 
> (not even slightly tested)
> 
> .
> 

