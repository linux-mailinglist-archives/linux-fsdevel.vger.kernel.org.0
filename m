Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09294ADC6F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbfIIPti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 11:49:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44976 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfIIPth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:49:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so9397308pfn.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TcpVRxPvSCJBDeMrd2YTMRp8Rl8PbIZu3n0i+gvGrs0=;
        b=pyj6eZzOMQKgCMAnu5hk7YcUQt/XRn56h4r0IMODI0hyM9G9CYPIi2I36Xh8bWAswe
         HQ69epbn6Uf9ynM4L80OZwNVT7+NKwhsVjbbBOdgZ3Sno+ciFri39Kli05LwVBVwXMO4
         WPQPuPR8PH4DNpoQm9XN6dklzcVFGdNXqpu0a1NtCG6oZM5UZY52+iEmc5U+69aWMSDD
         TtFXWImbrKRvBbStNAPXOn384l3qdIeXuF90JziftEWHMPomjRynDL5FJz+grsE1Ojux
         M7UMm0N5iJ2ogZ3iHxqnGcVPcNf5bXqHXW4l+fPAohZq2BPjtEtmzX37Gd63Ig1oZN85
         4jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TcpVRxPvSCJBDeMrd2YTMRp8Rl8PbIZu3n0i+gvGrs0=;
        b=rNwYiPgRFecV+63y1/3rWZX4p+2mNcnPU//mrq4aaRFcCbmJqlazgfIvdajCiMRPq5
         6QPffOpXhtr0RkS2Zbi67XaSPDWkV1Hlvc45FaWqlTXWIFc8NERYAPhhM76yO8rj0cJ9
         CR+YYXgjD39lG0m3rjLvkFZRqg5l+Q9eqFFOy7LAQbtBgTk9heDrr6QJZpYfutKAN9Fv
         cwuKSEbqbY2/suvubcy5tOMLBQK8D1k9gZRGwwcJlJMXBukIE7YpyHOYXoxJZnu0FGNm
         6gfAljoldWuaQmi3xY2fHKMColgkXkRIB5FQ4mHhKUa04VFbsSMXvdUPUUutaIlkgrmk
         CrGA==
X-Gm-Message-State: APjAAAUwLyKL+0PZ9GtAeis3UFTNjFAGCS9rseiA32SmfJzTLdHrTkhK
        3I/XJddqk5y9UFpYr/YGqd20Rg==
X-Google-Smtp-Source: APXvYqySGg+p3Dw7cgCsaiUZVu10eDMnz9rdqxHXA7Nhsj2dAxRpToTiDCtfq8sckKTaoarNWjC1Vw==
X-Received: by 2002:a63:df06:: with SMTP id u6mr21484642pgg.96.1568044176881;
        Mon, 09 Sep 2019 08:49:36 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:75ae:6074:df59:7e95? ([2601:646:c200:1ef2:75ae:6074:df59:7e95])
        by smtp.gmail.com with ESMTPSA id d15sm15407841pfo.118.2019.09.09.08.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 08:49:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/5] fs: Add support for an O_MAYEXEC flag on sys_open()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <9e43ca3f-04c0-adba-1ab4-bbc8ed487934@ssi.gouv.fr>
Date:   Mon, 9 Sep 2019 08:49:32 -0700
Cc:     Jeff Layton <jlayton@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
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
        =?utf-8?Q?Philippe_Tr=C3=A9buchet?= 
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
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3D3F165-F562-4090-831D-D8E39F9C5246@amacapital.net>
References: <20190906152455.22757-1-mic@digikod.net> <20190906152455.22757-2-mic@digikod.net> <87ef0te7v3.fsf@oldenburg2.str.redhat.com> <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr> <f53ec45fd253e96d1c8d0ea6f9cca7f68afa51e3.camel@kernel.org> <1fbf54f6-7597-3633-a76c-11c4b2481add@ssi.gouv.fr> <5a59b309f9d0603d8481a483e16b5d12ecb77540.camel@kernel.org> <D1212E06-773B-42B9-B7C3-C4C1C2A6111D@amacapital.net> <9e43ca3f-04c0-adba-1ab4-bbc8ed487934@ssi.gouv.fr>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Sep 9, 2019, at 2:18 AM, Micka=C3=ABl Sala=C3=BCn <mickael.salaun@ssi.g=
ouv.fr> wrote:
>=20
>=20
>> On 06/09/2019 20:41, Andy Lutomirski wrote:
>>=20
>>=20
>>>> On Sep 6, 2019, at 11:38 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>=20
>>>>> On Fri, 2019-09-06 at 19:14 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
>>>>>> On 06/09/2019 18:48, Jeff Layton wrote:
>>>>>>> On Fri, 2019-09-06 at 18:06 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
>>>>>>> On 06/09/2019 17:56, Florian Weimer wrote:
>>>>>>> Let's assume I want to add support for this to the glibc dynamic loa=
der,
>>>>>>> while still being able to run on older kernels.
>>>>>>>=20
>>>>>>> Is it safe to try the open call first, with O_MAYEXEC, and if that f=
ails
>>>>>>> with EINVAL, try again without O_MAYEXEC?
>>>>>>=20
>>>>>> The kernel ignore unknown open(2) flags, so yes, it is safe even for
>>>>>> older kernel to use O_MAYEXEC.
>>>>>>=20
>>>>>=20
>>>>> Well...maybe. What about existing programs that are sending down bogus=

>>>>> open flags? Once you turn this on, they may break...or provide a way t=
o
>>>>> circumvent the protections this gives.
>>>>=20
>>>> Well, I don't think we should nor could care about bogus programs that
>>>> do not conform to the Linux ABI.
>>>>=20
>>>=20
>>> But they do conform. The ABI is just undefined here. Unknown flags are
>>> ignored so we never really know if $random_program may be setting them.
>>>=20
>>>>> Maybe this should be a new flag that is only usable in the new openat2=
()
>>>>> syscall that's still under discussion? That syscall will enforce that
>>>>> all flags are recognized. You presumably wouldn't need the sysctl if y=
ou
>>>>> went that route too.
>>>>=20
>>>> Here is a thread about a new syscall:
>>>> https://lore.kernel.org/lkml/1544699060.6703.11.camel@linux.ibm.com/
>>>>=20
>>>> I don't think it fit well with auditing nor integrity. Moreover using
>>>> the current open(2) behavior of ignoring unknown flags fit well with th=
e
>>>> usage of O_MAYEXEC (because it is only a hint to the kernel about the
>>>> use of the *opened* file).
>>>>=20
>>>=20
>>> The fact that open and openat didn't vet unknown flags is really a bug.
>>>=20
>>> Too late to fix it now, of course, and as Aleksa points out, we've
>>> worked around that in the past. Now though, we have a new openat2
>>> syscall on the horizon. There's little need to continue these sorts of
>>> hacks.
>>>=20
>>> New open flags really have no place in the old syscalls, IMO.
>>>=20
>>>>> Anyone that wants to use this will have to recompile anyway. If the
>>>>> kernel doesn't support openat2 or if the flag is rejected then you kno=
w
>>>>> that you have no O_MAYEXEC support and can decide what to do.
>>>>=20
>>>> If we want to enforce a security policy, we need to either be the syste=
m
>>>> administrator or the distro developer. If a distro ship interpreters
>>>> using this flag, we don't need to recompile anything, but we need to be=

>>>> able to control the enforcement according to the mount point
>>>> configuration (or an advanced MAC, or an IMA config). I don't see why a=
n
>>>> userspace process should check if this flag is supported or not, it
>>>> should simply use it, and the sysadmin will enable an enforcement if it=

>>>> makes sense for the whole system.
>>>>=20
>>>=20
>>> A userland program may need to do other risk mitigation if it sets
>>> O_MAYEXEC and the kernel doesn't recognize it.
>>>=20
>>> Personally, here's what I'd suggest:
>>>=20
>>> - Base this on top of the openat2 set
>>> - Change it that so that openat2() files are non-executable by default. A=
nyone wanting to do that needs to set O_MAYEXEC or upgrade the fd somehow.
>>> - Only have the openat2 syscall pay attention to O_MAYEXEC. Let open and=
 openat continue ignoring the new flag.
>>>=20
>>> That works around a whole pile of potential ABI headaches. Note that
>>> we'd need to make that decision before the openat2 patches are merged.
>>>=20
>>> Even better would be to declare the new flag in some openat2-only flag
>>> space, so there's no confusion about it being supported by legacy open
>>> calls.
>>>=20
>>> If glibc wants to implement an open -> openat2 wrapper in userland
>>> later, it can set that flag in the wrapper implicitly to emulate the old=

>>> behavior.
>>>=20
>>> Given that you're going to have to recompile software to take advantage
>>> of this anyway, what's the benefit to changing legacy syscalls?
>>>=20
>>>>>>> Or do I risk disabling this security feature if I do that?
>>>>>>=20
>>>>>> It is only a security feature if the kernel support it, otherwise it i=
s
>>>>>> a no-op.
>>>>>>=20
>>>>>=20
>>>>> With a security feature, I think we really want userland to aware of
>>>>> whether it works.
>>>>=20
>>>> If userland would like to enforce something, it can already do it
>>>> without any kernel modification. The goal of the O_MAYEXEC flag is to
>>>> enable the kernel, hence sysadmins or system designers, to enforce a
>>>> global security policy that makes sense.
>>>>=20
>>>=20
>>> I don't see how this helps anything if you can't tell whether the kernel=

>>> recognizes the damned thing. Also, our track record with global sysctl
>>> switches like this is pretty poor. They're an administrative headache as=

>>> well as a potential attack vector.
>>=20
>> I tend to agree. The sysctl seems like it=E2=80=99s asking for trouble. I=
 can see an ld.so.conf option to turn this thing off making sense.
>=20
> The sysctl is required to enable the adoption of this flag without
> breaking existing systems. Current systems may have "noexec" on mount
> points containing scripts. Without giving the ability to the sysadmin to
> control that behavior, updating to a newer version of an interpreter
> using O_MAYEXEC may break such systems.
>=20
> How would you do this with ld.so.conf ?
>=20

By telling user code not to use O_MAYEXEC?

Alternatively, you could allow O_MAYEXEC even on a noexec mount and have a s=
trong_noexec option that blocks it.=
