Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54075503661
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Apr 2022 13:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiDPLlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Apr 2022 07:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiDPLlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Apr 2022 07:41:10 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DD73F327;
        Sat, 16 Apr 2022 04:38:38 -0700 (PDT)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nfgl9-0000mk-RE; Sat, 16 Apr 2022 13:38:35 +0200
Message-ID: <c6b80014-846d-cd90-7e67-d72959ffabe1@leemhuis.info>
Date:   Sat, 16 Apr 2022 13:38:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: fscache corruption in Linux 5.17?
Content-Language: en-US
To:     Max Kellermann <mk@cm4all.com>, dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1650109118;7865a6ba;
X-HE-SMSGID: 1nfgl9-0000mk-RE
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[TLDR: I'm adding the regression report below to regzbot, the Linux
kernel regression tracking bot; all text you find below is compiled from
a few templates paragraphs you might have encountered already already
from similar mails.]

Hi, this is your Linux kernel regression tracker. CCing the regression
mailing list, as it should be in the loop for all regressions, as
explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 12.04.22 17:10, Max Kellermann wrote:
> Hi David,
> 
> two weeks ago, I updated a cluster of web servers to Linux kernel
> 5.17.1 (5.16.x previously) which includes your rewrite of the fscache
> code.
> 
> In the last few days, there were numerous complaints about broken
> WordPress installations after WordPress was updated.  There were
> PHP syntax errors everywhere.
> 
> Indeed there were broken PHP files, but the interesting part is: those
> corruptions were only on one of the web servers; the others were fine,
> the file contents were only broken on one of the servers.
> 
> File size and time stamp and everyhing in "stat" is identical, just
> the file contents are corrupted; it looks like a mix of old and new
> contents.  The corruptions always started at multiples of 4096 bytes.
> 
> An example diff:
> 
>  --- ok/wp-includes/media.php    2022-04-06 05:51:50.000000000 +0200
>  +++ broken/wp-includes/media.php    2022-04-06 05:51:50.000000000 +0200
>  @@ -5348,7 +5348,7 @@
>                  /**
>                   * Filters the threshold for how many of the first content media elements to not lazy-load.
>                   *
>  -                * For these first content media elements, the `loading` attribute will be omitted. By default, this is the case
>  +                * For these first content media elements, the `loading` efault, this is the case
>                   * for only the very first content media element.
>                   *
>                   * @since 5.9.0
>  @@ -5377,3 +5377,4 @@
>   
>          return $content_media_count;
>   }
>  +^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
> 
> The corruption can be explained by WordPress commit
> https://github.com/WordPress/WordPress/commit/07855db0ee8d5cff2 which
> makes the file 31 bytes longer (185055 -> 185086).  The "broken" web
> server sees the new contents until offset 184320 (= 45 * 4096), but
> sees the old contents from there on; followed by 31 null bytes
> (because the kernel reads past the end of the cache?).
> 
> All web servers mount a storage via NFSv3 with fscache.
> 
> My suspicion is that this is caused by a fscache regression in Linux
> 5.17.  What do you think?
> 
> What can I do to debug this further, is there any information you
> need?  I don't know much about how fscache works internally and how to
> obtain information.

Thx for the report. Maybe a bisection is what's needed here, but lets
see what David says, maybe he has a idea already.

To be sure below issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced v5.16..v5.17
#regzbot title fscache: file contents are corrupted
#regzbot ignore-activity

If it turns out this isn't a regression, free free to remove it from the
tracking by sending a reply to this thread containing a paragraph like
"#regzbot invalid: reason why this is invalid" (without the quotes).

Reminder for developers: when fixing the issue, please add a 'Link:'
tags pointing to the report (the mail quoted above) using
lore.kernel.org/r/, as explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'. Regzbot needs them to
automatically connect reports with fixes, but they are useful in
general, too.

I'm sending this to everyone that got the initial report, to make
everyone aware of the tracking. I also hope that messages like this
motivate people to directly get at least the regression mailing list and
ideally even regzbot involved when dealing with regressions, as messages
like this wouldn't be needed then. And don't worry, if I need to send
other mails regarding this regression only relevant for regzbot I'll
send them to the regressions lists only (with a tag in the subject so
people can filter them away). With a bit of luck no such messages will
be needed anyway.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.
