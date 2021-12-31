Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF7C48244C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 15:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhLaOYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Dec 2021 09:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhLaOYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Dec 2021 09:24:23 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9C2C061574;
        Fri, 31 Dec 2021 06:24:22 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n3IpI-0000DM-Jk; Fri, 31 Dec 2021 15:24:12 +0100
Message-ID: <5c9d7c6b-05cd-4d17-b941-a93d90197cd3@leemhuis.info>
Date:   Fri, 31 Dec 2021 15:24:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Content-Language: en-BS
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Mark Brown <broonie@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <caf247ab-f6fe-a3b9-c4b5-7ce17d1d5e43@leemhuis.info>
 <20211229154553.09dd5bb657bc19d45c3de8dd@linux-foundation.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20211229154553.09dd5bb657bc19d45c3de8dd@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1640960662;ce6ca4c0;
X-HE-SMSGID: 1n3IpI-0000DM-Jk
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.12.21 00:45, Andrew Morton wrote:
> On Tue, 28 Dec 2021 11:04:18 +0100 Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> 
>> Hi, this is your Linux kernel regression tracker speaking.
>>
>> On 02.12.21 16:06, Mel Gorman wrote:
>>> Mike Galbraith, Alexey Avramov and Darrick Wong all reported similar
>>> problems due to reclaim throttling for excessive lengths of time.
>>> In Alexey's case, a memory hog that should go OOM quickly stalls for
>>> several minutes before stalling. In Mike and Darrick's cases, a small
>>> memcg environment stalled excessively even though the system had enough
>>> memory overall.
>>
>> Just wondering: this patch afaics is now in -mm and  Linux next for
>> nearly two weeks. Is that intentional? I had expected it to be mainlined
>> with the batch of patches Andrew mailed to Linus last week, but it
>> wasn't among them.
> 
> I have it queued for 5.17-rc1.
> 
> There is still time to squeeze it into 5.16, just, with a cc:stable. 
> 
> Alternatively we could merge it into 5.17-rc1 with a cc:stable, so it
> will trickle back with less risk to the 5.17 release.
> 
> What do people think?

CCing Linus, to make sure he's aware of this.

Maybe I'm totally missing something, but I'm a bit confused by what you
wrote, as the regression afaik was introduced between v5.15..v5.16-rc1.
So I assume this is what you meant:

```
I have it queued for 5.17-rc1.

There is still time to squeeze it into 5.16.

Alternatively we could merge it into 5.17-rc1 with a cc:stable, so it
will trickle back with less risk to the 5.16 release.

What do people think?
```

I'll leave the individual risk evaluation of the patch to others. If the
fix is risky, waiting for 5.17 is fine for me.

But hmmm, regarding the "could merge it into 5.17-rc1 with a cc:stable"
idea a remark: is that really "less risk", as your stated?

If we get it into rc8 (which is still possible, even if a bit hard due
to the new year festivities), it will get at least one week of testing.

If the fix waits for the next merge window, it all depends on the how
the timing works out. But it's easy to picture a worst case: the fix is
only merged on the Friday evening before Linus releases 5.17-rc1 and
right after it's out makes it into a stable-rc (say a day or two after
5.17-rc1 is out) and from there into a 5.16.y release on Thursday. That
IMHO would mean less days of testing in the end (and there is a weekend
in this period as well).

Waiting obviously will also mean that users of 5.16 and 5.16.y will
likely have to face this regression for at least two and a half weeks,
unless you send the fix early and Greg backports it before rc1 (which he
afaics does if there are good reasons). Yes, it's `just` a performance
regression, so it might not stop anyone from running Linux 5.16 -- but
it's one that three people separately reported in the 5.16 devel cycle,
so others will likely encounter it as well if we leave it unfixed in
5.16. This will likely annoy some people, especially if they invest time
in bisecting it, only to find out that the forth iteration of the fix
for the regression is already available since December the 2nd.

Ciao, Thorsten
