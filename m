Return-Path: <linux-fsdevel+bounces-73071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FDBD0B8D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 18:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A509E315B9C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 17:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BB23659E2;
	Fri,  9 Jan 2026 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqkqumFc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfKMj8lC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228323817E
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978477; cv=none; b=huzwjz3eAr5A4kxB0kiB1weP+JlWCG9kqsB75bwC1C3XI2eyZqaaZsBBj2zVGCbUSxV/XhWS5Qhh9I8276gj6QohJjE3j8mirZ7Sbx2HtyIa5Ar4znQj8IESAEMSRSuVQyiSXxSv93qW7vn86v+mtIn8uYhL0QQzSfR3yFAFg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978477; c=relaxed/simple;
	bh=huRxJQDIb3w85HB5Gg9Yl9KkH922WVM9qKseF1suB6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubNjoG8Kzb7FGy0IBoHmIdigFsM2GriMB4lfnmYAnME9OglpC9hVTOFMeuX3EPtcChCn+8CtLYC2QBz9jhWQ8gGQ7OtydSNYMsjiJa3jPB5tKG20Ra4dY0jMlbdhuCkWtWhdl5dUnbICpI1hy3m1Idz5wlb2xG3AxASEN0qzOys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqkqumFc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OfKMj8lC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767978473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNN3XKG/l9YBe/Fwe75LlMiDor3ysYrljgCh3+R6g10=;
	b=gqkqumFcJYbDngI1Muea+tf1JeJFNbpDncKQb5HezMZkh1nTwlQajYdvZfmWr6Vwj2rlAG
	dYPIB5J8hyrJPFWBfwmuVyb3jHCzXil5XId+BJwfpb+RHqyVyH/3RNbRqzNqLnQIdTjmHF
	UXCZHRYhkGSsb4XzuvhvbIejJqMiIXA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-_T9b6A3LPo-jXB0O0gIfCw-1; Fri, 09 Jan 2026 12:07:52 -0500
X-MC-Unique: _T9b6A3LPo-jXB0O0gIfCw-1
X-Mimecast-MFC-AGG-ID: _T9b6A3LPo-jXB0O0gIfCw_1767978471
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-459ae2f7d41so8310229b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 09:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767978471; x=1768583271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNN3XKG/l9YBe/Fwe75LlMiDor3ysYrljgCh3+R6g10=;
        b=OfKMj8lCqu3dtcd+X2BkBvITocXwMuB1zNB+DNT/iGyHMr1X6MjSdvsgzjOg7R53yy
         A9J/j+zkaF3Ou2K8hQNkCIYmEG4TuOM4RKw/z3wNBx11PCV2a6qEnqCYQ0WFblk26EVZ
         motn0bdOBH91jsO2fG9BJRTl+M3/GwhiffjuEI4O3CNmXgQ0a3lbEom5YIlJvRKtig0s
         o2l3JTH+yBv0/1OGQojWn96Gd1oFqVGNZaOIkEduoFuC26OATfCEwEeVy9aU/+aM5unD
         eN/2qhWqLXAcn4NeJnG5QT8ETOKrL1vNC2FeTLUzeSRsEki7tiI4qxxROGg2nZDL3DD4
         4U2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767978471; x=1768583271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iNN3XKG/l9YBe/Fwe75LlMiDor3ysYrljgCh3+R6g10=;
        b=vIAd7fCLSxC0yaZFsFlpg9H6a66d1cjhjr5QpRApSKOii5PeTSsYs3NPF1s8k3jmBH
         LvdBYd65Ty5jSDg/3J2BR+clzZZpU/kiiqk85aWOtbEWlcZRYd0gplPJSgwt1SVOrnap
         Xvaw1bqFzvtguTofDt+KMPdEr8NSS6unmO4qQLK0krroJLjYyZSqfn95QRUv5++GF0LW
         InuGC7ddsRGZdJXpAs2E6JYED0z/WxsIlp6Uk+SkMfoazsHGUAka5P/O7yFO1z9VQYVP
         k0zuRYdC7w8OLcj5h3rnlk3xBbueRzaMCsfrCH/nOGs4JPx2f/y1TeqLIA66E0xAWZh7
         1A5A==
X-Forwarded-Encrypted: i=1; AJvYcCVf2oMSqYZEkj3uzy5R2nvQnBgS+MUH1UBsRQgaNRdlh902A11AduGuOpD1id6/WbsqUtV8SBghzT1natna@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwg3gT3Gtyhj5NFXzFiq2VNUiFpK1aOO1RAiQaZ8GehM//tPN1
	cA1i4WQnYnqpg+V35oh1g6vluTdI47RNUuAJ0XCgAQC6krKxAjFsYnWpNZjLofSmCa8GtDzARZ1
	kLznpzNUwy6VNrQklXEHOI7SgMbKORE8sS/lQxH4VubKe6ZXI3NdiFOthIoFPn+VbcXAlmW3wia
	p7+mljpoBMHuM3pDxNqDuv4aqZH1uCOyiwWaEnm1UfbA==
X-Gm-Gg: AY/fxX407puPmYLIjjbS1Kw0zlRdGxqLeoggPTZclSH5JfF+4kyHTgKxrfWaVlIEnKj
	y224Vfo2QKUhPCYDotgfHElkEz+Xk/0tCm9yr8UaKXidqoHn9zYzWU9RjZmaKe8ogwKjdyt8AIa
	68ZXaj8RrlzQ1/HNyb8NmRWeVoun6iJhRFUCqpVMvcqA7V7aFE5ljLk9Jnij35s3ng7rACGQeAG
	yb7TAAlDX0Lft1RNYmj8hf2ug==
X-Received: by 2002:a05:6808:6a86:b0:450:f3e4:eb05 with SMTP id 5614622812f47-45a6bed20e1mr5451493b6e.64.1767978470947;
        Fri, 09 Jan 2026 09:07:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy8tVd1WkdpjjvpWIyqlunn7NBPgWceSzoTTOgzlKTboUDnZFrRqmnp2vkoFF5ijCVkBdwlSlGjscdQcE0Oww=
X-Received: by 2002:a05:6808:6a86:b0:450:f3e4:eb05 with SMTP id
 5614622812f47-45a6bed20e1mr5451475b6e.64.1767978470462; Fri, 09 Jan 2026
 09:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108223453.907929-2-slava@dubeyko.com>
In-Reply-To: <20260108223453.907929-2-slava@dubeyko.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Fri, 9 Jan 2026 12:07:23 -0500
X-Gm-Features: AZwV_QhZfpqGUggGSedE_pdIKziYyRT0KZtKY3AUuknXJzojB_acmYEW5xaVAMM
Message-ID: <CA+2bHPZ9WiTnJXFgoRveHchOm0j=A1qeKt+T59QJpfMkrPX0Mw@mail.gmail.com>
Subject: Re: [PATCH v4] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com, khiremat@redhat.com, Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On Thu, Jan 8, 2026 at 5:35=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The CephFS kernel client has regression starting from 6.18-rc1.
>
> sudo ./check -g quick
> FSTYP         -- ceph
> PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_DYNAM=
IC Fri
> Nov 14 11:26:14 PST 2025
> MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/scr=
atch
> /mnt/cephfs/scratch
>
> Killed
>
> Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> (2)192.168.1.213:3300 session established
> Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167616
> Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL pointer
> dereference, address: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read acc=
ess in
> kernel mode
> Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x0000) =
- not-
> present page
> Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1] SM=
P KASAN
> NOPTI
> Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 3453 =
Comm:
> xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU Stan=
dard PC
> (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1c/0x=
40
> Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90 90 =
90 90
> 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c=
0 01 84
> d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3=
 cc cc
> cc cc 31
> Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff8881536875=
c0
> EFLAGS: 00010246
> Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000000 RB=
X:
> ffff888116003200 RCX: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000063 RS=
I:
> 0000000000000000 RDI: ffff88810126c900
> Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a8 R0=
8:
> 0000000000000000 R09: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000000 R1=
1:
> 0000000000000000 R12: dffffc0000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0000 R1=
4:
> 0000000000000000 R15: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082840(00=
00)
> GS:ffff8882401a4000(0000) knlGS:0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 ES: 0=
000
> CR0: 0000000080050033
> Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000000 CR=
3:
> 0000000110ebd001 CR4: 0000000000772ef0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> ceph_mds_check_access+0x348/0x1760
> Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> __kasan_check_write+0x14/0x30
> Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/0x17=
0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> __pfx__raw_spin_lock+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xef0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0x10/=
0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> __pfx_apparmor_file_open+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> __ceph_caps_issued_mask_metric+0xd6/0x180
> Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7bf/0x=
10e0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0x10/=
0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
> Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x370
> Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/0x50=
a0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat+0x1=
0/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> __pfx_stack_trace_save+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> stack_depot_save_flags+0x28/0x8f0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+0xe/=
0x20
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/0x45=
0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> __pfx__raw_spin_lock_irqsave+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_open+0x=
10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x13d/0=
x2b0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> __pfx__raw_spin_lock+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> __check_object_size+0x453/0x600
> Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+0xe/=
0x40
> Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6/0x1=
80
> Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> __pfx_do_sys_openat2+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x108/=
0x240
> Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> __pfx___x64_sys_openat+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> __pfx___handle_mm_fault+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f/0x2=
350
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/0xd5=
0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xba/0x=
d50
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_read+0x=
11/0x20
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> count_memcg_events+0x25b/0x400
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0x38b=
/0x6a0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_read+0x=
11/0x20
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> irqentry_exit_to_user_mode+0x2e/0x2a0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x43/0x=
50
> Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x95/0=
x100
> Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf145ab
> Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00 3d =
00 00
> 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c f=
f ff ff
> b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28=
 64 48
> 2b 14 25
> Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77d316=
d0
> EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffda RB=
X:
> 0000000000000002 RCX: 000074a85bf145ab
> Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000000 RS=
I:
> 00007ffc77d32789 RDI: 00000000ffffff9c
> Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32789 R0=
8:
> 00007ffc77d31980 R09: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000000 R1=
1:
> 0000000000000246 R12: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000ffffffff R1=
4:
> 0000000000000180 R15: 0000000000000001
> Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_=
core
> pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vse=
c
> kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesni_=
intel
> rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vgasta=
te
> serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc ppd=
ev lp
> parport efi_pstore
> Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 000000000=
0000000
> ]---
> Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1c/0x=
40
> Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90 90 =
90 90
> 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c=
0 01 84
> d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3=
 cc cc
> cc cc 31
> Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff8881536875=
c0
> EFLAGS: 00010246
> Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000000 RB=
X:
> ffff888116003200 RCX: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000063 RS=
I:
> 0000000000000000 RDI: ffff88810126c900
> Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a8 R0=
8:
> 0000000000000000 R09: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000000 R1=
1:
> 0000000000000000 R12: dffffc0000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0000 R1=
4:
> 0000000000000000 R15: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082840(00=
00)
> GS:ffff8882401a4000(0000) knlGS:0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 ES: 0=
000
> CR0: 0000000080050033
> Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000000 CR=
3:
> 0000000110ebd001 CR4: 0000000000772ef0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
>
> We have issue here [1] if fs_name =3D=3D NULL:
>
> const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
>     ...
>     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
>             / fsname mismatch, try next one */
>             return 0;
>     }
>
> v2
> Patrick Donnelly suggested that: In summary, we should definitely start
> decoding `fs_name` from the MDSMap and do strict authorizations checks
> against it. Note that the `--mds_namespace` should only be used for
> selecting the file system to mount and nothing else. It's possible
> no mds_namespace is specified but the kernel will mount the only
> file system that exists which may have name "foo".
>
> v3
> The namespace_equals() logic has been generalized into
> __namespace_equals() with the goal of using it in
> ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
> The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.
>
> v4
> The __namespace_equals() now supports wildcard check.
>
> This patch reworks ceph_mdsmap_decode() and namespace_equals() with
> the goal of supporting the suggested concept. Now struct ceph_mdsmap
> contains m_fs_name field that receives copy of extracted FS name
> by ceph_extract_encoded_string(). For the case of "old" CephFS file syste=
ms,
> it is used "cephfs" name. Also, namespace_equals() method has been
> reworked with the goal of proper names comparison.
>
> [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_client.=
c#L5666
> [2] https://tracker.ceph.com/issues/73886
>
> Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/mds_client.c         | 12 ++++----
>  fs/ceph/mdsmap.c             | 22 +++++++++++----
>  fs/ceph/mdsmap.h             |  1 +
>  fs/ceph/super.h              | 54 ++++++++++++++++++++++++++++++++----
>  include/linux/ceph/ceph_fs.h |  6 ++++
>  5 files changed, 78 insertions(+), 17 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 7e4eab824dae..339736423cae 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_clie=
nt *mdsc,
>         u32 caller_uid =3D from_kuid(&init_user_ns, cred->fsuid);
>         u32 caller_gid =3D from_kgid(&init_user_ns, cred->fsgid);
>         struct ceph_client *cl =3D mdsc->fsc->client;
> -       const char *fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> +       const char *fs_name =3D mdsc->mdsmap->m_fs_name;
>         const char *spath =3D mdsc->fsc->mount_options->server_path;
>         bool gid_matched =3D false;
>         u32 gid, tlen, len;
> @@ -5679,7 +5679,9 @@ static int ceph_mds_auth_match(struct ceph_mds_clie=
nt *mdsc,
>
>         doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%s\n",
>               fs_name, auth->match.fs_name ? auth->match.fs_name : "");
> -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) =
{
> +
> +       if (!__namespace_equals(auth->match.fs_name, is_wildcard_requeste=
d,
> +                               fs_name, NULL, NAME_MAX)) {
>                 /* fsname mismatch, try next one */
>                 return 0;
>         }
> @@ -6122,7 +6124,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client =
*mdsc, struct ceph_msg *msg)
>  {
>         struct ceph_fs_client *fsc =3D mdsc->fsc;
>         struct ceph_client *cl =3D fsc->client;
> -       const char *mds_namespace =3D fsc->mount_options->mds_namespace;
>         void *p =3D msg->front.iov_base;
>         void *end =3D p + msg->front.iov_len;
>         u32 epoch;
> @@ -6157,9 +6158,8 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client =
*mdsc, struct ceph_msg *msg)
>                 namelen =3D ceph_decode_32(&info_p);
>                 ceph_decode_need(&info_p, info_end, namelen, bad);
>
> -               if (mds_namespace &&
> -                   strlen(mds_namespace) =3D=3D namelen &&
> -                   !strncmp(mds_namespace, (char *)info_p, namelen)) {
> +               if (namespace_equals(fsc->mount_options,
> +                                    (char *)info_p, namelen)) {
>                         mount_fscid =3D fscid;
>                         break;
>                 }
> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> index 2c7b151a7c95..9cadf811eb4b 100644
> --- a/fs/ceph/mdsmap.c
> +++ b/fs/ceph/mdsmap.c
> @@ -353,22 +353,31 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_=
mds_client *mdsc, void **p,
>                 __decode_and_drop_type(p, end, u8, bad_ext);
>         }
>         if (mdsmap_ev >=3D 8) {
> -               u32 fsname_len;
> +               size_t fsname_len;
> +
>                 /* enabled */
>                 ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
> +
>                 /* fs_name */
> -               ceph_decode_32_safe(p, end, fsname_len, bad_ext);
> +               m->m_fs_name =3D ceph_extract_encoded_string(p, end,
> +                                                          &fsname_len,
> +                                                          GFP_NOFS);
> +               if (IS_ERR(m->m_fs_name)) {
> +                       m->m_fs_name =3D NULL;
> +                       goto nomem;
> +               }
>
>                 /* validate fsname against mds_namespace */
> -               if (!namespace_equals(mdsc->fsc->mount_options, *p,
> +               if (!namespace_equals(mdsc->fsc->mount_options, m->m_fs_n=
ame,
>                                       fsname_len)) {
>                         pr_warn_client(cl, "fsname %*pE doesn't match mds=
_namespace %s\n",
> -                                      (int)fsname_len, (char *)*p,
> +                                      (int)fsname_len, m->m_fs_name,
>                                        mdsc->fsc->mount_options->mds_name=
space);
>                         goto bad;
>                 }
> -               /* skip fsname after validation */
> -               ceph_decode_skip_n(p, end, fsname_len, bad);
> +       } else {
> +               m->m_enabled =3D false;
> +               m->m_fs_name =3D kstrdup(CEPH_OLD_FS_NAME, GFP_NOFS);
>         }
>         /* damaged */
>         if (mdsmap_ev >=3D 9) {
> @@ -430,6 +439,7 @@ void ceph_mdsmap_destroy(struct ceph_mdsmap *m)
>                 kfree(m->m_info);
>         }
>         kfree(m->m_data_pg_pools);
> +       kfree(m->m_fs_name);
>         kfree(m);
>  }
>
> diff --git a/fs/ceph/mdsmap.h b/fs/ceph/mdsmap.h
> index 1f2171dd01bf..d48d07c3516d 100644
> --- a/fs/ceph/mdsmap.h
> +++ b/fs/ceph/mdsmap.h
> @@ -45,6 +45,7 @@ struct ceph_mdsmap {
>         bool m_enabled;
>         bool m_damaged;
>         int m_num_laggy;
> +       char *m_fs_name;
>  };
>
>  static inline struct ceph_entity_addr *
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index a1f781c46b41..fe950bd72452 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -104,18 +104,62 @@ struct ceph_mount_options {
>         struct fscrypt_dummy_policy dummy_enc_policy;
>  };
>
> +#define CEPH_NAMESPACE_WILDCARD                "*"
> +
> +typedef bool (*wildcard_check_fn)(const char *name);
> +
> +static inline bool is_wildcard_requested(const char *name)
> +{
> +       if (!name)
> +               return false;
> +
> +       return strcmp(name, CEPH_NAMESPACE_WILDCARD) =3D=3D 0;
> +}
> +
> +static inline bool __namespace_equals(const char *name1,
> +                                     wildcard_check_fn is_wildcard_reque=
sted1,
> +                                     const char *name2,
> +                                     wildcard_check_fn is_wildcard_reque=
sted2,
> +                                     size_t max_len)

I'm puzzled by this. For all callers, is_wildcard_requested1 is always
is_wildcard_requested (why have it as a parameter at all?) and
is_wildcard_requested2 is always NULL.

Additionally, for all callers, I believe name1 and name2 should never
be NULL? Perhaps you mean to check e.g. name1[0] =3D=3D '\0'?

In any case, please comment each of these below conditions because
it's hard to follow without doing the logic for each case manually in
one's head.



> +       size_t len1, len2;
> +
> +       if (!name1 && !name2)
> +               return true;
> +
> +       if (name1) {
> +               if (is_wildcard_requested1 && is_wildcard_requested1(name=
1))
> +                       return true;
> +               else if (!name2)
> +                       return false;
> +       }
> +
> +       if (name2) {
> +               if (is_wildcard_requested2 && is_wildcard_requested2(name=
2))
> +                       return true;
> +               else if (!name1)
> +                       return true;
> +       }
> +
> +       WARN_ON_ONCE(!name1 || !name2);
> +
> +       len1 =3D strnlen(name1, max_len);
> +       len2 =3D strnlen(name2, max_len);
> +
> +       return !(len1 !=3D len2 || strncmp(name1, name2, len1));
> +}
> +
>  /*
>   * Check if the mds namespace in ceph_mount_options matches
>   * the passed in namespace string. First time match (when
>   * ->mds_namespace is NULL) is treated specially, since
>   * ->mds_namespace needs to be initialized by the caller.
>   */
> -static inline int namespace_equals(struct ceph_mount_options *fsopt,
> -                                  const char *namespace, size_t len)
> +static inline bool namespace_equals(struct ceph_mount_options *fsopt,
> +                                   const char *namespace, size_t len)
>  {
> -       return !(fsopt->mds_namespace &&
> -                (strlen(fsopt->mds_namespace) !=3D len ||
> -                 strncmp(fsopt->mds_namespace, namespace, len)));
> +       return __namespace_equals(fsopt->mds_namespace, is_wildcard_reque=
sted,
> +                                 namespace, NULL, len);

I think we agreed that the "*" wildcard should have _no_ special
meaning as a glob for fsopt->mds_namespace?

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


