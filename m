Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C75F2C8D1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 19:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbgK3Smp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 13:42:45 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:53894 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgK3Smp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:42:45 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kjo7g-004lQG-08; Mon, 30 Nov 2020 11:42:04 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kjo7e-0001dC-QW; Mon, 30 Nov 2020 11:42:03 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20201128175850.19484-1-wenyang@linux.alibaba.com>
Date:   Mon, 30 Nov 2020 12:41:33 -0600
In-Reply-To: <20201128175850.19484-1-wenyang@linux.alibaba.com> (Wen Yang's
        message of "Sun, 29 Nov 2020 01:58:50 +0800")
Message-ID: <87zh2yit5u.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kjo7e-0001dC-QW;;;mid=<87zh2yit5u.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+D1VhZMNzyY+vufufIEE54onRJFTivgMQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMGappySubj_01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Wen Yang <wenyang@linux.alibaba.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 644 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 8 (1.3%), b_tie_ro: 7 (1.1%), parse: 1.33 (0.2%),
        extract_message_metadata: 23 (3.5%), get_uri_detail_list: 3.7 (0.6%),
        tests_pri_-1000: 19 (3.0%), tests_pri_-950: 1.20 (0.2%),
        tests_pri_-900: 0.97 (0.2%), tests_pri_-90: 205 (31.9%), check_bayes:
        184 (28.6%), b_tokenize: 7 (1.1%), b_tok_get_all: 72 (11.2%),
        b_comp_prob: 4.1 (0.6%), b_tok_touch_all: 97 (15.1%), b_finish: 0.97
        (0.2%), tests_pri_0: 366 (56.8%), check_dkim_signature: 0.89 (0.1%),
        check_dkim_adsp: 2.8 (0.4%), poll_dns_idle: 0.47 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 13 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] proc: add locking checks in proc_inode_is_dead
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wen Yang <wenyang@linux.alibaba.com> writes:

> The proc_inode_is_dead function might race with __unhash_process.
> This will result in a whole bunch of stale proc entries being cached.
> To prevent that, add the required locking.

I assume you are talking about during proc_task_readdir?

It is completely possible for the proc_inode_is_dead to report
the inode is still alive and then for unhash_process to
happen when afterwards.

Have you been able to trigger this race in practice?


Ouch!!!!  Oleg I just looked the introduction of proc_inode_is_dead in
d855a4b79f49 ("proc: don't (ab)use ->group_leader in proc_task_readdir()
paths") introduced a ``regression''.

Breaking the logic introduced in 7d8952440f40 ("[PATCH] procfs: Fix
listing of /proc/NOT_A_TGID/task") to keep those directory listings not
showing up.

Given that it has been 6 years and no one has cared it doesn't look like
an actual regression but it does suggest the proc_inode_is_dead can be
removed entirely as it does not achieve anything in proc_task_readdir.



As for removing the race.  I expect the thing to do is to modify
proc_pid_is_alive to verify the that the pid is still alive.
Oh but look get_task_pid verifies that thread_pid is not NULL
and unhash_process sets thread_pid to NULL.


My brain is too fuzzy right now to tell if it is possible for
get_task_pid to return a pid and then for that pid to pass through
unhash_process, while the code is still in proc_pid_make_inode.

proc_inode_is_dead is definitely not the place to look to close races.

Eric


> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/proc/base.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 1bc9bcd..59720bc 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1994,7 +1994,13 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
>  
>  static inline bool proc_inode_is_dead(struct inode *inode)
>  {
> -	return !proc_pid(inode)->tasks[PIDTYPE_PID].first;
> +	bool has_task;
> +
> +	read_lock(&tasklist_lock);
> +	has_task = pid_has_task(proc_pid(inode), PIDTYPE_PID);
> +	read_unlock(&tasklist_lock);
> +
> +	return !has_task;
>  }
>  
>  int pid_delete_dentry(const struct dentry *dentry)
