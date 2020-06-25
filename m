Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837C920A0C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 16:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405342AbgFYOWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 10:22:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62204 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404890AbgFYOWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:22:14 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05PEL9iM055217;
        Thu, 25 Jun 2020 23:21:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Thu, 25 Jun 2020 23:21:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05PEL95i055207
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 25 Jun 2020 23:21:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Greg KH <greg@kroah.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org>
 <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
 <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
 <20200625013518.chuqehybelk2k27x@ast-mbp.dhcp.thefacebook.com>
 <b83831ba-c330-7eb8-e6d5-5087de68a9b8@i-love.sakura.ne.jp>
 <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <46edbddb-6da8-d9b6-1ad2-9e24ac74fbcf@i-love.sakura.ne.jp>
Date:   Thu, 25 Jun 2020 23:21:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625120725.GA3493334@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/25 21:07, Greg KH wrote:
>>>>     call_usermodehelper() can teach LSM modules via pre-existing file's pathname and
>>>>     inode's security label at security_bprm_creds_for_exec()/security_bprm_check() etc.
>>>>     But since fork_usermode_blob() accepts only "byte array" and "length of byte array"
>>>>     arguments, I'm not sure whether LSM modules can obtain information needed for
>>>>     inspection. How does fork_usermode_blob() tell that information?
>>>
>>> It would seem that the "security context" for those would be the same as
>>> anything created before userspace launches today, right?  You handle
>>> that ok, and this should be just the same.
>>
>> I don't think so. Today when call_usermodehelper() is called, LSMs switch their security
>> context (at least TOMOYO does it) for further syscalls from the usermode process started
>> by the kernel context. But when fork_usermode_blob() is called, how LSMs can switch their
>> security context for further syscalls from the usermode process started by the kernel
>> context?
> 
> Ok, that makes a bit more sense.  Why not just do the same thing that
> you do today with call_usermodehelper()?  The logic in a way is the
> same, right?
> 

call_usermodehelper() provides information like "the kernel is about to run
/sbin/modprobe in order to load foo module" but fork_usermode_blob() does not
provide information like "the kernel is about to run a blob that we think is
a userspace USB IR filter driver". That is unfriendly to LSM modules.

> 
>>> Right now I, as a kernel module, can read/write to any file in the
>>> system, and do all sorts of other fun things.  You can't mediate that
>>> today from a LSM, and this is just one other example of this.
>>
>> Some functions (e.g. kernel_sock_shutdown()) bypass permission checks by LSMs
>> comes from a sort of trustness that the byte array kept inside kernel address
>> space remains secure/intact.
> 
> And what is going to change that "trustness" here?  The byte array came
> from the kernel address space to start with.  Are you thinking something
> outside of the kernel will then tamper with those bytes to do something
> else with them?

Right. e.g. ptrace() will allow reading/writing those bytes to do something
else with them. I guess 'gdb -p' is the same meaning.

>                  If so, shouldn't you be preventing that userspace
> program that does the tampering from doing that in the first place with
> the LSM running?

SELinux can handle process isolation very well. But the reality is that none of customers
I'm working for can afford using SELinux because SELinux is too complicated to support.
Instead, they use proprietary antivirus kernel modules (which tamper with syscall tables
and/or security_hook_heads). Therefore, I wish that isolation between processes running
fork_usermode_blob() and processes running normal usermode programs is implemented by
built-in mechanism (like DAC), and I said

  We might need to invent built-in "protected userspace" because existing
  "unprotected userspace" is not trustworthy enough to run kernel modules.
  That's not just inventing fork_usermode_blob().

at https://lkml.kernel.org/r/62859212-df69-b913-c1e0-cd2e358d1adf@i-love.sakura.ne.jp .
I'm happy if we can implement such isolation without counting on in-tree LSMs.

