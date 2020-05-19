Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0371DA039
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 21:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgESTA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 15:00:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60704 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgESTA4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 15:00:56 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7Tu-00039F-E2; Tue, 19 May 2020 13:00:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7Tt-0007tH-FD; Tue, 19 May 2020 13:00:50 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <871rng22dm.fsf_-_@x220.int.ebiederm.org>
        <202005191101.1D420E03@keescook>
        <CAHk-=wjeoeh-F-PJmpYRpR_HoiB4r4qYgd3U6igtrUD6q5d_cg@mail.gmail.com>
Date:   Tue, 19 May 2020 13:57:07 -0500
In-Reply-To: <CAHk-=wjeoeh-F-PJmpYRpR_HoiB4r4qYgd3U6igtrUD6q5d_cg@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 19 May 2020 11:28:14 -0700")
Message-ID: <87k117pxbw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb7Tt-0007tH-FD;;;mid=<87k117pxbw.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19MrUcNnkuFTMNeQJe1Nc0NOcGbTYorMS0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 544 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.0%), b_tie_ro: 9 (1.7%), parse: 1.21 (0.2%),
         extract_message_metadata: 20 (3.8%), get_uri_detail_list: 2.00 (0.4%),
         tests_pri_-1000: 9 (1.7%), tests_pri_-950: 1.58 (0.3%),
        tests_pri_-900: 1.31 (0.2%), tests_pri_-90: 208 (38.2%), check_bayes:
        188 (34.6%), b_tokenize: 12 (2.2%), b_tok_get_all: 60 (11.0%),
        b_comp_prob: 2.9 (0.5%), b_tok_touch_all: 109 (20.1%), b_finish: 0.95
        (0.2%), tests_pri_0: 274 (50.3%), check_dkim_signature: 1.09 (0.2%),
        check_dkim_adsp: 3.4 (0.6%), poll_dns_idle: 0.83 (0.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 11 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/8] exec: Teach prepare_exec_creds how exec treats uids & gids
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, May 19, 2020 at 11:03 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> One question, though: why add this, since the repeat calling of the caps
>> LSM hook will do this?
>
> I assume it's for the "preserve_creds" case where we don't even end up
> setting creds at all.
>
> Yeah, at some point we'll hit a bprm handler that doesn't set
> 'preserve_creds', and it all does get set in the end, but that's not
> statically all that obvious.
>
> I think it makes sense to initialize as much as possible from the
> generic code, and rely as little as possible on what the binfmt
> handlers end up actually doing.

Where this initially came from was I was looking at how to clean up the
case of no_new_privs/ptrace of a suid executable when we don't have
enough permissions.   Just being able to create creds that kept
everything as they were looked very useful and there was just this one
little bit missing.

I included the change to prepare_exec_creds in this patchset to
emphasize that neither security_bprm_creds_for_exec nor
security_bprm_repopulate_creds need to do anything if there is nothing
special going on.

At the very least that helps me think through what the LSMs are required
to do, and what those hooks are for.  AKA privilege changing execs.

So I was thinking rely on the LSMs as little as possible rather than
rely on the binfmt handlers as little as possible.  But it is the same
idea.

And yes it makes everything easier to analyze if everything starts off
in a known good state.

Eric
