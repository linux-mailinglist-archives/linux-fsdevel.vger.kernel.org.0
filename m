Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F1C141AEB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 02:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgASBep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 20:34:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728689AbgASBep (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:34:45 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AF8274ADDE76E45BC65C;
        Sun, 19 Jan 2020 09:34:42 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 09:34:33 +0800
Subject: Re: [RFC] iomap: fix race between readahead and direct write
To:     Matthew Wilcox <willy@infradead.org>
CC:     <hch@infradead.org>, <darrick.wong@oracle.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
References: <20200116063601.39201-1-yukuai3@huawei.com>
 <20200118230826.GA5583@bombadil.infradead.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <f5328338-1a2d-38b4-283f-3fb97ad37133@huawei.com>
Date:   Sun, 19 Jan 2020 09:34:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200118230826.GA5583@bombadil.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/1/19 7:08, Matthew Wilcox wrote:
> It's worth noting that my patch series from earlier this week to
> redesign the readahead API will fix this problem.  Direct write will block
> on the locked pages in the page cache.

Thank you for your response!

In this case, direct write finish while page do not exist in the page
cache. This is the fundamental condition of the race, because readahead
won't allocate page if page exist in page cache.

By the way, in the current logic, if page exist in page cache, direct
write need to hold lock for page in invalidate_inode_pages2_range().

Thanks!
Yu Kuai




