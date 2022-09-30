Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62F55F0B3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 14:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiI3MDe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 08:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiI3MDc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:03:32 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83236177785;
        Fri, 30 Sep 2022 05:03:29 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oeEjm-0000JX-R5; Fri, 30 Sep 2022 14:03:26 +0200
Message-ID: <e4557441-2c23-376a-39bf-cb02e70c6440@leemhuis.info>
Date:   Fri, 30 Sep 2022 14:03:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
To:     linux-kernel@vger.kernel.org, gpiccoli@igalia.com
Cc:     regressions@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com
References: <20220929215515.276486-1-gpiccoli@igalia.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [REGRESSION][PATCH] Revert "pstore: migrate to crypto acomp
 interface" #forregzbot
In-Reply-To: <20220929215515.276486-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664539409;03c3a444;
X-HE-SMSGID: 1oeEjm-0000JX-R5
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker. Thx for the report.

On 29.09.22 23:55, Guilherme G. Piccoli wrote:
> This reverts commit e4f0a7ec586b7644107839f5394fb685cf1aadcc.
> 
> When using this new interface, both efi_pstore and ramoops
> backends are unable to properly decompress dmesg if using
> zstd, lz4 and lzo algorithms (and maybe more). It does succeed
> with deflate though.
> 
> The message observed in the kernel log is:
> 
> [2.328828] pstore: crypto_acomp_decompress failed, ret = -22!
> 
> The pstore infrastructure is able to collect the dmesg with
> both backends tested, but since decompression fails it's
> unreadable. With this revert everything is back to normal.
> 
> Fixes: e4f0a7ec586b ("pstore: migrate to crypto acomp interface")
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> Hi Ard, Thorsten and pstore maintainers. I've found this yday
> during pstore development - it was "hidden" since I was using
> deflate. Tried some fixes (I plan to submit a cast fix for a
> long-term issue later), but nothing I tried fixed this.
> 
> So, I thought in sending this revert - feel free to ignore it if
> anybody comes with a proper fix for the async compress interface
> proposed by Ard. The idea of the revert is because the 6.0-rc
> cycle is nearly over, and would be nice to avoid introducing
> this regression.
> 
> Also, I searched some mailing list discussions / submission of
> the patch ("pstore: migrate to crypto acomp interface"), but
> couldn't find it - can any of you point it to me in case it's
> in some archive?
> 
> Thanks in advance, and sorry for reporting this so late in the
> cycle, I wish I'd found it before.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced e4f0a7ec586b
#regzbot title pstore: efi_pstore and ramoops backends are sometimes
unable to properly decompress dmesg
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
