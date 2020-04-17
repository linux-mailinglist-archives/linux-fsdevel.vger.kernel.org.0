Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1EB1AE85D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 00:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgDQWo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 18:44:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:55900 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgDQWo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 18:44:56 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPZjC-0005JR-PH; Fri, 17 Apr 2020 16:44:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPZjB-0000Gs-Ug; Fri, 17 Apr 2020 16:44:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200414070142.288696-1-hch@lst.de>
Date:   Fri, 17 Apr 2020 17:41:52 -0500
In-Reply-To: <20200414070142.288696-1-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 14 Apr 2020 09:01:34 +0200")
Message-ID: <87r1wl68gf.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jPZjB-0000Gs-Ug;;;mid=<87r1wl68gf.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/NTTejAZTToJnS0iJyxwSeYmg+5kLfBag=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4907]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christoph Hellwig <hch@lst.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 360 ms - load_scoreonly_sql: 0.34 (0.1%),
        signal_user_changed: 16 (4.4%), b_tie_ro: 12 (3.3%), parse: 1.80
        (0.5%), extract_message_metadata: 19 (5.2%), get_uri_detail_list: 1.28
        (0.4%), tests_pri_-1000: 21 (5.9%), tests_pri_-950: 1.81 (0.5%),
        tests_pri_-900: 1.51 (0.4%), tests_pri_-90: 91 (25.2%), check_bayes:
        88 (24.5%), b_tokenize: 6 (1.7%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 2.1 (0.6%), b_tok_touch_all: 69 (19.3%), b_finish: 1.66
        (0.5%), tests_pri_0: 187 (52.0%), check_dkim_signature: 0.93 (0.3%),
        check_dkim_adsp: 3.1 (0.9%), poll_dns_idle: 0.67 (0.2%), tests_pri_10:
        2.9 (0.8%), tests_pri_500: 12 (3.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: remove set_fs calls from the exec and coredump code v2
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Hi all,
>
> this series gets rid of playing with the address limit in the exec and
> coredump code.  Most of this was fairly trivial, the biggest changes are
> those to the spufs coredump code.
>
> Changes since v1:
>  - properly spell NUL
>  - properly handle the compat siginfo case in ELF coredumps

Quick question is exec from a kernel thread within the scope of what you
are looking at?

There is a set_fs(USER_DS) in flush_old_exec whose sole purpose appears
to be to allow exec from kernel threads.  Where the kernel threads
run with set_fs(KERNEL_DS) until they call exec.

Eric
