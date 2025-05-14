Return-Path: <linux-fsdevel+bounces-49006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9832AB7624
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 21:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A63E16A63E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 19:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FE2292924;
	Wed, 14 May 2025 19:49:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C627BF6D
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747252144; cv=none; b=CFh4yox5nKVii+xRKpk5j0gEra2dZ1/7zdKpkV08FPQBsU/GFfvaAk89sGOQ118P8iKgUct5d/Oq9FJ0dOqhsY0WcKUIEnc35bevYFqdSErfPNcqbGlnb/ZAwTB5bNglw9k3KV9DZEQCxBfw/6lUb2nz488qp+usizookTuQtoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747252144; c=relaxed/simple;
	bh=oIrs49oF22LdOayzkJxHulEMqFcJxB98u0gpNzS1tJw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L/n100PW6KLm0EfW6Iw7PyYGb7Z+1idY5kO4ZPv0xUC/FjrvwdqisXZFcrdBCx34nJcpbtdmIYEesigWltKFaQ9yuoeTjYOcPXrPKujAtrZ6mh6tbdpOrXWLl30j2mFwxfkpaouzIIp/wHrW/qiqffJINtZ1fUhNKYtTd4TFUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86463467dddso24657039f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 12:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747252142; x=1747856942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Im8wekS7D0YSdnMIfDocgAHGRdGBxTKIXIfbrUkKCCY=;
        b=rL37iOcloSeSwc1h12S78hZHDroiFoBQFzVWncJDcfLnVSX4dM4gBikOGRqoVt5bve
         edud1t/jx06TlDDerVW2mLwUezJQqkOcymHs9u+SzD4574T67X8kd1ITGHF0yd+ZT8tQ
         9FM00O1sg7gJBnRYhak5DD30LNJ+zy9Th54Aoo6iy0hqc35llJ2dpXbZ2fXntD2tVWNY
         NiKJbpbC04kZpVrcige7xJOI1yWXCql/vW6mh4YMXi4+7fMF9h3CuMpVi4bP9NAv1MD2
         opm7OgYMnAPwQm/m5LMAN1altYp+sjKvUDCifIyffOEZx/HJdhSMLr196m6W39NR3SGx
         XKsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwhkecaci0JcXKe2dqdcN08td3UYIOBdDbt9nWiqVrh//nHmfcqs2TJ7e0K0elq4i7jesktQqILhm8liHy@vger.kernel.org
X-Gm-Message-State: AOJu0YwCSKes99jXRDTt1Hcme8uCTVPEBdQxdl7AafhQgXNaPDNqDCaM
	q+EYxfVtomvLrzQGhgTt32TkzSbBSjjjkokc4TdGFH9GABMSnRCYovgvF6EhpFcrfWwZ76U97YJ
	/azIqtLrx+TldftJcPjXf9JQsw3xp5LxGaODgyLsqtprFP8Fka0SzFj0=
X-Google-Smtp-Source: AGHT+IHi1nA9q05RgsrvMcaw4+vkrl4VzwVZ7QmhuqaphmWHt3YXymWvrvMvRn2WUOpe2Ha7COf3DHODkvj9pxX72z9wyoUxAbTe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:368e:b0:85b:4afc:11d1 with SMTP id
 ca18e2360f4ac-86a08dccf99mr546554139f.5.1747252142169; Wed, 14 May 2025
 12:49:02 -0700 (PDT)
Date: Wed, 14 May 2025 12:49:02 -0700
In-Reply-To: <20250514184652.GP2023217@ZenIV>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6824f3ae.a70a0220.3e9d8.001b.GAE@google.com>
Subject: Re: [syzbot] [xfs?] general protection fault in do_move_mount (3)
From: syzbot <syzbot+799d4cf78a7476483ba2@syzkaller.appspotmail.com>
To: brauner@kernel.org, cem@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+799d4cf78a7476483ba2@syzkaller.appspotmail.com
Tested-by: syzbot+799d4cf78a7476483ba2@syzkaller.appspotmail.com

Tested on:

commit:         cfaefc95 fix a braino in "do_move_mount(): don't leak ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11865cd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9683d529ec1b880
dashboard link: https://syzkaller.appspot.com/bug?extid=799d4cf78a7476483ba2
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

