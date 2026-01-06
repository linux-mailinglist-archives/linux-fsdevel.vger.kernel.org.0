Return-Path: <linux-fsdevel+bounces-72414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0D0CF66DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 03:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB34730133BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 02:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047E2233149;
	Tue,  6 Jan 2026 02:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3wCmmk6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E411223DC1
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665657; cv=none; b=IOc9Ztw1KkQxHfiHzEr/edKqu9LQc52zJ0H6w8JN5SmhsdXkOfQaSifFxBSx94uCT8fqFS9ZNBS2rBpU9SI9ORMgdVHqRJ98kHBZknkkRkWIujLRlvO3laN9xn/pbxC9pv+jt9f5gaVwObhnZVRhJ64XsLwgZWesohKdKDNtOgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665657; c=relaxed/simple;
	bh=btl/+HTfJerwC1h2Qpb42qtrInFxSAmJddHg6fmSdUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSEJ4SC4ZrPRLm3liDufQodQKZNET0fxfmFzYKeaBeQ200kV4XNkWXc1YheeaFYCaba+DUvWKKFMgl/+qSC9unUePuoMiAqQPhE//KUvhBX3trt5nQqjThGTfQTKba4bh4QPz7wtf8zL6CwWa0LdCFYaLxD9QSYWhKFaeacjugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3wCmmk6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b728a43e410so92442366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 18:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767665653; x=1768270453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D06lB7GDZFakLbyZTuVCy3/4xhawoEibMQiHD5lwYB0=;
        b=m3wCmmk6dP0LdSbM3LUa4Kck8jhJ3Moz7mGdqYFSHfubPPF5L6IkJqvoFhUqfz9bF2
         KXRdUW8uryTxsxPEc9dFswBgevrRozW9rzTSJ76SDPUBLQreNp9/y3OL70O2eVom9ErZ
         qWf5ybCHRwVu3XYIOMWZ7Qbv6DsOCgJ+WtQ49pgyytokQQFcKdwQB09vlSR6UQ44U7Co
         ACXrMmLEx1k5SbfltD2gPg7IVJtVS5UFF+JBnCQY+L8zMoNLZM6aNFEuMYjbhEt55SKU
         OFl68NL9L+etEVHLYz0XgsZwFoMrm//zP87V6IubujmNfmVn8Wz0DWFhfOhbUk5WFe/X
         ICvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767665653; x=1768270453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D06lB7GDZFakLbyZTuVCy3/4xhawoEibMQiHD5lwYB0=;
        b=nTU5QxQnDi18drMVnX4Qn43kUBCh7hdr0YjyYv4MyGDOfNwUGWnXD+2KXG7DhrGJC7
         BpPMLOIyKBeqhanqh4vW/QhMu9Ly4/Gnrjr/HxgMUfEXV9Vm1sM2/YEyb9C+IrM+1Ty7
         Krd9oL46MjcYJ9HvnvVmpqizLorNvMLxywDUUwoZZcIhOfAIyfA7DYiivGRALI1YEUy3
         FCNzQ+0/u3TCaEX6jlDhwI+L87t5AmKvtbcaWVksnWTi2UuGGmVuqafbPIzcofOfLW+y
         Oiq2tMFUTfzn/WsorKPnPQHCgcILWHK6Se37q6HJgGvW0v0ZYL2R8wBKn778JhicRX4B
         jQcQ==
X-Gm-Message-State: AOJu0YyV3LPA43r4qa9E/N5H6iU5i1Q3xuIEIVLHXvm4QY53CB67PMKQ
	sTYUkTfXTPbRw9Mjv91KWrAXd97FLvo7coskQnWIlAa8Nf5Ma8TWoIPEu1RrK6FQxXRf53DFKyU
	TJLZe2nIYJv5YolYKZjQBOVIIdTdgiY5uV/TWBGh47g==
X-Gm-Gg: AY/fxX5J7uhZMaMQmgKn+Mce9Nsd3nMo8VS7jCUVg99BwqadoARS90DTcBX0PlGv5IH
	R1KcINrRjsb/U3FRMgvSEN1NtdVMcAdMTFEcVStTuZv12HvsO3xy+2uz5u1Mb6qrVNqik7Y+uTq
	vdU2O0dj50wKIesba0Ze91BIg1N9VnCaTgJwrPZziH3ilJZdhCgMtGuybd4Kq3zNYQ0KNtjs6TN
	Muo5VsbOw9y5azjNxjH4y70IoArESdgRoIfdk9SyN1PrvXnGs2pQZpMqykp3Zuv+vy6FxgL6aEi
	r6wcOjw=
X-Google-Smtp-Source: AGHT+IHt9pqbgMHHG0qo6vSvt+59/FijY04gaQUoQTXIFvk1cZkOy1ZtvcdRYH2kpsj47laKl+Z48j0btwOvIz3wpvM=
X-Received: by 2002:a17:906:ef0b:b0:b4a:d0cf:873f with SMTP id
 a640c23a62f3a-b8426a50a99mr169160066b.2.1767665652467; Mon, 05 Jan 2026
 18:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGmFzSc=YbHdaFbGQOrs_E4-MBXrM7QwXZ0DuKAGW1Ers2q=Rg@mail.gmail.com>
 <CAJnrk1ZOYnXpY0qf3yU41gQUHjyHOdBhAdyRPt_kaBmhvjr_9g@mail.gmail.com>
 <CAGmFzSdQ2Js5xUjb-s2vQkNB75Y5poOr_kTf4_8wqzeSgA6mJg@mail.gmail.com>
 <CAJnrk1Z=kqQc5SM2Z1ObgEMeCttT8J83LjeX19Ysc1jCjvA79A@mail.gmail.com>
 <CAGmFzSe3P3=daObU5tOWxzTQ3jgo_-XTsGE3UN5Z19djhYwhfg@mail.gmail.com>
 <CAJnrk1a1aT77GugkAVtUixypPpAwx7vUd92cMd3XWHgmHXjYCA@mail.gmail.com>
 <CAGmFzSc3hidao0aSD9nDT50J4a9ZY053MdEPRF-x_Xfkb730-g@mail.gmail.com>
 <CAGmFzSdmGLSC59vUjd=3d3bng+SQSHL=DMUQ+fpzAM2S12DcuA@mail.gmail.com> <CAJnrk1Z_1LO0uS=J5uca2tXUp_4Zc+O5D6XN-hdGEJFxTKyvyw@mail.gmail.com>
In-Reply-To: <CAJnrk1Z_1LO0uS=J5uca2tXUp_4Zc+O5D6XN-hdGEJFxTKyvyw@mail.gmail.com>
From: Gang He <dchg2000@gmail.com>
Date: Tue, 6 Jan 2026 10:14:00 +0800
X-Gm-Features: AQt7F2o8kvRaj2DHSVKIim33zgLRiQeGJv4NFkJlDaQxPj4J2s0qtXbw9-YZYvU
Message-ID: <CAGmFzSci7dC5Fq77umzrCQVaKqDPiJ4NgMGTycjvMCnPXv6-zQ@mail.gmail.com>
Subject: Re: feedback: fuse/io-uring: add kernel-managed buffer rings and zero-copy
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joanne,

Yes, I enabled /sys/module/fuse/parameters/enable_uring before doing
the testing.
I verified my libfuse include/fuse_kernel.h, the code looks like,
struct fuse_uring_cmd_req {
    uint64_t flags;

    /* entry identifier for commits */
    uint64_t commit_id;

    /* queue the command is for (queue index) */
    uint16_t qid;

    union {
        struct {
            uint16_t flags;
            uint16_t queue_depth;
        } init;
    };

    uint8_t padding[2];
};

But, for my kernel source code fs/fuse/dev_uring.c:1522:21, the
detailed code lines are as follows,
1518 static int fuse_uring_register(struct io_uring_cmd *cmd,
1519                    unsigned int issue_flags, struct fuse_conn *fc)
1520 {
1521     const struct fuse_uring_cmd_req *cmd_req =3D io_uring_sqe_cmd(cmd-=
>sqe);
1522     bool use_bufring =3D READ_ONCE(cmd_req->init.use_bufring);    <<=
=3D=3D here
1523     bool zero_copy =3D READ_ONCE(cmd_req->init.zero_copy);
1524     struct fuse_ring *ring =3D smp_load_acquire(&fc->ring);
1525     struct fuse_ring_queue *queue;

The problem looks like the user space side does not pass the right
data structure to the kernel space side.

Thanks
Gang

Joanne Koong <joannelkoong@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=BA=8C 03:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Jan 3, 2026 at 6:28=E2=80=AFPM Gang He <dchg2000@gmail.com> wrote=
:
> >
> > Hi Joanne,
> >
> > I also saw some kernel messages as below when the ls command was hanged=
.
> >
> > [  316.972329] ------------[ cut here ]------------
> > [  316.972332] UBSAN: invalid-load in fs/fuse/dev_uring.c:1522:21
> > [  316.972338] load of value 3 is not a valid value for type '_Bool'
> > [  316.972344] CPU: 0 UID: 0 PID: 2499 Comm: fuse-ring-0 Not tainted
> > 6.19.0-rc2+ #1 PREEMPT(voluntary)
> > [  316.972346] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.13.0-1kylin1 04/01/2014
> > [  316.972349] Call Trace:
> > [  316.972350]  <TASK>
> > [  316.972356]  dump_stack_lvl+0x5f/0x90
> > [  316.972360]  dump_stack+0x10/0x18
> > [  316.972362]  ubsan_epilogue+0x9/0x39
> > [  316.972364]  __ubsan_handle_load_invalid_value.cold+0x44/0x49
> > [  316.972366]  fuse_uring_cmd.cold+0x72/0x2d9
> > [  316.972369]  ? __memcg_slab_post_alloc_hook+0x1af/0x3b0
> > [  316.972371]  io_uring_cmd+0xb7/0x1a0
> > [  316.972375]  __io_issue_sqe+0x43/0x1b0
> > [  316.972377]  io_issue_sqe+0x3f/0x5b0
> > [  316.972379]  ? io_cache_alloc_new+0x3d/0x60
> > [  316.972381]  io_submit_sqes+0x25e/0x680
> > [  316.972382]  ? __io_uring_add_tctx_node+0x4d/0x170
> > [  316.972385]  __do_sys_io_uring_enter+0x42f/0x790
> > [  316.972387]  ? __pfx_futex_wake_mark+0x10/0x10
> > [  316.972390]  __x64_sys_io_uring_enter+0x22/0x40
> > [  316.972391]  x64_sys_call+0x1c27/0x2360
> > [  316.972394]  do_syscall_64+0x81/0x500
> > [  316.972397]  ? do_futex+0x105/0x260
> > [  316.972398]  ? __x64_sys_futex+0x127/0x200
> > [  316.972400]  ? restore_fpregs_from_fpstate+0x3d/0xc0
> > [  316.972403]  ? switch_fpu_return+0x5c/0xf0
> > [  316.972404]  ? do_syscall_64+0x272/0x500
> > [  316.972406]  ? switch_fpu_return+0x5c/0xf0
> > [  316.972408]  ? do_syscall_64+0x272/0x500
> > [  316.972410]  ? tick_program_event+0x43/0xa0
> > [  316.972412]  ? hrtimer_interrupt+0x126/0x250
> > [  316.972415]  ? irqentry_exit+0xb2/0x600
> > [  316.972417]  ? clear_bhb_loop+0x50/0xa0
> > [  316.972419]  ? clear_bhb_loop+0x50/0xa0
> > [  316.972420]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  316.972422] RIP: 0033:0x7b76ec4e9a13
> > [  316.972426] Code: 0f b6 c0 48 8b 79 20 8b 3f 83 e7 01 44 0f 45 d0
> > 41 83 ca 01 8b b9 cc 00 00 00 45 31 c0 41 b9 08 00 00 00 b8 aa 01 00
> > 00 0f 05 <c3> 0f 1f 40 00 89 30 eb 97 0f 1f 40 00 41 f6 c2 04 74 3a 44
> > 89 d0
> > [  316.972427] RSP: 002b:00007b76eabfdd38 EFLAGS: 00000246 ORIG_RAX:
> > 00000000000001aa
> > [  316.972432] RAX: ffffffffffffffda RBX: 00007b76e4000c80 RCX: 00007b7=
6ec4e9a13
> > [  316.972434] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000=
000000006
> > [  316.972434] RBP: 00007b76e4000c00 R08: 0000000000000000 R09: 0000000=
000000008
> > [  316.972435] R10: 0000000000000001 R11: 0000000000000246 R12: 0000638=
df32ac990
> > [  316.972436] R13: 00007b76e4103010 R14: 00007b76e41037b0 R15: 0000000=
000000006
> > [  316.972439]  </TASK>
> > [  316.972440] ---[ end trace ]---
> > [  347.022626] ------------[ cut here ]------------
> > [  347.022631] WARNING: fs/fuse/dev_uring.c:1290 at
> > fuse_uring_headers_prep+0x76/0x90, CPU#1: fuse-ring-1/2500
> > [  347.022636] Modules linked in: snd_seq_dummy snd_hrtimer qrtr
> > binfmt_misc intel_rapl_msr intel_rapl_common intel_pmc_core
> > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry
> > intel_vsec kvm_intel snd_hda_codec_generic snd_hda_intel kvm
> > snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi
> > snd_hwdep snd_pcm irqbypass ghash_clmulni_intel aesni_intel rapl
> > snd_seq_midi snd_seq_midi_event snd_rawmidi i2c_i801 snd_seq i2c_smbus
> > i2c_mux qxl snd_seq_device snd_timer drm_ttm_helper lpc_ich snd ttm
> > drm_exec soundcore joydev input_leds mac_hid sch_fq_codel msr
> > parport_pc ppdev lp parport efi_pstore nfnetlink vsock_loopback
> > vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock
> > vmw_vmci dmi_sysfs qemu_fw_cfg autofs4 hid_generic usbhid psmouse hid
> > ahci serio_raw virtio_rng libahci
> > [  347.022683] CPU: 1 UID: 0 PID: 2500 Comm: fuse-ring-1 Not tainted
> > 6.19.0-rc2+ #1 PREEMPT(voluntary)
> > [  347.022685] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.13.0-1kylin1 04/01/2014
> > [  347.022687] RIP: 0010:fuse_uring_headers_prep+0x76/0x90
> > [  347.022689] Code: c0 75 27 c9 31 d2 31 c9 31 f6 31 ff 45 31 c0 45
> > 31 c9 e9 bd f7 b9 00 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 c3 cc
> > cc cc cc <0f> 0b c9 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 e9 94 f7
> > b9 00
> > [  347.022690] RSP: 0018:ffffcc6289717a30 EFLAGS: 00010282
> > [  347.022693] RAX: 00000000ffffffea RBX: ffff8aae00e76280 RCX: 0000000=
000000000
> > [  347.022694] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000=
000000000
> > [  347.022695] RBP: ffffcc6289717a30 R08: 0000000000000000 R09: 0000000=
000000000
> > [  347.022696] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000000
> > [  347.022697] R13: ffff8aae020ecc00 R14: ffff8aae020ecc00 R15: ffff8aa=
e55de1f00
> > [  347.022699] FS:  00007b76ea3fd6c0(0000) GS:ffff8aaee5b0d000(0000)
> > knlGS:0000000000000000
> > [  347.022700] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  347.022701] CR2: 00007ffcaeaadef8 CR3: 000000010433a006 CR4: 0000000=
000372ef0
> > [  347.022706] Call Trace:
> > [  347.022707]  <TASK>
> > [  347.022710]  fuse_uring_send_in_task+0xce/0x190
> > [  347.022713]  io_handle_tw_list+0x13a/0x140
> > [  347.022715]  tctx_task_work_run+0x40/0xb0
> > [  347.022718]  tctx_task_work+0x37/0x70
> > [  347.022720]  task_work_run+0x60/0xa0
> > [  347.022722]  io_run_task_work+0x4d/0x160
> > [  347.022725]  io_cqring_wait+0x412/0x740
> > [  347.022727]  ? __pfx_io_wake_function+0x10/0x10
> > [  347.022731]  __do_sys_io_uring_enter+0x514/0x790
> > [  347.022733]  ? __x64_sys_futex+0x127/0x200
> > [  347.022736]  __x64_sys_io_uring_enter+0x22/0x40
> > [  347.022738]  x64_sys_call+0x1c27/0x2360
> > [  347.022740]  do_syscall_64+0x81/0x500
> > [  347.022744]  ? __do_sys_io_uring_register+0x305/0x980
> > [  347.022747]  ? __x64_sys_io_uring_register+0x1b/0x30
> > [  347.022749]  ? x64_sys_call+0x171/0x2360
> > [  347.022752]  ? do_syscall_64+0xbf/0x500
> > [  347.022754]  ? __x64_sys_io_uring_register+0x1b/0x30
> > [  347.022756]  ? x64_sys_call+0x171/0x2360
> > [  347.022758]  ? do_syscall_64+0xbf/0x500
> > [  347.022761]  ? handle_mm_fault+0x1e8/0x2f0
> > [  347.022764]  ? do_user_addr_fault+0x2f8/0x830
> > [  347.022767]  ? irqentry_exit+0xb2/0x600
> > [  347.022770]  ? clear_bhb_loop+0x50/0xa0
> > [  347.022772]  ? clear_bhb_loop+0x50/0xa0
> > [  347.022773]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  347.022775] RIP: 0033:0x7b76ec4e9a13
> > [  347.022777] Code: 0f b6 c0 48 8b 79 20 8b 3f 83 e7 01 44 0f 45 d0
> > 41 83 ca 01 8b b9 cc 00 00 00 45 31 c0 41 b9 08 00 00 00 b8 aa 01 00
> > 00 0f 05 <c3> 0f 1f 40 00 89 30 eb 97 0f 1f 40 00 41 f6 c2 04 74 3a 44
> > 89 d0
> > [  347.022779] RSP: 002b:00007b76ea3fcd38 EFLAGS: 00000246 ORIG_RAX:
> > 00000000000001aa
> > [  347.022781] RAX: ffffffffffffffda RBX: 00007b76e4000c80 RCX: 00007b7=
6ec4e9a13
> > [  347.022782] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000=
000000008
> > [  347.022783] RBP: 00007b76e4000c00 R08: 0000000000000000 R09: 0000000=
000000008
> > [  347.022784] R10: 0000000000000001 R11: 0000000000000246 R12: 0000638=
df32ac990
> > [  347.022785] R13: 00007b76e41037a8 R14: 00007b76e4103f48 R15: 0000000=
000000008
> > [  347.022788]  </TASK>
> > [  347.022789] ---[ end trace 0000000000000000 ]---
> >
> > Thanks
> > Gang
> >
> > Gang He <dchg2000@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=884=E6=97=A5=
=E5=91=A8=E6=97=A5 10:15=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hi Joanne,
> > >
> > > I used the kernel (v6.19-rc2/9448598b22c) with your 25 patches, there
> > > are few different patches between two kernels.
> > > I used your command "./passthrough_hp /mnt/xfs/ /mnt/fusemnt/
> > > --nopassthrough -o io_uring -o io_uring_bufring -o io_uring_zero_copy
> > > -o io_uring_q_depth=3D8" to mount the fuse file system.
> > > but the ls command was still hanged with the below stack,
>
> Hi Gang,
>
> I applied the 25 patches on top of commit 9448598b22c in the linux
> tree (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git)
> but I'm not seeing the hang you're describing (or any hangs with cat,
> echo >,  or the fio commands).
>
> Just to double-check, you have
> /sys/module/fuse/parameters/enable_uring set to "Y" on your system,
> correct?
>
> In this line in your stack trace above:
> > [  316.972332] UBSAN: invalid-load in fs/fuse/dev_uring.c:1522:21
>
> does that line correspond to "unsigned int init_flags =3D
> READ_ONCE(cmd_req->init.flags);" for you? That's what it corresponds
> to for me with the patches applied to that 9448598b22c commit you
> listed. If so, that means something is awry in the setup - could you
> verify that your libfuse include/fuse_kernel.h file has
>
>             struct {
>                     uint16_t flags;
>                     uint16_t queue_depth;
>             } init;
>
> defined in "struct fuse_uring_cmd_req"?
>
> Let me know if it'd be helpful to jump on a google video call to
> figure this out.
>
> Thanks,
> Joanne
>
> > > root@ub-2504:/zzz/test/libfuse/build/example# cat /proc/2515/stack
> > > [<0>] request_wait_answer+0x166/0x260
> > > [<0>] __fuse_simple_request+0x11f/0x320
> > > [<0>] fuse_do_getattr+0x101/0x240
> > > [<0>] fuse_update_get_attr+0x19a/0x1c0
> > > [<0>] fuse_getattr+0x96/0xe0
> > > [<0>] vfs_getattr_nosec+0xc4/0x110
> > > [<0>] vfs_statx+0xa7/0x160
> > > [<0>] do_statx+0x63/0xb0
> > > [<0>] __x64_sys_statx+0xad/0x100
> > > [<0>] x64_sys_call+0x10c9/0x2360
> > > [<0>] do_syscall_64+0x81/0x500
> > > [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > > Thanks
> > > Gang

