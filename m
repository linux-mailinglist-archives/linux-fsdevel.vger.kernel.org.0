Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43859750536
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 12:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjGLKz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 06:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjGLKz0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:55:26 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472A210C7
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 03:55:23 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4R1F555dypzMq4rn;
        Wed, 12 Jul 2023 10:55:21 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4R1F543rTKz7cc;
        Wed, 12 Jul 2023 12:55:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1689159321;
        bh=MXMR0QJpxC+UeXa9j+Xw92U/wAKYxcatbVIZYEVLQjA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h4RUn+LjafPynjaWUEyVdwyTch9Txy0l01cGTZNGfdmvGv2eKVJvJZRnKmMm8t9n1
         XlefRRRzCCKbal1k6Wo0hkCLjt2V4zWEtzfVcrN77JD/eHEUzQtEMRJbxsBmNNuSOk
         FF0cWdf3sz9aAsOTMKoTeVq3uc7kOtkFjaJDI550=
Message-ID: <6dfc0198-9010-7c54-2699-d3b867249850@digikod.net>
Date:   Wed, 12 Jul 2023 12:55:19 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2 0/6] Landlock: ioctl support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>,
        linux-security-module@vger.kernel.org
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
References: <20230623144329.136541-1-gnoack@google.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230623144329.136541-1-gnoack@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi,

Thinking more about this, this first step is too restrictive, which
might lead to dangerous situations.

My main concern is that this approach will deny innocuous or even "good"
IOCTL. For instance, if FIOCLEX is denied, this could leak file
descriptors and then introduce vulnerabilities.

As we discussed before, we cannot categorize all IOCTLs, but I think we
need to add exceptions for a subset of them, and maintain this list.
SELinux has some special handling within selinux_file_ioctl(), and we
should use that as a starting point. The do_vfs_ioctl() function is
another important place to look at. The main thing to keep in mind is
that Landlock's goal is to restrict access to data (e.g. FS, network,
IPC, bypass through other processes), not to restrict innocuous (at
least in theory) kernel features.

I think, at least all IOCTLs targeting file descriptors themselves 
should always be allowed, similar to fcntl(2)'s F_SETFD and F_SETFL 
commands:
- FIOCLEX
- FIONCLEX
- FIONBIO
- FIOASYNC

Some others may not be a good idea:
- FIONREAD should be OK in theory but the VFS part only target regular
files and there is no access check according to the read right, which is
weird.
- FICLONE, FICLONERANGE, FIDEDUPRANGE: read/write actions.

We should add a built-time or run-time safeguard to be sure that future
FD IOCTLs will be added to this list. I'm not sure how to efficiently
implement such protection though.


I'm also wondering if we should not split the IOCTL access right into
three: mostly read, mostly write, and misc. _IOC_READ and _IOC_WRITE are
definitely not perfect, but tied to specific drivers (i.e. not a file
hierarchy but a block or character device) this might help until we get
a more fine-grained IOCTL access control. We should check if it's worth
it according to commonly used drivers. Looking at the TTY driver, most
IOCTLs are without read or write markers. Using this split could induce
a false sense of security, so it should be well motivated.



On 23/06/2023 16:43, Günther Noack wrote:
> Hello!
> 
> These patches add simple ioctl(2) support to Landlock.
> 
> Objective ~~~~~~~~~
> 
> Make ioctl(2) requests restrictable with Landlock, in a way that is 
> useful for real-world applications.
> 
> Proposed approach ~~~~~~~~~~~~~~~~~
> 
> Introduce the LANDLOCK_ACCESS_FS_IOCTL right, which restricts the
> use of ioctl(2) on file descriptors.
> 
> We attach the LANDLOCK_ACCESS_FS_IOCTL right to opened file 
> descriptors, as we already do for LANDLOCK_ACCESS_FS_TRUNCATE.
> 
> I believe that this approach works for the majority of use cases,
> and offers a good trade-off between Landlock API and implementation 
> complexity and flexibility when the feature is used.
> 
> Current limitations ~~~~~~~~~~~~~~~~~~~
> 
> With this patch set, ioctl(2) requests can *not* be filtered based
> on file type, device number (dev_t) or on the ioctl(2) request
> number.
> 
> On the initial RFC patch set [1], we have reached consensus to start 
> with this simpler coarse-grained approach, and build additional ioctl
> restriction capabilities on top in subsequent steps.
> 
> [1] 
> https://lore.kernel.org/linux-security-module/d4f1395c-d2d4-1860-3a02-2a0c023dd761@digikod.net/
>
>
>
>
>
> 
Notable implications of this approach
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> * Existing inherited file descriptors stay unaffected when a program
>  enables Landlock.
> 
> This means in particular that in common scenarios, the terminal's 
> ioctls (ioctl_tty(2)) continue to work.
> 
> * ioctl(2) continues to be available for file descriptors acquired 
> through means other than open(2).  Example: Network sockets, 
> memfd_create(2), file descriptors that are already open before the 
> Landlock ruleset is enabled.
> 
> Examples ~~~~~~~~
> 
> Starting a sandboxed shell from $HOME with 
> samples/landlock/sandboxer:
> 
> LL_FS_RO=/ LL_FS_RW=. ./sandboxer /bin/bash
> 
> The LANDLOCK_ACCESS_FS_IOCTL right is part of the "read-write"
> rights here, so we expect that newly opened files outside of $HOME
> don't work with ioctl(2).
> 
> * "stty" works: It probes terminal properties
> 
> * "stty </dev/tty" fails: /dev/tty can be reopened, but the ioctl is 
> denied.
> 
> * "eject" fails: ioctls to use CD-ROM drive are denied.
> 
> * "ls /dev" works: It uses ioctl to get the terminal size for 
> columnar layout
> 
> * The text editors "vim" and "mg" work.  (GNU Emacs fails because it 
> attempts to reopen /dev/tty.)
> 
> Related Work ~~~~~~~~~~~~
> 
> OpenBSD's pledge(2) [2] restricts ioctl(2) independent of the file 
> descriptor which is used.  The implementers maintain multiple 
> allow-lists of predefined ioctl(2) operations required for different 
> application domains such as "audio", "bpf", "tty" and "inet".
> 
> OpenBSD does not guarantee ABI backwards compatibility to the same 
> extent as Linux does, so it's easier for them to update these lists 
> in later versions.  It might not be a feasible approach for Linux 
> though.
> 
> [2] https://man.openbsd.org/OpenBSD-7.3/pledge.2
> 
> Changes ~~~~~~~
> 
> V2: * rebased on mic-next * added documentation * exercise ioctl in 
> the memfd test * test: Use layout0 for the test
> 
> ---
> 
> V1: 
> https://lore.kernel.org/linux-security-module/20230502171755.9788-1-gnoack3000@gmail.com/
>
>
>
>
>
> 
Günther Noack (6): landlock: Increment Landlock ABI version to 4
> landlock: Add LANDLOCK_ACCESS_FS_IOCTL access right 
> selftests/landlock: Test ioctl support selftests/landlock: Test ioctl
> with memfds samples/landlock: Add support for 
> LANDLOCK_ACCESS_FS_IOCTL landlock: Document ioctl support
> 
> Documentation/userspace-api/landlock.rst     | 52 ++++++++----- 
> include/uapi/linux/landlock.h                | 19 +++-- 
> samples/landlock/sandboxer.c                 | 12 ++- 
> security/landlock/fs.c                       | 21 +++++- 
> security/landlock/limits.h                   |  2 +- 
> security/landlock/syscalls.c                 |  2 +- 
> tools/testing/selftests/landlock/base_test.c |  2 +- 
> tools/testing/selftests/landlock/fs_test.c   | 77 
> ++++++++++++++++++-- 8 files changed, 149 insertions(+), 38 
> deletions(-)
> 
> 
> base-commit: 35ca4239929737bdc021ee923f97ebe7aff8fcc4
