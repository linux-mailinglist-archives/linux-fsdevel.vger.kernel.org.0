Return-Path: <linux-fsdevel+bounces-32924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4735E9B0C9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A9D2817EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8668720BB5F;
	Fri, 25 Oct 2024 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="J+xuAHcW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB420BB32
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879347; cv=none; b=mpOQY6Om13c8Jdq7v+AEihCI6GFJ4tcB/HiUlYOGs2oUvsSY9tK9wHqMto5orAzyyUkb+ehDefP9B2JfU/st/bsOOexD+bVBFSghVngR8g0OQN4FXboTWm9Wk0fbbyyW2zAExOxLJsE6m+ta3v78gaMObF+L0wdWyFS9qpBef/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879347; c=relaxed/simple;
	bh=1dE2F+vZcgFlgG3ndgbG2q47TGN/UqgKp6iWNLnZIlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOaPW1CjBcF9UnH0A87y250Dl8RfJkvpkW0hU+jXYTTQJ3X/Uez6Tdr6RbX5RMc0UytJnZqWV9nbTpUttmcASDX/XuS7gFAkmpFDrbABYdEIon1RqMpyucUvZZQ9FlFl20pBNrREZO3alaoRboOxapPtIkY3veUElmtnHlHZmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=J+xuAHcW; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460ace055d8so14487321cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 11:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729879343; x=1730484143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s7jI+cVj/0Vp7vLRDMNOKjs5v00Q6EAB/w2WS63LbRg=;
        b=J+xuAHcWU9jmBcD0YrL7qrVqyURuKE7dS/BVJxqP9pbhIg4KTUkupqFTgsvGA2rDzm
         fl80W8OWORlP2LVtJTozdx2P/Xl7TbkJVgHzr9R4AKF7aF9+usjgot+MSbk/CSyaFByJ
         XQ78TRk0LGubrAZAvCkroyB2ujmKpi90Nd35A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729879343; x=1730484143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7jI+cVj/0Vp7vLRDMNOKjs5v00Q6EAB/w2WS63LbRg=;
        b=XXvJ2mZQ5Sy3AindHhGH6l/ohtaz8/W0hf26LaqKV5L8dq67Ht+uBmJFXyfxHIAZEX
         Pw+uJ18lEQf7UexNskUnaxHTVReJgloZ4QlJ1uf3y1IODisuB1BXfi3bHOP5tJI6S+nV
         Is08LswfHbB2GvImlQEEAmTfLfCWFDAuryHv6aXMGZbbSgJ7qZ/qaGYABAMcZO1/1eIC
         BwmyfE9Owf871k6olqK5dZQVKvDXyfJiXCsQn/FR6Ol1G8wxV4oz5xyPuLCqIamBz/cu
         i/aoUqkJHqJwUpWf8CP/h+rJWhIwaa3By6QCEY4EEac/NCILyTPGX7vBE+vCKHX6R5CI
         TVjg==
X-Forwarded-Encrypted: i=1; AJvYcCWhgniPUbSunh1gv2coaGqbia0CtFs4z/JjuENKcwp618qJQZhC6+hNbque0SG2t3PRXO9h7oHvzFwjXdMM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6p1CJBipmdJvJQLNrAWUooaG7UhTkdPcRgMB0rYpLU0YoCky
	6RkJoHAYkIouSvY0y8C02ACmllO723RwlbTnnLdHy0dCq6V06e42Lrp5ypihK+y4JjAcno+eAun
	6sjqm+ayrrUtIKzI/2Sfx0n7iNNKLJKwr2YbttA==
X-Google-Smtp-Source: AGHT+IHLxwf8GyD7abelP0DnXH6pF3Z/rGm9BsLy31uke0VSLgq2REqYS/YuFkUrt4oxcyV39h6yJ/5eJVeAuDBxJDk=
X-Received: by 2002:a05:622a:10e:b0:461:1c54:5bcd with SMTP id
 d75a77b69052e-4613c0046f6mr1602731cf.13.1729879343454; Fri, 25 Oct 2024
 11:02:23 -0700 (PDT)
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
In-Reply-To: <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 25 Oct 2024 20:02:12 +0200
Message-ID: <CAJfpegvyD35YX27msBE+si2kmYrqBYW7SJgOW5ewUBKNzDB1Gg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 19:36, Joanne Koong <joannelkoong@gmail.com> wrote:

> That's a great point. It seems like we can just skip waiting on
> writeback to finish for fuse folios in sync(2) altogether then. I'll
> look into what's the best way to do this.

I just tested this, and it turns out this doesn't quite work the way
I'd expected.  I can trigger sync(2) being blocked by a suspended fuse
server:

task:kworker/u16:3   state:D stack:0     pid:172   tgid:172   ppid:2
   flags:0x00004000
Workqueue: writeback wb_workfn (flush-0:30)
Call Trace:
 __schedule+0x40b/0xad0
 schedule+0x36/0x120
 inode_sleep_on_writeback+0x9d/0xb0
 wb_writeback+0x104/0x3d0
 wb_workfn+0x325/0x490
 process_one_work+0x1d8/0x520
 worker_thread+0x1af/0x390
 kthread+0xcc/0x100
 ret_from_fork+0x2d/0x50
 ret_from_fork_asm+0x1a/0x30

task:dd              state:S stack:0     pid:1364  tgid:1364
ppid:1336   flags:0x00000002
Call Trace:
 __schedule+0x40b/0xad0
 schedule+0x36/0x120
 request_wait_answer+0x16b/0x200
 __fuse_simple_request+0xd6/0x290
 fuse_flush_times+0x119/0x140
 fuse_write_inode+0x6d/0xc0
 __writeback_single_inode+0x36d/0x480
 writeback_single_inode+0xa8/0x170
 write_inode_now+0x75/0xa0
 fuse_flush+0x85/0x1c0
 filp_flush+0x2c/0x70
 __x64_sys_close+0x2e/0x80
 do_syscall_64+0x64/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

task:sync            state:D stack:0     pid:1365  tgid:1365
ppid:1336   flags:0x00004002
Call Trace:
 __schedule+0x40b/0xad0
 schedule+0x36/0x120
 wb_wait_for_completion+0x56/0x80
 sync_inodes_sb+0xc5/0x450
 iterate_supers+0x69/0xd0
 ksys_sync+0x40/0xa0
 __do_sys_sync+0xa/0x20
 do_syscall_64+0x64/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Maybe I'm too paranoid about this, and in practice we can just let
sync(2) block in any case.  But I want to understand this better
first.

Thanks,
Miklos

