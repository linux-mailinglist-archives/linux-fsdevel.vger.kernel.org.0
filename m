Return-Path: <linux-fsdevel+bounces-69985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A18AFC8D1F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 08:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E690234882B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 07:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DED23203A1;
	Thu, 27 Nov 2025 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxOcl3QK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TacY8a3N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B720D31A553
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228819; cv=none; b=OJxOIBD13VJ2vNl0FB6WiJfOEB7yR9da6nk+WHfQbtNretKk5P3sMGXPVSQAxe9WFvMEOZdr48c7BG1X7cR+rzq5vuixeRAxK7j71YLL12oO8k2vM68Sr5gUv2zZVq6ZSqf99qKkWWfR4z2lfYwgEf9dyxw0uPCsqOCAtEC/ZSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228819; c=relaxed/simple;
	bh=6jR6xxXQUzFxSTwOJzz2synniUy/PizBDW3HKJRrliM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyPSdojGtKdVwAXo088imFrmrkWpX4RqnuzbewsAxesokTqInzHZS8hnZZjBfE4IXzvTRw32xWrZURveHwax9Ke4NokIaHAcjGXQZnLy1UJJ9znA5YyTYsLtDacm3xbKt7AnTqaqZDVATvxyyhaT1q4s0JTOpFz11nSWK36VKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxOcl3QK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TacY8a3N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764228812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vD20zSbyf5srVFgQ/UrB7jMoVAMrIvVEXIiFe6qOWwU=;
	b=WxOcl3QKGa7aBDRsqaElTdLM72w8BecbcpssG8mEyWUTiw3M51UTyavc7csk3ii5wRCx0L
	wA+28DC4uyxMj9GaBI2ey38SkAp1E/6C9ttNppESZ+QWx/XNmfyZDH/SBUAhu4ZF6gnnkn
	pI7fP8brtJYD5873+G6YhnC+8ulD6LY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-OjgJ09hCP-mrMWTV42vfLg-1; Thu, 27 Nov 2025 02:33:30 -0500
X-MC-Unique: OjgJ09hCP-mrMWTV42vfLg-1
X-Mimecast-MFC-AGG-ID: OjgJ09hCP-mrMWTV42vfLg_1764228809
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3416dc5752aso1514763a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 23:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764228809; x=1764833609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vD20zSbyf5srVFgQ/UrB7jMoVAMrIvVEXIiFe6qOWwU=;
        b=TacY8a3NPOfTJAXsfS7kx8I1ywcxJcXfVQP2omR9LjZ1Vc/myeFIRpGZMsa3pj+Bwp
         eYXjxGit/b+wnFkoJ1yifdJoOt0oI/2EwNPM9Ug7jghvaRn+r6QnhFC0mvxVrbVpTTgW
         Z48u2OBYQ1vrfoP7L5Rmd0gpNPVQGPJjsMEVmBZt0gy5W/YLklF59NJYER7sIUHP3Xhq
         rWy8xaBnYtZReY7CEOlq1UwhZqs/a2r0ABDqchzmzazfP3XQaQqXXTV75laMu9b1le+G
         wNajeUvfXIS1+Ki6ohowar/aFrOk5QlOAc8kQ3A5VDqHkXKdCWeFAaCMuMCI2mD9RM1j
         U3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764228809; x=1764833609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vD20zSbyf5srVFgQ/UrB7jMoVAMrIvVEXIiFe6qOWwU=;
        b=mdPPCWdi2uVCmpHXTMqhGlgZfKt+Ttb256FG52RIs2LWMPHbizP+T8JFfvhDxVB8J4
         Z5DvJmnI0k5IDIvpRlWOPbIxvbB5Uaecl6QhchTsN8UQoOG7Osy03rULGi7SRVJs4Lwj
         ef0P84nanJYqbcCJ4rai2p246PXE1Yw7oF82CCuatQRBVYMo+splnlXZNiFWsR9tlqdF
         LNVOxkGRo2lBb0zrytbqbpPc5eqKF1CUHT3jqPnev36tf7CpjOw7JgpwqUhKa7UjLDui
         VrjeF1xTkjq44GZ+bLg9SIx85cTPdQDbS/EW5I1QYcrPXUTNvVn6SD9nQbTIVsEZVqGy
         pQSw==
X-Forwarded-Encrypted: i=1; AJvYcCV+ef0Q6EXGvZWSMV/1DpgwqaKA3ZOMx57dWSmZy4h25GfTalkaghWpVhXK6nQAxdFZcjTKtuFgrdpiuLXc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx8LmPGfW+MFhI05xRRSPUL7hTxTuKxFonG/qJi9qPL/0+ES1D
	GT4eC9blin+TShgb0KU6nnMnIhOukkfkdiID2jXr4Lf+MpG+6XanW+i8Ei91scl0Ulqv/XepGWZ
	T8FNBls6o63wzZ2mqmPJQWiRDgXnBejOHCGE/o0l0d37br4dtm+nY3Km6CycjOk5fqWOAIfsdwx
	WwfGCto2nK3SODfAqLXunA7pgT2bXikyswX5Daq0JO
X-Gm-Gg: ASbGncsWrJacnMBOPfza9F4+4mP+VGvXIYUStjDwlqGKW8J0cr9dQ5od0SJErI9JgzH
	RSYO0mrDHtUNkVKpubHWVC3l3nqXeG4HjdsknOQ9a5yEt4G7ogoob29frbZOdi9FcLp01RVizKu
	nD/sZsAL291n0CDQy8zfasTgZ0TGj5zkAcyWYqZbcH6V33os5VO4nfNAxy5VdEi+mZkLz+5yezv
	+msPwiYGcoRe9/oAOy27sz+Dg==
X-Received: by 2002:a17:90b:2d8e:b0:330:84c8:92d0 with SMTP id 98e67ed59e1d1-3475ed46424mr11161550a91.24.1764228808034;
        Wed, 26 Nov 2025 23:33:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFailW/JPgQ4c8UrCCfBa+cxrOWJK1ypafZGSVHTRJHSPXYS4nHfsW2zWhzXnjdLVFSq8BQi/ZgO3Z/vcjR2Ls=
X-Received: by 2002:a17:90b:2d8e:b0:330:84c8:92d0 with SMTP id
 98e67ed59e1d1-3475ed46424mr11161520a91.24.1764228807264; Wed, 26 Nov 2025
 23:33:27 -0800 (PST)
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
 <9534e58061c7832826bbd3500b9da9479e8a8244.camel@ibm.com>
In-Reply-To: <9534e58061c7832826bbd3500b9da9479e8a8244.camel@ibm.com>
From: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
Date: Thu, 27 Nov 2025 13:03:15 +0530
X-Gm-Features: AWmQ_blxEGfhAiQ8jDy5tJOT0wIN2FjdnsYU4LJlfo8i9a749R9uzn5Up_ROFY4
Message-ID: <CAPgWtC5Zk7sKnP_-jH3Oyb8LFajt_sXEVBgguFsurifQ8hzDBA@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	Patrick Donnelly <pdonnell@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, 
	Alex Markuze <amarkuze@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 2:42=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Tue, 2025-11-25 at 00:48 +0530, Kotresh Hiremath Ravishankar wrote:
> > On Fri, Nov 21, 2025 at 1:47=E2=80=AFAM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> > >
> > > On Thu, 2025-11-20 at 19:50 +0530, Kotresh Hiremath Ravishankar wrote=
:
> > > > Hi All,
> > > >
> > > > I think the patch is necessary and fixes the crash. There is no har=
m
> > > > in taking this patch as it behaves like an old kernel with this
> > > > particular scenario.
> > > >
> > > > When does the issue happen:
> > > >    - The issue happens only when the old mount syntax is used where
> > > > passing the file system name is optional in which case, it chooses =
the
> > > > default mds namespace but doesn't get filled in the
> > > > mdsc->fsc->mount_options->mds_namespace.
> > > >    - Along with the above, the mount user should be non admin.
> > > > Does it break the earlier fix ?
> > > >    - Not fully!!! Though the open does succeed, the subsequent
> > > > operation like write would get EPERM. I am not exactly able to
> > > > recollect but this was discussed before writing the fix 22c73d52a6d=
0
> > > > ("ceph: fix multifs mds auth caps issue"), it's guarded by another
> > > > check before actual operation like write.
> > > >
> > > > I think there are a couple of options to fix this cleanly.
> > > >  1. Use the default fsname when
> > > > mdsc->fsc->mount_options->mds_namespace is NULL during comparison.
> > > >  2. Mandate passing the fsname with old syntax ?
> > > >
> > >
> > > Anyway, we should be ready operate correctly if fsname or/and auth-
> > > > match.fs_name are NULL. And if we need to make the fix more cleanly=
, then we
> > > can introduce another patch with nicer fix.
> > >
> > > I am not completely sure how default fsname can be applicable here. I=
f I
> > > understood the CephFS mount logic correctly, then fsname can be NULL =
during some
> > > initial steps. But, finally, we will have the real fsname for compari=
son. But I
> > > don't know if it's right of assuming that fsname =3D=3D NULL is equal=
 to fsname =3D=3D
> > > default_name.
> >
> > We are pretty sure fsname is NULL only if the old mount syntax is used
> > without providing the
> > fsname in the optional arg. I believe kclient knows the fsname that's
> > mounted somewhere in this case ?
> > I am not sure though. If so, it can be used. If not, then can we rely
> > on what mds sends as part
> > of the mdsmap?
> >
> > With this fix, did the tests run fine ?
> >
>
> The xfstests works fine with the fix. I don't see any issues with the it.
>
> > Aren't you hitting this error
> > https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mdsmap.c#L365
> > ?
> >
>
> I am not sure how this error can be triggered. I see this sequence:

Ok. It doesn't crash because the null check is there at
https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/super.h#L116

>
> Nov 24 12:51:10 ceph-0005 kernel: [   89.621635] ceph:          super.c:6=
3   :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] begin
> Nov 24 12:51:10 ceph-0005 kernel: [   89.624691] ceph:          super.c:1=
17  :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] done
> Nov 24 12:51:10 ceph-0005 kernel: [   89.625349] ceph:          super.c:6=
3   :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] begin
> Nov 24 12:51:10 ceph-0005 kernel: [   89.627776] ceph:          super.c:1=
17  :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] done
> Nov 24 12:51:10 ceph-0005 kernel: [   89.645611] ceph:          super.c:6=
3   :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] begin
> Nov 24 12:51:10 ceph-0005 kernel: [   89.652534] ceph:          super.c:1=
17  :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] done
> Nov 24 12:51:10 ceph-0005 kernel: [   89.654695] ceph:          super.c:6=
3   :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] begin
> Nov 24 12:51:10 ceph-0005 kernel: [   89.656220] ceph:          super.c:1=
17  :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] done
>
> Nov 24 12:51:10 ceph-0005 kernel: [   89.678877] ceph:           file.c:3=
89  :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] 000000000e172927
> 10000000000.fffffffffffffffe file 00000000c51edc48 flags 65536 (32768)
> Nov 24 12:51:10 ceph-0005 kernel: [   89.680523] ceph:     mds_client.c:2=
832 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] on 000000005248a4a0 41 buil=
t
> 10000000000 '/'
> Nov 24 12:51:10 ceph-0005 kernel: [   89.681343] ceph:     mds_client.c:5=
779 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] tpath '/', mask 4, caller_u=
id 0,
> caller_gid 0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.682296] ceph:     mds_client.c:5=
664 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] fsname check fs_name=3D(nul=
l)
> match.fs_name=3Dcephfs
> Nov 24 12:51:10 ceph-0005 kernel: [   89.683134] BUG: kernel NULL pointer
> dereference, address: 0000000000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.683603] #PF: supervisor read acc=
ess in
> kernel mode
> Nov 24 12:51:10 ceph-0005 kernel: [   89.683969] #PF: error_code(0x0000) =
- not-
> present page
> Nov 24 12:51:10 ceph-0005 kernel: [   89.684311] PGD 0 P4D 0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.684496] Oops: Oops: 0000 [#2] SM=
P KASAN
> NOPTI
> Nov 24 12:51:10 ceph-0005 kernel: [   89.684843] CPU: 1 UID: 0 PID: 3406 =
Comm:
> xfs_io Tainted: G      D             6.18.0-rc6+ #64 PREEMPT(voluntary)
> Nov 24 12:51:10 ceph-0005 kernel: [   89.685535] Tainted: [D]=3DDIE
> Nov 24 12:51:10 ceph-0005 kernel: [   89.685738] Hardware name: QEMU Stan=
dard PC
> (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> Nov 24 12:51:10 ceph-0005 kernel: [   89.686351] RIP: 0010:strcmp+0x1c/0x=
40
> Nov 24 12:51:10 ceph-0005 kernel: [   89.686578] Code: 90 90 90 90 90 90 =
90 90
> 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c=
0 01 84
> d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3=
 cc cc
> cc cc 31
> Nov 24 12:51:10 ceph-0005 kernel: [   89.687550] RSP: 0018:ffff8881035c76=
e0
> EFLAGS: 00010246
> Nov 24 12:51:10 ceph-0005 kernel: [   89.687870] RAX: 0000000000000000 RB=
X:
> ffff88810bc59600 RCX: 0000000000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.688252] RDX: 0000000000000063 RS=
I:
> 0000000000000000 RDI: ffff888110739020
> Nov 24 12:51:10 ceph-0005 kernel: [   89.688654] RBP: ffff8881035c77c8 R0=
8:
> 0000000000000000 R09: 0000000000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.689126] R10: 0000000000000000 R1=
1:
> 0000000000000000 R12: dffffc0000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.689516] R13: ffff88811e104000 R1=
4:
> 0000000000000000 R15: 0000000000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.689918] FS:  000070f659aac840(00=
00)
> GS:ffff88825f422000(0000) knlGS:0000000000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.690338] CS:  0010 DS: 0000 ES: 0=
000
> CR0: 0000000080050033
> Nov 24 12:51:10 ceph-0005 kernel: [   89.690659] CR2: 0000000000000000 CR=
3:
> 00000001a0ebe003 CR4: 0000000000772ef0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.691092] PKRU: 55555554
> Nov 24 12:51:10 ceph-0005 kernel: [   89.691273] Call Trace:
> Nov 24 12:51:10 ceph-0005 kernel: [   89.691433]  <TASK>
> Nov 24 12:51:10 ceph-0005 kernel: [   89.691575]  ?
> ceph_mds_check_access+0x348/0x1760
> Nov 24 12:51:10 ceph-0005 kernel: [   89.691851]  ?
> __kasan_check_write+0x14/0x30
> Nov 24 12:51:10 ceph-0005 kernel: [   89.692089]  ? lockref_get+0xb1/0x17=
0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.692320]  ceph_open+0x322/0xef0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.692557]  ? __pfx_ceph_open+0x10/=
0x10
> Nov 24 12:51:10 ceph-0005 kernel: [   89.692801]  ?
> __pfx_apparmor_file_open+0x10/0x10
> Nov 24 12:51:10 ceph-0005 kernel: [   89.693078]  ?
> __ceph_caps_issued_mask_metric+0xd6/0x180
> Nov 24 12:51:10 ceph-0005 kernel: [   89.693405]  do_dentry_open+0x7bf/0x=
10e0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.693649]  ? __pfx_ceph_open+0x10/=
0x10
> Nov 24 12:51:10 ceph-0005 kernel: [   89.693870]  vfs_open+0x6d/0x450
> Nov 24 12:51:10 ceph-0005 kernel: [   89.694097]  ? may_open+0xec/0x370
> Nov 24 12:51:10 ceph-0005 kernel: [   89.694283]  path_openat+0x2017/0x50=
a0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.694520]  ? __pfx_path_openat+0x1=
0/0x10
> Nov 24 12:51:10 ceph-0005 kernel: [   89.694918]  ?
> __pfx_stack_trace_save+0x10/0x10
> Nov 24 12:51:10 ceph-0005 kernel: [   89.695284]  ?
> stack_depot_save_flags+0x28/0x8f0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.695572]  ? stack_depot_save+0xe/=
0x20
> Nov 24 12:51:10 ceph-0005 kernel: [   89.695864]  do_filp_open+0x1b4/0x45=
0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.696271]  ?
> __pfx__raw_spin_lock_irqsave+0x10/0x10
> Nov 24 12:51:10 ceph-0005 kernel: [   89.696712]  ? __pfx_do_filp_open+0x=
10/0x10
> Nov 24 12:51:10 ceph-0005 kernel: [   89.697089]  ? __link_object+0x13d/0=
x2b0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.697426]  ?
> __pfx__raw_spin_lock+0x10/0x10
> Nov 24 12:51:10 ceph-0005 kernel: [   89.697801]  ?
> __check_object_size+0x453/0x600
> Nov 24 12:51:10 ceph-0005 kernel: [   89.698216]  ? _raw_spin_unlock+0xe/=
0x40
> Nov 24 12:51:10 ceph-0005 kernel: [   89.698556]  do_sys_openat2+0xe6/0x1=
80
> Nov 24 12:51:10 ceph-0005 kernel: [   89.698905]  ?
> __pfx_do_sys_openat2+0x10/0x10
> Nov 24 12:51:10 ceph-0005 kernel: [   89.699280]  __x64_sys_openat+0x108/=
0x240
> Nov 24 12:51:10 ceph-0005 kernel: [   89.699625]  ?
> __pfx___x64_sys_openat+0x10/0x10
> Nov 24 12:51:10 ceph-0005 kernel: [   89.700038]  x64_sys_call+0x134f/0x2=
350
> Nov 24 12:51:10 ceph-0005 kernel: [   89.700371]  do_syscall_64+0x82/0xd5=
0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.700684]  ? do_syscall_64+0xba/0x=
d50
> Nov 24 12:51:10 ceph-0005 kernel: [   89.701030]  ?
> irqentry_exit_to_user_mode+0x2e/0x2a0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.701409]  ? irqentry_exit+0x43/0x=
50
> Nov 24 12:51:10 ceph-0005 kernel: [   89.701595]  ? exc_page_fault+0x95/0=
x100
> Nov 24 12:51:10 ceph-0005 kernel: [   89.701793]
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Nov 24 12:51:10 ceph-0005 kernel: [   89.702066] RIP: 0033:0x70f6599145ab
> Nov 24 12:51:10 ceph-0005 kernel: [   89.702266] Code: 25 00 00 41 00 3d =
00 00
> 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c f=
f ff ff
> b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28=
 64 48
> 2b 14 25
> Nov 24 12:51:10 ceph-0005 kernel: [   89.703191] RSP: 002b:00007ffc93ebcf=
c0
> EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> Nov 24 12:51:10 ceph-0005 kernel: [   89.703557] RAX: ffffffffffffffda RB=
X:
> 0000000000000002 RCX: 000070f6599145ab
> Nov 24 12:51:10 ceph-0005 kernel: [   89.703940] RDX: 0000000000000000 RS=
I:
> 00007ffc93ebf786 RDI: 00000000ffffff9c
> Nov 24 12:51:10 ceph-0005 kernel: [   89.704288] RBP: 00007ffc93ebf786 R0=
8:
> 00007ffc93ebd270 R09: 0000000000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.704624] R10: 0000000000000000 R1=
1:
> 0000000000000246 R12: 0000000000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.704986] R13: 00000000ffffffff R1=
4:
> 0000000000000180 R15: 0000000000000001
> Nov 24 12:51:10 ceph-0005 kernel: [   89.705329]  </TASK>
> Nov 24 12:51:10 ceph-0005 kernel: [   89.705453] Modules linked in:
> intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_=
core
> pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vse=
c
> kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesni_=
intel
> input_leds psmouse rapl vga16fb serio_raw vgastate floppy i2c_piix4 mac_h=
id
> qemu_fw_cfg i2c_smbus bochs pata_acpi sch_fq_codel rbd msr parport_pc ppd=
ev lp
> parport efi_pstore
> Nov 24 12:51:10 ceph-0005 kernel: [   89.707505] CR2: 0000000000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.707692] ---[ end trace 000000000=
0000000
> ]---
> Nov 24 12:51:10 ceph-0005 kernel: [   89.707965] RIP: 0010:strcmp+0x1c/0x=
40
> Nov 24 12:51:10 ceph-0005 kernel: [   89.708167] Code: 90 90 90 90 90 90 =
90 90
> 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c=
0 01 84
> d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3=
 cc cc
> cc cc 31
> Nov 24 12:51:10 ceph-0005 kernel: [   89.709139] RSP: 0018:ffff8881b8faf6=
00
> EFLAGS: 00010246
> Nov 24 12:51:10 ceph-0005 kernel: [   89.709394] RAX: 0000000000000000 RB=
X:
> ffff88810bc59600 RCX: 0000000000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.709760] RDX: 0000000000000063 RS=
I:
> 0000000000000000 RDI: ffff888110739020
> Nov 24 12:51:10 ceph-0005 kernel: [   89.710125] RBP: ffff8881b8faf6e8 R0=
8:
> 0000000000000000 R09: 0000000000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.710513] R10: 0000000000000000 R1=
1:
> 0000000000000000 R12: dffffc0000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.710874] R13: ffff88811e104000 R1=
4:
> 0000000000000000 R15: 0000000000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.711244] FS:  000070f659aac840(00=
00)
> GS:ffff88825f422000(0000) knlGS:0000000000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.711687] CS:  0010 DS: 0000 ES: 0=
000
> CR0: 0000000080050033
> Nov 24 12:51:10 ceph-0005 kernel: [   89.712009] CR2: 0000000000000000 CR=
3:
> 00000001a0ebe003 CR4: 0000000000772ef0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.712376] PKRU: 55555554
>
> Nov 24 12:51:10 ceph-0005 kernel: [   89.807353] ceph:          super.c:4=
14  :
> ceph_parse_mount_param: fs_parse 'source' token 12
> Nov 24 12:51:10 ceph-0005 kernel: [   89.807983] ceph:          super.c:3=
42  :
> '192.168.1.213:3300:/scratch'
> Nov 24 12:51:10 ceph-0005 kernel: [   89.808750] ceph:          super.c:3=
66  :
> device name '192.168.1.213:3300'
> Nov 24 12:51:10 ceph-0005 kernel: [   89.809361] ceph:          super.c:3=
68  :
> server path '/scratch'
> Nov 24 12:51:10 ceph-0005 kernel: [   89.809813] ceph:          super.c:3=
70  :
> trying new device syntax
> Nov 24 12:51:10 ceph-0005 kernel: [   89.809815] ceph:          super.c:2=
80  :
> separator '=3D' missing in source
> Nov 24 12:51:10 ceph-0005 kernel: [   89.810219] ceph:          super.c:3=
75  :
> trying old device syntax
> Nov 24 12:51:10 ceph-0005 kernel: [   89.810763] ceph:          super.c:1=
299 :
> ceph_get_tree
> Nov 24 12:51:10 ceph-0005 kernel: [   89.812515] ceph:          super.c:1=
236 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] 0000000003c37076
> Nov 24 12:51:10 ceph-0005 kernel: [   89.813215] ceph:          super.c:1=
239 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] monitor(s)/mount options do=
n't
> match
> Nov 24 12:51:10 ceph-0005 kernel: [   89.814018] ceph:          super.c:1=
236 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] 000000005e011a18
> Nov 24 12:51:10 ceph-0005 kernel: [   89.814618] ceph:          super.c:1=
239 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] monitor(s)/mount options do=
n't
> match
> Nov 24 12:51:10 ceph-0005 kernel: [   89.815493] ceph:          super.c:1=
236 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] 0000000003c37076
> Nov 24 12:51:10 ceph-0005 kernel: [   89.816133] ceph:          super.c:1=
239 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] monitor(s)/mount options do=
n't
> match
> Nov 24 12:51:10 ceph-0005 kernel: [   89.816830] ceph:          super.c:1=
236 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] 000000005e011a18
> Nov 24 12:51:10 ceph-0005 kernel: [   89.817528] ceph:          super.c:1=
239 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] monitor(s)/mount options do=
n't
> match
> Nov 24 12:51:10 ceph-0005 kernel: [   89.818320] ceph:          super.c:1=
199 :
> [00000000-0000-0000-0000-000000000000 0] 00000000ce5cc894
> Nov 24 12:51:10 ceph-0005 kernel: [   89.818919] ceph:          super.c:1=
335 :
> get_sb using new client 000000006de70127
> Nov 24 12:51:10 ceph-0005 kernel: [   89.819741] ceph:          super.c:1=
145 :
> [00000000-0000-0000-0000-000000000000 0] mount start 000000006de70127
> Nov 24 12:51:10 ceph-0005 kernel: [   89.826429] libceph: mon0
> (2)192.168.1.213:3300 session established
> Nov 24 12:51:10 ceph-0005 kernel: [   89.829158] ceph:     mds_client.c:6=
196 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] epoch 4346 len 1220
> Nov 24 12:51:10 ceph-0005 kernel: [   89.829955] ceph:     mds_client.c:5=
060 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] new 4346 old 0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.831138] libceph: client175983 fs=
id
> 31977b06-8cdb-42a9-97ad-d6a7d59a42dd
> Nov 24 12:51:10 ceph-0005 kernel: [   89.831780] ceph:          super.c:1=
168 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mount opening path 'scratch=
'
> Nov 24 12:51:10 ceph-0005 kernel: [   89.832570] ceph:          super.c:1=
055 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] opening 'scratch'
> Nov 24 12:51:10 ceph-0005 kernel: [   89.833170] ceph:     mds_client.c:3=
796 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] do_request on 000000004bf8d=
029
> Nov 24 12:51:10 ceph-0005 kernel: [   89.833823] ceph:     mds_client.c:3=
724 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] submit_request on 000000004=
bf8d029
> for inode 0000000000000000
> Nov 24 12:51:10 ceph-0005 kernel: [   89.834644] ceph:     mds_client.c:1=
183 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] 000000004bf8d029 tid 1
> Nov 24 12:51:10 ceph-0005 kernel: [   89.835278] ceph:     mds_client.c:1=
434 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] chose random mds0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.835886] ceph:     mds_client.c:9=
84  :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] realloc to 1
> Nov 24 12:51:10 ceph-0005 kernel: [   89.836390] ceph:     mds_client.c:9=
97  :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mds0
> Nov 24 12:51:10 ceph-0005 kernel: [   89.836969] ceph:     mds_client.c:3=
509 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mds0 session 00000000dd87f0=
dd
> state new
> Nov 24 12:51:10 ceph-0005 kernel: [   89.837584] ceph:     mds_client.c:1=
674 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] open_session to mds0 (up:ac=
tive)
> Nov 24 12:51:10 ceph-0005 kernel: [   89.838388] ceph:     mds_client.c:3=
741 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] do_request waiting
>
> Nov 24 12:51:10 ceph-0005 kernel: [   90.291635] ceph:     mds_client.c:4=
210 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] cap_auths_num 1
> Nov 24 12:51:10 ceph-0005 kernel: [   90.292760] ceph:     mds_client.c:4=
281 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] uid -1, num_gids 0, path (n=
ull),
> fs_name cephfs, root_squash 0, readable 1, writeable 1
> Nov 24 12:51:10 ceph-0005 kernel: [   90.294531] ceph:     mds_client.c:4=
313 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mds0 open 00000000dd87f0dd =
state
> opening seq 0
> Nov 24 12:51:10 ceph-0005 kernel: [   90.296268] ceph:     mds_client.c:2=
090 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mds0 ttl now 4294815743, wa=
s
> fresh, now stale
> Nov 24 12:51:10 ceph-0005 kernel: [   90.297370] ceph:     mds_client.c:3=
653 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983]  wake request 000000004bf8d=
029 tid
> 1
> Nov 24 12:51:10 ceph-0005 kernel: [   90.298127] ceph:     mds_client.c:1=
306 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] using resend_mds mds0
> Nov 24 12:51:10 ceph-0005 kernel: [   90.298734] ceph:     mds_client.c:3=
509 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mds0 session 00000000dd87f0=
dd
> state open
> Nov 24 12:51:11 ceph-0005 kernel: [   90.299523] ceph:     mds_client.c:3=
340 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] 000000004bf8d029 tid 1 geta=
ttr
> (attempt 1)
> Nov 24 12:51:11 ceph-0005 kernel: [   90.300184] ceph:     mds_client.c:2=
923 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983]  path scratch
> Nov 24 12:51:11 ceph-0005 kernel: [   90.300769] ceph:     mds_client.c:3=
409 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983]  r_parent =3D 0000000000000=
000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.302465] ceph:     mds_client.c:3=
863 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] handle_reply 000000004bf8d0=
29
> Nov 24 12:51:11 ceph-0005 kernel: [   90.303109] ceph:     mds_client.c:1=
208 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] 000000004bf8d029 tid 1
> Nov 24 12:51:11 ceph-0005 kernel: [   90.303661] ceph:     mds_client.c:3=
917 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] tid 1 result 0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.304326] ceph:     mds_client.c:3=
755 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] do_request waited, got 0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.305635] ceph:     mds_client.c:3=
802 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] do_request 000000004bf8d029=
 done,
> result 0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.307048] ceph:          super.c:1=
075 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] success
> Nov 24 12:51:11 ceph-0005 kernel: [   90.308214] ceph:          super.c:1=
081 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] success, root dentry is
> 00000000c9e255e3
> Nov 24 12:51:11 ceph-0005 kernel: [   90.309500] ceph:          super.c:1=
183 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mount success
> Nov 24 12:51:11 ceph-0005 kernel: [   90.310523] ceph:          super.c:1=
347 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] root 00000000c9e255e3 inode
> 000000000946916c ino 10000000001.fffffffffffffffe
> Nov 24 12:51:11 ceph-0005 kernel: [   90.312737] ceph:          super.c:6=
20  :
> destroy_mount_options 0000000000000000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.319198] ceph:           file.c:3=
89  :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] 000000000946916c
> 10000000001.fffffffffffffffe file 0000000006cb5fc2 flags 65536 (100352)
> Nov 24 12:51:11 ceph-0005 kernel: [   90.322405] ceph:     mds_client.c:2=
832 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] on 00000000c9e255e3 38 buil=
t
> 10000000001 '/'
> Nov 24 12:51:11 ceph-0005 kernel: [   90.324881] ceph:     mds_client.c:5=
779 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] tpath '/', mask 4, caller_u=
id 0,
> caller_gid 0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.327514] ceph:     mds_client.c:5=
664 :
> [31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] fsname check fs_name=3D(nul=
l)
> match.fs_name=3Dcephfs
> Nov 24 12:51:11 ceph-0005 kernel: [   90.328688] BUG: kernel NULL pointer
> dereference, address: 0000000000000000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.329218] #PF: supervisor read acc=
ess in
> kernel mode
> Nov 24 12:51:11 ceph-0005 kernel: [   90.329547] #PF: error_code(0x0000) =
- not-
> present page
> Nov 24 12:51:11 ceph-0005 kernel: [   90.330308] PGD 0 P4D 0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.330505] Oops: Oops: 0000 [#3] SM=
P KASAN
> NOPTI
> Nov 24 12:51:11 ceph-0005 kernel: [   90.330776] CPU: 7 UID: 0 PID: 2530 =
Comm:
> check Tainted: G      D             6.18.0-rc6+ #64 PREEMPT(voluntary)
> Nov 24 12:51:11 ceph-0005 kernel: [   90.331723] Tainted: [D]=3DDIE
> Nov 24 12:51:11 ceph-0005 kernel: [   90.331956] Hardware name: QEMU Stan=
dard PC
> (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> Nov 24 12:51:11 ceph-0005 kernel: [   90.333363] RIP: 0010:strcmp+0x1c/0x=
40
> Nov 24 12:51:11 ceph-0005 kernel: [   90.333614] Code: 90 90 90 90 90 90 =
90 90
> 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c=
0 01 84
> d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3=
 cc cc
> cc cc 31
> Nov 24 12:51:11 ceph-0005 kernel: [   90.334929] RSP: 0018:ffff8881b5f8f6=
d0
> EFLAGS: 00010246
> Nov 24 12:51:11 ceph-0005 kernel: [   90.335267] RAX: 0000000000000000 RB=
X:
> ffff88810bc59200 RCX: 0000000000000000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.335694] RDX: 0000000000000063 RS=
I:
> 0000000000000000 RDI: ffff8881107393c0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.336176] RBP: ffff8881b5f8f7b8 R0=
8:
> 0000000000000000 R09: 0000000000000000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.336688] R10: 0000000000000000 R1=
1:
> 0000000000000000 R12: dffffc0000000000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.337135] R13: ffff88811e218000 R1=
4:
> 0000000000000000 R15: 0000000000000000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.337691] FS:  00007f6a1017c740(00=
00)
> GS:ffff88825f722000(0000) knlGS:0000000000000000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.338600] CS:  0010 DS: 0000 ES: 0=
000
> CR0: 0000000080050033
> Nov 24 12:51:11 ceph-0005 kernel: [   90.339405] CR2: 0000000000000000 CR=
3:
> 000000010216e006 CR4: 0000000000772ef0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.339920] PKRU: 55555554
> Nov 24 12:51:11 ceph-0005 kernel: [   90.340105] Call Trace:
> Nov 24 12:51:11 ceph-0005 kernel: [   90.340276]  <TASK>
> Nov 24 12:51:11 ceph-0005 kernel: [   90.340454]  ?
> ceph_mds_check_access+0x348/0x1760
> Nov 24 12:51:11 ceph-0005 kernel: [   90.340775]  ?
> __kasan_check_write+0x14/0x30
> Nov 24 12:51:11 ceph-0005 kernel: [   90.341447]  ? lockref_get+0xb1/0x17=
0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.341729]  ceph_open+0x322/0xef0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.341962]  ?
> __kasan_check_write+0x14/0x30
> Nov 24 12:51:11 ceph-0005 kernel: [   90.342233]  ? __pfx_ceph_open+0x10/=
0x10
> Nov 24 12:51:11 ceph-0005 kernel: [   90.342499]  ?
> __pfx_apparmor_file_open+0x10/0x10
> Nov 24 12:51:11 ceph-0005 kernel: [   90.342763]  do_dentry_open+0x7bf/0x=
10e0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.343646]  ? __pfx_ceph_open+0x10/=
0x10
> Nov 24 12:51:11 ceph-0005 kernel: [   90.344196]  vfs_open+0x6d/0x450
> Nov 24 12:51:11 ceph-0005 kernel: [   90.344409]  ? may_open+0xec/0x370
> Nov 24 12:51:11 ceph-0005 kernel: [   90.344640]  path_openat+0x2017/0x50=
a0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.344895]  ? __pfx_path_openat+0x1=
0/0x10
> Nov 24 12:51:11 ceph-0005 kernel: [   90.345198]  ?
> __pfx_stack_trace_save+0x10/0x10
> Nov 24 12:51:11 ceph-0005 kernel: [   90.345566]  ?
> __kasan_check_write+0x14/0x30
> Nov 24 12:51:11 ceph-0005 kernel: [   90.345911]  ?
> stack_depot_save_flags+0x28/0x8f0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.346289]  ? stack_depot_save+0xe/=
0x20
> Nov 24 12:51:11 ceph-0005 kernel: [   90.346597]  do_filp_open+0x1b4/0x45=
0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.346899]  ?
> __pfx__raw_spin_lock_irqsave+0x10/0x10
> Nov 24 12:51:11 ceph-0005 kernel: [   90.347276]  ? __pfx_do_filp_open+0x=
10/0x10
> Nov 24 12:51:11 ceph-0005 kernel: [   90.347582]  ? __link_object+0x13d/0=
x2b0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.347880]  ?
> __pfx__raw_spin_lock+0x10/0x10
> Nov 24 12:51:11 ceph-0005 kernel: [   90.348140]  ?
> __check_object_size+0x453/0x600
> Nov 24 12:51:11 ceph-0005 kernel: [   90.348385]  ? _raw_spin_unlock+0xe/=
0x40
> Nov 24 12:51:11 ceph-0005 kernel: [   90.348597]  do_sys_openat2+0xe6/0x1=
80
> Nov 24 12:51:11 ceph-0005 kernel: [   90.348804]  ?
> __pfx_do_sys_openat2+0x10/0x10
> Nov 24 12:51:11 ceph-0005 kernel: [   90.349047]  ?
> __kasan_check_write+0x14/0x30
> Nov 24 12:51:11 ceph-0005 kernel: [   90.349302]  ?
> lock_vma_under_rcu+0x2e9/0x730
> Nov 24 12:51:11 ceph-0005 kernel: [   90.349556]  __x64_sys_openat+0x108/=
0x240
> Nov 24 12:51:11 ceph-0005 kernel: [   90.349772]  ?
> __pfx___x64_sys_openat+0x10/0x10
> Nov 24 12:51:11 ceph-0005 kernel: [   90.350023]  x64_sys_call+0x134f/0x2=
350
> Nov 24 12:51:11 ceph-0005 kernel: [   90.350239]  do_syscall_64+0x82/0xd5=
0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.350440]  ? __kasan_check_read+0x=
11/0x20
> Nov 24 12:51:11 ceph-0005 kernel: [   90.350660]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Nov 24 12:51:11 ceph-0005 kernel: [   90.350968]  ?
> irqentry_exit_to_user_mode+0x2e/0x2a0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.351240]  ? irqentry_exit+0x43/0x=
50
> Nov 24 12:51:11 ceph-0005 kernel: [   90.351442]  ? exc_page_fault+0x95/0=
x100
> Nov 24 12:51:11 ceph-0005 kernel: [   90.351647]
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Nov 24 12:51:11 ceph-0005 kernel: [   90.351933] RIP: 0033:0x7f6a0ff19a8c
> Nov 24 12:51:11 ceph-0005 kernel: [   90.352129] Code: 24 18 31 c0 41 83 =
e2 40
> 75 44 89 f0 25 00 00 41 00 3d 00 00 41 00 74 36 44 89 c2 4c 89 ce bf 9c f=
f ff ff
> b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 44 48 8b 54 24 18 64 48 2b 14=
 25 28
> 00 00 00
> Nov 24 12:51:11 ceph-0005 kernel: [   90.353095] RSP: 002b:00007ffe25b421=
90
> EFLAGS: 00000287 ORIG_RAX: 0000000000000101
> Nov 24 12:51:11 ceph-0005 kernel: [   90.353939] RAX: ffffffffffffffda RB=
X:
> 0000000000000001 RCX: 00007f6a0ff19a8c
> Nov 24 12:51:11 ceph-0005 kernel: [   90.354382] RDX: 0000000000090800 RS=
I:
> 00005c7d3b043a90 RDI: 00000000ffffff9c
> Nov 24 12:51:11 ceph-0005 kernel: [   90.354803] RBP: 00007ffe25b423f0 R0=
8:
> 0000000000090800 R09: 00005c7d3b043a90
> Nov 24 12:51:11 ceph-0005 kernel: [   90.355276] R10: 0000000000000000 R1=
1:
> 0000000000000287 R12: 00005c7d3ad24354
> Nov 24 12:51:11 ceph-0005 kernel: [   90.355686] R13: 00005c7d3b043a90 R1=
4:
> 0000000000000000 R15: 00005c7d3ad24353
> Nov 24 12:51:11 ceph-0005 kernel: [   90.356091]  </TASK>
> Nov 24 12:51:11 ceph-0005 kernel: [   90.356231] Modules linked in:
> intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_=
core
> pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vse=
c
> kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesni_=
intel
> input_leds psmouse rapl vga16fb serio_raw vgastate floppy i2c_piix4 mac_h=
id
> qemu_fw_cfg i2c_smbus bochs pata_acpi sch_fq_codel rbd msr parport_pc ppd=
ev lp
> parport efi_pstore
> Nov 24 12:51:11 ceph-0005 kernel: [   90.358735] CR2: 0000000000000000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.358972] ---[ end trace 000000000=
0000000
> ]---
> Nov 24 12:51:11 ceph-0005 kernel: [   90.359341] RIP: 0010:strcmp+0x1c/0x=
40
> Nov 24 12:51:11 ceph-0005 kernel: [   90.359581] Code: 90 90 90 90 90 90 =
90 90
> 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c=
0 01 84
> d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3=
 cc cc
> cc cc 31
> Nov 24 12:51:11 ceph-0005 kernel: [   90.360687] RSP: 0018:ffff8881b8faf6=
00
> EFLAGS: 00010246
> Nov 24 12:51:11 ceph-0005 kernel: [   90.361008] RAX: 0000000000000000 RB=
X:
> ffff88810bc59600 RCX: 0000000000000000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.361488] RDX: 0000000000000063 RS=
I:
> 0000000000000000 RDI: ffff888110739020
> Nov 24 12:51:11 ceph-0005 kernel: [   90.362074] RBP: ffff8881b8faf6e8 R0=
8:
> 0000000000000000 R09: 0000000000000000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.362498] R10: 0000000000000000 R1=
1:
> 0000000000000000 R12: dffffc0000000000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.362969] R13: ffff88811e104000 R1=
4:
> 0000000000000000 R15: 0000000000000000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.363442] FS:  00007f6a1017c740(00=
00)
> GS:ffff88825f722000(0000) knlGS:0000000000000000
> Nov 24 12:51:11 ceph-0005 kernel: [   90.363971] CS:  0010 DS: 0000 ES: 0=
000
> CR0: 0000000080050033
> Nov 24 12:51:11 ceph-0005 kernel: [   90.364338] CR2: 0000000000000000 CR=
3:
> 000000010216e006 CR4: 0000000000772ef0
> Nov 24 12:51:11 ceph-0005 kernel: [   90.364738] PKRU: 55555554
>
> So, the main sequence is:
>
> ceph_open()
>   -> ceph_mdsc_build_path()
>   -> ceph_mds_check_access()
>       -> ceph_mds_auth_match()
>           -> crash happens
>
> > >
> > > And I am not sure that we can mandate anyone to use the old syntax. I=
f there is
> > > some other opportunity, then someone could use it. But, maybe, I am m=
issing the
> > > point. :) What do you mean by "Mandate passing the fsname with old sy=
ntax"?
> >
> > In the old mount syntax, the fsname is passed as on optional argument
> > using 'mds_namespace'.
> > I was suggesting to mandate it if possible. But I guess it breaks
> > backward compatibility.
> >
> > >
> > >
>
> We had a private discussion with Ilya. Yes, he also mentioned the breakin=
g of
> backward compatibility for the case of mandating passing the fsname with =
old
> syntax. He believes that: "Use the default fsname when mdsc->fsc->mount_o=
ptions-
> >mds_namespace is NULL during comparison seems like a sensible approach t=
o me".
>
> Thanks,
> Slava.
>
> > > >
> > > >
> > > >
> > > > On Thu, Nov 20, 2025 at 4:47=E2=80=AFAM Viacheslav Dubeyko
> > > > <Slava.Dubeyko@ibm.com> wrote:
> > > > >
> > > > > On Wed, 2025-11-19 at 15:02 -0800, Gregory Farnum wrote:
> > > > > >
> > > > > > That doesn=E2=80=99t sound right =E2=80=94 this is authenticati=
on code. If the authorization is supplied for a namespace and we are mounti=
ng without a namespace at all, isn=E2=80=99t that a jailbreak? So the NULL =
pointer should be accepted in one direction, but denied in the other?
> > > > >
> > > > > What is your particular suggestion? I am simply fixing the kernel=
 crash after
> > > > > the 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue"). We di=
dn't have any
> > > > > check before. Do you imply that 22c73d52a6d0 ("ceph: fix multifs =
mds auth caps
> > > > > issue") fix is incorrect and we need to rework it somehow?
> > > > >
> > > > > If we will not have any fix, then 6.18 release will have broken C=
ephFS kernel
> > > > > client.
> > > > >
> > > > > Thanks,
> > > > > Slava.
> > > > >
> > > > > >
> > > > > > On Wed, Nov 19, 2025 at 2:54=E2=80=AFPM Viacheslav Dubeyko <Sla=
va.Dubeyko@ibm.com> wrote:
> > > > > > > On Wed, 2025-11-19 at 23:40 +0100, Ilya Dryomov wrote:
> > > > > > > > On Wed, Nov 19, 2025 at 8:38=E2=80=AFPM Viacheslav Dubeyko =
<slava@dubeyko.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > > > > >
> > > > > > > > > The CephFS kernel client has regression starting from 6.1=
8-rc1.
> > > > > > > > >
> > > > > > > > > sudo ./check -g quick
> > > > > > > > > FSTYP         -- ceph
> > > > > > > > > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 S=
MP PREEMPT_DYNAMIC Fri
> > > > > > > > > Nov 14 11:26:14 PST 2025
> > > > > > > > > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > > > > > > > > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168=
.1.213:3300:/scratch
> > > > > > > > > /mnt/cephfs/scratch
> > > > > > > > >
> > > > > > > > > Killed
> > > > > > > > >
> > > > > > > > > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph:=
 mon0
> > > > > > > > > (2)192.168.1.213:3300 session established
> > > > > > > > > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph:=
 client167616
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: ker=
nel NULL pointer
> > > > > > > > > dereference, address: 0000000000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: sup=
ervisor read access in
> > > > > > > > > kernel mode
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: err=
or_code(0x0000) - not-
> > > > > > > > > present page
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4=
D 0
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oo=
ps: 0000 [#1] SMP KASAN
> > > > > > > > > NOPTI
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 U=
ID: 0 PID: 3453 Comm:
> > > > > > > > > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware=
 name: QEMU Standard PC
> > > > > > > > > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 001=
0:strcmp+0x1c/0x40
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90=
 90 90 90 90 90 90 90
> > > > > > > > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 =
00 00 90 48 83 c0 01 84
> > > > > > > > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d=
2 31 f6 31 ff c3 cc cc
> > > > > > > > > cc cc 31
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 001=
8:ffff8881536875c0
> > > > > > > > > EFLAGS: 00010246
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 000=
0000000000000 RBX:
> > > > > > > > > ffff888116003200 RCX: 0000000000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 000=
0000000000063 RSI:
> > > > > > > > > 0000000000000000 RDI: ffff88810126c900
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: fff=
f8881536876a8 R08:
> > > > > > > > > 0000000000000000 R09: 0000000000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 000=
0000000000000 R11:
> > > > > > > > > 0000000000000000 R12: dffffc0000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: fff=
f8881061d0000 R14:
> > > > > > > > > 0000000000000000 R15: 0000000000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000=
074a85c082840(0000)
> > > > > > > > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  001=
0 DS: 0000 ES: 0000
> > > > > > > > > CR0: 0000000080050033
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 000=
0000000000000 CR3:
> > > > > > > > > 0000000110ebd001 CR4: 0000000000772ef0
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55=
555554
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Tra=
ce:
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > > > > > > > > ceph_mds_check_access+0x348/0x1760
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > > > > > > > > __kasan_check_write+0x14/0x30
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockr=
ef_get+0xb1/0x170
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > > > > > > > > __pfx__raw_spin_lock+0x10/0x10
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_op=
en+0x322/0xef0
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx=
_ceph_open+0x10/0x10
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > > > > > > > > __pfx_apparmor_file_open+0x10/0x10
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > > > > > > > > __ceph_caps_issued_mask_metric+0xd6/0x180
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dent=
ry_open+0x7bf/0x10e0
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx=
_ceph_open+0x10/0x10
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_ope=
n+0x6d/0x450
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_o=
pen+0xec/0x370
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_op=
enat+0x2017/0x50a0
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx=
_path_openat+0x10/0x10
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > > > > > > > > __pfx_stack_trace_save+0x10/0x10
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > > > > > > > > stack_depot_save_flags+0x28/0x8f0
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack=
_depot_save+0xe/0x20
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp=
_open+0x1b4/0x450
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > > > > > > > > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx=
_do_filp_open+0x10/0x10
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __lin=
k_object+0x13d/0x2b0
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > > > > > > > > __pfx__raw_spin_lock+0x10/0x10
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > > > > > > > > __check_object_size+0x453/0x600
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_=
spin_unlock+0xe/0x40
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_=
openat2+0xe6/0x180
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > > > > > > > > __pfx_do_sys_openat2+0x10/0x10
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_s=
ys_openat+0x108/0x240
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > > > > > > > > __pfx___x64_sys_openat+0x10/0x10
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > > > > > > > > __pfx___handle_mm_fault+0x10/0x10
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys=
_call+0x134f/0x2350
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_sysc=
all_64+0x82/0xd50
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > > > > > > > > fpregs_assert_state_consistent+0x5c/0x100
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_sy=
scall_64+0xba/0xd50
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kas=
an_check_read+0x11/0x20
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > > > > > > > > count_memcg_events+0x25b/0x400
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handl=
e_mm_fault+0x38b/0x6a0
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kas=
an_check_read+0x11/0x20
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > > > > > > > > fpregs_assert_state_consistent+0x5c/0x100
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > > > > > > > > irqentry_exit_to_user_mode+0x2e/0x2a0
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqen=
try_exit+0x43/0x50
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_p=
age_fault+0x95/0x100
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > > > > > > > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 003=
3:0x74a85bf145ab
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25=
 00 00 41 00 3d 00 00
> > > > > > > > > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 =
48 89 ee bf 9c ff ff ff
> > > > > > > > > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 0=
0 48 8b 54 24 28 64 48
> > > > > > > > > 2b 14 25
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002=
b:00007ffc77d316d0
> > > > > > > > > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: fff=
fffffffffffda RBX:
> > > > > > > > > 0000000000000002 RCX: 000074a85bf145ab
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 000=
0000000000000 RSI:
> > > > > > > > > 00007ffc77d32789 RDI: 00000000ffffff9c
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 000=
07ffc77d32789 R08:
> > > > > > > > > 00007ffc77d31980 R09: 0000000000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 000=
0000000000000 R11:
> > > > > > > > > 0000000000000246 R12: 0000000000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 000=
00000ffffffff R14:
> > > > > > > > > 0000000000000180 R15: 0000000000000001
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules =
linked in:
> > > > > > > > > intel_rapl_msr intel_rapl_common intel_uncore_frequency_c=
ommon intel_pmc_core
> > > > > > > > > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_tel=
emetry intel_vsec
> > > > > > > > > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmu=
lni_intel aesni_intel
> > > > > > > > > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid =
i2c_smbus vgastate
> > > > > > > > > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd ms=
r parport_pc ppdev lp
> > > > > > > > > parport efi_pstore
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 000=
0000000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end=
 trace 0000000000000000
> > > > > > > > > ]---
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 001=
0:strcmp+0x1c/0x40
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90=
 90 90 90 90 90 90 90
> > > > > > > > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 =
00 00 90 48 83 c0 01 84
> > > > > > > > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d=
2 31 f6 31 ff c3 cc cc
> > > > > > > > > cc cc 31
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 001=
8:ffff8881536875c0
> > > > > > > > > EFLAGS: 00010246
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 000=
0000000000000 RBX:
> > > > > > > > > ffff888116003200 RCX: 0000000000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 000=
0000000000063 RSI:
> > > > > > > > > 0000000000000000 RDI: ffff88810126c900
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: fff=
f8881536876a8 R08:
> > > > > > > > > 0000000000000000 R09: 0000000000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 000=
0000000000000 R11:
> > > > > > > > > 0000000000000000 R12: dffffc0000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: fff=
f8881061d0000 R14:
> > > > > > > > > 0000000000000000 R15: 0000000000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000=
074a85c082840(0000)
> > > > > > > > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  001=
0 DS: 0000 ES: 0000
> > > > > > > > > CR0: 0000000080050033
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 000=
0000000000000 CR3:
> > > > > > > > > 0000000110ebd001 CR4: 0000000000772ef0
> > > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55=
555554
> > > > > > > > >
> > > > > > > > > We have issue here [1] if fs_name =3D=3D NULL:
> > > > > > > > >
> > > > > > > > > const char fs_name =3D mdsc->fsc->mount_options->mds_name=
space;
> > > > > > > > >      ...
> > > > > > > > >      if (auth->match.fs_name && strcmp(auth->match.fs_nam=
e, fs_name)) {
> > > > > > > > >              / fsname mismatch, try next one */
> > > > > > > > >              return 0;
> > > > > > > > >      }
> > > > > > > > >
> > > > > > > > > The patch fixes the issue by introducing is_fsname_mismat=
ch() method
> > > > > > > > > that checks auth->match.fs_name and fs_name pointers vali=
dity, and
> > > > > > > > > compares the file system names.
> > > > > > > > >
> > > > > > > > > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/=
ceph/mds_client.c#L5666
> > > > > > > > >
> > > > > > > > > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps iss=
ue")
> > > > > > > > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > > > > > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > > > > > > > > cc: Alex Markuze <amarkuze@redhat.com>
> > > > > > > > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > > > > > > > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > > > > > > > > ---
> > > > > > > > >   fs/ceph/mds_client.c | 20 +++++++++++++++++---
> > > > > > > > >   1 file changed, 17 insertions(+), 3 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > > > > > > > index 1740047aef0f..19c75e206300 100644
> > > > > > > > > --- a/fs/ceph/mds_client.c
> > > > > > > > > +++ b/fs/ceph/mds_client.c
> > > > > > > > > @@ -5647,6 +5647,22 @@ void send_flush_mdlog(struct ceph_=
mds_session *s)
> > > > > > > > >          mutex_unlock(&s->s_mutex);
> > > > > > > > >   }
> > > > > > > > >
> > > > > > > > > +static inline
> > > > > > > > > +bool is_fsname_mismatch(struct ceph_client *cl,
> > > > > > > > > +                       const char *fs_name1, const char =
*fs_name2)
> > > > > > > > > +{
> > > > > > > > > +       if (!fs_name1 || !fs_name2)
> > > > > > > > > +               return false;
> > > > > > > >
> > > > > > > > Hi Slava,
> > > > > > > >
> > > > > > > > It looks like this would declare a match (return false for =
"mismatch")
> > > > > > > > in case ceph_mds_cap_auth is defined to require a particula=
r fs_name but
> > > > > > > > no mds_namespace was passed on mount.  Is that the desired =
behavior?
> > > > > > > >
> > > > > > >
> > > > > > > Hi Ilya,
> > > > > > >
> > > > > > > Before 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")=
, we had no such
> > > > > > > check in the logic of ceph_mds_auth_match(). So, if auth->mat=
ch.fs_name or
> > > > > > > fs_name is NULL, then we cannot say that they match or not. I=
t means that we
> > > > > > > need to continue logic, this is why is_fsname_mismatch() retu=
rns false.
> > > > > > > Otherwise, if we stop logic by returning true, then we have b=
unch of xfstests
> > > > > > > failures.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Slava.
> > > > > > >
> > > > > > > > > +
> > > > > > > > > +       doutc(cl, "fsname check fs_name1=3D%s fs_name2=3D=
%s\n",
> > > > > > > > > +             fs_name1, fs_name2);
> > > > > > > > > +
> > > > > > > > > +       if (strcmp(fs_name1, fs_name2))
> > > > > > > > > +               return true;
> > > > > > > > > +
> > > > > > > > > +       return false;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >   static int ceph_mds_auth_match(struct ceph_mds_client *=
mdsc,
> > > > > > > > >                                 struct ceph_mds_cap_auth =
*auth,
> > > > > > > > >                                 const struct cred *cred,
> > > > > > > > > @@ -5661,9 +5677,7 @@ static int ceph_mds_auth_match(stru=
ct ceph_mds_client *mdsc,
> > > > > > > > >          u32 gid, tlen, len;
> > > > > > > > >          int i, j;
> > > > > > > > >
> > > > > > > > > -       doutc(cl, "fsname check fs_name=3D%s  match.fs_na=
me=3D%s\n",
> > > > > > > > > -             fs_name, auth->match.fs_name ? auth->match.=
fs_name : "");
> > > > > > > > > -       if (auth->match.fs_name && strcmp(auth->match.fs_=
name, fs_name)) {
> > > > > > > > > +       if (is_fsname_mismatch(cl, auth->match.fs_name, f=
s_name)) {
> > > > > > > > >                  /* fsname mismatch, try next one */
> > > > > > > > >                  return 0;
> > > > > > > > >          }
> > > > > > > > > --
> > > > > > > > > 2.51.1
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>


