Return-Path: <linux-fsdevel+bounces-73315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E56D156E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F10D302A979
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 21:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E546434107C;
	Mon, 12 Jan 2026 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaC9FEGl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSkHkqSQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F205340D91
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768253213; cv=none; b=OJZ8pg020Uz1DkkJ1iif/7glA7hHUrhEySBLQ7VywrewCUQTUqNVyGtt4jgyREQ8Us1Hj4lJg1RYWESmpRUuewM4DZtyxlEmHVt02rUSbUROQVaK7uOX/ukHfZvfPTEv7m6yt60DR7hE0IkJc+FoIZRjxVZBhQLKLxQJadd/bX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768253213; c=relaxed/simple;
	bh=Y03bHe98LnxuFTtgNByDYpXEynehM+zuNkaKA/TQbcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhbbR/pKGkJ/brW0kszeLaZ8ixK/cOlpUJvCB4W7nYdAAv2HIyPtxbO4oVDMFvmMtiQZJB10azhIkVtEq0AonHNVuCYkHLGnHm0uAhoJAuNIf7aiFfVjz6dC3JT2YuFj7Pa58QPFrzwd4tX4yw0UYSmOuZnmwpZDHIdNY7EwWtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaC9FEGl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSkHkqSQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768253210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmV479tBWzcEHNe0jwKxi9nv7cIqxxwZfBVP9Osm10g=;
	b=EaC9FEGlV4kRoGevZT9mrgjC2vqjv+R4RogBuxArxtWmZfdjl+xhkYjmEQV4SIGUGRbVs4
	54SgGXmWMYjtyZhqcxC3+ZE1xwxPy1EZQmURsSK8AvpOLiQ9kXIPTvdgs7AxuKBQ0M+m0Q
	NbtyQPtAWvWxA769SIVOEXg/qFU3kDM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-wyDWhhH5M-OuYLsfI-W4Gw-1; Mon, 12 Jan 2026 16:26:48 -0500
X-MC-Unique: wyDWhhH5M-OuYLsfI-W4Gw-1
X-Mimecast-MFC-AGG-ID: wyDWhhH5M-OuYLsfI-W4Gw_1768253208
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7ce5218a735so17425977a34.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 13:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768253207; x=1768858007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmV479tBWzcEHNe0jwKxi9nv7cIqxxwZfBVP9Osm10g=;
        b=QSkHkqSQzq9ZgjZb3ebXhBhVxeC5Swh7lMPRM6QIGSRh4l1DSRZKfL3L+Lf7AW/ZmJ
         AWbIow5U/9W6IK6xHu9uwm/3Z3BBaOQHMypRxaQqwas3jQ/NTJJPgwbaslXsv+kUrx0H
         E4WrAZNHk3rD2p58jLKYM94hwVKbuDQKoe4cxlmtuv8NWEm3jw2xfHE0c+hUHtupehsz
         QQbTwumAhJoS28ZaZDq1/dE0Nsreo0lQJpHgfhY8asqYgfUdc1c7V5JMpFhAwgyh5Ad8
         QjA5B+snMjMsIOSODT+4ljjB0WjXbLpc+Ey9ilwMO2a84IYD2RKJZEbauN2hd7+ui766
         qS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768253207; x=1768858007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kmV479tBWzcEHNe0jwKxi9nv7cIqxxwZfBVP9Osm10g=;
        b=KOL1EP/0hvPId5H8M7QyCiFDL92vrLQG7b11VNCScxWjPfYDmOteMDYMqtM8FGtGTx
         vCKvoAmJMdAKJKWCRHn6g4ohDmBDq3eU6QzyHmZ39UgRZW+iABUfVEpLEBXDCbSYTcGb
         ARxycEZ7mb2igH69Bwu+EZzZ5m+aeGfvsLIj/ad6Zy1DSCUAWgNX9a5u2Lq7NITZmzkw
         AsPVNJbaXxCrf1wtX2CQUR+lcmHXNebRayTK6/LCNcsQ1lE/BmiOMZtUMyvQRkA2KYTs
         SodTTFuaiFd7Vb0Py9ClmcVmQXYvig/Rn6iorLNxYbzN4djdfDHMSpLlLITXI40y1kbb
         Boeg==
X-Forwarded-Encrypted: i=1; AJvYcCW890TzAKPpuPwZNxtnvm9ywEbWvAYaHnc9YUVQ+st66CfPIGrYopHTBNLML6410VYqi4BUAlnTe9h11oec@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUEr6ACVRtYTpZKeYn277kgklq0md54UN9taLSqaByHUNIEbK
	ObPJDIVZcL8CkvaZsujjGKkhC9qamDpHiXo4aYMwSCvQ96WYaLGAnUDmdHHhIf3gzcn12E7XXT2
	u5QaPpLi/M1wJgbRvYkPncbDbf1uM2ETkQ6P0YJ+sWkTPP8fAKZYFwma4C9FvKC4IhbGAS3iwXf
	R31++e64fEvpsFA9zj/18W/mbkVEshsgp1DNIkkSVP9+domJqDLQzf
X-Gm-Gg: AY/fxX6T2fxKOBi2lMR9n82jv46GSkdC4HiYZnkDTTE1mi+75YLNAOWvvDhNtgSq6O8
	BvEqoo0Gmt7xI9gz9keIGHbizoZopq0FqL0d54XuSu56W1nHadQJKuH6xg2leD81zanZuZ04dGp
	FhiXwoteYSiE0ZjHsBpDpduD5GB8vTeul1VTfo2zceuVwS9KG8sPB1/PPZGdQON3JuCxm4V4lNh
	8cG5D0B9JoGitZyh4knzdVdPA==
X-Received: by 2002:a05:6820:e88:b0:65d:88b:c00d with SMTP id 006d021491bc7-65f54f72e3fmr6294588eaf.66.1768253207477;
        Mon, 12 Jan 2026 13:26:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeQ0uiFBQaxa7SffRWi8tKjHdWhRtUo+e3plbPFET3NgvpQSQccEc1NhqvIZlIpcA1lVuyBVpYnrp68AgFByU=
X-Received: by 2002:a05:6820:e88:b0:65d:88b:c00d with SMTP id
 006d021491bc7-65f54f72e3fmr6294573eaf.66.1768253207020; Mon, 12 Jan 2026
 13:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108223453.907929-2-slava@dubeyko.com> <CA+2bHPZ9WiTnJXFgoRveHchOm0j=A1qeKt+T59QJpfMkrPX0Mw@mail.gmail.com>
 <03d862404f1a64f1ca16aa863bd4d4a6d0cdf830.camel@ibm.com>
In-Reply-To: <03d862404f1a64f1ca16aa863bd4d4a6d0cdf830.camel@ibm.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Mon, 12 Jan 2026 16:26:20 -0500
X-Gm-Features: AZwV_QhSlc6xAL7en4zVb3NBQ5pkgVX081Yb3RLcyDDsHlx5G-4AH-ndBF06D0w
Message-ID: <CA+2bHPYqT8iMJrSDiO=m-dAvmWd3j+co6Sq0gZ+421p8KYMEnQ@mail.gmail.com>
Subject: Re: [PATCH v4] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "slava@dubeyko.com" <slava@dubeyko.com>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	Kotresh Hiremath Ravishankar <khiremat@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On Fri, Jan 9, 2026 at 3:43=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> On Fri, 2026-01-09 at 12:07 -0500, Patrick Donnelly wrote:
> > Hi Slava,
> >
> > On Thu, Jan 8, 2026 at 5:35=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyk=
o.com> wrote:
> > >
> > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > >
> > > The CephFS kernel client has regression starting from 6.18-rc1.
> > >
> > > sudo ./check -g quick
> > > FSTYP         -- ceph
> > > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_D=
YNAMIC Fri
> > > Nov 14 11:26:14 PST 2025
> > > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:=
/scratch
> > > /mnt/cephfs/scratch
> > >
> > > Killed
> > >
> > > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> > > (2)192.168.1.213:3300 session established
> > > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client16761=
6
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL poi=
nter
> > > dereference, address: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read=
 access in
> > > kernel mode
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x00=
00) - not-
> > > present page
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1=
] SMP KASAN
> > > NOPTI
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 3=
453 Comm:
> > > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU =
Standard PC
> > > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1=
c/0x40
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90=
 90 90 90
> > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 =
83 c0 01 84
> > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 f=
f c3 cc cc
> > > cc cc 31
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff888153=
6875c0
> > > EFLAGS: 00010246
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 000000000000000=
0 RBX:
> > > ffff888116003200 RCX: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 000000000000006=
3 RSI:
> > > 0000000000000000 RDI: ffff88810126c900
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a=
8 R08:
> > > 0000000000000000 R09: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 000000000000000=
0 R11:
> > > 0000000000000000 R12: dffffc0000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d000=
0 R14:
> > > 0000000000000000 R15: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c08284=
0(0000)
> > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 E=
S: 0000
> > > CR0: 0000000080050033
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 000000000000000=
0 CR3:
> > > 0000000110ebd001 CR4: 0000000000772ef0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > > ceph_mds_check_access+0x348/0x1760
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > > __kasan_check_write+0x14/0x30
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/=
0x170
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > > __pfx__raw_spin_lock+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xe=
f0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0=
x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > > __pfx_apparmor_file_open+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > > __ceph_caps_issued_mask_metric+0xd6/0x180
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7b=
f/0x10e0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0=
x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x3=
70
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/=
0x50a0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat=
+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > > __pfx_stack_trace_save+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > > stack_depot_save_flags+0x28/0x8f0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+=
0xe/0x20
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/=
0x450
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_ope=
n+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x1=
3d/0x2b0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > > __pfx__raw_spin_lock+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > > __check_object_size+0x453/0x600
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+=
0xe/0x40
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6=
/0x180
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > > __pfx_do_sys_openat2+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x=
108/0x240
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > > __pfx___x64_sys_openat+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > > __pfx___handle_mm_fault+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f=
/0x2350
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/=
0xd50
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > > fpregs_assert_state_consistent+0x5c/0x100
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xb=
a/0xd50
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_rea=
d+0x11/0x20
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > > count_memcg_events+0x25b/0x400
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0=
x38b/0x6a0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_rea=
d+0x11/0x20
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > > fpregs_assert_state_consistent+0x5c/0x100
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > > irqentry_exit_to_user_mode+0x2e/0x2a0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x4=
3/0x50
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x=
95/0x100
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf1=
45ab
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00=
 3d 00 00
> > > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf =
9c ff ff ff
> > > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 2=
4 28 64 48
> > > 2b 14 25
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77=
d316d0
> > > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffd=
a RBX:
> > > 0000000000000002 RCX: 000074a85bf145ab
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 000000000000000=
0 RSI:
> > > 00007ffc77d32789 RDI: 00000000ffffff9c
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d3278=
9 R08:
> > > 00007ffc77d31980 R09: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 000000000000000=
0 R11:
> > > 0000000000000246 R12: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000fffffff=
f R14:
> > > 0000000000000180 R15: 0000000000000001
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> > > intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_=
pmc_core
> > > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel=
_vsec
> > > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel ae=
sni_intel
> > > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vg=
astate
> > > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc=
 ppdev lp
> > > parport efi_pstore
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 000000000000000=
0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 00000=
00000000000
> > > ]---
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1=
c/0x40
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90=
 90 90 90
> > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 =
83 c0 01 84
> > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 f=
f c3 cc cc
> > > cc cc 31
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff888153=
6875c0
> > > EFLAGS: 00010246
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 000000000000000=
0 RBX:
> > > ffff888116003200 RCX: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 000000000000006=
3 RSI:
> > > 0000000000000000 RDI: ffff88810126c900
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a=
8 R08:
> > > 0000000000000000 R09: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 000000000000000=
0 R11:
> > > 0000000000000000 R12: dffffc0000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d000=
0 R14:
> > > 0000000000000000 R15: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c08284=
0(0000)
> > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 E=
S: 0000
> > > CR0: 0000000080050033
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 000000000000000=
0 CR3:
> > > 0000000110ebd001 CR4: 0000000000772ef0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
> > >
> > > We have issue here [1] if fs_name =3D=3D NULL:
> > >
> > > const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> > >     ...
> > >     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) =
{
> > >             / fsname mismatch, try next one */
> > >             return 0;
> > >     }
> > >
> > > v2
> > > Patrick Donnelly suggested that: In summary, we should definitely sta=
rt
> > > decoding `fs_name` from the MDSMap and do strict authorizations check=
s
> > > against it. Note that the `--mds_namespace` should only be used for
> > > selecting the file system to mount and nothing else. It's possible
> > > no mds_namespace is specified but the kernel will mount the only
> > > file system that exists which may have name "foo".
> > >
> > > v3
> > > The namespace_equals() logic has been generalized into
> > > __namespace_equals() with the goal of using it in
> > > ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
> > > The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.
> > >
> > > v4
> > > The __namespace_equals() now supports wildcard check.
> > >
> > > This patch reworks ceph_mdsmap_decode() and namespace_equals() with
> > > the goal of supporting the suggested concept. Now struct ceph_mdsmap
> > > contains m_fs_name field that receives copy of extracted FS name
> > > by ceph_extract_encoded_string(). For the case of "old" CephFS file s=
ystems,
> > > it is used "cephfs" name. Also, namespace_equals() method has been
> > > reworked with the goal of proper names comparison.
> > >
> > > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_cli=
ent.c#L5666
> > > [2] https://tracker.ceph.com/issues/73886
> > >
> > > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > > cc: Alex Markuze <amarkuze@redhat.com>
> > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > cc: Patrick Donnelly <pdonnell@redhat.com>
> > > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > > ---
> > >  fs/ceph/mds_client.c         | 12 ++++----
> > >  fs/ceph/mdsmap.c             | 22 +++++++++++----
> > >  fs/ceph/mdsmap.h             |  1 +
> > >  fs/ceph/super.h              | 54 ++++++++++++++++++++++++++++++++--=
--
> > >  include/linux/ceph/ceph_fs.h |  6 ++++
> > >  5 files changed, 78 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > index 7e4eab824dae..339736423cae 100644
> > > --- a/fs/ceph/mds_client.c
> > > +++ b/fs/ceph/mds_client.c
> > > @@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_=
client *mdsc,
> > >         u32 caller_uid =3D from_kuid(&init_user_ns, cred->fsuid);
> > >         u32 caller_gid =3D from_kgid(&init_user_ns, cred->fsgid);
> > >         struct ceph_client *cl =3D mdsc->fsc->client;
> > > -       const char *fs_name =3D mdsc->fsc->mount_options->mds_namespa=
ce;
> > > +       const char *fs_name =3D mdsc->mdsmap->m_fs_name;
> > >         const char *spath =3D mdsc->fsc->mount_options->server_path;
> > >         bool gid_matched =3D false;
> > >         u32 gid, tlen, len;
> > > @@ -5679,7 +5679,9 @@ static int ceph_mds_auth_match(struct ceph_mds_=
client *mdsc,
> > >
> > >         doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%s\n",
> > >               fs_name, auth->match.fs_name ? auth->match.fs_name : ""=
);
> > > -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_nam=
e)) {
> > > +
> > > +       if (!__namespace_equals(auth->match.fs_name, is_wildcard_requ=
ested,
> > > +                               fs_name, NULL, NAME_MAX)) {
> > >                 /* fsname mismatch, try next one */
> > >                 return 0;
> > >         }
> > > @@ -6122,7 +6124,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_cli=
ent *mdsc, struct ceph_msg *msg)
> > >  {
> > >         struct ceph_fs_client *fsc =3D mdsc->fsc;
> > >         struct ceph_client *cl =3D fsc->client;
> > > -       const char *mds_namespace =3D fsc->mount_options->mds_namespa=
ce;
> > >         void *p =3D msg->front.iov_base;
> > >         void *end =3D p + msg->front.iov_len;
> > >         u32 epoch;
> > > @@ -6157,9 +6158,8 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_cli=
ent *mdsc, struct ceph_msg *msg)
> > >                 namelen =3D ceph_decode_32(&info_p);
> > >                 ceph_decode_need(&info_p, info_end, namelen, bad);
> > >
> > > -               if (mds_namespace &&
> > > -                   strlen(mds_namespace) =3D=3D namelen &&
> > > -                   !strncmp(mds_namespace, (char *)info_p, namelen))=
 {
> > > +               if (namespace_equals(fsc->mount_options,
> > > +                                    (char *)info_p, namelen)) {
> > >                         mount_fscid =3D fscid;
> > >                         break;
> > >                 }
> > > diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> > > index 2c7b151a7c95..9cadf811eb4b 100644
> > > --- a/fs/ceph/mdsmap.c
> > > +++ b/fs/ceph/mdsmap.c
> > > @@ -353,22 +353,31 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct c=
eph_mds_client *mdsc, void **p,
> > >                 __decode_and_drop_type(p, end, u8, bad_ext);
> > >         }
> > >         if (mdsmap_ev >=3D 8) {
> > > -               u32 fsname_len;
> > > +               size_t fsname_len;
> > > +
> > >                 /* enabled */
> > >                 ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
> > > +
> > >                 /* fs_name */
> > > -               ceph_decode_32_safe(p, end, fsname_len, bad_ext);
> > > +               m->m_fs_name =3D ceph_extract_encoded_string(p, end,
> > > +                                                          &fsname_le=
n,
> > > +                                                          GFP_NOFS);
> > > +               if (IS_ERR(m->m_fs_name)) {
> > > +                       m->m_fs_name =3D NULL;
> > > +                       goto nomem;
> > > +               }
> > >
> > >                 /* validate fsname against mds_namespace */
> > > -               if (!namespace_equals(mdsc->fsc->mount_options, *p,
> > > +               if (!namespace_equals(mdsc->fsc->mount_options, m->m_=
fs_name,
> > >                                       fsname_len)) {
> > >                         pr_warn_client(cl, "fsname %*pE doesn't match=
 mds_namespace %s\n",
> > > -                                      (int)fsname_len, (char *)*p,
> > > +                                      (int)fsname_len, m->m_fs_name,
> > >                                        mdsc->fsc->mount_options->mds_=
namespace);
> > >                         goto bad;
> > >                 }
> > > -               /* skip fsname after validation */
> > > -               ceph_decode_skip_n(p, end, fsname_len, bad);
> > > +       } else {
> > > +               m->m_enabled =3D false;
> > > +               m->m_fs_name =3D kstrdup(CEPH_OLD_FS_NAME, GFP_NOFS);

this needs a check:

if (!m->m_fs_name)  goto nomem;

> > >         }
> > >         /* damaged */
> > >         if (mdsmap_ev >=3D 9) {
> > > @@ -430,6 +439,7 @@ void ceph_mdsmap_destroy(struct ceph_mdsmap *m)
> > >                 kfree(m->m_info);
> > >         }
> > >         kfree(m->m_data_pg_pools);
> > > +       kfree(m->m_fs_name);
> > >         kfree(m);
> > >  }
> > >
> > > diff --git a/fs/ceph/mdsmap.h b/fs/ceph/mdsmap.h
> > > index 1f2171dd01bf..d48d07c3516d 100644
> > > --- a/fs/ceph/mdsmap.h
> > > +++ b/fs/ceph/mdsmap.h
> > > @@ -45,6 +45,7 @@ struct ceph_mdsmap {
> > >         bool m_enabled;
> > >         bool m_damaged;
> > >         int m_num_laggy;
> > > +       char *m_fs_name;
> > >  };
> > >
> > >  static inline struct ceph_entity_addr *
> > > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > > index a1f781c46b41..fe950bd72452 100644
> > > --- a/fs/ceph/super.h
> > > +++ b/fs/ceph/super.h
> > > @@ -104,18 +104,62 @@ struct ceph_mount_options {
> > >         struct fscrypt_dummy_policy dummy_enc_policy;
> > >  };
> > >
> > > +#define CEPH_NAMESPACE_WILDCARD                "*"
> > > +
> > > +typedef bool (*wildcard_check_fn)(const char *name);
> > > +
> > > +static inline bool is_wildcard_requested(const char *name)
> > > +{
> > > +       if (!name)
> > > +               return false;
> > > +
> > > +       return strcmp(name, CEPH_NAMESPACE_WILDCARD) =3D=3D 0;
> > > +}
> > > +
> > > +static inline bool __namespace_equals(const char *name1,
> > > +                                     wildcard_check_fn is_wildcard_r=
equested1,
> > > +                                     const char *name2,
> > > +                                     wildcard_check_fn is_wildcard_r=
equested2,
> > > +                                     size_t max_len)
> >
> > I'm puzzled by this. For all callers, is_wildcard_requested1 is always
> > is_wildcard_requested (why have it as a parameter at all?) and
> > is_wildcard_requested2 is always NULL.
> >
>
> I can see your confusion. Let me explain my troubles here. For the case o=
f
> struct ceph_mount_options, we have mount options from the left:
>
> bool namespace_equals(struct ceph_mount_options *fsopt,
> +                                   const char *namespace, size_t len);
>
> So, I can assume that I need to apply wildcard check for the left string.
>
> However, we don't have likewise method for the case of struct ceph_mds_ca=
p_auth.
> Finally, if I need to consider generalized __namespace_equals() method th=
at
> operates with pure strings, then I have no idea which string needs to be =
checked
> for wildcard. Because, it could be as left as right string. So, this is w=
hy I
> have introduced the check function typedef and __namespace_equals() recei=
ves the
> pointer on check function as for left as for right string. And it is up t=
o
> caller to make decision which string should be checked for wildcard (left=
,
> right, or both).
>
> If it looks slightly complicated/confusing, then we can consider option o=
f
> introduction a method:
>
> bool namespace_equals2(struct ceph_mds_cap_auth *auth,
> +                                   const char *namespace, size_t len);
>
> But I am not completely sure what names should be used for both checks. M=
aybe,
> do you have better idea here?

I would prefer the signature to just be:

static inline bool ceph_namespace_match(const char *pattern, const
char *target, size_t target_len) {
if (!pattern || !pattern[0] || !strcmp(pattern, CEPH_NAMESPACE_WILDCARD))
  return true;
if (strlen(pattern) !=3D target_len)
  return false;
return !strncmp(pattern, target, target_len);
}

where "target" is always the actual name (from the mdsmap or whatever).

To keep things simple, you can add a check to namespace_equals (only
called for mntopt namespace checking) to check if pattern is
CEPH_NAMESPACE_WILDCARD, and, if so, return false. (That is, using
mount option --mds_namespace=3D* is not valid for mounting.)

> If we have specialized methods, then we can assume that string that needs=
 to be
> check for wildcard is from the left. And it can simplify the
> __namespace_equals() method. So, which direction do you like more?
>
> > Additionally, for all callers, I believe name1 and name2 should never
> > be NULL? Perhaps you mean to check e.g. name1[0] =3D=3D '\0'?
> >
>
> I am not completely sure. I cannot rely on it and it is much better to be=
 ready
> for NULL pointers.
>
> > In any case, please comment each of these below conditions because
> > it's hard to follow without doing the logic for each case manually in
> > one's head.
> >
>
> Let's be on the same page at first. :) I can easily add comments here.
>
> >
> >
> > > +       size_t len1, len2;
> > > +
> > > +       if (!name1 && !name2)
> > > +               return true;
> > > +
> > > +       if (name1) {
> > > +               if (is_wildcard_requested1 && is_wildcard_requested1(=
name1))
> > > +                       return true;
> > > +               else if (!name2)
> > > +                       return false;
> > > +       }
> > > +
> > > +       if (name2) {
> > > +               if (is_wildcard_requested2 && is_wildcard_requested2(=
name2))
> > > +                       return true;
> > > +               else if (!name1)
> > > +                       return true;
> > > +       }
> > > +
> > > +       WARN_ON_ONCE(!name1 || !name2);
> > > +
> > > +       len1 =3D strnlen(name1, max_len);
> > > +       len2 =3D strnlen(name2, max_len);
> > > +
> > > +       return !(len1 !=3D len2 || strncmp(name1, name2, len1));
> > > +}
> > > +
> > >  /*
> > >   * Check if the mds namespace in ceph_mount_options matches
> > >   * the passed in namespace string. First time match (when
> > >   * ->mds_namespace is NULL) is treated specially, since
> > >   * ->mds_namespace needs to be initialized by the caller.
> > >   */
> > > -static inline int namespace_equals(struct ceph_mount_options *fsopt,
> > > -                                  const char *namespace, size_t len)
> > > +static inline bool namespace_equals(struct ceph_mount_options *fsopt=
,
> > > +                                   const char *namespace, size_t len=
)
> > >  {
> > > -       return !(fsopt->mds_namespace &&
> > > -                (strlen(fsopt->mds_namespace) !=3D len ||
> > > -                 strncmp(fsopt->mds_namespace, namespace, len)));
> > > +       return __namespace_equals(fsopt->mds_namespace, is_wildcard_r=
equested,
> > > +                                 namespace, NULL, len);
> >
> > I think we agreed that the "*" wildcard should have _no_ special
> > meaning as a glob for fsopt->mds_namespace?
>
> Frankly speaking, I don't quite follow to your point. What do you mean he=
re? :)

--mds_namespace=3D* is invalid.

vs.

And mds auth cap: mds 'allow rw fsname=3D*'  IS valid.


--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


