Return-Path: <linux-fsdevel+bounces-71791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FABFCD237B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 00:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38A5E3042802
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 23:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE342C158D;
	Fri, 19 Dec 2025 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8bup+hi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbmDdrvD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56892E764B
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766188731; cv=none; b=iDRPjCLVf436HopLk+L5ZdtNYxNEwIcqZ3ow6xGUrMdyvEmPQcBm2Ck63K647WclRBsHZVuTggAOI3J32dxUKiwdux2ocKGUT1QeQQRTDJVdxyiWKT3PITI1AG4IeSYingHHHHp3GyiivI5af+i1dXaVJ8sXwXlo+UG6Pv1uDsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766188731; c=relaxed/simple;
	bh=3u+wRxvSnBu2DYnRS5qezVpOYUKFtp8f+0DURL13tJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aM6ghZN6jtaJldN9xdduDQ5jLUTk5qpi73m5GymdPwiAr6bmza1tRqATUg9xUKP7vMyim20k8+oqz2qyWe/B3LlHa8q77sBl9dzc4WCg9znI/+HkspCuIuqqUhiZWIKaq/H6h/cDgNsFoXkxR/peGH64nYUttDipqSHRtqHa/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8bup+hi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbmDdrvD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766188727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rk8dyP1U3BGhjW2OLLawRUf26Ox6mt0Bj/ji5DJjy0w=;
	b=c8bup+hicanJdcSLVbO0F7/hLaSRiTRI21qpPwunGMCTW9PE2V2ZwSmDgYkuQg6mVpKeaa
	RLEAt3KVr4V/CJ48B+Yi4S7IKJfW7pPNJ2a3Q2wBUCbt4MhXSE0Rk4OucXlshOdLjacGvI
	nmBFmX75Qet4DcIMIq4Nl6qVVf0ofok=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-DMPHQW7xMWa-JzllCXrHpw-1; Fri, 19 Dec 2025 18:58:46 -0500
X-MC-Unique: DMPHQW7xMWa-JzllCXrHpw-1
X-Mimecast-MFC-AGG-ID: DMPHQW7xMWa-JzllCXrHpw_1766188726
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65b26eca9c7so3677126eaf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 15:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766188725; x=1766793525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk8dyP1U3BGhjW2OLLawRUf26Ox6mt0Bj/ji5DJjy0w=;
        b=fbmDdrvD7H1a/Rpvod9PomL9fnjdfhoapu+F3k39Op4BvzJid5LUYqPl46C1UYfBMJ
         5Kv/R0J3tOtmqjHaQ0dS6ASJYIFQ3s8q78t3XM3E48p7lvtXhyiODU9qraJknmawe1mI
         9Tt0ToPQxeJeaNlfzUEActX3y24HF5evBsGC/fLSzgzKbCZS455gOuMSecSH79/geF6F
         1OrV22sX1Bs8uDen0E8y3zwHIzKBgQlW+mwcvFSkuU1MKlwokJjb6zCMHzXzgTg/qZ5/
         bH20s7WCiaF0NF6wEvyzQeExNFpLaYqAzKj9NqsvMifloK8SuTGG8BSZHQ5GJ4IXcx+Z
         7GVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766188725; x=1766793525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rk8dyP1U3BGhjW2OLLawRUf26Ox6mt0Bj/ji5DJjy0w=;
        b=azkVB2oZT5ddpeHHJnDKFMVsJwb0TCnprB0gOu20CSIg+Dv1Aqm/CN+Zdf8DPBbMlF
         AFeK0kVDwuGWyoOT5i8dhA2d9HGB3pJUn4KP7ALL/gRxoKjadpig8fveUFNf/234TwWx
         PqKhGBOFe7K89ELQMkfEjTHcIFDFDS5t6TSukEwVMylBS7qtFksNDVlC+SBnaAYnQRPJ
         fxUyjje3Xd248dehNDgTU6PhWoL7As6oXn6De00jDIvO6piGzMhl+ztCpTDV5qVZf3Ex
         Dc8OjrBz3QOelk5cfOlgDijzJ12uXBFuZOq+sy72ly8854ZvZ93bnZb3RAEp+cuHl51/
         SoTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAzgakByzR8+Phjvdz4ouKv008fL8MirR4OJjOvONTT61FXSx1vnDbYdNUbZwRX2kwc80jzTe0KGNyr+DD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb427BvhlALC/zUQ7VXc+0SqbtX6otcBJbXacmfJgy1GnoY196
	Pn94WG/41GlAv+h6QglIZLEF6shQfO31kEwn6nWGVA/+izsGTw+ZFRNAnmIJtCx9JXEmDES0TM6
	B/RA7XghyLYMNRPpopFRwGBJo3d3LZu1i5JEqpZ+wxoPXG5VmZ7OjOTLJTwi4LFJTa9dWSXHFvH
	A043QMWThG5phkbPraOCCVjAOWjyucG8txtDFh9uxfeQ==
X-Gm-Gg: AY/fxX5HKMzP5/dyDFWvFj1xorDPH1zHVXU3Xbh7ek87bzlVfjhjG4AAYQQ4YZYDjuB
	WO4KL7w/9H5jKQtVgjhG7sXNZQ4kfQcM/+1C+mrH7F3lYvZWvmXWdqVz3xqAXR08v7mtDnql9a5
	v0OeWnGasejFgWQoF+qv6C+mn2GYMJKc/DNJ/PWki+mhSyclsQgPFSlTcoxRjS0ihVpCf6YQ5/p
	P5SPBy4s+eLkVCY2WaLvGW0vQ==
X-Received: by 2002:a05:6820:6381:b0:65b:31cf:ca92 with SMTP id 006d021491bc7-65d0eb4d653mr1271495eaf.84.1766188725644;
        Fri, 19 Dec 2025 15:58:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA3RVT/hPLpqrv6NTSpuR3bzXU3BTHq6KK23XsClo5T9r8b1/qe4V6MAkyTtjGtXHF7pqMXsvM9f2tlcbdlXQ=
X-Received: by 2002:a05:6820:6381:b0:65b:31cf:ca92 with SMTP id
 006d021491bc7-65d0eb4d653mr1271489eaf.84.1766188725284; Fri, 19 Dec 2025
 15:58:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215215301.10433-2-slava@dubeyko.com> <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
 <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com> <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
 <CAOi1vP_y+UT8yk00gxQZ7YOfAN3kTu6e6LE1Ya87goMFLEROsw@mail.gmail.com>
 <CA+2bHPYp-vcorCDEKU=3f6-H2nj5PHT=U_4=4pmO5bihiDStrA@mail.gmail.com>
 <CAOi1vP8o7NAmrHi96UJ8B8DxFSHCgiczDCU=r2TAVn2oi1VD8A@mail.gmail.com>
 <CA+2bHPb41OinL5E_HXpXTGww2WWqEU3k06JfVHZ9joUQuYsBPg@mail.gmail.com> <7d1f950f242b748b16acb88a92e062206628cd35.camel@ibm.com>
In-Reply-To: <7d1f950f242b748b16acb88a92e062206628cd35.camel@ibm.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Fri, 19 Dec 2025 18:58:19 -0500
X-Gm-Features: AQt7F2qxAGvLoyudmB7kefd92tNMjPgsCxKXQXYC6Jb4YBC2eEDBrrILcl6XNow
Message-ID: <CA+2bHPaFSheGxMvZWuk5OYWrGk3KzOmSSNRoMUNEY=og_uHkxg@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, Kotresh Hiremath Ravishankar <khiremat@redhat.com>, 
	Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, Alex Markuze <amarkuze@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 3:44=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Fri, 2025-12-19 at 08:21 -0500, Patrick Donnelly wrote:
> > On Fri, Dec 19, 2025 at 8:01=E2=80=AFAM Ilya Dryomov <idryomov@gmail.co=
m> wrote:
> > >
> > > On Thu, Dec 18, 2025 at 7:08=E2=80=AFPM Patrick Donnelly <pdonnell@re=
dhat.com> wrote:
> > > >
> > > > On Thu, Dec 18, 2025 at 5:31=E2=80=AFAM Ilya Dryomov <idryomov@gmai=
l.com> wrote:
> > > > >
> > > > > On Thu, Dec 18, 2025 at 4:50=E2=80=AFAM Patrick Donnelly <pdonnel=
l@redhat.com> wrote:
> > > > > > > >  Suggest documenting (in the man page) that
> > > > > > > > mds_namespace mntopt can be "*" now.
> > > > > > > >
> > > > > > >
> > > > > > > Agreed. Which man page do you mean? Because 'man mount' conta=
ins no info about
> > > > > > > Ceph. And it is my worry that we have nothing there. We shoul=
d do something
> > > > > > > about it. Do I miss something here?
> > > > > >
> > > > > > https://github.com/ceph/ceph/blob/2e87714b94a9e16c764ef6f97de50=
aecf1b0c41e/doc/man/8/mount.ceph.rst
> > > > > >
> > > > > > ^ that file. (There may be others but I think that's the main o=
ne
> > > > > > users look at.)
> > > > >
> > > > > Hi Patrick,
> > > > >
> > > > > Is that actually desired?  After having to take a look at the use=
rspace
> > > > > code to suggest the path forward in the thread for the previous v=
ersion
> > > > > of Slava's patch, I got the impression that "*" was just an MDSAu=
thCaps
> > > > > thing.  It's one of the two ways to express a match for any fs_na=
me
> > > > > (the other is not specifying fs_name in the cap at all).
> > > >
> > > > Well, '*' is not a valid name for a file system (enforced via
> > > > src/mon/MonCommands.h) so it's fairly harmless to allow. I think th=
ere
> > >
> > > By "allow", do you mean "handle specially"?  AFAIU passing "-o
> > > mds_namespace=3D*" on mount is already allowed in the sense that the
> > > value (a single "*" character) would be accepted and then matched
> > > literally against the names in the fsmap.  Because "*" isn't a valid
> > > name, such an attempt to mount is guaranteed to fail with ENOENT.
> >
> > Yes, correct.
> >
> > > > is a potential issue with "legacy fscid" (which indicates what the
> > > > default file system to mount should be according to the ceph admin)=
.
> > > > That only really influences the ceph-fuse client I think because --
> > > > after now looking at the kernel code -- it seems the kernel just
> > > > mounts whatever it can find in the FSMap if no mds_namespace is
> > > > specified. (If it were to respect the configured legacy file system=
,
> > > > it should sub to "mdsmap" if no mds_namespace is specified. s.f.
> > > > src/mon/MDSMonitor.cc)
> > >
> > > In create_fs_client() the kernel asks for an unqualified mdsmap if
> > > no mds_namespace is specified:
> > >
> > >     if (!fsopt->mds_namespace) {
> > >             ceph_monc_want_map(&fsc->client->monc, CEPH_SUB_MDSMAP,
> > >                                0, true);
> > >     } else {
> > >             ceph_monc_want_map(&fsc->client->monc, CEPH_SUB_FSMAP,
> > >                                0, false);
> > >     }
> > >
> > > I thought a subscription for an unqualified mdsmap (i.e. a generic
> > > "mdsmap" instead of a specific "mdsmap.<fscid>") was how the default
> > > filesystem thing worked.  Does this get overridden somewhere or am
> > > I missing something else?
> >
> > Ah, I didn't see that code. Yes, this looks right then.
> >
> > > >
> > > > So I think there is a potential for "*" to be different from nothin=
g.
> > > > The latter is supposed to be whatever the legacy fscid is.
> > >
> > > Are you stating this in the context of mounting or in the context of
> > > the MDS auth cap matching?
> >
> > mounting.
> >
> > >  In my previous message, I was trying to
> > > separate the case of mounting (where the name can be supplied by the
> > > user via mds_namespace option) from the case of ceph_mds_auth_match()
> > > where the name that is coming from the mdsmap is matched against the
> > > name in the cap.  AFAIU in userspace "*" has special meaning only in
> > > the latter case.
> >
> > I understand what you've been saying. I contend that treating "*"
> > specially for mds_namespace mntopt could be useful: you can select
> > *any* available file system even if none of them are marked as the
> > legacy fscid.
> >
> > Big picture I don't think this matters much. It'd probably be better
> > to only use namespace_equals (no "*" handling) for mntopt matching and
> > something else for the mds auth cap matching (yes "*" handling).
> >
> > > > Slava: I also want to point out that ceph_mdsc_handle_fsmap should
> > > > also be calling namespace_equals (it currently duplicates the old
> > > > logic).
> > > >
> > > > > I don't think this kind of matching is supposed to occur when mou=
nting.
> > > > > When fs_name is passed via ceph_select_filesystem() API or --clie=
nt_fs
> > > > > option on mount it appears to be a literal comparison that happen=
s in
> > > > > FSMapUser::get_fs_cid().
> > > >
> > > > Sorry, are you mixing the kernel and C++? I'm not following.
> > >
> > > I'm trying to ensure that we don't introduce an unnecessary discrepan=
cy
> > > in behavior between the kernel client and the userspace client/gatewa=
ys.
> > > If passing "*" for fs_name is a sure way to make Client::mount() fail
> > > with ENOENT in userspace, the kernel client shouldn't be doing (and o=
n
> > > top of that documenting) something different IMO.
> >
> > I wouldn't suggest the kernel change without also updating userspace.
> > In any case, we can drop the suggestion.
>
> OK. Finally, I assume that we agreed to drop: "Suggest documenting (in th=
e man
> page) that
> mds_namespace mntopt can be "*" now." Am I correct? :)

Not just documentation but in the code too. namespace_equals should
only be used for comparisons with the mds_namespace mntopt.

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


