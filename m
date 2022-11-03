Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0030C617B5B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 12:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKCLIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 07:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKCLIx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:08:53 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F6EFAF7;
        Thu,  3 Nov 2022 04:08:51 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oqY5Y-0006kG-JP; Thu, 03 Nov 2022 12:08:48 +0100
Message-ID: <9114cdb0-9d2a-d863-9157-40f182b110a8@leemhuis.info>
Date:   Thu, 3 Nov 2022 12:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-mm@kvack.org
References: <20220915094200.139713-1-hch@lst.de>
 <20220915094200.139713-4-hch@lst.de>
 <d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info>
Subject: Re: [REGESSION] systemd-oomd overreacting due to PSI changes for
 Btrfs #forregzbot
In-Reply-To: <d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1667473731;3c8542ad;
X-HE-SMSGID: 1oqY5Y-0006kG-JP
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.11.22 11:46, Thorsten Leemhuis wrote:
> On 15.09.22 11:41, Christoph Hellwig wrote:
>> btrfs compressed reads try to always read the entire compressed chunk,
>> even if only a subset is requested.  Currently this is covered by the
>> magic PSI accounting underneath submit_bio, but that is about to go
>> away. Instead add manual psi_memstall_{enter,leave} annotations.
>>
>> Note that for readahead this really should be using readahead_expand,
>> but the additionals reads are also done for plain ->read_folio where
>> readahead_expand can't work, so this overall logic is left as-is for
>> now.
> 
> It seems this patch makes systemd-oomd overreact on my day-to-day
> machine and aggressively kill applications. I'm not the only one that
> noticed such a behavior with 6.1 pre-releases:
> https://bugzilla.redhat.com/show_bug.cgi?id=2133829
> https://bugzilla.redhat.com/show_bug.cgi?id=2134971

Great, the kernel's regression tracker reports a regression and forgets
to tell his regression tracking bot about it to ensure it's tracked... :-D

#regzbot ^introduced 4088a47e78f9
#regzbot title mm/btrfs: systemd-oomd overreacting due to PSI changes
for Btrfs
#regzbot ignore-activity

Ciao, Thorsten
