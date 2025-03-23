Return-Path: <linux-fsdevel+bounces-44841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C118A6D0F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 20:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE57189525E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE31A01B0;
	Sun, 23 Mar 2025 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bjb0q27U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753524B29;
	Sun, 23 Mar 2025 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742759593; cv=none; b=YTuwDE8PqIc9IDVixJzjwggy0d1xMVIPPlVuZklFM4fccfSWH27M/j/iJayvPYGUmkxRgNFwDSUUjUgk+wbOsxvPTOFMYoUCNPSPZPyjkRWfWrAnHhArlVyWH8WeR0FgnMXAgOofdoDfFSakJlON5AChIa1GYwzcD27A9HpOCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742759593; c=relaxed/simple;
	bh=/D+nG4uW10nRpZVc2GkyF6TytJKeK32ybhtrWcO80fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+G+QoMTXfgj9pphPGXi8vgybvCK3wRpLN2//RatyhoVzuJZkl7pnT3T0Gdf1giJoUmLVxFZsCjMKriLMkYqk93VjJlIFbv+YJJ8nI68O2pnnLaONwQzwz0oTJCEmNB5GCGpwQX7/cQnPcrZH5d5oPW07duEEFJn4LCFKbaIFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bjb0q27U; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so7324654a12.2;
        Sun, 23 Mar 2025 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742759590; x=1743364390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/D+nG4uW10nRpZVc2GkyF6TytJKeK32ybhtrWcO80fU=;
        b=Bjb0q27Uv5UD0YRzMSP3u5FbGCYQfFk2NSjJ3a9gkcVfg8wAx0QlCbW3Nor92YrIY0
         yrlX+BrMATFLAcUCmSQ9KzXzY48N+qkgVOh+8uhHUt9/nvQttVCI9B/Qlv9ThDaevzHf
         wONl3YGTaf8opgOR3njFBtwqn6hhJTVFnG1CtRLI0NP7iska6P6b5DShG6xq22oBhamj
         c4Q72UhH+FNc/PSdlhO1c9TUqprEyF6WON23Vb8rywG6VxiUETHA3csMS/yjE1E8yUqZ
         uFdhSSEidxxICC0qSepQVl7vJkV22I5RLyTEFpB97UTCfVr1tkvRG+i9N/3Z8pU9Iesd
         gZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742759590; x=1743364390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/D+nG4uW10nRpZVc2GkyF6TytJKeK32ybhtrWcO80fU=;
        b=ZXmZ/hZyXFSlYB21GjRN8/vv/LSYB34R/CVkHR3uHWXHwDPa4iTZ8z/SsOsNDyxJxE
         x4IcKpZqvCPu+nc/1nEudz/UFUO+JkZMJt9sl2bKmoi5ZdmPkIAzTkWCRK+oVazWwi17
         SF1tj0bmP6Lr9+jZVyWlsNEczwbqpNUTXQ7W3vmPAxCNS/PG1k2v4H4+ZE0bAwFx4rIB
         BFzrAkIvXjS5pg4ti79ImDn7QsR7rDUvaaOj+ZaTckqM3t/0JjU5pXfLJZ6zOZXkqiqQ
         HcyjnInU8vxh+OxFsMHWuE/v/uEvHGsKQbZwE0T7oezvdfwMwE++/cWjsma9ZVTjiWC4
         W5NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBb2UsVWEXWTqMxCj6PaDGhGbqsWn3WdN9oacQUxK3S1zjcg73fF2/eTYkCIumCxXuYcRnYMuimEpTCAOc@vger.kernel.org, AJvYcCXZqOS/B7rVPEABcgxPieRx+4GkbFwE6UjHurQ+ndv86wNDY9pDqMOr+ESLOoos34Lql8IyctDx2ddo5Tc3@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDyVjrxlg//38zQQmt2ukU/V24DevmgbvN0ohHEXdJ1fw32GR
	QYhI4R6KT0CMgNuIjrImlOBUGeUsPZ7+xVrKSdkMyKgBzuAD35nNRHCmR2IhhiBgTTA+V3k2WkE
	OTuyGDb4MwyIl6mG3QEaT0fJENIQ=
X-Gm-Gg: ASbGncvI4OwH3e1fSTuHSro9CU1VwBFVFGqT3Wh4Y7142q+KuXDqxo33Pu3+GWxcqQn
	pga3RD0xGIqlwGjKLvz4uHJm5Sfm2TLR5bIRQGamobGg2O6m0WhDbURkS4BRRYW2X3g61PRYMVk
	c4ECswdtJ4q5t1At1YLqsLbxBlAQ==
X-Google-Smtp-Source: AGHT+IHoxQWQN8FbIDI0a4E/ODBLoiOjcLkhiQ5MPps/DpREbWQPxM3AVzbSmry+3Kvx9vewOOtvo2jMDaQvoLHZ3vQ=
X-Received: by 2002:a05:6402:270d:b0:5eb:cc1b:773a with SMTP id
 4fb4d7f45d1cf-5ebcd4f709dmr7581807a12.23.1742759590271; Sun, 23 Mar 2025
 12:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323184848.GB14883@redhat.com> <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com>
In-Reply-To: <20250323194701.GC14883@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 23 Mar 2025 20:52:58 +0100
X-Gm-Features: AQ5f1JqRBzcP3FWhh1V2ofCMs00Xh5Dt75eWXWr3JMV0jNgQshHIIMywyiTDbrQ
Message-ID: <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>, 
	brauner@kernel.org, dhowells@redhat.com, jack@suse.cz, jlayton@kernel.org, 
	kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 23, 2025 at 8:47=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 03/23, syzbot wrote:
> >
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer is still trigge=
ring an issue:
> > INFO: task hung in netfs_unbuffered_write_iter
>
> OK, as expected.
>
> Dear syzbot, thank you.
>
> So far I think this is another problem revealed by aaec5a95d59615523db03d=
d5
> ("pipe_read: don't wake up the writer if the pipe is still full").
>
> I am going to forget about this report for now and return to it later, wh=
en
> all the pending pipe-related changes in vfs.git are merged.
>

How do you ask syzbot for all stacks?

The reproducer *does* use pipes, but it is unclear to me if they play
any role here -- and notably we don't know if there is someone stuck
in pipe code, resulting in not waking up the reported thread.

--=20
Mateusz Guzik <mjguzik gmail.com>

