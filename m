Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00163720397
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 15:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbjFBNl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 09:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjFBNlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:41:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047BF137;
        Fri,  2 Jun 2023 06:41:19 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q551o-0006Ct-LG; Fri, 02 Jun 2023 15:41:16 +0200
Message-ID: <0625e839-65a5-2c79-681a-c43b502cb89f@leemhuis.info>
Date:   Fri, 2 Jun 2023 15:41:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 01/13] Revert "ext4: remove ac->ac_found >
 sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits"
Content-Language: en-US, de-DE
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <cover.1685009579.git.ojaswin@linux.ibm.com>
 <cd639a08cc9824c927591d9de14049f2461e1923.1685009579.git.ojaswin@linux.ibm.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <cd639a08cc9824c927591d9de14049f2461e1923.1685009579.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685713279;ef956bba;
X-HE-SMSGID: 1q551o-0006Ct-LG
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 25.05.23 13:32, Ojaswin Mujoo wrote:
> This reverts commit 32c0869370194ae5ac9f9f501953ef693040f6a1.
> 
> The reverted commit was intended to remove a dead check however it was observed
> that this check was actually being used to exit early instead of looping
> sbi->s_mb_max_to_scan times when we are able to find a free extent bigger than
> the goal extent. Due to this, a my performance tests (fsmark, parallel file
> writes in a highly fragmented FS) were seeing a 2x-3x regression.
> 
> Example, the default value of the following variables is:
> 
> sbi->s_mb_max_to_scan = 200
> sbi->s_mb_min_to_scan = 10
> 
> In ext4_mb_check_limits() if we find an extent smaller than goal, then we return
> early and try again. This loop will go on until we have processed
> sbi->s_mb_max_to_scan(=200) number of free extents at which point we exit and
> just use whatever we have even if it is smaller than goal extent.
> 
> Now, the regression comes when we find an extent bigger than goal. Earlier, in
> this case we would loop only sbi->s_mb_min_to_scan(=10) times and then just use
> the bigger extent. However with commit 32c08693 that check was removed and hence
> we would loop sbi->s_mb_max_to_scan(=200) times even though we have a big enough
> free extent to satisfy the request. The only time we would exit early would be
> when the free extent is *exactly* the size of our goal, which is pretty uncommon
> occurrence and so we would almost always end up looping 200 times.
> 
> Hence, revert the commit by adding the check back to fix the regression. Also
> add a comment to outline this policy.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 32c0869370194ae5ac
#regzbot title ext4: 2x-3x regression in performance tests
#regzbot monitor:
https://lore.kernel.org/all/ddcae9658e46880dfec2fb0aa61d01fb3353d202.1685449706.git.ojaswin@linux.ibm.com/
#regzbot fix: Revert "ext4: remove ac->ac_found > sbi->s_mb_min_to_scan
dead check in ext4_mb_check_limits"
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
