Return-Path: <linux-fsdevel+bounces-71790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D17CD2372
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 00:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19C8B3032123
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 23:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347CC2EC090;
	Fri, 19 Dec 2025 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYphjfXc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t2h2tBFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15FB2D877B
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766188688; cv=none; b=NIJwyHbpg4L8GDlCY5SEp1TBVZwyiF099UN4YZhPN0KBwJQtcgW9wAx10ysMZpanQxeRgV/CC8I5EmSqEP5z0dzJ8saWxch6TLxaBVny+FYndDxGX9u9PVszajWyeJ/G3QR1WhaNH58GX2ZclJViL78STLz3glghdJmrDHHduFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766188688; c=relaxed/simple;
	bh=fg5yo1xQHprJo8FbsfiNsG2MyoT6pTg3ZTbfjAtjHSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNdkiGPk6papwjQ4szFfDae1q7fvttSSzmLc5/yz7+nvm4/2qFdr39w64+bIZGugS4n+PV8/8UPSvcU/SlR0+w8HUXLPvh1Pc8PAGORj0so8R7suGhKcNdjZhQnyeJ89KcTzyL0vBhm/1ujTq6xYHV19aRaepqYAckmHAzm3XC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYphjfXc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t2h2tBFY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766188684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALzyGtBadbZGkYeZTAjY82NX2KCDRBpXYZcaej44mCc=;
	b=hYphjfXcg0NybKgzVuRN9RPujwnKSmkvr13nX64mt0JxQpROw+Isbe/IrBifI5of8A0iWu
	4pf2UGoe4zpZCONmbs60XKbSsLUbV7Ln5AN8M2JLqbSzS0wCfLfaX8uOPQaKYEbHrPVWLU
	PeGcHiz2/A6KWc1spXZZMsu1uJUQUjo=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-rb5CE_YzMKa8roF89epfHw-1; Fri, 19 Dec 2025 18:58:03 -0500
X-MC-Unique: rb5CE_YzMKa8roF89epfHw-1
X-Mimecast-MFC-AGG-ID: rb5CE_YzMKa8roF89epfHw_1766188683
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-657537cef7cso3400001eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 15:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766188683; x=1766793483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALzyGtBadbZGkYeZTAjY82NX2KCDRBpXYZcaej44mCc=;
        b=t2h2tBFYFEmWwWJkZepXsmmsDiNn8SFDRTsbNXzhi9u0yFZjEBxLIbWibHn+SY0gM9
         8XjDyvCSjVEViPSZ1CJ8posLmLs5xkyODUd2963zDoTWJaejWHSjsyS/CcAXxZQW9nVS
         9+4LNEyRenDOTMk4En3v7HWLJGgElK3/53MwgfN/xLWXiS11eH421/wFxQJlkfLf5Gog
         G8BEhxyMM1cZ6yGj2xrlASPpMU+vxGFPwaH/6qRZ4O/wiRjfIp96OjowC0wkJh9gFtjW
         hHAM/24dJhP5wPS48cEzV1xGq2ePLYy+7uTRjEk8yENTDXNdx776Ux1aoWuUjkz10i4p
         xwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766188683; x=1766793483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALzyGtBadbZGkYeZTAjY82NX2KCDRBpXYZcaej44mCc=;
        b=xPdPLLhbabD1LjyLE99eB8qg4wGHpt4xn5esT3Ox/qGsQ0JQg0qoK9eZThp6AVswaS
         9eJfmXBQuCuigYwbm+SD8HuC+EJP9zFMRcLqbIoVCLECYHNPCEJOC7/b8Nw3bzrsqAwv
         2YuupEI/BZKLsM9VowMyVnJpBUT4sxGJmgQLW4YPGsPNncQq19VKUqPEl00ljAWY7BGU
         rbGMglNzCI26CcK7n0mS46YuXLwCMjbzmAApLda+3G2sFS9YIoQSHJmVfmrfx9XMSkKv
         A+4QCbgRNWcJTm0rQb7PFvwDRXnOAgEJ53g1Vqsv/uu09zXCQLE4Kc8fceHWlH4ovyNe
         5naw==
X-Forwarded-Encrypted: i=1; AJvYcCWiC+iPhPDp9LiMyrYgw1SDMNK6brSMdlqUEl0V+THFBJyAAWNibFLA5UuYL3yrhgs2lCUhYwFMQdGGBJqA@vger.kernel.org
X-Gm-Message-State: AOJu0YwKUGsaKLbnSXp02o91N1bGRtj+vATGLfazbLUm9muKwgwohyf5
	1NeiNRZg9d/Xm12UeDajH4V+kSeefNXwmM8S2+v9RHF0InQ5dL8diOn02lgwtMbg8FlsAAYMQB+
	KSafn/NmZkp+4DiryVJHuOXx6zA4Og/5VybgfrX6T5NJ5Uj5vEl1LPb67dEKSNSohIjJBvvrG8W
	b4vt/Yavn4rphRzjZQFNLI2NJWvhIlqLmJ3LVui23bJw==
X-Gm-Gg: AY/fxX6m/3BYCf5Gyzikaw7qchrC3c/Ssq3TD5jLl5mdPi9zvNy4+HFsvTQDu+JQhoV
	RugMBCojSUAE7o+R1dSjnWYtUynp7GuyBKX6IvUOFJgsYJ1qao2iSsCywDVFSMmcofNHg6gJyI1
	l/KvbZwFwe6bUt/XLLz5URrhqJHQahFeN+AB4OpFoE3QkzTWWUW22pP/4hmmChzwWSyUwFRRHfL
	16FNmwvCBkkp4AGNYFUYCIlBQ==
X-Received: by 2002:a05:6820:22a6:b0:659:9a49:9009 with SMTP id 006d021491bc7-65d0ea7234dmr2047569eaf.54.1766188682809;
        Fri, 19 Dec 2025 15:58:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkZgbLIJ6ZlFxqxj6DIFGtzXWHySjjDCDaU59hhL/rXFFpA1JV6B/4qSUVo4rT38mLRQ6n9JAyYN2XvIzJQBU=
X-Received: by 2002:a05:6820:22a6:b0:659:9a49:9009 with SMTP id
 006d021491bc7-65d0ea7234dmr2047556eaf.54.1766188682443; Fri, 19 Dec 2025
 15:58:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215215301.10433-2-slava@dubeyko.com> <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
 <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com> <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
 <fd1e92b107d6c36f65ebc12e5aaa7fb773608c6f.camel@ibm.com> <CA+2bHPaxwf5iVo5N9HgOeCQtVTL8+LrHN_=K3EB-z+jujdGbuQ@mail.gmail.com>
 <87994d8c04ecb211005c0ad63f63e750b41070bd.camel@ibm.com>
In-Reply-To: <87994d8c04ecb211005c0ad63f63e750b41070bd.camel@ibm.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Fri, 19 Dec 2025 18:57:36 -0500
X-Gm-Features: AQt7F2pX1AEqWsLpHfP7izf2vX1wqWKkYGVE75LfO8EsP1EnvxMqAPnEDWiZuXE
Message-ID: <CA+2bHPZjUqwPfGiCMLkktszx+E2iatE80O0FHk4pr=K08GJH8g@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	Kotresh Hiremath Ravishankar <khiremat@redhat.com>, Alex Markuze <amarkuze@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 3:39=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Thu, 2025-12-18 at 20:11 -0500, Patrick Donnelly wrote:
> > On Thu, Dec 18, 2025 at 2:02=E2=80=AFPM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> > >
> > > On Wed, 2025-12-17 at 22:50 -0500, Patrick Donnelly wrote:
> > > > On Wed, Dec 17, 2025 at 3:44=E2=80=AFPM Viacheslav Dubeyko
> > > > <Slava.Dubeyko@ibm.com> wrote:
> > > > >
> > > > > On Wed, 2025-12-17 at 15:36 -0500, Patrick Donnelly wrote:
> > > > > > Hi Slava,
> > > > > >
> > > > > > A few things:
> > > > > >
> > > > > > * CEPH_NAMESPACE_WIDCARD -> CEPH_NAMESPACE_WILDCARD ?
> > > > >
> > > > > Yeah, sure :) My bad.
> > > > >
> > > > > > * The comment "name for "old" CephFS file systems," appears twi=
ce.
> > > > > > Probably only necessary in the header.
> > > > >
> > > > > Makes sense.
> > > > >
> > > > > > * You also need to update ceph_mds_auth_match to call
> > > > > > namespace_equals.
> > > > > >
> > > > >
> > > > > Do you mean this code [1]?
> > > >
> > > > Yes, that's it.
> > > >
> > > > > >  Suggest documenting (in the man page) that
> > > > > > mds_namespace mntopt can be "*" now.
> > > > > >
> > > > >
> > > > > Agreed. Which man page do you mean? Because 'man mount' contains =
no info about
> > > > > Ceph. And it is my worry that we have nothing there. We should do=
 something
> > > > > about it. Do I miss something here?
> > > >
> > > > https://github.com/ceph/ceph/blob/2e87714b94a9e16c764ef6f97de50aecf=
1b0c41e/doc/man/8/mount.ceph.rst
> > > >
> > > > ^ that file. (There may be others but I think that's the main one
> > > > users look at.)
> > >
> > > So, should we consider to add CephFS mount options' details into
> > > man page for generic mount command?
> >
> > For the generic mount command? No, only in mount.ceph(8).
> >
>
> I meant that, currently, we have no information about CephFS mount option=
s in
> man page for generic mount command. From my point of view, it makes sense=
 to
> have some explanation of CephFS mount options there. So, I see the point =
to send
> a patch for adding the explanation of CephFS mount options into man page =
of
> generic mount command. As a result, we will have brief information in man=
 page
> for generic mount command and detailed explanation in mount.ceph(8). How =
do you
> feel about it?

I didn't realize that the mount(8) manpage had FS specific options.
That would be good to add, certainly. I would also recommend pointing
out in that same man page that mount.ceph has some user-friendly
helpers (like pulling information out of the ceph.conf) so we
recommend using it routinely.

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


