Return-Path: <linux-fsdevel+bounces-51639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5ABAD981A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 00:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F207AF21E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 22:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589B328135D;
	Fri, 13 Jun 2025 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNBw5d6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B087223DD1
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749853224; cv=none; b=Hy6Rccb9GTe/jOZGQTPKm42AP/pI16IMDmT/2VqnXWyM1oNU8ABOr1YfV7J/h/IOD0RmPz+UiIzff9nrv/gTupsKyNRyuVksw6BDPEIU0BdCMTJhHXoETsLhlIbZ6/yQg/49XxdsKDfn3G+LugdDk6obTyRo9yHfxBMG3AA5qas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749853224; c=relaxed/simple;
	bh=OMIGIWIQd/rSC7KFxNJWRnMBcDJzLtcHNlB/hinhRdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrwj4uGHSS5eLOBD77O29f+38ehPtpyPYtuHIaowY8qDo7DofDa71lSsCuX3kSQFpH7a1T0gy40KcSVgO1+kMDNPACHKKy9zBkQ/m6Zcu2MC1xS39wlD95Ti5qgid3GJcuKiZhpnOHKXZmQBQ0iA8wEfNvR0FHfeq9zCefEz8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNBw5d6e; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a44b3526e6so35075421cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749853222; x=1750458022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaufVDbjlFpyqm2sfJEF/rCAZBpY5rUDXdDgMGT3YeU=;
        b=kNBw5d6eoVsazjxNj2qr2leiwvCiR/DE6p6aOjgFl+c9RwgmEfBfqDni6RQDScq3uD
         92c6LgoDWvzKicPVzT9jRpZuzK5u7ItcnvSuaiROZ04sZV74XEne7Ot0Qdd8CiESjswa
         YuWZ/Wo2OBTNvWUv9AhlyMUZAAq1xdRMH2zbfok1UUIbUlzOlYNkETXxVamziwMdjl4x
         rbD0vrh4YthzYJjHkyK+i7kNQluzqURVPp7bNxyiik7d6s7ci7GvMgL/AADYtkUBiZyD
         oYLUKHaDAfjWqfT0WaRBGooEHLRisfpQ98fXvDA2NQC2pciXgtofKJoZAIOKc8gNwcnj
         8HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749853222; x=1750458022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaufVDbjlFpyqm2sfJEF/rCAZBpY5rUDXdDgMGT3YeU=;
        b=GdtAO+bmTYJx4TD2pL0fJR9jDD3mV9Fug+CcJ1JH0DTqsULyX7nRm5+njCZJNH/Up1
         CBtLwldcCQ2JRN7YMQNjfY74N5U5HkKKpAlMtku64rlkicRpJ5LkMe1TwPycYuCcXzAi
         +27u3+UuNKnkLYthYjbKxP4QXPkpsUps8CT3Fm8bEm1WQQNsf0eqjQMQeuApd2M03Mbz
         GsKz4uAL5KxBb6gvZnRKLiQln6RN/S2DKWiZrOB8UCoRNAHBlSObs+YiEj7MAOoQNWmP
         96eOhQirXBrLugXD4T8adXWmC00jkYW3pFy+574DWs97VFkuC+VUXncz3p8SL61iqTlJ
         EbDg==
X-Forwarded-Encrypted: i=1; AJvYcCV9IW88Fod7HbqiPLCnT3rkdm/M7ZR1ng9Lw5nlgc+uGSNRzCAPsTrZsU6+vfuMl2dQZI7RTaXDFwvz31Sv@vger.kernel.org
X-Gm-Message-State: AOJu0YyvZbaePv+M8YMNw5JRO0IVC6AOop5MVsaIlim9hWJE5p34dCom
	3C3/RoS3fy18jko9pBwhfO8XHmiKnbj8HXlOorb+3QC8rso5/HQriCIP2c0D8vMPwSp4e/eHYKC
	ZY8GkCgVYVn82QhYfPO2ryCwI7cQf5IdTag==
X-Gm-Gg: ASbGncvWCebtNkdBjZBazC5hIKTthBszw1D+veXJdz9aOvDHTaNhv/Wymj0I9YW4NIx
	jByqOE1tGE3CXgBdKQ/PYJjveJ72GasZNCjzZrabnyEqJwk1OQrD1OObiG/zbAkTD7neyjO2Foz
	LYyatIPXtFSxB2Lx4nS0m7oHy9oLSIBTYm1Zu5WsF0vfFITFroPwaLSLiYD4w=
X-Google-Smtp-Source: AGHT+IEa+9cpl34UKtX4wSJHRiNmvZnCPgd9ICN/SMCQF4HajiVHm6rC51Ma/5vijXu7sMdaPvCkJkNhS0n0sZ7I8lY=
X-Received: by 2002:a05:622a:c3:b0:4a4:369c:762b with SMTP id
 d75a77b69052e-4a73c4c54efmr13386741cf.22.1749853221975; Fri, 13 Jun 2025
 15:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEq4haEQScwHIWK6@bfoster> <CAJnrk1aD_N6zX_htAgto_Bzo+1S-dmvgGRHaT_icbnwpVoDGsg@mail.gmail.com>
 <871prn20sm.fsf@igalia.com>
In-Reply-To: <871prn20sm.fsf@igalia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 13 Jun 2025 15:20:11 -0700
X-Gm-Features: AX0GCFsj85fv7a4a86fuFgx3STrfMOEKZEXHOhlryT_9VO-Ko_7MLSwv_Cqn4aY
Message-ID: <CAJnrk1ZYKnS65sOdM5_SNpQ_bWakctKCcPNdoFW0VwYLW0s40A@mail.gmail.com>
Subject: Re: [BUG] fuse/virtiofs: kernel module build fail
To: Luis Henriques <luis@igalia.com>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 7:06=E2=80=AFAM Luis Henriques <luis@igalia.com> wr=
ote:
>
> On Thu, Jun 12 2025, Joanne Koong wrote:
>
> > On Thu, Jun 12, 2025 at 4:19=E2=80=AFAM Brian Foster <bfoster@redhat.co=
m> wrote:
> >>
> >> Hi folks,
> >>
> >> I run kernel compiles quite a bit over virtiofs in some of my local te=
st
> >> setups and recently ran into an issue building xfs.ko once I had a
> >> v6.16-rc kernel installed in my guest. The test case is a simple:
> >>
> >>   make -j N M=3Dfs/xfs clean; make -j N M=3Dfs/xfs
> >
> > Hi Brian,
> >
> > If I'm understanding your setup correctly, basically you have the
> > v6.16-rc kernel running on a VM, on that VM you mounted a virtiofs
> > directory that references a linux repo that's on your host OS, and
> > then from your VM you are compiling the fs/xfs module in that shared
> > linux repo?
> >
> > I tried this on my local setup but I'm seeing some other issues:
> >
> > make[1]: Entering directory '/home/vmuser/linux/linux/fs/xfs'
> >   LD [M]  xfs.o
> > xfs.o: warning: objtool: __traceiter_xfs_attr_list_sf+0x23:
> > unannotated intra-function call
> > make[3]: *** [/home/vmuser/linux/linux/scripts/Makefile.build:501:
> > xfs.o] Error 255
> > make[3]: *** Deleting file 'xfs.o'
> > make[2]: *** [/home/vmuser/linux/linux/Makefile:2006: .] Error 2
> > make[1]: *** [/home/vmuser/linux/linux/Makefile:248: __sub-make] Error =
2
> > make[1]: Leaving directory '/home/vmuser/linux/linux/fs/xfs'
> > make: *** [Makefile:248: __sub-make] Error 2
> >
> > Did you also run into these issues when you were compiling?
>
> This is probably just a shot in the dark, but I remember seeing similar
> build failures long time ago due to virtiofs caching.  I don't remember
> the details, but maybe it's worth checking that.  I *think* that what
> fixed it for me was to use '--cache auto'.

Thanks for the tip. I just tried it again with --cache=3Dauto but I'm
still seeing the same issue.

>
> Cheers,
> --
> Lu=C3=ADs
>
>
> > Taking a look at what 63c69ad3d18a ("fuse: refactor
> > fuse_fill_write_pages()") does, it seems odd to me that the changes in
> > that commit would lead to the issues you're seeing - that commit
> > doesn't alter structs or memory layouts in any way. I'll keep trying
> > to repro the issue you're seeing.
> >
> >>
> >> ... and ends up spitting out link time errors like this as of commit
> >> 63c69ad3d18a ("fuse: refactor fuse_fill_write_pages()"):
> >>
> >> ...
> >>   CC [M]  xfs.mod.o
> >>   CC [M]  .module-common.o
> >>   LD [M]  xfs.ko
> >>   BTF [M] xfs.ko
> >> die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_un=
it or DW_TAG_skeleton_unit expected got subprogram (0x2e) @ ed957!
> >> error decoding cu i_mmap_rwsem
> >> error decoding cu
> >> ...
> >> error decoding cu
> >> pahole: xfs.ko: Invalid argument
> >> make[3]: *** [/root/repos/linux/scripts/Makefile.modfinal:57: xfs.ko] =
Error 1
> >> make[3]: *** Deleting file 'xfs.ko'
> >> make[2]: *** [/root/repos/linux/Makefile:1937: modules] Error 2
> >> make[1]: *** [/root/repos/linux/Makefile:248: __sub-make] Error 2
> >> make[1]: Leaving directory '/root/repos/linux/fs/xfs'
> >> make: *** [Makefile:248: __sub-make] Error 2
> >>
> >> ... or this on latest master:
> >>
> >> ...
> >>   LD [M]  fs/xfs/xfs.o
> >> fs/xfs/xfs.o: error: objtool: can't find reloc entry symbol 2145964924=
 for .rela.text
> >> make[4]: *** [scripts/Makefile.build:501: fs/xfs/xfs.o] Error 1
> >> make[4]: *** Deleting file 'fs/xfs/xfs.o'
> >> make[3]: *** [scripts/Makefile.build:554: fs/xfs] Error 2
> >> make[2]: *** [scripts/Makefile.build:554: fs] Error 2
> >> make[1]: *** [/root/repos/linux/Makefile:2006: .] Error 2
> >> make: *** [Makefile:248: __sub-make] Error 2
> >>
> >> The latter failure is what I saw through most of a bisect so I suspect
> >> one of the related followon commits alters the failure characteristic
> >> from the former, but I've not confirmed that. Also note out of
> >> convenience my test was to just recompile xfs.ko out of the same tree =
I
> >> was bisecting from because the failures were consistent and seemed to =
be
> >> a runtime kernel issue and not a source tree issue.
> >>
> >> I haven't had a chance to dig any further than this (and JFYI I'm
> >> probably not going to be responsive through the rest of today). I just
> >> completed the bisect and wanted to get it on list sooner rather than
> >> later..
> >>
> >> Brian
> >>
> >
>

