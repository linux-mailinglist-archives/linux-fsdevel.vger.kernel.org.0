Return-Path: <linux-fsdevel+bounces-24574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB3E9407FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 08:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6D11C20E7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 06:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E016C877;
	Tue, 30 Jul 2024 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbeJWNHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC405624
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319202; cv=none; b=MBJapUF3+hUbNPikDVsFPAclP+GVnvh3yPFnPXF9rgBxtExtc/JD83Fp8qFpmYtOs0J9XLLNYP9HtqDZGnWWszRqhGdHtYZzavIrcTkkWpT27aOru7vjeFgi3+sqW8cBcuAjBAd1NOKfoPOcyOKlT06LYNCP5Yqc83D1p+pyw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319202; c=relaxed/simple;
	bh=aeIY+biU6Js8jukWXZsjFS8ziJ3CQAkcBCN+OctaPk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxFr5GkAPyuL2YXf9v7+U+B6lKVVX7O3iOadyZHmFk3NAaKhQnuWDM09IQ3xCrwFxqUh3VHHj0V5ouPPs6OWRJ2KTw8539+k+rjv5bJNaophS5gv6sKEvv8yE0UZAfJURXK6IOMEI+YmD9+bDHqvSFkJ2yP5Mh/g+oPgMarIjS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbeJWNHs; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44c2c4ccb7aso32170941cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 23:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722319199; x=1722923999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByBVp+Fxhe1gq1XWzJ3T6rxlMZxty93/iifPUIeXE38=;
        b=NbeJWNHsmdnxRb52pOL5wsBnZ3pZP1jgXdUhXeolWa37lS85pRDRAbBQwHFh9UVqgg
         bsh/QwlgdMSVVUfHbYHP7k50VMQR8dJSV/JEoUY9RWqWwgKOJCG8jhy7BALS7EpbKfIR
         Yx8Wtc5DtJjs7KK8QgKgyXmdEZ+UyypgtSd1LeQiMprBsyRkcEbsSVK635XTsOcafmEY
         hMJXk/NZ3193nXMjJRiMIurwCzCUTiB4VmF33ILmxhddZ0tQEt7jlS+V/ZHXxaTtb9EG
         Z6Hl4ytZ1Y2hTemPsCY9qjDiB9wt3DXUBGIGAJofFki/rShlI2dn+KlU+Hsg2ZAsk5Z6
         PdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722319199; x=1722923999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByBVp+Fxhe1gq1XWzJ3T6rxlMZxty93/iifPUIeXE38=;
        b=Nnpilcv8wF6RDSfSsgum7jh4Ojin5FUz3OYhjny/3DfRAP8V59m0sxaUSWUwUj6kvR
         nMYB7gqubEBHO8XG7TQ5EbWCkghZksU14lH2zuFZ21qa7hfTOZt67PuCqhULNz1DYNWP
         LIMC+qNJuNHwQwkPyfIw10CeKGET6HG+QNL2N+pCJYCmwZSzCLMe0yyYuh0+2aN9x6Re
         7nfi9qN0yYI4D4I9Rnr3Q7MLSp2bhBxX6lAS0Ef3LHTvkwmJQOVgV8x1il1dFfCqdac1
         jpEFhsNZj/jS/b+N2hfYO4KcJsJPEQvUnHCwiJy8LJvPRYWueOlywDw0Td4QP013kcU3
         z/ew==
X-Forwarded-Encrypted: i=1; AJvYcCUOEU2f8W0sqQ/f75TgCmVTUwdBM2VscB65JX8QnZbl8QmvZuDmaAyfpSds1p8Cye62yvH3hy9SA9A7ZxOawOpX8aGmhgBGyLu4cLzIcA==
X-Gm-Message-State: AOJu0YzwzgXfdRCZ2ZJKIr67IWw3z08adX2oS6a1kcBlvZzb8UompigH
	W+jielT/1gTjOu1eIUjOCZUPbtoASbN+fXkQ/TZd4o3o9YrODBneEfWNcYE7HQ2UyRfo1h8kGHC
	PqD14w0piWUOYrNnbawQQYnBQrAM=
X-Google-Smtp-Source: AGHT+IGwhKsiu4L1c/dTUmVboQ+uMRSmZVq79ny5kkXeDFOOBXxD1u5BDVD1acDy0k0Czp+fZxuZnkBcDuWgL5dafbE=
X-Received: by 2002:a05:6214:2267:b0:6b5:dfc2:669a with SMTP id
 6a1803df08f44-6bb77f5a72amr22023936d6.2.1722319199440; Mon, 29 Jul 2024
 22:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
In-Reply-To: <20240730002348.3431931-1-joannelkoong@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 30 Jul 2024 13:59:19 +0800
Message-ID: <CALOAHbD=PY+forv4WebU06igfTdk2UpuwEpNosimWKE=Y=QmYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse: add timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 8:28=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> There are situations where fuse servers can become unresponsive or take
> too long to reply to a request. Currently there is no upper bound on
> how long a request may take, which may be frustrating to users who get
> stuck waiting for a request to complete.
>
> This patchset adds a timeout option for requests and two dynamically
> configurable fuse sysctls "default_request_timeout" and "max_request_time=
out"
> for controlling/enforcing timeout behavior system-wide.
>
> Existing fuse servers will not be affected unless they explicitly opt int=
o the
> timeout.
>
> v1: https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joanne=
lkoong@gmail.com/
> Changes from v1:
> - Add timeout for background requests
> - Handle resend race condition
> - Add sysctls
>
> Joanne Koong (2):
>   fuse: add optional kernel-enforced timeout for requests
>   fuse: add default_request_timeout and max_request_timeout sysctls
>
>  Documentation/admin-guide/sysctl/fs.rst |  17 +++
>  fs/fuse/Makefile                        |   2 +-
>  fs/fuse/dev.c                           | 187 +++++++++++++++++++++++-
>  fs/fuse/fuse_i.h                        |  30 ++++
>  fs/fuse/inode.c                         |  24 +++
>  fs/fuse/sysctl.c                        |  42 ++++++
>  6 files changed, 293 insertions(+), 9 deletions(-)
>  create mode 100644 fs/fuse/sysctl.c
>
> --
> 2.43.0
>

Hello Joanne,

Thanks for your update.

I have tested your patches using my test case, which is similar to the
hello-fuse [0] example, with an additional change as follows:

@@ -125,6 +125,8 @@ static int hello_read(const char *path, char *buf,
size_t size, off_t offset,
        } else
                size =3D 0;

+       // TO trigger timeout
+       sleep(60);
        return size;
 }

[0] https://github.com/libfuse/libfuse/blob/master/example/hello.c

However, it triggered a crash with the following setup:

1. Set FUSE timeout:
  sysctl -w fs.fuse.default_request_timeout=3D10
  sysctl -w fs.fuse.max_request_timeout =3D 20

2. Start FUSE daemon:
  ./hello /tmp/fuse

3. Read from FUSE:
  cat /tmp/fuse/hello

4. Kill the process within 10 seconds (to avoid the timeout being triggered=
).
   Then the crash will be triggered.

The crash details are as follows:

[  270.729966] CPU: 37 PID: 0 Comm: swapper/37 Kdump: loaded Not
tainted 6.10.0+ #30
[  270.731658] RIP: 0010:__run_timers+0x27e/0x360
[  270.732129] Code: 07 48 c7 43 08 00 00 00 00 48 85 c0 74 78 4d 8b
2f 4c 89 6b 08 0f 1f 44 00 00 49 8b 45 00 49 8b 55 08 48 89 02 48 85
c0 74 04 <48> 89 50 08 4d 8b 65 18 49 c7 45 08 00 00 00 00 48 b8 22 01
00 00
[  270.733815] RSP: 0018:ffff9c1c80d00ed8 EFLAGS: 00010086
[  270.734347] RAX: dead000000000122 RBX: ffff8bfb7f7613c0 RCX: 00000000000=
00001
[  270.735037] RDX: ffff9c1c80d00ef8 RSI: 0000000000000000 RDI: ffff8bfb7f7=
613e8
[  270.735723] RBP: ffff9c1c80d00f70 R08: 00000000000000b3 R09: ffff8bfb7f7=
61430
[  270.736439] R10: ffffffffb0e060c0 R11: 00000000000000b1 R12: 00000000000=
00001
[  270.737133] R13: ffff8bbd6591a0a0 R14: 00000000ffff8c00 R15: ffff9c1c80d=
00ef8
[  270.737834] FS:  0000000000000000(0000) GS:ffff8bfb7f740000(0000)
knlGS:0000000000000000
[  270.738603] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  270.739178] CR2: 00007fac75f44778 CR3: 00000001200c2006 CR4: 00000000003=
70ef0
[  270.739880] Call Trace:
[  270.740211]  <IRQ>
[  270.740512]  ? show_regs+0x69/0x80
[  270.740934]  ? die_addr+0x38/0x90
[  270.741340]  ? exc_general_protection+0x236/0x490
[  270.741874]  ? asm_exc_general_protection+0x27/0x30
[  270.742416]  ? __run_timers+0x27e/0x360
[  270.742872]  ? __run_timers+0x1b4/0x360
[  270.743318]  ? kvm_sched_clock_read+0x11/0x20
[  270.743821]  ? sched_clock_noinstr+0x9/0x10
[  270.744298]  ? sched_clock+0x10/0x30
[  270.744716]  ? sched_clock_cpu+0x10/0x190
[  270.745190]  run_timer_softirq+0x3a/0x60
[  270.745647]  handle_softirqs+0x118/0x350
[  270.746106]  irq_exit_rcu+0x60/0x80
[  270.746527]  sysvec_apic_timer_interrupt+0x7f/0x90
[  270.747067]  </IRQ>
[  270.747374]  <TASK>
[  270.747669]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  270.748255] RIP: 0010:default_idle+0xb/0x20
[  270.748724] Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d b3 51 33
00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 90
[  270.750507] RSP: 0018:ffff9c1c801e7e18 EFLAGS: 00000246
[  270.751075] RAX: 0000000000004000 RBX: 0000000000000001 RCX: 000028c5f01=
d9e8e
[  270.751811] RDX: 0000000000000001 RSI: ffffffffb112e200 RDI: ffff8bfb7f7=
7c8e0
[  270.752529] RBP: ffff9c1c801e7e20 R08: 0000003f08a215b6 R09: 00000000000=
00001
[  270.753298] R10: ffffffffb0e56080 R11: 0000000000000001 R12: 00000000000=
00001
[  270.754023] R13: ffffffffb112e200 R14: ffffffffb112e280 R15: 00000000000=
00001
[  270.754742]  ? ct_kernel_exit.constprop.0+0x79/0x90
[  270.755285]  ? arch_cpu_idle+0x9/0x10
[  270.755707]  default_enter_idle+0x22/0x2f
[  270.756175]  cpuidle_enter_state+0x88/0x430
[  270.756648]  cpuidle_enter+0x34/0x50
[  270.757075]  call_cpuidle+0x22/0x50
[  270.757492]  cpuidle_idle_call+0xd2/0x120
[  270.757960]  do_idle+0x77/0xd0
[  270.758347]  cpu_startup_entry+0x2c/0x30
[  270.758804]  start_secondary+0x117/0x140
[  270.759260]  common_startup_64+0x13e/0x141
[  270.759721]  </TASK>

Please feel free to reach out if you are unable to reproduce the issue.

--
Regards
Yafang

