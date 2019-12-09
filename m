Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4FB116515
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 03:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLICoJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sun, 8 Dec 2019 21:44:09 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2528 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726659AbfLICoJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 21:44:09 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 21C2E1A06C04F490431D;
        Mon,  9 Dec 2019 10:44:07 +0800 (CST)
Received: from dggeme716-chm.china.huawei.com (10.1.199.112) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 9 Dec 2019 10:44:06 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme716-chm.china.huawei.com (10.1.199.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 9 Dec 2019 10:44:06 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Mon, 9 Dec 2019 10:44:06 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Davide Libenzi <davidel@xmailserver.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: eventfd: fix obsolete comment
Thread-Topic: [PATCH] fs: eventfd: fix obsolete comment
Thread-Index: AdWuOLFQ36TDuRuGSpCh3xTGQtMBOQ==
Date:   Mon, 9 Dec 2019 02:44:06 +0000
Message-ID: <d23f9f8e10854e0faca4e05fedc0df95@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.189.20]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:
>On Sat, Dec 07, 2019 at 03:45:33PM +0800, linmiaohe wrote:
>> From: Miaohe Lin <linmiaohe@huawei.com>
>> 
>>   *
>> - * eventfd_fget
>> + * fdget
>
>But this is wrong.  The error pointer is returned from eventfd_ctx_fileget(), not from fdget.
>
>Looking at the three callers of eventfd_ctx_fileget(), I think it would make sense to do this:

Many thanks for your review and nice advice. But I think this patch should belong to you as you found this.
I really did nothing about it. Maybe a Reviewed-by tag for me is enough.

>diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c index 997cb5d0a657..c35b614e3770 100644
>--- a/drivers/vfio/virqfd.c
>+++ b/drivers/vfio/virqfd.c
>@@ -126,11 +126,6 @@ int vfio_virqfd_enable(void *opaque,
> 	INIT_WORK(&virqfd->inject, virqfd_inject);
> 
> 	irqfd = fdget(fd);
>-	if (!irqfd.file) {
>-		ret = -EBADF;
>-		goto err_fd;
>-	}
>-
> 	ctx = eventfd_ctx_fileget(irqfd.file);
> 	if (IS_ERR(ctx)) {
> 		ret = PTR_ERR(ctx);

The err_fd label should further be removed, as after this change, it's no longer used.
Other callers should drop unused jump label too.

>(not even compile tested)

Thanks again.
