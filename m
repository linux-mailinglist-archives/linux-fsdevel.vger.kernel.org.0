Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F059C15AB9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 16:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgBLPBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 10:01:32 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:45584 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLPBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:01:32 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j1tW3-00061z-6s; Wed, 12 Feb 2020 08:01:27 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j1tW0-0002sE-6R; Wed, 12 Feb 2020 08:01:27 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
        <20200210150519.538333-8-gladkov.alexey@gmail.com>
        <87v9odlxbr.fsf@x220.int.ebiederm.org>
        <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
Date:   Wed, 12 Feb 2020 08:59:29 -0600
In-Reply-To: <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
        (Alexey Gladkov's message of "Wed, 12 Feb 2020 15:49:21 +0100")
Message-ID: <87tv3vkg1a.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j1tW0-0002sE-6R;;;mid=<87tv3vkg1a.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/y0OtQ5QQujeXudLM/V7FEvgZrY+iG/uQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;LKML <linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2544 ms - load_scoreonly_sql: 0.23 (0.0%),
        signal_user_changed: 16 (0.6%), b_tie_ro: 13 (0.5%), parse: 2.2 (0.1%),
         extract_message_metadata: 276 (10.9%), get_uri_detail_list: 27 (1.1%),
         tests_pri_-1000: 235 (9.2%), tests_pri_-950: 2.6 (0.1%),
        tests_pri_-900: 1.73 (0.1%), tests_pri_-90: 247 (9.7%), check_bayes:
        208 (8.2%), b_tokenize: 81 (3.2%), b_tok_get_all: 43 (1.7%),
        b_comp_prob: 31 (1.2%), b_tok_touch_all: 23 (0.9%), b_finish: 1.23
        (0.0%), tests_pri_0: 1656 (65.1%), check_dkim_signature: 0.97 (0.0%),
        check_dkim_adsp: 34 (1.3%), poll_dns_idle: 31 (1.2%), tests_pri_10: 8
        (0.3%), tests_pri_500: 51 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> On Mon, Feb 10, 2020 at 07:36:08PM -0600, Eric W. Biederman wrote:
>> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
>> 
>> > This allows to flush dcache entries of a task on multiple procfs mounts
>> > per pid namespace.
>> >
>> > The RCU lock is used because the number of reads at the task exit time
>> > is much larger than the number of procfs mounts.
>> 
>> A couple of quick comments.
>> 
>> > Cc: Kees Cook <keescook@chromium.org>
>> > Cc: Andy Lutomirski <luto@kernel.org>
>> > Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
>> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
>> > ---
>> >  fs/proc/base.c                | 20 +++++++++++++++-----
>> >  fs/proc/root.c                | 27 ++++++++++++++++++++++++++-
>> >  include/linux/pid_namespace.h |  2 ++
>> >  include/linux/proc_fs.h       |  2 ++
>> >  4 files changed, 45 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/fs/proc/base.c b/fs/proc/base.c
>> > index 4ccb280a3e79..24b7c620ded3 100644
>> > --- a/fs/proc/base.c
>> > +++ b/fs/proc/base.c
>> > @@ -3133,7 +3133,7 @@ static const struct inode_operations proc_tgid_base_inode_operations = {
>> >  	.permission	= proc_pid_permission,
>> >  };
>> >  
>> > -static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
>> > +static void proc_flush_task_mnt_root(struct dentry *mnt_root, pid_t pid, pid_t tgid)
>> Perhaps just rename things like:
>> > +static void proc_flush_task_root(struct dentry *root, pid_t pid, pid_t tgid)
>> >  {
>> 
>> I don't think the mnt_ prefix conveys any information, and it certainly
>> makes everything longer and more cumbersome.
>> 
>> >  	struct dentry *dentry, *leader, *dir;
>> >  	char buf[10 + 1];
>> > @@ -3142,7 +3142,7 @@ static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
>> >  	name.name = buf;
>> >  	name.len = snprintf(buf, sizeof(buf), "%u", pid);
>> >  	/* no ->d_hash() rejects on procfs */
>> > -	dentry = d_hash_and_lookup(mnt->mnt_root, &name);
>> > +	dentry = d_hash_and_lookup(mnt_root, &name);
>> >  	if (dentry) {
>> >  		d_invalidate(dentry);
>> >  		dput(dentry);
>> > @@ -3153,7 +3153,7 @@ static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
>> >  
>> >  	name.name = buf;
>> >  	name.len = snprintf(buf, sizeof(buf), "%u", tgid);
>> > -	leader = d_hash_and_lookup(mnt->mnt_root, &name);
>> > +	leader = d_hash_and_lookup(mnt_root, &name);
>> >  	if (!leader)
>> >  		goto out;
>> >  
>> > @@ -3208,14 +3208,24 @@ void proc_flush_task(struct task_struct *task)
>> >  	int i;
>> >  	struct pid *pid, *tgid;
>> >  	struct upid *upid;
>> > +	struct dentry *mnt_root;
>> > +	struct proc_fs_info *fs_info;
>> >  
>> >  	pid = task_pid(task);
>> >  	tgid = task_tgid(task);
>> >  
>> >  	for (i = 0; i <= pid->level; i++) {
>> >  		upid = &pid->numbers[i];
>> > -		proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
>> > -					tgid->numbers[i].nr);
>> > +
>> > +		rcu_read_lock();
>> > +		list_for_each_entry_rcu(fs_info, &upid->ns->proc_mounts, pidns_entry) {
>> > +			mnt_root = fs_info->m_super->s_root;
>> > +			proc_flush_task_mnt_root(mnt_root, upid->nr, tgid->numbers[i].nr);
>> > +		}
>> > +		rcu_read_unlock();
>> > +
>> > +		mnt_root = upid->ns->proc_mnt->mnt_root;
>> > +		proc_flush_task_mnt_root(mnt_root, upid->nr, tgid->numbers[i].nr);
>> 
>> I don't think this following of proc_mnt is needed.  It certainly
>> shouldn't be.  The loop through all of the super blocks should be
>> enough.
>
> Yes, thanks!
>
>> Once this change goes through.  UML can be given it's own dedicated
>> proc_mnt for the initial pid namespace, and proc_mnt can be removed
>> entirely.
>
> After you deleted the old sysctl syscall we could probably do it.
>
>> Unless something has changed recently UML is the only other user of
>> pid_ns->proc_mnt.  That proc_mnt really only exists to make the loop in
>> proc_flush_task easy to write.
>
> Now I think, is there any way to get rid of proc_mounts or even
> proc_flush_task somehow.
>
>> It also probably makes sense to take the rcu_read_lock() over
>> that entire for loop.
>
> Al Viro pointed out to me that I cannot use rcu locks here :(

Fundamentally proc_flush_task is an optimization.  Just getting rid of
dentries earlier.  At least at one point it was an important
optimization because the old process dentries would just sit around
doing nothing for anyone.

I wonder if instead of invalidating specific dentries we could instead
fire wake up a shrinker and point it at one or more instances of proc.

The practical challenge I see is something might need to access the
dentries to see that they are invalid.

We definitely could try without this optimization and see what happens.

Eric

