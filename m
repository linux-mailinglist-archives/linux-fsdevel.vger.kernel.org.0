Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1307203AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 15:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbjFBNqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 09:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbjFBNp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:45:58 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42962137;
        Fri,  2 Jun 2023 06:45:55 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q556H-0006wj-8Q; Fri, 02 Jun 2023 15:45:53 +0200
Message-ID: <29895f4d-9492-4572-d6f3-30d028cdcbe3@leemhuis.info>
Date:   Fri, 2 Jun 2023 15:45:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 01/12] Revert "ext4: remove ac->ac_found >
 sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits"
Content-Language: en-US, de-DE
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
 <ddcae9658e46880dfec2fb0aa61d01fb3353d202.1685449706.git.ojaswin@linux.ibm.com>
 <CA+icZUXDFbxRvx8-pvEwsZAu+-28bX4VDTj6ZTPtvn4gWqGnCg@mail.gmail.com>
 <ZHcMCGO5zW/P8LHh@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ZHcMCGO5zW/P8LHh@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685713555;50cb9482;
X-HE-SMSGID: 1q556H-0006wj-8Q
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31.05.23 10:57, Ojaswin Mujoo wrote:
> On Tue, May 30, 2023 at 06:28:22PM +0200, Sedat Dilek wrote:
>> On Tue, May 30, 2023 at 3:25 PM Ojaswin Mujoo <ojaswin@linux.ibm.com> wrote:
>>>
>>> This reverts commit 32c0869370194ae5ac9f9f501953ef693040f6a1.
>>>
>>> The reverted commit was intended to remove a dead check however it was observed
>>> that this check was actually being used to exit early instead of looping
>>> sbi->s_mb_max_to_scan times when we are able to find a free extent bigger than
>>> the goal extent. Due to this, a my performance tests (fsmark, parallel file
>>> writes in a highly fragmented FS) were seeing a 2x-3x regression.
>>>
>>> Example, the default value of the following variables is:
>>>
>>> sbi->s_mb_max_to_scan = 200
>>> sbi->s_mb_min_to_scan = 10
>>>
>>> In ext4_mb_check_limits() if we find an extent smaller than goal, then we return
>>> early and try again. This loop will go on until we have processed
>>> sbi->s_mb_max_to_scan(=200) number of free extents at which point we exit and
>>> just use whatever we have even if it is smaller than goal extent.
>>>
>>> Now, the regression comes when we find an extent bigger than goal. Earlier, in
>>> this case we would loop only sbi->s_mb_min_to_scan(=10) times and then just use
>>> the bigger extent. However with commit 32c08693 that check was removed and hence
>>> we would loop sbi->s_mb_max_to_scan(=200) times even though we have a big enough
>>> free extent to satisfy the request. The only time we would exit early would be
>>> when the free extent is *exactly* the size of our goal, which is pretty uncommon
>>> occurrence and so we would almost always end up looping 200 times.
>>>
>>> Hence, revert the commit by adding the check back to fix the regression. Also
>>> add a comment to outline this policy.
>>
>> I applied this single patch of your series v2 on top of Linux v6.4-rc4.
>>
>> So, if this is a regression I ask myself if this is material for Linux 6.4?
>>
>> Can you comment on this, please?
> 
> Since this patch fixes a regression I think it should ideally go in
> Linux 6.4

Ted can speak up for himself, but maybe this might speed things up:

A lot of maintainers in a case like this want fixes (like this)
submitted separately from other changes (like the rest of this series).

/me hopes this will help and not confuse anything

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
