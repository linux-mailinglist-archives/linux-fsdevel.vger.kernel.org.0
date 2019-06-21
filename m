Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6512C4E166
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 09:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfFUHxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 03:53:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfFUHxX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 03:53:23 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9EFF5BE07A469CE25F30;
        Fri, 21 Jun 2019 15:53:17 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 15:53:08 +0800
Subject: Re: [PATCH v2 2/8] staging: erofs: add compacted compression indexes
 support
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Du Wei <weidu.du@huawei.com>
References: <20190620160719.240682-1-gaoxiang25@huawei.com>
 <20190620160719.240682-3-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4274208b-63bc-6dfd-a2c8-a94d2fa5c8d7@huawei.com>
Date:   Fri, 21 Jun 2019 15:53:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190620160719.240682-3-gaoxiang25@huawei.com>
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
> This patch aims at compacted compression indexes:
>  1) cleanup z_erofs_map_blocks_iter and move into zmap.c;
>  2) add compacted 4/2B decoding support.
> 
> On kirin980 platform, sequential read is increased about
> 6% (725MiB/s -> 770MiB/s) on enwik9 dataset if compacted 2B
> feature is enabled.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> +static int vle_legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> +					     unsigned long lcn)
> +{
> +	struct inode *const inode = m->inode;
> +	struct erofs_vnode *const vi = EROFS_V(inode);
> +	const erofs_off_t ibase = iloc(EROFS_I_SB(inode), vi->nid);
> +	const erofs_off_t pos = Z_EROFS_VLE_EXTENT_ALIGN(ibase +
> +							 vi->inode_isize +
> +							 vi->xattr_isize) +
> +		16 + lcn * sizeof(struct z_erofs_vle_decompressed_index);

use macro instead of raw number?

Thanks,
