Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5D2CA688
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 16:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbgLAPHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 10:07:16 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:40234 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387462AbgLAPHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:07:16 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kk7Eg-006Kl5-SO; Tue, 01 Dec 2020 08:06:34 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kk7Eg-004AdG-2J; Tue, 01 Dec 2020 08:06:34 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20201128175850.19484-1-wenyang@linux.alibaba.com>
        <87zh2yit5u.fsf@x220.int.ebiederm.org>
        <20201201123556.GB2700@redhat.com>
Date:   Tue, 01 Dec 2020 09:06:04 -0600
In-Reply-To: <20201201123556.GB2700@redhat.com> (Oleg Nesterov's message of
        "Tue, 1 Dec 2020 13:35:56 +0100")
Message-ID: <87lfehftwj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kk7Eg-004AdG-2J;;;mid=<87lfehftwj.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/oeFjxe0NXtD6hi2b0dZgnvFQeZkd65EY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMGappySubj_01
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 286 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.3 (1.2%), b_tie_ro: 2.3 (0.8%), parse: 1.02
        (0.4%), extract_message_metadata: 3.1 (1.1%), get_uri_detail_list:
        1.11 (0.4%), tests_pri_-1000: 4.2 (1.5%), tests_pri_-950: 1.43 (0.5%),
        tests_pri_-900: 1.13 (0.4%), tests_pri_-90: 109 (38.2%), check_bayes:
        108 (37.7%), b_tokenize: 7 (2.3%), b_tok_get_all: 4.3 (1.5%),
        b_comp_prob: 1.99 (0.7%), b_tok_touch_all: 92 (32.2%), b_finish: 0.76
        (0.3%), tests_pri_0: 144 (50.3%), check_dkim_signature: 0.36 (0.1%),
        check_dkim_adsp: 2.3 (0.8%), poll_dns_idle: 0.94 (0.3%), tests_pri_10:
        2.7 (0.9%), tests_pri_500: 7 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] proc: add locking checks in proc_inode_is_dead
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 11/30, Eric W. Biederman wrote:
>>
>> Ouch!!!!  Oleg I just looked the introduction of proc_inode_is_dead in
>> d855a4b79f49 ("proc: don't (ab)use ->group_leader in proc_task_readdir()
>> paths") introduced a ``regression''.
>>
>> Breaking the logic introduced in 7d8952440f40 ("[PATCH] procfs: Fix
>> listing of /proc/NOT_A_TGID/task") to keep those directory listings not
>> showing up.
>
> Sorry, I don't understand...
>
> Do you mean that "ls /proc/pid/task" can see an empty dir? Afaics this
> was possible before d855a4b79f49 too.
>
> Or what?

Bah. Brain fart on my part.

I read 7d8952440f40 too fast.  I thought it was attempting to make
it so that "ls /proc/tid/task/" would see an empty dir while "ls
/proc/tgid/task/" would see the complete set of threads.

Where tgid is the pid of the thread group leader and tid
is the pid of some thread in the thread group.


But 7d8952440f40 was just attempting to ensure that no thread was
listed more than once in "/proc/xxx/task".

My apologies for the confusion.

Eric
