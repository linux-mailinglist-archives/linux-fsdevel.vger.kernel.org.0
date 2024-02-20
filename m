Return-Path: <linux-fsdevel+bounces-12178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BED85C5C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 21:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42371F21BAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 20:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FEE14AD26;
	Tue, 20 Feb 2024 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acwU73RU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5549A612D7;
	Tue, 20 Feb 2024 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460890; cv=none; b=lxGQIc1ID02t1iH+teosut+34bR+c7rICcOa5fmN3RR+YQR1++n0tW603AISYP0AbhgoEGUtw/nJ96fiwt6Xeq1ZEULPTXdWX7jflJ+4acGJ4R2mFGG/ukAijRECu+hGcU5OR4I9+nYCcnhsd4Qq78kNYI7yMv2r6D9zdeC+/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460890; c=relaxed/simple;
	bh=A1MvHpPolzHclZTFrT7Mz0QU8ANDs5FPUBzDEWHT0CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGnl/TyN9gpAXYW2vp0rZ86AozKG10cT2GyV9ZBpAn2XxC9nDjqQiB8KV0Dul8RVZhcoZtQ8UTISWbOkJafbwGU7fSIVFh6LPUJJw8QIedzOspUC8RV1gYenPX8qwyJY+0UmhPGm8HrYRQ213SFmdMmmerBsqK4cH9+3aBrvaWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acwU73RU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d2533089f6so954051fa.1;
        Tue, 20 Feb 2024 12:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708460886; x=1709065686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQVaoZMHrUwH8D7MZfopuI7iW1uozR+J2Oa9ClCShe4=;
        b=acwU73RU2TUu6yoVUaysVqt/HEvLikMrryyudYkZ165moWWQ2POTNuPF2oZS9Jura0
         mhSNyy2v3SS5yshshJarmVxzYx82nzP2ZjGpDx1BqWPNzerQJUwdnidmiYkApVvrdTbv
         Gj9b99Irm94DpRfsM9ZzaG+80OP4wYKeKo4oPDjOQxfQl6ojOB0wZQY2sAhr0BV7he97
         4wdPJLg3tedU61aKSP6eHIfF3uc8vOp+Yuryje4u7U6DoFxI9leacM5WXf8vB5xuU9kX
         IuAdNQAsumUVAK3I7ygeQh/3WlWSlvrG1BwxYm8cDOrz6yg6YDsW/OwmtNpbEwPDtGQE
         RD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460886; x=1709065686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQVaoZMHrUwH8D7MZfopuI7iW1uozR+J2Oa9ClCShe4=;
        b=EgW1OaNZfxHYSQbFhnaarzZdYah76tfdCIEIMWgrf+/NQ4sOEcnWek3k5WFgIG5ldY
         wSjkIhryjDpBWDM8iafm0SnDg7cslFPmo5n0tgc+AawYoqgcnC/fdHqmqgk0fQgjR4dQ
         JnD8/N5N3rAnpO2v1n5hE47WfjvNSWes295HNa8VdOeiAglj/aXICWTibzdJKhm7XRVr
         Rt9x5g/2Tln13akNZfGYX/gVkC8wICGBZY+To18PUcmNMqfRR5CDQF+2dzanSRBn8dPP
         GjEueThWUZohPmOB+ROaDv1f3xiINAJ4roOOJt2YJvNO4VEAxG/XVEFB3tTbH5/7CF19
         liCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkFu15UVJauyptr/ffcgcp1eSVVOKVvxSFosisxzqNDd9SwKarY4MXVrSv9yvPUfpTAUIu2HsXgmTtV0Zgos/iumc8LQtMVBNqsTEOBZ+WBH+0FFwiso5aB7E5qZ3/jLF7t8jT0aQCdV4=
X-Gm-Message-State: AOJu0Yx2E+Zg/FLu+Y0ukPIojcIGrACv7Cz/A9CLEHXNviXP7osv9rOl
	lo9sF1Ym4HpQBCAM7dpRSe8GOW9A3aGM73iUujyTLsMg/nkfF+dXw8EEjVrAvOi5zrn3mfTDMF/
	R7DR6GfOVfpoCs7reta+rl7HFB0SkhHby/nMS1A==
X-Google-Smtp-Source: AGHT+IH1KNc70gSIB80eTdvh4FlG9U0Ct/lHcE6W2pXVGDaJoDOX7jbiPwHtYgk06K6S27wWu0OFtDm6M28zG3leIL4=
X-Received: by 2002:a05:651c:232:b0:2d2:4783:872a with SMTP id
 z18-20020a05651c023200b002d24783872amr2007251ljn.29.1708460886148; Tue, 20
 Feb 2024 12:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5ms2Hn1cmYEmmbGXTpCo2DY8FY8mfMewcvzEe2S-vjV0pQ@mail.gmail.com>
 <ZdT-SOlTdrDoFqnX@casper.infradead.org>
In-Reply-To: <ZdT-SOlTdrDoFqnX@casper.infradead.org>
From: Steve French <smfrench@gmail.com>
Date: Tue, 20 Feb 2024 14:27:54 -0600
Message-ID: <CAH2r5msF5n+5OCQ=JzYL-FVQEeCax-JutaUVcni5Bkcd8z26tw@mail.gmail.com>
Subject: Re: folio oops
To: Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 1:32=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Feb 20, 2024 at 12:09:17PM -0600, Steve French wrote:
> > FYI - I hit this oops in xfstests (around generic/048) today.  This is
> > with 6.8-rc5
> >
> > Any thoughts?
>
> Umm, this isn't an oops, it's just a backtrace.  Do you have anything
> that was printed before the backtrace?  I'd expect to see something
> complaining about sleeping for too long, since this is where we wait for
> writeback to finish ... the bug is probably something not calling
> folio_end_writeback() when it should.

That makes more sense - looking at the saved kernel log I do see
evidence that writes could have timed out (in this case due to
reconnects to a Windows server repeatedly failing)

2024-02-20T12:05:52.416215-06:00 smfrench-ThinkPad-P52 kernel:
[125520.747835] CIFS: VFS: No writable handle in writepages rc=3D-9
2024-02-20T12:05:55.743942-06:00 smfrench-ThinkPad-P52 kernel:
[125524.077358] CIFS: VFS: \\ has not responded in 180 seconds.
Reconnecting...
2024-02-20T12:05:57.024052-06:00 smfrench-ThinkPad-P52 kernel:
[125524.077367] CIFS: VFS: unable to get chan index for server: 0x2bf
2024-02-20T12:05:57.024077-06:00 smfrench-ThinkPad-P52 kernel:
[125525.357444] CIFS: VFS: \\ has not responded in 180 seconds.
Reconnecting...
2024-02-20T12:05:57.024080-06:00 smfrench-ThinkPad-P52 kernel:
[125525.357469] CIFS: VFS: unable to get chan index for server: 0x2c0

And interestingly I also see some "invalid argument" errors later
which I have not seen for session setup before.

2024-02-20T12:06:17.048083-06:00 smfrench-ThinkPad-P52 kernel:
[125545.382363] CIFS: VFS: \\ Send error in SessSetup =3D -22




> > 125545.834971] task:xfs_io          state:D stack:0     pid:1697299
> > tgid:1697299 ppid:1692194 flags:0x00004002
> > [125545.834987] Call Trace:
> > [125545.834992]  <TASK>
> > [125545.835002]  __schedule+0x2cb/0x760
> > [125545.835022]  schedule+0x33/0x110
> > [125545.835031]  io_schedule+0x46/0x80
> > [125545.835039]  folio_wait_bit_common+0x136/0x330
> > [125545.835052]  ? __pfx_wake_page_function+0x10/0x10
> > [125545.835069]  folio_wait_bit+0x18/0x30
> > [125545.835076]  folio_wait_writeback+0x2b/0xa0
> > [125545.835087]  __filemap_fdatawait_range+0x93/0x110
> > [125545.835104]  filemap_write_and_wait_range+0x94/0xc0
> > [125545.835120]  cifs_flush+0x9a/0x140 [cifs]
> > [125545.835315]  filp_flush+0x35/0x90
> > [125545.835329]  filp_close+0x14/0x30
> > [125545.835341]  put_files_struct+0x85/0xf0
> > [125545.835354]  exit_files+0x47/0x60
> > [125545.835365]  do_exit+0x295/0x530
> > [125545.835377]  ? wake_up_state+0x10/0x20
> > [125545.835391]  do_group_exit+0x35/0x90
> > [125545.835403]  __x64_sys_exit_group+0x18/0x20
> > [125545.835414]  do_syscall_64+0x74/0x140
> > [125545.835424]  ? handle_mm_fault+0xad/0x380
> > [125545.835437]  ? do_user_addr_fault+0x338/0x6b0
> > [125545.835446]  ? irqentry_exit_to_user_mode+0x6b/0x1a0
> > [125545.835458]  ? irqentry_exit+0x43/0x50
> > [125545.835467]  ? exc_page_fault+0x94/0x1b0
> > [125545.835478]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [125545.835490] RIP: 0033:0x7f9b67eea36d
> > [125545.835549] RSP: 002b:00007ffde6442cd8 EFLAGS: 00000202 ORIG_RAX:
> > 00000000000000e7
> > [125545.835560] RAX: ffffffffffffffda RBX: 00007f9b68000188 RCX:
> > 00007f9b67eea36d
> > [125545.835566] RDX: 00000000000000e7 RSI: ffffffffffffff28 RDI:
> > 0000000000000000
> > [125545.835572] RBP: 0000000000000001 R08: 0000000000000000 R09:
> > 0000000000000000
> > [125545.835576] R10: 00005b88e60ec720 R11: 0000000000000202 R12:
> > 0000000000000000
> > [125545.835582] R13: 0000000000000000 R14: 00007f9b67ffe860 R15:
> > 00007f9b680001a0
> > [125545.835597]  </TASK>
> >
> >
> > --
> > Thanks,
> >
> > Steve
> >



--=20
Thanks,

Steve

