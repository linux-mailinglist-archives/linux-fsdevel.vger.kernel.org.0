Return-Path: <linux-fsdevel+bounces-32926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C462E9B0D0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E2F1C22862
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAF918C915;
	Fri, 25 Oct 2024 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD49YbpH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3F20C33B
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880390; cv=none; b=lAdQK6derAy2FsUTVpiHLmqg7XbKJIswldHeuNKOsllLQQ/iLpdgf0USnGyOvTkgQrZszTzSIHtNuTOYFZAIIhUuDCKsxogDbTflgZHp5pzaOfCW2SqzLhvUIGgHVNtSBm1OayRYNGKN++Abu3mHU7hwX80ax5SvfMrCbhnRtEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880390; c=relaxed/simple;
	bh=uoj7yO3LZEFNCl0qSiv5M5ZA2alM0WebsNre77RIC7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRjQZhWAuzpLeZGTPE1XHwIwtUNAygdEwqzK2UEuou8bCYVV/qjmcwFXHSt39p1WMVKTCQTqDy1bDbiajfGNcIZSYX/Qf2rrsmbZ8OX0o8dNby4XUGPjn3AcYynOfIdX8JeLMHytwiFlc9yg8XBeu30b3nHuGg3QQ4nTxfvQM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD49YbpH; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4609beb631aso15114071cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 11:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729880387; x=1730485187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9xZaCMYKVNUqsBVzIMyuTrxIwRebHw99enZCT1oYWI=;
        b=JD49YbpHfOsXFoR8Jac/YSzuH3urvaD8aQg3cilX6WVvprBWxaU7MTCRyHcdAqEYJ6
         Bpbp4j2dzFx1vlvWGeHV4M5QTQYpsHX/g+vs/MrVPwq25HW5zridievWyoTCiR2PGAXt
         AOoi4xAQQxmmHiiZZVQvMajuAK9tj34zAzU5oueOqKqZKBqX9DNAOsVPCNqkfrYRIjzg
         UT5GYwJNfjEURemDpBujiQLbS5FEMViOVIGQWb1GeMVuPjOcXNYFQsVG31p1iqemRzYx
         e3LdeE91s1rvV8cpNkqxEEVusz69lVm5fbqh9B6iFEVNT/tRuzIWDycn0FEoaRYbW86s
         dNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729880387; x=1730485187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9xZaCMYKVNUqsBVzIMyuTrxIwRebHw99enZCT1oYWI=;
        b=LvHLg4G0qzxm5/qET5vqulBeGTv00Fo9TotdVwXGQ9uTRbXcLMGOPB9OkbVjgGl0Pq
         QnO3Z0tQtRuu+ge63enIJoIQkaAQECIrHCsH/aWS04WVxzb0ANZ9mZvanOTFKoTEq3EM
         3JsQbRndZJn0kig+YI1qEtq2L9f3vOo3COZ6tHLyUzJsz6Fgy4JUPUNCfwUgo+Tvfd7B
         6l7baS+11Et7zBa6C2S/40YfBq4orYoR4dedV+o3E6NDL3n2MBeIUUr8H8H8XgOIrkCl
         8I3zjGmGZ2QG6l+DyFrhtS3wTsTRFfnU590o1Ah/gKcFwGVzUkul7dTxMCqnAyKQOG1j
         PEmg==
X-Forwarded-Encrypted: i=1; AJvYcCXXcKuzaGPgyjcAgQWx1bzAijr+4sM8XJgGj4SXKsnl9BRzO3Cs8d+smxBP0PJAGP421gRIybJyPdA9C9Xk@vger.kernel.org
X-Gm-Message-State: AOJu0YxYNrijYNd+awMmTIoin/70ukvOhfuYm/DUC2r+5/M8LhXhaJlT
	qgld0mzQ0VfTav7iXDevT3OmG8dxQg0r6XAMxmEfJdCMnS9Jbwe+XpRhIicHzminX6s9xGCtas5
	7cTA9ofq+l4Sk/UEO+EX55wqWohY=
X-Google-Smtp-Source: AGHT+IEfGIJ2iXBBf9Pv+w++7PrEPnltOwEaV/bfTM2VWPSkS6eT2bc9osH6MJlC2bnAD5IiVRQMx+Jq3JWxgUjxPNY=
X-Received: by 2002:a05:622a:48f:b0:458:4126:ec46 with SMTP id
 d75a77b69052e-4613bff1dfbmr2261411cf.17.1729880387454; Fri, 25 Oct 2024
 11:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
 <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
 <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
 <CAJnrk1aB3MehpTx6OM=J_5jgs_Xo+euAZBRGLGB+1HYX66URHQ@mail.gmail.com>
 <CAJnrk1YFPZ8=7s4m-CP02_416syO+zDLjNSBrYteUqm8ovoHSQ@mail.gmail.com>
 <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com> <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
 <CAJfpegvyD35YX27msBE+si2kmYrqBYW7SJgOW5ewUBKNzDB1Gg@mail.gmail.com>
In-Reply-To: <CAJfpegvyD35YX27msBE+si2kmYrqBYW7SJgOW5ewUBKNzDB1Gg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 25 Oct 2024 11:19:36 -0700
Message-ID: <CAJnrk1ZC9fW3y8sc2nyRUzPwwjQhnQuJzCS4+L9Chq49+Ob7Fg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 11:02=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Fri, 25 Oct 2024 at 19:36, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > That's a great point. It seems like we can just skip waiting on
> > writeback to finish for fuse folios in sync(2) altogether then. I'll
> > look into what's the best way to do this.
>
> I just tested this, and it turns out this doesn't quite work the way
> I'd expected.  I can trigger sync(2) being blocked by a suspended fuse
> server:
>
> task:kworker/u16:3   state:D stack:0     pid:172   tgid:172   ppid:2
>    flags:0x00004000
> Workqueue: writeback wb_workfn (flush-0:30)
> Call Trace:
>  __schedule+0x40b/0xad0
>  schedule+0x36/0x120
>  inode_sleep_on_writeback+0x9d/0xb0
>  wb_writeback+0x104/0x3d0
>  wb_workfn+0x325/0x490
>  process_one_work+0x1d8/0x520
>  worker_thread+0x1af/0x390
>  kthread+0xcc/0x100
>  ret_from_fork+0x2d/0x50
>  ret_from_fork_asm+0x1a/0x30
>
> task:dd              state:S stack:0     pid:1364  tgid:1364
> ppid:1336   flags:0x00000002
> Call Trace:
>  __schedule+0x40b/0xad0
>  schedule+0x36/0x120
>  request_wait_answer+0x16b/0x200
>  __fuse_simple_request+0xd6/0x290
>  fuse_flush_times+0x119/0x140
>  fuse_write_inode+0x6d/0xc0
>  __writeback_single_inode+0x36d/0x480
>  writeback_single_inode+0xa8/0x170
>  write_inode_now+0x75/0xa0
>  fuse_flush+0x85/0x1c0
>  filp_flush+0x2c/0x70
>  __x64_sys_close+0x2e/0x80
>  do_syscall_64+0x64/0x140
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> task:sync            state:D stack:0     pid:1365  tgid:1365
> ppid:1336   flags:0x00004002
> Call Trace:
>  __schedule+0x40b/0xad0
>  schedule+0x36/0x120
>  wb_wait_for_completion+0x56/0x80
>  sync_inodes_sb+0xc5/0x450
>  iterate_supers+0x69/0xd0
>  ksys_sync+0x40/0xa0
>  __do_sys_sync+0xa/0x20
>  do_syscall_64+0x64/0x140
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>

Thanks for the trace. If i'm understanding it correctly, this only
blocks temporarily until the writeback wb_workfn is rescheduled?

> Maybe I'm too paranoid about this, and in practice we can just let
> sync(2) block in any case.  But I want to understand this better

in the case of a malicious fuse server, it could block sync(2) forever
so I think this means we have to skip the wait for fuse folios
altogether.


Thanks,
Joanne
> first.
>
> Thanks,
> Miklos

