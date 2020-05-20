Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FC31DB3F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 14:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgETMom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 08:44:42 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55702 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgETMom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 08:44:42 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbO5F-0003RP-BL; Wed, 20 May 2020 06:44:29 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbO5D-00014Z-VJ; Wed, 20 May 2020 06:44:29 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>
        <alpine.LRH.2.21.2005200750490.30843@namei.org>
Date:   Wed, 20 May 2020 07:40:45 -0500
In-Reply-To: <alpine.LRH.2.21.2005200750490.30843@namei.org> (James Morris's
        message of "Wed, 20 May 2020 07:52:42 +1000 (AEST)")
Message-ID: <871rnen5iq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jbO5D-00014Z-VJ;;;mid=<871rnen5iq.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18udNvJx+c1yIl5NydlUzC7C5ZchehH+PU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;James Morris <jmorris@namei.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 884 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (1.5%), b_tie_ro: 11 (1.3%), parse: 1.40
        (0.2%), extract_message_metadata: 17 (1.9%), get_uri_detail_list: 1.62
        (0.2%), tests_pri_-1000: 8 (0.9%), tests_pri_-950: 1.76 (0.2%),
        tests_pri_-900: 1.43 (0.2%), tests_pri_-90: 59 (6.7%), check_bayes: 57
        (6.5%), b_tokenize: 9 (1.0%), b_tok_get_all: 7 (0.8%), b_comp_prob:
        2.7 (0.3%), b_tok_touch_all: 35 (3.9%), b_finish: 1.10 (0.1%),
        tests_pri_0: 768 (86.9%), check_dkim_signature: 0.73 (0.1%),
        check_dkim_adsp: 3.4 (0.4%), poll_dns_idle: 1.23 (0.1%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 8 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 3/8] exec: Convert security_bprm_set_creds into security_bprm_repopulate_creds
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

James Morris <jmorris@namei.org> writes:

> On Mon, 18 May 2020, Eric W. Biederman wrote:
>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 9e70da47f8d9..8e3b93d51d31 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1366,7 +1366,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>>  	 * the final state of setuid/setgid/fscaps can be merged into the
>>  	 * secureexec flag.
>>  	 */
>> -	bprm->secureexec |= bprm->cap_elevated;
>> +	bprm->secureexec |= bprm->active_secureexec;
>
> Which kernel tree are these patches for? Seems like begin_new_exec() is 
> from a prerequisite patchset.

The base is:
git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-next

I should have mentioned.  I am several round deep in cleaning up exec
already.

begin_new_exec is essentially forget_old_exec.

Eric


