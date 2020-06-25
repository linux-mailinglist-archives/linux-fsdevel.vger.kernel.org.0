Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF2209FCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 15:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404966AbgFYNZ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 09:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404888AbgFYNZy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:25:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1837420702;
        Thu, 25 Jun 2020 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593091554;
        bh=Zo4VA4OcklTBlXrdN2hk4i87r+8uEzcz/Mh/YqPzpUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcqK+e0oDQ9Bpi9lykZcRJYfUEzV7tu5PvAuVo/S5XenzmdpbGv9aNveQVMJeSagz
         w+rsxzNuhdD6ctUlFx4MaF6h8wZKVcYodeWmMhRYXBhoGd52ad5aX1yYx4KKIdBt1q
         gY2MOFFjAii+Vk4/6byOgMBslnXLzK/1C1rjQJpU=
Date:   Thu, 25 Jun 2020 15:25:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200625132551.GB3526980@kroah.com>
References: <87ftaxd7ky.fsf@x220.int.ebiederm.org>
 <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org>
 <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
 <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
 <CAEjxPJ4e9rWWssp0CyM7GM7NP_QKkswHK7URwLZFqo5+wGecQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ4e9rWWssp0CyM7GM7NP_QKkswHK7URwLZFqo5+wGecQw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 08:56:10AM -0400, Stephen Smalley wrote:
> On Wed, Jun 24, 2020 at 7:16 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > What is unhappy for pathname based LSMs is that fork_usermode_blob() creates
> > a file with empty filename. I can imagine that somebody would start abusing
> > fork_usermode_blob() as an interface for starting programs like modprobe, hotplug,
> > udevd and sshd. When such situation happened, how fork_usermode_blob() provides
> > information for identifying the intent of such execve() requests?
> >
> > fork_usermode_blob() might also be an unhappy behavior for inode based LSMs (like
> > SELinux and Smack) because it seems that fork_usermode_blob() can't have a chance
> > to associate appropriate security labels based on the content of the byte array
> > because files are created on-demand. Is fork_usermode_blob() friendly to inode
> > based LSMs?
> 
> No, because we cannot label the inode based on the program's purpose
> and therefore cannot configure an automatic transition to a suitable
> security context for the process, unlike call_usermodehelper().

Why, what prevents this?  Can you not just do that based on the "blob
address" or signature of it or something like that?  Right now you all
do this based on inode of a random file on a disk, what's the difference
between a random blob in memory?

> It is
> important to note that the goal of such transitions is not merely to
> restrict the program from doing bad things but also to protect the
> program from untrustworthy inputs, e.g. one can run kmod/modprobe in a
> domain that can only read from authorized kernel modules, prevent
> following untrusted symlinks, etc.  Further, at present, the
> implementation creates the inode via shmem_kernel_file_setup(), which
> is supposed to be for inodes private to the kernel not exposed to
> userspace (hence marked S_PRIVATE), which I believe in this case will
> end up leaving the inode unlabeled but still end up firing checks in
> the bprm hooks on the file inode, thereby potentially yielding denials
> in SELinux on the exec of unlabeled files.  Not exactly what we would
> want.  If users were to switch from using call_usermodehelper() to
> fork_usermode_blob() we would need them to label the inode in some
> manner to reflect the program purpose prior to exec.  I suppose they
> could pass in some string key and SELinux could look it up in policy
> to get a context to use or something.

Sure, that would work.

> On a different note, will the usermode blob be measured by IMA prior
> to execution?  What ensures that the blob was actually embedded in the
> kernel image and wasn't just supplied as data through exploitation of
> a kernel vulnerability or malicious kernel module?

No reason it couldn't be passed to IMA for measuring, if people want to
do that.

thanks,

greg k-h
