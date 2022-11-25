Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578B46384CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 08:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKYHw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 02:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKYHw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:52:58 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8DC1F2CD;
        Thu, 24 Nov 2022 23:52:56 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NJRsd0tQ9zmWC2;
        Fri, 25 Nov 2022 15:52:21 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 15:52:55 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 15:52:54 +0800
Subject: Re: [PATCH] pipe: fix potential use-after-free in pipe_read()
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <20221117115323.1718-1-thunder.leizhen@huawei.com>
 <Y4Bh0fTf4vZ6/6Pc@ZenIV>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <3a38686c-040a-202c-2778-7670a2b3f087@huawei.com>
Date:   Fri, 25 Nov 2022 15:52:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y4Bh0fTf4vZ6/6Pc@ZenIV>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/11/25 14:33, Al Viro wrote:
> On Thu, Nov 17, 2022 at 07:53:23PM +0800, Zhen Lei wrote:
>> Accessing buf->flags after pipe_buf_release(pipe, buf) is unsafe, because
>> the 'buf' memory maybe freed.
> 
> Huh?  What are you talking about?
>                         struct pipe_buffer *buf = &pipe->bufs[tail & mask];
> To free *buf you would need to free the entire damn array, which is
> obviously not going to be possible here; if you are talking about reuse
> of *buf - that's controlled by pipe->tail, and we do not assign it until
> later.
> 
> Fetching any fields of *buf is safe; what can get freed is buf->page, not
> buf itself.  So that buf->flags access is fine.

Right. Thank you for explaining clearly. Sorry, I misunderstood in the
course of learning.

> 
> .
> 

-- 
Regards,
  Zhen Lei
