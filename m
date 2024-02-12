Return-Path: <linux-fsdevel+bounces-11101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CC58510F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 11:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23BF41F22229
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62019208DD;
	Mon, 12 Feb 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjbN9oPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1138F84
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733963; cv=none; b=j98yAoiE5ELlprfNXXSIeo2to1NQtpzWqxNap6kUYTZoY5xfnZi5XCpytW7Jv1evU2Cu6kWfLFIGAIDXkZYSCxAD6c5mIL77be4hPiYktAbzkO9iYsWSSOKigRe/IhewLVWeWNPFoThVeYGtai41HTbpj6vEKnY9xYOtVsuPC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733963; c=relaxed/simple;
	bh=UkHd/GmH09GQBsYpAgBPGTOK55u0Pd+g0aye5wazMcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U33fO8Ioeu07ZibLgWAWQWSjqJ6RYbEif6Y4V5G2kqUIY7iZLgks8ja+UsyJoVVr77OSxf1VKxbDMhmSzLMczs485SGFbXb7XOk965rJop5AKKXuzb/+WLyt1wFO+sFPhbkywuK9slhGR2WH70nBQwsPVevYkvs1asgdKrvmqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjbN9oPP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d5ce88b51cso754155ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 02:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707733961; x=1708338761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVlNJZ/Jdf69a5rljlmZldBDpMdBRinviHNt5piQvy0=;
        b=RjbN9oPPOAYDAuYRdE82ouuA3p7vuMFvyRPhO/zSZBIQVP3MrLHZR23e1d5mHHw1Si
         1zHWWSrX6QZKmb/m0uw3dwc91WWOZneKXyJpRAxWE7Aq1Ny8jXMyjIUD+IuXcVCsDLeX
         +NElBjKgZS7WYtyAZISqAiBmbjvKk3Dt+x+EX4BfgMquEQQSri26kQo/GP4EqZDGKd49
         Nzp2OBgM2vuzjfS9vmNHxeUtm+1cLIMfiT/UichN+P+0BXcUQkHsNMRihl8ICowcSLTM
         akk28dej9VRDS0YXnVt1cDYhue2sile7+WZgU4o7SfJjQO+Cyy6ZeNa5ZVKNCNxyYVJF
         cc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733961; x=1708338761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVlNJZ/Jdf69a5rljlmZldBDpMdBRinviHNt5piQvy0=;
        b=F7Y3TJ+fI5d6R9Us6Xt5uoFcaTB9pKe1j4oZhoCvZspoi+SPE9GsdV4514Y9ppfXek
         d50xv/ajbvUL1ntZMLXccX5ArwycNBTdOpjBcWBZMGe30FIDP93Nxp40eYeDLxEOKOjk
         lpyfXZIZJbYs3gIu59ZTEOhcnQl5DLX9lDNKdchTgzZE3CYlDQvzaqbp6eO8vmmsXeAw
         XQDkLRMX1vL0oJzEZkMK8Wmf94tesqoujYkjuJhKQPazl5DK0V/LAdeSmNidFG+ai+2k
         E17jEbNsfWQ8NfF6uXjD/XU4uH0G1/5pp4u3XZ/Q6zYzBCkvPgDae4TmsKQ200lu54Nt
         O1wg==
X-Gm-Message-State: AOJu0Yy6ktb0yZ+UdcwhIgW7zgwbS1iUCwmZFOpL7S7YIZ7a01DmD5Tm
	WYPjIdAloOPr+xyIK4PB8qzByKFXfMf1BFYtQ8Uf/SxtKuycDMIeJVkRN9+vEoI7xux8hEOEJe3
	0DcsDYXIYq8a2Ce2gSDb39quiaYGUqWvIFlgN
X-Google-Smtp-Source: AGHT+IGdlMaFd/BdT6RBgHhSi1OWBqayl0lNXuYCbxRDZ9tYdjTq3zOaOOG89twPSQVa3gRMaSCc9qpJ6Ji32VuPl50=
X-Received: by 2002:a17:902:e149:b0:1d9:4c70:9731 with SMTP id
 d9-20020a170902e14900b001d94c709731mr213050pla.29.1707733961356; Mon, 12 Feb
 2024 02:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a135c0060a2260b3@google.com> <000000000000d4a29506111827e7@google.com>
In-Reply-To: <000000000000d4a29506111827e7@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 12 Feb 2024 11:32:29 +0100
Message-ID: <CANp29Y7+q_Jo65YHbReU9AYJfU=e6sZqNxxTOhgzgDTC04OY+A@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
To: syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, dvyukov@google.com, 
	edumazet@google.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	william.xuanziyang@huawei.com, willy@infradead.org, wzhmmmmm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks reasonable, judging by the commit title.

#syz fix: ida: Fix crash in ida_free when the bitmap is empty


On Sun, Feb 11, 2024 at 10:55=E2=80=AFAM syzbot
<syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit af73483f4e8b6f5c68c9aa63257bdd929a9c194a
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Thu Dec 21 16:53:57 2023 +0000
>
>     ida: Fix crash in ida_free when the bitmap is empty
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12fc6ba218=
0000
> start commit:   b46ae77f6787 Merge tag 'xfs-6.7-fixes-3' of git://git.ker=
n..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6ae1a4ee971a7=
305
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D51baee846ddab52=
d5230
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D127837cce80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12779dc8e8000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: ida: Fix crash in ida_free when the bitmap is empty
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000d4a29506111827e7%40google.com.

