Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6DEB153EBD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 07:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgBFG3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 01:29:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45846 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgBFG3h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:29:37 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AB7CA32F6C2CAFABF1A5;
        Thu,  6 Feb 2020 14:29:34 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 6 Feb 2020
 14:29:31 +0800
Subject: Re: [PATCH v2] f2fs: Make f2fs_readpages readable again
To:     Matthew Wilcox <willy@infradead.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>
References: <20200201150807.17820-1-willy@infradead.org>
 <20200203033903.GB8731@bombadil.infradead.org>
 <bd08bf56-f901-33b1-5151-f77fd823e343@huawei.com>
 <20200205030845.GP8731@bombadil.infradead.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c5bfd52b-e336-709b-5bed-aa29fc110631@huawei.com>
Date:   Thu, 6 Feb 2020 14:29:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200205030845.GP8731@bombadil.infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/2/5 11:08, Matthew Wilcox wrote:
> On Wed, Feb 05, 2020 at 09:58:29AM +0800, Chao Yu wrote:
>> On 2020/2/3 11:39, Matthew Wilcox wrote:
>>>
>>> Remove the horrendous ifdeffery by slipping an IS_ENABLED into
>>> f2fs_compressed_file().
>>
>> I'd like to suggest to use
>>
>> if (IS_ENABLED(CONFIG_F2FS_FS_COMPRESSION) && f2fs_compressed_file(inode))
>>
>> here to clean up f2fs_readpages' codes.
>>
>> Otherwise, f2fs module w/o compression support will not recognize compressed
>> file in most other cases if we add IS_ENABLED() condition into
>> f2fs_compressed_file().
> 
> If we need to recognise them in order to deny access to them, then I
> suppose we need two predicates.  Perhaps:

Yup, for compression feature, now we use f2fs_is_compress_backend_ready() to
check whether current kernel can support to handle compressed file.

For the purpose of cleanup, I guess below change should be enough...

>> if (IS_ENABLED(CONFIG_F2FS_FS_COMPRESSION) && f2fs_compressed_file(inode))

Thanks,

> 
> 	f2fs_unsupported_attributes(inode)
> and
> 	f2fs_compressed_file(inode)
> 
> where f2fs_unsupported_attributes can NACK any set flag (including those
> which don't exist yet), eg encrypted.  That seems like a larger change
> than I should be making, since I'm not really familiar with f2fs code.
> .
> 
