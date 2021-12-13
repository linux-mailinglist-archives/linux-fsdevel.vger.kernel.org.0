Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B407B472E8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 15:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbhLMOJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 09:09:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37890 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhLMOJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:09:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC3B761043;
        Mon, 13 Dec 2021 14:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CDBC34601;
        Mon, 13 Dec 2021 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639404585;
        bh=QrAGT1B3Yarjb7AwosvkB0JspOa/cD58mcxtYJAOAts=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=j+klMESi4uCfFEylZP6jh02UBFCAZJ6wIGdaIH93QSPIp5AZs7YgURWib4DABiLfq
         OhvoxLarode+c+4kbKs5LSyG8JEr3rd39guP89VgNzTrhuVIYLwVflYS5B3vL19s2P
         BlI6Kh0JDnGDLUZlniKEiEkpBQvfo6ToSs6GWU/lmy4h2hodIJWo1nU0C1mD+TV5Ej
         qBvdf10NMdadXgtdUzsPbUFFedYguHjd2kwWspavdkbzdbqmoWs28KRJB45GD2Cbga
         bihOV/FSDcLmXYW7u+Ic4khebyO6i9MFnAGsGycXsZhVXChrsNWH/67mn/OgVI4Wxj
         tuCNtPp2a5q4g==
Received: by mail-ot1-f41.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso17472406otf.12;
        Mon, 13 Dec 2021 06:09:45 -0800 (PST)
X-Gm-Message-State: AOAM533f2l48xlmgUbLc3LBwshuHNv4Lttgf2ke9dXy65g0qcvG4BPgk
        UBGpO8LWvLWo0zbh4VKcavbKn+VYUz37mE0ekb4=
X-Google-Smtp-Source: ABdhPJxzAenHXhObuJaIOMnjAJbhyD1itt71Ka+xu82CEa7c/Ct3re6PQ4aoYnNTLQsSuuwrJXjXj3CH92jtpJtFumg=
X-Received: by 2002:a9d:364b:: with SMTP id w69mr25556807otb.18.1639404584560;
 Mon, 13 Dec 2021 06:09:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:428a:0:0:0:0:0 with HTTP; Mon, 13 Dec 2021 06:09:44
 -0800 (PST)
In-Reply-To: <20211213113903.bkspqw2qlpct3uxr@pali>
References: <20210927111948.GA16257@gofer.mess.org> <20211211020453.mkuzumgpnignsuri@pali>
 <YbbskNBJI8Ak1Vl/@angband.pl> <20211213113903.bkspqw2qlpct3uxr@pali>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 13 Dec 2021 23:09:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9fjSEsNDLMtqpWOcu9xWdFzr1gqLdC5aKJFmgK9MfHoA@mail.gmail.com>
Message-ID: <CAKYAXd9fjSEsNDLMtqpWOcu9xWdFzr1gqLdC5aKJFmgK9MfHoA@mail.gmail.com>
Subject: Re: Incorrect handling of . and .. files
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Adam Borowski <kilobyte@angband.pl>, Sean Young <sean@mess.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-12-13 20:39 GMT+09:00, Pali Roh=C3=A1r <pali@kernel.org>:
> On Monday 13 December 2021 07:47:44 Adam Borowski wrote:
>> On Sat, Dec 11, 2021 at 03:04:53AM +0100, Pali Roh=C3=A1r wrote:
>> > I tried to find some information what is allowed and what not.
>> >
>> > On Monday 27 September 2021 12:19:48 Sean Young wrote:
>> > > Windows allows files and directories called "." and ".." to be
>> > > created
>> > > using UNC paths, i.e. "\\?\D:\..". Now this is totally insane
>> > > behaviour,
>> > > but when an exfat filesytem with such a file is mounted on Linux,
>> > > those
>> > > files show up as another directory and its contents is inaccessible.
>> > >
>> > > I can replicate this using exfat filesystems, but not ntfs.
>> >
>> > Microsoft exFAT specification explicitly disallow "." and "..", see:
>> [...]
>> > On the other hand Microsoft FAT32 specification can be understood that
>> > file may have long name (vfat) set to "." or ".." but not short name.
>> [...]
>> > OSTA UDF 2.60 specification does not disallow "." and ".." entries, bu=
t
>> [...]
>> > So it means that "." and ".." entries could be stored on disk as valid
>> > file names.
>>
>> It doesn't matter one whit what the specification says.  Anyone with a
>> disk
>> editor can craft a filesystem containing filenames such as "." or "..",
>> "/"
>> "foo/bar" or anything else we would like to ban.
>
> That is truth. But question is what should do fsck tools with such file
> names on filesystems where "." and ".." are permitted? Fully valid
> argument is "do not touch them" because there is nothing bad with these
> names.
>
>> > > So, in Linux cannot read "." or ".." (i.e., I can't see "Hello,
>> > > World!"). I
>> > > don't know what the correct handling should be, but having two "." a=
nd
>> > > two
>> > > ".." files does not seem right at all.
>> >
>> > This is really a bug in Linux kernel. It should not export "." and "..=
"
>> > into VFS even when filesystem disk format supports such insane file
>> > names.
>>
>> This.
>>
>> Otherwise, every filesystem driver would need to contain redundant code
>> for
>> checking for such bad names.
>>
>> > So either Linux needs to completely hide these insane file names from
>> > VFS or translate them to something which do not conflict with other
>> > files in correct directory.
>>
>> Escaping bad names has the problem of the escaped name also possibly
>> existing -- perhaps even recursively.  Plus, the filesystem might be
>> using
>> hashed or tree indices which could go wrong if a name is altered.
>
> vfat has already own escaping scheme and it is documented in mount(8)
> manpage. Invalid characters are translated either to fixed char '?' or
> to ':'... esc sequence if uni_xlate mount option is used. But it looks
> like that that kernel vfat driver do not have these two entries "." and
> ".." in its blacklist.
>
> And, another important thing about vfat is that it has two file names
> for each file. One short 8.3 and one long vfat. Short 8.3 do not allow
> "." or "..", so another possibility how to handle this issue for vfat is
> to show short 8.3 name in VFS when long is invalid.
>
> For UDF case, specification already says how to handle problematic
> file names, so I think that udf.ko could implement it according to
> specification.
>
> But for all other filesystems it is needed to do something ideally on
> VFS layer.
>
> What about generating some deterministic / predicable file names which
> will not conflict with other file names in current directory for these
> problematic files?
>
>> But then, I once proposed (and I'm pondering reviving) a ban for
>> characters
>> \x01..\x1f and possibly others, and if banned, they can still
>> legitimately
>> occur in old filesystems.
>>
>> > I guess that hiding them for exfat is valid thing as Microsoft
>> > specification explicitly disallow them. Probably fsck.exfat can be
>> > teach
>> > to rename these files and/or put them to lost+found directory.
>>
>> fsck fixing those is a good thing but we still need to handle them at
>> runtime.
>
> Namjae Jeon, would you be able to implement fixing of such filenames in
> fsck.exfat tool?
We've recently been finalizing the repair function in fsck.exfat. We
will check it as soon as it is finished.

Thanks for your suggestion!
>
>>
>> Meow!
>> --
>> =E2=A2=80=E2=A3=B4=E2=A0=BE=E2=A0=BB=E2=A2=B6=E2=A3=A6=E2=A0=80
>> =E2=A3=BE=E2=A0=81=E2=A2=A0=E2=A0=92=E2=A0=80=E2=A3=BF=E2=A1=81 in the b=
eginning was the boot and root floppies and they were
>> good.
>> =E2=A2=BF=E2=A1=84=E2=A0=98=E2=A0=B7=E2=A0=9A=E2=A0=8B=E2=A0=80         =
                              -- <willmore> on
>> #linux-sunxi
>> =E2=A0=88=E2=A0=B3=E2=A3=84=E2=A0=80=E2=A0=80=E2=A0=80=E2=A0=80
>
