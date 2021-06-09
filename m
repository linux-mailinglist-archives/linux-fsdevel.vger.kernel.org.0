Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259823A1E5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 22:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhFIU6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 16:58:07 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51924 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhFIU6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 16:58:04 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lr5FA-00Dirf-K8; Wed, 09 Jun 2021 14:56:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lr5F9-00GeK9-9c; Wed, 09 Jun 2021 14:56:08 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Enrico Weigelt\, metux IT consult" <lkml@metux.net>,
        Chris Down <chris@chrisdown.name>, legion@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@kernel.org>
References: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
        <YLi+JoBwfLtqVGiP@chrisdown.name>
        <b8c86081-503c-3671-2ea3-dd3a0950ce25@metux.net>
        <87k0n2am0n.fsf@disp2133> <YMElKcrVIhJg4GTT@cmpxchg.org>
Date:   Wed, 09 Jun 2021 15:56:00 -0500
In-Reply-To: <YMElKcrVIhJg4GTT@cmpxchg.org> (Johannes Weiner's message of
        "Wed, 9 Jun 2021 16:31:37 -0400")
Message-ID: <87lf7i7o67.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lr5F9-00GeK9-9c;;;mid=<87lf7i7o67.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18FkAbzTYIBn3ucwFU8qo4xXys9E2kN0X0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08,
        T_XMDrugObfuBody_09 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  1.0 T_XMDrugObfuBody_09 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Johannes Weiner <hannes@cmpxchg.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 604 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 13 (2.1%), b_tie_ro: 11 (1.8%), parse: 1.99
        (0.3%), extract_message_metadata: 21 (3.5%), get_uri_detail_list: 3.8
        (0.6%), tests_pri_-1000: 18 (3.0%), tests_pri_-950: 1.44 (0.2%),
        tests_pri_-900: 1.14 (0.2%), tests_pri_-90: 70 (11.6%), check_bayes:
        68 (11.3%), b_tokenize: 11 (1.8%), b_tok_get_all: 11 (1.8%),
        b_comp_prob: 3.9 (0.6%), b_tok_touch_all: 39 (6.4%), b_finish: 0.97
        (0.2%), tests_pri_0: 413 (68.4%), check_dkim_signature: 0.68 (0.1%),
        check_dkim_adsp: 4.8 (0.8%), poll_dns_idle: 45 (7.4%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 58 (9.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1] proc: Implement /proc/self/meminfo
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Wed, Jun 09, 2021 at 02:14:16PM -0500, Eric W. Biederman wrote:
>> "Enrico Weigelt, metux IT consult" <lkml@metux.net> writes:
>> 
>> > On 03.06.21 13:33, Chris Down wrote:
>> >
>> > Hi folks,
>> >
>> >
>> >> Putting stuff in /proc to get around the problem of "some other metric I need
>> >> might not be exported to a container" is not a very compelling argument. If
>> >> they want it, then export it to the container...
>> >>
>> >> Ultimately, if they're going to have to add support for a new
>> >> /proc/self/meminfo file anyway, these use cases should just do it properly
>> >> through the already supported APIs.
>> >
>> > It's even a bit more complex ...
>> >
>> > /proc/meminfo always tells what the *machine* has available, not what a
>> > process can eat up. That has been this way even long before cgroups.
>> > (eg. ulimits).
>> >
>> > Even if you want a container look more like a VM - /proc/meminfo showing
>> > what the container (instead of the machine) has available - just looking
>> > at the calling task's cgroup is also wrong. Because there're cgroups
>> > outside containers (that really shouldn't be affected) and there're even
>> > other cgroups inside the container (that further restrict below the
>> > container's limits).
>> >
>> > BTW: applications trying to autotune themselves by looking at
>> > /proc/meminfo are broken-by-design anyways. This never has been a valid
>> > metric on how much memory invididual processes can or should eat.
>> 
>> Which brings us to the problem.
>> 
>> Using /proc/meminfo is not valid unless your application can know it has
>> the machine to itself.  Something that is becoming increasing less
>> common.
>> 
>> Unless something has changed in the last couple of years, reading values
>> out of the cgroup filesystem is both difficult (v1 and v2 have some
>> gratuitous differences) and is actively discouraged.
>> 
>> So what should applications do?
>> 
>> Alex has found applications that are trying to do something with
>> meminfo, and the fields that those applications care about.  I don't see
>> anyone making the case that specifically what the applications are
>> trying to do is buggy.
>> 
>> Alex's suggest is to have a /proc/self/meminfo that has the information
>> that applications want, which would be something that would be easy
>> to switch applications to.  The patch to userspace at that point is
>> as simple as 3 lines of code.  I can imagine people take that patch into
>> their userspace programs.
>
> But is it actually what applications want?
>
> Not all the information at the system level translates well to the
> container level. Things like available memory require a hierarchical
> assessment rather than just a look at the local level, since there
> could be limits higher up the tree.

That sounds like a bug in the implementation of /proc/self/meminfo.

It certainly is a legitimate question to ask what are the limits
from my perspective.

> Not all items in meminfo have a container equivalent, either.

Not all items in meminfo were implemented.

> The familiar format is likely a liability rather than an asset.

It could be.  At the same time that is the only format anyone has
proposed so we good counter proposal would be appreciated if you don't
like the code that has been written.

>> The simple fact that people are using /proc/meminfo when it doesn't make
>> sense for anything except system monitoring tools is a pretty solid bug
>> report on the existing linux apis.
>
> I agree that we likely need a better interface for applications to
> query the memory state of their container. But I don't think we should
> try to emulate a format that is a poor fit for this.

I don't think it is the container that we care about (except for maybe
system managment tools).  I think the truly interesting case is
applications asking what do I have available to me.

> We should also not speculate what users intended to do with the
> meminfo data right now. There is a surprising amount of misconception
> around what these values actually mean. I'd rather have users show up
> on the mailing list directly and outline the broader usecase.

We are kernel developers, we can read code.  We don't need to speculate.
We can read the userspace code.  If things are not clear we can ask
their developers.

Eric

