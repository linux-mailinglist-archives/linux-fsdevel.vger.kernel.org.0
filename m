Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BC8ABEB0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 19:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406061AbfIFRYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 13:24:30 -0400
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:54986 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbfIFRY3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:24:29 -0400
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id 96E93D0007D;
        Fri,  6 Sep 2019 19:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1567790667;
        bh=KJUuECIANqpK6TruuSChflkPQxJqxFhMngqPuIjpheg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=sbpxnjcUU1rtFVaIRuPkdkOxATfyY/Uuz9hBbitRqUg2lVqhrqGbOJpx02hf+klvN
         lipJTmGLxWXJjfdA9E+9OX5GuyYNFdgOFtw8HQtPxFJWbgCcS8OnqQWYreCRK7Ex4l
         y8S5jKXHQ2fxJr/QfhDuHJTiBRubESRjpTOhRkr9MQY9npRBSgO2UTTVKkbHbi+DYn
         k+anbqV9S//kmngzANIoe2fnFS4Bz9LaLeRvsQWZcLIFChC+1BVQ41w4dvDME/hJUI
         /PgjsbUDqxTgb3bAG7/Psis5hSOMHi4lDb3Un2k/tvw6xVbk5TTDcBxsJwb39kegw0
         iqZZAYov54cpA==
Subject: Re: [PATCH v2 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
CC:     Florian Weimer <fweimer@redhat.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        <linux-kernel@vger.kernel.org>,
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
 <20190906170739.kk3opr2phidb7ilb@yavin.dot.cyphar.com>
 <20190906172050.v44f43psd6qc6awi@wittgenstein>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <062c25e2-1996-c32c-46a1-aa831d69930f@ssi.gouv.fr>
Date:   Fri, 6 Sep 2019 19:24:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20190906172050.v44f43psd6qc6awi@wittgenstein>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 06/09/2019 19:20, Christian Brauner wrote:
> On Sat, Sep 07, 2019 at 03:07:39AM +1000, Aleksa Sarai wrote:
>> On 2019-09-06, Micka=C3=ABl Sala=C3=BCn <mickael.salaun@ssi.gouv.fr> wro=
te:
>>>
>>> On 06/09/2019 17:56, Florian Weimer wrote:
>>>> Let's assume I want to add support for this to the glibc dynamic loade=
r,
>>>> while still being able to run on older kernels.
>>>>
>>>> Is it safe to try the open call first, with O_MAYEXEC, and if that fai=
ls
>>>> with EINVAL, try again without O_MAYEXEC?
>>>
>>> The kernel ignore unknown open(2) flags, so yes, it is safe even for
>>> older kernel to use O_MAYEXEC.
>>
>> Depends on your definition of "safe" -- a security feature that you will
>> silently not enable on older kernels doesn't sound super safe to me.
>> Unfortunately this is a limitation of open(2) that we cannot change --
>> which is why the openat2(2) proposal I've been posting gives -EINVAL for
>> unknown O_* flags.
>>
>> There is a way to probe for support (though unpleasant), by creating a
>> test O_MAYEXEC fd and then checking if the flag is present in
>> /proc/self/fdinfo/$n.
>
> Which Florian said they can't do for various reasons.
>
> It is a major painpoint if there's no easy way for userspace to probe
> for support. Especially if it's security related which usually means
> that you want to know whether this feature works or not.

I used "safe" deliberately (not "secure" which didn't make sense in this
sentence). According to the threat model, if the kernel doesn't support
the feature, it should be ignored by userland. In this case, it fit well
with the current behavior of open(2). I agree that the openat2(2)
behavior handling flags is the good way to do it (whitelisting), but the
O_MAYEXEC flag should not change the userland behavior on its own,
because it depend on a global policy. Even being able to probe for
O_MAYEXEC support does not make sense because it would not be enough to
know the system policy (either this flag is enforced or not=E2=80=A6).

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
