Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E3C20B096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 13:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgFZLfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 07:35:20 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56806 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgFZLfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:35:19 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jomdY-0007pG-CV; Fri, 26 Jun 2020 05:35:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jomdX-0000K5-C2; Fri, 26 Jun 2020 05:35:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
References: <87d066vd4y.fsf@x220.int.ebiederm.org>
        <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
        <87bllngirv.fsf@x220.int.ebiederm.org>
        <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
        <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
        <87ftaxd7ky.fsf@x220.int.ebiederm.org>
        <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
        <87h7v1pskt.fsf@x220.int.ebiederm.org>
        <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
        <87h7v1mx4z.fsf@x220.int.ebiederm.org>
        <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
        <878sgck6g0.fsf@x220.int.ebiederm.org>
        <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
Date:   Fri, 26 Jun 2020 06:30:48 -0500
In-Reply-To: <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
        (Alexei Starovoitov's message of "Wed, 24 Jun 2020 07:26:22 -0700")
Message-ID: <87sgeihxnb.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jomdX-0000K5-C2;;;mid=<87sgeihxnb.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/z/QlJLLbv8fWfozhts4apX0qJqt5rpEs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 570 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (2.4%), b_tie_ro: 12 (2.1%), parse: 1.09
        (0.2%), extract_message_metadata: 12 (2.1%), get_uri_detail_list: 1.29
        (0.2%), tests_pri_-1000: 13 (2.3%), tests_pri_-950: 1.29 (0.2%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 102 (17.9%), check_bayes:
        100 (17.5%), b_tokenize: 6 (1.0%), b_tok_get_all: 8 (1.5%),
        b_comp_prob: 2.4 (0.4%), b_tok_touch_all: 78 (13.7%), b_finish: 1.28
        (0.2%), tests_pri_0: 413 (72.5%), check_dkim_signature: 0.72 (0.1%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 1.17 (0.2%), tests_pri_10:
        2.5 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Jun 24, 2020 at 5:17 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Tue, Jun 23, 2020 at 01:53:48PM -0500, Eric W. Biederman wrote:
>>
>> > There is no refcnt bug. It was a user error on tomoyo side.
>> > fork_blob() works as expected.
>>
>> Nope.  I have independently confirmed it myself.
>
> I guess you've tried Tetsuo's fork_blob("#!/bin/true") kernel module ?
> yes. that fails. It never meant to be used for this.
> With elf blob it works, but breaks if there are rejections
> in things like security_bprm_creds_for_exec().
> In my mind that path was 'must succeed or kernel module is toast'.
> Like passing NULL into a function that doesn't check for it.
> Working on a fix for that since Tetsuo cares.

No.  The reference counting issue is present with the elf blob.

It is very straight forward to see when you take a minute to look.

The file is created with shmem_kernel_file_setup in fork_usermode_blob.
The file is put in fork_usermode_blob
The file is put in free_bprm by exec.

Eric
