Return-Path: <linux-fsdevel+bounces-72386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D07CF2E57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 11:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6A0030161B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C70C329C6E;
	Mon,  5 Jan 2026 09:58:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ACA3FC9
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607085; cv=none; b=myYizwM2X8dkCDNC+JA+qCTJct9UyJHXy47+/bnDHEz3wVkn4pFAcrvWHCaD+jhIoNxt8VRNabsUjvMxEGNJSd9mU31Uu1ng3JXjEQGXRcp8vpiQWg7LxcJ3tBhF218C6Neu4EeovGyFfxx2wF7mb0d5pUQinJTlYDExYpKS1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607085; c=relaxed/simple;
	bh=HkOv+wAGL1Dq64KlQJMKTjRGPPlR5TSIpg2gbL/5vnw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OpFQ4Fw5OWR2nvZoIhZ1teyziNIp9EkOwdiepoyd+Y0UKTRDf0FYaTf2qMCiUvhs712uF1pLN5/CQNezMKinr2LhvEdBzY7nbjdLjIfBsa8EQU+z/TKJ5ReOpccjjyqxLbCb8aZxJfJ64XltVas/6dXxzW5Yj7LkIG7kxCP1jKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-65d12f446c2so26577990eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 01:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767607082; x=1768211882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDGmjMaHgnZwwAqDdlQy6B4Ob7QJflg+s9wTsqFHJ2E=;
        b=s8G4c6cgSmFC8afCIbHTyowkJNGIyBdPp1z/RQyVv22+wRNKEF9WqRwE4O8hVY08gy
         IsRsVsE68EAiiRIYdvZNyyFhl+FI98vRuWZwbn9cSibDOabWoKOQNr/xt7RR4JTJ0okk
         qAxulfrLUCxTNVquEEoGgAtq4Vs6JhNkWPzFbCVnamqrYREbH7Se8aoHqUIkZgjOsJIQ
         Mi3zeBzHtGP4a+H8x38BANXIbY9unJuJHSaYMXJEtLy/ZCF82HKXOJJNfXzAvKyPMHP/
         hUdwYIFaV2/hRPZqkQCHeYfAFPjbGVYXWx4bI5X8/5lwBMtWjnaHriwZrGknLcT7IPn0
         tkCg==
X-Forwarded-Encrypted: i=1; AJvYcCV7h1z9I0MIgZiiVBkHSWhZfPJBlJ9nDKDP2Lh1eoLPqo3RNIn2Ac/SHhTqEkPEJ/VuR0aJ2SXIZ0EjSrT6@vger.kernel.org
X-Gm-Message-State: AOJu0YwZdO+e/bvL75O270WdDtdEiunIlpUWHtGoA9VQm/nXI0Q94Mbj
	sLk+ddzXwW7A9vglp9p9h+fXcwYi67oHb8UP4neoSXf+dsOfUTHXhY8onUZTPw2fOqphjvu7puu
	xn2G/F/jikzNDMB4nzufZq8tfeJ5RU9MbFb+VyYCmxbfLUzk8lNHw+vrvZe8=
X-Google-Smtp-Source: AGHT+IHp1Iokdt1C1OpMO5MYFyiTIFq/unOeK2efM0UBFldfFzcjBM4b2J6affPRU5gF5OT28seal58My4+2OvzLg+1gFGRm9W7g
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:b808:0:b0:659:9a49:8ead with SMTP id
 006d021491bc7-65d0eb2eed6mr16225489eaf.49.1767607081903; Mon, 05 Jan 2026
 01:58:01 -0800 (PST)
Date: Mon, 05 Jan 2026 01:58:01 -0800
In-Reply-To: <6888afe6.050a0220.f0410.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695b8b29.050a0220.1c9965.002c.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in driver_remove_file
From: syzbot <syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, dakr@kernel.org, eadavis@qq.com, 
	gregkh@linuxfoundation.org, hdanton@sina.com, hsweeten@visionengravers.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 72262330f7b3ad2130e800cecf02adcce3c32c77
Author: Ian Abbott <abbotti@mev.co.uk>
Date:   Thu Oct 23 12:31:41 2025 +0000

    comedi: c6xdigio: Fix invalid PNP driver unregistration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13622e9a580000
start commit:   3b08f56fbbb9 Merge tag 'x86-urgent-2025-09-20' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=a56aa983ce6a1bf12485
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15571534580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152f7e42580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: comedi: c6xdigio: Fix invalid PNP driver unregistration

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

