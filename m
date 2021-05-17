Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22BD382C8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 14:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhEQMvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 08:51:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:34644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233280AbhEQMvn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 08:51:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A882DAF4E;
        Mon, 17 May 2021 12:50:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3E57A1F2CA4; Mon, 17 May 2021 14:50:25 +0200 (CEST)
Date:   Mon, 17 May 2021 14:50:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 0/2] quota: Add mountpath based quota support
Message-ID: <20210517125025.GE31755@quack2.suse.cz>
References: <20210304123541.30749-1-s.hauer@pengutronix.de>
 <20210316112916.GA23532@quack2.suse.cz>
 <20210512110149.GA31495@quack2.suse.cz>
 <20210512125310.m3b4ralhwsdocpyb@wittgenstein>
 <20210512131429.GA2734@quack2.suse.cz>
 <20210512153621.n5u43jsytbik4yze@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20210512153621.n5u43jsytbik4yze@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 12-05-21 17:36:21, Christian Brauner wrote:
> On Wed, May 12, 2021 at 03:14:29PM +0200, Jan Kara wrote:
> > On Wed 12-05-21 14:53:10, Christian Brauner wrote:
> > > On Wed, May 12, 2021 at 01:01:49PM +0200, Jan Kara wrote:
> > > > Added a few more CCs.
> > > > 
> > > > On Tue 16-03-21 12:29:16, Jan Kara wrote:
> > > > > On Thu 04-03-21 13:35:38, Sascha Hauer wrote:
> > > > > > Current quotactl syscall uses a path to a block device to specify the
> > > > > > filesystem to work on which makes it unsuitable for filesystems that
> > > > > > do not have a block device. This series adds a new syscall quotactl_path()
> > > > > > which replaces the path to the block device with a mountpath, but otherwise
> > > > > > behaves like original quotactl.
> > > > > > 
> > > > > > This is done to add quota support to UBIFS. UBIFS quota support has been
> > > > > > posted several times with different approaches to put the mountpath into
> > > > > > the existing quotactl() syscall until it has been suggested to make it a
> > > > > > new syscall instead, so here it is.
> > > > > > 
> > > > > > I'm not posting the full UBIFS quota series here as it remains unchanged
> > > > > > and I'd like to get feedback to the new syscall first. For those interested
> > > > > > the most recent series can be found here: https://lwn.net/Articles/810463/
> > > > > 
> > > > > Thanks. I've merged the two patches into my tree and will push them to
> > > > > Linus for the next merge window.
> > > > 
> > > > So there are some people at LWN whining that quotactl_path() has no dirfd
> > > > and flags arguments for specifying the target. Somewhat late in the game
> > > > but since there's no major release with the syscall and no userspace using
> > > > it, I think we could still change that. What do you think? What they
> > > > suggest does make some sense. But then, rather then supporting API for
> > > > million-and-one ways in which I may wish to lookup a fs object, won't it be
> > > > better to just pass 'fd' in the new syscall (it may well be just O_PATH fd
> > > > AFAICT) and be done with that?
> > > 
> > > I think adding a dirfd argument makes a lot of sense (Unless there are
> > > some restrictions around quotas I'm misunderstanding.).
> > > 
> > > If I may: in general, I think we should aim to not add additional system
> > > calls that operate on paths only. Purely path-based apis tend to be the
> > > source of security issues especially when scoped lookups are really
> > > important which given the ubiquity of sandboxing solutions nowadays is
> > > quite often actually.
> > > For example, when openat2() landed it gave such a boost in lookup
> > > capabilities that I switched some libraries over to only ever do scoped
> > > lookups, i.e. I decide on a starting point that gets opened path-based
> > > and then explicitly express how I want that lookup to proceed ultimately
> > > opening the final path component on which I want to perform operations.
> > > Combined with the mount API almost everything can be done purely fd
> > > based.
> > > 
> > > In addition to that dirfd-scopable system calls allow for a much nicer
> > > api experience when programming in userspace.
> > 
> > OK, thanks for your insights. But when we add 'dirfd' I wonder whether we
> > still need the 'path' component then. I mean you can always do fd =
> > openat2(), quotactl_fd(fd, ...). After all ioctl() works exactly that way
> > since the beginning. The only advantage of quotactl_xxx() taking path would
> > be saving the open(2) call. That is somewhat convenient for simple cases
> > (but also error prone in complex setups as you point out) and can be also
> > sligthly faster (but quotactl is hardly a performance sensitive thing)...
> 
> That's a bit tricky indeed. It would feel consistent to add a path
> argument as most of our fs apis seems to work that way even stuff like
> fanotify_mark() but indeed a fd-only based api would be fine too. I
> would try to follow recent additions/prior art here, I think.

Thanks for opinion Christian. Sasha, I've decided to disable the syscall
for now (I plan to push attached patch to Linus later this week). Will you
please update the syscall to just take 'fd' argument instead of the path to
leave dealing with path pitfalls to syscalls such as openat2()? Probably
renaming to quotactl_fd() would be also good. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--sdtB3X0nJg68CQEu
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-quota-Disable-quotactl_path-syscall.patch"

From 5b9fedb31e476693c90d8ee040e7d4c51b3e7cc4 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 17 May 2021 14:39:56 +0200
Subject: [PATCH] quota: Disable quotactl_path syscall

In commit fa8b90070a80 ("quota: wire up quotactl_path") we have wired up
new quotactl_path syscall. However some people in LWN discussion have
objected that the path based syscall is missing dirfd and flags argument
which is mostly standard for contemporary path based syscalls. Indeed
they have a point and after a discussion with Christian Brauner and
Sascha Hauer I've decided to disable the syscall for now and update its
API. Since there is no userspace currently using that syscall and it
hasn't been released in any major release, we should be fine.

CC: Christian Brauner <christian.brauner@ubuntu.com>
CC: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://lore.kernel.org/lkml/20210512153621.n5u43jsytbik4yze@wittgenstein
Signed-off-by: Jan Kara <jack@suse.cz>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 2 +-
 arch/arm/tools/syscall.tbl                  | 2 +-
 arch/arm64/include/asm/unistd32.h           | 3 +--
 arch/ia64/kernel/syscalls/syscall.tbl       | 2 +-
 arch/m68k/kernel/syscalls/syscall.tbl       | 2 +-
 arch/microblaze/kernel/syscalls/syscall.tbl | 2 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 2 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 2 +-
 arch/parisc/kernel/syscalls/syscall.tbl     | 2 +-
 arch/powerpc/kernel/syscalls/syscall.tbl    | 2 +-
 arch/s390/kernel/syscalls/syscall.tbl       | 2 +-
 arch/sh/kernel/syscalls/syscall.tbl         | 2 +-
 arch/sparc/kernel/syscalls/syscall.tbl      | 2 +-
 arch/x86/entry/syscalls/syscall_32.tbl      | 2 +-
 arch/x86/entry/syscalls/syscall_64.tbl      | 2 +-
 arch/xtensa/kernel/syscalls/syscall.tbl     | 2 +-
 17 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 5622578742fd..3000a2e8ee21 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -482,7 +482,7 @@
 550	common	process_madvise			sys_process_madvise
 551	common	epoll_pwait2			sys_epoll_pwait2
 552	common	mount_setattr			sys_mount_setattr
-553	common	quotactl_path			sys_quotactl_path
+# 553 reserved for quotactl_path
 554	common	landlock_create_ruleset		sys_landlock_create_ruleset
 555	common	landlock_add_rule		sys_landlock_add_rule
 556	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index c7679d7db98b..28e03b5fec00 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -456,7 +456,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_path			sys_quotactl_path
+# 443 reserved for quotactl_path
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 7859749d6628..5dab69d2c22b 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -893,8 +893,7 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
 __SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
 #define __NR_mount_setattr 442
 __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
-#define __NR_quotactl_path 443
-__SYSCALL(__NR_quotactl_path, sys_quotactl_path)
+/* 443 is reserved for quotactl_path */
 #define __NR_landlock_create_ruleset 444
 __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
 #define __NR_landlock_add_rule 445
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 1ee8e736a48e..bb11fe4c875a 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -363,7 +363,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_path			sys_quotactl_path
+# 443 reserved for quotactl_path
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 0dd019dc2136..79c2d24c89dd 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -442,7 +442,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_path			sys_quotactl_path
+# 443 reserved for quotactl_path
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 2ac716984ca2..b11395a20c20 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -448,7 +448,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_path			sys_quotactl_path
+# 443 reserved for quotactl_path
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 5e0096657251..9220909526f9 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -381,7 +381,7 @@
 440	n32	process_madvise			sys_process_madvise
 441	n32	epoll_pwait2			compat_sys_epoll_pwait2
 442	n32	mount_setattr			sys_mount_setattr
-443	n32	quotactl_path			sys_quotactl_path
+# 443 reserved for quotactl_path
 444	n32	landlock_create_ruleset		sys_landlock_create_ruleset
 445	n32	landlock_add_rule		sys_landlock_add_rule
 446	n32	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 9974f5f8e49b..9cd1c34f31b5 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -357,7 +357,7 @@
 440	n64	process_madvise			sys_process_madvise
 441	n64	epoll_pwait2			sys_epoll_pwait2
 442	n64	mount_setattr			sys_mount_setattr
-443	n64	quotactl_path			sys_quotactl_path
+# 443 reserved for quotactl_path
 444	n64	landlock_create_ruleset		sys_landlock_create_ruleset
 445	n64	landlock_add_rule		sys_landlock_add_rule
 446	n64	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 39d6e71e57b6..d560c467a8c6 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -430,7 +430,7 @@
 440	o32	process_madvise			sys_process_madvise
 441	o32	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	o32	mount_setattr			sys_mount_setattr
-443	o32	quotactl_path			sys_quotactl_path
+# 443 reserved for quotactl_path
 444	o32	landlock_create_ruleset		sys_landlock_create_ruleset
 445	o32	landlock_add_rule		sys_landlock_add_rule
 446	o32	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 5ac80b83d745..aabc37f8cae3 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -440,7 +440,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_path			sys_quotactl_path
+# 443 reserved for quotactl_path
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 2e68fbb57cc6..8f052ff4058c 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -522,7 +522,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_path			sys_quotactl_path
+# 443 reserved for quotactl_path
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 7e4a2aba366d..0690263df1dd 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -445,7 +445,7 @@
 440  common	process_madvise		sys_process_madvise		sys_process_madvise
 441  common	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
 442  common	mount_setattr		sys_mount_setattr		sys_mount_setattr
-443  common	quotactl_path		sys_quotactl_path		sys_quotactl_path
+# 443 reserved for quotactl_path
 444  common	landlock_create_ruleset	sys_landlock_create_ruleset	sys_landlock_create_ruleset
 445  common	landlock_add_rule	sys_landlock_add_rule		sys_landlock_add_rule
 446  common	landlock_restrict_self	sys_landlock_restrict_self	sys_landlock_restrict_self
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index f47a0dc55445..0b91499ebdcf 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -445,7 +445,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_path			sys_quotactl_path
+# 443 reserved for quotactl_path
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index b9e1c0e735b7..e34cc30ef22c 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -488,7 +488,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_path			sys_quotactl_path
+# 443 reserved for quotactl_path
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 28a1423ce32e..4bbc267fb36b 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -447,7 +447,7 @@
 440	i386	process_madvise		sys_process_madvise
 441	i386	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	i386	mount_setattr		sys_mount_setattr
-443	i386	quotactl_path		sys_quotactl_path
+# 443 reserved for quotactl_path
 444	i386	landlock_create_ruleset	sys_landlock_create_ruleset
 445	i386	landlock_add_rule	sys_landlock_add_rule
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ecd551b08d05..ce18119ea0d0 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -364,7 +364,7 @@
 440	common	process_madvise		sys_process_madvise
 441	common	epoll_pwait2		sys_epoll_pwait2
 442	common	mount_setattr		sys_mount_setattr
-443	common	quotactl_path		sys_quotactl_path
+# 443 reserved for quotactl_path
 444	common	landlock_create_ruleset	sys_landlock_create_ruleset
 445	common	landlock_add_rule	sys_landlock_add_rule
 446	common	landlock_restrict_self	sys_landlock_restrict_self
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 9d76d433d3d6..fd2f30227d96 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -413,7 +413,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_path			sys_quotactl_path
+# 443 reserved for quotactl_path
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
-- 
2.26.2


--sdtB3X0nJg68CQEu--
