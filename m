Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353C75FDE4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 18:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJMQfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 12:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJMQf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:35:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE9D5A838;
        Thu, 13 Oct 2022 09:35:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19C696188C;
        Thu, 13 Oct 2022 16:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0482DC433C1;
        Thu, 13 Oct 2022 16:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665678926;
        bh=ojv6miQ0A5DdJNSgRzTvWZC/p3gwaVkHl+zPjFW09Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKyN79lf7u7mdgAZob92WqqX+utTUF+j68GCAXz4BbmHj/x4z4DVRh3SRjqZmmFMJ
         /vC9iAnZmga2hv/DE6K2RV2OA5BnD9MaR1XGMEzqdC2QGhLgtmK37+73emcZMttX2n
         s90IJvyycvAuLemKMMmILnvDSsggmTsgnXxrpecHB/iqMn+pkP8Hh9E1xF8KwIDQ9q
         vQjziPDZ0292X2rZAgx5J4r2Ol2IV8KmozrIpXEVda6Pjn+g89n+SsW4wV5Bk//1xI
         keXRDSaSukvcMzm8AGZUiEaL1jmrq9YXXnycXslcoEH5/o8RsQNgoJvtgVIkeNdRdu
         66ZMs/5nIbgeg==
Date:   Thu, 13 Oct 2022 09:35:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v9 00/11] landlock: truncate support
Message-ID: <Y0g+TEgGGhZDm7MX@dev-arch.thelio-3990X>
References: <20221008100935.73706-1-gnoack3000@gmail.com>
 <b8566973-63bc-441f-96b9-f822e9944127@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8566973-63bc-441f-96b9-f822e9944127@digikod.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mickaël and Günther,

On Mon, Oct 10, 2022 at 12:35:31PM +0200, Mickaël Salaün wrote:
> Thanks Günther! This series looks good and is now in -next with some minor
> cosmetic comment changes.
> 
> Nathan, could you please confirm that this series work for you?

First of all, let me apologize for the delay in response. I am just now
getting back online after a week long vacation, which was definitely
poorly timed with the merge window :/

Unfortunately, with this series applied on top of commit e8bc52cb8df8
("Merge tag 'driver-core-6.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core") as
indicated by the base commit information at the bottom of the cover
letter, I can still reproduce the original crash I reported. What is
even more odd is that I should be using the exact same tool versions
that Günther is, as I am also using Arch Linux as my distribution.

I have attached the exact .config that the build system produced after
my build, just in case there is something else in our environment that
could be causing difficulties in reproducing.

For what it is worth, I can reproduce this in a fresh Arch Linux
container, which should hopefully remove most environment concerns.

$ podman run \
    --interactive \
    --tty \
    --rm
    --volume .../linux-next:/linux-next \
    --workdir /linux-next \
    docker.io/archlinux:base-devel
# pacman -Syyu --noconfirm \
    aarch64-linux-gnu-gcc \
    bc \
    git \
    pahole \
    python3 \
    qemu-system-aarch64
...

# aarch64-linux-gnu-gcc --version | head -1
aarch64-linux-gnu-gcc (GCC) 12.2.0

# aarch64-linux-gnu-as --version | head -1
GNU assembler (GNU Binutils) 2.39

# qemu-system-aarch64 --version | head -1
QEMU emulator version 7.1.0

# git log --first-parent --oneline e8bc52cb8df8^..
5622ae16a601 landlock: Document Landlock's file truncation support
6c8a1dadeae1 samples/landlock: Extend sample tool to support LANDLOCK_ACCESS_FS_TRUNCATE
d19c9ba61c75 selftests/landlock: Test ftruncate on FDs created by memfd_create(2)
bf5e5018edb5 selftests/landlock: Test FD passing from restricted to unrestricted processes
4a7f660a22b2 selftests/landlock: Locally define __maybe_unused
1a9015ef7014 selftests/landlock: Test open() and ftruncate() in multiple scenarios
79bb219d0b7c selftests/landlock: Test file truncation support
dd3d0e23543e landlock: Support file truncation
dcade986e070 landlock: Document init_layer_masks() helper
873afb813b11 landlock: Refactor check_access_path_dual() into is_access_to_paths_allowed()
cdda4d440c96 security: Create file_truncate hook from path_truncate hook
e8bc52cb8df8 Merge tag 'driver-core-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core

# mkdir build

# mv .config build

# mv rootfs.cpio build

# make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build Image.gz

# qemu-system-aarch64 \
    -machine virt,gic-version=max,virtualization=true \
    -cpu max,pauth-impdef=true \
    -kernel build/arch/arm64/boot/Image.gz \
    -append "console=ttyAMA0 earlycon" \
    -display none \
    -initrd build/rootfs.cpio \
    -m 512m \
    -nodefaults \
    -no-reboot \
    -serial mon:stdio
...
[    0.000000] Linux version 6.0.0-08005-g5622ae16a601 (root@82bc572c5e5f) (aarch64-linux-gnu-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39) #1 SMP Thu Oct 13 16:30:30 UTC 2022
...
[    0.491767] Trying to unpack rootfs image as initramfs...
[    0.494156] Unable to handle kernel paging request at virtual address ffff00000851036a
[    0.494389] Mem abort info:
[    0.494466]   ESR = 0x0000000097c0c061
[    0.494601]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.494756]   SET = 0, FnV = 0
[    0.494957]   EA = 0, S1PTW = 0
[    0.495070]   FSC = 0x21: alignment fault
[    0.495214] Data abort info:
[    0.495298]   Access size = 8 byte(s)
[    0.495408]   SSE = 0, SRT = 0
[    0.495519]   SF = 1, AR = 1
[    0.495636]   CM = 0, WnR = 1
[    0.495759] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041645000
[    0.495938] [ffff00000851036a] pgd=180000005fff8003, p4d=180000005fff8003, pud=180000005fff7003, pmd=180000005ffbd003, pte=0068000048510f07
[    0.496779] Internal error: Oops: 0000000097c0c061 [#1] SMP
[    0.497081] Modules linked in:
[    0.497341] CPU: 0 PID: 9 Comm: kworker/u2:0 Not tainted 6.0.0-08005-g5622ae16a601 #1
[    0.497643] Hardware name: linux,dummy-virt (DT)
[    0.497987] Workqueue: events_unbound async_run_entry_fn
[    0.498635] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.498882] pc : apparmor_file_alloc_security+0x98/0x210
[    0.499132] lr : apparmor_file_alloc_security+0x48/0x210
[    0.499297] sp : ffff800008093960
[    0.499403] x29: ffff800008093960 x28: ffff800008093b30 x27: ffff000002201500
[    0.499679] x26: ffffa4c2a0e55de0 x25: ffff00000201cd05 x24: ffffa4c2a1cd0068
[    0.499901] x23: ffff000008510362 x22: ffff000008510360 x21: 0000000000000002
[    0.500153] x20: ffffa4c2a0f72000 x19: ffff00000201b2b0 x18: ffffffffffffffff
[    0.500375] x17: 000000000000003f x16: ffffa4c2a15d5008 x15: 0000000000000000
[    0.500606] x14: 0000000000000001 x13: 0000000000002578 x12: ffff00001fef1eb8
[    0.500830] x11: ffffa4c2a15ec860 x10: 0000000000000007 x9 : ffffa4c2a0bce9ec
[    0.501061] x8 : ffff000008510380 x7 : 0000000000000000 x6 : 0000000000001e23
[    0.501284] x5 : ffff000008510360 x4 : ffff800008093990 x3 : ffff000002017d80
[    0.501500] x2 : 0000000000000001 x1 : ffff00000851036a x0 : ffff00000201b2b0
[    0.501800] Call trace:
[    0.501957]  apparmor_file_alloc_security+0x98/0x210
[    0.502241]  security_file_alloc+0x6c/0xf0
[    0.502401]  __alloc_file+0x5c/0x100
[    0.502520]  alloc_empty_file+0x68/0x110
[    0.502630]  path_openat+0x50/0x1090
[    0.502743]  do_filp_open+0x88/0x13c
[    0.502858]  filp_open+0x110/0x1b0
[    0.502961]  do_name+0xbc/0x230
[    0.503105]  write_buffer+0x40/0x60
[    0.503234]  unpack_to_rootfs+0x100/0x2bc
[    0.503375]  do_populate_rootfs+0x70/0x134
[    0.503516]  async_run_entry_fn+0x40/0x1e0
[    0.503653]  process_one_work+0x1f4/0x460
[    0.503783]  worker_thread+0x188/0x4e0
[    0.503902]  kthread+0xe0/0xe4
[    0.503999]  ret_from_fork+0x10/0x20
[    0.504279] Code: 52800002 d2800000 d2800013 910022e1 (c89ffc20)
[    0.504647] ---[ end trace 0000000000000000 ]---
...

I am not sure what else I can provide in order to reproduce this but I
am happy to do whatever is needed to get to the bottom of this.

Cheers,
Nathan

> On 08/10/2022 12:09, Günther Noack wrote:
> > The goal of these patches is to work towards a more complete coverage
> > of file system operations that are restrictable with Landlock.
> > 
> > Motivation
> > ----------
> > 
> > The known set of currently unsupported file system operations in
> > Landlock is described at [1]. Out of the operations listed there,
> > truncate is the only one that modifies file contents, so these patches
> > should make it possible to prevent the direct modification of file
> > contents with Landlock.
> > 
> > Apart from Landlock, file truncation can also be restricted using
> > seccomp-bpf, but it is more difficult to use (requires BPF, requires
> > keeping up-to-date syscall lists) and it is not configurable by file
> > hierarchy, as Landlock is. The simplicity and flexibility of the
> > Landlock approach makes it worthwhile adding.
> > 
> > Implementation overview
> > -----------------------
> > 
> > The patch introduces the truncation restriction feature as an
> > additional bit in the access_mask_t bitmap, in line with the existing
> > supported operations.
> > 
> > The truncation flag covers both the truncate(2) and ftruncate(2)
> > families of syscalls, as well as open(2) with the O_TRUNC flag.
> > This includes usages of creat() in the case where existing regular
> > files are overwritten.
> > 
> > Additionally, this patch set introduces a new Landlock security blob
> > associated with opened files, to track the available Landlock access
> > rights at the time of opening the file. This is in line with Unix's
> > general approach of checking the read and write permissions during
> > open(), and associating this previously checked authorization with the
> > opened file.
> > 
> > In order to treat truncate(2) and ftruncate(2) calls differently in an
> > LSM hook, we split apart the existing security_path_truncate hook into
> > security_path_truncate (for truncation by path) and
> > security_file_truncate (for truncation of previously opened files).
> > 
> > We also implement the file_alloc_security hook, in order to override
> > the access rights in the file security blob, in cases where the file
> > is opened by other means than open(2), but where the opened file still
> > supports ftruncate(2). This is also demonstrated in a selftest, using
> > memfd_create(2).
> > 
> > Relationship between "truncate" and "write" rights
> > --------------------------------------------------
> > 
> > While it's possible to use the "write file" and "truncate" rights
> > independent of each other, it simplifies the mental model for
> > userspace callers to always use them together.
> > 
> > Specifically, the following behaviours might be surprising for users
> > when using these independently:
> > 
> >   * The commonly creat() syscall requires the truncate right when
> >     overwriting existing files, as it is equivalent to open(2) with
> >     O_TRUNC|O_CREAT|O_WRONLY.
> >   * The "write file" right is not always required to truncate a file,
> >     even through the open(2) syscall (when using O_RDONLY|O_TRUNC).
> > 
> > Nevertheless, keeping the two flags separate is the correct approach
> > to guarantee backwards compatibility for existing Landlock users.
> > 
> > When the "truncate" right is checked for ftruncate(2)
> > -----------------------------------------------------
> > 
> > Notably, for the purpose of ftruncate(2), the Landlock truncation
> > access right is looked up when *opening* the file, not when calling
> > ftruncate(). The availability of the truncate right is associated with
> > the opened file and is later checked to authorize ftruncate(2)
> > operations.
> > 
> > This is similar to how the write mode gets remembered after a
> > open(..., O_WRONLY) to authorize later write() operations.
> > 
> > These opened file descriptors can also be passed between processes and
> > will continue to enforce their truncation properties when these
> > processes attempt an ftruncate().
> > 
> > These patches are based on master, commit e8bc52cb8df8 ("Merge tag
> > 'driver-core-6.1-rc1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core").
> > 
> > Best regards,
> > Günther
> > 
> > [1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags
> > 
> > Past discussions:
> > V1: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
> > V2: https://lore.kernel.org/all/20220712211405.14705-1-gnoack3000@gmail.com/
> > V3: https://lore.kernel.org/all/20220804193746.9161-1-gnoack3000@gmail.com/
> > V4: https://lore.kernel.org/all/20220814192603.7387-1-gnoack3000@gmail.com/
> > V5: https://lore.kernel.org/all/20220817203006.21769-1-gnoack3000@gmail.com/
> > V6: https://lore.kernel.org/all/20220908195805.128252-1-gnoack3000@gmail.com/
> > V7: https://lore.kernel.org/all/20220930160144.141504-1-gnoack3000@gmail.com/
> > V8: https://lore.kernel.org/all/20221001154908.49665-1-gnoack3000@gmail.com/
> > 
> > Changelog:
> > 
> > V9:
> > * Implement file_alloc_security hook
> >    * Needs to grant all Landlock rights by default for use cases where
> >      files are opened by other means than open(2), i.e. memfd_create(2)
> >    * Discovered and fixed by Mickaël Salaün on his -next branch
> >    * Add a selftest for the memfd_create(2) example
> > * file_open_hook: Reorder the logic a bit as discussed in review
> > * selftests: Return -errno from recv_fd() and send_fd()
> > * Rebase to master branch
> > * Reorder __maybe_unused patch before its use
> > * Various small formatting and documentation fixes in code,
> >    documentation and commit messages
> > 
> > V8:
> > * landlock: Refactor check_access_path_dual() into
> >    is_access_to_paths_allowed(), as suggested by Mickaël Salaün on the
> >    v7 review. Added this as a separate commit.
> > * landlock truncate feature: inline get_path_access()
> > * Documentation: update documentation date to October 2022
> > * selftests: locally #define __maybe_unused (checkpatch started
> >    complaining about it, but the header where it's defined is not
> >    usable from selftests)
> > 
> > V7:
> > * security: Create file_truncate hook
> >    * Fix the build on kernels without CONFIG_SECURITY_PATH (fixed by
> >      Mickaël Salaün)
> >    * lsm_hooks.h: Document file_truncate hook
> >    * fs/open.c: undo accidental indentation changes
> > * landlock: Support file truncation
> >    * Use the init_layer_masks() result as input for
> >      check_access_path_dual()
> >    * Naming
> >      * Rename the landlock_file_security.allowed_access field
> >        (previously called "rights")
> >      * Rename get_path_access_rights() to get_path_access()
> >      * Rename get_file_access() to get_required_file_open_access() to
> >        avoid confusion with get_path_access()
> >      * Use "access_request" for access_mask_t variables, access_req for
> >        unsigned long
> >    * Documentation:
> >      * Fixed some comments according to review
> >      * Added comments to get_required_file_open_access() and
> >        init_layer_masks()
> > * selftests:
> >    * remove unused variables
> >    * rename fd0,...,fd3 to fd_layer0,...,fd_layer3.
> >    * test_ftruncate: define layers on top and inline the helper function
> > * New tests (both added as separate commits)
> >    * More exhaustive ftruncate test: Add open_and_ftruncate test that
> >      exercises ftruncate more thoroughly with fixture variants
> >    * FD-passing test: exercise restricted file descriptors getting
> >      passed between processes, also using the same fixture variants
> > * Documentation: integrate review comments by Mickaël Salaün
> >    * do not use contraptions (don't)
> >    * use double backquotes in all touched lines
> >    * add the read/write open() analogy to the truncation docs
> >    * in code example, check for abi<0 explicitly and fix indentation
> > 
> > V6:
> > * LSM hooks: create file_truncate hook in addition to path_truncate.
> >    Use it in the existing path_truncate call sites where appropriate.
> > * landlock: check LANDLOCK_ACCESS_FS_TRUNCATE right during open(), and
> >    associate that right with the opened struct file in a security blob.
> >    Introduce get_path_access_rights() helper function.
> > * selftests: test ftruncate in a separate test, to exercise that
> >    the rights are associated with the file descriptor.
> > * Documentation: Rework documentation to reflect new ftruncate() semantics.
> > * Applied small fixes by Mickaël Salaün which he added on top of V5, in
> >    https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
> >    (I hope I found them all.)
> > 
> > V5:
> > * Documentation
> >    * Fix wording in userspace-api headers and in landlock.rst.
> >    * Move the truncation limitation section one to the bottom.
> >    * Move all .rst changes into the documentation commit.
> > * selftests
> >    * Remove _metadata argument from helpers where it became unnecessary.
> >    * Open writable file descriptors at the top of both tests, before Landlock
> >      is enabled, to exercise ftruncate() independently from open().
> >    * Simplify test_ftruncate and decouple it from exercising open().
> >    * test_creat(): Return errno on close() failure (it does not conflict).
> >    * Fix /* comment style */
> >    * Reorder blocks of EXPECT_EQ checks to be consistent within a test.
> >    * Add missing |O_TRUNC to a check in one test.
> >    * Put the truncate_unhandled test before the other.
> > 
> > V4:
> >   * Documentation
> >     * Clarify wording and syntax as discussed in review.
> >     * Use a less confusing error message in the example.
> >   * selftests:
> >     * Stop using ASSERT_EQ in test helpers, return EBADFD instead.
> >       (This is an intentionally uncommon error code, so that the source
> >       of the error is clear and the test can distinguish test setup
> >       failures from failures in the actual system call under test.)
> >   * samples/Documentation:
> >     * Use additional clarifying comments in the kernel backwards
> >       compatibility logic.
> > 
> > V3:
> >   * selftests:
> >     * Explicitly test ftruncate with readonly file descriptors
> >       (returns EINVAL).
> >     * Extract test_ftruncate, test_truncate, test_creat helpers,
> >       which simplified the previously mixed usage of EXPECT/ASSERT.
> >     * Test creat() behaviour as part of the big truncation test.
> >     * Stop testing the truncate64(2) and ftruncate64(2) syscalls.
> >       This simplifies the tests a bit. The kernel implementations are the
> >       same as for truncate(2) and ftruncate(2), so there is little benefit
> >       from testing them exhaustively. (We aren't testing all open(2)
> >       variants either.)
> >   * samples/landlock/sandboxer.c:
> >     * Use switch() to implement best effort mode.
> >   * Documentation:
> >     * Give more background on surprising truncation behaviour.
> >     * Use switch() in the example too, to stay in-line with the sample tool.
> >     * Small fixes in header file to address previous comments.
> > * misc:
> >    * Fix some typos and const usages.
> > 
> > V2:
> >   * Documentation: Mention the truncation flag where needed.
> >   * Documentation: Point out connection between truncation and file writing.
> >   * samples: Add file truncation to the landlock/sandboxer.c sample tool.
> >   * selftests: Exercise open(2) with O_TRUNC and creat(2) exhaustively.
> >   * selftests: Exercise truncation syscalls when the truncate right
> >     is not handled by Landlock.
> > 
> > Günther Noack (11):
> >    security: Create file_truncate hook from path_truncate hook
> >    landlock: Refactor check_access_path_dual() into
> >      is_access_to_paths_allowed()
> >    landlock: Document init_layer_masks() helper
> >    landlock: Support file truncation
> >    selftests/landlock: Test file truncation support
> >    selftests/landlock: Test open() and ftruncate() in multiple scenarios
> >    selftests/landlock: Locally define __maybe_unused
> >    selftests/landlock: Test FD passing from restricted to unrestricted
> >      processes
> >    selftests/landlock: Test ftruncate on FDs created by memfd_create(2)
> >    samples/landlock: Extend sample tool to support
> >      LANDLOCK_ACCESS_FS_TRUNCATE
> >    landlock: Document Landlock's file truncation support
> > 
> >   Documentation/userspace-api/landlock.rst     |  67 ++-
> >   fs/namei.c                                   |   2 +-
> >   fs/open.c                                    |   2 +-
> >   include/linux/lsm_hook_defs.h                |   1 +
> >   include/linux/lsm_hooks.h                    |  10 +-
> >   include/linux/security.h                     |   6 +
> >   include/uapi/linux/landlock.h                |  21 +-
> >   samples/landlock/sandboxer.c                 |  12 +-
> >   security/apparmor/lsm.c                      |   6 +
> >   security/landlock/fs.c                       | 204 ++++++--
> >   security/landlock/fs.h                       |  24 +
> >   security/landlock/limits.h                   |   2 +-
> >   security/landlock/setup.c                    |   1 +
> >   security/landlock/syscalls.c                 |   2 +-
> >   security/security.c                          |   5 +
> >   security/tomoyo/tomoyo.c                     |  13 +
> >   tools/testing/selftests/landlock/base_test.c |  38 +-
> >   tools/testing/selftests/landlock/common.h    |  85 +++-
> >   tools/testing/selftests/landlock/fs_test.c   | 468 ++++++++++++++++++-
> >   19 files changed, 854 insertions(+), 115 deletions(-)
> > 
> > 
> > base-commit: e8bc52cb8df80c31c73c726ab58ea9746e9ff734
