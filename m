Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 376934E49E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 11:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfFUJvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 05:51:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49964 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbfFUJvH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:51:07 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 20A01448ADF50FCA3AE8;
        Fri, 21 Jun 2019 17:51:01 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 17:50:52 +0800
Subject: Re: [PATCH v2 6/8] staging: erofs: introduce LZ4 decompression
 inplace
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Du Wei <weidu.du@huawei.com>
References: <20190620160719.240682-1-gaoxiang25@huawei.com>
 <20190620160719.240682-7-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <bf1ebb0f-3039-d7d1-95cd-f49cadd6085e@huawei.com>
Date:   Fri, 21 Jun 2019 17:50:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190620160719.240682-7-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/6/21 0:07, Gao Xiang wrote:
> compressed data will be usually loaded into last pages of
> the extent (the last page for 4k) for in-place decompression
> (more specifically, in-place IO), as ilustration below,
> 
>          start of compressed logical extent
>            |                          end of this logical extent
>            |                           |
>      ______v___________________________v________
> ... |  page 6  |  page 7  |  page 8  |  page 9  | ...
>     |__________|__________|__________|__________|
>            .                         ^ .        ^
>            .                         |compressed|
>            .                         |   data   |
>            .                           .        .
>            |<          dstsize        >|<margin>|
>                                        oend     iend
>            op                        ip
> 
> Therefore, it's possible to do decompression inplace (thus no
> memcpy at all) if the margin is sufficient and safe enough [1],
> and it can be implemented only for fixed-size output compression
> compared with fixed-size input compression.
> 
> No memcpy for most of in-place IO (about 99% of enwik9) after
> decompression inplace is implemented and sequential read will
> be improved of course (see the following patches for test results).
> 
> [1] https://github.com/lz4/lz4/commit/b17f578a919b7e6b078cede2d52be29dd48c8e8c
>     https://github.com/lz4/lz4/commit/5997e139f53169fa3a1c1b4418d2452a90b01602
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
