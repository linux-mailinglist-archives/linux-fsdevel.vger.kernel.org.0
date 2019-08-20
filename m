Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D6F958B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 09:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfHTHnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 03:43:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfHTHnZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:43:25 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B4DADC8A5D2DB9292ABB;
        Tue, 20 Aug 2019 15:43:19 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 20 Aug
 2019 15:43:15 +0800
Subject: Re: [f2fs-dev] [PATCH V4 5/8] f2fs: Use read_callbacks for decrypting
 file data
To:     Chandan Rajendra <chandan@linux.ibm.com>, Chao Yu <chao@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fscrypt@vger.kernel.org>, <hch@infradead.org>,
        <tytso@mit.edu>, <ebiggers@kernel.org>, <adilger.kernel@dilger.ca>,
        <chandanrmail@gmail.com>, <jaegeuk@kernel.org>
References: <20190816061804.14840-1-chandan@linux.ibm.com>
 <20190816061804.14840-6-chandan@linux.ibm.com>
 <bb3dc624-1249-2418-f9da-93da8c11e7f5@kernel.org>
 <20104514.oSSJcvNEEM@localhost.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c4a16ead-bb85-b7db-948e-5ebe7bc4431d@huawei.com>
Date:   Tue, 20 Aug 2019 15:43:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20104514.oSSJcvNEEM@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/8/19 21:33, Chandan Rajendra wrote:
> On Sunday, August 18, 2019 7:15:42 PM IST Chao Yu wrote:
>> Hi Chandan,
>>
>> On 2019-8-16 14:18, Chandan Rajendra wrote:
>>> F2FS has a copy of "post read processing" code using which encrypted
>>> file data is decrypted. This commit replaces it to make use of the
>>> generic read_callbacks facility.
>>
>> I remember that previously Jaegeuk had mentioned f2fs will support compression
>> later, and it needs to reuse 'post read processing' fwk.
>>
>> There is very initial version of compression feature in below link:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=compression
>>
>> So my concern is how can we uplift the most common parts of this fwk into vfs,
>> and meanwhile keeping the ability and flexibility when introducing private
>> feature/step in specified filesytem(now f2fs)?
>>
>> According to current f2fs compression's requirement, maybe we can expand to
>>
>> - support callback to let filesystem set the function for the flow in
>> decompression/verity/decryption step.
>> - support to use individual/common workqueue according the parameter.
>>
>> Any thoughts?
>>
> 
> Hi,
> 
> F2FS can be made to use fscrypt's queue for decryption and hence can reuse
> "read callbacks" code for decrypting data.
> 
> For decompression, we could have a STEP_MISC where we invoke a FS provided
> callback function for FS specific post read processing? 
> 
> Something like the following can be implemented in read_callbacks(),
> 	  case STEP_MISC:
> 		  if (ctx->enabled_steps & (1 << STEP_MISC)) {
> 			  /*
> 			    ctx->fs_misc() must process bio in a workqueue
> 			    and later invoke read_callbacks() with
> 			    bio->bi_private's value as an argument.
> 			  */
> 			  ctx->fs_misc(ctx->bio);
> 			  return;
> 		  }
> 		  ctx->cur_step++;
> 
> The fs_misc() callback can be passed in by the filesystem when invoking
> read_callbacks_setup_bio().

Hi,

Yes, something like this, can we just use STEP_DECOMPRESS and fs_decompress(),
not sure, I doubt this interface may has potential user which has compression
feature.

One more concern is that to avoid more context switch, maybe we can merge all
background works into one workqueue if there is no conflict when call wants to.

static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
 {
	switch (++ctx->cur_step) {
	case STEP_DECRYPT:
		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
...
			if (ctx->separated_wq)
				return;
		}
		ctx->cur_step++;
		/* fall-through */
	case STEP_DECOMPRESS:
...
	default:
		__read_end_io(ctx->bio);

> 
