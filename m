Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6D4DC57B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 13:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiCQMGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 08:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiCQMGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:06:38 -0400
X-Greylist: delayed 12565 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 05:05:21 PDT
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D13B1A6E67
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 05:05:20 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KK5SH2RZ2zMqNN2;
        Thu, 17 Mar 2022 13:05:19 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KK5SG3DNhzlhSMF;
        Thu, 17 Mar 2022 13:05:18 +0100 (CET)
Message-ID: <ebf1f65c-c0eb-c818-e3e4-46ad9292bdec@digikod.net>
Date:   Thu, 17 Mar 2022 13:06:02 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20220221212522.320243-1-mic@digikod.net>
 <20220221212522.320243-10-mic@digikod.net>
 <CAHC9VhSmz1ga5NTu=vG3+Z+gxD8C+-W+k5UweUROe2p4BfjSTg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1 09/11] landlock: Document LANDLOCK_ACCESS_FS_REFER and
 ABI versioning
In-Reply-To: <CAHC9VhSmz1ga5NTu=vG3+Z+gxD8C+-W+k5UweUROe2p4BfjSTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 17/03/2022 02:27, Paul Moore wrote:
> On Mon, Feb 21, 2022 at 4:15 PM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> Add LANDLOCK_ACCESS_FS_REFER in the example and properly check to only
>> use it if the current kernel support it thanks to the Landlock ABI
>> version.
>>
>> Move the file renaming and linking limitation to a new "Previous
>> limitations" section.
>>
>> Improve documentation about the backward and forward compatibility,
>> including the rational for ruleset's handled_access_fs.
>>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20220221212522.320243-10-mic@digikod.net
>> ---
>>   Documentation/userspace-api/landlock.rst | 124 +++++++++++++++++++----
>>   1 file changed, 104 insertions(+), 20 deletions(-)
> 
> Thanks for remembering to update the docs :)  I made a few phrasing
> suggestions below, but otherwise it looks good to me.

Thanks Paul! I'll take them.


> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>
> 
>> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
>> index f35552ff19ba..97db09d36a5c 100644
>> --- a/Documentation/userspace-api/landlock.rst
>> +++ b/Documentation/userspace-api/landlock.rst
>> @@ -281,6 +347,24 @@ Memory usage
>>   Kernel memory allocated to create rulesets is accounted and can be restricted
>>   by the Documentation/admin-guide/cgroup-v1/memory.rst.
>>
>> +Previous limitations
>> +====================
>> +
>> +File renaming and linking (ABI 1)
>> +---------------------------------
>> +
>> +Because Landlock targets unprivileged access controls, it is needed to properly
>                                                            ^^^^^
>                                             "... controls, it needs to ..."
> 
>> +handle composition of rules.  Such property also implies rules nesting.
>> +Properly handling multiple layers of ruleset, each one of them able to restrict
>                                          ^^^^^^^
>                                        "rulesets,"
> 
>> +access to files, also implies to inherit the ruleset restrictions from a parent
>                                   ^^^^^^^^^^
>                      "... implies inheritance of the ..."
> 
>> +to its hierarchy.  Because files are identified and restricted by their
>> +hierarchy, moving or linking a file from one directory to another implies to
>> +propagate the hierarchy constraints.
> 
> "... one directory to another implies propagation of the hierarchy constraints."
> 
>> +                                     To protect against privilege escalations
> 
>> +through renaming or linking, and for the sake of simplicity, Landlock previously
>> +limited linking and renaming to the same directory.  Starting with the Landlock
>> +ABI version 2, it is now possible to securely control renaming and linking
>> +thanks to the new `LANDLOCK_ACCESS_FS_REFER` access right.
> 
> --
> paul-moore.com
