Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F636F77D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 23:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjEDVMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 17:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjEDVMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 17:12:15 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4775B9EE6
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 14:12:04 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QC62V1k7hzMr93Y;
        Thu,  4 May 2023 23:12:02 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4QC62T2QFNz3j;
        Thu,  4 May 2023 23:12:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1683234722;
        bh=apalpZxl0+zvWBFLdL7q02//smZ2PTxAJfSrWC6B9HI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YcB55VYJHOfllZV6U0z8Rj+DMygf7epLPc8lzT25vQ3oTv4kwuvvTKK8ee2jDcsfD
         n8ZQKpJ+mIK41OJhE0Wo7SMWzCrxbokH5hgy0xAHTmecQJ4zL7RT8l6XzCAk9XAALb
         73CmRuI3koaojQ97H52IJO/FTWh7xWjFxqrV+wCU=
Message-ID: <1cb74c81-3c88-6569-5aff-154b8cf626fa@digikod.net>
Date:   Thu, 4 May 2023 23:12:00 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [RFC 0/4] Landlock: ioctl support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230502171755.9788-1-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for this RFC, this is interesting!

I previously thought a lot about IOCTLs restrictions and here are some 
notes:

IOCTLs are everywhere, from devices to filesystems (see fscrypt). Each 
different file type may behave differently for the same IOCTL 
command/ID. It is also worth noting that there are a lot of different 
IOCTLs, they are growing over time, some might be dedicated to get some 
data (i.e. read) and others to change the state of a device (i.e. 
write), some might be innocuous (e.g. FIOCLEX, FIONCLEX) and others 
potentially harmful. _IOC_READ and _IOC_WRITE can be useful but they are 
not mandatory, there are exceptions, and it may be difficult to identify 
if a command pertains to one, the other, or both kind of actions.

I then think it would be very useful to be able to tie file/device types 
to a set of IOCTLs, letting user space libraries define and classify the 
IOCTL semantic.

Instead of relying on a LANDLOCK_ACCESS_FS_IOCTL which would allow or 
deny all IOCTLs, we can extend the path_beneath struct to manage IOCTLs 
in addition to regular file accesses. Because dealing with a set of 
IOCTLs would imply to deal with a lot of data and combinations, I 
thought about creating groups of IOCTLs (defining access semantic) that 
could be matched against file hierarchies. The composability nature of 
Landlock domains is also another constraint to keep in mind.

// New rule type dedicated to define groups of IOCTLs.
struct landlock_ioctl_attr {
   __u32 command; // IOCTL number/ID
   dev_t device; // must be 0 for regular file and directory
   __u8 file_type;
   __u8 id_mask; // if 0, then applied globally
};

We could use landlock_add_rule(2) to fill a set of landlock_ioctl_attr 
into a ruleset and use them with landlock_path_beneath_attr entries:

// LANDLOCK_RULE_PATH_BENEATH, leveraging the extensible design of
// landlock_path_beneath_attr, hence the same first fields.
struct landlock_path_beneath_attr {
   __u64 allowed_access;
   __s32 parent_fd;
   __u16 allowed_ioctl_id_mask;
};

landlock_ioctl_attr includes a 8-bit mask for which each bit identifies 
a set of allowed IOCTLs per device/file type. This mask is then tied to 
a path_beneath_attr. We cannot use number IDs because of dev_t+IOCTL->ID 
intersection conflicts. Using an id_mask enables to group (specific) 
IOCTLs together, then creating synthetic access rights.

When merging a ruleset with a domain, each IOCTL ID mask is shifted and 
ORed with the other layer ones to get a (8*16) 128-bit mask, stored in 
an IOCTL/dev_t table and in the related landlock_object. When looking 
for an IOCTL request, Landlock first looks into the IOCTL set ID table 
and get the global set ID mask, which kind of translates to a 
composition of synthetic access rights (stored with the 
landlock_layer.ioctl_access bitmask). We then walk through all the 
inodes to match the whole mask.

I realize that this is complex and this explanation might be confusing 
though. What do you think?



On 02/05/2023 19:17, Günther Noack wrote:
> Hello!
> 
> These patches add ioctl support to Landlock.
> 
> It's an early version - it potentially needs more tests and
> documentation.  I'd like to circulate the patches early to discuss
> whether this approach is feasible.
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
> I believe that this approach works for the majority of use cases, and
> offers a good trade-off between Landlock API and implementation
> complexity and flexibility when the feature is used.
> 
> Notable implications of this approach
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> * Existing inherited file descriptors stay unaffected
>    when a program enables Landlock.
> 
>    This means in particular that in common scenarios,
>    the terminal's ioctls (ioctl_tty(2)) continue to work.
> 
> * ioctl(2) continues to be available for file descriptors acquired
>    through means other than open(2).  Example: Network sockets.
> 
> Examples
> ~~~~~~~~
> 
> Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:
> 
>    LL_FS_RO=/ LL_FS_RW=. ./sandboxer /bin/bash
> 
> The LANDLOCK_ACCESS_FS_IOCTL right is part of the "read-write" rights
> here, so we expect that newly opened files outside of $HOME don't work
> with ioctl(2).
> 
>    * "stty" works: It probes terminal properties
> 
>    * "stty </dev/tty" fails: /dev/tty can be reopened, but the ioctl is
>      denied.
> 
>    * "eject" fails: ioctls to use CD-ROM drive are denied.
> 
>    * "ls /dev" works: It uses ioctl to get the terminal size for
>      columnar layout
> 
>    * The text editors "vim" and "mg" work.  (GNU Emacs fails because it
>      attempts to reopen /dev/tty.)
> 
> Alternatives considered: Allow-listing specific ioctl requests
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> It would be technically possible to keep an allow-list of ioctl
> requests and thereby control in more detail which ioctls should work.
> 
> I believe that this is not needed for the majority of use cases and
> that it is a reasonable trade-off to make here (but I'm happy to hear
> about counterexamples).  The reasoning is:
> 
> * Many programs do not need ioctl at all,
>    and denying all ioctl(2) requests OK for these.
> 
> * Other programs need ioctl, but only for the terminal FDs.
>    This is supported because these file descriptors are usually
>    inherited from the parent process - so the parent process gets to
>    control the ioctl(2) policy for them.
> 
> * Some programs need ioctl on specific files that they are opening
>    themselves.  They can allow-list these file paths for ioctl(2).
>    This makes the programs work, but it restricts a variety of other
>    ioctl requests which are otherwise possible through opening other
>    files.
> 
> Because the LANDLOCK_ACCESS_FS_IOCTL right is attached to the file
> descriptor, programs have flexible options to control which ioctl
> operations should work, without the implementation complexity of
> additional ioctl allow-lists in the kernel.
> 
> Finally, the proposed approach is simpler in implementation and has
> lower API complexity, but it does *not* preclude us from implementing
> per-ioctl-request allow lists later, if that turns out to be necessary
> at a later point.

I value this simplicity, but I'm also wondering about how much this 
allow/deny all IOCTLs approach would be useful in real case scenarios. ;)


> 
> Related Work
> ~~~~~~~~~~~~
> 
> OpenBSD's pledge(2) [1] restricts ioctl(2) independent of the file
> descriptor which is used.  The implementers maintain multiple
> allow-lists of predefined ioctl(2) operations required for different
> application domains such as "audio", "bpf", "tty" and "inet".
> 
> OpenBSD does not guarantee ABI backwards compatibility to the same
> extent as Linux does, so it's easier for them to update these lists in
> later versions.  It might not be a feasible approach for Linux though.
> 
> [1] https://man.openbsd.org/OpenBSD-7.3/pledge.2
> 
> Feedback I'm looking for
> ~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Some specific points I would like to get your opinion on:
> 
> * Is this the right general approach to restricting ioctl(2)?
> 
>    It will probably be possible to find counter-examples where the
>    alternative (see below) is better.  I'd be interested in these, and
>    in how common they are, to understand whether we have picked the
>    right trade-off here.

In the long term, I'd like Landlock to be able to restrict a set of 
IOCTLs, taking into account the type of file/device. Being able to deny 
all IOCTLs might be useful and is much easier to implement though.


> 
> * Should we introduce a "landlock_fd_rights_limit()" syscall?
> 
>    We could potentially implement a system call for dropping the
>    LANDLOCK_ACCESS_FS_IOCTL and LANDLOCK_ACCESS_FS_TRUNCATE rights from
>    existing file descriptors (independent of the type of file
>    descriptor, even).
> 
>    Possible use cases would be to (a) restrict the rights on inherited
>    file descriptors like std{in,out,err} and to (b) restrict ioctl and
>    truncate operations on file descriptors that are not acquired
>    through open(2), such as network sockets.
> 
>    This would be similar to the cap_rights_limit(2) system call in
>    FreeBSD's Capsicum.
> 
>    This idea feels somewhat orthogonal to the ioctl patch, but it would
>    start to be more useful if the ioctl right exists.

This is indeed interesting, and that should be useful for the cases you 
explained. I think supporting IOCTLs is more important for now, but a 
new syscall to restrict FDs could be useful in the future. We should 
also think about batch operations on FD (see the close_range syscall), 
for instance to deny all IOCTLs on inherited or received FDs.


> 
> 
> Günther Noack (4):
>    landlock: Increment Landlock ABI version to 4
>    landlock: Add LANDLOCK_ACCESS_FS_IOCTL access right
>    selftests/landlock: Test ioctl support
>    samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
> 
>   include/uapi/linux/landlock.h                | 19 ++++--
>   samples/landlock/sandboxer.c                 | 12 +++-
>   security/landlock/fs.c                       | 20 +++++-
>   security/landlock/limits.h                   |  2 +-
>   security/landlock/syscalls.c                 |  2 +-
>   tools/testing/selftests/landlock/base_test.c |  2 +-
>   tools/testing/selftests/landlock/fs_test.c   | 67 +++++++++++++++++++-
>   7 files changed, 107 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
