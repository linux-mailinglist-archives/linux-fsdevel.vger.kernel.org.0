Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262B375FA4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 17:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGXPBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 11:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGXPBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:01:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFF110C0;
        Mon, 24 Jul 2023 08:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1727611DF;
        Mon, 24 Jul 2023 15:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D2EC433C7;
        Mon, 24 Jul 2023 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690210859;
        bh=Mfr8vuIOX4qKuQEGlNurc0jSe2SNs7HwJSKOmiWIS6c=;
        h=From:Date:Subject:To:Cc:From;
        b=AXDfeDBOYFM/r9o5f4Hvi0OD966mzalQRKNHuU+RRoTXbDUvFRnlp6z7aDGuXuoyr
         jMskzUoscPcTOI6kwhjtmcidDAS9Iw3BzlkL1VDQrWgN2Lizlqd8J1qC6BQUUZvHCj
         ezLIH+nU/Hp0nADrI+PptG2LIndz2s6RAANQ8MMbM3pnVC2ak87LnaJytCa54RL6lX
         LQNdnKtvA3PpNRYbyQenAMA9udJ+eGjMefLtpQoef6t8BbymMACal3+u6ELN7e7os2
         +RYGJdOwYTrK/UDADnDXYFxoIKSpc+HhJ1InX/X20RsZstHjBpm2GCgEZughU4NZQs
         jROC4Qd90TSLg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 24 Jul 2023 17:00:49 +0200
Subject: [PATCH] file: always lock position
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
X-B4-Tracking: v=1; b=H4sIACCSvmQC/x3MTQrCMBBA4auUWTslJv1BryIiaTJpZ2FaZkoQS
 u9udPkt3jtASZgU7s0BQoWV11xxvTQQFp9nQo7VYI11ZrQdlqSY4kz7a1sVw9B3hhzFMd6gNpt
 Q4s//93hWT14JJ/E5LL/L2+tO0pah7VGCg/P8AvyruteBAAAA
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=9453; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Mfr8vuIOX4qKuQEGlNurc0jSe2SNs7HwJSKOmiWIS6c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTsm6TRkSL+3thx+efNzK0xXx+yBvos2xR0fdHb93KzNP4L
 /THZ1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARmziG/1UP2mYKh0W/4F+Sv/niae
 crO05bZRevEtLJXHPsmdgsnR8M/8M13e95mb5Z9/zDUtvEbz1Fe7evOFfowZbmHHHio+R5B24A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By abusing new methods of file descriptor transferal it is possible to
break the assumption that f_pos_lock doesn't need to be acquired when
the caller is single threaded and the file_count(file) is one aka when
the caller holds the only reference to the file.

The explanation has two parts. The first part is about a new io_uring
interface that isn't merged yet where I realized that only acquiring the
lock when multiple references to a file are held would be broken in some
circumstances. The second part illustrates that this assumption is
already broken by abusing another interface.

During review of the io_uring patchset for adding getdents support I
pointed out various problems in the locking assumptions that were made.
Effectively, the guts of __fdget_pos() were copied out and a trylock
scheme for f_pos_lock was introduced.

The approach overall is workable but the locking was wrong because it
copied the file_count(file) greater than one optimization that
__fdget_pos() had into io_uring. But this assumption is broken when
fixed file descriptors are used.

Short reminder of fixed files here via some C pseudo code:

T1 (still single threaded)

        fd_register = open("/some/file") -----------------> f_count == 1

        fd_fixed = io_uring_register_file(fd_register)
        -> io_sqe_files_register(fd_register)
           -> fget(fd_register) --------------------------> f_count == 2
           -> io_fixed_file_set(fd_register)

        close(fd_register);
        -> close_fd(fd_register)
           -> file = pick_file()
           -> filp_close(file)
              -> fput(file) ------------------------------> f_count == 1

The caller has now traded a regular file descriptor reference for a
fixed file reference. Such fixed files never use fget() again and thus
fully eliminate any fget()/fput() overhead.

However, for getdents f_pos_lock needs to be acquired as state may often
be kept that requires synchronization with seek and other concurrent
getdent requests.

Since io_uring is an asynchronous interface it is of course possible to
register multiple concurrent getdent calls that aren't synchronized by
io_uring as that's never done unless the user requests specific
chaining. And since the reference count for fixed files is always one
it's possible to create multiple racing getdent requests if locking is
conditional on file_count(file) being greater than one.

That wouldn't be a problem since io_uring can just unconditionally take
f_pos_lock and eliminate this problem for fixed files since they aren't
usable with the regular system call api.

However, while thinking about this I realized that a while ago the
file_count(file) greater than one optimization was already broken and
that concurrent read/write/getdents/seek calls are possible in the
regular system call api.

The pidfd_getfd() system call allows a caller with ptrace_may_access()
abilities on another process to steal a file descriptor from this
process. This system call is used by debuggers, container runtimes,
system call supervisors, networking proxies etc (cf. [1]-[3]). So while
it is a special interest system call it is used in common tools.

Via pidfd_getfd() it's possible to intercept syscalls such as
connect(2). For example, a container manager might want to rewrite the
connect(2) request to something other than the task intended for
security reasons or because the task lacks the necessary information
about the networking layout to connect to the right endpoint. In these
cases pidfd_getfd(2) can be used to retrieve a copy of the file
descriptor of the task and perform the connect(2) for it.

When used in combination with the seccomp notifier things are pretty
simple. The intercepted task itself is blocked in the seccomp code. That
code runs before the actual requested system call is performed. So the
task is blocked before any system call is performed. The seccomp
notifier will then notify the supervising process which holds the
seccomp notifier fd.

The supervisor can now call pidfd_getfd() while the target process is
blocked and steal the file descriptor. It can then perform whatever
operation it wants on that file descriptor and then tell seccomp to
either return a specific return value to the task once it is unblocked
or even continue the task using the SECCOMP_USER_NOTIF_FLAG_CONTINUE
flag.

One of the most useful things for pidfd_getfd() is that the target task
from which the caller is about to steal a file descriptor doesn't need
to be blocked or stopped. But that makes it possible for the target
process to be in the middle of a read/write/getdents/seek system call
while the caller is stealing the file on which that
read/write/getdents/seek was issued and issuing a concurrent
read/write/getdents/seek system call:

P1                                              P2
getdents(fd)
-> fdget_pos()
   {
           * @file->f_count == 1
           * @current->files->count == 1
           => not taking @file->f_pos_lock
   }
                                                fd = pidfd_getfd(fd)
                                                -> __pidfd_fget()
                                                   -> fget_task() ----> f_count = 2
                                                   -> receive_fd()
                                                      -> get_file() --> f_count = 3
                                                      -> fd_install()
                                                   -> fput() ---------> f_count = 2

                                                getdents(fd)
                                                -> fdget_pos()
                                                   {
                                                           * @file->f_count == 1
                                                           * @file->f_count == 2
                                                           => taking @file->f_pos_lock and bumping @file->f_count = 3
                                                   }
-> vfs_readdir()                                   -> vfs_readdir()
-> fdput()                                         -> fdput()---------> f_count = 2

Although I'm not happy about it, I'm somewhat confident that this
analysis is correct but that the race is hard to hit in real life but
with some ingenuity it might be possible to make it more reliable.
However, I was lazy and introduced a luscious 10 second delay after
fdget_pos() succeeded into vfs_read() that was triggerable by passing -1
as the buffer size to the read() system call. I then used the very very
ugly program in [4] to enforce the order illustrated above. Lastly, I
wrote a bpftrace program which attached a kretfunc to __fdget_pos() and
a kfunc and a kretfunc to vfs_read(). The bpftrace program would only
trigger if the target file with a specific inode number was read:

Attaching 3 probes...
fdget_pos() on file pointer 0xffff8b3500d6a300: name(stealme) | i_ino(1591) | pid(9690) FDPUT_POS_UNLOCK(0), count(1) => mutex not acquired
 vfs_read() on file pointer 0xffff8b3500d6a300: pid 9690 started reading from name(stealme) | i_ino(1591)
fdget_pos() on file pointer 0xffff8b3500d6a300: name(stealme) | i_ino(1591) | pid(9691) FDPUT_POS_UNLOCK(2), count(2) => mutex acquired
 vfs_read() on file pointer 0xffff8b3500d6a300: pid 9691 started reading from name(stealme) | i_ino(1591)
 vfs_read() on file pointer 0xffff8b3500d6a300: pid 9690 finished reading from name(stealme) | i_ino(1591)
 vfs_read() on file pointer 0xffff8b3500d6a300: pid 9691 finished reading from name(stealme) | i_ino(1591)

I thought about various ways to fix this such as introducing some
mechanism to refuse pidfd_getfd() if the target process is in the middle
of an fdget_pos() protected system call with file count being one up to
just not caring about it at all. But it is pretty nasty to leave this
race open and it feels like something that'll bite us later anyway.

Plus, with io_uring having to acquire f_pos_lock unconditionally anyway
for getdents support I'm not sure that deviation in locking semantics
here is worth keeping. So remove the locking optimization for file count
being one. We'll see if this has a significant performance impact.

This survives xfstests and LTP.

Link: https://github.com/rr-debugger/rr [1]
Link: https://github.com/opencontainers/runc [2]
Link: https://brauner.io/2020/07/23/seccomp-notify.html [3]
Link: https://gist.github.com/brauner/599d31048c8adcb3aa0c537b76c89e12 [4]
Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---

---
 fs/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 7893ea161d77..35c62b54c9d6 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1042,10 +1042,8 @@ unsigned long __fdget_pos(unsigned int fd)
 	struct file *file = (struct file *)(v & ~3);
 
 	if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
-		if (file_count(file) > 1) {
-			v |= FDPUT_POS_UNLOCK;
-			mutex_lock(&file->f_pos_lock);
-		}
+		v |= FDPUT_POS_UNLOCK;
+		mutex_lock(&file->f_pos_lock);
 	}
 	return v;
 }

---
base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
change-id: 20230724-vfs-fdget_pos-c6540e3ed7d9

