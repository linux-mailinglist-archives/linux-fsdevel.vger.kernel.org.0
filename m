Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB91F80D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 06:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgFMEXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 00:23:55 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54128 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgFMEXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 00:23:55 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05D4MlgJ014729;
        Sat, 13 Jun 2020 13:22:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp);
 Sat, 13 Jun 2020 13:22:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05D4Mg4c014641
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 13 Jun 2020 13:22:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
References: <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <87r1uo2ejt.fsf@x220.int.ebiederm.org>
 <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
 <87d066vd4y.fsf@x220.int.ebiederm.org>
 <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
 <62859212-df69-b913-c1e0-cd2e358d1adf@i-love.sakura.ne.jp>
 <20200613033821.l62q2ed5ligheyhu@ast-mbp>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <92011d12-5d73-b0fd-a744-3f99f19922fe@i-love.sakura.ne.jp>
Date:   Sat, 13 Jun 2020 13:22:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200613033821.l62q2ed5ligheyhu@ast-mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/13 12:38, Alexei Starovoitov wrote:
> On Fri, Jun 12, 2020 at 09:57:40AM +0900, Tetsuo Handa wrote:
>>
>> , the userspace memory can be easily interfered from userspace. The kernel module
>> running in kernel space is protected (unless methods like /dev/{mem,kmem} are used)
>> but the kernel module running in user space is not protected.
> 
> huh? One user process 'can easily interfere' with memory of other process?

It is an execution environment problem.

Somebody can send SIGKILL (e.g. OOM-killker, SysRq-i) to kill kernel code running as
usermode process, somebody can send SIGSTOP to make kernel code running as usermode
process defunctional, somebody can /usr/bin/strace in order to eavesdrop on secret
data used by kernel code running as usermode process etc.

>> can be interfered) is so painful. I won't be able to trust kernel modules running
>> in userspace memory.
> 
> The part that I suspect is still missing is what triggers fork_usermode_blob().
> It's always kernel code == trusted code.

How can that part be guaranteed?
In future somebody might add a caller that allows

  sys_execute_anonymously_in_usermode(const char code, const int len) {
     return fork_usermode_blob(code, len);
  }

or something similar.

> The interface between kernel part of .ko and user part of .ko is
> specific to that particular kernel module. It's not a typical user space.

How can that part be guaranteed? A caller can pass arbitrary code including
typical user space program (e.g. /bin/sh).

> But when loaded the bpfilter.ko will start its user space side
> via fork_usermode_blob() that is specific to that version of .ko.

How can we guarantee that its user space side started via fork_usermode_blob()
is not disturbed (e.g. SIGKILL, SIGSTOP, /usr/bin/strace) ?

I consider that reliability (from "robustness" perspective) of fork_usermode_blob()
is same with CONFIG_INITRAMFS_SOURCE or call_usermodehelper() or init= approach.

