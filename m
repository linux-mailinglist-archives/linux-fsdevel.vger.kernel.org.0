Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6463B16E5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 02:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfEHAjZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 20:39:25 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:48119 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHAjY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 20:39:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hOAcA-0005DP-QV; Tue, 07 May 2019 18:39:18 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hOAc6-0003vL-2C; Tue, 07 May 2019 18:39:18 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jann Horn <jannh@google.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20190506165439.9155-1-cyphar@cyphar.com>
        <20190506165439.9155-6-cyphar@cyphar.com>
        <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
Date:   Tue, 07 May 2019 19:38:58 -0500
In-Reply-To: <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
        (Jann Horn's message of "Mon, 6 May 2019 20:37:37 +0200")
Message-ID: <87o94d6aql.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hOAc6-0003vL-2C;;;mid=<87o94d6aql.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX184qY0rF5uzX8tinelqeZoHJk5mDIQxr/Q=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4965]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 4241 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.3 (0.1%), b_tie_ro: 2.3 (0.1%), parse: 0.97
        (0.0%), extract_message_metadata: 3.1 (0.1%), get_uri_detail_list:
        1.03 (0.0%), tests_pri_-1000: 4.1 (0.1%), tests_pri_-950: 1.10 (0.0%),
        tests_pri_-900: 0.93 (0.0%), tests_pri_-90: 19 (0.5%), check_bayes: 18
        (0.4%), b_tokenize: 5 (0.1%), b_tok_get_all: 6 (0.1%), b_comp_prob:
        1.47 (0.0%), b_tok_touch_all: 3.4 (0.1%), b_finish: 0.61 (0.0%),
        tests_pri_0: 4189 (98.8%), check_dkim_signature: 0.35 (0.0%),
        check_dkim_adsp: 3006 (70.9%), poll_dns_idle: 3004 (70.8%),
        tests_pri_10: 2.9 (0.1%), tests_pri_500: 7 (0.2%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> writes:
>
> In my opinion, CVE-2019-5736 points out two different problems:
>
> The big problem: The __ptrace_may_access() logic has a special-case
> short-circuit for "introspection" that you can't opt out of;

Once upon a time in a galaxy far far away I fixed a bug where we missing
ptrace_may_access checks on various proc files and systems using selinux
stopped working.  At the time selinux did not allow ptrace like access
to yourself.  The "introspection" special case was the quick and simple
work-around.

There is nothing fundamental in having the "introspection" special case
except that various lsms have probably grown to depend upon it being
there.  I expect without difficulty we could move the check down
into the various lsms.  Which would get that check out of the core
kernel code.

Then the special case would the lsms challenge to keep or remove.

Eric
