Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BA4217E8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 06:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgGHEtI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 00:49:08 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:54028 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgGHEtI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:49:08 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jt211-0001kS-7J; Tue, 07 Jul 2020 22:49:03 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jt210-0006xn-Av; Tue, 07 Jul 2020 22:49:03 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <87y2oac50p.fsf@x220.int.ebiederm.org>
        <87bll17ili.fsf_-_@x220.int.ebiederm.org>
        <20200629221231.jjc2czk3ul2roxkw@ast-mbp.dhcp.thefacebook.com>
        <87eepwzqhd.fsf@x220.int.ebiederm.org>
        <1f4d8b7e-bcff-f950-7dac-76e3c4a65661@i-love.sakura.ne.jp>
        <87pn9euks9.fsf@x220.int.ebiederm.org>
        <757f37f8-5641-91d2-be80-a96ebc74cacb@i-love.sakura.ne.jp>
        <87h7upucqi.fsf@x220.int.ebiederm.org>
        <d0266a24-dfab-83d0-e178-aa67c9f5ebc0@i-love.sakura.ne.jp>
        <87lfk0nslu.fsf@x220.int.ebiederm.org>
        <ec6a6e18-d7aa-3072-c8dc-b925398b8409@i-love.sakura.ne.jp>
Date:   Tue, 07 Jul 2020 23:46:18 -0500
In-Reply-To: <ec6a6e18-d7aa-3072-c8dc-b925398b8409@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Sat, 4 Jul 2020 15:57:38 +0900")
Message-ID: <87o8oqipgl.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jt210-0006xn-Av;;;mid=<87o8oqipgl.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+sfYvpeMP1lDLTQFoc9fa68JTKvPiHbwU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4976]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Spam-Relay-Country: 
X-Spam-Timing: total 365 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (3.4%), b_tie_ro: 11 (2.9%), parse: 1.52
        (0.4%), extract_message_metadata: 4.0 (1.1%), get_uri_detail_list:
        1.18 (0.3%), tests_pri_-1000: 5 (1.4%), tests_pri_-950: 1.40 (0.4%),
        tests_pri_-900: 1.30 (0.4%), tests_pri_-90: 61 (16.7%), check_bayes:
        59 (16.2%), b_tokenize: 8 (2.3%), b_tok_get_all: 8 (2.3%),
        b_comp_prob: 2.5 (0.7%), b_tok_touch_all: 36 (9.8%), b_finish: 1.01
        (0.3%), tests_pri_0: 259 (71.1%), check_dkim_signature: 0.58 (0.2%),
        check_dkim_adsp: 2.7 (0.7%), poll_dns_idle: 0.97 (0.3%), tests_pri_10:
        2.5 (0.7%), tests_pri_500: 8 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Just to make certain I understand what is going on I instrumented a
kernel with some print statements.

a) The workqueues and timers start before populate_rootfs.

b) populate_rootfs does indeed happen long before the bpfilter
   module is intialized.

c) What prevents populate_rootfs and the umd_load_blob from
   having problems when they call flush_delayed_put is the
   fact that fput_many does:
   "schedule_delayed_work(&delayed_fput_work,1)".

   That 1 requests a delay of at least 1 jiffy.  A jiffy is between
   1ms and 10ms depending on how Linux is configured.

   In my test configuration running a kernel in kvm printing to a serial
   console I measured 0.8ms between the fput in blob_to_mnt and
   flush_delayed_fput which immediately follows it.

   So unless the fput becomes incredibly slow there is nothing to worry
   about in blob_to_mnt.

d) As the same mechanism is used by populate_rootfs.  A but in the
   mechanism applies to both.

e) No one appears to have reported a problem executing files out of
   initramfs these last several years since the flush_delayed_fput was
   introduced.
 
f) The code works for me.  There is real reason to believe the code will
   work for everyone else, as the exact same logic is used by initramfs.
   So it should be perfectly fine for the patchset and the
   usermode_driver code to go ahead as written.

h) If there is something to be fixed it is flush_delayed_fput as that is
   much more important than anything in the usermode driver code.

Eric

p.s.) When I talked of restarts of the usermode driver code ealier I was
   referring to the code that restarts the usermode driver if it is
   killed, the next time the kernel tries to talk to it.

   That could mask an -ETXTBUSY except if it happens on the first exec
   the net/bfilter/bpfilter_kern.c:load_umh() will return an error.

