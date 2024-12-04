Return-Path: <linux-fsdevel+bounces-36465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F11E9E3D11
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D2EB24155
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781B1F7548;
	Wed,  4 Dec 2024 14:20:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231F41E3DCF
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322006; cv=none; b=Aps0PomWOUGbLCPi2Iflm1Te3KK4zZ06HkhYlNadzxPxNacZXGc95HQVH3swRNjeF3rZy/InfdzNHQhbwX/bCW47yLoWjbIArtK5U0n1JqdOQBT0ZiKS+6mJ41CM1Nho5sTufi563uY5rOKNnddXBNP85sCPnfEWKpR3tOAlyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322006; c=relaxed/simple;
	bh=tO+SORHpKmrWTcl93DOLCo0umt8XdOBYvIMpAvA3wgg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PO9on6WjGECBsKEEgmXZKMDNPVRFkVGCheM4brfLjs3DJd3j3qQooCF8RqBV5RP5+WbHBpsAKHX38RHnVRlVEJw2Ui0MJ/W8YlKX6Fd/SYBUEiEqeMe8mGOE2a0VcaTH/xdUivc8UEQWotyyJUdRHQhrcnWOxMovGpOc0Z7vQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-841a4a82311so603448239f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 06:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322002; x=1733926802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KVEhwAjHAH6DwhUQICA5+2FgGfgLP5QSHauX9xaRkI=;
        b=G8px13/MvdAtlX4tED6XP6uoxVwtJ8NdGDm8WhNazHV/xZ4xc8BUWkXYwrTIk0upgX
         QNx7BSIe20uWmKq5yzf2bDgxTXvqyy8KtKMDyQ9tWpHQZlMFoOybrJvFX1SVjLbQEC/1
         cA6n5s0r6F3fMy8c57ssdn+tqUrf0Tj6U0PSX7lhaBauruzH+jQxZ64uCwtmRu5wQVUc
         ND78ytRBKTbnUa3PTG87mftMqb0lf/3Hli6VZMPNV0ZqUUAS4PICZ1eJvI6N/xeeSEAK
         JblPA3Rs19FvUFkl9nxJGkd5YoROb1XUA513qzX005wnzZH2m1epd0HnvcdrTt6kl5rH
         o6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUHGGYFpFhcDHZ8VqUCiUdr0XQWDUi+HKZiKVGgvePbqjgmTnhSLXdf+9eYJAGjKkclHhT/+NagTfe/Bhw4@vger.kernel.org
X-Gm-Message-State: AOJu0YzJRoFwGDCoLIXg5G1rcECtDDCM4aszrQFQyHdJduPb4tUnY+xY
	1Xpu5YxL7fnQbQrrscNs6d+1iCCBONRO5h59ZqSvYuNViPOj/NApqANaA8eKgZ1m6iVLP9UWlRU
	L/UrYrVgotvF2L4QwA28Z85Tl71ETxOjydZJJ4iaGj+xeaS/H4rdB544=
X-Google-Smtp-Source: AGHT+IFCfKe19gEn2IpmATv9IPOuQmAwJeYIZY35tvobgYCj4YIwz7jBav1nR/Rzgpfp/T5bdc8Tcp8RRuHIAae0Yhb0GSO7H9tV
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:3a7:e528:6ee6 with SMTP id
 e9e14a558f8ab-3a7f9a4e005mr86299875ab.13.1733322002409; Wed, 04 Dec 2024
 06:20:02 -0800 (PST)
Date: Wed, 04 Dec 2024 06:20:02 -0800
In-Reply-To: <1128092.1733320787@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67506512.050a0220.17bd51.006d.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Tested-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com

Tested on:

commit:         40384c84 Linux 6.13-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.13-rc1
console output: https://syzkaller.appspot.com/x/log.txt?x=11f960f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58639d2215ba9a07
dashboard link: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1249a330580000

Note: testing is done by a robot and is best-effort only.

