Return-Path: <linux-fsdevel+bounces-36852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A19E9D1D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 18:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D288188747A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969D014F9E2;
	Mon,  9 Dec 2024 17:32:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CB1233137
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765527; cv=none; b=T2bbWoGnPFwLzzs1rLX8UYB30ZikJXT1CpskDnE/GXVttH9yGMfNinvtlBAxVeLfXoT2G0JRCpzDYmbhmqFNp5DPBZ30X9ie8umznyLAYcxLYmrSK6AuV34EKwmwBb+knA9Mukz7IhTSlcxMf/C43hZBwIdns+AYApuYbjfZc3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765527; c=relaxed/simple;
	bh=2dbFz4F3lGyQECKzFO9Edvk8zlb8Isu/2tfm0Nq5Lkc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nMtTwT20jtIX4KUNCB9mAJ3kWZpCetLJ5HTjrPuJuE1CzRxX9mD0o05NgXG4IUiTZge8jQi5jCm8GLpH2BMXonKZ6BhuNoA3ZNGBXe871WlRT1fP7tanlugRzbHR13/4v4YgXGL+kuYcUspWA9ln47wTOU8FfbO5AmzLwAJDAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a9d303a5ccso18804935ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 09:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733765525; x=1734370325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jT/MGQxDXKDPFnbZPgiB7s7xdACGqnR8EVRt/7/8hDs=;
        b=u0I4BYFgx1Ky+k9edmsPyzNmo1dV9wU4sR4dyEnL7BotHgjikbycuAmpF6WX4qTlZD
         C6BlxUyWWSLaDkTBAb4JqtOMdUW7nbsBIJdRtPql2AjDs0zHsFEHs0MrqEl0jqwu5wmi
         l3Xisjqtw/hRfVIW8YEjGIFPgfKlpQFHA1acNgBcWv8ju4Csc1F1/KXmeqxgt6jR9bYK
         aIcxPsIJzR7b/KiUZSW26dMRtQEHIsg0kXSB/nMDf7QwqjRM5t7chVttqns8rv9VQEuE
         3plelIcYAmL0x5TKTahpk90QK5ZM7bkhmNIswg7WJ/si09nkWcZqgCOU2Roi13vLCUvb
         SW8A==
X-Forwarded-Encrypted: i=1; AJvYcCWnGjFtXno0Wmasxq8bMQoxuwljB0SsgyYfb2Bpi3+5i6GwMtpbT3Tb6hNOZJphjzjBvNV3BU3DyP0uSnfq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz20jUo+1MdCv8ai1vD6gIjRuZRyWbRh5In62PlLNeMKkocQ27V
	vQyUUZfNxRdTrznI+2hb53DgAEH6m30icYpqDQtWzSYouk3C0duTgQavLzzCPubEGCppt3sj+c4
	RuzYLcUyHr0eKCYuauHBcBf3Ksm3J4CgCGBbjR3yCj7LJd3y4lrbVPNU=
X-Google-Smtp-Source: AGHT+IEbmrduPr4KcIVaGH64axnUUJmrCwgpaRUJDoVlmRGbX0Ds5oWWrgEhVPCUxpp251txjlITZJhDfXt2hN60A9Af/5ybn40p
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1745:b0:3a7:e539:c27b with SMTP id
 e9e14a558f8ab-3a811dfe123mr141144075ab.17.1733765523621; Mon, 09 Dec 2024
 09:32:03 -0800 (PST)
Date: Mon, 09 Dec 2024 09:32:03 -0800
In-Reply-To: <0000000000001126200614f5c9c4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67572993.050a0220.a30f1.01ad.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: slab-use-after-free Read in
 hfsplus_read_wrapper (2)
From: syzbot <syzbot+fa7b3ab32bcb56c10961@syzkaller.appspotmail.com>
To: brauner@kernel.org, bvanassche@acm.org, cascardo@igalia.com, 
	chao@kernel.org, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, rdunlap@infradead.org, sandeen@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 1c82587cb57687de3f18ab4b98a8850c789bedcf
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date:   Thu Nov 7 11:41:09 2024 +0000

    hfsplus: don't query the device logical block size multiple times

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17c554df980000
start commit:   48cf398f15fc Merge tag 'char-misc-6.9-rc5' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5d33c579b4e833f
dashboard link: https://syzkaller.appspot.com/bug?extid=fa7b3ab32bcb56c10961
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e3d1fd180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151a6e73180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: hfsplus: don't query the device logical block size multiple times

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

