Return-Path: <linux-fsdevel+bounces-72087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E6ECDD63F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 08:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6759230194D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 07:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DFF217723;
	Thu, 25 Dec 2025 07:03:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFEF33EC
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766646186; cv=none; b=DXOZAIPDT8ZTx+gg9HtIQAcc62VwmFlfqw49FhZQXvMnnItkyYweQYoj5f3FkgNazEqL9BYh6R70jnGXi3GXJoBKCzUEkkir7eL5mFbc14hbmiD30zxYNsP6ccWD9mIBNJtFGrxpH5J+btosBzu2/KoEWdjOb0Bokm2pmbrXjPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766646186; c=relaxed/simple;
	bh=wn96RWDl5N1hOdjrqeg17LgWUNfNi+PhXsw6RX5sOZU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tnD5w1KwMhAKEbwlIs7XyZYAgqrGlYMwV7F7WZw6MVNmt9RvBtmqSE7OaN26RTum4r3aLCqnxKwSbMStmpXamjHdD3Fn/40+igTHJREL3f04POnjsNNN+IJHiez8i8TPTIEDtSq51FNGPqvlC5pvLTpvwIJFAYvnSL5+rxba1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7c76977192eso19784070a34.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 23:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766646184; x=1767250984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KZIgj2KabdePGNXiH8PxxTMu0sC8Sc0rYJeYx3aeTA=;
        b=lVGVuayuo0kiZD32HxQaFQPIzEvh0UDJJqdX63WzkubS12Nc1hsaewXQ95MxN/fWep
         sU7Z/Z61UzcZNIH7SrMMkOIe8F5fQeCe/hf6rCRavGN1pLDwlYb/WRqwS7WQBawGi+om
         Eh4gbRk62mg7QROgrkrjStYNgIDyubW4M554hDIDRYCcZEhUwqNTgampi2Lw2I9KwImJ
         bQbSQVf/813MrMksUzDPpdqllGh6OMvSn6Rkb+o4pvS7am+yM34oQ5sK/uzmoOoVZrpW
         Ctf2PBRtnYw4mtM740vgqkQfKaJFxzEtYo2q0WwCzfBNzWbsJCzd7v5IetM4ZtcXRnJ2
         WdrA==
X-Forwarded-Encrypted: i=1; AJvYcCXGCflbpuceHbrI3Kfu6y7fHsh/wxzIFQHAy9E9IGLjSAdoxyB4W2oDXFMggNjcuZmOKPWF5nEGgF2aj070@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOsJG2NwLWQ3jzzUzj0tvjtX7eeDxF55q407GXKnJLmzwTaSv
	ePZ9QL5bJlYT5vdq5gBYwkrP1C5v/SzZHKQ8LDYJezWBpz2i1Eu/z5wiw/zLhmgK+6JIBldxXcQ
	x1zCbhgABSm2WdgxgzYfXQ2ndKUANqjTuYGvUBCA9Vus4HRo07SApUi6GLac=
X-Google-Smtp-Source: AGHT+IHi94rnsICS/Ar5+vQ/0pN3IhewQdBMuKf5fC8S8WtfwHuHHXT+FBVN6Bpa1zZGiG33E+XO2qx6Yc7O5UmsyBDc9bR39Av9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:dc4e:0:b0:659:9a49:8f33 with SMTP id
 006d021491bc7-65d0eae4877mr6631531eaf.68.1766646183915; Wed, 24 Dec 2025
 23:03:03 -0800 (PST)
Date: Wed, 24 Dec 2025 23:03:03 -0800
In-Reply-To: <20251225063402.19684-1-activprithvi@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694ce1a7.050a0220.35954c.0034.GAE@google.com>
Subject: Re: [syzbot] [fs?] memory leak in getname_flags
From: syzbot <syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com>
To: activprithvi@gmail.com, axboe@kernel.dk, brauner@kernel.org, 
	io-uring@vger.kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
Tested-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com

Tested on:

commit:         b9275466 Merge tag 'dma-mapping-6.19-2025-12-22' of gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17332bb4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d60836e327fd6756
dashboard link: https://syzkaller.appspot.com/bug?extid=00e61c43eb5e4740438f
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1640c8fc580000

Note: testing is done by a robot and is best-effort only.

