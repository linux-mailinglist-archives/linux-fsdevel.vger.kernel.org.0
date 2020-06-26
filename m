Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7E320B347
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgFZOKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 10:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbgFZOKQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:10:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC187207D8;
        Fri, 26 Jun 2020 14:10:14 +0000 (UTC)
Date:   Fri, 26 Jun 2020 16:10:11 +0200
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
Message-ID: <20200626141011.GA4140284@kroah.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 07:51:41AM -0500, Eric W. Biederman wrote:
> 
> Asking for people to fix their bugs in this user mode driver code has
> been remarkably unproductive.  So here are my bug fixes.
> 
> I have tested them by booting with the code compiled in and
> by killing "bpfilter_umh" and running iptables -vnL to restart
> the userspace driver.
> 
> I have split the changes into small enough pieces so they should be
> easily readable and testable.  
> 
> The changes lean into the preexisting interfaces in the kernel and
> remove special cases for user mode driver code in favor of solutions
> that don't need special cases.  This results in smaller code with
> fewer bugs.
> 
> At a practical level this removes the maintenance burden of the
> user mode drivers from the user mode helper code and from exec as
> the special cases are removed.
> 
> Similarly the LSM interaction bugs are fixed by not having unnecessary
> special cases for user mode drivers.
> 
> Please let me know if you see any bugs.  Once the code review is
> finished I plan to take this through my tree.
> 
> Eric W. Biederman (14):
>       umh: Capture the pid in umh_pipe_setup
>       umh: Move setting PF_UMH into umh_pipe_setup
>       umh: Rename the user mode driver helpers for clarity
>       umh: Remove call_usermodehelper_setup_file.
>       umh: Separate the user mode driver and the user mode helper support
>       umd: For clarity rename umh_info umd_info
>       umd: Rename umd_info.cmdline umd_info.driver_name
>       umd: Transform fork_usermode_blob into fork_usermode_driver
>       umh: Stop calling do_execve_file
>       exec: Remove do_execve_file
>       bpfilter: Move bpfilter_umh back into init data
>       umd: Track user space drivers with struct pid
>       bpfilter: Take advantage of the facilities of struct pid
>       umd: Remove exit_umh

After a quick read, all looks sane to me, nice cleanups!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
