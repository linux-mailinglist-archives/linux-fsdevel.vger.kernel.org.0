Return-Path: <linux-fsdevel+bounces-69633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB878C7F589
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 09:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5FA3A6DF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 08:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C74B2EFD89;
	Mon, 24 Nov 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0Yn1yPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ECA2EBBB4
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971636; cv=none; b=G4qsd3FRyy8I5Y0XcKBy+81VbU2p4Kp2eOGg7UHWmIZm27++j15d+J6HmMAsr6PNwcShfvM2TtUQWhxcGeFoMqbRebK494xfknkX0kqhppg1BLAqdO4FgtSOlX8OViKpfhzNaYD0C/KUn/xFjXjMSMWPxwDmYWCWYpM5m9TREt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971636; c=relaxed/simple;
	bh=uLF4ymbc1debRYSZV84IG2bq9LlsCFvbjGNsZ7FjQMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv+LHkYnd2oKq0xHlbSOYW9eMm9GHzn2RKa+efvJPX4IulzmrIOK/hXPo/xXLklPkGKgoWxioORYUmwwzCl3WExXVd0PJ3/1cqMNLnTsCL9xIUhMaLbedWUorFXRpakjCFGlp9qdnM0fK4iKU2XPSk/6G/VibzvXmUaXpa5KIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0Yn1yPY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7277324204so665125266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 00:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763971633; x=1764576433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffJm8uD7vCOgF9zgZEJ5I2oPynD5JwzH3iIO07ZQVps=;
        b=l0Yn1yPYVT2d4vT6gdgi7jao0TGcA2OdbTWl/nMRCsn7PVswrIIWR3NerIrujGuyCC
         wB9M0kkQt6mhyxLQ6K1rP6Xvsu+mOIIEndPsFl2f6RO62ZlOI5uHj3k7JsvHh6534IEU
         jSeirhlOS3vGDAlkEBs09raizrFaliQuLVbYTrkuRD80Z3qUC8UV9p8g4VnsHJ9O4Usc
         zlNa7zvfJrWC4VvaZSEIBlqHa3sbgebzleKAr21q31SUussxV+pmtKQ9LKuXcR0AYZPK
         b3GtLi+/jjH0WlGwnCvngEbgiXuIYdPbzZGiOwc4TYCYbm/IaDb+Jez6jBKR4zB86Y7I
         xCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971633; x=1764576433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffJm8uD7vCOgF9zgZEJ5I2oPynD5JwzH3iIO07ZQVps=;
        b=vZptOuUAUOsqdGEmq2pQTtVO5ODJ4IlIr1LHcRjYOxGgAr5nY7oOTtOOxrajLjGH0E
         gi6yiA2W7rjQOI9Ttk7LRmeS3RSCHjQRNsiOL2Q/W4LsEEkPoqBx6Oql59FoCkVPnkFl
         lCHtvcCLzl+XTS86fgoQ1SHpwrK66NaArhNcj9i1affodrN6Gf+D/CmMle6TJul9HvSL
         YtbwNKDCOJK5BL84am61WBfA+VjjNyA6cDVUZMW5CClV9My5fXshMcJG7gbqslRepM4L
         Gd98szCtuA3BqVyfNog5uYz6jxHlhiwR8lKfxojh2ZbgvGIJPrVkrvTA7wV/HTJORUbS
         NNtg==
X-Forwarded-Encrypted: i=1; AJvYcCXZgYLv94KRz2trVdx0wQVvTqhe6tUuXmd0nKJ1img/+vGK2QovVurJTv1Bo2Pct7kfo+osuVmSUM8ON1P1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxryct6iCugvdBXUwFjAzcYyfkoa1V0h/2r1dLKQt3PCIftqb2b
	MRO5TbYNHXumof8UaZSUJffj81Kui31SB8KQWxDH6rrukfIc6tqGQDxr
X-Gm-Gg: ASbGnctjb1UNidUAf6BvJ6Uv6EmmZZunF3C1V4jIk5reOXle8WaGvFJ8w6lM2Kx4cYQ
	8iIVAmdz7MeacnXQzzMrXwXdcZVzO4huqkrmg+Di3CD3UKHRRVjF2fvzcayd3WVFtd7TXcuNbOL
	wOOZV16LLWMKhV9H5fgnHHy6OBOCRhnAoukI8LdUg0HvzDGw/eiJmniWYLtsvJdhFxT7SnNy7FR
	OhS+sybyo6L51RgMvq5cHG06D/xGLikp7mq99OSk0W91cHJ/cPlsF53wEi5cy8kygoR5hohwagP
	5O+CxsDX1FeLm1AgfZMzcpeHzDZh2GiMNlJwKHCHzDmssUIQ1Zthts7ZyBHVvpNrWO5KYjSxKNG
	xp2p+SUlWWeOp8XpJmPNts33ZSquw8zh8laoflG1w+gRK0VTFMLnDcsYVy75CMRRkdcDn/S94+A
	ND+ibVtfm6t6YtOxO4JQfWr3l+yfROfQto7w5DzU/MkkFuhkTVtU2b7UvE
X-Google-Smtp-Source: AGHT+IFtvbyzbyYPyyUbUpNZQBqo9VaVT/zaQpsMNf29OGJ5PF9TvCJCEVLb2lxKlFTH4n4qLf5tjg==
X-Received: by 2002:a17:906:fe46:b0:b4e:d6e3:1670 with SMTP id a640c23a62f3a-b7671517ad4mr1179647766b.11.1763971632882;
        Mon, 24 Nov 2025 00:07:12 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd5e0sm1283838066b.1.2025.11.24.00.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:07:12 -0800 (PST)
Date: Mon, 24 Nov 2025 09:07:00 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
Message-ID: <wij7hnuisn4cukkqmcflda3eurejl2dqjgwlphwesbu5jbljvc@xtqmwpwdj4pr>
References: <69238e4d.a70a0220.d98e3.006e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69238e4d.a70a0220.d98e3.006e.GAE@google.com>

On Sun, Nov 23, 2025 at 02:44:29PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe4d0dea039f Add linux-next specific files for 20251119
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=142c0514580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f20a6db7594dcad7
> dashboard link: https://syzkaller.appspot.com/bug?extid=2fefb910d2c20c0698d8
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cd7692580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17615658580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ce4f26d91a01/disk-fe4d0dea.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6c9b53acf521/vmlinux-fe4d0dea.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/64d37d01cd64/bzImage-fe4d0dea.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/a91529a880b1/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 1e3c3784221ac86401aea72e2bae36057062fc9c
> Author: Mateusz Guzik <mjguzik@gmail.com>
> Date:   Fri Oct 10 22:17:36 2025 +0000
> 
>     fs: rework I_NEW handling to operate without fences
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17739742580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f39742580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f39742580000
> 

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.19.inode 

