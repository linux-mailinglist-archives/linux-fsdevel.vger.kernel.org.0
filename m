Return-Path: <linux-fsdevel+bounces-69231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 112DAC74863
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 15:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B0AFD30108
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE3E346FAE;
	Thu, 20 Nov 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aj0DqEsH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAT56BWu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39CC2FBDED
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648481; cv=none; b=Wf0gPxQEpnTrRFxPGNDNJjhOaeF4yyTJnJGo/YNEmdGWijEBwu6KoE+anxb1P6Dcg8DfCCknGdrC961yLAkq7ddvp84K/1JgE46mm850H04SpETSB/03uGi97Jfo5cfRef9EFn/ev3Wy0NVcVNNgglWNVtMtmrXZjqCmx2chq50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648481; c=relaxed/simple;
	bh=90bwdrSXnGV2AwpfXE41UB0u6TS8LAvPo4Iw+fEwR1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3+UgQGGfcwZtmFfRbtChsyIdXuzSZC1zrGRdF/KZ21YEFJAsRBPEDV3aoomfuhsG38hRfO5C4SXLi26LMue2tiD4SX/HfVMQzvIruwkzaXwBoqpyX31XLh9bvjBJhgBTMCgZ9Z+u1j1ncciS3RbtrrbxqkG2moqYe1AMZMqQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aj0DqEsH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAT56BWu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763648477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HC8LsMTSJRYHRNwi1nxukmbWM79j/db925ZKIbJYuY=;
	b=Aj0DqEsHyQ2QLa4kbjCzZmua6I/aBL51X/y78p3vJDtHZHPpKtkysRd7qYt/JM92hQo4Uf
	xozBP2AJ+6HieSl7wQMCd2bIEocR4FoVGCjQ8AlhDf+IUgUF+GZu6Xn3lPHvi9ax3JGiLx
	nJdMZNmMbHHpgqjXwjJdyc0SCWTqIXg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-h7EZrcslOb2Jzb7Z0apW1Q-1; Thu, 20 Nov 2025 09:21:14 -0500
X-MC-Unique: h7EZrcslOb2Jzb7Z0apW1Q-1
X-Mimecast-MFC-AGG-ID: h7EZrcslOb2Jzb7Z0apW1Q_1763648473
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88050bdc2abso33405836d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 06:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763648472; x=1764253272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HC8LsMTSJRYHRNwi1nxukmbWM79j/db925ZKIbJYuY=;
        b=HAT56BWu52NVRwQJyCH0+Ffeis6gu/nmZdRjPbxr0O4TUmjXDrPMqrEUHocH8bJM4D
         1dyQMyso+S9FqSgmXOg7TQ9oXOh7hLgO7+DQcXXutMXTdxmtcOieBh7F8oZepw5hEjF2
         CGNGLOELlphHuNU60tICONo6F+fLpfaPTXtbECnLV01lSVhhWwK/8OSD0ouTiMf+hODe
         pm7XwFBrSNPmdz+Ow/vl9q+I6w4n9okY3diIlD+T/1sa1qINMMgCoTHK76460hHDejXd
         azoWo8jzAZClwdjZ6jzogpjkDyzJLMTDIVzF0fynyx1+dUtAs3/jk4pH6nvUqBa9V++9
         2Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763648472; x=1764253272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0HC8LsMTSJRYHRNwi1nxukmbWM79j/db925ZKIbJYuY=;
        b=QG4n7TPYWeSn68uRNzq8HmItC1Upw+aljevAB7qCMcTRqskB20tHsNkWtWerZCh38v
         yrwkTWoS+3p3MZriuga2J4BbP26c7L04H5dtFMJJilVeXDmiU+faCWG3ntemMZKKtWE4
         unC0LHgshOIIZxk9h5ehNP5M76yV6/R7Oxnt86o1OCx+aYlnKum2iMbsu4kd0kGkqpyV
         fo+UAu4u0qorJS+EadDQd1HUD3Ow+IzIdmaBMsCb/n+RdAQ+6tUhZV07NsF+4F971Ju5
         R20fvBcm6Vcc27qymudPX4bp1WNf5rBxMnL4AHJkYy8pFuRfYqx25V6SMCxgAl9m+cRL
         MIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsWx8CpxeMbBlMEX/rcGuXltC/aQcanZo5i3PW6ObBMXBFIuOqYLJMGJdQQGqHIzSNipNi4E3SIaKW3fyY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhxn+xPkq6GNJFiyPW+r5fz+TTx2A2g8Z5QfeztCl9rV8VVsO9
	d5vgLcYtt0ZK4b8pw9im7lXVBYsiUiVJnXXbtdDv54o/tE4CVNWT4WL9Vkm1ITd+C3wiRdXZbnh
	3uL51hDtIiS3ksqm4jq20cYY3WeG8/cw/vfzOP+Bi/bHHU+xKTeRlOPlSwNBOGM78+iH3HrWtS8
	mDd/TfOwnbt1DnJsLd4l3fhoRVuojciNNnwJu/SY1WClqVrHm6
X-Gm-Gg: ASbGncsJlAyECZw9+LMe31gHgHmwgS+SbqtyFEx8g/QZqqaWbChb0+LdDJH5ioEbT6K
	ioHVxURujRQUJogM19KjyXxV61gjjyKUw7NYpVepYxk6GScd6+T4MHn5v++o76WrYtVRx3L9P5x
	Na8q6+TSOCgSc8q5Fhc1gOU8Paq42kOOR972Xyzm1Uah1bk8/aLhId2kv2rKBcS4d0NV2DW/Gfc
	UzEhHgVVJc5XkNAjUiBn6n9Vg==
X-Received: by 2002:a05:6214:4611:b0:880:53e3:3a2 with SMTP id 6a1803df08f44-8846dfc7b92mr43042256d6.11.1763648472367;
        Thu, 20 Nov 2025 06:21:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgtHcGMdGGzShiUCINa9C444bkPzixbinHxALJQ14MjZ/HD1sROCVgzEJnzEjTKkWogZbzjsyajFfQPw32DTQ=
X-Received: by 2002:a05:6214:4611:b0:880:53e3:3a2 with SMTP id
 6a1803df08f44-8846dfc7b92mr43041706d6.11.1763648471896; Thu, 20 Nov 2025
 06:21:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119193745.595930-2-slava@dubeyko.com> <CAOi1vP-bjx9FsRq+PA1NQ8fx36xPTYMp0Li9WENmtLk=gh_Ydw@mail.gmail.com>
 <fe7bd125c74a2df575c6c1f2d83de13afe629a7d.camel@ibm.com> <CAJ4mKGZexNm--cKsT0sc0vmiAyWrA1a6FtmaGJ6WOsg8d_2R3w@mail.gmail.com>
 <370dff22b63bae1296bf4a4c32a563ab3b4a1f34.camel@ibm.com>
In-Reply-To: <370dff22b63bae1296bf4a4c32a563ab3b4a1f34.camel@ibm.com>
From: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
Date: Thu, 20 Nov 2025 19:50:58 +0530
X-Gm-Features: AWmQ_bkaTcEBCHAqvdduQ7msqq_0gjYiDvdJP-pV8yTlZL1pLrcSSunLs5DBw_Y
Message-ID: <CAPgWtC58SL1=csiPa3fG7qR0sQCaUNaNDTwT1RdFTHD2BLFTZw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>, 
	Alex Markuze <amarkuze@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

I think the patch is necessary and fixes the crash. There is no harm
in taking this patch as it behaves like an old kernel with this
particular scenario.

When does the issue happen:
   - The issue happens only when the old mount syntax is used where
passing the file system name is optional in which case, it chooses the
default mds namespace but doesn't get filled in the
mdsc->fsc->mount_options->mds_namespace.
   - Along with the above, the mount user should be non admin.
Does it break the earlier fix ?
   - Not fully!!! Though the open does succeed, the subsequent
operation like write would get EPERM. I am not exactly able to
recollect but this was discussed before writing the fix 22c73d52a6d0
("ceph: fix multifs mds auth caps issue"), it's guarded by another
check before actual operation like write.

I think there are a couple of options to fix this cleanly.
 1. Use the default fsname when
mdsc->fsc->mount_options->mds_namespace is NULL during comparison.
 2. Mandate passing the fsname with old syntax ?


Thanks,
Kotresh H R



On Thu, Nov 20, 2025 at 4:47=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2025-11-19 at 15:02 -0800, Gregory Farnum wrote:
> >
> > That doesn=E2=80=99t sound right =E2=80=94 this is authentication code.=
 If the authorization is supplied for a namespace and we are mounting witho=
ut a namespace at all, isn=E2=80=99t that a jailbreak? So the NULL pointer =
should be accepted in one direction, but denied in the other?
>
> What is your particular suggestion? I am simply fixing the kernel crash a=
fter
> the 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue"). We didn't hav=
e any
> check before. Do you imply that 22c73d52a6d0 ("ceph: fix multifs mds auth=
 caps
> issue") fix is incorrect and we need to rework it somehow?
>
> If we will not have any fix, then 6.18 release will have broken CephFS ke=
rnel
> client.
>
> Thanks,
> Slava.
>
> >
> > On Wed, Nov 19, 2025 at 2:54=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubey=
ko@ibm.com> wrote:
> > > On Wed, 2025-11-19 at 23:40 +0100, Ilya Dryomov wrote:
> > > > On Wed, Nov 19, 2025 at 8:38=E2=80=AFPM Viacheslav Dubeyko <slava@d=
ubeyko.com> wrote:
> > > > >
> > > > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > >
> > > > > The CephFS kernel client has regression starting from 6.18-rc1.
> > > > >
> > > > > sudo ./check -g quick
> > > > > FSTYP         -- ceph
> > > > > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEM=
PT_DYNAMIC Fri
> > > > > Nov 14 11:26:14 PST 2025
> > > > > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > > > > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3=
300:/scratch
> > > > > /mnt/cephfs/scratch
> > > > >
> > > > > Killed
> > > > >
> > > > > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> > > > > (2)192.168.1.213:3300 session established
> > > > > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client1=
67616
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL=
 pointer
> > > > > dereference, address: 0000000000000000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor =
read access in
> > > > > kernel mode
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(=
0x0000) - not-
> > > > > present page
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000=
 [#1] SMP KASAN
> > > > > NOPTI
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PI=
D: 3453 Comm:
> > > > > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: Q=
EMU Standard PC
> > > > > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp=
+0x1c/0x40
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 9=
0 90 90 90 90
> > > > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90=
 48 83 c0 01 84
> > > > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 =
31 ff c3 cc cc
> > > > > cc cc 31
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff88=
81536875c0
> > > > > EFLAGS: 00010246
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 00000000000=
00000 RBX:
> > > > > ffff888116003200 RCX: 0000000000000000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 00000000000=
00063 RSI:
> > > > > 0000000000000000 RDI: ffff88810126c900
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536=
876a8 R08:
> > > > > 0000000000000000 R09: 0000000000000000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 00000000000=
00000 R11:
> > > > > 0000000000000000 R12: dffffc0000000000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061=
d0000 R14:
> > > > > 0000000000000000 R15: 0000000000000000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c0=
82840(0000)
> > > > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 00=
00 ES: 0000
> > > > > CR0: 0000000080050033
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 00000000000=
00000 CR3:
> > > > > 0000000110ebd001 CR4: 0000000000772ef0
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > > > > ceph_mds_check_access+0x348/0x1760
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > > > > __kasan_check_write+0x14/0x30
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0=
xb1/0x170
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > > > > __pfx__raw_spin_lock+0x10/0x10
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322=
/0xef0
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_op=
en+0x10/0x10
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > > > > __pfx_apparmor_file_open+0x10/0x10
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > > > > __ceph_caps_issued_mask_metric+0xd6/0x180
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+=
0x7bf/0x10e0
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_op=
en+0x10/0x10
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0=
x450
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec=
/0x370
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2=
017/0x50a0
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_op=
enat+0x10/0x10
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > > > > __pfx_stack_trace_save+0x10/0x10
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > > > > stack_depot_save_flags+0x28/0x8f0
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_s=
ave+0xe/0x20
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x=
1b4/0x450
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > > > > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp=
_open+0x10/0x10
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object=
+0x13d/0x2b0
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > > > > __pfx__raw_spin_lock+0x10/0x10
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > > > > __check_object_size+0x453/0x600
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unl=
ock+0xe/0x40
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+=
0xe6/0x180
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > > > > __pfx_do_sys_openat2+0x10/0x10
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_opena=
t+0x108/0x240
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > > > > __pfx___x64_sys_openat+0x10/0x10
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > > > > __pfx___handle_mm_fault+0x10/0x10
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x=
134f/0x2350
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0=
x82/0xd50
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > > > > fpregs_assert_state_consistent+0x5c/0x100
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64=
+0xba/0xd50
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check=
_read+0x11/0x20
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > > > > count_memcg_events+0x25b/0x400
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fau=
lt+0x38b/0x6a0
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check=
_read+0x11/0x20
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > > > > fpregs_assert_state_consistent+0x5c/0x100
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > > > > irqentry_exit_to_user_mode+0x2e/0x2a0
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit=
+0x43/0x50
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_faul=
t+0x95/0x100
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > > > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a8=
5bf145ab
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 4=
1 00 3d 00 00
> > > > > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee=
 bf 9c ff ff ff
> > > > > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b =
54 24 28 64 48
> > > > > 2b 14 25
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007f=
fc77d316d0
> > > > > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: fffffffffff=
fffda RBX:
> > > > > 0000000000000002 RCX: 000074a85bf145ab
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 00000000000=
00000 RSI:
> > > > > 00007ffc77d32789 RDI: 00000000ffffff9c
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d=
32789 R08:
> > > > > 00007ffc77d31980 R09: 0000000000000000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 00000000000=
00000 R11:
> > > > > 0000000000000246 R12: 0000000000000000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000fff=
fffff R14:
> > > > > 0000000000000180 R15: 0000000000000001
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked i=
n:
> > > > > intel_rapl_msr intel_rapl_common intel_uncore_frequency_common in=
tel_pmc_core
> > > > > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry i=
ntel_vsec
> > > > > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_inte=
l aesni_intel
> > > > > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbu=
s vgastate
> > > > > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parpor=
t_pc ppdev lp
> > > > > parport efi_pstore
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 00000000000=
00000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 0=
000000000000000
> > > > > ]---
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp=
+0x1c/0x40
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 9=
0 90 90 90 90
> > > > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90=
 48 83 c0 01 84
> > > > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 =
31 ff c3 cc cc
> > > > > cc cc 31
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff88=
81536875c0
> > > > > EFLAGS: 00010246
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 00000000000=
00000 RBX:
> > > > > ffff888116003200 RCX: 0000000000000000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 00000000000=
00063 RSI:
> > > > > 0000000000000000 RDI: ffff88810126c900
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536=
876a8 R08:
> > > > > 0000000000000000 R09: 0000000000000000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 00000000000=
00000 R11:
> > > > > 0000000000000000 R12: dffffc0000000000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061=
d0000 R14:
> > > > > 0000000000000000 R15: 0000000000000000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c0=
82840(0000)
> > > > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 00=
00 ES: 0000
> > > > > CR0: 0000000080050033
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 00000000000=
00000 CR3:
> > > > > 0000000110ebd001 CR4: 0000000000772ef0
> > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
> > > > >
> > > > > We have issue here [1] if fs_name =3D=3D NULL:
> > > > >
> > > > > const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> > > > >      ...
> > > > >      if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_na=
me)) {
> > > > >              / fsname mismatch, try next one */
> > > > >              return 0;
> > > > >      }
> > > > >
> > > > > The patch fixes the issue by introducing is_fsname_mismatch() met=
hod
> > > > > that checks auth->match.fs_name and fs_name pointers validity, an=
d
> > > > > compares the file system names.
> > > > >
> > > > > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds=
_client.c#L5666
> > > > >
> > > > > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > > > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > > > > cc: Alex Markuze <amarkuze@redhat.com>
> > > > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > > > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > > > > ---
> > > > >   fs/ceph/mds_client.c | 20 +++++++++++++++++---
> > > > >   1 file changed, 17 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > > > index 1740047aef0f..19c75e206300 100644
> > > > > --- a/fs/ceph/mds_client.c
> > > > > +++ b/fs/ceph/mds_client.c
> > > > > @@ -5647,6 +5647,22 @@ void send_flush_mdlog(struct ceph_mds_sess=
ion *s)
> > > > >          mutex_unlock(&s->s_mutex);
> > > > >   }
> > > > >
> > > > > +static inline
> > > > > +bool is_fsname_mismatch(struct ceph_client *cl,
> > > > > +                       const char *fs_name1, const char *fs_name=
2)
> > > > > +{
> > > > > +       if (!fs_name1 || !fs_name2)
> > > > > +               return false;
> > > >
> > > > Hi Slava,
> > > >
> > > > It looks like this would declare a match (return false for "mismatc=
h")
> > > > in case ceph_mds_cap_auth is defined to require a particular fs_nam=
e but
> > > > no mds_namespace was passed on mount.  Is that the desired behavior=
?
> > > >
> > >
> > > Hi Ilya,
> > >
> > > Before 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue"), we had=
 no such
> > > check in the logic of ceph_mds_auth_match(). So, if auth->match.fs_na=
me or
> > > fs_name is NULL, then we cannot say that they match or not. It means =
that we
> > > need to continue logic, this is why is_fsname_mismatch() returns fals=
e.
> > > Otherwise, if we stop logic by returning true, then we have bunch of =
xfstests
> > > failures.
> > >
> > > Thanks,
> > > Slava.
> > >
> > > > > +
> > > > > +       doutc(cl, "fsname check fs_name1=3D%s fs_name2=3D%s\n",
> > > > > +             fs_name1, fs_name2);
> > > > > +
> > > > > +       if (strcmp(fs_name1, fs_name2))
> > > > > +               return true;
> > > > > +
> > > > > +       return false;
> > > > > +}
> > > > > +
> > > > >   static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
> > > > >                                 struct ceph_mds_cap_auth *auth,
> > > > >                                 const struct cred *cred,
> > > > > @@ -5661,9 +5677,7 @@ static int ceph_mds_auth_match(struct ceph_=
mds_client *mdsc,
> > > > >          u32 gid, tlen, len;
> > > > >          int i, j;
> > > > >
> > > > > -       doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%s\=
n",
> > > > > -             fs_name, auth->match.fs_name ? auth->match.fs_name =
: "");
> > > > > -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs=
_name)) {
> > > > > +       if (is_fsname_mismatch(cl, auth->match.fs_name, fs_name))=
 {
> > > > >                  /* fsname mismatch, try next one */
> > > > >                  return 0;
> > > > >          }
> > > > > --
> > > > > 2.51.1
> > > > >
> > >
>
> --
> Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>


