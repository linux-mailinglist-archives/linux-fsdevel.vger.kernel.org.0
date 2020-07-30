Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94648233617
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 17:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgG3Pyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 11:54:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55682 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgG3Pyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:54:52 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k1AtK-0000Fx-Sz; Thu, 30 Jul 2020 15:54:46 +0000
Date:   Thu, 30 Jul 2020 17:54:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        gerg@linux-m68k.org, ktkhai@virtuozzo.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <20200730155445.2xiyzbglibqlyioo@wittgenstein>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
 <20200730152705.ol42jppnl4xfhl32@wittgenstein>
 <20200730153450.GH23808@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730153450.GH23808@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 04:34:50PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 30, 2020 at 05:27:05PM +0200, Christian Brauner wrote:
> > On Thu, Jul 30, 2020 at 04:22:50PM +0100, Matthew Wilcox wrote:
> > > On Mon, Jul 27, 2020 at 10:11:22AM -0700, Anthony Yznaga wrote:
> > > > This patchset adds support for preserving an anonymous memory range across
> > > > exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
> > > > sharing memory in this manner, as opposed to re-attaching to a named shared
> > > > memory segment, is to ensure it is mapped at the same virtual address in
> > > > the new process as it was in the old one.  An intended use for this is to
> > > > preserve guest memory for guests using vfio while qemu exec's an updated
> > > > version of itself.  By ensuring the memory is preserved at a fixed address,
> > > > vfio mappings and their associated kernel data structures can remain valid.
> > > > In addition, for the qemu use case, qemu instances that back guest RAM with
> > > > anonymous memory can be updated.
> > > 
> > > I just realised that something else I'm working on might be a suitable
> > > alternative to this.  Apologies for not realising it sooner.
> > > 
> > > http://www.wil.cx/~willy/linux/sileby.html
> > 
> > Just skimming: make it O_CLOEXEC by default. ;)
> 
> I appreciate the suggestion, and it makes sense for many 'return an fd'
> interfaces, but the point of mshare() is to, well, share.  So sharing
> the fd with a child is a common usecase, unlike say sharing a timerfd.

Fair point, from reading I thought the main reason was share after
fork() but having an fd over exec() may be a good use-case too.
(Fwiw, this very much looks like what the memfd_create() api should have
looked like, i.e. mshare() could've possibly encompassed both.)

> The only other reason to use mshare() is to pass the fd over a unix
> socket to a non-child, and I submit that is far less common than wanting
> to share with a child.

Well, we have use-cases for that too. E.g. where we need to attach to an
existing pid namespace which requires a first fork() of an intermediate
process so that the caller doesn't change the pid_for_children
namespace. Then we setns() to the target pid namespace in the
intermediate process which changes the pid_ns_children namespace such
that the next process will be a proper member of the target pid
namespace. Finally, we fork() the target process that is now a full
member of the target pid namespace. We also set CLONE_PARENT so
grandfather process == father process for the second process and then
have the intermediate process exit. Some fds we only ever open or create
after the intermediate process exited and some fds we can only open or
create after the intermediate process has been created and then send the
fds via scm (since we can't share the fdtable) to the final process.

Christian
