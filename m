Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3696750FF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjGLRs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjGLRsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:48:51 -0400
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B255D1FD2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 10:48:49 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4R1QG66prdzMq7X8;
        Wed, 12 Jul 2023 17:48:46 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4R1QG56QqQzMpppg;
        Wed, 12 Jul 2023 19:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1689184126;
        bh=ej4nRdflBKFob/CbkVTHtZZT92EorQqZrHWUv3RwmDQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WsOwq/20iSQkOQRWdoeM/gLXQGPTRWWIh1L9J+TGNIefMZZzimbGG1R/O1bbqsKZg
         mdb/CD7Gy1am6Qzl7tiZIycxi82Dv4pL9kkrKRUIlYu3DE6kSFseTTzJExalz+l7+5
         r8Zwzg8dHFf9SIfBgeRucQx+zDeKJNzzKPRQV9FM=
Message-ID: <f3d46406-4cae-cd5d-fb35-cfcbd64c0690@digikod.net>
Date:   Wed, 12 Jul 2023 19:48:29 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2 0/6] Landlock: ioctl support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
References: <20230623144329.136541-1-gnoack@google.com>
 <6dfc0198-9010-7c54-2699-d3b867249850@digikod.net>
 <ZK6/CF0RS5KPOVff@google.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <ZK6/CF0RS5KPOVff@google.com>
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


On 12/07/2023 16:56, Günther Noack wrote:
> Hi!
> 
> On Wed, Jul 12, 2023 at 12:55:19PM +0200, Mickaël Salaün wrote:
>> Thinking more about this, this first step is too restrictive, which
>> might lead to dangerous situations.
>>
>> My main concern is that this approach will deny innocuous or even "good"
>> IOCTL. For instance, if FIOCLEX is denied, this could leak file
>> descriptors and then introduce vulnerabilities.
> 
> This is a good point.
> 
>> As we discussed before, we cannot categorize all IOCTLs, but I think we
>> need to add exceptions for a subset of them, and maintain this list.
>> SELinux has some special handling within selinux_file_ioctl(), and we
>> should use that as a starting point. The do_vfs_ioctl() function is
>> another important place to look at. The main thing to keep in mind is
>> that Landlock's goal is to restrict access to data (e.g. FS, network,
>> IPC, bypass through other processes), not to restrict innocuous (at
>> least in theory) kernel features.
>>
>> I think, at least all IOCTLs targeting file descriptors themselves should
>> always be allowed, similar to fcntl(2)'s F_SETFD and F_SETFL commands:
>> - FIOCLEX
>> - FIONCLEX
>> - FIONBIO
>> - FIOASYNC
>>
>> Some others may not be a good idea:
>> - FIONREAD should be OK in theory but the VFS part only target regular
>> files and there is no access check according to the read right, which is
>> weird.
>> - FICLONE, FICLONERANGE, FIDEDUPRANGE: read/write actions.
>>
>> We should add a built-time or run-time safeguard to be sure that future
>> FD IOCTLs will be added to this list. I'm not sure how to efficiently
>> implement such protection though.
> 
> I need to ponder it a bit.. :)  I also don't see an obvious solution yet how to
> tie these lists of ioctls together.

I guess it should be ok to manually watch the do_vfs_ioctl() changes, 
but definitely not optimal.

> 
> 
>> I'm also wondering if we should not split the IOCTL access right into
>> three: mostly read, mostly write, and misc. _IOC_READ and _IOC_WRITE are
>> definitely not perfect, but tied to specific drivers (i.e. not a file
>> hierarchy but a block or character device) this might help until we get
>> a more fine-grained IOCTL access control. We should check if it's worth
>> it according to commonly used drivers. Looking at the TTY driver, most
>> IOCTLs are without read or write markers. Using this split could induce
>> a false sense of security, so it should be well motivated.
> 
> As it was pointed out by the LWN article that Jeff Xu pointed to [1], this
> read/write bit in the ioctl command number is only referring to whether the
> *argument pointer* to the ioctl is being read or written, but you can not use
> this bit to infer whether the ioctl itself performs a "reading" or "writing"
> access to the underlying file.
> 
> As the LWN article explains, SELinux has fallen for the same trap in the past,
> the post [2] has an example for an ioctl where the read/write bits for the
> argument are not related to what the underlying operation does.
> 
> It might be that you could potentially use the _IOC_READ and _IOC_WRITE bits to
> group smaller subsets of the ioctl cmd space, such as for a single device type.
> But then, the users would have to go through the list of supported ioctls one by
> one anyway, to ensure that this works for that subset.  If they are going
> through them one by one anyway, they might maybe just as well list them out in
> the filter rule...?
> 
> [1] https://lwn.net/Articles/428140
> [2] https://lwn.net/Articles/428142/

Right, I fell again in this trap, !_IOC_READ cannot even guarantee 
non-write actions.

A useful split would be at least between devices and regular 
files/directories, something like this:
- LANDLOCK_ACCESS_FS_IOCTL_DEV: allows IOCTLs on character or block 
devices, which should be targeted on specific paths.
- LANDLOCK_ACCESS_FS_IOCTL_NODEV: allows IOCTLs on regular files, 
directories, unix sockets, pipes, and symlinks. These are targeting 
filesystems (e.g. ext4's fsverity) or common Linux file types.

I think it makes sense because the underlying filesystems should already 
check for read/write access, which is not the case for block/char 
devices. Pipe and unix socket IOCTLs are quite specific but don't touch 
the underlying filesystem, and it should be allowed to properly use 
them. It should be noted that the pipe and socket IOCTL implementations 
don't care about their file mode though; I guess the rationale might be 
that IOCTLs may be required to (efficiently) either read or write.

Reading your following comments, this dev/nodev classification would be 
like the *file type* item, but simpler and only for file descriptors 
accessible through the filesystem, which I guess could be everything 
because of procfs…

This split might also help for the landlock_inode_attr properties, but 
it would also be a bit redundant with the file type match…


> 
> 
> I've also pondered more about the ioctl support. I have a work-in-progress patch
> set which filters ioctls according to various criteria, but it's not fully
> fleshed out yet.
> 
> In the big picture: I think that the main ways how we can build this differently
> are (a) the criteria on which to decide whether an ioctl is permitted, and (b)
> the time at which we evaluate these criteria (time of open() vs. time of
> ioctl()).  We can also evaluate the criteria at different times, depending on
> which criterium it is.
> 
> So:
> 
> (a) The criteria on which to decide that an ioctl is permitted:
> 
>      We have discussed the followowing ones so far:
> 
>      * The *ioctl cmd* (request) itself
>         - needs to be taken into account, obviously.
>         - ioctl cmds do not have an obvious ordering exposed to userspace,
>           so asking users to specify ranges is potentially difficult
>         - asking users to list all individual ioctls they do might result in
>           lists that are larger than I had thought. I've straced Firefox and
>           found that it did about 20-30 direct-rendering related ioctls, and most
>           of them were specific to my graphics card... o_O so I assume that there
>           are more of these for other graphics cards.
> 
>      * The *file device ID* (major / minor)
>         - specifying ranges is a good idea - ranges of device IDs are logically
>           grouped and the order is also exposed and documented to user space.
> 
>      * The *file type*, read from filp->f_mode
>         - includes regular files, directories, char devices, block devices,
>           fifos and sockets
>         - BUT this list of types in non-exhaustive:
>           - there are valid struct file objects which have special types and are
>             not distinguishable. They might not have a file type set in f_mode,
>             even.  Examples include pidfds, or the Landlock ruleset FD. -- so: we
>             do need a way to ignore file type altogether in an ioctl rule, so
>             that such "special" file types can still be matched in the rule.
> 
>      * The *file path*
>         - This can only really be checked against at open() time, imho.
>           Doing it during the ioctl is too late, because the file might
>           have been created in a different mount namespace, and then the
>           current thread can't really make that file work with ioctls.
>         - Not all open files *have* a file path (i.e. sockets, Landlock ruleset)

I think we can reach a lot through /proc/self/fd/

> 
> (b) The time at which the criteria are checked:
> 
>      * During open():
>         - A check at this time is necessary to match against file paths, imho,
>           as we already to in the ioctl patch set I've sent.
> 
>      * During ioctl():
>         - A check at this time is *also* necessary, because without that, we will
>           not be able to restrict ioctls on TTYs and other file descriptors that
>           are obtained from other processes.

As I explained before, I don't think we should care about inherited or 
passed FDs. Other ways to get FDs (e.g. landlock_create_ruleset) should 
probably not be a priority for now.


> 
> The tentative approach I've taken in my own patch set and the WIP part so far is:
> 
>   (1) Do file path checks at open() time (modeled as a access_fs right)
>   (2) Do cmds, device ID and file type checks at ioctl() time.
>       This is modeled independently of the file path check. -- both checks need to
>       pass independently for an ioctl invocation to be permitted.

This looks good! However, see below an alternative approach for the 
rules combination.

> 
> The API of that approach is:
>   * The ruleset attribute gets a new handled_misc field,
>     and when setting the first bit in it, it'll deny all ioctls
>     unless there is a special ioctl rule added for them
>     (and the path of the file was OK for ioctl at open time).
>   * A new rule type with an associated struct landlock_ioctl_attr -
>     that struct lets users define:
>       - the desired mask of file types (or 0 for "all")
>       - the designed device ID range
>       - the list of ioctl cmds to be permitted for such files
> 
> An open question is whether the ruleset attr's "handled_misc" field should
> rather be a "handled_ioctl_cmds" field, a set of restricted ioctl cmds
> (potentially [0, 2^32)).  I think that would be more consistent conceptually
> with how it was done for file system access rights, but obviously we can't model
> it as a bit field any more - it would have to be some other suitable
> representation of a set of integers, which also lets people say "all ioctls".

We might not need another ruleset's field because we can reuse the 
existing FS access rights, including the new IOCTL one(s). The trick is 
just to define a new way to match files (and optionally specific IOCTL 
commands), hence the landlock_inode_attr proposal. As you explained, 
this type of rule could match device IDs and file types. An alternative 
way to identify such properties would be to pass an FD and specify a 
subset of these properties to match on. This would avoid some side 
channel issues, and could be used to check for directory or file (as 
done for path_beneath) to avoid irrelevant access rights.

I suggest to first handle path_beneath and inode rules as a binary OR 
set of rights (i.e. the sandboxed processes only needs one rule to match 
for the defined action to be allowed). Then, with a way to identify 
inodes rules, we could treat them as synthetic access rights and add a 
new allowed_inode field to path_beneath rules and remove the IOCTL 
access rights from their allowed_access field. This way, sandboxed 
processes would need both rules to match.


> 
> The upside of that approach would be that it could also be used to selectively
> restrict specific known-evil ioctls, and letting all others continue to work.
> For example, sandboxing or sudo-like programs could filter out TIOCSTI and
> TIOCLINUX.
> 
> I'd be interested in hearing your opinion about this (also from the Chromium
> side).
> 
> Thanks,
> —Günther
> 
