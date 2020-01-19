Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF88141AE0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 02:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgASBZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 20:25:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9651 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727070AbgASBZ2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:25:28 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8B567E18B6321792B211;
        Sun, 19 Jan 2020 09:25:25 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 09:25:17 +0800
Subject: Re: [RFC] iomap: fix race between readahead and direct write
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>
CC:     <hch@infradead.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <houtao1@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>
References: <20200116063601.39201-1-yukuai3@huawei.com>
 <20200116153206.GF8446@quack2.suse.cz>
 <ce4bc2f3-a23e-f6ba-0ef1-66231cd1057d@huawei.com>
 <20200117110536.GE17141@quack2.suse.cz> <20200117162439.GT8247@magnolia>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <fefbacb4-4ad9-df70-a5ab-58df4471800c@huawei.com>
Date:   Sun, 19 Jan 2020 09:25:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200117162439.GT8247@magnolia>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/1/18 0:24, Darrick J. Wong wrote:
> Does the problem go away if you apply[1]?  If I understand the race
> correctly, marking the extents unwritten and leaving them that way until
> after we've written the disk should eliminate the exposure vector...?:)

Thank you for your response.

The patch [1] fixed the stale data exposure problem which was tested by
generic/042. I'm afarid it's completely a diffrent case for generic/418.

In generic/418, direct write wrote some data to disk successfully, while
buffer read left the correspond page uptodate with 0 content in
pagecache.

Thanks!
Yu Kuai

