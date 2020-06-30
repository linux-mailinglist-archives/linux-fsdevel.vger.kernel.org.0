Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B9020F584
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 15:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgF3NWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 09:22:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53064 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgF3NWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:22:23 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05UDLOlk013584;
        Tue, 30 Jun 2020 22:21:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Tue, 30 Jun 2020 22:21:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05UDLNN3013564
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 30 Jun 2020 22:21:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <87y2oac50p.fsf@x220.int.ebiederm.org>
 <87bll17ili.fsf_-_@x220.int.ebiederm.org>
 <20200629221231.jjc2czk3ul2roxkw@ast-mbp.dhcp.thefacebook.com>
 <87eepwzqhd.fsf@x220.int.ebiederm.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <1f4d8b7e-bcff-f950-7dac-76e3c4a65661@i-love.sakura.ne.jp>
Date:   Tue, 30 Jun 2020 22:21:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87eepwzqhd.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/30 21:29, Eric W. Biederman wrote:
> Hmm.  The wake up happens just of tgid->wait_pidfd happens just before
> release_task is called so there is a race.  As it is possible to wake
> up and then go back to sleep before pid_has_task becomes false.

What is the reason we want to wait until pid_has_task() becomes false?

- wait_event(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID));
+ while (!wait_event_timeout(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID), 1));




By the way, commit 4a9d4b024a3102fc ("switch fput to task_work_add") says
that use of flush_delayed_fput() has to be careful. Al, is it safe to call
flush_delayed_fput() from blob_to_mnt() from umd_load_blob() (which might be
called from both kernel thread and from process context (e.g. init_module()
syscall by /sbin/insmod )) ?
