Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43BF209D37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 13:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404077AbgFYLEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 07:04:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55079 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404042AbgFYLEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:04:38 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05PB3R1n042337;
        Thu, 25 Jun 2020 20:03:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Thu, 25 Jun 2020 20:03:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05PB3ROU042332
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 25 Jun 2020 20:03:27 +0900 (JST)
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
References: <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org>
 <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
 <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
 <20200625013518.chuqehybelk2k27x@ast-mbp.dhcp.thefacebook.com>
 <b83831ba-c330-7eb8-e6d5-5087de68a9b8@i-love.sakura.ne.jp>
 <20200625095725.GA3303921@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
Date:   Thu, 25 Jun 2020 20:03:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625095725.GA3303921@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/25 18:57, Greg KH wrote:
> On Thu, Jun 25, 2020 at 03:38:14PM +0900, Tetsuo Handa wrote:
>> My questions are:
>>
>> (1) "Signed and in-tree kernel module" assertion is pointless.
>>     In future, some of in-tree kernel modules might start using fork_usermode_blob()
>>     instead of call_usermodehelper(), with instructions containing what your initial
>>     use case does not use. There is no guarantee that such thing can't happen.
> 
> I hope that this would happen for some tools, what's wrong with that?
> That means we can ship those programs from within the kernel source tree
> instead of trying to rely on keeping a specific user/kernel api stable
> for forever.
> 
> That would be a good thing, right?

Some in-tree users might start embedding byte array containing userspace programs
like /bin/sh when building kernels. How can we prove that such thing won't happen?
I consider that the byte array can contain arbitrary instructions (regardless of
some tools used for building the byte array).

> 
>>     Assuming that there will be multiple blobs, we need a way to identify these blobs.
>>     How does fork_usermode_blob() provide information for identification?
> 
> If the kernel itself was running these blobs, why would LSM care about
> it?  These are coming from "within the building!" don't you trust the
> kernel already?
> 
> I don't understand the issue here.

The byte array came from the kernel, but due to possibility of "root can poke into
kernel or any process memory.", that byte array can become as untrusted as byte
array coming from userspace. There is no concept like "the kernel itself _is_ running
these blobs". Only a fact "the byte array _was_ copied from the kernel address space
(rather than from some file on the filesystem)" exists. We need a mechanism (ideally,
without counting on LSMs) for avoid peeking/poking etc. into/from the byte array
which was copied from the kernel address space to user address space.



>>     call_usermodehelper() can teach LSM modules via pre-existing file's pathname and
>>     inode's security label at security_bprm_creds_for_exec()/security_bprm_check() etc.
>>     But since fork_usermode_blob() accepts only "byte array" and "length of byte array"
>>     arguments, I'm not sure whether LSM modules can obtain information needed for
>>     inspection. How does fork_usermode_blob() tell that information?
> 
> It would seem that the "security context" for those would be the same as
> anything created before userspace launches today, right?  You handle
> that ok, and this should be just the same.

I don't think so. Today when call_usermodehelper() is called, LSMs switch their security
context (at least TOMOYO does it) for further syscalls from the usermode process started
by the kernel context. But when fork_usermode_blob() is called, how LSMs can switch their
security context for further syscalls from the usermode process started by the kernel
context?

> 
> But again, as these programs are coming from "within the kernel", why
> would you want to disallow them?  If you don't want to allow them, don't
> build them into your kernel?  :)

I'm talking about not only "disallow unauthorized execve() request" but also "disallow
unauthorized syscalls after execve() request". Coming from the kernel is not important.



>>     Thus, LSM modules (including pathname based security) want to control how that byte
>>     array can behave. And how does fork_usermode_blob() tell necessary information?
> 
> Think of these blobs just as any other kernel module would be today.

No, I can't. How can we guarantee that the byte array came from kernel remains intact
despite the possibility of "root can poke into kernel or any process memory" ?

> Right now I, as a kernel module, can read/write to any file in the
> system, and do all sorts of other fun things.  You can't mediate that
> today from a LSM, and this is just one other example of this.

Some functions (e.g. kernel_sock_shutdown()) bypass permission checks by LSMs
comes from a sort of trustness that the byte array kept inside kernel address
space remains secure/intact.

> 
> The "only" change is that now this code is running in userspace context,
> which for an overall security/system issue, should be better than
> running it in kernel context, right?

As soon as exposing that byte array outside of kernel address space, processes
running such byte array are considered insecure/tampered. We can't prove that
the byte array exposed to outside of kernel address space does only limited
set of instructions, and we have to perform permission checks by LSMs.

And LSMs need to receive the intent (or "security context" argument) from fork_usermode_blob()
for restricting further syscalls by the usermode process started via fork_usermode_blob().

> 
> Perhaps we just add new LSM hooks for every place that we call this new
> function to run a blob?  That will give you the needed "the kernel is
> about to run a blob that we think is a userspace USB IR filter driver",
> or whatever the blob does.

Yes, that would be the intent (or "security context" argument) fork_usermode_blob()
is missing. Though I don't know how such stringuish argument can be represented for
individual LSM modules...

