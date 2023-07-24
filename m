Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB65875FF78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 21:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGXTEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 15:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXTEL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:04:11 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CC810E3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 12:04:06 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4R8qMS33jjzMq0WP;
        Mon, 24 Jul 2023 19:04:04 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4R8qMQ5QRBzN5vmW;
        Mon, 24 Jul 2023 21:04:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1690225444;
        bh=mOUnKI3ZsRq6WkhNFABTF7njmSvjadtUXrERf/Wp9u8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=szl2ZoO9m/IhnZZeLkwHhOYg3lDrObzoa9x/n+mLRKyITU0/dTy1cCxEOyJjA+Z3w
         AVm4s/OV1TYbW8IG7L3xpwzTriR8h/I0JceKUqA6j5P8jBsd7GROznM0uNBE6BPME2
         r2JzkG7a2Pr9ViDqH5Nuy9wjG6b8H84qOqj5HLBM=
Message-ID: <e7e24682-5da7-3b09-323e-a4f784f10158@digikod.net>
Date:   Mon, 24 Jul 2023 21:03:42 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2 0/6] Landlock: ioctl support
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>,
        linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
References: <20230623144329.136541-1-gnoack@google.com>
 <6dfc0198-9010-7c54-2699-d3b867249850@digikod.net>
 <ZK6/CF0RS5KPOVff@google.com>
 <f3d46406-4cae-cd5d-fb35-cfcbd64c0690@digikod.net>
 <20230713.470acd0e890b@gnoack.org>
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230713.470acd0e890b@gnoack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 14/07/2023 00:38, Günther Noack wrote:
> Hi!
> 
> On Wed, Jul 12, 2023 at 07:48:29PM +0200, Mickaël Salaün wrote:
>> On 12/07/2023 16:56, Günther Noack wrote:
>>> On Wed, Jul 12, 2023 at 12:55:19PM +0200, Mickaël Salaün wrote:
>>>> Thinking more about this, this first step is too restrictive, which
>>>> might lead to dangerous situations.
>>>>
>>>> My main concern is that this approach will deny innocuous or even "good"
>>>> IOCTL. For instance, if FIOCLEX is denied, this could leak file
>>>> descriptors and then introduce vulnerabilities.
>>>
>>> This is a good point.
>>>
>>>> As we discussed before, we cannot categorize all IOCTLs, but I think we
>>>> need to add exceptions for a subset of them, and maintain this list.
>>>> SELinux has some special handling within selinux_file_ioctl(), and we
>>>> should use that as a starting point. The do_vfs_ioctl() function is
>>>> another important place to look at. The main thing to keep in mind is
>>>> that Landlock's goal is to restrict access to data (e.g. FS, network,
>>>> IPC, bypass through other processes), not to restrict innocuous (at
>>>> least in theory) kernel features.
>>>>
>>>> I think, at least all IOCTLs targeting file descriptors themselves should
>>>> always be allowed, similar to fcntl(2)'s F_SETFD and F_SETFL commands:
>>>> - FIOCLEX
>>>> - FIONCLEX
>>>> - FIONBIO
>>>> - FIOASYNC
>>>>
>>>> Some others may not be a good idea:
>>>> - FIONREAD should be OK in theory but the VFS part only target regular
>>>> files and there is no access check according to the read right, which is
>>>> weird.
>>>> - FICLONE, FICLONERANGE, FIDEDUPRANGE: read/write actions.
>>>>
>>>> We should add a built-time or run-time safeguard to be sure that future
>>>> FD IOCTLs will be added to this list. I'm not sure how to efficiently
>>>> implement such protection though.
>>>
>>> I need to ponder it a bit.. :)  I also don't see an obvious solution yet how to
>>> tie these lists of ioctls together.
>>
>> I guess it should be ok to manually watch the do_vfs_ioctl() changes, but
>> definitely not optimal.
>>
>>>
>>>
>>>> I'm also wondering if we should not split the IOCTL access right into
>>>> three: mostly read, mostly write, and misc. _IOC_READ and _IOC_WRITE are
>>>> definitely not perfect, but tied to specific drivers (i.e. not a file
>>>> hierarchy but a block or character device) this might help until we get
>>>> a more fine-grained IOCTL access control. We should check if it's worth
>>>> it according to commonly used drivers. Looking at the TTY driver, most
>>>> IOCTLs are without read or write markers. Using this split could induce
>>>> a false sense of security, so it should be well motivated.
>>>
>>> As it was pointed out by the LWN article that Jeff Xu pointed to [1], this
>>> read/write bit in the ioctl command number is only referring to whether the
>>> *argument pointer* to the ioctl is being read or written, but you can not use
>>> this bit to infer whether the ioctl itself performs a "reading" or "writing"
>>> access to the underlying file.
>>>
>>> As the LWN article explains, SELinux has fallen for the same trap in the past,
>>> the post [2] has an example for an ioctl where the read/write bits for the
>>> argument are not related to what the underlying operation does.
>>>
>>> It might be that you could potentially use the _IOC_READ and _IOC_WRITE bits to
>>> group smaller subsets of the ioctl cmd space, such as for a single device type.
>>> But then, the users would have to go through the list of supported ioctls one by
>>> one anyway, to ensure that this works for that subset.  If they are going
>>> through them one by one anyway, they might maybe just as well list them out in
>>> the filter rule...?
>>>
>>> [1] https://lwn.net/Articles/428140
>>> [2] https://lwn.net/Articles/428142/
>>
>> Right, I fell again in this trap, !_IOC_READ cannot even guarantee non-write
>> actions.
>>
>> A useful split would be at least between devices and regular
>> files/directories, something like this:
>> - LANDLOCK_ACCESS_FS_IOCTL_DEV: allows IOCTLs on character or block devices,
>> which should be targeted on specific paths.
>> - LANDLOCK_ACCESS_FS_IOCTL_NODEV: allows IOCTLs on regular files,
>> directories, unix sockets, pipes, and symlinks. These are targeting
>> filesystems (e.g. ext4's fsverity) or common Linux file types.
> 
> To make sure we are on the same page, let me paraphrase:
> 
> You are suggesting that we should split the LANDLOCK_ACCESS_FS_IOCTL
> right into a LANDLOCK_ACCESS_FS_IOCTL_DEV part (for block and
> character devices) and a LANDLOCK_ACCESS_FS_IOCTL_NODEV part (for
> regular files, directories, named(!) unix sockets, named(!) pipes and
> symlinks)?  The check would presumably be done during the open(2) call
> and then store the access right on the freshly opened struct file?

Correct

> 
> If Landlock only checks the ioctl criteria during open(2), that would
> mean that file descriptors created through other means would be
> unaffected.

Correct

> 
> In particular, the protection would only apply to named pipes and Unix
> sockets which get newly opened through the file system, but it would
> not apply to pipes created through pipe(2) and Unix sockets created
> through socketpair(2)?

Correct

> 
> (It is more clearly a philosophy of "protecting resources", rather
> than a philosophy of limiting access to the thousands of potentially
> buggy ioctl implementations. - But I think it might be reasonable to
> permit unnamed pipes and socketpairs - they are useful mechanisms and
> seem harmless as long as their implementations don't have bugs.)

The goal of Landlock is to limit access to new resources (e.g. new FD 
obtained from an existing FD or a path).

Unnamed pipes and socketpairs are not a way to (directly) access new 
kernel resources/data, hence out of scope for Landlock. Abstract unix 
sockets will need to be restricted though, but not with a path_beneath 
rule (and not right now with this patch series).


> 
> 
>> I think it makes sense because the underlying filesystems should already
>> check for read/write access, which is not the case for block/char devices.
>> Pipe and unix socket IOCTLs are quite specific but don't touch the
>> underlying filesystem, and it should be allowed to properly use them. It
>> should be noted that the pipe and socket IOCTL implementations don't care
>> about their file mode though; I guess the rationale might be that IOCTLs may
>> be required to (efficiently) either read or write.
>>
> 
> I don't understand your remark about the read/write access.

I meant that regular file/directory IOCTLs (e.g. fscrypt) should already 
check for read or write access according to the IOCTL command. This 
doesn't seem to be the case for devices because they don't modify and 
are unrelated to the underlying filesystem.


> 
> Pipes have a read end and a write end, where only one of the two
> operations should work.  Unix sockets are always bidirectional, if I
> remember this correctly.

Yes, but the pipe and socket IOCTL commands don't check if the related 
FD is opened with read nor write.

> 
>> Reading your following comments, this dev/nodev classification would be like
>> the *file type* item, but simpler and only for file descriptors accessible
>> through the filesystem, which I guess could be everything because of procfs…
>>
>> This split might also help for the landlock_inode_attr properties, but it
>> would also be a bit redundant with the file type match…
> 
> I agree that this dev/nodev classification seems like a simpler
> version of the *file type* item from below.
> 
>>
>>
>>>
>>>
>>> I've also pondered more about the ioctl support. I have a work-in-progress patch
>>> set which filters ioctls according to various criteria, but it's not fully
>>> fleshed out yet.
>>>
>>> In the big picture: I think that the main ways how we can build this differently
>>> are (a) the criteria on which to decide whether an ioctl is permitted, and (b)
>>> the time at which we evaluate these criteria (time of open() vs. time of
>>> ioctl()).  We can also evaluate the criteria at different times, depending on
>>> which criterium it is.
>>>
>>> So:
>>>
>>> (a) The criteria on which to decide that an ioctl is permitted:
>>>
>>>       We have discussed the followowing ones so far:
>>>
>>>       * The *ioctl cmd* (request) itself
>>>          - needs to be taken into account, obviously.
>>>          - ioctl cmds do not have an obvious ordering exposed to userspace,
>>>            so asking users to specify ranges is potentially difficult
>>>          - asking users to list all individual ioctls they do might result in
>>>            lists that are larger than I had thought. I've straced Firefox and
>>>            found that it did about 20-30 direct-rendering related ioctls, and most
>>>            of them were specific to my graphics card... o_O so I assume that there
>>>            are more of these for other graphics cards.
>>>
>>>       * The *file device ID* (major / minor)
>>>          - specifying ranges is a good idea - ranges of device IDs are logically
>>>            grouped and the order is also exposed and documented to user space.
>>>
>>>       * The *file type*, read from filp->f_mode
>>>          - includes regular files, directories, char devices, block devices,
>>>            fifos and sockets
>>>          - BUT this list of types in non-exhaustive:
>>>            - there are valid struct file objects which have special types and are
>>>              not distinguishable. They might not have a file type set in f_mode,
>>>              even.  Examples include pidfds, or the Landlock ruleset FD. -- so: we
>>>              do need a way to ignore file type altogether in an ioctl rule, so
>>>              that such "special" file types can still be matched in the rule.
>>>
>>>       * The *file path*
>>>          - This can only really be checked against at open() time, imho.
>>>            Doing it during the ioctl is too late, because the file might
>>>            have been created in a different mount namespace, and then the
>>>            current thread can't really make that file work with ioctls.
>>>          - Not all open files *have* a file path (i.e. sockets, Landlock ruleset)
>>
>> I think we can reach a lot through /proc/self/fd/
> 
> What I meant to say is: The struct file for some files does not refer
> to a path on the file system that the file was opened from ==> Using
> the file path as criterium does not cover all existing ioctl use
> cases.

Correct

> 
> The thing that struck me about the above list of criteria is that each
> of them seems to have gaps.  As an example, take timerfds
> (timerfd_create(2)):
> 
>   * these do not get opened through a file system path, so the *file
>     path* can not restrict them.

>   * they are not character or block devices and do not have a device ID.
>   * they don't match any of the file types in filp->f_mode.

Indeed, we may need a way to identify this kind of FD in the future but 
it should not be an issue for now with the path_beneath rules. I guess 
we could match the anon_inode:[*] name, but I would prefer to avoid 
using strings. A better way to identify this kind of FD would be to pass 
a similar one in a rule, in the same way as for path_beneath (as I 
suggested in a previous email).


> 
> So in order to permit the TFD_IOC_SET_TICKS ioctl on them, these three
> criteria can't be used to describe a timerfd.

Correct, and timerfd don't give access to (FS-related) data.

If we want to restrict this kind of FD (and if it's worth it), we can 
follow the same approach as for restricting new socket creation. 
Restricting specific IOCTLs on these FDs would require a 
capability-based approach (cf. Capsicum): explicitly attach restrictions 
to a FD, not a process, and the mechanism is almost there thanks to the 
truncate access right patches. It would make sense for Landlock to 
support this kind of FD capabilities, but maybe not right now.


> 
> This is more important in an implementation where the criteria are
> checked in security_file_ioctl, rather than in security_file_open.  In
> an implementation where the criteria are only checked in
> security_file_open, it would anyway not be possible to restrict ioctls
> on the timerfd, and all files for which it would be possible, they
> must have a path in the file system when they end up in that hook, I
> suspect?
> 
>>> (b) The time at which the criteria are checked:
>>>
>>>       * During open():
>>>          - A check at this time is necessary to match against file paths, imho,
>>>            as we already to in the ioctl patch set I've sent.
>>>
>>>       * During ioctl():
>>>          - A check at this time is *also* necessary, because without that, we will
>>>            not be able to restrict ioctls on TTYs and other file descriptors that
>>>            are obtained from other processes.
> 
> For completeness: I forgot to list here: The other reason where a
> check during ioctl() is needed is the case as for the timerfd, the
> pipe(2) and socketpair(2), where a file is created through a simple
> syscall, but without spelling out a path.  If these kinds of files are
> in scope for ioctl protection, it can't be done during the open()
> check alone, I suspect?

Correct, but we don't need this kind of restriction for now.

> 
>> As I explained before, I don't think we should care about inherited or
>> passed FDs. Other ways to get FDs (e.g. landlock_create_ruleset) should
>> probably not be a priority for now.
> 
> I don't know what we should do about the "basic Unix tool" and
> TIOCSTI/TIOCLINUX case, where it is possible to gain control over the
> shell running in the tty that we get as stdout fd.
> 
> I'm in that situation with the little web application I run at home,
> but the patch that you have sent for GNU tar at some point (and which
> we should really revive :)) has the same problem: If an attacker
> manages to do a Remote Code Execution in that tar process, they can
> ioctl(1, TIOCSTI, ...) their way out into the shell which invoked tar,
> and which is not restricted with tar's Landlock policy.
> 
> (I don't really see tar create a pty/tty pair either and shovel data
> between them in a sidecar process or thread, just to protect against
> that.)

Indeed, and that's why sandboxing an application might raise some 
challenges. We should note that a sandboxed application might only be 
safely used in some cases (e.g. pipe stdio and close other FDs), but I 
agree that this is not satisfactory for now, and there are still gaps.


> 
> Remark: For the specific TIOCSTI problem, I'm seeing a glimmer of
> light with this patch set which has appeared in the meantime:
> https://lore.kernel.org/all/20230710002645.v565c7xq5iddruse@begin/
> (This will still require that distributions flip that Kconfig option
> off, but the only(?) known user of TIOCSTI, BRLTTY, would continue
> working.)

I hope most distros are disabling CONFIG_LEGACY_TIOCSTI, otherwise users 
should still be able to tweak the related sysctl.


> 
> I would be more comfortable with doing the checks only at open(2) time
> if the above patch landed in distributions so that you would need to
> have CAP_SYS_ADMIN in order to use TIOCSTI.
> 
> Do you think this is realistic?  If this does not get flipped by
> distributions, Landlock would continue to have these TIOCSTI problems
> on these platforms (unless its users do the pty/tty pair thing, but
> that seems like an unrealistic demand).

What if we use an FD to identify an inode with landlock_inode_attr rule? 
We could have some flag to "pin" the restriction on this specific 
FD/inode, or only match the device type, or the file type… We need to 
think a bit more about the implications though.


> 
> 
>>> The tentative approach I've taken in my own patch set and the WIP part so far is:
>>>
>>>    (1) Do file path checks at open() time (modeled as a access_fs right)
>>>    (2) Do cmds, device ID and file type checks at ioctl() time.
>>>        This is modeled independently of the file path check. -- both checks need to
>>>        pass independently for an ioctl invocation to be permitted.
>>
>> This looks good! However, see below an alternative approach for the rules
>> combination.
>>
>>>
>>> The API of that approach is:
>>>    * The ruleset attribute gets a new handled_misc field,
>>>      and when setting the first bit in it, it'll deny all ioctls
>>>      unless there is a special ioctl rule added for them
>>>      (and the path of the file was OK for ioctl at open time).
>>>    * A new rule type with an associated struct landlock_ioctl_attr -
>>>      that struct lets users define:
>>>        - the desired mask of file types (or 0 for "all")
>>>        - the designed device ID range
>>>        - the list of ioctl cmds to be permitted for such files
>>>
>>> An open question is whether the ruleset attr's "handled_misc" field should
>>> rather be a "handled_ioctl_cmds" field, a set of restricted ioctl cmds
>>> (potentially [0, 2^32)).  I think that would be more consistent conceptually
>>> with how it was done for file system access rights, but obviously we can't model
>>> it as a bit field any more - it would have to be some other suitable
>>> representation of a set of integers, which also lets people say "all ioctls".
>>
>> We might not need another ruleset's field because we can reuse the existing
>> FS access rights, including the new IOCTL one(s). The trick is just to
>> define a new way to match files (and optionally specific IOCTL commands),
>> hence the landlock_inode_attr proposal. As you explained, this type of rule
>> could match device IDs and file types.
> 
> I have to think about it and maybe try it out in code.  This might be
> a better option if we go for doing the checks only at open(2) time.
> 
> I do think that device IDs are often a better way to specify device
> files than their paths are.  Device IDs are a stable numbering scheme
> that won't change, whereas the structure of /dev can be defined by
> user space and is also often dynamically adding and removing devices.
> 
>> An alternative way to identify such
>> properties would be to pass an FD and specify a subset of these properties
>> to match on. This would avoid some side channel issues, and could be used to
>> check for directory or file (as done for path_beneath) to avoid irrelevant
>> access rights.
> 
> I don't fully understand what you mean here.  Do you mean to use an
> open device file as example for what to match?

Yes

>  I don't see how
> specifying the file type and device ID range as plain numbers could
> lead to a race condition.

No race condition but side channel issues. For instance, a landlocked 
process could infer some file properties by adding and testing a 
Landlock rule even if it is not allowed to read such file properties 
(because of potential Landlock or other restrictions). Using a FD 
enables Landlock to check that the process is indeed allowed to read 
such properties, or we may decide that it is not necessary to do so.


> 
> 
>> I suggest to first handle path_beneath and inode rules as a binary OR set of
>> rights (i.e. the sandboxed processes only needs one rule to match for the
>> defined action to be allowed). Then, with a way to identify inodes rules, we
>> could treat them as synthetic access rights and add a new allowed_inode
>> field to path_beneath rules and remove the IOCTL access rights from their
>> allowed_access field. This way, sandboxed processes would need both rules to
>> match.
> 
> I'm not sure what the inode rule is.  Do you mean "ioctl rule"?

I mean a landlock_inode_attr rule that identify an inode with a device 
type, or a file type, or a specific inode (i.e. object)… and an IOCTL 
command as well (i.e. action).

> 
> If yes, I do agree that a list of permitted ioctls is similar to the
> access rights flags that we already have, and it would have to get
> passed around in a similar fashion (as "synthetic access rights"),
> albeit using a different data structure.
> 
> I'm still skeptical of the API approach where we tie previously
> unrelated rules together, if that is what you mean here.  I find this
> difficult to explain and reason about.  But in doubt we'll see in the
> implementation how unwieldy it actually gets.

Right, we don't need to implement the synthetic access rights with the 
current step though.

> 
> 
>>> The upside of that approach would be that it could also be used to selectively
>>> restrict specific known-evil ioctls, and letting all others continue to work.
>>> For example, sandboxing or sudo-like programs could filter out TIOCSTI and
>>> TIOCLINUX.
> 
> By the way, selectively restricting known-bad ioctls is still not
> possible with the approach we discussed now, I think.  Maybe TIOCSTI
> is the only bad one... I hope.

It would not be possible with the landlock_path_beneath_attr, but the 
landlock_inode_attr could be enough.

> 
>>>
>>> I'd be interested in hearing your opinion about this (also from the Chromium
>>> side).
>>>
>>> Thanks,
>>> —Günther
>>>
> 
> Thanks,
> –Günther
