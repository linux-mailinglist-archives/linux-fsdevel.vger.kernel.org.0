Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70E51F7186
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 02:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFLA6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 20:58:46 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54474 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLA6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 20:58:45 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05C0vilX017075;
        Fri, 12 Jun 2020 09:57:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Fri, 12 Jun 2020 09:57:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05C0vh7p017069
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 12 Jun 2020 09:57:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <87r1uo2ejt.fsf@x220.int.ebiederm.org>
 <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
 <87d066vd4y.fsf@x220.int.ebiederm.org>
 <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <62859212-df69-b913-c1e0-cd2e358d1adf@i-love.sakura.ne.jp>
Date:   Fri, 12 Jun 2020 09:57:40 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/12 8:31, Alexei Starovoitov wrote:
> On Wed, Jun 10, 2020 at 04:12:29PM -0500, Eric W. Biederman wrote:
>> We probably also need to have a conversation about why this
>> functionality is a better choice that using a compiled in initramfs,
>> such as can be had by setting CONFIG_INITRAMFS_SOURCE.

I agree. CONFIG_INITRAMFS_SOURCE or call_usermodehelper() should be fine.

>> Even with this write up and the conversations so far I don't understand
>> what problem fork_usermode_blob is supposed to be solving.  Is there
>> anything kernel version dependent about bpf_lsm?  For me the primary
>> justification of something like fork_usermode_blob is something that is
>> for all practical purposes a kernel module but it just happens to run in
>> usermode.
> 
> that's what it is. It's a kernel module that runs in user space.
> 

How can the code running in the userspace memory be protected? Like you said

  It's nice to be able to compile that blob with -g and be able to 'gdb -p' into it.
  That works and very convenient when it comes to debugging. Compare that to debugging
  a kernel module!

, the userspace memory can be easily interfered from userspace. The kernel module
running in kernel space is protected (unless methods like /dev/{mem,kmem} are used)
but the kernel module running in user space is not protected.

You said

  What you're saying is tomoyo doesn't trust kernel modules that are built-in
  as part of vmlinux and doesn't trust vmlinux build.

but the word 'trust' has multiple aspects. One of aspects is "can the program
contain malicious code?" which would be mitigated by cryptographic signing
technology. But another aspect is "does the program contain vulnerability or
bugs?" which would be mitigated by updating programs as soon as possible.
Yet another aspect is "is the program protected from interference?" which would
be mitigated by enforcing sandbox like seccomp. But to enforce it, we need
information for identifying what does the code need to do.

We might need to invent built-in "protected userspace" because existing
"unprotected userspace" is not trustworthy enough to run kernel modules.
That's not just inventing fork_usermode_blob().



>> Strictly speaking I am also aware of the issue that the kernel has to
>> use set_fs(KERNEL_DS) to allow argv and envp to exist in kernel space
>> instead of userspace.  That needs to be fixed as well, but for all
>> kernel uses of exec.  So any work fixing fork_usermode_blob can ignore
>> that issue.
> 
> well, this is the problem of usermodehelper_exec.
> usermode_blob doesn't use argv/envp.
> They could be NULL for all practical purpose.
> 

That's what TOMOYO LSM does not like. You said

  tomoyo does path name resolution as a string and using that for security?
  I'm looking at tomoyo_realpath*() and tomoyo_pathcmp(). Ouch.
  Path based security is anti pattern of security.

but, like Casey mentioned, pathnames/argv/envp etc. represents *user intentions*
for controlling what that code can do.

A method for allow anonymously running arbitrary code in userspace memory (which
can be interfered) is so painful. I won't be able to trust kernel modules running
in userspace memory.
