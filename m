Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A6D766ED0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 15:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjG1Nw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 09:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbjG1Nw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:52:26 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8A53AAE
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 06:52:23 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RC8Fv1HnfzMsHWs;
        Fri, 28 Jul 2023 13:52:19 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RC8Fs60C7z3d;
        Fri, 28 Jul 2023 15:52:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1690552339;
        bh=+70MFSI1SegwL4z3nQq58XdcZmUoakLls3DpzQveORg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V3QKTz9YbELVjDlat9tptSSVPVeJPokQHK7DFVN33NH9zNQ65FxMIABmG4wENSQGb
         MIlUPHMZaJdGMP2R6iFN7bl6sATMcCUBi7tihh1TtMvCQElUFYFxi1e54a/vehiIjH
         GntQmHjmpsOD/cTuXYbo3rmjOe6KIeSF3nX07qlA=
Message-ID: <ac314809-0afc-7a1c-d758-da28b0199e7e@digikod.net>
Date:   Fri, 28 Jul 2023 15:52:03 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2 0/6] Landlock: ioctl support
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>
Cc:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Matt Bobrowski <repnop@google.com>
References: <20230623144329.136541-1-gnoack@google.com>
 <6dfc0198-9010-7c54-2699-d3b867249850@digikod.net>
 <ZK6/CF0RS5KPOVff@google.com>
 <f3d46406-4cae-cd5d-fb35-cfcbd64c0690@digikod.net>
 <20230713.470acd0e890b@gnoack.org>
 <e7e24682-5da7-3b09-323e-a4f784f10158@digikod.net>
 <ZMI5ooJq6i/OJyxs@google.com>
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <ZMI5ooJq6i/OJyxs@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 27/07/2023 11:32, Günther Noack wrote:
> Hello Mickaël!
> 
> Overall, I believe that I thought too far ahead here and now we've
> been mixing the discussions for different steps from the three-step
> approach that we discussed in [1].
> 
> In order to make progress here, let me try to disentangle in this mail
> which parts we need for the current step (1) and which parts are only
> needed for later steps.
> 
> [1] https://lore.kernel.org/linux-security-module/d4f1395c-d2d4-1860-3a02-2a0c023dd761@digikod.net/
> 
> 
> On Mon, Jul 24, 2023 at 09:03:42PM +0200, Mickaël Salaün wrote:
>> On 14/07/2023 00:38, Günther Noack wrote:
>>> On Wed, Jul 12, 2023 at 07:48:29PM +0200, Mickaël Salaün wrote:
>>>> A useful split would be at least between devices and regular
>>>> files/directories, something like this:
>>>> - LANDLOCK_ACCESS_FS_IOCTL_DEV: allows IOCTLs on character or block devices,
>>>> which should be targeted on specific paths.
>>>> - LANDLOCK_ACCESS_FS_IOCTL_NODEV: allows IOCTLs on regular files,
>>>> directories, unix sockets, pipes, and symlinks. These are targeting
>>>> filesystems (e.g. ext4's fsverity) or common Linux file types.
>>>
>>> To make sure we are on the same page, let me paraphrase:
>>>
>>> You are suggesting that we should split the LANDLOCK_ACCESS_FS_IOCTL
>>> right into a LANDLOCK_ACCESS_FS_IOCTL_DEV part (for block and
>>> character devices) and a LANDLOCK_ACCESS_FS_IOCTL_NODEV part (for
>>> regular files, directories, named(!) unix sockets, named(!) pipes and
>>> symlinks)?  The check would presumably be done during the open(2) call
>>> and then store the access right on the freshly opened struct file?
>>
>> Correct
> 
> OK, I'll add this to step (1) then.
> 
> 
>>> (It is more clearly a philosophy of "protecting resources", rather
>>> than a philosophy of limiting access to the thousands of potentially
>>> buggy ioctl implementations. - But I think it might be reasonable to
>>> permit unnamed pipes and socketpairs - they are useful mechanisms and
>>> seem harmless as long as their implementations don't have bugs.)
>>
>> The goal of Landlock is to limit access to new resources (e.g. new FD
>> obtained from an existing FD or a path).
>>
>> Unnamed pipes and socketpairs are not a way to (directly) access new kernel
>> resources/data, hence out of scope for Landlock. Abstract unix sockets will
>> need to be restricted though, but not with a path_beneath rule (and not
>> right now with this patch series).
> 
> OK, fair enough.  I can see that this is conceptually cleaner within
> Landlock.
> 
> Let's go for that approach then, where Landlock only restricts newly
> opened path-based files, and where we leave inherited file descriptors
> and the ones created through pipe(2), socketpair(2) and timerfds as
> they are for now.
> 
> It feels like TIOCSTI (and TIOCLINUX) are probably the biggest
> problems when it comes to these inherited files.  With some luck,
> TIOCSTI will be turned off by distributions soon (and TIOCLINUX only
> works on the text console, which is luckily not in use that much).
> Fingers crossed.
> 
> 
>>>> I think it makes sense because the underlying filesystems should already
>>>> check for read/write access, which is not the case for block/char devices.
>>>> Pipe and unix socket IOCTLs are quite specific but don't touch the
>>>> underlying filesystem, and it should be allowed to properly use them. It
>>>> should be noted that the pipe and socket IOCTL implementations don't care
>>>> about their file mode though; I guess the rationale might be that IOCTLs may
>>>> be required to (efficiently) either read or write.
>>>>
>>>
>>> I don't understand your remark about the read/write access.
>>
>> I meant that regular file/directory IOCTLs (e.g. fscrypt) should already
>> check for read or write access according to the IOCTL command. This doesn't
>> seem to be the case for devices because they don't modify and are unrelated
>> to the underlying filesystem.
>>
>>
>>>
>>> Pipes have a read end and a write end, where only one of the two
>>> operations should work.  Unix sockets are always bidirectional, if I
>>> remember this correctly.
>>
>> Yes, but the pipe and socket IOCTL commands don't check if the related FD is
>> opened with read nor write.
> 
> I still don't understand your remarks about ioctl commands not
> checking read and write flags.  To clarify: What you are talking about
> is that the implementations of individual ioctl commands should all
> check the read and write mode flags on the struct file, is that right?
> 
> I'm puzzled how you come to the conclusion that devices don't do such
> checks - did you read some ioctl command implementations, or is it a
> more underlying principle that I was not aware of so far?

I took a look at fscrypt IOCTLs for instance, and other FS IOCTLs seems 
to correctly check for FD's read/write mode according to the IOCTL 
behavior. From what I've seen, IOCTLs implemented by device drivers 
don't care about file mode.


> 
> So far, I've always been under the impression that the modes on device
> files are also reflected on the associated struct file after they are
> opened.  As in, you open a block device for reading to read its
> contents, but you need to open it for writing to modify it.  Are these
> rights not respected by the ioctl commands?

File mode is correctly tracked but ignore by most IOCTL handlers, 
probably because file mode is dedicated to raw files and directories.

> 
> 
> In any case - I believe the only reason why we are discussing this is
> to justify the DEV/NODEV split, and that one in itself is not
> controversial to me, even when I admittedly don't fully follow your
> reasoning.

The main reason is than I don't want applications/users to not be 
allowed to use "legitimate" IOCTL, for instance to correctly encrypt 
their own files. If we only have one IOCTL right, we cannot easily 
differentiate between the targeted file types. However, this split might 
be too costly, cf. my comment in the below summary.


> 
> 
>>> The thing that struck me about the above list of criteria is that each
>>> of them seems to have gaps.  As an example, take timerfds
>>> (timerfd_create(2)):
>>>
>>>    * these do not get opened through a file system path, so the *file
>>>      path* can not restrict them.
>>
>>>    * they are not character or block devices and do not have a device ID.
>>>    * they don't match any of the file types in filp->f_mode.
>>
>> Indeed, we may need a way to identify this kind of FD in the future but it
>> should not be an issue for now with the path_beneath rules. I guess we could
>> match the anon_inode:[*] name, but I would prefer to avoid using strings. A
>> better way to identify this kind of FD would be to pass a similar one in a
>> rule, in the same way as for path_beneath (as I suggested in a previous
>> email).
> 
> (In retrospect, the timerfd was a bad example, because it is acquired
> through something else than open(2).  I don't currently have an
> immediate example at hand for an anon_inode which is reachable through
> the file system (except /proc/.../fd).)
> 
> Agreed that matching the "anon_inode:*" name would be a hack.  That
> does not look like it was meant as a reliable interface.
> 
> This discussion seems like it belongs to step (2) and later though, so
> wouldn't block the first patch set, I think.

Yes :)

> 
> 
>>> So in order to permit the TFD_IOC_SET_TICKS ioctl on them, these three
>>> criteria can't be used to describe a timerfd.
>>
>> Correct, and timerfd don't give access to (FS-related) data.
>>
>> If we want to restrict this kind of FD (and if it's worth it), we can follow
>> the same approach as for restricting new socket creation. Restricting
>> specific IOCTLs on these FDs would require a capability-based approach (cf.
>> Capsicum): explicitly attach restrictions to a FD, not a process, and the
>> mechanism is almost there thanks to the truncate access right patches. It
>> would make sense for Landlock to support this kind of FD capabilities, but
>> maybe not right now.
> 
> +1 let's discuss in a follow-up patch set.
> 
> 
>>> For completeness: I forgot to list here: The other reason where a
>>> check during ioctl() is needed is the case as for the timerfd, the
>>> pipe(2) and socketpair(2), where a file is created through a simple
>>> syscall, but without spelling out a path.  If these kinds of files are
>>> in scope for ioctl protection, it can't be done during the open()
>>> check alone, I suspect?
>>
>> Correct, but we don't need this kind of restriction for now.
> 
> OK
> 
> 
>>>> As I explained before, I don't think we should care about inherited or
>>>> passed FDs. Other ways to get FDs (e.g. landlock_create_ruleset) should
>>>> probably not be a priority for now.
>>>
>>> I don't know what we should do about the "basic Unix tool" and
>>> TIOCSTI/TIOCLINUX case, where it is possible to gain control over the
>>> shell running in the tty that we get as stdout fd.
>>>
>>> I'm in that situation with the little web application I run at home,
>>> but the patch that you have sent for GNU tar at some point (and which
>>> we should really revive :)) has the same problem: If an attacker
>>> manages to do a Remote Code Execution in that tar process, they can
>>> ioctl(1, TIOCSTI, ...) their way out into the shell which invoked tar,
>>> and which is not restricted with tar's Landlock policy.
>>>
>>> (I don't really see tar create a pty/tty pair either and shovel data
>>> between them in a sidecar process or thread, just to protect against
>>> that.)
>>
>> Indeed, and that's why sandboxing an application might raise some
>> challenges. We should note that a sandboxed application might only be safely
>> used in some cases (e.g. pipe stdio and close other FDs), but I agree that
>> this is not satisfactory for now, and there are still gaps.
> 
> OK, I'll make sure it shows up in the documentation.
> 
> 
>>> Remark: For the specific TIOCSTI problem, I'm seeing a glimmer of
>>> light with this patch set which has appeared in the meantime:
>>> https://lore.kernel.org/all/20230710002645.v565c7xq5iddruse@begin/
>>> (This will still require that distributions flip that Kconfig option
>>> off, but the only(?) known user of TIOCSTI, BRLTTY, would continue
>>> working.)
>>
>> I hope most distros are disabling CONFIG_LEGACY_TIOCSTI, otherwise users
>> should still be able to tweak the related sysctl.
> 
> +1
> 
> 
>>> I would be more comfortable with doing the checks only at open(2) time
>>> if the above patch landed in distributions so that you would need to
>>> have CAP_SYS_ADMIN in order to use TIOCSTI.
>>>
>>> Do you think this is realistic?  If this does not get flipped by
>>> distributions, Landlock would continue to have these TIOCSTI problems
>>> on these platforms (unless its users do the pty/tty pair thing, but
>>> that seems like an unrealistic demand).
>>
>> What if we use an FD to identify an inode with landlock_inode_attr rule? We
>> could have some flag to "pin" the restriction on this specific FD/inode, or
>> only match the device type, or the file type… We need to think a bit more
>> about the implications though.
> 
> This would also be a later step and not be part of step (1).
> 
> The idea of using an FD as an "example" is interesting, but I'm not
> fully sold on it yet.  I need to ponder it more.  Some specific
> points:
> 
> * Creating such FDs might have unwanted side effects, or be
>    disproportionally difficult, when they are just created for the
>    purpose of defining a Landlock ruleset.
> 
> * The matching is unclear to me.  In particular, we've discussed
>    before to restrict dev_t ranges (fixed major, range on minor) - I
>    don't know how that would be done with this approach.

Those are valid concerns, but yes, let's get back to this discussion 
after the first step. :)


> 
> 
>>>   I don't see how
>>> specifying the file type and device ID range as plain numbers could
>>> lead to a race condition.
>>
>> No race condition but side channel issues. For instance, a landlocked
>> process could infer some file properties by adding and testing a Landlock
>> rule even if it is not allowed to read such file properties (because of
>> potential Landlock or other restrictions). Using a FD enables Landlock to
>> check that the process is indeed allowed to read such properties, or we may
>> decide that it is not necessary to do so.
> 
> Understood - so IIUC the scenario is that a process is not permitted
> to read file attributes, but it'll be able to infer the device ID by
> defining a dev_t-based Landlock rule and then observing whether ioctl
> still works.

Right. I think it should be possible to still check if this kind of file 
attribute would be allowed to be read by the process, when performing 
the IOCTL on it. We need to think about the implications, and if it's 
worth it.

It would be interesting to see if there are similar cover channels with 
other Linux interfaces.


> 
> (I'll also postpone it to step (2) or later then)
> 
> 
>>> If yes, I do agree that a list of permitted ioctls is similar to the
>>> access rights flags that we already have, and it would have to get
>>> passed around in a similar fashion (as "synthetic access rights"),
>>> albeit using a different data structure.
>>>
>>> I'm still skeptical of the API approach where we tie previously
>>> unrelated rules together, if that is what you mean here.  I find this
>>> difficult to explain and reason about.  But in doubt we'll see in the
>>> implementation how unwieldy it actually gets.
>>
>> Right, we don't need to implement the synthetic access rights with the
>> current step though.
> 
> +1 OK
> 
>>
>>>
>>>
>>>>> The upside of that approach would be that it could also be used to selectively
>>>>> restrict specific known-evil ioctls, and letting all others continue to work.
>>>>> For example, sandboxing or sudo-like programs could filter out TIOCSTI and
>>>>> TIOCLINUX.
>>>
>>> By the way, selectively restricting known-bad ioctls is still not
>>> possible with the approach we discussed now, I think.  Maybe TIOCSTI
>>> is the only bad one... I hope.
>>
>> It would not be possible with the landlock_path_beneath_attr, but the
>> landlock_inode_attr could be enough.
> 
> Will ponder it -- it has the limitation as I said above that it can't
> restrict device ranges, but it could be used to apply restrictions to
> specific opened inodes.
> 
> One difference I see with this approach is that the rights would not
> transfer along with the opened file when the files get passed between
> processes.  So the policy for that inode would apply to the enforcing
> process and its new children, but it would not apply to other
> processes which the file is given to.

Good point. We need to come up with something consistent.

> 
> 
> ---
> 
> Summarizing this, I believe that the parts that we need for step (1)
> are the following ones:
> 
> (1) Identify and blanket-permit a small list of ioctl cmds which work
>      on all file descriptors (FIOCLEX, FIONCLEX, FIONBIO, FIOASYNC, and
>      others?)
> 
>      Compare
>      https://lore.kernel.org/linux-security-module/6dfc0198-9010-7c54-2699-d3b867249850@digikod.net/
> 
> (2) Split into LANDLOCK_ACCESS_FS_IOCTL into a ..._DEV and a ..._NODEV part.

I'm a bit annoyed that this access rights mix action and object property 
and I'm worried that this might be a pain for future FS-related rule 
types (e.g. reusing all/most ACCESS_FS rights).

At first glance, a cleaner way would be to add a file_type field to 
landlock_path_beneath_attr (i.e. a subset of the landlock_inode_attr) 
but that would make struct landlock_rule and landlock_layer too complex, 
so not a good approach.

Unless someone has a better idea, let's stick to your first proposal and 
only implement LANDLOCK_ACCESS_FS_IOCTL (with the FIOCLEX-like 
exceptions). We should clearly explain that IOCTLs should be allowed for 
non-device file hierarchies: containing regular/data file (e.g. /home 
with the fscrypt use case), pipe, socket…

I'm still trying to convince myself which approach is the best, but for 
now the simplest one wins.

> 
> (3) Point out in documentation that this IOCTL restriction scheme only
>      applies to newly opened FDs and in particular point out the common
>      use case where that is a TTY, and what to do in this case.
> 
> If you agree, I'd go ahead and implement that as step (1) and we can
> discuss the more advanced ideas in the context of a follow-up.

Sounds good!

> 
> Thanks,
> —Günther
> 
