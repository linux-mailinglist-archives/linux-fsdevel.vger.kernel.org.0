Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A5BAD903
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfIIM3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 08:29:02 -0400
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:59863 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfIIM3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:29:01 -0400
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id 5F3D1D0006E;
        Mon,  9 Sep 2019 14:28:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1568032139;
        bh=XQS2EF2mnNbqj/DprgGZgt8u1Qnlm766iQGzVJeqMHU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=q3oVKRlrjwqa7gzDcI+Y/JWOteC1KCYyr7kMJ8cHo7vayol0DaSgezX6jfJgD1Odz
         MC+dLFooSZ4dELBV3NlZPovcCxpSft1PVM2sGbSZNjz72e/518jgyEZHkQiKIoD7B2
         vatimaDPPbt/XQchF7Tc5UpgKX2+Fm21Ul7A6rKNG+sSEoB3IUELmkCllInlNrnh1+
         mpOYELY1zaXJFTZjEeOqh2RXxIIO83yVg9LfUA8YtKAi/njhOvo3nNgAIS9Je6Z2yW
         a1vSkCsRUSKlguBpnkZAMzpT/3C58vqLB7b0ejjs+rljlbf+XNS5huUF0LMFFToJNq
         eyD0rq6cvG2jA==
Subject: Re: [PATCH v2 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
To:     Aleksa Sarai <cyphar@cyphar.com>
CC:     James Morris <jmorris@namei.org>, Jeff Layton <jlayton@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>, Jan Kara <jack@suse.cz>,
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
 <alpine.LRH.2.21.1909061202070.18660@namei.org>
 <49e98ece-e85f-3006-159b-2e04ba67019e@ssi.gouv.fr>
 <20190909115437.jwpyslcdhhvzo7g5@yavin>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <fa592f31-3fbf-d0da-d31a-d14a89488219@ssi.gouv.fr>
Date:   Mon, 9 Sep 2019 14:28:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20190909115437.jwpyslcdhhvzo7g5@yavin>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 09/09/2019 13:54, Aleksa Sarai wrote:
> On 2019-09-09, Micka=EBl Sala=FCn <mickael.salaun@ssi.gouv.fr> wrote:
>> On 06/09/2019 21:03, James Morris wrote:
>>> On Fri, 6 Sep 2019, Jeff Layton wrote:
>>>
>>>> The fact that open and openat didn't vet unknown flags is really a bug=
.
>>>>
>>>> Too late to fix it now, of course, and as Aleksa points out, we've
>>>> worked around that in the past. Now though, we have a new openat2
>>>> syscall on the horizon. There's little need to continue these sorts of
>>>> hacks.
>>>>
>>>> New open flags really have no place in the old syscalls, IMO.
>>>
>>> Agree here. It's unfortunate but a reality and Linus will reject any su=
ch
>>> changes which break existing userspace.
>>
>> Do you mean that adding new flags to open(2) is not possible?
>
> It is possible, as long as there is no case where a program that works
> today (and passes garbage to the unused bits in flags) works with the
> change.
>
> O_TMPFILE was okay because it's actually two flags (one is O_DIRECTORY)
> and no working program does file IO to a directory (there are also some
> other tricky things done there, I'll admit I don't fully understand it).
>
> O_EMPTYPATH works because it's a no-op with non-empty path strings, and
> empty path strings have always given an error (so no working program
> does it today).
>
> However, O_MAYEXEC will result in programs that pass garbage bits to
> potentially get -EACCES that worked previously.
>
>> As I said, O_MAYEXEC should be ignored if it is not supported by the
>> kernel, which perfectly fit with the current open(2) flags behavior, and
>> should also behave the same with openat2(2).
>
> NACK on having that behaviour with openat2(2). -EINVAL on unknown flags
> is how all other syscalls work (any new syscall proposed today that
> didn't do that would be rightly rejected), and is a quirk of open(2)
> which unfortunately cannot be fixed. The fact that *every new O_ flag
> needs to work around this problem* should be an indication that this
> interface mis-design should not be allowed to infect any more syscalls.

It's definitely OK (and a sane interface) to always return -EINVAL for
unknown flags with openat2(2) (and other new syscalls). With openat2(2),
userland need to handle the case where some flags may be unknown to the
kernel (and handling the fact that this syscall may be unknown too). So
there is not an issue with openat2(2).

However, *userland* should not try to infer possible security
restrictions from the O_MAYEXEC flag (then, my use of "ignore" above),
which may return -EACCES or not, according to the current running system
security policy.

Following this reasoning, the current behavior or open(2) is fine for
O_MAYEXEC. The openat2(2) strict flag handling (i.e. -EINVAL) is fine
too for O_MAYEXEC.

>
> Note that this point is regardless of the fact that O_MAYEXEC is a
> *security* flag -- if userspace wants to have a secure fallback on
> old kernels (which is "the right thing" to do) they would have to do
> more work than necessary. And programs that don't care don't have to do
> anything special.

Most of the time this reasoning is good for most security stuff.
However, the O_MAYEXEC flag is not a security feature on its own, it is
an indication to the kernel to how this file would be used by userland.
The *kernel* security policy may tell back to userland if the system
security policy allow it or not. Most of the time, Policy Decision
Points (PDP) and Policy Enforcement Points (PEP) are in the same
software component (e.g. the kernel). Here the kernel is the PDP and
userland interpreters are PDP. Obviously, it means that these
interpreters must be (sub)part of your TCB (thanks to other security
features).

>
> However with -EINVAL, the programs doing "the right thing" get an easy
> -EINVAL check. And programs that don't care can just un-set O_MAYEXEC
> and retry. You should be forced to deal with the case where a flag is
> not supported -- and this is doubly true of security flags!

I'm in favor of doing this for openat2(2) with O_MAYEXEC, but it is not
because of the "security purposes" of this flag, as I said above, it is
because it is a saner ABI that every syscall should follow. But again,
it doesn't change my point about open(2). :)


--
Micka=EBl Sala=FCn

Les donn=E9es =E0 caract=E8re personnel recueillies et trait=E9es dans le c=
adre de cet =E9change, le sont =E0 seule fin d=92ex=E9cution d=92une relati=
on professionnelle et s=92op=E8rent dans cette seule finalit=E9 et pour la =
dur=E9e n=E9cessaire =E0 cette relation. Si vous souhaitez faire usage de v=
os droits de consultation, de rectification et de suppression de vos donn=
=E9es, veuillez contacter contact.rgpd@sgdsn.gouv.fr. Si vous avez re=E7u c=
e message par erreur, nous vous remercions d=92en informer l=92exp=E9diteur=
 et de d=E9truire le message. The personal data collected and processed dur=
ing this exchange aims solely at completing a business relationship and is =
limited to the necessary duration of that relationship. If you wish to use =
your rights of consultation, rectification and deletion of your data, pleas=
e contact: contact.rgpd@sgdsn.gouv.fr. If you have received this message in=
 error, we thank you for informing the sender and destroying the message.
