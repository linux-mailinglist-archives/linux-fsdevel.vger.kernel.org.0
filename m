Return-Path: <linux-fsdevel+bounces-71744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D29CCFF4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 14:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5AA63088139
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341E73242DF;
	Fri, 19 Dec 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUMNx74v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B22D7DE2
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149259; cv=none; b=YStRnlmcRulTp56qYH4ubQRUs5Ou2YwXBRZT5Rupm8FHnIpZFpVAOxVwGug56A9hqVasBYvjQixIAarBjlwPveUIFZNsk65ZUac0oIZ+qP2leYNGXossJybXv6uOYHElJA8H1iC0v05wkVHEbKwtP0y54rFaTTwTBFu8FBv8dk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149259; c=relaxed/simple;
	bh=GDOLtqKmfhq+WMcY8uYmk0+pG6qHWnMY0R2NsjdF0YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ay9YacDHqyWwyUVybX8LGCR3LZFTMN5jJD5IfCH9j3+dH+clHyj/oxy6tWh9BFeXzKZVmnU+kQoEMX9zzx6dpJvJx4V1pCIxNqpPZaAynuA/KfR2dHFJH6VRSjifDsl9BtylsUvOngx65tVI89NH0i0BQw/rNdsEIq0s0iuGWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUMNx74v; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0a95200e8so16493445ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 05:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766149255; x=1766754055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjVBhljpAn/OFs7GyqyEVP6E/FCBCWf8NQiG2o5JLRo=;
        b=nUMNx74v/lc2n5En75+lQHXIyTZ7FuuNPGGpQRenzBHlrL1STaIT/Ura6OysrSh/Rv
         Un8/wpEI6g6tYlAFvim6JZjmyUhTjZOjjKA2yOAFa4aqhk8zP1PcLaqo8ZZCxGSQbbvl
         X5Jj5vZ7T3mSCJp4iKgDKncOOD756Mszf311foi15z84dv70v1IKGtC8lM+SHsi75olH
         GP5VQY+Yyx6lEFSOMzH+1ribdyzrrIZM+kOaqUD1Xf9XMEmHHB8uIjugby+oOTy/101T
         2IapncB6BDkmh9SbkqxRVrjo2xodUH4du5SEA8JKYBzT+1OL1FhxB9cCWu/cEGy+xXZ6
         QBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766149255; x=1766754055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjVBhljpAn/OFs7GyqyEVP6E/FCBCWf8NQiG2o5JLRo=;
        b=JrDGNaGPpVmQmgeR5RE4O30trUAMfi2Nqc0da/pkGFveUBX/AS6BJis0v5lU7QEvqM
         gq0J7oBpzYVHmBhrN58J36Pu6YziRNDRYkN5PzAMRC7LuoAneXCbPYTwJ40//LLRNtc7
         CbKOVlOrgbMXmbdxEaBQx11aW5vHaonJ43tIX9ii2WNExqvZIMOIrNwQSstxgVZcJ7iz
         G3XMvKLIy6DyDhGwPPy7twSsiDQXMNrvIFK4ARoceAyKkahuaqPQmx29M4uHbtbJmC1r
         tHfiEM1hHWtPiHw3YbWvfOjgN9Ci6gAIYhv5hIEuP2+NNujWIS6oyYSSHIDjHinnLvxX
         mWyA==
X-Forwarded-Encrypted: i=1; AJvYcCVo7/Vn1r3FPAMSLPJGUc5tWrHE/YeQP0P7kKd+5wLveD0NV3FLIdmF/w9JBQZMNJJsT7K7VMZFzyYMpneT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4meXXY6rtYMbTAP+kEHw2QPi5Phj7514JhzXcWr8gLNDMrpPP
	xG6A5FVypnVN7TaJMJbAQpUm9TB7i2FO6ssMuMvtZleASBqouZgJuXGp/Nd4Daqo70WV5pRLBNW
	HKnOkh9mzPevjkrvF43+uauInnDhq4EI=
X-Gm-Gg: AY/fxX6xAEF/b1NHPxdh3MQyhkaSSvXPy3F6sCbxMBrv55uF2ODv03kIejawgYbL1BV
	1gmgDpDYE5TE3qcMSmglXe0f62q+geGxdJeZ7rXPRH86jumSCtIuTJi6BQiapuK6oLDVpHkemzY
	S9ihLmAJW8hEyvGd3EGg9D77AL9fatSqHtiXsmxtnXQsWVuDAzhlYTc1kvumfDHb6LeMmxk5jrN
	+B9xWpU/ah4jcLXMfylGJXeCXzg5Ns9XiAqwqFp43LBM8K/4kGN7oGvC184aPsLQGp2E2I=
X-Google-Smtp-Source: AGHT+IEWn0ksq41hYEERl42v86xzPhaMhaQClDtnCMtJIEG3edwUb4LisK/+vBZkJTHqMDCdoT66Yk/7nadFpzppcKw=
X-Received: by 2002:a05:7022:e1b:b0:11b:b622:cad9 with SMTP id
 a92af1059eb24-121722b44a8mr3580013c88.21.1766149254711; Fri, 19 Dec 2025
 05:00:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215215301.10433-2-slava@dubeyko.com> <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
 <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com> <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
 <CAOi1vP_y+UT8yk00gxQZ7YOfAN3kTu6e6LE1Ya87goMFLEROsw@mail.gmail.com> <CA+2bHPYp-vcorCDEKU=3f6-H2nj5PHT=U_4=4pmO5bihiDStrA@mail.gmail.com>
In-Reply-To: <CA+2bHPYp-vcorCDEKU=3f6-H2nj5PHT=U_4=4pmO5bihiDStrA@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 19 Dec 2025 14:00:43 +0100
X-Gm-Features: AQt7F2pbo-xUw68ywJhalgwP0mmxXVRw88E_uPQoMCJhTCP1i5sZiX1Q3V6n9Bw
Message-ID: <CAOi1vP8o7NAmrHi96UJ8B8DxFSHCgiczDCU=r2TAVn2oi1VD8A@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	Kotresh Hiremath Ravishankar <khiremat@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 7:08=E2=80=AFPM Patrick Donnelly <pdonnell@redhat.c=
om> wrote:
>
> On Thu, Dec 18, 2025 at 5:31=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com>=
 wrote:
> >
> > On Thu, Dec 18, 2025 at 4:50=E2=80=AFAM Patrick Donnelly <pdonnell@redh=
at.com> wrote:
> > > > >  Suggest documenting (in the man page) that
> > > > > mds_namespace mntopt can be "*" now.
> > > > >
> > > >
> > > > Agreed. Which man page do you mean? Because 'man mount' contains no=
 info about
> > > > Ceph. And it is my worry that we have nothing there. We should do s=
omething
> > > > about it. Do I miss something here?
> > >
> > > https://github.com/ceph/ceph/blob/2e87714b94a9e16c764ef6f97de50aecf1b=
0c41e/doc/man/8/mount.ceph.rst
> > >
> > > ^ that file. (There may be others but I think that's the main one
> > > users look at.)
> >
> > Hi Patrick,
> >
> > Is that actually desired?  After having to take a look at the userspace
> > code to suggest the path forward in the thread for the previous version
> > of Slava's patch, I got the impression that "*" was just an MDSAuthCaps
> > thing.  It's one of the two ways to express a match for any fs_name
> > (the other is not specifying fs_name in the cap at all).
>
> Well, '*' is not a valid name for a file system (enforced via
> src/mon/MonCommands.h) so it's fairly harmless to allow. I think there

By "allow", do you mean "handle specially"?  AFAIU passing "-o
mds_namespace=3D*" on mount is already allowed in the sense that the
value (a single "*" character) would be accepted and then matched
literally against the names in the fsmap.  Because "*" isn't a valid
name, such an attempt to mount is guaranteed to fail with ENOENT.

> is a potential issue with "legacy fscid" (which indicates what the
> default file system to mount should be according to the ceph admin).
> That only really influences the ceph-fuse client I think because --
> after now looking at the kernel code -- it seems the kernel just
> mounts whatever it can find in the FSMap if no mds_namespace is
> specified. (If it were to respect the configured legacy file system,
> it should sub to "mdsmap" if no mds_namespace is specified. s.f.
> src/mon/MDSMonitor.cc)

In create_fs_client() the kernel asks for an unqualified mdsmap if
no mds_namespace is specified:

    if (!fsopt->mds_namespace) {
            ceph_monc_want_map(&fsc->client->monc, CEPH_SUB_MDSMAP,
                               0, true);
    } else {
            ceph_monc_want_map(&fsc->client->monc, CEPH_SUB_FSMAP,
                               0, false);
    }

I thought a subscription for an unqualified mdsmap (i.e. a generic
"mdsmap" instead of a specific "mdsmap.<fscid>") was how the default
filesystem thing worked.  Does this get overridden somewhere or am
I missing something else?

>
> So I think there is a potential for "*" to be different from nothing.
> The latter is supposed to be whatever the legacy fscid is.

Are you stating this in the context of mounting or in the context of
the MDS auth cap matching?  In my previous message, I was trying to
separate the case of mounting (where the name can be supplied by the
user via mds_namespace option) from the case of ceph_mds_auth_match()
where the name that is coming from the mdsmap is matched against the
name in the cap.  AFAIU in userspace "*" has special meaning only in
the latter case.

>
> Slava: I also want to point out that ceph_mdsc_handle_fsmap should
> also be calling namespace_equals (it currently duplicates the old
> logic).
>
> > I don't think this kind of matching is supposed to occur when mounting.
> > When fs_name is passed via ceph_select_filesystem() API or --client_fs
> > option on mount it appears to be a literal comparison that happens in
> > FSMapUser::get_fs_cid().
>
> Sorry, are you mixing the kernel and C++? I'm not following.

I'm trying to ensure that we don't introduce an unnecessary discrepancy
in behavior between the kernel client and the userspace client/gateways.
If passing "*" for fs_name is a sure way to make Client::mount() fail
with ENOENT in userspace, the kernel client shouldn't be doing (and on
top of that documenting) something different IMO.

Thanks,

                Ilya

