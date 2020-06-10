Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357F91F59ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 19:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgFJRRG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 13:17:06 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60928 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbgFJRRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:17:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jj4LV-0006fQ-U5; Wed, 10 Jun 2020 11:17:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jj4LV-0002OG-1e; Wed, 10 Jun 2020 11:17:01 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     syzbot <syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <0000000000002d7ca605a7b8b1c5@google.com>
        <20200610130422.1197386-1-gladkov.alexey@gmail.com>
Date:   Wed, 10 Jun 2020 12:12:54 -0500
In-Reply-To: <20200610130422.1197386-1-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Wed, 10 Jun 2020 15:04:22 +0200")
Message-ID: <87mu5azvxl.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jj4LV-0002OG-1e;;;mid=<87mu5azvxl.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18dBXhU4ULnzMCMzQEm7usNsGx80LULPAM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4807]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 516 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (2.6%), b_tie_ro: 11 (2.2%), parse: 0.96
        (0.2%), extract_message_metadata: 12 (2.4%), get_uri_detail_list: 1.99
        (0.4%), tests_pri_-1000: 4.5 (0.9%), tests_pri_-950: 1.31 (0.3%),
        tests_pri_-900: 1.11 (0.2%), tests_pri_-90: 139 (27.0%), check_bayes:
        136 (26.4%), b_tokenize: 6 (1.2%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 2.8 (0.5%), b_tok_touch_all: 113 (22.0%), b_finish: 1.36
        (0.3%), tests_pri_0: 331 (64.2%), check_dkim_signature: 0.82 (0.2%),
        check_dkim_adsp: 3.4 (0.6%), poll_dns_idle: 0.93 (0.2%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] proc: s_fs_info may be NULL when proc_kill_sb is called
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

For the case where s_fs_info is never allocated this looks correct.
That is because generic_shutdown_super has a special for !sb->s_root.

However for the existing cases I can't convince myself that it is safe
to change the order we free the pid namespace and free fs_info.

There is a lot of code that can run while generic_shutdown_super is
running and purging all of the inodes.  We have crazy things like
proc_flush_pid that might care, as well proc_evict_inode.

I haven't found anything that actually references fs_info or actually
depends on the pid namespace living longer than the proc inode but it
would be really easy to miss something.

Can you send a v2 version does not change the order things are freed in
for the case where we do allocate fs_info.  That will make it trivially
safe to apply.

Otherwise this looks like a very good patch.

Thank you,
Eric


> Link: https://lore.kernel.org/lkml/0000000000002d7ca605a7b8b1c5@google.com
> Reported-by: syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com
> Fixes: fa10fed30f25 ("proc: allow to mount many instances of proc in one pid namespace")
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---
>  fs/proc/root.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index ffebed1999e5..a715eb9f196a 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -264,15 +264,18 @@ static void proc_kill_sb(struct super_block *sb)
>  {
>  	struct proc_fs_info *fs_info = proc_sb_info(sb);
>  
> -	if (fs_info->proc_self)
> -		dput(fs_info->proc_self);
> +	if (fs_info) {
> +		if (fs_info->proc_self)
> +			dput(fs_info->proc_self);
>  
> -	if (fs_info->proc_thread_self)
> -		dput(fs_info->proc_thread_self);
> +		if (fs_info->proc_thread_self)
> +			dput(fs_info->proc_thread_self);
> +
> +		put_pid_ns(fs_info->pid_ns);
> +		kfree(fs_info);
> +	}
>  
>  	kill_anon_super(sb);
> -	put_pid_ns(fs_info->pid_ns);
> -	kfree(fs_info);
>  }
>  
>  static struct file_system_type proc_fs_type = {
