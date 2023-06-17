Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D629733FFA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbjFQJtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 05:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346143AbjFQJsu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 05:48:50 -0400
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8700268C
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 02:48:43 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qjrng49s2zMq1bX;
        Sat, 17 Jun 2023 09:48:39 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Qjrms47gTzMqCyx;
        Sat, 17 Jun 2023 11:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1686995319;
        bh=+fzW0u0iw3EHZzDovn+F7hHfgOLFj0JO9BHr7r7hFM4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DqUxKUvAubKDssStOx1pi+nPDvFE9tofNQfHfqgkgSUha57CXdKyZJ0uv7okeZtCI
         bPGIQa+OSn3FQjxthlKIIQ7W0Hp2Ttq/eyzRGXlgWdPapIQIgARagUjWPqUZZq8L49
         3IpB1cMzYRzSRKBJknMbO8KfQmaqXhRjCleyVOX4=
Message-ID: <d4f1395c-d2d4-1860-3a02-2a0c023dd761@digikod.net>
Date:   Sat, 17 Jun 2023 11:47:55 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [RFC 0/4] Landlock: ioctl support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Jeff Xu <jeffxu@chromium.org>,
        Dmitry Torokhov <dtor@google.com>
Cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
 <1cb74c81-3c88-6569-5aff-154b8cf626fa@digikod.net>
 <20230510.c667268d844f@gnoack.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230510.c667268d844f@gnoack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This subject is not easy, but I think we're reaching a consensus (see my 
3-steps proposal plan below). I answered your questions about the 
(complex) interface I proposed, but we should focus on the first step 
now (your initial proposal) and get back to the other steps later in 
another email thread.


On 10/05/2023 21:21, Günther Noack wrote:
> Hello Mickaël!
> 
> Sorry for the late reply.  This was indeed a bit difficult for me to
> understand; maybe it just needs more clarification.
> 
> Let me try to paraphrase your proposal (inline below) so we can
> resolve the misunderstandings.
> 
> 
> On Thu, May 04, 2023 at 11:12:00PM +0200, Mickaël Salaün wrote:
>> Thanks for this RFC, this is interesting!
>>
>> I previously thought a lot about IOCTLs restrictions and here are some
>> notes:
>>
>> IOCTLs are everywhere, from devices to filesystems (see fscrypt). Each
>> different file type may behave differently for the same IOCTL command/ID. It
>> is also worth noting that there are a lot of different IOCTLs, they are
>> growing over time, some might be dedicated to get some data (i.e. read) and
>> others to change the state of a device (i.e. write), some might be innocuous
>> (e.g. FIOCLEX, FIONCLEX) and others potentially harmful. _IOC_READ and
>> _IOC_WRITE can be useful but they are not mandatory, there are exceptions,
>> and it may be difficult to identify if a command pertains to one, the other,
>> or both kind of actions.
>>
>> I then think it would be very useful to be able to tie file/device types to
>> a set of IOCTLs, letting user space libraries define and classify the IOCTL
>> semantic.
>>
>> Instead of relying on a LANDLOCK_ACCESS_FS_IOCTL which would allow or deny
>> all IOCTLs, we can extend the path_beneath struct to manage IOCTLs in
>> addition to regular file accesses. Because dealing with a set of IOCTLs
>> would imply to deal with a lot of data and combinations, I thought about
>> creating groups of IOCTLs (defining access semantic) that could be matched
>> against file hierarchies. The composability nature of Landlock domains is
>> also another constraint to keep in mind.
>>
>> // New rule type dedicated to define groups of IOCTLs.
>> struct landlock_ioctl_attr {
>>    __u32 command; // IOCTL number/ID
>>    dev_t device; // must be 0 for regular file and directory
>>    __u8 file_type;
>>    __u8 id_mask; // if 0, then applied globally
>> };
>>
>> We could use landlock_add_rule(2) to fill a set of landlock_ioctl_attr into
>> a ruleset and use them with landlock_path_beneath_attr entries:
>>
>> // LANDLOCK_RULE_PATH_BENEATH, leveraging the extensible design of
>> // landlock_path_beneath_attr, hence the same first fields.
>> struct landlock_path_beneath_attr {
>>    __u64 allowed_access;
>>    __s32 parent_fd;
>>    __u16 allowed_ioctl_id_mask;
>> };
>>
>> landlock_ioctl_attr includes a 8-bit mask for which each bit identifies a
>> set of allowed IOCTLs per device/file type. This mask is then tied to a
>> path_beneath_attr. We cannot use number IDs because of dev_t+IOCTL->ID
>> intersection conflicts. Using an id_mask enables to group (specific) IOCTLs
>> together, then creating synthetic access rights.
>>
>> When merging a ruleset with a domain, each IOCTL ID mask is shifted and ORed
>> with the other layer ones to get a (8*16) 128-bit mask, stored in an
>> IOCTL/dev_t table and in the related landlock_object. When looking for an
>> IOCTL request, Landlock first looks into the IOCTL set ID table and get the
>> global set ID mask, which kind of translates to a composition of synthetic
>> access rights (stored with the landlock_layer.ioctl_access bitmask). We then
>> walk through all the inodes to match the whole mask.
>>
>> I realize that this is complex and this explanation might be confusing
>> though. What do you think?
> 
> To be honest, I am not fully sure I understand the landlock_ioctl_attr
> struct correctly.
> 
> My current guess is:
> 
>    command:   a single ioctl request number that should be permitted
> 
>    device:    if device != 0; require the dev_t (major+minor number)
>               of the file to match, before permitting the ioctl
> 
>    file_type: if set (!= 0?), require the file type to match,
>               before permitting the ioctl
> 
>    id_mask:   Indicates the IDs of the groups where this ioctl
>               should be permitted(?)
> 
> So -- if we were to implement this without any optimizations -- the
> logic of this is presumably something like this?:
> 
>    If Landlock checks an ioctl with a request_id on a file f:
> 
>    We look up the allowed_ioctl_id_mask and loop over the bits set in
>    that mask.
> 
>    For every bit set in that mask, we look up the matching ioctl group.
>    Within the group, we look whether we can find a landlock_ioctl_attr
>    rule that belongs to the group which permits that ioctl request.
> 
>    The request is granted by a landlock_ioctl_attr if:
> 
>      attr.command == request_id
>      && (attr.device == 0 || file_inode(file).i_rdev == attr.device)
>      && (attr.file_type == 0 || landlock_get_file_type?(file))
> 
> Is this roughly what you imagined?

Yes :)

> 
> 
> Some specific things I don't understand well are:
> 
> * How does id_mask identify the ioctl group?  Do you envision an
>    interface where you can add a landlock_ioctl_attr to multiple groups
>    at once?

id_mask would be an arbitrary value picked by the user (library). I was 
thinking about a bitmask (for allowed_ioctl_id_mask) because different 
ioctl_attr could overlap (e.g., for different file hierarchy).

> 
>    When the added landlock_ioctl_attr has id_mask=3, does it add that
>    attr to group 2 and 1?

No, it assigns this IOCTL attribute to the group 3, which can then be 
matched against with allowed_ioctl_id_mask & (1 << 2).

> 
> * How does allowed_ioctl_id_mask match against the ioctl group IDs
>    (id_mask)?  I'm particularly confused because the
>    allowed_ioctl_id_mask is __u16, whereas id_mask is __u8?  Is this
>    intentional?

The idea was to assign each ioctl_attr to one group (ID) but enable to 
match several groups with path_beneath_attr (allowed_ioctl_id_mask being 
the only bitmask, whereas id_mask is a number). Yes, the naming is 
confusing…

> 
> * What is file_type?  Are those the file types as used in mknod(2),
>    so that you can distinguish between regular files, directories,
>    named pipes and the like?

Yes

> 
> * If I understand the proposal right, the .device and .file_type in
>    landlock_ioctl_attr are narrowing down the set of files that the
>    ioctl policy applies to.  In all rules up until Landlock v3, which
>    we already have, the selection of the files which the rule applies
>    to is purely done based on file hierarchy.
> 
>    Would it not be a more orthogonal API if the "file selection" part
>    of the Landlock API and the "policy adding" part for these selected
>    files were independent of each other?  Then the .device and
>    .file_type selection scheme could be used for the existing policies
>    as well?

Both approaches have pros and cons. I propose a new incremental approach 
below that starts with the simple case where there is no direct links 
between different rule types (only the third step add that).

> 
> * When restricting by dev_t (major and minor number), aren't there use
>    cases where a system might have 256 CDROM drives, and you'd need to
>    allow-list all of these minor number combinations?

Indeed, we should be able to just ignore device minors.

> 
> * Aren't many ioctl use cases already usable with just the proposal I
>    made?  If you add a rule to permit IOCTL for /dev/cdrom0, that
>    opened file will anyway only expose a small subset of the ioctls
>    that the kernel as a whole offers, no?  Are there ioctls which are
>    offered independent of the file type which I'm overlooking? (Sorry,
>    this might be a naive question. :))

This is correct until users allow IOCTL for a directory (e.g. /etc). It 
depends on use cases though.

> 
> 
>> On 02/05/2023 19:17, Günther Noack wrote:
>>> Alternatives considered: Allow-listing specific ioctl requests
>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> It would be technically possible to keep an allow-list of ioctl
>>> requests and thereby control in more detail which ioctls should work.
>>>
>>> I believe that this is not needed for the majority of use cases and
>>> that it is a reasonable trade-off to make here (but I'm happy to hear
>>> about counterexamples).  The reasoning is:
>>>
>>> * Many programs do not need ioctl at all,
>>>     and denying all ioctl(2) requests OK for these.
>>>
>>> * Other programs need ioctl, but only for the terminal FDs.
>>>     This is supported because these file descriptors are usually
>>>     inherited from the parent process - so the parent process gets to
>>>     control the ioctl(2) policy for them.
>>>
>>> * Some programs need ioctl on specific files that they are opening
>>>     themselves.  They can allow-list these file paths for ioctl(2).
>>>     This makes the programs work, but it restricts a variety of other
>>>     ioctl requests which are otherwise possible through opening other
>>>     files.
>>>
>>> Because the LANDLOCK_ACCESS_FS_IOCTL right is attached to the file
>>> descriptor, programs have flexible options to control which ioctl
>>> operations should work, without the implementation complexity of
>>> additional ioctl allow-lists in the kernel.
>>>
>>> Finally, the proposed approach is simpler in implementation and has
>>> lower API complexity, but it does *not* preclude us from implementing
>>> per-ioctl-request allow lists later, if that turns out to be necessary
>>> at a later point.
>>
>> I value this simplicity, but I'm also wondering about how much this
>> allow/deny all IOCTLs approach would be useful in real case scenarios. ;)
> 
> Mickaël, would you be open to gather some more data for this from
> existing users, to understand better which use cases they have?

Of course, thanks!

I'm trying to project myself as an app developer, a sysadmin and a 
desktop user. I know some sandboxed softwares, I sandboxed some, and I'm 
looking into new ones. The main issue I see is (from the sysadmin and 
user POV) when we want to manage a whole file hierarchy, which may 
contain different file/device types.


> 
> (Looking in the direction of Jeff Xu, who has inquired about Landlock
> for Chromium in the past -- do you happen to know in which ways you'd
> want to restrict ioctls, if you have that need? :))
> 
> 
>>> Related Work
>>> ~~~~~~~~~~~~
>>>
>>> OpenBSD's pledge(2) [1] restricts ioctl(2) independent of the file
>>> descriptor which is used.  The implementers maintain multiple
>>> allow-lists of predefined ioctl(2) operations required for different
>>> application domains such as "audio", "bpf", "tty" and "inet".
>>>
>>> OpenBSD does not guarantee ABI backwards compatibility to the same
>>> extent as Linux does, so it's easier for them to update these lists in
>>> later versions.  It might not be a feasible approach for Linux though.
>>>
>>> [1] https://man.openbsd.org/OpenBSD-7.3/pledge.2
>>>
>>> Feedback I'm looking for
>>> ~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Some specific points I would like to get your opinion on:
>>>
>>> * Is this the right general approach to restricting ioctl(2)?
>>>
>>>     It will probably be possible to find counter-examples where the
>>>     alternative (see below) is better.  I'd be interested in these, and
>>>     in how common they are, to understand whether we have picked the
>>>     right trade-off here.
>>
>> In the long term, I'd like Landlock to be able to restrict a set of IOCTLs,
>> taking into account the type of file/device. Being able to deny all IOCTLs
>> might be useful and is much easier to implement though.
> 
> In my mind, it's a trade-off between implementation complexity and
> flexibility.
> 
> My proposal is more simple-minded than what you explained, but might
> solve the bulk of real-life use cases for a lower implementation
> complexity. (With the caveat that I don't understand the real life use
> cases well enough to know how far it really gets us, that's why this
> is just an RFC.)
> 
> I'm not *just* saying this because I'm lazy ;), but I also feel that
> we should be careful with the amount of complexity that we take on,
> especially if there is a chance that it won't be needed in practice.

I agree :)

> 
> I think that it might be a feasible approach to start with the
> LANDLOCK_ACCESS_FS_IOCTL approach and then look at its usage to
> understand whether we see a significant number of programs whose
> sandboxes are too coarse because of this.
> 
> If more fine-granular control is needed, we can still put the other
> approach on top, and the additional complexity from
> LANDLOCK_ACCESS_FS_IOCTL that we have to support is not that
> dramatically high.
> 
> If more fine-granular control is not needed, we can skip the
> implementation of the other approach and Landlock is simpler.
> 
> Then again, I'm somewhat new to kernel development still, I'm not sure
> whether this is an approach that is deemed acceptable in this setting?

I agree that IOCTLs are a security risk and that we should propose a 
simple solution short-term, and maybe a more complete one long-term.

The main issue with a unique IOCTL access right for a file hierarchy is 
that we may not know which device/driver will be the target/server, and 
hence if we need to allow some IOCTL for regular files (e.g., fscrypt), 
we might end up allowing all IOCTLs.

Here is a plan to incrementally develop a fine-grained IOCTL access 
control in 3 steps:

1/ Add a simple IOCTL access right for path_beneath: what you initially 
proposed. For systems that already configure nodev mount points, it 
could be even more useful (e.g., safely allow IOCTL on /home for 
fscrypt, and specific /dev files otherwise).


2/ Create a new type of rule to identify file/device type:
struct landlock_inode_type_attr {
     __u64 allowed_access; /* same as for path_beneath */
     __u64 flags; /* bit 0: ignores device minor */
     dev_t device; /* same as stat's st_rdev */
     __u16 file_type; /* same as stat's st_mode & S_IFMT */
};

We'll probably need to differentiate the handled accesses for 
path_beneath rules and those for inode_type rules to be more useful.

One issue with this type of rule is that it could be used as an oracle 
to bypass stat restrictions. We could check if such (virtual) action is 
allowed without the current domain though.


3/ Add a new type of rule to match IOCTL commands, with a mechanism to 
tie this to inode_type rules (because a command ID is relative to a file 
type/device), and potentially the same mechanism to tie inode_type rules 
to path_beneath rules.


Each of this step can be implemented one after the other, and each one 
is valuable. What do you think?


> 
> 
>>> * Should we introduce a "landlock_fd_rights_limit()" syscall?
>>>
>>>     We could potentially implement a system call for dropping the
>>>     LANDLOCK_ACCESS_FS_IOCTL and LANDLOCK_ACCESS_FS_TRUNCATE rights from
>>>     existing file descriptors (independent of the type of file
>>>     descriptor, even).
>>>
>>>     Possible use cases would be to (a) restrict the rights on inherited
>>>     file descriptors like std{in,out,err} and to (b) restrict ioctl and
>>>     truncate operations on file descriptors that are not acquired
>>>     through open(2), such as network sockets.
>>>
>>>     This would be similar to the cap_rights_limit(2) system call in
>>>     FreeBSD's Capsicum.
>>>
>>>     This idea feels somewhat orthogonal to the ioctl patch, but it would
>>>     start to be more useful if the ioctl right exists.
>>
>> This is indeed interesting, and that should be useful for the cases you
>> explained. I think supporting IOCTLs is more important for now, but a new
>> syscall to restrict FDs could be useful in the future.
> 
> Ack, OK.  I agree, it's not that urgent yet.
> 
> 
>> We should also think about batch operations on FD (see the
>> close_range syscall), for instance to deny all IOCTLs on inherited
>> or received FDs.
> 
> Hm, you mean a landlock_fd_rights_limit_range() syscall to limit the
> rights for an entire range of FDs?
> 
> I have to admit, I'm not familiar with the real-life use cases of
> close_range().  In most programs I work with, it's difficult to reason
> about their ordering once the program has really started to run. So I
> imagine that close_range() is mostly used to "sanitize" the open file
> descriptors at the start of main(), and you have a similar use case in
> mind for this one as well?
> 
> If it's just about closing the range from 0 to 2, I'm not sure it's
> worth adding a custom syscall. :)

The advantage of this kind of range is to efficiently manage all 
potential FDs, and the main use case is to close (or change, see the 
flags) everything *except" 0-2 (i.e. 3-~0), and then avoid a lot of 
(potentially useless) syscalls.

The Landlock interface doesn't need to be a syscall. We could just add a 
new rule type which could take a FD range and restrict them when calling 
landlock_restrict_self(). Something like this:
struct landlock_fd_attr {
     __u64 allowed_access;
     __u32 first;
     __u32 last;
}

> 
> Thanks for the review!
> –Günther
