Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883954287B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 09:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhJKHey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 03:34:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28913 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbhJKHew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:34:52 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HSVlD0P90zbmZH;
        Mon, 11 Oct 2021 15:28:24 +0800 (CST)
Received: from dggpeml500013.china.huawei.com (7.185.36.41) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 15:32:50 +0800
Received: from [10.174.187.161] (10.174.187.161) by
 dggpeml500013.china.huawei.com (7.185.36.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 15:32:49 +0800
To:     <xieyongji@bytedance.com>
References: <20210831103634.33-1-xieyongji@bytedance.com>
Subject: Re: [PATCH v13 00/13] Introduce VDUSE - vDPA Device in Userspace
CC:     "Fangyi (Eric)" <eric.fangyi@huawei.com>, <yebiaoxiang@huawei.com>,
        <x86@kernel.org>, <kvm@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Liuxiangdong <liuxiangdong5@huawei.com>
Message-ID: <6163E8A1.8080901@huawei.com>
Date:   Mon, 11 Oct 2021 15:32:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20210831103634.33-1-xieyongji@bytedance.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.161]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpeml500013.china.huawei.com (7.185.36.41)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Yongji.

I tried vduse with null-blk:

   $ qemu-storage-daemon \
       --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server,nowait \
       --monitor chardev=charmonitor \
       --blockdev 
driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0 
\
       --export 
type=vduse-blk,id=test,node-name=disk0,writable=on,name=vduse-null,num-queues=16,queue-size=128

The qemu-storage-daemon is yours 
(https://github.com/bytedance/qemu/tree/vduse)

And then, how can we use this vduse-null (dev/vduse/vduse-null) in vm(QEMU)?

Because qemu-storage-daemon open this vduse-null in vduse_dev_init(), 
all the operations which open this dev
will report "failed to open '/dev/vduse/vduse-null': Device or resource 
busy".

Or something I understood wrong?

Thanks!
Xiangdong Liu
