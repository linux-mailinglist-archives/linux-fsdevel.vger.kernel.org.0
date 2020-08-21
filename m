Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F4E24C991
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 03:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHUBh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 21:37:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726803AbgHUBh1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:37:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1D640FABB2D3D12F11C1;
        Fri, 21 Aug 2020 09:37:25 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 21 Aug
 2020 09:37:20 +0800
Subject: Re: [PATCH 2/2] f2fs: Return EOF on unaligned end of file DIO read
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        <viro@zeniv.linux.org.uk>, <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel@collabora.com>
References: <20200819200731.2972195-1-krisman@collabora.com>
 <20200819200731.2972195-3-krisman@collabora.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1c036ee5-a864-f50d-d439-e2d520e18b32@huawei.com>
Date:   Fri, 21 Aug 2020 09:37:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200819200731.2972195-3-krisman@collabora.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/8/20 4:07, Gabriel Krisman Bertazi wrote:
> Reading past end of file returns EOF for aligned reads but -EINVAL for
> unaligned reads on f2fs.  While documentation is not strict about this
> corner case, most filesystem returns EOF on this case, like iomap
> filesystems.  This patch consolidates the behavior for f2fs, by making
> it return EOF(0).
> 
> it can be verified by a read loop on a file that does a partial read
> before EOF (A file that doesn't end at an aligned address).  The
> following code fails on an unaligned file on f2fs, but not on
> btrfs, ext4, and xfs.
> 
>    while (done < total) {
>      ssize_t delta = pread(fd, buf + done, total - done, off + done);
>      if (!delta)
>        break;
>      ...
>    }
> 
> It is arguable whether filesystems should actually return EOF or
> -EINVAL, but since iomap filesystems support it, and so does the
> original DIO code, it seems reasonable to consolidate on that.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
