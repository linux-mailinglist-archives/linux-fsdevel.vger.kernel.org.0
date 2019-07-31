Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D047C385
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 15:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfGaNaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 09:30:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48458 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727441AbfGaNaY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:30:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5A6A4ECF286C3B90EAB0;
        Wed, 31 Jul 2019 21:30:20 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 21:30:11 +0800
Subject: Re: [PATCH v5 12/24] erofs: introduce tagged pointer
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Jan Kara <jack@suse.cz>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "David Sterba" <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190730071413.11871-1-gaoxiang25@huawei.com>
 <20190730071413.11871-13-gaoxiang25@huawei.com>
 <20190731130148.GE15806@quack2.suse.cz>
 <204b7fcc-a54b-ebd6-ff4c-2d5e2e6d4a8c@huawei.com>
Message-ID: <560f56f4-fb6d-6c78-6080-fe32df9ac4bf@huawei.com>
Date:   Wed, 31 Jul 2019 21:30:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <204b7fcc-a54b-ebd6-ff4c-2d5e2e6d4a8c@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/7/31 21:20, Gao Xiang wrote:
> Yes, I think that is about coding style, but the legacy way we have to do
> type cast as well, I think...
> 
>    struct b *ptr = tagptr_unfold_tags(tptr);
> vs
>    struct b *ptr = (struct b *)((unsigned long)tptr & ~2);

and we could do "typedef tagptr1_t tptrb;" and then use tptrb for tagged
pointer rather than barely use tagptr1_t tagptr2_t ... as I mentioned in:
https://lore.kernel.org/lkml/0c2cdd4f-8fe7-6084-9c2d-c2e475e6806e@aol.com/

I think "tptrb" is enough for developers to know the original pointer type
when they coding...

OTOH, I think it could be better not to directly use "struct b *" to
represent the whole tagged pointer since it seems unsafe to do dereference
directly.. It could introduce some potential bugs...

All in all, this approach is only used for EROFS for now... If there are
some better implementation, I can switch to it in the later version :)

Thanks,
Gao Xiang
