Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C16285B2CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 03:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfGABse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 21:48:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727064AbfGABse (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 21:48:34 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 56E66F18D3F85B97CE92;
        Mon,  1 Jul 2019 09:48:31 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 1 Jul 2019
 09:48:24 +0800
Subject: Re: [PATCH] fs: change last_ino type to unsigned long
To:     Matthew Wilcox <willy@infradead.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <houtao1@huawei.com>, <yi.zhang@huawei.com>, <rui.xiang@huawei.com>
References: <1561811293-75769-1-git-send-email-zhengbin13@huawei.com>
 <20190629142101.GA1180@bombadil.infradead.org>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <b8edc95d-0073-ab0f-27f2-3aee3a728d00@huawei.com>
Date:   Mon, 1 Jul 2019 09:48:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190629142101.GA1180@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2019/6/29 22:21, Matthew Wilcox wrote:
> On Sat, Jun 29, 2019 at 08:28:13PM +0800, zhengbin wrote:
>> tmpfs use get_next_ino to get inode number, if last_ino wraps,
>> there will be files share the same inode number. Change last_ino
>> type to unsigned long.
> Is this a serious problem?  I'd be more convinced by a patch to use
> the sbitmap data structure than a blind conversion to use atomic64_t.

Yes, if two files share the same inode number, when application uses dlopen to get

file handle,  there will be problems.


Maybe we could use iunique to try to get a unique i_ino value(when we allocate new inode,

we need to add it to the hashtable), the questions are:

1. inode creation will be slow down, as the comment of function  iunique says:

 *    BUGS:
 *    With a large number of inodes live on the file system this function
 *    currently becomes quite slow.

2. we need to convert all callers of  get_next_ino to use iunique (tmpfs, autofs, configfs...),

moreover, the more callers are converted, the function of iunique will be more slower.


Looking forward to your reply, thanks.

> .
>

