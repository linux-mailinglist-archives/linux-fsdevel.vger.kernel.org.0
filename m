Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDEE5B5F81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 19:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiILRrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiILRrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:47:18 -0400
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [IPv6:2001:1600:3:17::190f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234D91D320
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 10:47:17 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MRDZ94qd7zMqphv;
        Mon, 12 Sep 2022 19:47:13 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MRDZ82VTyz3d;
        Mon, 12 Sep 2022 19:47:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663004833;
        bh=QE7XU4x2GAWq8J4XtCiqJ5pj1Z1e485TxnAQzT2woLQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZfWGpZ5OYti6R2fz4lvz0ehzj7nPfp8o6/XR8dlhnKSz2l8QGaIcCO06057y5fDDn
         Cmlw4RAqv4y1205Zc2L3WfF0rtG8nyMJ2uZ1urtV6h6CwK9ls2TPcWakXhqw3q0jwU
         v7rmmX7XiZKYnoDU+mnETcOEpGd3UFLQhW12ky94=
Message-ID: <b0bdf697-1789-d579-6b6b-a6aca73d4b11@digikod.net>
Date:   Mon, 12 Sep 2022 19:47:11 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v6 5/5] landlock: Document Landlock's file truncation
 support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-6-gnoack3000@gmail.com>
 <2f9c6131-3140-9c47-cf95-f7fa3cf759ee@digikod.net> <Yx9UZocFXQ9TbZnO@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Yx9UZocFXQ9TbZnO@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/09/2022 17:46, Günther Noack wrote:
> On Fri, Sep 09, 2022 at 03:51:35PM +0200, Mickaël Salaün wrote:
>>
>> On 08/09/2022 21:58, Günther Noack wrote:
>>> Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.
>>>
>>> Adapt the backwards compatibility example and discussion to remove the
>>> truncation flag where needed.
>>>
>>> Point out potential surprising behaviour related to truncate.
>>>
>>> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
>>> ---
>>>    Documentation/userspace-api/landlock.rst | 62 +++++++++++++++++++++---
>>>    1 file changed, 54 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
>>> index b8ea59493964..57802fd1e09b 100644
>>> --- a/Documentation/userspace-api/landlock.rst
>>> +++ b/Documentation/userspace-api/landlock.rst
>>> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>>>    =====================================
>>>    :Author: Mickaël Salaün
>>> -:Date: May 2022
>>> +:Date: September 2022
>>>    The goal of Landlock is to enable to restrict ambient rights (e.g. global
>>>    filesystem access) for a set of processes.  Because Landlock is a stackable
>>> @@ -60,7 +60,8 @@ the need to be explicit about the denied-by-default access rights.
>>>                LANDLOCK_ACCESS_FS_MAKE_FIFO |
>>>                LANDLOCK_ACCESS_FS_MAKE_BLOCK |
>>>                LANDLOCK_ACCESS_FS_MAKE_SYM |
>>> -            LANDLOCK_ACCESS_FS_REFER,
>>> +            LANDLOCK_ACCESS_FS_REFER |
>>> +            LANDLOCK_ACCESS_FS_TRUNCATE,
>>>        };
>>>    Because we may not know on which kernel version an application will be
>>> @@ -69,16 +70,26 @@ should try to protect users as much as possible whatever the kernel they are
>>>    using.  To avoid binary enforcement (i.e. either all security features or
>>>    none), we can leverage a dedicated Landlock command to get the current version
>>>    of the Landlock ABI and adapt the handled accesses.  Let's check if we should
>>> -remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
>>> -starting with the second version of the ABI.
>>> +remove the `LANDLOCK_ACCESS_FS_REFER` or `LANDLOCK_ACCESS_FS_TRUNCATE` access
>>> +rights, which are only supported starting with the second and third version of
>>> +the ABI.
>>>    .. code-block:: c
>>>        int abi;
>>>        abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
>>> -    if (abi < 2) {
>>> -        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
>>> +    switch (abi) {
>>> +    case -1:
>>> +            perror("The running kernel does not enable to use Landlock");
>>> +            return 1;
>>> +    case 1:
>>> +            /* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
>>> +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
>>> +            __attribute__((fallthrough));
>>> +    case 2:
>>> +            /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
>>> +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
>>>        }
>>>    This enables to create an inclusive ruleset that will contain our rules.
>>> @@ -127,8 +138,8 @@ descriptor.
>>>    It may also be required to create rules following the same logic as explained
>>>    for the ruleset creation, by filtering access rights according to the Landlock
>>> -ABI version.  In this example, this is not required because
>>> -`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
>>> +ABI version.  In this example, this is not required because all of the requested
>>> +``allowed_access`` rights are already available in ABI 1.
>>
>> This fix is correct, but it should not be part of this series. FYI, I have a
>> patch almost ready to fix some documentation style issues. Please remove
>> this hunk for the next series. I'll deal with the merge conflicts if any.
> 
> Can you please clarify what part of it should not be part of this
> series?

My mistake, I guess I was reviewing something else… I was thinking about 
style changes, but it is not the case here. Using "``" is correct.


> 
> In this hunk, I've started using double backquote, but I've also
> changed the meaning of the sentence slightly so that it is still
> correct when the truncate right is introduced.
> 
> It is still correct that the backwards compatibility check is not
> required because LANDLOCK_ACCESS_FS_REFER is not allowed by any rule.
> But with the new truncate flag, LANDLOCK_ACCESS_FS_TRUNCATE may also
> not be allowed by any rule so that we can skip this check.
> 
> Should I remove this hunk entirely?

Keep your changes, it's better like this.


> 
> Or maybe rather phrase it like
> 
>    It may also be required to create rules following the same logic as
>    explained for the ruleset creation, by filtering access rights
>    according to the Landlock ABI version. In this example, this is not
>    required because `LANDLOCK_ACCESS_FS_REFER` and
>    `LANDLOCK_ACCESS_FS_TRUNCATE` are not allowed by any rule.
>   
> ?
