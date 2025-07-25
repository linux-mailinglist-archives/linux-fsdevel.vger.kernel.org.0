Return-Path: <linux-fsdevel+bounces-56009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B96AB11751
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 06:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98B6AA1BBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 04:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B5A23A99E;
	Fri, 25 Jul 2025 04:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNjd0wvX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F62E36EC;
	Fri, 25 Jul 2025 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753416755; cv=none; b=pHntycGGKz581oaibXf63igMGlbm5tpRVU1frki+i3yI26uE6fjvCPuglxJ38hmXQHKgL2r6zVDP+EpVMWIb24hyKf90WdPsanw99MsRMlCEU5hxyeCAuId9qY3DASa4tIXNZA/zt6OqYEZEoSAmOPmQI+tlWn1BffYFGneQyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753416755; c=relaxed/simple;
	bh=s691h+SvxGjaKLuojAdn6yF03n4tEezV7cov2TKHRUA=;
	h=From:To:Cc:Subject:Date:References:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Xa0VXTPmwu8jAiHB7qgxc28yuiqxr6VLagLXFCblqrwQNwY3QlcTJ3S+2LfdYZ+Uv/GVTssCp5pnc5DpYOh+Fry3tKy68gcjvbVocHZ8GL9Dm/2SLdeDRcbEZ2Oo40Sbcbuc6rOItWG5EnQRm8PHP9+lVgW6851EV2sIAMNrAyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNjd0wvX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso1354458a91.1;
        Thu, 24 Jul 2025 21:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753416753; x=1754021553; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oME5smZQciDRU++0q4UCxZ08x6aqQ7JM6IN1Wx11wes=;
        b=NNjd0wvXuL++91IXJIs4CzVWZW4Q+KBvaDAZpTXUzXqcZRXAHJdHS3ytV+RjYCbn6q
         mnVjq5iP8mBp8XOJwjvlixI14kgnn682H9Hds8sFWg7avA+5qHN+DsvJAGab6T9KCLih
         kQrBts5LMtOcXLIm9AAWMiTm9qyKIrvOcALylrNKm5BC/ElzqrsNnb9e9uvcwbfflkWq
         6ezB06VIKjU0djuUEjFPvcT7oJbnq6pOyuZCtyIjxAwTTitzG5p4hafR4P6LiPi5gjzg
         OeiXFmbcAJyjoHnorQpOYVaWIO04/qowu/OKisypOkunla2V3HeKIAS/EwUMz4bueppw
         IGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753416753; x=1754021553;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oME5smZQciDRU++0q4UCxZ08x6aqQ7JM6IN1Wx11wes=;
        b=w3rlauVQbfLHPkHD6D5Rgj9SKwcmsuNbb7xMIKRHKp46KAaGmyX5pyrPmJRGg230h2
         PKPe7bG4BgRn3x2+ayXL45ebNyLLqUMPV8A9bFTiySpG15SIpe6Y462XzHNA7yDVKdTP
         6O2YHG8hQeP7LQ55v8qmLkNew6P5lYwkRQexX7ocjrTlWmK92ntTO8JdfHBtzYXukI3Z
         t1dNh39hLKVmIGatQ2cnG5M2hyn7mT5TaoAozVBfSf665+p0WYez3a95ppsFFQMXNeQl
         t8qmWvNL9vxOAWaOVHt7U4eDGRirdv1uBHDQvUUp+tdkF8gAVwY1jB0sxi07VulKMxml
         m4tw==
X-Forwarded-Encrypted: i=1; AJvYcCUWXF1ikT8zpLThs6UAj8DASW+Uv+ZgxCgRVw3tqgeZv8oRmBH7ZiuPcI2FxsmHvaXIi5jEjifajbWETsNb@vger.kernel.org, AJvYcCUZGrZwN2Skg8deZDHTyy+1LLMzWcE/xAWde8xdkuvucv5E235vHeJVldW9zkdi60a9B/Ze3Assp0hFQBBiIo0MzKPLPxCa@vger.kernel.org
X-Gm-Message-State: AOJu0YycS/yJLuuLJGYWNhXKINETBhQt9+wKHLe+Ed33RrSYbhCc7jTw
	HdD2pLq8JwCuEZZvvCwQPzpz23UdbVtZ2vVQowgXsaaYIyyRmUUsVgSEiLIXd3vzbMk=
X-Gm-Gg: ASbGncv6TN3tmuv9HQeVVLgMLaLTB5VCyrJJDXql70VUT9w/ObPVPLTQITxiifsQX/d
	s8E6Hqa4JBDG525NFPXDpCfrbPBKPjvsM54S4qdjf75qb3x+4E7c9bja1e90du1BnpEy/nxF+iW
	6s1zUYuwKynPe7D/G6h4z3ksCtiIu2ecGx03FVZVckji12S/e2KQZb0g4x6e1I02Bl062A1Elq4
	VmUF1UPg5kefX5nNkdDEj8Zojme5hebjI5gxQrl4AhnDpNu4EyHcY3oODrMAt3YCv1EPrON+tb/
	LkhbK5nb7u80lCU7xQ87AQulhfNou/v65ZTXcw01yBZCXRqpmlcTcy0RJExaFuvRGUfIC7PQJO9
	x1Nwk/37L2plj
X-Google-Smtp-Source: AGHT+IGqvrwoX53tPa0NT1yJgEB5sPK9Frc4wWVRkfcVJtXt79nGTHd+irrszcrhVatuCfHZv/ei0w==
X-Received: by 2002:a17:90b:17c1:b0:31e:3d7e:d575 with SMTP id 98e67ed59e1d1-31e77a009abmr639215a91.24.1753416752502;
        Thu, 24 Jul 2025 21:12:32 -0700 (PDT)
Received: from 1337 ([136.159.213.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e66384406sm2501100a91.33.2025.07.24.21.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 21:12:31 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Tingmao Wang
 <m@maowtm.org>, Jann
 Horn <jannh@google.com>, John Johansen <john.johansen@canonical.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Ben Scarlato <akhna@google.com>, Christian
 Brauner <brauner@kernel.org>, Daniel Burgener
 <dburgener@linux.microsoft.com>, Jeff Xu <jeffxu@google.com>, NeilBrown
 <neil@brown.name>, Paul Moore <paul@paul-moore.com>, Ryan Sullivan
 <rysulliv@redhat.com>, Song Liu <song@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/4] landlock: Fix handling of disconnected directories
Date: Thu, 24 Jul 2025 21:54:22 -0600
References: <20250719104204.545188-1-mic@digikod.net>
 <20250719104204.545188-3-mic@digikod.net>
 <18425339-1f4b-4d98-8400-1decef26eda7@maowtm.org>
 <20250723.vouso1Kievao@digikod.net> <aIJH9CoEKWNq0HwN@google.com>
 <20250724.ECiGoor4ulub@digikod.net>
User-agent: mu4e 1.10.8; emacs 30.1
In-reply-to: <20250724.ECiGoor4ulub@digikod.net>
Message-ID: <87tt307vtd.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> writes:
> On Thu, Jul 24, 2025 at 04:49:24PM +0200, G=C3=BCnther Noack wrote:
>> On Wed, Jul 23, 2025 at 11:01:42PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
>> > On Tue, Jul 22, 2025 at 07:04:02PM +0100, Tingmao Wang wrote:
>> > > On the other hand, I=E2=80=99m still a bit uncertain about the domai=
n check
>> > > semantics.  While it would not cause a rename to be allowed if it is
>> > > otherwise not allowed by any rules on or above the mountpoint, this =
gets a
>> > > bit weird if we have a situation where renames are allowed on the
>> > > mountpoint or everywhere, but not read/writes, however read/writes a=
re
>> > > allowed directly on a file, but the dir containing that file gets
>> > > disconnected so the sandboxed application can=E2=80=99t read or writ=
e to it.
>> > > (Maybe someone would set up such a policy where renames are allowed,
>> > > expecting Landlock to always prevent renames where additional permis=
sions
>> > > would be exposed?)
>> > >
>> > > In the above situation, if the file is then moved to a connected
>> > > directory, it will become readable/writable again.
>> >
>> > We can generalize this issue to not only the end file but any component
>> > of the path: disconnected directories.  In fact, the main issue is the
>> > potential inconsistency of access checks over time (e.g. between two
>> > renames).  This could be exploited to bypass the security checks done
>> > for FS_REFER.
>> >
>> > I see two solutions:
>> >
>> > 1. *Always* walk down to the IS_ROOT directory, and then jump to the
>> >    mount point.  This makes it possible to have consistent access chec=
ks
>> >    for renames and open/use.  The first downside is that that would
>> >    change the current behavior for bind mounts that could get more
>> >    access rights (if the policy explicitly sets rights for the hidden
>> >    directories).  The second downside is that we=E2=80=99ll do more wa=
lk.
>> >
>> > 2. Return -EACCES (or -ENOENT) for actions involving disconnected
>> >    directories, or renames of disconnected opened files.  This second
>> >    solution is simpler and safer but completely disables the use of
>> >    disconnected directories and the rename of disconnected files for
>> >    sandboxed processes.
>> >
>> > It would be much better to be able to handle opened directories as
>> > (object) capabilities, but that is not currently possible because of t=
he
>> > way paths are handled by the VFS and LSM hooks.
>> >
>> > Tingmao, G=C3=BCnther, Jann, what do you think?
>>
>> I have to admit that so far, I still failed to wrap my head around the
>> full patch set and its possible corner cases.  I hope I did not
>> misunderstand things all too badly below:
>>
>> As far as I understand the proposed patch, we are =E2=80=9Ccheckpointing=
=E2=80=9D the
>> intermediate results of the path walk at every mount point boundary,
>> and in the case where we run into a disconnected directory in one of
>> the nested mount points, we restore from the intermediate result at
>> the previous mount point directory and skip to the next mount point.
>
> Correct
>
>>
>> Visually speaking, if the layout is this (where =E2=80=9C:=E2=80=9D deno=
tes a
>> mountpoint boundary between the mountpoints MP1, MP2, MP3):
>>
>>                           dirfd
>>                             |
>>           :                 V         :
>> 	  :       ham <=E2=80=94 spam <=E2=80=94 eggs <=E2=80=94 x.txt
>> 	  :    (disconn.)             :
>>           :                           :
>>   / <=E2=80=94 foo <=E2=80=94 bar <=E2=80=94 baz        :
>>           :                           :
>>     MP1                 MP2                  MP3
>>
>> When a process holds a reference to the =E2=80=9Cspam=E2=80=9D directory=
, which is now
>> disconnected, and invokes openat(dirfd, =E2=80=9Ceggs/x.txt=E2=80=9D, =
=E2=80=A6), then we
>> would:
>>
>>   * traverse x.txt
>>   * traverse eggs (checkpointing the intermediate result) <-.
>>   * traverse spam                                           |
>>   * traverse ham                                            |
>>   * discover that ham is disconnected:                      |
>>      * restore the intermediate result from =E2=80=9Ceggs=E2=80=9D =E2=
=80=94=E2=80=94=E2=80=94=E2=80=99
>>      * continue the walk at foo
>>   * end up at the root
>>
>> So effectively, since the results from =E2=80=9Cspam=E2=80=9D and =E2=80=
=9Cham=E2=80=9D are discarded,
>> we would traverse only the inodes in the outer and inner mountpoints
>> MP1 and MP3, but effectively return a result that looks like we did
>> not traverse MP2?
>
> We=E2=80=99d still check MP2=E2=80=99s inode, but otherwise yes.
>

I don=E2=80=99t know if it makes sense, but can access rights be cached as =
part
of the inode security blob? Although I am not sure if the LSM blob would
exist after unlinking.

But if it does, maybe during unlink, keep the cached rights for MP2,
and during openat():
1. Start at disconnected =E2=80=9Cspam=E2=80=9D inode
2. Check spam->i_security->allowed_access  <- Cached MP2 rights
3. Continue normal path walk with preserved access context

>>
>> Maybe (likely) I misread the code. :) It=E2=80=99s not clear to me what =
the
>> thinking behind this is.  Also, if there was another directory in
>> between =E2=80=9Cspam=E2=80=9D and =E2=80=9Ceggs=E2=80=9D in MP2, wouldn=
=E2=80=99t we be missing the access
>> rights attached to this directory?
>
> Yes, we would ignore this access right because we don=E2=80=99t know that=
 the
> path was resolved from spam.
>
>>
>>
>> Regarding the capability approach:
>>
>> I agree that a =E2=80=9Ccapability=E2=80=9D approach would be the better=
 solution, but
>> it seems infeasible with the existing LSM hooks at the moment.  I
>> would be in favor of it though.
>
> Yes, it would be a new feature with potential important changes.
>
> In the meantime, we still need a fix for disconnected directories, and
> this fix needs to be backported.  That=E2=80=99s why the capability appro=
ach is
> not part of the two solutions. ;)
>
>>
>> To spell it out a bit more explicitly what that would mean in my mind:
>>
>> When a path is looked up relative to a dirfd, the path walk upwards
>> would terminate at the dirfd and use previously calculated access
>> rights stored in the associated struct file.  These access rights
>> would be determined at the time of opening the dirfd, similar to how we
>> are already storing the =E2=80=9Ctruncate=E2=80=9D access right today fo=
r regular
>> files.
>>
>> (Remark: There might still be corner cases where we have to solve it
>> the hard way, if someone uses =E2=80=9C..=E2=80=9D together with a dirfd=
-relative
>> lookup.)
>
> Yep, real capabilities don=E2=80=99t have =E2=80=9C..=E2=80=9D in their d=
esign.  On Linux (and
> Landlock), we need to properly handle =E2=80=9C..=E2=80=9D, which is chal=
lenging.
>
>>
>> I also looked at what it would take to change the LSM hooks to pass
>> the directory that the lookup was done relative to, but it seems that
>> this would have to be passed through a bunch of VFS callbacks as well,
>> which seems like a larger change.  I would be curious whether that
>> would be deemed an acceptable change.
>>
>> =E2=80=94G=C3=BCnther
>>
>>
>> P.S. Related to relative directory lookups, there is some movement in
>> the BSDs as well to use dirfds as capabilities, by adding a flag to
>> open directories that enforces O_BENEATH on subsequent opens:
>>
>>  * <https://undeadly.org/cgi?action=3Darticle;sid=3D20250529080623>
>>  * <https://reviews.freebsd.org/D50371>
>>
>> (both found via <https://news.ycombinator.com/item?id=3D44575361>)
>>
>> If a dirfd had such a flag, that would get rid of the corner case
>> above.
>
> This would be nice but it would not solve the current issue because we
> cannot force all processes to use this flag (which breaks some use
> cases).
>
> FYI, Capsicum is a more complete implementation:
> <https://man.freebsd.org/cgi/man.cgi?query=3Dcapsicum&sektion=3D4>
> See the vfs.lookup_cap_dotdot sysctl too.

Also, my apologies, as this may be tangential to the current
conversation, but since object-based capabilities were mentioned, I had
some design ideas around it while working on the memfd feature [1]. I
don=E2=80=99t know if the design for object-based capabilities has been
internally formalized yet, but since we=E2=80=99re at this juncture, it wou=
ld
make me glad if any of this is helpful in any way :)

If I understand things correctly, the domain currently applies to ALL
file operations via paths and persists until the process exits.
Therefore, with disconnected directories, once a path component is
unlinked, security policies can be bypassed, as access checks on
previously visible ancestors might get skipped.

Current Landlock Architecture:
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95

Process -> Landlock Domain -> Access Decision

{Filesystem Rules, Network Rules, Scope Restrictions}

Path/Port Resolution + Domain Boundary Checks


Enhanced Architecture with Object Capabilities:
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95

Process -> Enhanced Landlock Domain ->   Access Decision
=E2=94=81=E2=94=81
=20=20
=E2=94=81=E2=94=81
{Path Rules, Network Rules,  (AND)   {FD Capabilities}
 Scope Restrictions}                      |
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81
 Per-FD Rights=20
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81
Traditional Resolution             (calculated)

Unlike SCOPE which provides coarse-grained blocking, object capabilities
provide with the facility to add domain specific fine-grained individual
FD operations. So that we have:

Child Domain =3D Parent Domain & New Restrictions
             =3D {
    path_rules: Parent.path_rules & Child.path_rules,
    net_rules: Parent.net_rules & Child.net_rules,
    scope: Parent.scope | Child.scope,  /* Additive */
    fd_caps: path_rules & net_rules & scope & Child.allowed_fd_operations
}

where the Child domain *must* be more restrictive than the parent. Here
is an example:

/* Example */
Parent Domain =3D {
    path_rules: [=E2=80=9C/var/www=E2=80=9D -> READ_FILE|READ_DIR, =E2=80=
=9C/var/log=E2=80=9D -> WRITE_FILE],
    net_rules: [=E2=80=9C80=E2=80=9D -> BIND_TCP, =E2=80=9C443=E2=80=9D -> =
BIND_TCP],
    scope: [SIGNAL, ABSTRACT_UNIX],

    /* Auto-derived FD capabilities */
    fd_caps: {
        3: READ_FILE,           /* /var/www/index.html */
        7: READ_DIR,            /* /var/www directory */
        12: WRITE_FILE,         /* /var/log/access.log */
        15: BIND_TCP,           /* socket bound to port 80 */
        20: READ_FILE|READ_DIR  /* /var/www/images/ */
    }
}

/* Child creates new domain with additional restrictions */
Child.new_restrictions =3D {
    path_rules: ["/var/www" -> READ_FILE only], /* Remove READ_DIR */
    net_rules: [],                              /* Remove all network */
    scope: [SIGNAL, ABSTRACT_UNIX, MEMFD_EXEC], /* Add MEMFD restriction */
}

/* Child FD capabilities =3D Parent & Child restrictions */
Child.fd_caps =3D {
    3: READ_FILE,     /* READ_FILE & READ_FILE =3D READ_FILE */
    7: 0,             /* READ_DIR & READ_FILE =3D none (no access) */
    12: WRITE_FILE,   /* WRITE_FILE unchanged (not restricted) */
    15: 0,            /* BIND_TCP & none =3D none (network blocked) */
    20: READ_FILE     /* (READ_FILE|READ_DIR) & READ_FILE =3D READ_FILE */
}

API Design: Reusing Existing Flags
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95

/* Extended ruleset - reuse existing flags where possible */
struct landlock_ruleset_attr {
    __u64 handled_access_fs;      /* Existing: also applies to FDs */
    __u64 handled_access_net;     /* Existing: also applies to FDs */
    __u64 scoped;                 /* Existing: domain boundaries */
    __u64 handled_access_fd;      /* NEW: FD-specific operations only */
};

/* New syscalls */
long landlock_set_fd_capability(int fd, __u64 access_rights, __u32 flags);

/* Reuse existing filesystem/network flags for FD operations */
landlock_set_fd_capability(file_fd, LANDLOCK_ACCESS_FS_READ_FILE, 0);
landlock_set_fd_capability(dir_fd, LANDLOCK_ACCESS_FS_READ_DIR, 0);
landlock_set_fd_capability(sock_fd, LANDLOCK_ACCESS_NET_BIND_TCP, 0);

`=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'

With object capabilities, we assign access rights to file descriptors
directly, at open/alloc time, eliminating the need for path resolution
during future use.

This solves the core issue because:
=E2=80=A2 FDs remain valid even when disconnected, and
=E2=80=A2 Rights are bound to the object rather than its pathname.

Therefore, openat with dirfd should still work.

int dirfd =3D open(=E2=80=9C/tmp/work", O_RDONLY);        // Connected
unlink(=E2=80=9D/tmp/work");                            // Now disconnected
openat(dirfd, =E2=80=9Cfile.txt=E2=80=9D, O_RDONLY);            // Still wo=
rks, FD bound

Moreover, no path resolution is needed at a later stage and sandboxed
processes don=E2=80=99t bypass restrictions.

Would love to hear any feedback and thoughts on this.

Best,
Abhinav

[1] - <https://lore.kernel.org/all/20250719-memfd-exec-v1-0-0ef7feba5821@gm=
ail.com/>

--=-=-=--

