Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959441F5D04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgFJUVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:21:34 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33832 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgFJUVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:21:34 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jj7E3-0000Ye-35; Wed, 10 Jun 2020 14:21:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jj7E2-00080u-Ef; Wed, 10 Jun 2020 14:21:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     syzbot <syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <20200610130422.1197386-1-gladkov.alexey@gmail.com>
        <20200610183549.1234214-1-gladkov.alexey@gmail.com>
Date:   Wed, 10 Jun 2020 15:17:22 -0500
In-Reply-To: <20200610183549.1234214-1-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Wed, 10 Jun 2020 20:35:49 +0200")
Message-ID: <87eeqmzne5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jj7E2-00080u-Ef;;;mid=<87eeqmzne5.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18c/i2m4LzZvVR3NXfr4aSXpqcWLF2oyW0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4889]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 243 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (5.1%), b_tie_ro: 11 (4.4%), parse: 0.83
        (0.3%), extract_message_metadata: 10 (4.0%), get_uri_detail_list: 0.77
        (0.3%), tests_pri_-1000: 13 (5.3%), tests_pri_-950: 1.34 (0.6%),
        tests_pri_-900: 1.25 (0.5%), tests_pri_-90: 74 (30.3%), check_bayes:
        72 (29.4%), b_tokenize: 4.2 (1.7%), b_tok_get_all: 6 (2.4%),
        b_comp_prob: 1.67 (0.7%), b_tok_touch_all: 55 (22.8%), b_finish: 1.33
        (0.5%), tests_pri_0: 118 (48.8%), check_dkim_signature: 0.43 (0.2%),
        check_dkim_adsp: 2.6 (1.1%), poll_dns_idle: 1.04 (0.4%), tests_pri_10:
        2.0 (0.8%), tests_pri_500: 7 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] proc: s_fs_info may be NULL when proc_kill_sb is called
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> syzbot found that proc_fill_super() fails before filling up sb->s_fs_info,
> deactivate_locked_super() will be called and sb->s_fs_info will be NULL.
> The proc_kill_sb() does not expect fs_info to be NULL which is wrong.
>
> Link: https://lore.kernel.org/lkml/0000000000002d7ca605a7b8b1c5@google.com
> Reported-by: syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com
> Fixes: fa10fed30f25 ("proc: allow to mount many instances of proc in one pid namespace")
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>

applied

Eric
