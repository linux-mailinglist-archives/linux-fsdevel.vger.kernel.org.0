Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3D744FE9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 07:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhKOGRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 01:17:34 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14741 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKOGRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 01:17:21 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HszNY5f9kzZd4n;
        Mon, 15 Nov 2021 14:11:41 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 14:13:56 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 14:13:56 +0800
Subject: Re: [PATCH 1/2] pipe: fix potential use-after-free in pipe_read()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211115035721.1909-1-thunder.leizhen@huawei.com>
 <20211115035721.1909-2-thunder.leizhen@huawei.com>
 <YZHhQ5uUJ06BOnJh@casper.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d604e5f8-128a-d25c-848d-7380a5bde609@huawei.com>
Date:   Mon, 15 Nov 2021 14:13:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YZHhQ5uUJ06BOnJh@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/11/15 12:25, Matthew Wilcox wrote:
> On Mon, Nov 15, 2021 at 11:57:20AM +0800, Zhen Lei wrote:
>>  			if (!buf->len) {
>> +				unsigned int __maybe_unused flags = buf->flags;
> 
> Why __maybe_unused?

It's used only if "#ifdef CONFIG_WATCH_QUEUE". Otherwise, a warning will be reported.

> .
> 
