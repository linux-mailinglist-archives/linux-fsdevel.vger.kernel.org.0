Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979A32099EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 08:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389952AbgFYGj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 02:39:26 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54324 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgFYGjZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:39:25 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05P6cEwX080687;
        Thu, 25 Jun 2020 15:38:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Thu, 25 Jun 2020 15:38:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05P6cEJh080683
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 25 Jun 2020 15:38:14 +0900 (JST)
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
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org>
 <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org>
 <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
 <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
 <20200625013518.chuqehybelk2k27x@ast-mbp.dhcp.thefacebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b83831ba-c330-7eb8-e6d5-5087de68a9b8@i-love.sakura.ne.jp>
Date:   Thu, 25 Jun 2020 15:38:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625013518.chuqehybelk2k27x@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/25 10:35, Alexei Starovoitov wrote:
>> What is unhappy for pathname based LSMs is that fork_usermode_blob() creates
>> a file with empty filename. I can imagine that somebody would start abusing
>> fork_usermode_blob() as an interface for starting programs like modprobe, hotplug,
>> udevd and sshd. When such situation happened, how fork_usermode_blob() provides
>> information for identifying the intent of such execve() requests?
>>
>> fork_usermode_blob() might also be an unhappy behavior for inode based LSMs (like
>> SELinux and Smack) because it seems that fork_usermode_blob() can't have a chance
>> to associate appropriate security labels based on the content of the byte array
>> because files are created on-demand. Is fork_usermode_blob() friendly to inode
>> based LSMs?
> 
> blob is started by a kernel module. Regardless of path existence that kernel module
> could have disabled any LSM and any kernel security mechanism.
> People who write out of tree kernel modules found ways to bypass EXPORT_SYMBOL
> with and without _GPL. Modules can do anything. It's only the number of hoops
> they need to jump through to get what they want.

So what? I know that. That's irrelevant to my questions.

> Signed and in-tree kernel module is the only way to protect the integrity of the system.
> That's why user blob is part of kernel module elf object and it's covered by the same
> module signature verification logic.

My questions are:

(1) "Signed and in-tree kernel module" assertion is pointless.
    In future, some of in-tree kernel modules might start using fork_usermode_blob()
    instead of call_usermodehelper(), with instructions containing what your initial
    use case does not use. There is no guarantee that such thing can't happen.
    Assuming that there will be multiple blobs, we need a way to identify these blobs.
    How does fork_usermode_blob() provide information for identification?

(2) Running some blob in usermode means that permission checks by LSM modules will
    be enforced. For example, socket's shutdown operation via shutdown() syscall from
    usermode blob will involve security_socket_shutdown() check.
    
    ----------
    int kernel_sock_shutdown(struct socket *sock, enum sock_shutdown_cmd how)
    {
            return sock->ops->shutdown(sock, how);
    }
    ----------
    
    ----------
    int __sys_shutdown(int fd, int how)
    {
            int err, fput_needed;
            struct socket *sock;
    
            sock = sockfd_lookup_light(fd, &err, &fput_needed);
            if (sock != NULL) {
                    err = security_socket_shutdown(sock, how);
                    if (!err)
                            err = sock->ops->shutdown(sock, how);
                    fput_light(sock->file, fput_needed);
            }
            return err;
    }
    
    SYSCALL_DEFINE2(shutdown, int, fd, int, how)
    {
            return __sys_shutdown(fd, how);
    }
    ----------
    
    I don't know what instructions your blob would contain. But even if the blobs
    containing your initial use case use only setsockopt()/getsockopt() syscalls,
    LSM modules have rights to inspect and reject these requests from usermode blobs
    via security_socket_setsockopt()/security_socket_getsockopt() hooks. In order to
    inspect these requests, LSM modules need information (so called "security context"),
    and fork_usermode_blob() has to be able to somehow teach that information to LSM
    modules. Pathname is one of information for pathname based LSM modules. Inode's
    security label is one of information for inode based LSM modules.
    
    call_usermodehelper() can teach LSM modules via pre-existing file's pathname and
    inode's security label at security_bprm_creds_for_exec()/security_bprm_check() etc.
    But since fork_usermode_blob() accepts only "byte array" and "length of byte array"
    arguments, I'm not sure whether LSM modules can obtain information needed for
    inspection. How does fork_usermode_blob() tell that information?

(3) Again, "root can poke into kernel or any process memory." assertion is pointless.
    Answering to your questions

      > hmm. do you really mean that it's possible for an LSM to restrict CAP_SYS_ADMIN effectively?
      Not every LSM module restricts CAP_* flags. But LSM modules can implement finer grained
      restrictions than plain CAP_* flags.

      > How elf binaries embedded in the kernel modules different from pid 1?
      No difference.

      > If anything can peek into their memory the system is compromised.
      Permission checks via LSM modules are there to prevent such behavior.

      > Say, there are no user blobs in kernel modules. How pid 1 memory is different
      > from all the JITed images? How is it different for all memory regions shared
      > between kernel and user processes?
      I don't know what "the JITed images" means. But I guess that the answer is
      "No difference".

    Then, I ask you back.

    Although the byte array (which contains code / data) might be initially loaded from
    the kernel space (which is protected), that byte array is no longer protected (e.g.
    SIGKILL, ptrace()) when executed because they are placed in the user address space.

    Why the usermode process started by fork_usermode_blob() cannot interfere (or be
    interfered by) the rest of the system (including normal usermode processes) ?
    And I guess that your answer is "the usermode process started by fork_usermode_blob()
    _can_ (and be interfered by) the rest of the system, for they are nothing but
    normal usermode processes."

    Thus, LSM modules (including pathname based security) want to control how that byte
    array can behave. And how does fork_usermode_blob() tell necessary information?

Your answers up to now did not convince LSM modules to ignore what the usermode process
started by fork_usermode_blob() can do. If you again don't answer my questions, I'll
ack to https://lkml.kernel.org/r/875zc4c86z.fsf_-_@x220.int.ebiederm.org .

