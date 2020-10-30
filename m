Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1982A05A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 13:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgJ3Mlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 08:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgJ3Mld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:41:33 -0400
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A312C0613D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 05:41:33 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CN24C353wzlhbLm;
        Fri, 30 Oct 2020 13:41:31 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CN2494vmzzlh8TR;
        Fri, 30 Oct 2020 13:41:29 +0100 (CET)
Subject: Re: [PATCH v22 08/12] landlock: Add syscall implementations
To:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20201027200358.557003-1-mic@digikod.net>
 <20201027200358.557003-9-mic@digikod.net>
 <CAG48ez1San538w=+He309vHg4pBSCvAf7e5xeHdqeOHA6qwitw@mail.gmail.com>
 <de287149-ff42-40ca-5bd1-f48969880a06@digikod.net>
 <CAG48ez1FQVkt78129WozBwFbVhAPyAr9oJAHFHAbbNxEBr9h1g@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <163f298b-b492-fee0-b475-102ae8170419@digikod.net>
Date:   Fri, 30 Oct 2020 13:41:29 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez1FQVkt78129WozBwFbVhAPyAr9oJAHFHAbbNxEBr9h1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 30/10/2020 04:07, Jann Horn wrote:
> On Thu, Oct 29, 2020 at 12:30 PM Mickaël Salaün <mic@digikod.net> wrote:
>> On 29/10/2020 02:06, Jann Horn wrote:
>>> On Tue, Oct 27, 2020 at 9:04 PM Mickaël Salaün <mic@digikod.net> wrote:
>>>> These 3 system calls are designed to be used by unprivileged processes
>>>> to sandbox themselves:
> [...]
>>>> +       /*
>>>> +        * Similar checks as for seccomp(2), except that an -EPERM may be
>>>> +        * returned.
>>>> +        */
>>>> +       if (!task_no_new_privs(current)) {
>>>> +               err = security_capable(current_cred(), current_user_ns(),
>>>> +                               CAP_SYS_ADMIN, CAP_OPT_NOAUDIT);
>>>
>>> I think this should be ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN)?
>>
>> Right. The main difference is that ns_capable*() set PF_SUPERPRIV in
>> current->flags. I guess seccomp should use ns_capable_noaudit() as well?
> 
> Yeah. That seccomp code is from commit e2cfabdfd0756, with commit date
> in April 2012, while ns_capable_noaudit() was introduced in commit
> 98f368e9e263, with commit date in June 2016; the seccomp code predates
> the availability of that API.
> 
> Do you want to send a patch to Kees for that, or should I?
> 

I found another case of this inconsistency in ptrace. I sent patches:
https://lore.kernel.org/lkml/20201030123849.770769-1-mic@digikod.net/
