Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F9AD55A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 11:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfIIJJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 05:09:29 -0400
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:61989 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfIIJJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:09:29 -0400
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id A3979D0006E;
        Mon,  9 Sep 2019 11:09:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1568020166;
        bh=opIRdxfCnQZ1C3Ck0d+pceeguG9JPIviZMLGs1p3xIM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=NZFLKcutgBubH+cejPYxXCLvDS5m9lg+j7jJPqpaSLtAT72ebm0tH/lyuDKUue33t
         s/tCE82xi2on9sej/TiXEntjcjpGPb9hAQwu2//btq8Nco+nsksah6aY7BoKlMUS6O
         kwAmmUSJCY1Z18Rrp6f8ChFkn3z8BHK5GwtEpmMJJQoZKvjSKXyPebNVC5XaDzri5x
         dpY4IuGS5xq/2tKpaAeo1QfEkPfzfuRIo6RiNOIPJ1oQNjF1xrSTlLYmkltwwgACNz
         kd0FVU04VynwUT2P+8altgQRdWPFR8sPcVBgc0Yz63znw6yMBmhPzSV/cp3wK8UCow
         WWFvVFshIREvA==
Subject: Re: [PATCH v2 0/5] Add support for O_MAYEXEC
To:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>
CC:     Steve Grubb <sgrubb@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
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
        Thibaut S autereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        <kernel-hardening@lists.openwall.com>, <linux-api@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190906152455.22757-1-mic@digikod.net> <2989749.1YmIBkDdQn@x2>
 <87mufhckxv.fsf@oldenburg2.str.redhat.com> <1802966.yheqmZt8Si@x2>
 <C95B704C-F84F-4341-BDE7-CD70C5DDBEEF@amacapital.net>
 <20190906224410.lffd6l5lnm4z3hht@yavin.dot.cyphar.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <70e4244e-4dfb-6e67-416b-445e383aa1b5@ssi.gouv.fr>
Date:   Mon, 9 Sep 2019 11:09:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20190906224410.lffd6l5lnm4z3hht@yavin.dot.cyphar.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 07/09/2019 00:44, Aleksa Sarai wrote:
> On 2019-09-06, Andy Lutomirski <luto@amacapital.net> wrote:
>>> On Sep 6, 2019, at 12:07 PM, Steve Grubb <sgrubb@redhat.com> wrote:
>>>
>>>> On Friday, September 6, 2019 2:57:00 PM EDT Florian Weimer wrote:
>>>> * Steve Grubb:
>>>>> Now with LD_AUDIT
>>>>> $ LD_AUDIT=3D/home/sgrubb/test/openflags/strip-flags.so.0 strace ./te=
st
>>>>> 2>&1 | grep passwd openat(3, "passwd", O_RDONLY)           =3D 4
>>>>>
>>>>> No O_CLOEXEC flag.
>>>>
>>>> I think you need to explain in detail why you consider this a problem.

Right, LD_PRELOAD and such things are definitely not part of the threat
model for O_MAYEXEC, on purpose, because this must be addressed with
other security mechanism (e.g. correct file system access-control, IMA
policy, SELinux or other LSM security policies). This is a requirement
for O_MAYEXEC to be useful.

An interpreter is just a flexible program which is generic and doesn't
have other purpose other than behaving accordingly to external rules
(i.e. scripts). If you don't trust your interpreter, it should not be
executable in the first place. O_MAYEXEC enables to restrict the use of
(some) interpreters accordingly to a *global* system security policy.

>>>
>>> Because you can strip the O_MAYEXEC flag from being passed into the ker=
nel.
>>> Once you do that, you defeat the security mechanism because it never ge=
ts
>>> invoked. The issue is that the only thing that knows _why_ something is=
 being
>>> opened is user space. With this mechanism, you can attempt to pass this
>>> reason to the kernel so that it may see if policy permits this. But you=
 can
>>> just remove the flag.
>>
>> I=E2=80=99m with Florian here. Once you are executing code in a process,=
 you
>> could just emulate some other unapproved code. This series is not
>> intended to provide the kind of absolute protection you=E2=80=99re imagi=
ning.
>
> I also agree, though I think that there is a separate argument to be
> made that there are two possible problems with O_MAYEXEC (which might
> not be really big concerns):
>
>   * It's very footgun-prone if you didn't call O_MAYEXEC yourself and
>     you pass the descriptor elsewhere. You need to check f_flags to see
>     if it contains O_MAYEXEC. Maybe there is an argument to be made that
>     passing O_MAYEXECs around isn't a valid use-case, but in that case
>     there should be some warnings about that.

That could be an issue if you don't trust your system, especially if the
mount points (and the "noexec" option) can be changed by untrusted
users. As I said above, there is a requirement for basic security
properties as a meaningful file system access control, and obviously not
letting any user change mount points (which can lead to much sever
security issues anyway).

If a process A pass a FD to an interpreter B, then the interpreter B
must trust the process A. Moreover, being able to tell if the FD was
open with O_MAYEXEC and relying on it may create a wrong feeling of
security. As I said in a previous email, being able to probe for
O_MAYEXEC does not make sense because it would not be enough to
know the system policy (either this flag is enforced or not, for mount
points, based on xattr, time=E2=80=A6). The main goal of O_MAYEXEC is to as=
k the
kernel, on a trusted link (hence without LD_PRELOAD-like interfering),
for a file which is allowed to be interpreted/executed by this interpreter.

To be able to correctly handle the case you pointed out (FD passing),
either an existing or a new LSM should handle this behavior according to
the origin of the FD and the chain of processes getting it.

Some advanced LSM rules could tie interpreters with scripts dedicated to
them, and have different behavior for the same scripts but with
different interpreters.

>
>   * There's effectively a TOCTOU flaw (even if you are sure O_MAYEXEC is
>     in f_flags) -- if the filesystem becomes re-mounted noexec (or the
>     file has a-x permissions) after you've done the check you won't get
>     hit with an error when you go to use the file descriptor later.

Again, the threat model needs to be appropriate to make O_MAYEXEC
useful. The security policies of the system need to be seen as a whole,
and updated as such.

As for most file system access control on Linux, it may be possible to
have TOCTOU, but the whole system should be designed to protect against
that. For example, changing file access control (e.g. mount point
options) without a reboot may lead to inconsistent security properties,
which is why such thing are discouraged by some access control systems
(e.g. SELinux).

>
> To fix both you'd need to do what you mention later:
>
>> What the kernel *could* do is prevent mmapping a non-FMODE_EXEC file
>> with PROT_EXEC, which would indeed have a real effect (in an iOS-like
>> world, for example) but would break many, many things.
>
> And I think this would be useful (with the two possible ways of
> executing .text split into FMODE_EXEC and FMODE_MAP_EXEC, as mentioned
> in a sister subthread), but would have to be opt-in for the obvious
> reason you outlined. However, we could make it the default for
> openat2(2) -- assuming we can agree on what the semantics of a
> theoretical FMODE_EXEC should be.
>
> And of course we'd need to do FMODE_UPGRADE_EXEC (which would need to
> also permit fexecve(2) though probably not PROT_EXEC -- I don't think
> you can mmap() an O_PATH descriptor).

The mmapping restriction may be interesting but it is a different use
case. This series address the interpreter/script problem. Either the
script may be mapped executable is the choice of the interpreter. In
most cases, no script are mapped as such, exactly because they are
interpreted by a process but not by the CPU.


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
