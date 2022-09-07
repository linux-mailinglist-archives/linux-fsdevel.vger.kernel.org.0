Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C505B0FA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 00:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiIGWBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 18:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIGWBS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:01:18 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C8F895DE;
        Wed,  7 Sep 2022 15:01:17 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:32958)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oW36e-0064Jr-Ba; Wed, 07 Sep 2022 16:01:12 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:53706 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oW36d-0092tB-7e; Wed, 07 Sep 2022 16:01:11 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Will Deacon <will@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Stephen Kitt <steve@sk2.org>, Rob Herring <robh@kernel.org>,
        Joel Savitz <jsavitz@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Renaud =?utf-8?Q?M=C3=A9trich?= <rmetrich@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, Qi Guo <qguo@redhat.com>
References: <20220903064330.20772-1-oleksandr@redhat.com>
        <87r10ob0st.fsf@email.froward.int.ebiederm.org>
        <5599808.DvuYhMxLoT@redhat.com> <20220907173438.GA15992@redhat.com>
Date:   Wed, 07 Sep 2022 17:00:43 -0500
In-Reply-To: <20220907173438.GA15992@redhat.com> (Oleg Nesterov's message of
        "Wed, 7 Sep 2022 19:34:40 +0200")
Message-ID: <877d2ec0ac.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oW36d-0092tB-7e;;;mid=<877d2ec0ac.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/MTX45R8okRsDE3mI928lifjqE1i+i1fQ=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 548 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.1%), b_tie_ro: 10 (1.8%), parse: 1.47
        (0.3%), extract_message_metadata: 4.3 (0.8%), get_uri_detail_list:
        1.70 (0.3%), tests_pri_-1000: 7 (1.3%), tests_pri_-950: 1.74 (0.3%),
        tests_pri_-900: 1.48 (0.3%), tests_pri_-90: 143 (26.1%), check_bayes:
        141 (25.7%), b_tokenize: 13 (2.4%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 3.9 (0.7%), b_tok_touch_all: 110 (20.1%), b_finish: 0.96
        (0.2%), tests_pri_0: 354 (64.6%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 0.97 (0.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 9 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] core_pattern: add CPU specifier
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 09/07, Oleksandr Natalenko wrote:
>>
>> The advantage of having CPU recorded in the file name is that
>> in case of multiple cores one can summarise them with a simple
>> ls+grep without invoking a fully-featured debugger to find out
>> whether the segfaults happened on the same CPU.
>
> Besides, if you only need to gather the statistics about the faulting
> CPU(s), you do not even need to actually dump the the core. For example,
> something like
>
> 	#!/usr/bin/sh
>
> 	echo $* >> path/to/coredump-stat.txt
>
> and
> 	echo '| path-to-script-above %C' >/proc/sys/kernel/core_pattern
>
> can help.

So I am confused.  I thought someone had modified print_fatal_signal
to print this information.  Looking at the code now I don't see it,
but perhaps that is in linux-next somewhere.

That would seem to be the really obvious place to put this and much
closer to the original fault so we ware more likely to record the
cpu on which things actually happened on.

If we don't care about the core dump just getting the information in
syslog where it can be analyzed seems like the thing to do.

For a developers box putting it in core pattern makes sense, isn't a
hinderance to use.  For anyone else's box the information needs to come
out in a way that allows automated tools to look for a pattern.
Requiring someone to take an extra step to print the information seems
a hinderance to automated tools doing the looking.

Eric

