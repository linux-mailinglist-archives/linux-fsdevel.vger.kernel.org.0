Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF13B584FC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 13:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiG2L6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 07:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiG2L6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:58:24 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC50187F52
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 04:58:21 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LvQyL3Vf0zMqPRv;
        Fri, 29 Jul 2022 13:58:18 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4LvQyL0XFJzlq6Mv;
        Fri, 29 Jul 2022 13:58:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1659095898;
        bh=CsI5Svm/rgvYVqv6A6gv4agjS5R+C2dOfunzOYx5hO0=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=UN/8F/QnPv2hyHVHpTcv+AXImbZ3k+JzFEf/rfmGOOF0wTcI8oW58zDpPXofoo/+7
         qGB4M7X9VPM15cOul6HyoQGRxa6Q//VlL79WUgo/F8ptll41EKNUlXCYg61fJYmFIj
         wRSEP70AfMFR3EyOibgPAqWjhKLQmIQZ0eaLSNzI=
Message-ID: <b7ee2d01-2e33-bf9c-3b56-b649e2fde0fb@digikod.net>
Date:   Fri, 29 Jul 2022 13:58:17 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
References: <20220707200612.132705-1-gnoack3000@gmail.com>
 <dbb0cd04-72a8-b014-b442-a85075314464@digikod.net> <YsqihF0387fBeiVa@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH 0/2] landlock: truncate(2) support
In-Reply-To: <YsqihF0387fBeiVa@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/07/2022 11:57, Günther Noack wrote:
> Hello Mickaël!
> 
> Thank you for the fast feedback! I'm looking into your comments from
> this mail and the rest of the thread and am working on an updated
> patch set.
> 
> On Fri, Jul 08, 2022 at 01:16:29PM +0200, Mickaël Salaün wrote:
>> Hi Günther, this looks good!
>>
>> Added linux-fsdevel@vger.kernel.org
>>
>> On 07/07/2022 22:06, Günther Noack wrote:
>>> The goal of these patches is to work towards a more complete coverage
>>> of file system operations that are restrictable with Landlock.
>>>
>>> The known set of currently unsupported file system operations in
>>> Landlock is described at [1]. Out of the operations listed there,
>>> truncate is the only one that modifies file contents, so these patches
>>> should make it possible to prevent the direct modification of file
>>> contents with Landlock.
>>>
>>> The patch introduces the truncate(2) restriction feature as an
>>> additional bit in the access_mask_t bitmap, in line with the existing
>>> supported operations.
>>>
>>> Apart from Landlock, the truncate(2) and ftruncate(2) family of system
>>> calls can also be restricted using seccomp-bpf, but it is a
>>> complicated mechanism (requires BPF, requires keeping up-to-date
>>> syscall lists) and it also is not configurable by file hierarchy, as
>>> Landlock is. The simplicity and flexibility of the Landlock approach
>>> makes it worthwhile adding.
>>>
>>> I am aware that the documentation and samples/landlock/sandboxer.c
>>> tool still need corresponding updates; I'm hoping to get some early
>>> feedback this way.
>> Yes, that's a good approach.
>>
>> Extending the sandboxer should be straightforward, you can just extend the
>> scope of LL_FS_RW, taking into account the system Landlock ABI because there
>> is no "contract" for this sample.
> 
> Sounds good, I'll extend the sample tool like this for the updated patch set.
> 
> (On the side, as you know from the discussion on the go-landlock
> library, I have some suspicion that the "best effort"
> backwards-compatibility approach in the sample tool is not the right
> one for the "refer" right, but that might be better suited for a
> separate patch. Maybe it'll be simpler to just not support a
> best-effort downgrade in the sample tool.)

Please share your though about the "refer" right.


> 
>> You'll need to remove the warning about truncate(2) in the documentation,
>> and maybe to move it to the "previous limitations" section, with the
>> LANDLOCK_ACCESS_TRUNCATE doc pointing to it. I think it would be nice to
>> extend the LANDLOCK_ACCESS_FS_WRITE documentation to point to
>> LANDLOCK_ACCESS_FS_TRUNCATE because this distinction could be disturbing for
>> users. Indeed, all inode-based LSMs (SELinux and Smack) deny such action if
>> the inode is not writable (with the inode_permission check), which is not
>> the case for path-based LSMs (AppArmor and Tomoyo).
> 
> This makes a lot of sense, I'll work on the documentation to point this out.
> 
> I suspect that for many common use cases, the
> LANDLOCK_ACCESS_FS_TRUNCATE right will anyway only be used together
> with LANDLOCK_ACCESS_FS_FILE_WRITE in practice. (See below for more
> detail.)

Agree


> 
>> While we may question whether a dedicated access right should be added for
>> the Landlock use case, two arguments are in favor of this approach:
>> - For compatibility reasons, the kernel must follow the semantic of a
>> specific Landlock ABI, otherwise it could break user space. We could still
>> backport this patch and merge it with the ABI 1 and treat it as a bug, but
>> the initial version of Landlock was meant to be an MVP, hence this lack of
>> access right.
>> - There is a specific access right for Capsicum (CAP_FTRUNCATE) that could
>> makes more sense in the future.
>>
>> Following the Capsicum semantic, I think it would be a good idea to also
>> check for the O_TRUNC open flag:
>> https://www.freebsd.org/cgi/man.cgi?query=rights
> 
> open() with O_TRUNC was indeed a case I had not thought about - thanks
> for pointing it out.
> 
> I started adding some tests for it, and found to my surprise that
> open() *is* already checking security_path_truncate() when it is
> truncating files. So there is a chance that we can get away without a
> special check for O_TRUNC in the security_file_open hook.
> 
> The exact semantics might be slightly different to Capsicum though -
> in particular, the creat() call (= open with O_TRUNC|O_CREAT|O_WRONLY)
> will require the Landlock truncate right when it's overwriting an
> existing regular file, but it will not require the Landlock truncate
> right when it's creating a new file.

Is the creat() check really different from what is done by Capsicum?


> 
> I'm not fully sure how this is done in Capsicum. I assume that the
> Comparison with Capsicum is mostly for inspiration, but there is no
> goal of being fully compatible with that model?

I think Landlock has all the technical requirements to implement a 
Capsicum-like on Linux: unprivileged access control (which implies 
scoped access control, policies composition, only new restrictions, 
nesting, dedicated syscalls…). The main difference with the actual 
Landlock sandboxing would be that restrictions would apply to all 
processes doing actions on a specific kind of file descriptor (i.e. 
capability). Instead of checking the current thread's domain, Landlock 
could check the "file descriptor's domain". We're definitely not there 
yet but let's keep this in mind. ;)


> 
> The creat() behaviour is non-intuitive from userspace, I think:
> creat() is a pretty common way to create new files, and it might come
> as a surprise to people that this can require the truncate right,
> because:
> 
> - The function creat() doesn't have "truncate" in its name, and you
>    might be tempted to think that the LANDLOCK_ACCESS_FS_MAKE_REG is
>    sufficient for calling it.
> 
> - Users can work around the need for the truncate right by unlinking
>    the existing regular file with the same name and creating a new one.
>    So for the most common use case (where users do not care about the
>    file's inode identity or race conditions), it is surprising that
>    the truncate right is required.

These are useful information to put in the documentation. Explaining why 
it is required should help users. From my point of view, the logic 
behind is that replacing a file modifies its content (i.e. shrink it to 
zero), while unlinking a file doesn't change its content but makes it 
unreachable (removes it) from a directory (and it might not be deleted 
if linked elsewhere).


> 
> Summarizing this, I also think that the truncate right needs to be a
> separate flag, even if just for backwards compatibility reasons.
> 
> But at the same time, I suspect that in practice, the truncate right
> will probably have to usually go together with the file_write right,
> so that the very common creat() use case (and possibly others) does
> not yield surprising behaviour.

Agree. User space libraries might (and probably should) have a different 
interface than the raw syscalls. The Landlock syscalls are meant to 
provide a flexible interface for different use cases. We should keep in 
mind that the goal of libraries is to help developers. ;)
