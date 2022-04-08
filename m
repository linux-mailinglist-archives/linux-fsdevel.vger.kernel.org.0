Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F0A4F9B11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiDHQxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 12:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbiDHQxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:53:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E97424F1F;
        Fri,  8 Apr 2022 09:51:00 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ncrp0-0005Tj-A6; Fri, 08 Apr 2022 18:50:54 +0200
Message-ID: <74e4cc73-f16d-3e79-9927-1de3beea4a11@leemhuis.info>
Date:   Fri, 8 Apr 2022 18:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [regression] 5.15 kernel triggering 100x more inode evictions
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, dsterba@suse.cz,
        Bruno Damasceno Freire <bdamasceno@hotmail.com.br>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, fdmanana@suse.com
References: <MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com>
 <07bb78be-1d58-7d88-288b-6516790f3b5d@leemhuis.info>
 <MN2PR20MB251203B4B5445B4B0C4148C9D21D9@MN2PR20MB2512.namprd20.prod.outlook.com>
 <35b62998-e386-2032-5a7a-07e3413b3bc1@leemhuis.info>
 <MN2PR20MB251205164078C367C3FC4166D2E59@MN2PR20MB2512.namprd20.prod.outlook.com>
 <9163b8a9-e852-5786-24fa-d324e3118890@leemhuis.info>
 <20220408145222.GR15609@twin.jikos.cz> <YlBa/Rc0lvJCm5Rr@debian9.Home>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YlBa/Rc0lvJCm5Rr@debian9.Home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649436661;c6b98862;
X-HE-SMSGID: 1ncrp0-0005Tj-A6
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

First off: David, Filipe, many thx for your answers, that helped me a
lot to get a better picture of the situation!

On 08.04.22 17:55, Filipe Manana wrote:
> On Fri, Apr 08, 2022 at 04:52:22PM +0200, David Sterba wrote:
>> On Fri, Apr 08, 2022 at 12:32:20PM +0200, Thorsten Leemhuis wrote:
>>> Hi, this is your Linux kernel regression tracker. Top-posting for once,
>>> to make this easily accessible to everyone.
>>>
>>> Btrfs maintainers, what's up here? Yes, this regression report was a bit
>>> confusing in the beginning, but Bruno worked on it. And apparently it's
>>> already fixed in 5.16, but still in 5.15. Is this caused by a change
>>> that is to big to backport or something?
>>
>> I haven't identified possible fixes in 5.16 so I can't tell how much
>> backport efforts it could be. As the report is related to performance on
>> package updates, my best guess is that the patches fixing it are those
>> from Filipe related to fsync/logging, and there are several of such
>> improvements in 5.16. Or something else that fixes it indirectly.
> 
> So there's a lot of confusion in the thread,

Yeah, definitely. That basically why I had hoped from a rough assessment
from the btrfs maintainers.

> and the original openSUSE 
> bugzilla [1] is also a bit confusing and large to follow.
> 
> Let me try to make it clear:
> 
> 1) For some reason, outside btrfs' control, inode eviction is triggered
>    a lot on 5.15 kernels in Bruno's test machine when doing package
>    installations/updates with zypper.

So I assume there are no other reports like this? Great!

> [...]

> 6) In short, it is not known what causes the excessive evictions on 5.15
>    on his machine for that specific workload - we don't have a commit to
>    point at and say it caused a regression. [...]

Bruno, under these circumstances I'd say you need to bisect this to get
us closer to the root of the problem (and a fix for it). Sadly that how
it is sometimes, as briefly explained here:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/admin-guide/reporting-regressions.rst#n140

> This thread is also basically a revamp of an older thread [3].
> 
> [1] https://bugzilla.opensuse.org/show_bug.cgi?id=1193549
> [2] https://lore.kernel.org/linux-btrfs/cover.1642676248.git.fdmanana@suse.com/
> [3] https://lore.kernel.org/linux-fsdevel/MN2PR20MB251235DDB741CD46A9DD5FAAD24E9@MN2PR20MB2512.namprd20.prod.outlook.com/

Yeah, but it was this thread that made me aware of the issue -- and just
like [3] it didn't get a single reply from a btrfs maintainer, so I had
to assume the report was ignored. A quick "we have no idea what my cause
this issue and it's the only report with such symptoms so far; could you
please bisect" would have made me happy already. :-D

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.
