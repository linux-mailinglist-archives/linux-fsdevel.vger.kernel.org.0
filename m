Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430B9AD912
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 14:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfIIMdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 08:33:55 -0400
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:53117 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfIIMdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:33:55 -0400
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id 1BC33D00071;
        Mon,  9 Sep 2019 14:33:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1568032433;
        bh=2i3c2h85LfgWysBXkgaRfA1GieIicnUeTJmX6tbk8zM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=DIA1Z3Zu3HCxstRjX0+tueSAj80lWxY1sAKxeq+efi6dSgyroVTJV8OH6MRAeufM2
         jFE4bHUfovw/uhK0wdDYgP2+dhwRTY6lYUL+c4KPWD5O2xWX9gYCW8B+9ZeaQscNh+
         iNgmxt2dbyBbJNWSYe3IeWpG9WChnuJn7iTXN2D5pqdOiwVahCkEkHfsbElRiYoEbR
         7Pj1qPpKDIsa7HrTYf99kTTDALyksUu+nUQbc2yA/VCMkfJf0vVKqFFu1ivBw6yyfc
         fxvQ1UAQ/LLpN5GSOEppLqdYvl7B1vMAuA5Fc4d8ZFb2PLhIdHUywDuJuj/giF4giW
         C85NYH4BN6ojQ==
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
References: <20190906152455.22757-2-mic@digikod.net>
 <87ef0te7v3.fsf@oldenburg2.str.redhat.com>
 <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr>
 <f53ec45fd253e96d1c8d0ea6f9cca7f68afa51e3.camel@kernel.org>
 <1fbf54f6-7597-3633-a76c-11c4b2481add@ssi.gouv.fr>
 <5a59b309f9d0603d8481a483e16b5d12ecb77540.camel@kernel.org>
 <alpine.LRH.2.21.1909061202070.18660@namei.org>
 <49e98ece-e85f-3006-159b-2e04ba67019e@ssi.gouv.fr>
 <alpine.LRH.2.21.1909090309260.27895@namei.org>
 <073cb831-7c6b-1882-9b7d-eb810a2ef955@ssi.gouv.fr>
 <20190909122802.imfx6wp4zeroktuz@yavin>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <045db737-107f-d06a-04ea-fdd0758de062@ssi.gouv.fr>
Date:   Mon, 9 Sep 2019 14:33:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20190909122802.imfx6wp4zeroktuz@yavin>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 09/09/2019 14:28, Aleksa Sarai wrote:
> On 2019-09-09, Micka=EBl Sala=FCn <mickael.salaun@ssi.gouv.fr> wrote:
>> On 09/09/2019 12:12, James Morris wrote:
>>> On Mon, 9 Sep 2019, Micka=EBl Sala=FCn wrote:
>>>> As I said, O_MAYEXEC should be ignored if it is not supported by the
>>>> kernel, which perfectly fit with the current open(2) flags behavior, a=
nd
>>>> should also behave the same with openat2(2).
>>>
>>> The problem here is programs which are already using the value of
>>> O_MAYEXEC, which will break.  Hence, openat2(2).
>>
>> Well, it still depends on the sysctl, which doesn't enforce anything by
>> default, hence doesn't break existing behavior, and this unused flags
>> could be fixed/removed or reported by sysadmins or distro developers.
>
> Okay, but then this means that new programs which really want to enforce
> O_MAYEXEC (and know that they really do want this feature) won't be able
> to unless an admin has set the relevant sysctl. Not to mention that the
> old-kernel fallback will not cover the "it's disabled by the sysctl"
> case -- so the fallback handling would need to be:
>
>     int fd =3D open("foo", O_MAYEXEC|O_RDONLY);
>     if (!(fcntl(fd, F_GETFL) & O_MAYEXEC))
>         fallback();
>     if (!sysctl_feature_is_enabled)
>         fallback();
>
> However, there is still a race here -- if an administrator enables
> O_MAYEXEC after the program gets the fd, then you still won't hit the
> fallback (and you can't tell that O_MAYEXEC checks weren't done).

I just replied to this concern here:
https://lore.kernel.org/lkml/70e4244e-4dfb-6e67-416b-445e383aa1b5@ssi.gouv.=
fr/

>
> You could fix the issue with the sysctl by clearing O_MAYEXEC from
> f_flags if the sysctl is disabled. You could also avoid some of the
> problems with it being a global setting by making it a prctl(2) which
> processes can opt-in to (though this has its own major problems).

Security definition and enforcement should be manageable by sysadmins
and distro developers.

>
> Sorry, but I'm just really not a fan of this.

I guess there is some misunderstanding. I just replied to another thread
and I think it should answer your concerns (especially about the PDP and
PEP):
https://lore.kernel.org/lkml/70e4244e-4dfb-6e67-416b-445e383aa1b5@ssi.gouv.=
fr/


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
