Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECE4321BC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 16:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhBVPpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 10:45:42 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:43248 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhBVPpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:45:41 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lEDOL-0093bx-OT; Mon, 22 Feb 2021 08:44:57 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lEDOK-001Z2V-UG; Mon, 22 Feb 2021 08:44:57 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
References: <cover.1613550081.git.gladkov.alexey@gmail.com>
Date:   Mon, 22 Feb 2021 09:44:40 -0600
In-Reply-To: <cover.1613550081.git.gladkov.alexey@gmail.com> (Alexey Gladkov's
        message of "Wed, 17 Feb 2021 09:21:40 +0100")
Message-ID: <m1zgzwm7iv.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lEDOK-001Z2V-UG;;;mid=<m1zgzwm7iv.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18UX+qcoGNY+o+bfYPzgo2AhKFciywhCUM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4934]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 294 ms - load_scoreonly_sql: 0.33 (0.1%),
        signal_user_changed: 11 (3.9%), b_tie_ro: 9 (3.0%), parse: 1.01 (0.3%),
         extract_message_metadata: 3.1 (1.1%), get_uri_detail_list: 0.73
        (0.2%), tests_pri_-1000: 4.6 (1.6%), tests_pri_-950: 1.52 (0.5%),
        tests_pri_-900: 1.62 (0.6%), tests_pri_-90: 70 (23.9%), check_bayes:
        68 (23.3%), b_tokenize: 6 (1.9%), b_tok_get_all: 4.7 (1.6%),
        b_comp_prob: 2.2 (0.7%), b_tok_touch_all: 52 (17.8%), b_finish: 1.14
        (0.4%), tests_pri_0: 179 (61.0%), check_dkim_signature: 1.09 (0.4%),
        check_dkim_adsp: 3.2 (1.1%), poll_dns_idle: 0.99 (0.3%), tests_pri_10:
        2.2 (0.8%), tests_pri_500: 8 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RESEND PATCH v4 0/3] proc: Relax check of mount visibility
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> If only the dynamic part of procfs is mounted (subset=pid), then there is no
> need to check if procfs is fully visible to the user in the new user
> namespace.


A couple of things.

1) Allowing the mount should come in the last patch.  So we don't have a
bisect hazard.

2) We should document that we still require a mount of proc to match on
atime and readonly mount attributes.

3) If we can find a way to safely not require a previous mount of proc
this will be much more valuable.

Eric

