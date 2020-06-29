Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8609C20CBB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 04:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgF2CV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jun 2020 22:21:28 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60985 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgF2CV2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jun 2020 22:21:28 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05T2KJWq076036;
        Mon, 29 Jun 2020 11:20:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Mon, 29 Jun 2020 11:20:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05T2KIxF076032
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 29 Jun 2020 11:20:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
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
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <40720db5-92f0-4b5b-3d8a-beb78464a57f@i-love.sakura.ne.jp>
 <87366g8y1e.fsf@x220.int.ebiederm.org>
 <aa737d87-cf38-55d6-32f1-2d989a5412ea@i-love.sakura.ne.jp>
 <20200628194440.puzh7nhdnk6i4rqj@ast-mbp.dhcp.thefacebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c99d0cfc-8526-0daf-90b5-33e560efdede@i-love.sakura.ne.jp>
Date:   Mon, 29 Jun 2020 11:20:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200628194440.puzh7nhdnk6i4rqj@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/29 4:44, Alexei Starovoitov wrote:
> But all the defensive programming kinda goes against general kernel style.
> I wouldn't do it. Especially pr_info() ?!
> Though I don't feel strongly about it.

Honestly speaking, caller should check for errors and print appropriate
messages. info->wd.mnt->mnt_root != info->wd.dentry indicates that something
went wrong (maybe memory corruption). But other conditions are not fatal.
That is, I consider even pr_info() here should be unnecessary.

> 
> I would like to generalize elf_header_check() a bit and call it
> before doing blob_to_mnt() to make sure that all blobs are elf files only.
> Supporting '#!/bin/bash' or other things as blobs seems wrong to me.

Why? There is no point with forbidding "#!", for users can use a wrapper
ELF binary which contains instructions including glibc's execv()/system()
functions even if "#!" cannot be used.

What is more important is what protection/isolation properties processes started
via fork_usermode_driver() should hold, for ELF binary can contain arbitrary
instructions, these processes run as daemons (reading request from stdin and
writing response to stdout) but hidden from "/usr/bin/pstree -p 1" (because
they are forked from kthreadd kernel thread).

