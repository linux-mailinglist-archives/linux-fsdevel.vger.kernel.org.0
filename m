Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D6780C80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 15:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377124AbjHRN1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 09:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377122AbjHRN1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:27:03 -0400
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BAE12B
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 06:26:59 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RS2hx3tK2zMq9P5;
        Fri, 18 Aug 2023 13:26:57 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RS2hw6nSqzMppDK;
        Fri, 18 Aug 2023 15:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692365217;
        bh=WcsmgrJK2gM6tzUctn3fx5jwZTxSee3ewBV0B2CUGJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=koHxOVF13JHmBUEI2EtIA5Wx/WZLL0H3JuWWuzQgQr1ZG7rLlawcu20guDgw42PCi
         PkkcNSEgF1kqBsJ04w9avBdMYxKgduhBr9l2QAn7Vh37pAXCx+KbozJph+8RWRW+bA
         jBaU7N5qfOd/XRZDyjTKVaO7z5wItP5XqXcKVJ1A=
Date:   Fri, 18 Aug 2023 15:26:52 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Landlock: IOCTL support
Message-ID: <20230818.ha8zoocahZah@digikod.net>
References: <20230814172816.3907299-1-gnoack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814172816.3907299-1-gnoack@google.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 07:28:11PM +0200, Günther Noack wrote:
> Hello!
> 
> These patches add simple ioctl(2) support to Landlock.
> 
> Objective
> ~~~~~~~~~
> 
> Make ioctl(2) requests restrictable with Landlock,
> in a way that is useful for real-world applications.
> 
> Proposed approach
> ~~~~~~~~~~~~~~~~~
> 
> Introduce the LANDLOCK_ACCESS_FS_IOCTL right, which restricts the use
> of ioctl(2) on file descriptors.
> 
> We attach the LANDLOCK_ACCESS_FS_IOCTL right to opened file
> descriptors, as we already do for LANDLOCK_ACCESS_FS_TRUNCATE.
> 
> We make an exception for the common and known-harmless IOCTL commands FIOCLEX,
> FIONCLEX, FIONBIO, FIOASYNC and FIONREAD.  These IOCTL commands are always
> permitted.  The functionality of the first four is already available through
> fcntl(2), and FIONREAD only returns the number of ready-to-read bytes.
> 
> I believe that this approach works for the majority of use cases, and
> offers a good trade-off between Landlock API and implementation
> complexity and flexibility when the feature is used.
> 
> Current limitations
> ~~~~~~~~~~~~~~~~~~~
> 
> With this patch set, ioctl(2) requests can *not* be filtered based on
> file type, device number (dev_t) or on the ioctl(2) request number.
> 
> On the initial RFC patch set [1], we have reached consensus to start
> with this simpler coarse-grained approach, and build additional IOCTL
> restriction capabilities on top in subsequent steps.
> 
> [1] https://lore.kernel.org/linux-security-module/d4f1395c-d2d4-1860-3a02-2a0c023dd761@digikod.net/
> 
> Notable implications of this approach
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> * Existing inherited file descriptors stay unaffected
>   when a program enables Landlock.
> 
>   This means in particular that in common scenarios,
>   the terminal's IOCTLs (ioctl_tty(2)) continue to work.
> 
> * ioctl(2) continues to be available for file descriptors acquired
>   through means other than open(2).  Example: Network sockets,
>   memfd_create(2), file descriptors that are already open before the
>   Landlock ruleset is enabled.
> 
> Examples
> ~~~~~~~~
> 
> Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:
> 
>   LL_FS_RO=/ LL_FS_RW=. ./sandboxer /bin/bash
> 
> The LANDLOCK_ACCESS_FS_IOCTL right is part of the "read-write" rights
> here, so we expect that newly opened files outside of $HOME don't work
> with ioctl(2).
> 
>   * "stty" works: It probes terminal properties
> 
>   * "stty </dev/tty" fails: /dev/tty can be reopened, but the IOCTL is
>     denied.
> 
>   * "eject" fails: ioctls to use CD-ROM drive are denied.
> 
>   * "ls /dev" works: It uses ioctl to get the terminal size for
>     columnar layout
> 
>   * The text editors "vim" and "mg" work.  (GNU Emacs fails because it
>     attempts to reopen /dev/tty.)
> 
> How we arrived at the list of always-permitted IOCTL commands
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> To decide which IOCTL commands should be blanket-permitted I went through the
> list of IOCTL commands mentioned in fs/ioctl.c and looked at them individually
> to understand what they are about.  The following list is my conclusion from
> that.
> 
> We should always allow the following IOCTL commands:
> 
>  * FIOCLEX, FIONCLEX - these work on the file descriptor and manipulate the
>    close-on-exec flag

I agree that FIOCLEX and FIONCLEX should always be allowed.

>  * FIONBIO, FIOASYNC - these work on the struct file and enable nonblocking-IO
>    and async flags

About FIONBIO and FIOASYNC, I think it's OK because it is already
allowed thanks to fcntl. We could combine these commands with
LANDLOCK_ACCESS_FS_{READ,WRITE}_FILE but it may not be related to only
regular files.

I found that there is an inconsistency between the fcntl's SETFL and the
FIONBIO/FIOASYNC IOCTLs. The first one call filp->f_op->check_flags()
while the second one doesn't. This should enable to bypass such
check_flags() checks. This is unrelated to Landlock or this patch series
though, and it should be OK because only NFS seems to implement
check_flags() and only O_DIRECT|O_APPEND are checked.

Cc Christian

>  * FIONREAD - get the number of bytes available for reading (the implementation
>    is defined per file type)

About FIONREAD, I'm convinced we should only allow this command
according to LANDLOCK_ACCESS_FS_READ. As for the VFS implementation,
it should also depend on the file being a regular file (otherwise any
driver could implement another semantic).

To make it forward compatible (with the same semantic), I think we
should handle specific IOCTLs this way: if the complementary access
right (e.g. LANDLOCK_ACCESS_FS_READ_FILE) is not handled by the ruleset
(which is not the same as allowed by a rule), then the related IOCTLs
(e.g. FIONREAD) are denied, otherwise the related IOCTLs are only
allowed if the complementary access is explicitly allowed for this FD.
This way of delegating enables to extend the access control to IOCTL
commands while preserving the access (rights) semantic.

This will enable for instance to restrict FS_IOC_GETFLAGS according to a
potential future LANDLOCK_ACCESS_FS_READ_METADATA, while keeping the
same IOCTL restriction semantic.

We could also follow this same semantic for synthetic access rights
grouping IOCTLs commands.


> 
> The first four are also available through fcntl with the F_SETFD and F_SETFL
> commands.
> 
> The following commands mentioned in fs/ioctl.c should be guarded by the
> LANDLOCK_ACCESS_FS_IOCTL access right, the same as the other ioctl commands,
> because they are nontrivial:
> 
>  * FIFREEZE, FITHAW - work on superblock(!) to freeze/thaw the file
>    system. Requires CAP_SYS_ADMIN.
>  * FICLONE, FICLONERANGE, FIDEDUPRANGE - making files share physical storage
>    between multiple files.  These only work on some file systems, by design.
>  * Commands that read file system internals:
>    * FS_IOC_FIEMAP - get information about file extent mapping
>      (c.f. https://www.kernel.org/doc/Documentation/filesystems/fiemap.txt)
>    * FIBMAP - get a file's file system block number
>    * FIGETBSZ - get file system blocksize
>  * Accessing file attributes:
>    * FS_IOC_GETFLAGS, FS_IOC_SETFLAGS - manipulate inode flags (ioctl_iflags(2))
>    * FS_IOC_FSGETXATTR, FS_IOC_FSSETXATTR - more attributes
>  * FS_IOC_RESVSP, FS_IOC_RESVSP64, FS_IOC_UNRESVSP, FS_IOC_UNRESVSP64,
>    FS_IOC_ZERO_RANGE: Backwards compatibility with legacy XFS preallocation
>    syscalls which predate fallocate(2).
> 
> Related Work
> ~~~~~~~~~~~~
> 
> OpenBSD's pledge(2) [2] restricts ioctl(2) independent of the file
> descriptor which is used.  The implementers maintain multiple
> allow-lists of predefined ioctl(2) operations required for different
> application domains such as "audio", "bpf", "tty" and "inet".
> 
> OpenBSD does not guarantee ABI backwards compatibility to the same
> extent as Linux does, so it's easier for them to update these lists in
> later versions.  It might not be a feasible approach for Linux though.
> 
> [2] https://man.openbsd.org/OpenBSD-7.3/pledge.2
> 
> Changes
> ~~~~~~~
> 
> V3:
>  * always permit the IOCTL commands FIOCLEX, FIONCLEX, FIONBIO, FIOASYNC and
>    FIONREAD, independent of LANDLOCK_ACCESS_FS_IOCTL
>  * increment ABI version in the same commit where the feature is introduced
>  * testing changes
>    * use FIOQSIZE instead of TTY IOCTL commands
>      (FIOQSIZE works with regular files, directories and memfds)
>    * run the memfd test with both Landlock enabled and disabled
>    * add a test for the always-permitted IOCTL commands
> 
> V2:
>  * rebased on mic-next
>  * added documentation
>  * exercise ioctl(2) in the memfd test
>  * test: Use layout0 for the test
> 
> ---
> 
> V1: https://lore.kernel.org/linux-security-module/20230502171755.9788-1-gnoack3000@gmail.com/
> V2: https://lore.kernel.org/linux-security-module/20230623144329.136541-1-gnoack@google.com/
> 
> Günther Noack (5):
>   landlock: Add ioctl access right
>   selftests/landlock: Test ioctl support
>   selftests/landlock: Test ioctl with memfds
>   samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
>   landlock: Document ioctl support
> 
>  Documentation/userspace-api/landlock.rst     |  74 ++++++++---
>  include/uapi/linux/landlock.h                |  31 +++--
>  samples/landlock/sandboxer.c                 |  12 +-
>  security/landlock/fs.c                       |  38 +++++-
>  security/landlock/limits.h                   |   2 +-
>  security/landlock/syscalls.c                 |   2 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   | 133 +++++++++++++++++--
>  8 files changed, 249 insertions(+), 45 deletions(-)
> 
> 
> base-commit: 35ca4239929737bdc021ee923f97ebe7aff8fcc4
> -- 
> 2.41.0.694.ge786442a9b-goog
> 
