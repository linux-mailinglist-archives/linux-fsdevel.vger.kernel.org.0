Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D473D9A13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 02:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhG2A01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 20:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232727AbhG2A01 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 20:26:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2465E60F59;
        Thu, 29 Jul 2021 00:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627518384;
        bh=uludeyf3+zGf2YO7V7UPfU6EFXH4cySzsy2ac4vsqZg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uc+72srOYR120uKGl7ZxsAJO2p0AMdqnnbO8mDXLYzC3n8ZaPT0qkoi/GV9IVP1l4
         ZrAfzKwfU3hfAOrONYnqYPgHd/TnafG4/K9DAwHy3hO8MXHsRDFDB7pFClWg+3M/7Z
         BNTpulDwWjsDj9yXPrafyLei5OXfAXPV2yg+brRzltg7lyONSFwSlS0k9Rtt7h2sVj
         Ci/rZW1yQR/LSdLe1jRlUY4nsk9b3YXPAMeu9h94UPw15RdQjzOwEiGnYrpoCSOibp
         NzqUm9sTByxPYnLI1sSwefdqgKAfpdajK78xOVOUxykWCO6pPP+BHgnjYelPo75Qw8
         ofqXEcTdeS8yA==
Subject: Re: [PATCH 3/9] f2fs: rework write preallocations
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-4-ebiggers@kernel.org>
 <14782036-f6a5-878a-d21f-e7dd7008a285@kernel.org>
 <YP2l+1umf9ct/4Sp@sol.localdomain> <YP9oou9sx4oJF1sc@google.com>
 <70f16fec-02f6-cb19-c407-856101cacc23@kernel.org>
 <YP+38QzXS6kpLGn0@sol.localdomain>
 <70d9c954-d7f0-bbe2-f078-62273229342f@kernel.org>
 <20210727153335.GE559212@magnolia>
From:   Chao Yu <chao@kernel.org>
Message-ID: <e237ab66-82dd-254d-7be2-aee8cb2b1c85@kernel.org>
Date:   Thu, 29 Jul 2021 08:26:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727153335.GE559212@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/7/27 23:33, Darrick J. Wong wrote:
> On Tue, Jul 27, 2021 at 04:30:16PM +0800, Chao Yu wrote:
>> On 2021/7/27 15:38, Eric Biggers wrote:
>>> That's somewhat helpful, but I've been doing some more investigation and now I'm
>>> even more confused.  How can f2fs support non-overwrite DIO writes at all
>>> (meaning DIO writes in LFS mode as well as DIO writes to holes in non-LFS mode),
>>> given that it has no support for unwritten extents?  AFAICS, as-is users can
>>
>> I'm trying to pick up DAX support patch created by Qiuyang from huawei, and it
>> looks it faces the same issue, so it tries to fix this by calling sb_issue_zeroout()
>> in f2fs_map_blocks() before it returns.
> 
> I really hope you don't, because zeroing the region before memcpy'ing it
> is absurd.  I don't know if f2fs can do that (xfs can't really) without
> pinning resources during a potentially lengthy memcpy operation, but you
> /could/ allocate the space in ->iomap_begin, attach some record of that
> to iomap->private, and only commit the mapping update in ->iomap_end.

Thanks for the suggestion, let me check this a little bit later, since now I
just try to stabilize the codes...

Thanks,

> 
> --D
> 
>>> easily leak uninitialized disk contents on f2fs by issuing a DIO write that
>>> won't complete fully (or might not complete fully), then reading back the blocks
>>> that got allocated but not written to.
>>>
>>> I think that f2fs will have to take the ext2 approach of not allowing
>>> non-overwrite DIO writes at all...
>> Yes,
>>
>> Another option is to enhance f2fs metadata's scalability which needs to update layout
>> of dnode block or SSA block, after that we can record the status of unwritten data block
>> there... it's a big change though...
>>
>> Thanks,
>>
>>>
>>> - Eric
>>>
