Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D07AD583
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 11:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfIIJSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 05:18:16 -0400
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:58304 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbfIIJSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:18:16 -0400
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id 15011D0006E;
        Mon,  9 Sep 2019 11:18:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1568020694;
        bh=Hd8aFaGZ8LQBGcIwXmzG1HYsGaSeWSLgJ8EpAZuMJ3A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=iyZXFpZInIRGwmVAB22SLi6P+EoYbTo+dknvcERPzmCgHTyKGims0Y/Obn6CWg9N4
         VBmU5dot5M8iovNNL18I4AaOWtrnmKcPIVp7Yt8k1lvVFfr+CmYeOQnQ/OuBH2NAB+
         dH+A973s1mw+qVQ4VC/s/D6O2cwwpBf0AcGEX/P8si6kBidDZIkqqgLLUDOZ4eVrQk
         kJbtssZZGlI9nW+ACQrAw0zXBuvVhmHHg62LeLbkRiOkbQzEYjQ1r1N0k0HZBot/DB
         UbgddKG1L5STCziS4dmUnIQJQddzuUMLmI7puYWdU45MkbqYCvbh3QXrka0+6fjJXo
         gMkCeV2jBj2mw==
Subject: Re: [PATCH v2 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
To:     Andy Lutomirski <luto@amacapital.net>,
        Jeff Layton <jlayton@kernel.org>
CC:     Florian Weimer <fweimer@redhat.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        <linux-kernel@vger.kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        <kernel-hardening@lists.openwall.com>, <linux-api@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190906152455.22757-1-mic@digikod.net>
 <20190906152455.22757-2-mic@digikod.net>
 <87ef0te7v3.fsf@oldenburg2.str.redhat.com>
 <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr>
 <f53ec45fd253e96d1c8d0ea6f9cca7f68afa51e3.camel@kernel.org>
 <1fbf54f6-7597-3633-a76c-11c4b2481add@ssi.gouv.fr>
 <5a59b309f9d0603d8481a483e16b5d12ecb77540.camel@kernel.org>
 <D1212E06-773B-42B9-B7C3-C4C1C2A6111D@amacapital.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <9e43ca3f-04c0-adba-1ab4-bbc8ed487934@ssi.gouv.fr>
Date:   Mon, 9 Sep 2019 11:18:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <D1212E06-773B-42B9-B7C3-C4C1C2A6111D@amacapital.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 06/09/2019 20:41, Andy Lutomirski wrote:
>
>
>> On Sep 6, 2019, at 11:38 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>
>>> On Fri, 2019-09-06 at 19:14 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
>>>> On 06/09/2019 18:48, Jeff Layton wrote:
>>>>> On Fri, 2019-09-06 at 18:06 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
>>>>>> On 06/09/2019 17:56, Florian Weimer wrote:
>>>>>> Let's assume I want to add support for this to the glibc dynamic loa=
der,
>>>>>> while still being able to run on older kernels.
>>>>>>
>>>>>> Is it safe to try the open call first, with O_MAYEXEC, and if that f=
ails
>>>>>> with EINVAL, try again without O_MAYEXEC?
>>>>>
>>>>> The kernel ignore unknown open(2) flags, so yes, it is safe even for
>>>>> older kernel to use O_MAYEXEC.
>>>>>
>>>>
>>>> Well...maybe. What about existing programs that are sending down bogus
>>>> open flags? Once you turn this on, they may break...or provide a way t=
o
>>>> circumvent the protections this gives.
>>>
>>> Well, I don't think we should nor could care about bogus programs that
>>> do not conform to the Linux ABI.
>>>
>>
>> But they do conform. The ABI is just undefined here. Unknown flags are
>> ignored so we never really know if $random_program may be setting them.
>>
>>>> Maybe this should be a new flag that is only usable in the new openat2=
()
>>>> syscall that's still under discussion? That syscall will enforce that
>>>> all flags are recognized. You presumably wouldn't need the sysctl if y=
ou
>>>> went that route too.
>>>
>>> Here is a thread about a new syscall:
>>> https://lore.kernel.org/lkml/1544699060.6703.11.camel@linux.ibm.com/
>>>
>>> I don't think it fit well with auditing nor integrity. Moreover using
>>> the current open(2) behavior of ignoring unknown flags fit well with th=
e
>>> usage of O_MAYEXEC (because it is only a hint to the kernel about the
>>> use of the *opened* file).
>>>
>>
>> The fact that open and openat didn't vet unknown flags is really a bug.
>>
>> Too late to fix it now, of course, and as Aleksa points out, we've
>> worked around that in the past. Now though, we have a new openat2
>> syscall on the horizon. There's little need to continue these sorts of
>> hacks.
>>
>> New open flags really have no place in the old syscalls, IMO.
>>
>>>> Anyone that wants to use this will have to recompile anyway. If the
>>>> kernel doesn't support openat2 or if the flag is rejected then you kno=
w
>>>> that you have no O_MAYEXEC support and can decide what to do.
>>>
>>> If we want to enforce a security policy, we need to either be the syste=
m
>>> administrator or the distro developer. If a distro ship interpreters
>>> using this flag, we don't need to recompile anything, but we need to be
>>> able to control the enforcement according to the mount point
>>> configuration (or an advanced MAC, or an IMA config). I don't see why a=
n
>>> userspace process should check if this flag is supported or not, it
>>> should simply use it, and the sysadmin will enable an enforcement if it
>>> makes sense for the whole system.
>>>
>>
>> A userland program may need to do other risk mitigation if it sets
>> O_MAYEXEC and the kernel doesn't recognize it.
>>
>> Personally, here's what I'd suggest:
>>
>> - Base this on top of the openat2 set
>> - Change it that so that openat2() files are non-executable by default. =
Anyone wanting to do that needs to set O_MAYEXEC or upgrade the fd somehow.
>> - Only have the openat2 syscall pay attention to O_MAYEXEC. Let open and=
 openat continue ignoring the new flag.
>>
>> That works around a whole pile of potential ABI headaches. Note that
>> we'd need to make that decision before the openat2 patches are merged.
>>
>> Even better would be to declare the new flag in some openat2-only flag
>> space, so there's no confusion about it being supported by legacy open
>> calls.
>>
>> If glibc wants to implement an open -> openat2 wrapper in userland
>> later, it can set that flag in the wrapper implicitly to emulate the old
>> behavior.
>>
>> Given that you're going to have to recompile software to take advantage
>> of this anyway, what's the benefit to changing legacy syscalls?
>>
>>>>>> Or do I risk disabling this security feature if I do that?
>>>>>
>>>>> It is only a security feature if the kernel support it, otherwise it =
is
>>>>> a no-op.
>>>>>
>>>>
>>>> With a security feature, I think we really want userland to aware of
>>>> whether it works.
>>>
>>> If userland would like to enforce something, it can already do it
>>> without any kernel modification. The goal of the O_MAYEXEC flag is to
>>> enable the kernel, hence sysadmins or system designers, to enforce a
>>> global security policy that makes sense.
>>>
>>
>> I don't see how this helps anything if you can't tell whether the kernel
>> recognizes the damned thing. Also, our track record with global sysctl
>> switches like this is pretty poor. They're an administrative headache as
>> well as a potential attack vector.
>
> I tend to agree. The sysctl seems like it=E2=80=99s asking for trouble. I=
 can see an ld.so.conf option to turn this thing off making sense.

The sysctl is required to enable the adoption of this flag without
breaking existing systems. Current systems may have "noexec" on mount
points containing scripts. Without giving the ability to the sysadmin to
control that behavior, updating to a newer version of an interpreter
using O_MAYEXEC may break such systems.

How would you do this with ld.so.conf ?


--
Micka=C3=ABl Sala=C3=BCn

Les donn=C3=A9es =C3=A0 caract=C3=A8re personnel recueillies et trait=C3=A9=
es dans le cadre de cet =C3=A9change, le sont =C3=A0 seule fin d=E2=80=99ex=
=C3=A9cution d=E2=80=99une relation professionnelle et s=E2=80=99op=C3=A8re=
nt dans cette seule finalit=C3=A9 et pour la dur=C3=A9e n=C3=A9cessaire =C3=
=A0 cette relation. Si vous souhaitez faire usage de vos droits de consulta=
tion, de rectification et de suppression de vos donn=C3=A9es, veuillez cont=
acter contact.rgpd@sgdsn.gouv.fr. Si vous avez re=C3=A7u ce message par err=
eur, nous vous remercions d=E2=80=99en informer l=E2=80=99exp=C3=A9diteur e=
t de d=C3=A9truire le message. The personal data collected and processed du=
ring this exchange aims solely at completing a business relationship and is=
 limited to the necessary duration of that relationship. If you wish to use=
 your rights of consultation, rectification and deletion of your data, plea=
se contact: contact.rgpd@sgdsn.gouv.fr. If you have received this message i=
n error, we thank you for informing the sender and destroying the message.
