Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B91196B26
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Mar 2020 06:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgC2E2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Mar 2020 00:28:55 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56646 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgC2E2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Mar 2020 00:28:54 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02T4SjTG009213;
        Sun, 29 Mar 2020 13:28:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Sun, 29 Mar 2020 13:28:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02T4SitU009210
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 29 Mar 2020 13:28:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH (repost)] umh: fix refcount underflow in
 fork_usermode_blob().
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp>
 <20200312143801.GJ23230@ZenIV.linux.org.uk>
 <a802dfd6-aeda-c454-6dd3-68e32a4cf914@i-love.sakura.ne.jp>
 <85163bf6-ae4a-edbb-6919-424b92eb72b2@i-love.sakura.ne.jp>
 <9b846b1f-a231-4f09-8c37-6bfb0d1e7b05@i-love.sakura.ne.jp>
 <20200328175512.e89ff65333e6c65fea211c12@linux-foundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f8099e95-c0fc-d133-471e-e0ba97d2230e@i-love.sakura.ne.jp>
Date:   Sun, 29 Mar 2020 13:28:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328175512.e89ff65333e6c65fea211c12@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/03/29 9:55, Andrew Morton wrote:
> On Fri, 27 Mar 2020 09:51:34 +0900 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
> 
>> Since free_bprm(bprm) always calls allow_write_access(bprm->file) and
>> fput(bprm->file) if bprm->file is set to non-NULL, __do_execve_file()
>> must call deny_write_access(file) and get_file(file) if called from
>> do_execve_file() path. Otherwise, use-after-free access can happen at
>> fput(file) in fork_usermode_blob().
>>
>>   general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b6b: 0000 [#1] SMP DEBUG_PAGEALLOC
>>   CPU: 3 PID: 4131 Comm: insmod Tainted: G           O      5.6.0-rc5+ #978
>>   Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/29/2019
>>   RIP: 0010:fork_usermode_blob+0xaa/0x190
> 
> This is rather old code - what casued this to be observed now?  Some
> unusual userspace behaviour?

I'm attempting to fix a regression for TOMOYO caused by commit 51f39a1f0cea1cac
("syscalls: implement execveat() system call") in 3.19 that execve() request fails
if fd argument is not AT_FDCWD, for TOMOYO needs to re-calculate "requested pathname
using AT_SYMLINK_NOFOLLOW" from LSM hook. That regression was practically not a big
problem because 99%+ of execve() request used AT_FDCWD, for in general executing a
program involves opening external libraries which have to be accessible from mount
namespace where execve() was requested. But commit 449325b52b7a6208 ("umh: introduce
fork_usermode_blob() helper") in 4.18 was a rather unique change that allows file-less
execution of a program, which means that file-less execution request fails because
TOMOYO can never calculate "requested pathname using AT_SYMLINK_NOFOLLOW".

This patch itself does not fix the regression for TOMOYO. But this patch fixes a
memory corruption bug which should be applied regardless of the regression for TOMOYO.
Although Al does not like this patch, I'd like to keep this patch minimal so that
RedHat folks can easily backport this patch to RHEL 8 (which uses 4.18).

