Return-Path: <linux-fsdevel+bounces-2186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 655D27E3031
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9EB280D5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51922EB08;
	Mon,  6 Nov 2023 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eS+gVTHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644822D7B1
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:54:02 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25381D71
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:54:00 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-da0cfcb9f40so5294758276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699311239; x=1699916039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNKybQWPnk2Ce8tjd4ygA9PCEAcyMepwChQ21Wxo49Q=;
        b=eS+gVTHOwbaUhdRE2dcKKt55Br7rVqShiRidyy+yAC/sib5+Y6z+jJw/7zz3H/A/iD
         nZC/jSSLjzpON8CNt/CNCVYA94y7GJHmvfJ4reO1gV8DgSPqQuB7jclC9+ea7bA1dhTz
         2Wu3MXwztn6JtVVxfUMNOgf+OGd0YOcoe1SCn/FlLa9qNPeg5dT5BD052XoKfYBTevGn
         r8uVAGE1GxzFO2UveSBXaRrEQozSOi/tWLKONU1bxpCjxNAn2JsRs4KrP3nrV+mAGnpJ
         E0ITzg0NO59aaBfWzLapGQnFpcLhZa+ktVAnw8QLqh1wRqMdtIVXNet9NOds6NmUXXI+
         V0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699311239; x=1699916039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNKybQWPnk2Ce8tjd4ygA9PCEAcyMepwChQ21Wxo49Q=;
        b=Jt49UlbfshYpRkr0efQOJ7EpPUidpOlCHb3SC1FI7q14fcgn/6J8l2qujeEGpH1Ayk
         jDQpvpxw0O5YzsRNPTlyvCPYFj0bryPDs68q/Lw/ZOe0X5NUIgaiPjemUWcVQmMudzxT
         gSz3nBcugQQ9M4qemHbjfwWcw0fJ4nk/gsEdDeQg+zJYTU0q83JsgRd3GN53NwqJWpTq
         5F7bh2NDRjzdsNLLSacbXPjQJSPi0ZpJL2pM2NSkIKwxfF0KeWfZ4GMV/FILiAJlMPDr
         rKo/UqcwI/WqQn/T9/N1s89iSAm/3o8CaWr6MWwFMdU+7C+eMD0ZZIVXlkoa2OuqJXY2
         NFJA==
X-Gm-Message-State: AOJu0Yw5VeLYsu6XzFSnibTJy04ffYOWgtQYoOT+3ROL5M67/9DP32qC
	jCwTB8Vkq1ChWfP9qv7HAyvUjL9N2J1UMRg6PwtxhWVwi1onOqXmqQ==
X-Google-Smtp-Source: AGHT+IHZtlkskeIKbm+EW0uQZXkwuE4jHHoiiwhdcK0HgQeq6o4GqdUA6KYYEVVg4c/cz32HA+X7WbYUN1vLqa6WKCE=
X-Received: by 2002:a25:d186:0:b0:d9a:3bf1:35e9 with SMTP id
 i128-20020a25d186000000b00d9a3bf135e9mr30012463ybg.3.1699311239327; Mon, 06
 Nov 2023 14:53:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000cfe6f305ee84ff1f@google.com> <000000000000a8d8e7060977b741@google.com>
In-Reply-To: <000000000000a8d8e7060977b741@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Nov 2023 17:53:48 -0500
Message-ID: <CAHC9VhTFs=AHtsdzas-XXq2-Ub4V9Tbkcp4_HBspmGaARzWanw@mail.gmail.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
To: syzbot <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>
Cc: hdanton@sina.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org, 
	roberto.sassu@huawei.com, syzkaller-bugs@googlegroups.com, 
	syzkaller@googlegroups.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 3:34=E2=80=AFAM syzbot
<syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> Author: Roberto Sassu <roberto.sassu@huawei.com>
> Date:   Fri Mar 31 12:32:18 2023 +0000
>
>     reiserfs: Add security prefix to xattr name in reiserfs_security_writ=
e()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14d0b78768=
0000
> start commit:   90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kern=
e..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D16d0b78768=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12d0b78768000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D93ac5233c1382=
49e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc319bb5b1014113=
a92cf
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D113f3717680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D154985ef68000=
0
>
> Reported-by: syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com
> Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reis=
erfs_security_write()")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

Hi Roberto,

I know you were looking at this over the summer[1], did you ever find
a resolution to this?  If not, what do you think of just dropping
security xattr support on reiserfs?  Normally that wouldn't be
something we could consider, but given the likelihood that this hadn't
been working in *years* (if ever), and reiserfs is deprecated, I think
this is a viable option if there isn't an obvious fix.

[1] https://lore.kernel.org/linux-security-module/CAHC9VhTM0a7jnhxpCyonepcf=
WbnG-OJbbLpjQi68gL2GVnKSRg@mail.gmail.com/

--=20
paul-moore.com

