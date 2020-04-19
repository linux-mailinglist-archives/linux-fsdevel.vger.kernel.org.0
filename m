Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83461AF9B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 13:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgDSLxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 07:53:39 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59978 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgDSLxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 07:53:39 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQ8W1-0003fL-D0; Sun, 19 Apr 2020 05:53:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQ8Vz-0006Fr-TU; Sun, 19 Apr 2020 05:53:37 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200414070142.288696-1-hch@lst.de>
        <87r1wl68gf.fsf@x220.int.ebiederm.org> <20200419081926.GA12539@lst.de>
Date:   Sun, 19 Apr 2020 06:50:32 -0500
In-Reply-To: <20200419081926.GA12539@lst.de> (Christoph Hellwig's message of
        "Sun, 19 Apr 2020 10:19:26 +0200")
Message-ID: <87o8rn3d9z.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jQ8Vz-0006Fr-TU;;;mid=<87o8rn3d9z.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1++Xt8JJKQGcbPJViucMNdTMbptPpl2UTk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4919]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christoph Hellwig <hch@lst.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1033 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (1.4%), b_tie_ro: 12 (1.2%), parse: 0.89
        (0.1%), extract_message_metadata: 12 (1.1%), get_uri_detail_list: 1.11
        (0.1%), tests_pri_-1000: 4.9 (0.5%), tests_pri_-950: 1.33 (0.1%),
        tests_pri_-900: 1.14 (0.1%), tests_pri_-90: 64 (6.2%), check_bayes: 62
        (6.0%), b_tokenize: 4.7 (0.5%), b_tok_get_all: 8 (0.7%), b_comp_prob:
        2.2 (0.2%), b_tok_touch_all: 43 (4.2%), b_finish: 1.23 (0.1%),
        tests_pri_0: 150 (14.5%), check_dkim_signature: 0.45 (0.0%),
        check_dkim_adsp: 3.1 (0.3%), poll_dns_idle: 756 (73.2%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 779 (75.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: remove set_fs calls from the exec and coredump code v2
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Fri, Apr 17, 2020 at 05:41:52PM -0500, Eric W. Biederman wrote:
>> > this series gets rid of playing with the address limit in the exec and
>> > coredump code.  Most of this was fairly trivial, the biggest changes are
>> > those to the spufs coredump code.
>> >
>> > Changes since v1:
>> >  - properly spell NUL
>> >  - properly handle the compat siginfo case in ELF coredumps
>> 
>> Quick question is exec from a kernel thread within the scope of what you
>> are looking at?
>> 
>> There is a set_fs(USER_DS) in flush_old_exec whose sole purpose appears
>> to be to allow exec from kernel threads.  Where the kernel threads
>> run with set_fs(KERNEL_DS) until they call exec.
>
> This series doesn't really look at that area.  But I don't think exec
> from a kernel thread makes any sense, and cleaning up how to set the
> initial USER_DS vs KERNEL_DS state is something I'll eventually get to,
> it seems like a major mess at the moment.

Fair enough.  I just wanted to make certain that it is on people's radar
that when the kernel exec's init the arguments are read from kernel
memory and the set_fs(USER_DS) in flush_old_exec() that makes that not
work later.

It is subtle and easy to miss.  So I figured I would mention it since
I have been staring at the exec code a lot lately.

Eric
