Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E1FAC13B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 22:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394011AbfIFUGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 16:06:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43227 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfIFUGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:06:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id d15so5251993pfo.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fA56nmfsZsnUsEfBRX6jWIQZ7RippmvM12LMrLjjbeM=;
        b=E0bpCavZc9w7bg3ldootyHw632dMvkQjPiTDyyD9E4nvHHA/R4hfUqQe7JLvWLoVI1
         ZzdmjRUZn1I/3UFIId9wru0Cc8NhUgmlZoWyxM/ETmiRdFCnjHslhNciqqND5mXeB2ql
         n2FNStFMy81oIyvmFuPfhqeBNzaKyrGa2txp4Fp60Why8ReO3XzcGfC7Iqb3t9OIfHFS
         hkuXHMI1y873af/967NcJKza/15DICLILQudnnZaxDY3hkSvNaemTLwpsFes4bFnAeGl
         yrMqylb/J5NUitzWqPaJmoR/oVtP6BgW0XPr9/NxQgR7ofco0GzSUDnNYnFHisgIXVU8
         A/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fA56nmfsZsnUsEfBRX6jWIQZ7RippmvM12LMrLjjbeM=;
        b=LHawC2HGUP1IEQbArXCcmtFzOJYc8qGFFjy6nQdBsGuJuPoM6jKARMgkOGS2ABWCYx
         hOKBzmDL9r98jZwpV3d1QeWNcaWMT02dxnIcLf4l+2GUk7GiPZlCQYiTu/9K89DZPmIx
         CRXWzieHniK4448cppR33bav+xklCdM1ZHMwf8LRyzGX2agL3hWFqe6gI7iF6Z/OOqtM
         oqOKz1Uk9kZGDXzRaH5Eo6nY0Fbxygc7xBAELv0K2nB6hhN1nDR4qRXPsi/g1zLTBWrX
         UBL2YM4Am+nyz9D8ZnS325towQpFV3Nw13woZgPLzzZjUazR+3KhJKd1xCTodoM5rVpS
         y1Bw==
X-Gm-Message-State: APjAAAX7p0jn+7TJfXr+cCBUlzy9IjtCFJ2DetkGISjnCkaCITEUn61C
        D6TgLptKlOslbHjXnzeCBgAtvw==
X-Google-Smtp-Source: APXvYqz56KYhH6DJKB5EGgZ1CB/vlaLiWum8K3dRnvpJQJJwnJqULKe23ljO87SF/jS0Eam/QGtA3w==
X-Received: by 2002:a62:3083:: with SMTP id w125mr12963792pfw.102.1567800362967;
        Fri, 06 Sep 2019 13:06:02 -0700 (PDT)
Received: from ?IPv6:2600:100f:b121:da37:bc66:d4de:83c7:e0cd? ([2600:100f:b121:da37:bc66:d4de:83c7:e0cd])
        by smtp.gmail.com with ESMTPSA id k8sm5007663pgm.14.2019.09.06.13.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 13:06:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/5] fs: Add support for an O_MAYEXEC flag on sys_open()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <e1ac9428e6b768ac3145aafbe19b24dd6cf410b9.camel@kernel.org>
Date:   Fri, 6 Sep 2019 13:06:00 -0700
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Florian Weimer <fweimer@redhat.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
Message-Id: <D2A57C7B-B0FD-424E-9F81-B858FFF21FF0@amacapital.net>
References: <20190906152455.22757-1-mic@digikod.net> <20190906152455.22757-2-mic@digikod.net> <87ef0te7v3.fsf@oldenburg2.str.redhat.com> <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr> <f53ec45fd253e96d1c8d0ea6f9cca7f68afa51e3.camel@kernel.org> <20190906171335.d7mc3no5tdrcn6r5@yavin.dot.cyphar.com> <e1ac9428e6b768ac3145aafbe19b24dd6cf410b9.camel@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 6, 2019, at 12:43 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
>> On Sat, 2019-09-07 at 03:13 +1000, Aleksa Sarai wrote:
>>> On 2019-09-06, Jeff Layton <jlayton@kernel.org> wrote:
>>>> On Fri, 2019-09-06 at 18:06 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
>>>>> On 06/09/2019 17:56, Florian Weimer wrote:
>>>>> Let's assume I want to add support for this to the glibc dynamic loade=
r,
>>>>> while still being able to run on older kernels.
>>>>>=20
>>>>> Is it safe to try the open call first, with O_MAYEXEC, and if that fai=
ls
>>>>> with EINVAL, try again without O_MAYEXEC?
>>>>=20
>>>> The kernel ignore unknown open(2) flags, so yes, it is safe even for
>>>> older kernel to use O_MAYEXEC.
>>>>=20
>>>=20
>>> Well...maybe. What about existing programs that are sending down bogus
>>> open flags? Once you turn this on, they may break...or provide a way to
>>> circumvent the protections this gives.
>>=20
>> It should be noted that this has been a valid concern for every new O_*
>> flag introduced (and yet we still introduced new flags, despite the
>> concern) -- though to be fair, O_TMPFILE actually does have a
>> work-around with the O_DIRECTORY mask setup.
>>=20
>> The openat2() set adds O_EMPTYPATH -- though in fairness it's also
>> backwards compatible because empty path strings have always given ENOENT
>> (or EINVAL?) while O_EMPTYPATH is a no-op non-empty strings.
>>=20
>>> Maybe this should be a new flag that is only usable in the new openat2()=

>>> syscall that's still under discussion? That syscall will enforce that
>>> all flags are recognized. You presumably wouldn't need the sysctl if you=

>>> went that route too.
>>=20
>> I'm also interested in whether we could add an UPGRADE_NOEXEC flag to
>> how->upgrade_mask for the openat2(2) patchset (I reserved a flag bit for
>> it, since I'd heard about this work through the grape-vine).
>>=20
>=20
> I rather like the idea of having openat2 fds be non-executable by
> default, and having userland request it specifically via O_MAYEXEC (or
> some similar openat2 flag) if it's needed. Then you could add an
> UPGRADE_EXEC flag instead?
>=20
> That seems like something reasonable to do with a brand new API, and
> might be very helpful for preventing certain classes of attacks.
>=20
>=20

There are at least four concepts of executability here:

- Just check the file mode and any other relevant permissions. Return a norm=
al fd.  Makes sense for script interpreters, perhaps.

- Make the fd fexecve-able.

- Make the resulting fd mappable PROT_EXEC.

- Make the resulting fd upgradable.

I=E2=80=99m not at all convinced that the kernel needs to distinguish all th=
ese, but at least upgradability should be its own thing IMO.=
