Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6424E2F8C6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jan 2021 10:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbhAPJIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jan 2021 04:08:15 -0500
Received: from verein.lst.de ([213.95.11.211]:43015 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbhAPJIG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:08:06 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2912A6736F; Sat, 16 Jan 2021 10:07:22 +0100 (CET)
Date:   Sat, 16 Jan 2021 10:07:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Ryan Houdek <sonicadvance1@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Amanieu d'Antras <amanieu@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>, Jan Kara <jack@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] Adds a new ioctl32 syscall for backwards compatibility
 layers
Message-ID: <20210116090721.GA30277@lst.de>
References: <20210106064807.253112-1-Sonicadvance1@gmail.com> <CAK8P3a2tV3HzPpbCR7mAeutx38_D2d-vfpEgpXv+GW_98w3VSQ@mail.gmail.com> <CABnRqDfQ5Qfa2ybut0qXcKuYnsMcG7+9gqjL-e7nZF1bkvhPRw@mail.gmail.com> <CAK8P3a2vfVfEWTk1ig349LGqt8bkK8YQWjE6PRyx+xvgYx7-gA@mail.gmail.com> <CALCETrUtyVaGSE9fcFAkhrGCpkyYcYnZb6tj8227o2EH5hgOfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUtyVaGSE9fcFAkhrGCpkyYcYnZb6tj8227o2EH5hgOfg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 04:07:46PM -0800, Andy Lutomirski wrote:
> Finally, I'm not convinced that this patch works correctly.  We have
> in_compat_syscall(), and code that uses it may well be reachable from
> ioctl.

ioctls are the prime user of in_compat_syscall().

> I personally would like to see in_compat_syscall() go away,
> but some other people (Hi, Christoph!) disagree, and usage seems to be
> increasing, not decreasing.

I'm absolutely against it going away.  in_compat_syscall helped to
remove so much crap compared to the explicit compat syscalls.
