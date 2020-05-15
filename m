Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00781D5AC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 22:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgEOUj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 16:39:59 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56812 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEOUj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 16:39:58 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jZh7a-0007OX-H5; Fri, 15 May 2020 14:39:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jZh7V-0007gL-4O; Fri, 15 May 2020 14:39:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        syzbot <syzbot+c1af344512918c61362c@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <0000000000002f0c7505a5b0e04c@google.com>
        <c3461e26-1407-2262-c709-dac0df3da2d0@i-love.sakura.ne.jp>
        <72cb7aea-92bd-d71b-2f8a-63881a35fad8@i-love.sakura.ne.jp>
        <20200515201357.GG23230@ZenIV.linux.org.uk>
Date:   Fri, 15 May 2020 15:36:13 -0500
In-Reply-To: <20200515201357.GG23230@ZenIV.linux.org.uk> (Al Viro's message of
        "Fri, 15 May 2020 21:13:57 +0100")
Message-ID: <87o8qpaqbm.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jZh7V-0007gL-4O;;;mid=<87o8qpaqbm.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/PGgvqQtmtGb1PoHqp2pZ/qQlUc5KbPks=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMGappySubj_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 4955 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (0.2%), b_tie_ro: 9 (0.2%), parse: 1.08 (0.0%),
         extract_message_metadata: 13 (0.3%), get_uri_detail_list: 1.70 (0.0%),
         tests_pri_-1000: 5 (0.1%), tests_pri_-950: 1.39 (0.0%),
        tests_pri_-900: 1.11 (0.0%), tests_pri_-90: 81 (1.6%), check_bayes: 79
        (1.6%), b_tokenize: 8 (0.2%), b_tok_get_all: 8 (0.2%), b_comp_prob:
        2.7 (0.1%), b_tok_touch_all: 56 (1.1%), b_finish: 1.00 (0.0%),
        tests_pri_0: 279 (5.6%), check_dkim_signature: 0.63 (0.0%),
        check_dkim_adsp: 2.5 (0.1%), poll_dns_idle: 4538 (91.6%),
        tests_pri_10: 2.2 (0.0%), tests_pri_500: 4557 (92.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: linux-next boot error: general protection fault in tomoyo_get_local_path
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Sat, May 16, 2020 at 12:36:28AM +0900, Tetsuo Handa wrote:
>> On 2020/05/16 0:18, Tetsuo Handa wrote:
>> > This is
>> > 
>> >         if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
>> >                 char *ep;
>> >                 const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
>> >                 struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry)); // <= here
>> > 
>> >                 if (*ep == '/' && pid && pid ==
>> >                     task_tgid_nr_ns(current, proc_pidns)) {
>> > 
>> > which was added by commit c59f415a7cb6e1e1 ("Use proc_pid_ns() to get pid_namespace from the proc superblock").
>> > 
>> > @@ -161,9 +162,10 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
>> >         if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
>> >                 char *ep;
>> >                 const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
>> > +               struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry));
>> > 
>> >                 if (*ep == '/' && pid && pid ==
>> > -                   task_tgid_nr_ns(current, sb->s_fs_info)) {
>> > +                   task_tgid_nr_ns(current, proc_pidns)) {
>> >                         pos = ep - 5;
>> >                         if (pos < buffer)
>> >                                 goto out;
>> > 
>> > Alexey and Eric, any clue?
>> > 
>> 
>> A similar bug (racing inode destruction with open() on proc filesystem) was fixed as
>> commit 6f7c41374b62fd80 ("tomoyo: Don't use nifty names on sockets."). Then, it might
>> not be safe to replace dentry->d_sb->s_fs_info with dentry->d_inode->i_sb->s_fs_info .
>
> Could you explain why do you want to bother with d_inode() anyway?  Anything that
> does dentry->d_inode->i_sb can bloody well use dentry->d_sb.  And that's never
> changed over the struct dentry lifetime - ->d_sb is set on allocation and never
> modified afterwards.

Wanting to bother with d_inode is a bit strong.

It was just a matter of the helper function proc_pid_ns was built to
work against inodes.  And working with inodes looks reasonable as
in all of the places in proc where it was originally called it had
an inode, and did not have a dentry.

I don't think there was any strong design to it.

Before changing the s_fs_info in proc we found Tomoyo accessing it
without any helpers, and used the helper we had.  Which looked
reasonable.  Now we have discovered it wasn't.

It probably makes most sense just to have the helper go from the
super_block, and not worry about inodes or dentries.

Alexey Gladkov is already looking at fixing this.

Eric

