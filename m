Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8AF24827A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 12:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHRKEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 06:04:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37736 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHRKEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:04:30 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k7yTd-00008v-Jn; Tue, 18 Aug 2020 10:04:21 +0000
Date:   Tue, 18 Aug 2020 12:04:20 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH 01/17] exec: Move unshare_files to fix posix file locking
 during exec
Message-ID: <20200818100420.akdocgojdjhmq5z6@wittgenstein>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
 <20200817220425.9389-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200817220425.9389-1-ebiederm@xmission.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 05:04:09PM -0500, Eric W. Biederman wrote:
> Many moons ago the binfmts were doing some very questionable things
> with file descriptors and an unsharing of the file descriptor table
> was added to make things better[1][2].  The helper steal_files was
> added to avoid breaking the userspace programs[3][4][6].
> 
> Unfortunately it turned out that steal_locks did not work for network
> file systems[5], so it was removed to see if anyone would
> complain[7][8].  It was thought at the time that NPTL would not be
> affected as the unshare_files happened after the other threads were
> killed[8].  Unfortunately because there was an unshare_files in
> binfmt_elf.c before the threads were killed this analysis was
> incorrect.
> 
> This unshare_files in binfmt_elf.c resulted in the unshares_files
> happening whenever threads were present.  Which led to unshare_files
> being moved to the start of do_execve[9].
> 
> Later the problems were rediscovered and suggested approach was to
> readd steal_locks under a different name[10].  I happened to be
> reviewing patches and I noticed that this approach was a step
> backwards[11].
> 
> I proposed simply moving unshare_files[12] and it was pointed
> out that moving unshare_files without auditing the code was
> also unsafe[13].
> 
> There were then several attempts to solve this[14][15][16] and I even
> posted this set of changes[17].  Unfortunately because auditing all of
> execve is time consuming this change did not make it in at the time.
> 
> Well now that I am cleaning up exec I have made the time to read
> through all of the binfmts and the only playing with file descriptors
> is either the security modules closing them in
> security_bprm_committing_creds or is in the generic code in fs/exec.c.
> None of it happens before begin_new_exec is called.
> 
> So move unshare_files into begin_new_exec, after the point of no
> return.  If memory is very very very low and the application calling
> exec is sharing file descriptor tables between processes we might fail
> past the point of no return.  Which is unfortunate but no different
> than any of the other places where we allocate memory after the point
> of no return.
> 
> This movement allows another process that shares the file table, or
> another thread of the same process and that closes files or changes
> their close on exec behavior and races with execve to cause some
> unexpected things to happen.  There is only one time of check to time

It seems to only make the already existing race window wider by moving
it from bprm_execve() to begin_new_exec() which isn't great but probably
ok since done for a good reason.

> of use race and it is just there so that execve fails instead of
> an interpreter failing when it tries to open the file it is supposed
> to be interpreting.   Failing later if userspace is being silly is
> not a problem.
> 
> With this change it the following discription from the removal
> of steal_locks[8] finally becomes true.
> 
>     Apps using NPTL are not affected, since all other threads are killed before
>     execve.
> 
>     Apps using LinuxThreads are only affected if they
> 
>       - have multiple threads during exec (LinuxThreads doesn't kill other
>         threads, the app may do it with pthread_kill_other_threads_np())
>       - rely on POSIX locks being inherited across exec
> 
>     Both conditions are documented, but not their interaction.
> 
>     Apps using clone() natively are affected if they
> 
>       - use clone(CLONE_FILES)
>       - rely on POSIX locks being inherited across exec
> 
> I have investigated some paths to make it possible to solve this
> without moving unshare_files but they all look more complicated[18].
> 
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> Reported-by: Jeff Layton <jlayton@redhat.com>
> History-tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> [1] 02cda956de0b ("[PATCH] unshare_files"
> [2] 04e9bcb4d106 ("[PATCH] use new unshare_files helper")
> [3] 088f5d7244de ("[PATCH] add steal_locks helper")
> [4] 02c541ec8ffa ("[PATCH] use new steal_locks helper")
> [5] https://lkml.kernel.org/r/E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu
> [6] https://lkml.kernel.org/r/0060321191605.GB15997@sorel.sous-sol.org
> [7] https://lkml.kernel.org/r/E1FLwjC-0000kJ-00@dorka.pomaz.szeredi.hu
> [8] c89681ed7d0e ("[PATCH] remove steal_locks()")
> [9] fd8328be874f ("[PATCH] sanitize handling of shared descriptor tables in failing execve()")
> [10] https://lkml.kernel.org/r/20180317142520.30520-1-jlayton@kernel.org
> [11] https://lkml.kernel.org/r/87r2nwqk73.fsf@xmission.com
> [12] https://lkml.kernel.org/r/87bmfgvg8w.fsf@xmission.com
> [13] https://lkml.kernel.org/r/20180322111424.GE30522@ZenIV.linux.org.uk
> [14] https://lkml.kernel.org/r/20180827174722.3723-1-jlayton@kernel.org
> [15] https://lkml.kernel.org/r/20180830172423.21964-1-jlayton@kernel.org
> [16] https://lkml.kernel.org/r/20180914105310.6454-1-jlayton@kernel.org
> [17] https://lkml.kernel.org/r/87a7ohs5ow.fsf@xmission.com
> [18] https://lkml.kernel.org/r/87pn8c1uj6.fsf_-_@x220.int.ebiederm.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---

Slightly scary change but it solves a problem.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
