Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0541F2922
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 02:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbgFHXXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 19:23:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58937 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731430AbgFHXXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:23:05 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 058NMDxO028517;
        Tue, 9 Jun 2020 08:22:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp);
 Tue, 09 Jun 2020 08:22:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 058NMD61028513
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 9 Jun 2020 08:22:13 +0900 (JST)
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
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook> <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <af00d341-6046-e187-f5c8-5f57b40f017c@i-love.sakura.ne.jp>
Date:   Tue, 9 Jun 2020 08:22:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/09 1:23, Alexei Starovoitov wrote:
> On Sun, Jun 07, 2020 at 11:31:05AM +0900, Tetsuo Handa wrote:
>> On 2020/06/07 10:49, Alexei Starovoitov wrote:
>>> So you're right that for most folks user space is the
>>> answer. But there are cases where kernel has to have these things before
>>> systemd starts.
>>
>> Why such cases can't use init= kernel command line argument?
>> The program specified via init= kernel command line argument can do anything
>> before systemd (a.k.a. global init process) starts.
>>
>> By the way, from the LSM perspective, doing a lot of things before global init
>> process starts is not desirable, for access decision can be made only after policy
>> is loaded (which is generally when /sbin/init on a device specified via root=
>> kernel command line argument becomes ready). Since
>> fork_usermode_blob((void *) "#!/bin/true\n", 12, info) is possible, I worry that
>> the ability to start userspace code is abused for bypassing dentry/inode-based
>> permission checks.
> 
> bpf_lsm is that thing that needs to load and start acting early.
> It's somewhat chicken and egg. fork_usermode_blob() will start a process
> that will load and apply security policy to all further forks and execs.

fork_usermode_blob() would start a process in userspace, but early in the boot
stage means that things in the kernel might not be ready to serve for userspace
processes (e.g. we can't open a shared library before a filesystem containing
that file becomes ready, we can't mount a filesystem before mount point becomes
ready, we can't access mount point before a device that contains that directory
becomes ready).

TOMOYO LSM module uses call_usermodehelper() from tomoyo_load_policy() in order to
load and apply security policy. What is so nice with fork_usermode_blob() compared
to existing call_usermodehelper(), at the cost of confusing LSM modules by allowing
file-less execve() request from fork_usermode_blob() ?
