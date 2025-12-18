Return-Path: <linux-fsdevel+bounces-71654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A88E1CCB654
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 11:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB41F303B643
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 10:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE49533EAFD;
	Thu, 18 Dec 2025 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw8J0xoz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F17A331A79
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766053858; cv=none; b=ZXDSnkc4/kdYDfx991JLHdDfhMYibcybHMP9Ua8jGigwkmmQnRo+38Mdwf9GGo9GHcPRkjNH2XGbVVIUFem/2wcMTihY1fH1Sws8Zi+mqB9sLzVdGEv7bI5q9A/V7mvbcc+GXInuQ0BzlAe0ThBXZxHNv7jYuvylhReWyJCmwwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766053858; c=relaxed/simple;
	bh=coLA1gMnueOdWW2y3zkfSAuSFNiYs3kPhCnOPTkxuf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQSyRrO1Ro+pBdtvgn7u2eGk56TUpoYIP3Qt1LW4MnQUdKQ4EECP/mVk5VMM5+la2OMnLhTdG43vohrDjxPIzGKytcrV/GDEwERoFzrXIbNo5nx2rdrfHrO2WSSBvXNhn3umd30dMeMnOjwX1bVp03ksYxNXrsoW3ZEbWFt+ePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw8J0xoz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0833b5aeeso6164905ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 02:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766053856; x=1766658656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfx0RSNVAivkH6E1CctvNqx0dWYRIEIIvPaPiHNi3os=;
        b=fw8J0xozTCj++5U+USmL9K9+0AUaiUN2hPOITMXq8m9FDVCk24dJr5HbPJJIaIeuo2
         GBkeNu+UBMxKAN1vFx560UjWjN5jSek70QEjCB6iHApc20D9n1GpsTXkuP6WbxAiwjQm
         YOyWM/pO4/vFQsGQxhUiVD/u+VwS0pJsXVI2ZPrwTr3wnzrfwSb03EcX+SAfTcd7zvr9
         Sk4/MzA7w9300n3KBuradHKIoPsACOm3cDCSElhI+9y+vYbs8gqo3ZFvi7ZBFtg3TIe5
         clNcMzSdqnfWxs2gLWPTrYGJlgm5rvnUVFGXSraUzUrcPuUmv3e8F6XpcwVeFYCsQ42r
         GxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766053856; x=1766658656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfx0RSNVAivkH6E1CctvNqx0dWYRIEIIvPaPiHNi3os=;
        b=Ga/t4SYsOyTLMNtHgm5fAV9Woy97g/cwlixofrZtfFVEWj5BDo/YTc4fTyFMGbiueH
         ov07bBajn5QSEAxYr3Yd23bWGH4t2pSN1i5LsgW5a5DDTtx9eu8tCXVtH2PApDV+K/wM
         euX+67gnzbeuJ3u8/F7SWFXp3yjQR8CFwUdHhrYIw9FFt4qb99WTHj2OcBSKWUd68KAr
         bE4u2bTdm0NA85UJX6+Uws/T8ZE+gpfGBRFmAAeI8C9ktibZm7cDSVPBFbm533EmrQRs
         qzeUBl4dKSIXnZDUad/HkeW1M172xKjqicqZxdF3kHa0wV8vt7efnehFQmwAsF9SanT2
         wBAA==
X-Forwarded-Encrypted: i=1; AJvYcCWFyI8uagH6+lyNcrirOvYKgohpNLbrJuuV++miBUeYFWuNJrGdcWwnBt+TR/vGLnRh2HnAO3AAJyQb2+it@vger.kernel.org
X-Gm-Message-State: AOJu0YzXaFoOMCxSakjpXmoPAx7cVFyX1U0sfi71AEkL08Co9SsUTI9x
	3QX+RlHLUFlQqSnYht78wG3o+PBNl72xNS8UHGl/WwjTzSUM/Ow6hSRoMXxvl1gILM08vFmZIlA
	JXrqXVnRpnD3uekPsBIRurp/hNmROnPQ=
X-Gm-Gg: AY/fxX5x8o7ZQG1HfYmTIjVecS14XgKlwjloCH6qkcYeXVIDu68JEgQfc7CUzhkksAc
	rlFlUVHAaLgVm6bmtx1bq0W79ysP6ExTwxrgPOIqjkN0D4UC3MT2DaKJrviTdNHEMA7XZ1qrR77
	k/RQK+D1yq7cFGBR8hoiXqoKCMNgJgAblOM2YM7k5ZzC6zGPRMfAeF5zklKHjjwpJNOiLU2Dqfs
	dtchZvneVo0rQBVeMDyQqX40ASa2AQ6XnoVqLpVNhd970Qe4627rRI0ytUJMC2XNpvbtzw=
X-Google-Smtp-Source: AGHT+IGTrXflbA7TuH+HMFPKadliLmhPvmaddni0A+suBBUE0r17KKOfpya47jmQzV7xIWL/JMQTbmyuegC/gaPJ6Kk=
X-Received: by 2002:a05:7022:7f1a:b0:11f:2c9e:87f8 with SMTP id
 a92af1059eb24-11f34c12699mr14026707c88.34.1766053856001; Thu, 18 Dec 2025
 02:30:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215215301.10433-2-slava@dubeyko.com> <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
 <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com> <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
In-Reply-To: <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 18 Dec 2025 11:30:42 +0100
X-Gm-Features: AQt7F2rd8ZAR0qUouk3bbCRZlGum8CJLI2DtlF-AsBtcTzZCpUDhii1Zu1eXreo
Message-ID: <CAOi1vP_y+UT8yk00gxQZ7YOfAN3kTu6e6LE1Ya87goMFLEROsw@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	Kotresh Hiremath Ravishankar <khiremat@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 4:50=E2=80=AFAM Patrick Donnelly <pdonnell@redhat.c=
om> wrote:
> > >  Suggest documenting (in the man page) that
> > > mds_namespace mntopt can be "*" now.
> > >
> >
> > Agreed. Which man page do you mean? Because 'man mount' contains no inf=
o about
> > Ceph. And it is my worry that we have nothing there. We should do somet=
hing
> > about it. Do I miss something here?
>
> https://github.com/ceph/ceph/blob/2e87714b94a9e16c764ef6f97de50aecf1b0c41=
e/doc/man/8/mount.ceph.rst
>
> ^ that file. (There may be others but I think that's the main one
> users look at.)

Hi Patrick,

Is that actually desired?  After having to take a look at the userspace
code to suggest the path forward in the thread for the previous version
of Slava's patch, I got the impression that "*" was just an MDSAuthCaps
thing.  It's one of the two ways to express a match for any fs_name
(the other is not specifying fs_name in the cap at all).

I don't think this kind of matching is supposed to occur when mounting.
When fs_name is passed via ceph_select_filesystem() API or --client_fs
option on mount it appears to be a literal comparison that happens in
FSMapUser::get_fs_cid().  Assuming "*" isn't a valid fs_name (it it was
the cap syntax wouldn't make sense), the user passing "*" for fs_name
when mounting would always lead to an error.

Thanks,

                Ilya

