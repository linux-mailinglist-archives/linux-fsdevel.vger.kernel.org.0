Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4966E1E5105
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 00:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgE0WMw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 18:12:52 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57768 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE0WMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 18:12:51 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1je4I4-0007b5-Ch; Wed, 27 May 2020 16:12:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1je4I3-0001jf-FJ; Wed, 27 May 2020 16:12:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200527134911.1024114-1-arnd@arndb.de>
Date:   Wed, 27 May 2020 17:08:57 -0500
In-Reply-To: <20200527134911.1024114-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 27 May 2020 15:49:01 +0200")
Message-ID: <877dwx3u9y.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1je4I3-0001jf-FJ;;;mid=<877dwx3u9y.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18PilCsXe1U+52ZzNR11cP33Nif/W5bnxU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_B_Unicode
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4617]
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Arnd Bergmann <arnd@arndb.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 472 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.4%), b_tie_ro: 10 (2.1%), parse: 1.20
        (0.3%), extract_message_metadata: 16 (3.3%), get_uri_detail_list: 1.25
        (0.3%), tests_pri_-1000: 6 (1.3%), tests_pri_-950: 1.34 (0.3%),
        tests_pri_-900: 1.16 (0.2%), tests_pri_-90: 180 (38.1%), check_bayes:
        168 (35.5%), b_tokenize: 6 (1.4%), b_tok_get_all: 42 (8.9%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 113 (23.9%), b_finish: 1.02
        (0.2%), tests_pri_0: 242 (51.4%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 2.9 (0.6%), poll_dns_idle: 0.87 (0.2%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] binfmt_elf_fdpic: fix execfd build regression
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The change to bprm->have_execfd was incomplete, leading
> to a build failure:
>
> fs/binfmt_elf_fdpic.c: In function 'create_elf_fdpic_tables':
> fs/binfmt_elf_fdpic.c:591:27: error: 'BINPRM_FLAGS_EXECFD' undeclared
>
> Change the last user of BINPRM_FLAGS_EXECFD in a corresponding
> way.
>
> Reported-by: Valdis Klētnieks <valdis.kletnieks@vt.edu>
> Fixes: b8a61c9e7b4a ("exec: Generic execfd support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I have no idea whether this is right, I only looked briefly at
> the commit that introduced the problem.

It is correct and my fault.

Is there an easy to build-test configuration that includes
binfmt_elf_fdpic?

I have this sense that it might be smart to unify binfmt_elf
and binftm_elf_fdpic to the extent possible, and that will take build
tests.

Eric



> ---
>  fs/binfmt_elf_fdpic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index bba3ad555b94..aaf332d32326 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -588,7 +588,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>  	nitems = 1 + DLINFO_ITEMS + (k_platform ? 1 : 0) +
>  		(k_base_platform ? 1 : 0) + AT_VECTOR_SIZE_ARCH;
>  
> -	if (bprm->interp_flags & BINPRM_FLAGS_EXECFD)
> +	if (bprm->have_execfd)
>  		nitems++;
>  
>  	csp = sp;
