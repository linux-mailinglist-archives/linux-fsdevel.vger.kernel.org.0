Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2531D735D9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 20:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjFSS5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 14:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjFSS5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:57:46 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439E918C
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 11:57:45 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QlJtG08ZMzMpntG;
        Mon, 19 Jun 2023 18:57:42 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4QlJtD520mz36c;
        Mon, 19 Jun 2023 20:57:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1687201061;
        bh=6QprCwOiuHLtLfPngXg7d3MqCSM+0TlN0JsN6TcOnAM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IcDXZoA92zU+W6X+vB+dukIM8g8PA36XmHBE4zybxUSk3OlskE42kPNO354nbA9AV
         sZWPzUeqnWcWCqveJsgBG4nv9l74M9XGIpfuT22rY6Y9USZC3mqXInQfU+U2gYGsea
         ClU0z470M6/CaDftUye/nlVBAGxENGal0OzfhMcs=
Message-ID: <f6f4779d-3fb1-d9b2-d3c3-ebdc0d58e85d@digikod.net>
Date:   Mon, 19 Jun 2023 20:57:40 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [RFC 0/4] Landlock: ioctl support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>
Cc:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Jeff Xu <jeffxu@chromium.org>,
        Dmitry Torokhov <dtor@google.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
 <1cb74c81-3c88-6569-5aff-154b8cf626fa@digikod.net>
 <20230510.c667268d844f@gnoack.org>
 <d4f1395c-d2d4-1860-3a02-2a0c023dd761@digikod.net>
 <ZJCAbvA5WB+P1jjZ@google.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <ZJCAbvA5WB+P1jjZ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/06/2023 18:21, Günther Noack wrote:
> Hello Mickaël!
> 
> On Sat, Jun 17, 2023 at 11:47:55AM +0200, Mickaël Salaün wrote:
>> This subject is not easy, but I think we're reaching a consensus (see my
>> 3-steps proposal plan below). I answered your questions about the (complex)
>> interface I proposed, but we should focus on the first step now (your
>> initial proposal) and get back to the other steps later in another email
>> thread.
> 
> Thanks for the review!
> 
> 
>> On 10/05/2023 21:21, Günther Noack wrote:
>>> [...]
>>> Some specific things I don't understand well are:
>>> [...]
> 
> Thanks, this all make sense now. 👍
> 
> 
>>>     Would it not be a more orthogonal API if the "file selection" part
>>>     of the Landlock API and the "policy adding" part for these selected
>>>     files were independent of each other?  Then the .device and
>>>     .file_type selection scheme could be used for the existing policies
>>>     as well?
>>
>> Both approaches have pros and cons. I propose a new incremental approach
>> below that starts with the simple case where there is no direct links
>> between different rule types (only the third step add that).
>>
>>>
>>> * When restricting by dev_t (major and minor number), aren't there use
>>>     cases where a system might have 256 CDROM drives, and you'd need to
>>>     allow-list all of these minor number combinations?
>>
>> Indeed, we should be able to just ignore device minors.
> 
> They device numbers are listed in
> https://www.kernel.org/doc/Documentation/admin-guide/devices.txt
> 
> Some major numbers are grab-bags of miscellaneous devices, for example
> major numbers 10 and 13; 13/0-31 (maj/min) are joysticks, whereas
> 13/32-62) are mice.
> 
> Maybe this can be specified as ranges on dev_t, so that it would be
> possible to specify 13/32-62, without matching the joysticks too?

Indeed, being able to specifying a range would be useful. I'm not sure 
about the whole dev_t range or only a minor range though. From a 
semantic POV, there is no links between majors.

> 
> 
>>> I think that it might be a feasible approach to start with the
>>> LANDLOCK_ACCESS_FS_IOCTL approach and then look at its usage to
>>> understand whether we see a significant number of programs whose
>>> sandboxes are too coarse because of this.
>>>
>>> If more fine-granular control is needed, we can still put the other
>>> approach on top, and the additional complexity from
>>> LANDLOCK_ACCESS_FS_IOCTL that we have to support is not that
>>> dramatically high.
>>>
>>> [...]
>>
>> I agree that IOCTLs are a security risk and that we should propose a simple
>> solution short-term, and maybe a more complete one long-term.
>>
>> The main issue with a unique IOCTL access right for a file hierarchy is that
>> we may not know which device/driver will be the target/server, and hence if
>> we need to allow some IOCTL for regular files (e.g., fscrypt), we might end
>> up allowing all IOCTLs.
>>
>> Here is a plan to incrementally develop a fine-grained IOCTL access control
>> in 3 steps:
>>
>> 1/ Add a simple IOCTL access right for path_beneath: what you initially
>> proposed. For systems that already configure nodev mount points, it could be
>> even more useful (e.g., safely allow IOCTL on /home for fscrypt, and
>> specific /dev files otherwise).
> 
> Ack, I'll continue on that implementation then. 👍
> 
> 
>> 2/ Create a new type of rule to identify file/device type:
>> struct landlock_inode_type_attr {
>>      __u64 allowed_access; /* same as for path_beneath */
>>      __u64 flags; /* bit 0: ignores device minor */
>>      dev_t device; /* same as stat's st_rdev */
>>      __u16 file_type; /* same as stat's st_mode & S_IFMT */
>> };
>>
>> We'll probably need to differentiate the handled accesses for path_beneath
>> rules and those for inode_type rules to be more useful.
>>
>> One issue with this type of rule is that it could be used as an oracle to
>> bypass stat restrictions. We could check if such (virtual) action is allowed
>> without the current domain though.
>>
>>
>> 3/ Add a new type of rule to match IOCTL commands, with a mechanism to tie
>> this to inode_type rules (because a command ID is relative to a file
>> type/device), and potentially the same mechanism to tie inode_type rules to
>> path_beneath rules.
>>
>>
>> Each of this step can be implemented one after the other, and each one is
>> valuable. What do you think?
> 
> I think it is a good idea to do it in multiple steps,
> as I also believe that step 1) already provides value on its own.
> 
> To make sure we are on the same page, let me paraphrase my understanding here:
> 
> 1) is what I already sent as RFC, with tests and documentation etc.
> 
>     With 1), callers could allow and deny ioctls on newly opened files,
>     independent of file path.

Yes

> 
> 2) makes dev_t and file_type predicates which can be used to limit
>     file accesses on already opened files.
> 
>     With 2), callers could allow and deny ioctls and other operations
>     also on files which are already opened before enablement, such
>     as the TTY FD inherited from the parent process.

This is not on already opened files, it would be a complementary rule 
type to path_beneath ones: if a rule with dev_t/file_type matches and 
allowed action FOO, and a path_beneath rules matches and also allowed 
action FOO, then FOO is allowed.

However, this could be extended in the future (with a new dedicated 
flag) to also support already-opened files.


>     
> 3) would make it possible to restrict individual ioctl commands,
>     depending on the dev_t, the file_type, and possibly the path.

Yes. I think we could even only extend the "landlock_inode_attr" struct 
to add an ioctl_command field, and potentially others too. I think it 
would make sense because IOCTLs are tied to a specific device/file type 
(or even the underlying filesystem).

In fact, we can split the third step in two:
3/ Extend landlock_inode_attr with ioctl_command.
4/ Define an inode_category field that contain an arbitrary number which 
can be match against a path_beneath rule (with a bitmask to be able to 
match others too).

Other steps could allow to match landlock_inode_attr with FDs, add a 
landlock_fd_range_attr…


> 
> Is that accurate?
> 
> In 2) and 3), I'm still contemplating a bit whether we have
> alternative approaches, but I believe in any case, it's clear that
> they can be built on top of each other without much overhead, and for
> many programs, outright denying ioctl on newly opened files with 1)
> might be the most straightforward approach which already delivers
> value.

Right

> 
> Some notes which I collected on the side:
> 
> * I'm still worried about the already-opened file descriptors like the
>    TTY, through which it can be easy to escape a sandbox
>    (c.f. https://nvd.nist.gov/vuln/detail/CVE-2017-5226) - I would like
>    to have a solution for that.  Step (2) would fix it, but maybe I can
>    find a workaround to at least detect the problem in step (1)
>    already.

Yes, good example, Landlock should be able to help with this issue 
thanks to the third step.


> 
> * I looked at OpenBSD's pledge and unveil.  In OpenBSD, the ioctl
>    policy is based on the properties of an already opened file.  They
>    have hardcoded their ioctl logic in the kernel, which would be a
>    mistake to do in Linux due to stronger backwards compatibility
>    guarantees.  OpenBSD is making the allow/deny decisions based on
>    device major/minor numbers and file type (usually block/char
>    device).
> 
>    I think it is noteworthy that OpenBSD does *not* use the file path
>    to make that decision.

Yes, we could have the same behavior by only using the rule type added 
with the second step, but we could easily improve that by combining a 
path_beneath rule thanks to the third step.


> 
>    I wonder whether we should replicate that in steps (2) and (3).  It
>    would make for a simpler, more orthogonal API, where the ioctl
>    policy would become a property of the task, and it would be enforced
>    independently of the existing path-based logic.  When callers
>    combine that with the overall ioctl check from (1), it might be
>    flexible enough for practical purposes.

Yes, this will be possible with the four steps.


> 
> * We should not rely on the way that ioctl request numbers are
>    structured, because it is used inconsistently.  More background:
>    https://lwn.net/Articles/428140/ (Thank you for pointing out this
>    article, Jeff!)

Definitely, but the user space libraries might help with that. ;)


> 
>>>>> * Should we introduce a "landlock_fd_rights_limit()" syscall?
>>>> [...]
>>>>
>>>> We should also think about batch operations on FD (see the
>>>> close_range syscall), for instance to deny all IOCTLs on inherited
>>>> or received FDs.
>>>
>>> Hm, you mean a landlock_fd_rights_limit_range() syscall to limit the
>>> rights for an entire range of FDs?
>>>
>>> I have to admit, I'm not familiar with the real-life use cases of
>>> close_range().  In most programs I work with, it's difficult to reason
>>> about their ordering once the program has really started to run. So I
>>> imagine that close_range() is mostly used to "sanitize" the open file
>>> descriptors at the start of main(), and you have a similar use case in
>>> mind for this one as well?
>>>
>>> If it's just about closing the range from 0 to 2, I'm not sure it's
>>> worth adding a custom syscall. :)
>>
>> The advantage of this kind of range is to efficiently manage all potential
>> FDs, and the main use case is to close (or change, see the flags) everything
>> *except" 0-2 (i.e. 3-~0), and then avoid a lot of (potentially useless)
>> syscalls.
>>
>> The Landlock interface doesn't need to be a syscall. We could just add a new
>> rule type which could take a FD range and restrict them when calling
>> landlock_restrict_self(). Something like this:
>> struct landlock_fd_attr {
>>      __u64 allowed_access;
>>      __u32 first;
>>      __u32 last;
>> }
> 
> Ack, I see it a bit better. Let's discuss this topic separately.
> 
> —Günther
> 
