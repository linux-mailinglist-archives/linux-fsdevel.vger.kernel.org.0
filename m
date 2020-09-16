Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D91D26C901
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 21:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgIPTBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgIPRsu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:48:50 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B302AC008680
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 06:43:42 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Bs1Vt66Xxzlhp2Z;
        Wed, 16 Sep 2020 15:42:30 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Bs1Vr3lT6zlh8TV;
        Wed, 16 Sep 2020 15:42:28 +0200 (CEST)
Subject: Re: [PATCH v20 05/12] LSM: Infrastructure management of the
 superblock
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>
References: <20200802215903.91936-1-mic@digikod.net>
 <20200802215903.91936-6-mic@digikod.net>
 <779c290b-45f5-b86c-c573-2edb4004105d@tycho.nsa.gov>
 <03f522c0-414c-434b-a0d1-57c3b17fa67f@digikod.net>
 <CAEjxPJ7POnxKy=5w-iQkKhjftxf2-=UuvA6D8EmhUPJyS1F6qg@mail.gmail.com>
 <CAEjxPJ7ARJO57MBW66=xsBzMMRb=9uLgqocK5eskHCaiVMx7Vw@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <49fa967e-d60f-bd52-6fe3-c04fe56e20f6@digikod.net>
Date:   Wed, 16 Sep 2020 15:42:28 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7ARJO57MBW66=xsBzMMRb=9uLgqocK5eskHCaiVMx7Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 04/09/2020 16:06, Stephen Smalley wrote:
> On Thu, Aug 13, 2020 at 2:39 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> On Thu, Aug 13, 2020 at 10:17 AM Mickaël Salaün <mic@digikod.net> wrote:
>>>
>>>
>>> On 12/08/2020 21:16, Stephen Smalley wrote:
>>>> On 8/2/20 5:58 PM, Mickaël Salaün wrote:
>>>>> From: Casey Schaufler <casey@schaufler-ca.com>
>>>>>
>>>>> Move management of the superblock->sb_security blob out
>>>>> of the individual security modules and into the security
>>>>> infrastructure. Instead of allocating the blobs from within
>>>>> the modules the modules tell the infrastructure how much
>>>>> space is required, and the space is allocated there.
>>>>>
>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>>>>> Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>> Reviewed-by: Mickaël Salaün <mic@digikod.net>
>>>>> Link:
>>>>> https://lore.kernel.org/r/20190829232935.7099-2-casey@schaufler-ca.com
>>>>> ---
>>>>>
>>>>> Changes since v17:
>>>>> * Rebase the original LSM stacking patch from v5.3 to v5.7: I fixed some
>>>>>    diff conflicts caused by code moves and function renames in
>>>>>    selinux/include/objsec.h and selinux/hooks.c .  I checked that it
>>>>>    builds but I didn't test the changes for SELinux nor SMACK.
>>>>
>>>> You shouldn't retain Signed-off-by and Reviewed-by lines from an earlier
>>>> patch if you made non-trivial changes to it (even more so if you didn't
>>>> test them).
>>>
>>> I think I made trivial changes according to the original patch. But
>>> without reply from other people with Signed-off-by or Reviewed-by
>>> (Casey, Kees, John), I'll remove them. I guess you don't want your
>>> Reviewed-by to be kept, so I'll remove it, except if you want to review
>>> this patch (or the modified part).
>>
>> At the very least your Reviewed-by line is wrong - yours should be
>> Signed-off-by because the patch went through you and you modified it.
>> I'll try to take a look as time permits but FYI you should this
>> address (already updated in MAINTAINERS) going forward.
> 
> I finally got around to reviewing your updated patch.  You can drop
> the old line and add:
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> 

Thanks! I'll send a new series soon.
