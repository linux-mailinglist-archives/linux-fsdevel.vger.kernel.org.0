Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B9D78147E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 23:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjHRVAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 17:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjHRVAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:00:24 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591AC4214;
        Fri, 18 Aug 2023 14:00:23 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:45472)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qX6Zw-005O8N-KN; Fri, 18 Aug 2023 15:00:20 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:50332 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qX6Zt-00540T-Ve; Fri, 18 Aug 2023 15:00:20 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com>,
        anton@tuxera.com, brauner@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <000000000000c74d44060334d476@google.com>
        <87o7j471v8.fsf@email.froward.int.ebiederm.org>
        <20230818173625.by6bud4u7uz2k4be@f>
Date:   Fri, 18 Aug 2023 15:59:39 -0500
In-Reply-To: <20230818173625.by6bud4u7uz2k4be@f> (Mateusz Guzik's message of
        "Fri, 18 Aug 2023 19:36:25 +0200")
Message-ID: <87a5uo6p8k.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qX6Zt-00540T-Ve;;;mid=<87a5uo6p8k.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/ofGYnSpXkgEFr1C7tIJqjxck0R7gNKbE=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Mateusz Guzik <mjguzik@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1993 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 17 (0.8%), b_tie_ro: 14 (0.7%), parse: 1.78
        (0.1%), extract_message_metadata: 26 (1.3%), get_uri_detail_list: 1.51
        (0.1%), tests_pri_-2000: 15 (0.7%), tests_pri_-1000: 2.8 (0.1%),
        tests_pri_-950: 1.54 (0.1%), tests_pri_-900: 1.56 (0.1%),
        tests_pri_-200: 1.30 (0.1%), tests_pri_-100: 5 (0.3%), tests_pri_-90:
        1583 (79.5%), check_bayes: 1576 (79.1%), b_tokenize: 7 (0.4%),
        b_tok_get_all: 8 (0.4%), b_comp_prob: 3.2 (0.2%), b_tok_touch_all:
        1552 (77.9%), b_finish: 1.15 (0.1%), tests_pri_0: 310 (15.6%),
        check_dkim_signature: 0.66 (0.0%), check_dkim_adsp: 31 (1.6%),
        poll_dns_idle: 29 (1.4%), tests_pri_10: 2.7 (0.1%), tests_pri_500: 18
        (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [syzbot] [ntfs?] WARNING in do_open_execat
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mateusz Guzik <mjguzik@gmail.com> writes:

> On Fri, Aug 18, 2023 at 11:26:51AM -0500, Eric W. Biederman wrote:
>> syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com> writes:
>> 
>> > Hello,
>> >
>> > syzbot found the following issue on:
>> 
>> Not an issue.
>> Nothing to do with ntfs.
>> 
>> The code is working as designed and intended.
>> 
>> syzbot generated a malformed exec and the kernel made it
>> well formed and warned about it.
>> 
>
> There is definitely an issue here.
>
> The warn on comes from:
>         /*
>          * may_open() has already checked for this, so it should be
>          * impossible to trip now. But we need to be extra cautious
>          * and check again at the very end too.
>          */
>         err = -EACCES;
>         if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
>                          path_noexec(&file->f_path)))
>                 goto exit;
>
> Where path_noexec is:
>         return (path->mnt->mnt_flags & MNT_NOEXEC) ||
>                (path->mnt->mnt_sb->s_iflags & SB_I_NOEXEC);

My confusion.

I was seeing the message from
	if (retval == 0)
		pr_warn_once("process '%s' launched '%s' with NULL argv: empty string added\n",
			     current->comm, bprm->filename);

I made the mistake of assuming that that was generating the backtrace.
The lack of args to execveat appears to be working fine.

I see you tracked this down to a non-exhaustive check in may_open.
Apologies for the noise.

Eric
