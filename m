Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87F46573FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Dec 2022 09:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiL1Ikm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Dec 2022 03:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1Ikf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:40:35 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5694AF006
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Dec 2022 00:40:34 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pARzE-00014n-Ay; Wed, 28 Dec 2022 09:40:32 +0100
Message-ID: <2aa5cc7e-ca00-22a7-5e2f-7eb73556181e@leemhuis.info>
Date:   Wed, 28 Dec 2022 09:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] acl updates for v6.2 #forregzbot
Content-Language: en-US, de-DE
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-fsdevel@vger.kernel.org
References: <20221212111919.98855-1-brauner@kernel.org>
 <29161.1672154875@jrobl>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <29161.1672154875@jrobl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672216834;359ba8da;
X-HE-SMSGID: 1pARzE-00014n-Ay
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Note: this mail contains only information for Linux kernel regression
tracking. Mails like these contain '#forregzbot' in the subject to make
then easy to spot and filter out. The author also tried to remove most
or all individuals from the list of recipients to spare them the hassle.]

On 27.12.22 16:27, J. R. Okajima wrote:
> 
> Christian Brauner:
>> This series passes the LTP and xfstests suites without any regressions. For
>> xfstests the following combinations were tested:
> 
> I've found a behaviour got changed from v6.1 to v6.2-rc1 on ext3 (ext4).

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced v6.1..v6.2-rc1
#regzbot title fs: ext3/acl: behavior changed (ls and getact show
slightly different output)
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

> ----------------------------------------
> on v6.1
> + ls -ld /dev/shm/rw/hd-test/newdir
> drwxrwsr-x 2 nobody nogroup 1024 Dec 27 14:46 /dev/shm/rw/hd-test/newdir
> 
> + getfacl -d /dev/shm/rw/hd-test/newdir
> # file: dev/shm/rw/hd-test/newdir
> # owner: nobody
> # group: nogroup
> # flags: -s-
> 
> ----------------------------------------
> on v6.2-rc1
> + ls -ld /dev/shm/rw/hd-test/newdir
> drwxrwsr-x+ 2 nobody nogroup 1024 Dec 27 23:51 /dev/shm/rw/hd-test/newdir
> 
> + getfacl -d /dev/shm/rw/hd-test/newdir
> # file: dev/shm/rw/hd-test/newdir
> # owner: nobody
> # group: nogroup
> # flags: -s-
> user::rwx
> user:root:rwx
> group::r-x
> mask::rwx
> other::r-x
> 
> ----------------------------------------
> 
> - in the output from 'ls -l', the extra '+' appears
> - in the output from 'getfacl -d', some lines are appended
> - in those lines, I am not sure whether 'user:root:rwx' is correct or
>   not. Even it is correct, getfacl on v6.1 didn't produce such lines.
> 
> Is this change intentional?
> In other words, is this patch series for a bugfix?
> 
> 
> J. R. Okajima
