Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3539D10B76D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 21:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfK0UdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 15:33:02 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57120 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727016AbfK0UdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:33:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 930358EE133;
        Wed, 27 Nov 2019 12:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574886781;
        bh=8DP8rY2uFLUrxSI0vtoMZ4IFvwMnDyq6Oiy7cCM+0f4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EUvE1IDoXAo97xHGoJczlL07cJJSrwAr/fdTbKrwO6V2JSj/Cve6DUZyt1M9HE9P6
         BjM9dafy7I8NdiR5JC0JhzMu2GQD5xqhT5Ur2yOPQ7a4iFQQ9xF/+aR16kkTxCKR+u
         dmvD2wfaPjCeFoUAwN7I50udhiTL8fmJ2NyZwkaU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MOLd2uJIA_8q; Wed, 27 Nov 2019 12:33:00 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B61118EE130;
        Wed, 27 Nov 2019 12:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574886780;
        bh=8DP8rY2uFLUrxSI0vtoMZ4IFvwMnDyq6Oiy7cCM+0f4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MKt9QrGxESfHX7JZLaiasNnGuA7QCtfram9JLiBpfmaU6oTUJW2VnGnVZpt+25isG
         vSrDK2QRttL66wekpS7Jyum05RjhzYhkAqsr6LX/uoZcRndj08Hdp0K0gYvFuSKwWy
         bMnyMnhFIaPsdkCtqR8vio8HSRNQ283SUwbv2OzE=
Message-ID: <1574886778.21593.7.camel@HansenPartnership.com>
Subject: Re: Feature bug with the new mount API: no way of doing read only
 bind mounts
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 27 Nov 2019 12:32:58 -0800
In-Reply-To: <1574352920.3277.18.camel@HansenPartnership.com>
References: <1574295100.17153.25.camel@HansenPartnership.com>
         <17268.1574323839@warthog.procyon.org.uk>
         <1574352920.3277.18.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-11-21 at 08:15 -0800, James Bottomley wrote:
> On Thu, 2019-11-21 at 08:10 +0000, David Howells wrote:
> > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > 
> > > I was looking to use the read only bind mount as a template for
> > > reimplementing shiftfs when I discovered that you can't actually
> > > create a read only bind mount with the new API.  The problem is
> > > that fspick() will only reconfigure the underlying superblock,
> > > which you don't want because you only want the bound subtree to
> > > become read only and open_tree()/move_mount() doesn't give you
> > > any facility to add or change options on the bind.
> > 
> > You'd use open_tree() with OPEN_TREE_CLONE and possibly
> > AT_RECURSIVE rather than fspick().  fspick() is, as you observed,
> > more for reconfiguring the superblock.
> 
> In the abstract, I think the concept of a configuration file
> descriptor with the, open add parameters and execution to fd, and
> optionally convert to representation or reconfigure in place is a
> very generic one.  If we did agree to do that for bind mounts as
> well, I wouldn't overload the existing logic, I'd lift it up to the
> generic level, probably by hooking the execution parts, and make
> superblock and bind two implementations of it.  It would basically be
> 3 system calls: configopen, configparam and configconvert although
> obviously with more appealing names.
> 
> The reason for thinking like this is I can see it having utility in
> some of the more complex SCSI configuration operations we do today
> via a bunch of mechanisms including configfs that could more
> compactly be done by this file descriptor mechanism.
> 
> I'd also note that this plethora of system calls you have could then
> go away: fspick itself would just become an open type to which the
> path file descriptor would then be a required parameter, as would
> open_tree and the missing mount_setattr would then just work.

Well, that suggestion got crickets, so let me show you how it would
look.  I actually pulled the logger out into lib/ because that's not
filesystem dependent and implemented a generic configfd handler for
doing configuration via a file descriptor.  Configfd is completely
separated from the mechanics of filesystem reconfiguration, so it can
be used as a configuration mechanism for anything.

Once configuration file descriptor mechanics are made generic, you can
get away with two operations for everything, thus giving you the
ability to eliminate fsopen, fsmount, fsconfigure, fspick and
open_tree.  Note, I didn't do that: I just reimplemented them via
internal configfd calls instead, but it is a possibility.  Note also
I've now got the ability to do a ro bind mount without any new system
calls and I now have a scaffold on which I could successfully hang
shiftfs as a propertied bind mount.

The final patch introduces a bind configfd type that can be used both
in place of open_tree and to implement the ro bind mount as a bind
mount reconfigure operation.

James

---

James Bottomley (6):
  logger: add a limited buffer logging facility
  configfd: add generic file descriptor based configuration parser
  configfd: syscall: wire up configfd syscalls
  fs: implement fsconfig via configfd
  fs: expose internal interfaces open_detached_copy and
    do_reconfigure_mount
  fs: bind: add configfs type for bind mounts

 arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
 arch/arm/tools/syscall.tbl                  |   2 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   4 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
 arch/s390/kernel/syscalls/syscall.tbl       |   2 +
 arch/sh/kernel/syscalls/syscall.tbl         |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
 fs/Makefile                                 |   3 +-
 fs/bind.c                                   | 193 ++++++++++
 fs/configfd.c                               | 450 +++++++++++++++++++++++
 fs/filesystems.c                            |   8 +-
 fs/fs_context.c                             | 124 +------
 fs/fsopen.c                                 | 535 ++++++++++++++--------------
 fs/internal.h                               |   7 +
 fs/namespace.c                              | 115 +++---
 include/linux/configfd.h                    |  61 ++++
 include/linux/fs.h                          |   2 +
 include/linux/fs_context.h                  |  23 +-
 include/linux/fs_parser.h                   |   2 +
 include/linux/logger.h                      |  34 ++
 include/linux/syscalls.h                    |   5 +
 include/uapi/asm-generic/unistd.h           |   7 +-
 include/uapi/linux/configfd.h               |  20 ++
 lib/Makefile                                |   3 +-
 lib/logger.c                                | 211 +++++++++++
 36 files changed, 1368 insertions(+), 473 deletions(-)
 create mode 100644 fs/bind.c
 create mode 100644 fs/configfd.c
 create mode 100644 include/linux/configfd.h
 create mode 100644 include/linux/logger.h
 create mode 100644 include/uapi/linux/configfd.h
 create mode 100644 lib/logger.c

-- 
2.16.4

