Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFB0459983
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 02:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhKWBMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 20:12:53 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28165 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhKWBMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 20:12:52 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HymGL11QCz8vZ2;
        Tue, 23 Nov 2021 09:07:54 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 09:09:43 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 09:09:43 +0800
Subject: Re: [PATCH 1/2] pipe: fix potential use-after-free in pipe_read()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211115035721.1909-1-thunder.leizhen@huawei.com>
 <20211115035721.1909-2-thunder.leizhen@huawei.com>
 <YZHhQ5uUJ06BOnJh@casper.infradead.org>
 <d604e5f8-128a-d25c-848d-7380a5bde609@huawei.com>
 <YZJbBNs/63pnXngK@casper.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <3d1da34f-7b47-3d19-40ce-98b62d6e6f6d@huawei.com>
Date:   Tue, 23 Nov 2021 09:09:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YZJbBNs/63pnXngK@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/11/15 21:05, Matthew Wilcox wrote:
> On Mon, Nov 15, 2021 at 02:13:44PM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/11/15 12:25, Matthew Wilcox wrote:
>>> On Mon, Nov 15, 2021 at 11:57:20AM +0800, Zhen Lei wrote:
>>>>  			if (!buf->len) {
>>>> +				unsigned int __maybe_unused flags = buf->flags;
>>>
>>> Why __maybe_unused?
>>
>> It's used only if "#ifdef CONFIG_WATCH_QUEUE". Otherwise, a warning will be reported.
> 
> Better to turn the #ifdef into if (IS_ENABLED())

Hi, Matthew:
  Thank you for your advice. IS_ENABLED() is a good idea, but when I tried it, I found that
the macro 'PIPE_BUF_FLAG_LOSS' and the structure member 'note_loss' were also separated by
"ifdef CONFIG_WATCH_QUEUE", so this method is not suitable here.

#ifdef CONFIG_WATCH_QUEUE
#define PIPE_BUF_FLAG_LOSS     0x40    /* Message loss happened after this buffer */
#endif

@@ -62,9 +60,7 @@ struct pipe_inode_info {
        unsigned int tail;
        unsigned int max_usage;
        unsigned int ring_size;
#ifdef CONFIG_WATCH_QUEUE
        bool note_loss;
#endif



> .
> 
