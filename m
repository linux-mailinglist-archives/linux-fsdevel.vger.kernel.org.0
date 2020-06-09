Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717491F4A1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 01:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgFIXbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 19:31:36 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56036 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgFIXbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:31:35 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 059NUUGa002609;
        Wed, 10 Jun 2020 08:30:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Wed, 10 Jun 2020 08:30:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 059NUUq4002606
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 10 Jun 2020 08:30:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
 <af00d341-6046-e187-f5c8-5f57b40f017c@i-love.sakura.ne.jp>
 <20200609012826.dssh2lbfr6tlhwwa@ast-mbp.dhcp.thefacebook.com>
 <ddabab93-4660-3a46-8b05-89385e292b75@i-love.sakura.ne.jp>
 <20200609223214.43db3orsyjczb2dd@ast-mbp.dhcp.thefacebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <6a8b284f-461e-11b5-9985-6dc70012f774@i-love.sakura.ne.jp>
Date:   Wed, 10 Jun 2020 08:30:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609223214.43db3orsyjczb2dd@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/10 7:32, Alexei Starovoitov wrote:
>> You can't start a usermode helper which requires access to filesystems (e.g. ELF loaders,
>> shared libraries) before call_usermodehelper() can start a usermode helper which requires
>> access to filesystems. Under such a restricted condition, what is nice with starting a
>> usermode helper? Programs which can be started under such condition will be quite limited.
>> My question is: why you can't use existing call_usermodehelper() (if you need to call
>> a usermode helper) ?
> 
> I think the confusion comes from assumption that usermode blob is a dynamic file that
> needs ld.so, shared libs and rootfs.

Yes, I assume that usermode blob needs to be able to access the rootfs.

>                                      This mode is supported by the blob loading
> logic, but it's not a primary use case. It's nice to be able to compile
> that blob with -g and be able to 'gdb -p' into it.

Where can the gdb come from when the rootfs is not accessible?

>                                                    That works and very
> convenient when it comes to debugging. Compare that to debugging a kernel module!

Userspace is convenient for debugging, at the cost of robustness (e.g. being killed
by SIGKILL).

> 
> The main mode of bpfilter operation was envisioned as rootfs-less.
> It must work with any init= including busybox. For production the bpfilter
> user mode blob was compiled as static binary with no dependencies.

I still can't imagine. Compiling a user mode blob as a static binary is possible.
But what does 'It must work with any init=' mean? The use of init= depends on
the rootfs being ready.

> So there is no path to point to. It should be ready before pid 1
> will do its first iptables sys_setsockopt.

There has to be at least the root directory in order to use init= parameter.

What does the "pid 1" mean? Why you can't specify your "user mode blob" using init=
parameter and then transfer the control of "pid 1" from your "user mode blob" to
"some program which will do its first iptables sys_setsockopt()" ?

>                                            If user reboots the kernel
> with different init= cmdline the bpfilter should still be doing its job.
> Like builtin kernel module.

Even when rebooting the kernel with different init= cmdline, you have a space for
running your "user mode blob" (e.g.

  init=/path/to/your/user/mode/blob init_after_blob=/path/to/some/program/which/will/do/something/else

), don't you?

There is no need to use call_usermodehelper(), let alone fork_usermode_blob()...
