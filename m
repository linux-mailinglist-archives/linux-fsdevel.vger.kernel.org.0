Return-Path: <linux-fsdevel+bounces-70450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67378C9B514
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 12:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1FE3A1A06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D52307AF0;
	Tue,  2 Dec 2025 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htDmP6kz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980F3284662
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764675046; cv=none; b=Qk+pmhg9gVFl1UHQnO3GxJtM7fX3sQPijbIA3OFQwIAXAX5nwW3g2Dpdu1qx3ObQ9j6aQb1x2tSl4JBW9y7JxQ2QSHpl4O1Azlf1yPxqz7nr0Ay4+ILKjTG15QFmPysXDhkWxYrsgQrHQ94NitTFp/ob6+gYbIaxHmOs48IsWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764675046; c=relaxed/simple;
	bh=+Sx+uRurl6L1917SkUhGcr/1xP7AMJIrdUo5cOEVdWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUNTXTgguVxMPf8jX+iSZBhArM9/inNSaDp1U0epBbU7ITRIolq/If2SGaXpsUhdAl9kotw74SIOAIYcEc1D+3oN4dOarCAxIvOwmPOd87qeXZLCTvRW+20ZDAkVXPu2PRzKq0jO31rC043iAQxxJaFcaAh1xivvUK3GNzHyPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htDmP6kz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc169af247eso4353883a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 03:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764675044; x=1765279844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3KxX8uJD3ZpwwPehQ2ctjG2wl3hGsqn91v1v6JwRsA=;
        b=htDmP6kzCgGmjKs1yIzIMkkvIFrCAF7YbS6cnNf7h1CwrzQrxTeaIXBAebwVK5R8R8
         rvby54ayYz7pyC7UhLQb6Gdyd++leOYUAplgQgjwSgkSrNlJrKz1zDghJg68e2WAGDK+
         Z4N78hH5E+L1PvSalRJyLW75qsweynqxBEg42hhXzn7pcylRBz6iEVTW6c3yDdaM5u0p
         H9L9Qlevt7DzdePbf+7fmkWE8gOh57asTrHJHDQMTK/GuBikCFYNG3n9WOMrjzPkPTNV
         VNNLCQEbCRtB6Bq69YtLZYHibzfbZV6gdG/tx/juwD4W37ly7OXyFCJk9P5egWEdAocX
         itwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764675044; x=1765279844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d3KxX8uJD3ZpwwPehQ2ctjG2wl3hGsqn91v1v6JwRsA=;
        b=hWtgK5Yp4xsj/3zGCkr2Knrn+zVlzaz1FVorgxlPFkRV/Q3kf3kgrgycOFYPE1Tjfu
         q5Wf7XBypSZ+wBom7uNDSDd2lp85vdWLtGaN2s+/iYbI3uQtaNJ/N4WtidHVhtSMfcR0
         6l3eFbHG70sAvl47tk4iUMvkcv4MTFJRS+cyI7Ln8XPPX8r5V7kYYVcrAmjBH/+nAKYG
         9zKo8lRPTKjO28nnkXrfWEvzvoIj6GidNRcE+igl8E10KRnwcsbleKnd+tMpkhnyPPbg
         4B9br3CnTAjrVsduVHAnr+ofHkZ7c8BDoZOYyYbVcIMp8eV5e9JSDZ5K8P57idqr2nyF
         acyg==
X-Forwarded-Encrypted: i=1; AJvYcCV1k11FJ0pbnXjRut5S4qozaqcXNWgQMj77ePE67Yh87aFF3ZILBq1Y7yIPmDOAR3QbtzJjtXK4leJaW3zn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43hpCp5Y79DAHNcqTovZHNsaRH3EiTupybeVgdjm8GLi1eV9N
	r9soDtTK6UUthpa0IJ5W/eqMOI62ziW0j3YnbtGnA75JPy132k2b+BxYiBy7MhnfBdqFQK8sDwR
	LxL9bPpo0xBLa22fECFLT7usWi/Di+gk=
X-Gm-Gg: ASbGnctzLZWO92dE8fD6iwM2eXQiTyTdIfE2lSLMV62XWqvh8VzguqzI7x+CjOjFPsz
	eCT29s8gzr6jMq5tDd2sT1QVfe3KsDkPacb09E7fZQEK8gPT3fN0GAOgzt5tw6Y4F99hY96BV4O
	PMGY9089z99OesYk6DYY1A/fQCdHpwPsRGL+S7aV3W3YiLxX+1iwZ3BgJvpEqlZiYhAUwh5mLvJ
	dE9HdmqVpHx0gHsuewW6U/kPwcLhL/tadL4IhiaE6AuJWLbQ0xe8Wopktz4tXFesdErWBxLGj9y
	s+tJ1w==
X-Google-Smtp-Source: AGHT+IEQJwZnePTmOTu9jfQ5xqJINV7OLC6ws6yB9jT+cluDeJU0QH3VHTjdTacDc+PRvVyiMQ1dK0js2ActnILh8Pc=
X-Received: by 2002:a05:7300:824b:b0:2a4:3593:9689 with SMTP id
 5a478bee46e88-2a7190738f7mr25603581eec.6.1764675043634; Tue, 02 Dec 2025
 03:30:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119193745.595930-2-slava@dubeyko.com> <CAOi1vP-bjx9FsRq+PA1NQ8fx36xPTYMp0Li9WENmtLk=gh_Ydw@mail.gmail.com>
 <fe7bd125c74a2df575c6c1f2d83de13afe629a7d.camel@ibm.com> <CAJ4mKGZexNm--cKsT0sc0vmiAyWrA1a6FtmaGJ6WOsg8d_2R3w@mail.gmail.com>
 <370dff22b63bae1296bf4a4c32a563ab3b4a1f34.camel@ibm.com> <CAPgWtC58SL1=csiPa3fG7qR0sQCaUNaNDTwT1RdFTHD2BLFTZw@mail.gmail.com>
 <183d8d78950c5f23685c091d3da30d8edca531df.camel@ibm.com> <CAPgWtC7AvW994O38x4gA7LW9gX+hd1htzjnjJ8xn-tJgP2a8WA@mail.gmail.com>
 <9534e58061c7832826bbd3500b9da9479e8a8244.camel@ibm.com> <CAPgWtC5Zk7sKnP_-jH3Oyb8LFajt_sXEVBgguFsurifQ8hzDBA@mail.gmail.com>
 <6b405f0ea9e8cb38238d98f57eba9047ffb069c7.camel@ibm.com>
In-Reply-To: <6b405f0ea9e8cb38238d98f57eba9047ffb069c7.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 2 Dec 2025 12:30:30 +0100
X-Gm-Features: AWmQ_bmG2ynj2stJQogfVMnMfiusmEESpf0o7xZjp3UqGCY0T6iqifACvj6tN_g
Message-ID: <CAOi1vP83qU-J4b1HyQ4awYN_F=xQAaP8dGYFfXxnxoryBC1c7w@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>, Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	Patrick Donnelly <pdonnell@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Gregory Farnum <gfarnum@redhat.com>, 
	Alex Markuze <amarkuze@redhat.com>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	Venky Shankar <vshankar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 9:04=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> On Thu, 2025-11-27 at 13:03 +0530, Kotresh Hiremath Ravishankar wrote:
> > On Tue, Nov 25, 2025 at 2:42=E2=80=AFAM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> > >
> > > On Tue, 2025-11-25 at 00:48 +0530, Kotresh Hiremath Ravishankar wrote=
:
> > > > On Fri, Nov 21, 2025 at 1:47=E2=80=AFAM Viacheslav Dubeyko
> > > > <Slava.Dubeyko@ibm.com> wrote:
> > > > >
> > > > > On Thu, 2025-11-20 at 19:50 +0530, Kotresh Hiremath Ravishankar w=
rote:
> > > > > > Hi All,
> > > > > >
> > > > > > I think the patch is necessary and fixes the crash. There is no=
 harm
> > > > > > in taking this patch as it behaves like an old kernel with this
> > > > > > particular scenario.
> > > > > >
> > > > > > When does the issue happen:
> > > > > >    - The issue happens only when the old mount syntax is used w=
here
> > > > > > passing the file system name is optional in which case, it choo=
ses the
> > > > > > default mds namespace but doesn't get filled in the
> > > > > > mdsc->fsc->mount_options->mds_namespace.
> > > > > >    - Along with the above, the mount user should be non admin.
> > > > > > Does it break the earlier fix ?
> > > > > >    - Not fully!!! Though the open does succeed, the subsequent
> > > > > > operation like write would get EPERM. I am not exactly able to
> > > > > > recollect but this was discussed before writing the fix 22c73d5=
2a6d0
> > > > > > ("ceph: fix multifs mds auth caps issue"), it's guarded by anot=
her
> > > > > > check before actual operation like write.
> > > > > >
> > > > > > I think there are a couple of options to fix this cleanly.
> > > > > >  1. Use the default fsname when
> > > > > > mdsc->fsc->mount_options->mds_namespace is NULL during comparis=
on.
> > > > > >  2. Mandate passing the fsname with old syntax ?
> > > > > >
> > > > >
> > > > > Anyway, we should be ready operate correctly if fsname or/and aut=
h-
> > > > > > match.fs_name are NULL. And if we need to make the fix more cle=
anly, then we
> > > > > can introduce another patch with nicer fix.
> > > > >
> > > > > I am not completely sure how default fsname can be applicable her=
e. If I
> > > > > understood the CephFS mount logic correctly, then fsname can be N=
ULL during some
> > > > > initial steps. But, finally, we will have the real fsname for com=
parison. But I
> > > > > don't know if it's right of assuming that fsname =3D=3D NULL is e=
qual to fsname =3D=3D
> > > > > default_name.
> > > >
> > > > We are pretty sure fsname is NULL only if the old mount syntax is u=
sed
> > > > without providing the
> > > > fsname in the optional arg. I believe kclient knows the fsname that=
's
> > > > mounted somewhere in this case ?
> > > > I am not sure though. If so, it can be used. If not, then can we re=
ly
> > > > on what mds sends as part
> > > > of the mdsmap?
> > > >
> > > >
>
> <skipped>
>
> > >
> > > > >
> > > > > And I am not sure that we can mandate anyone to use the old synta=
x. If there is
> > > > > some other opportunity, then someone could use it. But, maybe, I =
am missing the
> > > > > point. :) What do you mean by "Mandate passing the fsname with ol=
d syntax"?
> > > >
> > > > In the old mount syntax, the fsname is passed as on optional argume=
nt
> > > > using 'mds_namespace'.
> > > > I was suggesting to mandate it if possible. But I guess it breaks
> > > > backward compatibility.
> > > >
> > > > >
> > > > >
> > >
> > > We had a private discussion with Ilya. Yes, he also mentioned the bre=
aking of
> > > backward compatibility for the case of mandating passing the fsname w=
ith old
> > > syntax. He believes that: "Use the default fsname when mdsc->fsc->mou=
nt_options-
> > > > mds_namespace is NULL during comparison seems like a sensible appro=
ach to me".
> > >
> > >
>
> OK. So, what finally should we consider like a right solution/fix here?

Hi Slava,

I think the right solution would be a patch that establishes
consistency with the userspace client.  What does ceph-fuse do when
--client_fs option isn't passed?  It's the exact equivalent of
mds_namespace mount option (--client_mds_namespace is what it used to
be named), so the kernel client just needs to be made to do exactly the
same.

After taking a deeper look I doubt that using the default fs_name for
the comparison would be sufficient and not prone to edge cases.  First,
even putting the NULL dereference aside, both the existing check by
Kotresh

    if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name))
        /* mismatch */

and your proposed check

    if (!fs_name1 || !fs_name2)
        /* match */

    if (strcmp(fs_name1, fs_name2))
        /* mismatch */

aren't equivalent to

  bool match_fs(std::string_view target_fs) const {
    return fs_name =3D=3D target_fs || fs_name.empty() || fs_name =3D=3D "*=
";
  }

in src/mds/MDSAuthCaps.h -- "*" isn't handled at all.

Second, I'm not following a reason to only "validate" fs_name against
mds_namespace option in ceph_mdsmap_decode().  Why not hold onto it and
actually use it in ceph_mds_auth_match() for the comparison as done in
src/client/Client.cc?

int Client::mds_check_access(std::string& path, const UserPerm& perms, int =
mask)
{
  ...
  std::string_view fs_name =3D mdsmap->get_fs_name();   <---------
  for (auto& s: cap_auths) {
    ...
    if (s.match.match(fs_name, path, perms.uid(), perms.gid(), &gid_list)) =
{
      /* match */

AFAIU the default fs_name would come into the picture only in case of
a super ancient cluster with prior to mdsmap v8 encoding.

I haven't really looked at this code before, so it's possible that
there are other things that are missing/inconsistent here.  I'd ask
that the final patch is formally reviewed by Venky and Patrick as
they were the approvers on https://github.com/ceph/ceph/pull/64550
in userspace.

Thanks,

                Ilya

