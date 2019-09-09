Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0441AAD74F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 12:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbfIIKyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 06:54:20 -0400
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:53148 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbfIIKyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:54:20 -0400
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id 68FEDD00069;
        Mon,  9 Sep 2019 12:54:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1568026458;
        bh=lsE8Nf8H8eP9Ra9FaOYEExhywlR7G0uudTTjxz1hvFc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=bsPrfe3facITGSy7DMYPy8YYzwh1VjblL+C13Jn98z/Ykyq4WF4HusFGQluS1lRBd
         QYYlffK04WUyhAEq8eXB0G3SbxesMMAAm5maeRLiYC+OGgwGm/UFnzGlEJmS5yTjgv
         eDWHr12JCE7LIy1AnpTqixcRdqDzgwzq7JGzTrSFVJXeir6LdPgy/jMps6OeNW1+Ba
         aChlFqI2Rwdfl7KYY82HfNbR9YLCc/r3WdWUMbTIopvQs4RYI2ecpdxUeyJYeoZrak
         hYdIFTmBcuxxlC16cK/J4YqCEyLJQ1AbFThzUt7fkCISGm2XqYe9FM8OenXBMO8HEi
         fKi53bdY2BZXA==
Subject: Re: [PATCH v2 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
To:     James Morris <jmorris@namei.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        <linux-kernel@vger.kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
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
 <alpine.LRH.2.21.1909090309260.27895@namei.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <073cb831-7c6b-1882-9b7d-eb810a2ef955@ssi.gouv.fr>
Date:   Mon, 9 Sep 2019 12:54:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1909090309260.27895@namei.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 09/09/2019 12:12, James Morris wrote:
> On Mon, 9 Sep 2019, Micka=C3=ABl Sala=C3=BCn wrote:
>
>>
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
>>
>> Does it means that unspecified behaviors are definitely part of the
>> Linux specification and can't be fixed?
>
> This is my understanding.
>
>>
>> As I said, O_MAYEXEC should be ignored if it is not supported by the
>> kernel, which perfectly fit with the current open(2) flags behavior, and
>> should also behave the same with openat2(2).
>
> The problem here is programs which are already using the value of
> O_MAYEXEC, which will break.  Hence, openat2(2).

Well, it still depends on the sysctl, which doesn't enforce anything by
default, hence doesn't break existing behavior, and this unused flags
could be fixed/removed or reported by sysadmins or distro developers.


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
