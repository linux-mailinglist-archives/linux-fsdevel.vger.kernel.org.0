Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1050D20B2ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgFZNws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 09:52:48 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60874 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgFZNwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:52:47 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1joomX-0006vu-7D; Fri, 26 Jun 2020 07:52:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1joomQ-000537-8X; Fri, 26 Jun 2020 07:52:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
Date:   Fri, 26 Jun 2020 08:48:06 -0500
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 26 Jun 2020 07:51:41 -0500")
Message-ID: <87y2oac50p.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1joomQ-000537-8X;;;mid=<87y2oac50p.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/X/e/bp8zrqPhiR14gLXKua40xuAjoewc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,T_TM2_M_HEADER_IN_MSG,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 6159 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.1 (0.1%), b_tie_ro: 2.8 (0.0%), parse: 1.11
        (0.0%), extract_message_metadata: 12 (0.2%), get_uri_detail_list: 2.1
        (0.0%), tests_pri_-1000: 3.3 (0.1%), tests_pri_-950: 1.03 (0.0%),
        tests_pri_-900: 0.87 (0.0%), tests_pri_-90: 79 (1.3%), check_bayes: 78
        (1.3%), b_tokenize: 7 (0.1%), b_tok_get_all: 8 (0.1%), b_comp_prob:
        2.0 (0.0%), b_tok_touch_all: 58 (0.9%), b_finish: 0.78 (0.0%),
        tests_pri_0: 6047 (98.2%), check_dkim_signature: 0.38 (0.0%),
        check_dkim_adsp: 5752 (93.4%), poll_dns_idle: 5747 (93.3%),
        tests_pri_10: 2.5 (0.0%), tests_pri_500: 6 (0.1%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Adding Luis Chamberlain as he maintains the user mode helper code.

Just so everyone who is relevant is at least aware of what is going on.

ebiederm@xmission.com (Eric W. Biederman) writes:

> Asking for people to fix their bugs in this user mode driver code has
> been remarkably unproductive.  So here are my bug fixes.
>
> I have tested them by booting with the code compiled in and
> by killing "bpfilter_umh" and running iptables -vnL to restart
> the userspace driver.
>
> I have split the changes into small enough pieces so they should be
> easily readable and testable.  
>
> The changes lean into the preexisting interfaces in the kernel and
> remove special cases for user mode driver code in favor of solutions
> that don't need special cases.  This results in smaller code with
> fewer bugs.
>
> At a practical level this removes the maintenance burden of the
> user mode drivers from the user mode helper code and from exec as
> the special cases are removed.
>
> Similarly the LSM interaction bugs are fixed by not having unnecessary
> special cases for user mode drivers.
>
> Please let me know if you see any bugs.  Once the code review is
> finished I plan to take this through my tree.
>
> Eric W. Biederman (14):
>       umh: Capture the pid in umh_pipe_setup
>       umh: Move setting PF_UMH into umh_pipe_setup
>       umh: Rename the user mode driver helpers for clarity
>       umh: Remove call_usermodehelper_setup_file.
>       umh: Separate the user mode driver and the user mode helper support
>       umd: For clarity rename umh_info umd_info
>       umd: Rename umd_info.cmdline umd_info.driver_name
>       umd: Transform fork_usermode_blob into fork_usermode_driver
>       umh: Stop calling do_execve_file
>       exec: Remove do_execve_file
>       bpfilter: Move bpfilter_umh back into init data
>       umd: Track user space drivers with struct pid
>       bpfilter: Take advantage of the facilities of struct pid
>       umd: Remove exit_umh
>
>  fs/exec.c                        |  38 ++------
>  include/linux/binfmts.h          |   1 -
>  include/linux/bpfilter.h         |   7 +-
>  include/linux/sched.h            |   9 --
>  include/linux/umd.h              |  18 ++++
>  include/linux/umh.h              |  15 ----
>  kernel/Makefile                  |   1 +
>  kernel/exit.c                    |   1 -
>  kernel/umd.c                     | 183 +++++++++++++++++++++++++++++++++++++++
>  kernel/umh.c                     | 171 +-----------------------------------
>  net/bpfilter/bpfilter_kern.c     |  38 ++++----
>  net/bpfilter/bpfilter_umh_blob.S |   2 +-
>  net/ipv4/bpfilter/sockopt.c      |  20 +++--
>  13 files changed, 249 insertions(+), 255 deletions(-)
>
> Eric
