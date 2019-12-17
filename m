Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5043D1229AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 12:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfLQLTb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 06:19:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54240 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLQLTb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:19:31 -0500
Received: from [79.140.115.158] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ihAsy-0002PF-5x; Tue, 17 Dec 2019 11:19:28 +0000
Date:   Tue, 17 Dec 2019 12:19:27 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>, gpascutto@mozilla.com,
        ealvarez@mozilla.com, Florian Weimer <fweimer@redhat.com>,
        jld@mozilla.com
Subject: Re: [PATCH v3 2/4] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
Message-ID: <20191217111926.bgt7jih2noli3cnu@wittgenstein>
References: <20191217010001.GA14461@ircssh-2.c.rugged-nimbus-611.internal>
 <20191217015001.sp6mrhuiqrivkq3u@wittgenstein>
 <CAMp4zn8fzeiJVSn6EtRi6UAGh6AL3QWu=PZxw+=TAYJORjn_Sw@mail.gmail.com>
 <CAK8P3a3G-W8s0G2-XKuDw9dRmupZSyiF6FRRAnvDt9=kMMzS8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a3G-W8s0G2-XKuDw9dRmupZSyiF6FRRAnvDt9=kMMzS8w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 09:54:40AM +0100, Arnd Bergmann wrote:
> On Tue, Dec 17, 2019 at 3:50 AM Sargun Dhillon <sargun@sargun.me> wrote:
> > On Mon, Dec 16, 2019 at 5:50 PM Christian Brauner <christian.brauner@ubuntu.com> wrote:
> Finally, there is the question whether this should be an ioctl
> operation at all, or
> if it would better be done as a proper syscall. Functionally the two
> are the same
> here, but doing such a fundamental operation as an ioctl doesn't feel
> quite right
> to me. As a system call, this could be something like
> 
> int pidfd_get_fd(int pidfd, int their_fd, int flags);
> 
> along the lines of dup3().

Thanks for taking a look, Arnd!

Yeah, Oleg hinted at this in the first version as well. I originally
disagreed but we can sure also do this as a separate syscall.
What we should keep in mind is that people already brought up adding new
fds to a task. Which is not a problem just something to remember as it
might potentially mean another syscall.

Christian
