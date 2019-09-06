Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09B4ABE70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 19:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395153AbfIFROR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 13:14:17 -0400
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:50125 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731344AbfIFROR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:14:17 -0400
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id 3E026D0007F;
        Fri,  6 Sep 2019 19:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1567790055;
        bh=cLdOiE54zKyAjOHLoAwzZPgDyl0aVvM/gUvpCeq4S7g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=FxaYGxPomU3H6XZ3g9gaFaWPW3F6a/Yn38emhmc3YLQXr9bsQzK0Jfo88sUl0z/il
         HS7+Z7kORFesl0y4ZjpYo5aaKLoMZ/OIJWz1iuqDcjAM8XkR8luHMLNgkLcDPsbRHG
         OSo6l4mrrCUaiEJvRgJxuQqbw7n4xVxKZLmhP/H+47q48e7OyIDCMNkWdIhAOulvWP
         t9mk7IK8G3/E71JHC2cXmRAlYuOkcQeZJWRpB9RqMeF7dSARiOHT/iO1+VKaYUl2xR
         KElwe8V2DtWOWSx4NqUbBZsPxOIwPTmta+EHU/8O3rlPzuE6Ey3Ak9yTlS0TJabKWK
         CZm8Tw6ByN6hw==
Subject: Re: [PATCH v2 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
To:     Jeff Layton <jlayton@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
CC:     <linux-kernel@vger.kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <1fbf54f6-7597-3633-a76c-11c4b2481add@ssi.gouv.fr>
Date:   Fri, 6 Sep 2019 19:14:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <f53ec45fd253e96d1c8d0ea6f9cca7f68afa51e3.camel@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 06/09/2019 18:48, Jeff Layton wrote:
> On Fri, 2019-09-06 at 18:06 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
>> On 06/09/2019 17:56, Florian Weimer wrote:
>>> Let's assume I want to add support for this to the glibc dynamic loader=
,
>>> while still being able to run on older kernels.
>>>
>>> Is it safe to try the open call first, with O_MAYEXEC, and if that fail=
s
>>> with EINVAL, try again without O_MAYEXEC?
>>
>> The kernel ignore unknown open(2) flags, so yes, it is safe even for
>> older kernel to use O_MAYEXEC.
>>
>
> Well...maybe. What about existing programs that are sending down bogus
> open flags? Once you turn this on, they may break...or provide a way to
> circumvent the protections this gives.

Well, I don't think we should nor could care about bogus programs that
do not conform to the Linux ABI.

>
> Maybe this should be a new flag that is only usable in the new openat2()
> syscall that's still under discussion? That syscall will enforce that
> all flags are recognized. You presumably wouldn't need the sysctl if you
> went that route too.

Here is a thread about a new syscall:
https://lore.kernel.org/lkml/1544699060.6703.11.camel@linux.ibm.com/

I don't think it fit well with auditing nor integrity. Moreover using
the current open(2) behavior of ignoring unknown flags fit well with the
usage of O_MAYEXEC (because it is only a hint to the kernel about the
use of the *opened* file).

>
> Anyone that wants to use this will have to recompile anyway. If the
> kernel doesn't support openat2 or if the flag is rejected then you know
> that you have no O_MAYEXEC support and can decide what to do.

If we want to enforce a security policy, we need to either be the system
administrator or the distro developer. If a distro ship interpreters
using this flag, we don't need to recompile anything, but we need to be
able to control the enforcement according to the mount point
configuration (or an advanced MAC, or an IMA config). I don't see why an
userspace process should check if this flag is supported or not, it
should simply use it, and the sysadmin will enable an enforcement if it
makes sense for the whole system.

>
>>> Or do I risk disabling this security feature if I do that?
>>
>> It is only a security feature if the kernel support it, otherwise it is
>> a no-op.
>>
>
> With a security feature, I think we really want userland to aware of
> whether it works.

If userland would like to enforce something, it can already do it
without any kernel modification. The goal of the O_MAYEXEC flag is to
enable the kernel, hence sysadmins or system designers, to enforce a
global security policy that makes sense.

>
>>> Do we need a different way for recognizing kernel support.  (Note that
>>> we cannot probe paths in /proc for various reasons.)
>>
>> There is no need to probe for kernel support.
>>
>>> Thanks,
>>> Florian
>>>
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
