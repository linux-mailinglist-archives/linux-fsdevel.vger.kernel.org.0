Return-Path: <linux-fsdevel+bounces-38345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB47E9FFFEA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 21:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92ED8162D3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 20:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54601187342;
	Thu,  2 Jan 2025 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GcG3JcZ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F6CA6B
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849100; cv=none; b=ZhUkTd8SPOSMjxaDVu+8XiBjFE1isqEScMiSlMkz2DiclEv84vHuEghNGynXOwcQAP59QOd3WrRIV7iMFLuK94Vdv2V1EflfLbcQ7XOxdYo0drhGEmP3X4lk8w04im+HNge6FS7uXKXAnC2DUklpmr1NNMNVak3cUBiJ9XFixxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849100; c=relaxed/simple;
	bh=P5rKo/20HCpsDorB04vTXU/JHstbfmXg+E+FwLLvuY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BM+HgF+bJm7zhSHLnX7dTp28lGjQnY8O5gf25/dvvJ6TQyKTBMY3IVJNs5xrDBpPCCqzK1+Jj/Fx/sRD3tT9lggEx6d2jrERf7qAwwVQnOONrb2w0KRZN+55xsG0DErw7YMKttASy0aG3DiYjIMJDPap0SIrutkZMMkJX46Yig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GcG3JcZ4; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4679d366adeso100168631cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2025 12:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1735849095; x=1736453895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=whjW7ansRJg9of7azCwOlJGbs8sBbLB1p917lKhKZC4=;
        b=GcG3JcZ4BQakVYBHdBJghw8zQSyoOXKEHz3bERqBRFCaeWgt+JHC8irHWdiixRodjY
         he+Dhh/sp9xrnw2qIblpBTzgZ1Ha7yhsbiGt3+82ewGR8+jhwem6gI9S60wUQWalZenx
         yXTcQdAfGWGNDvP+cmKDxbRQzeMoMU4fhE3Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735849095; x=1736453895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whjW7ansRJg9of7azCwOlJGbs8sBbLB1p917lKhKZC4=;
        b=HanVckMTB+h7mUPywn/Q5yev2V/cyZ9SRzF4H0lZEShLodYveNUi0r5p7xpNErlyRO
         dFQn4G41YUKqr6bSinKIyd9guiEsJxSWBb+xWM5cDnB2yTuTrlkayEQxdm4XqZ0VqZ0x
         ffeh0NxLXL9MvlObI+r1P0oKDqpNWQHlTDrSR/dj78sg5ruihWTZ/3OnNpXtQtLCdF5/
         hdkZ5L9QkCjwxAjteZpbSLRa8rmYOW0VSEG1Y8MB/yaLShUCbC46WHC52ZhQeXZ27PSu
         m7kwLe5fIdVJjvQCR+X+csJMuUlTUDa6pW/rJkyhkMhk0gE0HDN8vyJoKwaSoPsLqKPy
         BNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVow9pWWf0go7IQZMRtgCL1VHj/1llll/jy3ohKHIs36lHDPqnzNDK9gQv/TmhyCFvkjNL7EQeo6q0xwIaN@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNTWIan8LmJyB9i3180GDJsrqAs6o5McMmVhuKs632B0+CZhk
	nSC+VNjuLf9Xs7qBqgUUSkyr6RXe1fw9EH8sfK6a7rVc14uJskqKcqEH6tWvt9cqD0vd7y1kmZk
	yd1gT+G3ctVzOcGT1Ek1nebnMYhPvhDRgtIeRsQ==
X-Gm-Gg: ASbGncsUrHHufo/ml33mUIZWr5SZkTFV4lFwvmTLToCSLFuw4GN7Y8ll9NBqb0f9/c/
	sPSak4cnK23NEVZ779qmH2nPNtsdB4K1D6vilMQ==
X-Google-Smtp-Source: AGHT+IHnssMS0rJW35LIoTzFQOzDJTFx8qrOIdHzeXqJduLtr2ZHV+Q05oV07SAY6+3VSl7j9BBmUdUt82kXGzSb32M=
X-Received: by 2002:ac8:5815:0:b0:467:51d7:e13 with SMTP id
 d75a77b69052e-46a3af9ff9dmr746325331cf.9.1735849095639; Thu, 02 Jan 2025
 12:18:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66ed861b.050a0220.2abe4d.0016.GAE@google.com> <674a5a6e.050a0220.253251.00d3.GAE@google.com>
In-Reply-To: <674a5a6e.050a0220.253251.00d3.GAE@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 2 Jan 2025 21:18:04 +0100
Message-ID: <CAJfpeguK9Baf4hxBhqS_313bo9Z0ZAGMAAbkaOMQRKTK_auk=w@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
To: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mszeredi@redhat.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 01:21, syzbot
<syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 3b97c3652d9128ab7f8c9b8adec6108611fdb153
> Author: Joanne Koong <joannelkoong@gmail.com>
> Date:   Thu Oct 24 17:18:08 2024 +0000
>
>     fuse: convert direct io to use folios
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1033bf5f980000
> start commit:   b86545e02e8c Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1233bf5f980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1433bf5f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5f0b9d4913852126
> dashboard link: https://syzkaller.appspot.com/bug?extid=2625ce08c2659fb9961a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14534f78580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c3d3c0580000
>
> Reported-by: syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com
> Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
7a4f541873734f41f9645ec147cfae72ef3ffd00

