Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E55125F26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 11:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLSKfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 05:35:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37547 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfLSKfb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:35:31 -0500
Received: from [79.140.121.60] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iht9T-00014D-C2; Thu, 19 Dec 2019 10:35:27 +0000
Date:   Thu, 19 Dec 2019 11:35:26 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>, gpascutto@mozilla.com,
        ealvarez@mozilla.com, Florian Weimer <fweimer@redhat.com>,
        jld@mozilla.com
Subject: Re: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
Message-ID: <20191219103525.yqb5f4pbd2dvztkb@wittgenstein>
References: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal>
 <CAK8P3a2eT=bHkUamyp-P3Y2adNq1KBk7UknCYBY5_aR4zJmYaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2eT=bHkUamyp-P3Y2adNq1KBk7UknCYBY5_aR4zJmYaQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 19, 2019 at 09:03:09AM +0100, Arnd Bergmann wrote:
> On Thu, Dec 19, 2019 at 12:55 AM Sargun Dhillon <sargun@sargun.me> wrote:
> 
> > +#define PIDFD_IOCTL_GETFD      _IOWR('p', 0xb0, __u32)
> 
> This describes an ioctl command that reads and writes a __u32 variable
> using a pointer passed as the argument, which doesn't match the
> implementation:
> 
> > +static long pidfd_getfd(struct pid *pid, u32 fd)
> > +{
> ...
> > +       return retfd;
> 
> This function passes an fd as the argument and returns a new
> fd, so the command number would be
> 
> #define PIDFD_IOCTL_GETFD      _IO('p', 0xb0)
> 
> While this implementation looks easy enough, and it is roughly what
> I would do in case of a system call, I would recommend for an ioctl

I guess this is the remaining question we should settle, i.e. what do we
prefer.
I still think that adding a new syscall for this seems a bit rich. On
the other hand it seems that a lot more people agree that using a
dedicated syscall instead of an ioctl is the correct way; especially
when it touches core kernel functionality. I mean that was one of the
takeaways from the pidfd API ioctl-vs-syscall discussion.

A syscall is nicer especially for core-kernel code like this.
So I guess the only way to find out is to try the syscall approach and
either get yelled and switch to an ioctl() or have it accepted.

What does everyone else think? Arnd, still in favor of a syscall I take
it. Oleg, you had suggested a syscall too, right? Florian, any
thoughts/worries on/about this from the glibc side?

Christian
