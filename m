Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0D6369053
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 12:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242026AbhDWK10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 06:27:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17031 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhDWK10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:27:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FRVkT5xwtzPt7K;
        Fri, 23 Apr 2021 18:23:45 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 23 Apr
 2021 18:26:47 +0800
Subject: Re: [RFC] Reclaiming PG_private
To:     Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>
References: <20210422154705.GO3596236@casper.infradead.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0367408f-f9c7-a232-7339-51b27fb133ef@huawei.com>
Date:   Fri, 23 Apr 2021 18:26:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210422154705.GO3596236@casper.infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/4/22 23:47, Matthew Wilcox wrote:
> So ... what's going on with f2fs?  Does it need to distinguish between
> a page which has f2fs_set_page_private(page, 0) called on it, and a page
> which has had f2fs_clear_page_private() called on it?

Yes, its intention here is just using Pageprivate to indicate there is
some reference counts related to a dirty page, so value in page.private
is meaningless.

I guess we can avoid f2fs_set_page_private(page, 0) usage, instead, try to
use SetPagePrivate() and assign page.private with non-zero value at the time.

Thanks,
