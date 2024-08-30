Return-Path: <linux-fsdevel+bounces-28006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07191965F85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 12:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A4C28B637
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 10:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4405F18EFEE;
	Fri, 30 Aug 2024 10:44:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C917DE35
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014644; cv=none; b=AYzSj4WzX3H9oG+YoXFsgrkKSxNu48A2QaobDY2RojrJGM8FNThsOff+r1wOx+amU66/GhjcPUkLVPFLNyhh2rOfyg2579K0s9nDtraGJvWIgoMa3ozYKY3bkMKJ+s57VbhoeM7S9dnwtnl3MQYa7uf99mq4M3XLhUTrUY1ZO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014644; c=relaxed/simple;
	bh=niNpNZJMobFOh4FQA6zvVD8T0AOLgz3BBoY4hFfdYJ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DH5OhxBz0URouxxw1mL4KGsnKUcxr5S90r+ZxRe/9TYOE66Rh07A5NN3LHYIz3F+9r8SINI61hLiE6557rbiHrgdtP9hrdJaA1QVyZAptF2nxjZpNk+uWDBfvV/7ZA+6n3QO05uOKWqpt3gWiBN/5QCYE+5s+e3CN0jiEBSpX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2ced7e8eso17816605ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 03:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725014642; x=1725619442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJKtDFQx4A7z8EmFPZ787p4mjXNb5tRqOM9oMTocYA4=;
        b=cOX10UbpC5YU8U+6x57M7kB64p8olMlxa37KeInISzXpQw6OxY9AJWmRdf/CaAkiBD
         l1fYb2t4+o51ADSFOAyAJQ7fms8/5LNbn+BhflRBl64soP6nhbi4/rXG+HNM9n+9USl3
         iySq/2TQ0GBPcKxofeb3zOvavROLyCU2Jo0yUOzd88r9skC7oYIw4OvWyQVfMQYPnH2w
         ut/mgpBWbrE9iB4yvaYm29W61+bl4OdE5QS8Nwhegs8tKU5fHfWZZv2MpPfqW2oaCu8K
         Gyfitba0w+BKdlcwLyGm9pEAkWRq2/Qal/L0H34CEKkcWWdnemOMMdn+fclDeCaM1o0w
         JmOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmKh98cDHazanoLbux2EK+4eI1hP2e7ro+dE9ncEa0ifsphu430CEcD0zBj5/+lkmJwRgo+Y08mVFUNz8l@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1JmkpIDwKbJ3oheo1HXdQ76NC11BqULAIZyjUgFKXuhe7N12X
	4ayRJniysi7hmgYUkLKXkiz3xXlT7E/l7+VO5O/aDl/3Dps6VzQ0BjX2UnLEjbBjUUXyri6Z1W+
	XtX7Eu+BBrEwrjMwKXQ2NFmZm2+T6yYY21W371RuaSAcrIbhoTMVQ7Iw=
X-Google-Smtp-Source: AGHT+IFphnEkAR4PqF2gg0wh439hJmAr4j9EryTljjcSjPfYV4T1MBzhbaA98mG907oZ464Z9Y84zJ6WGp8spaxpqGvYh1Qn+Uh+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a65:b0:380:9233:96e6 with SMTP id
 e9e14a558f8ab-39f41073afemr1366405ab.4.1725014642624; Fri, 30 Aug 2024
 03:44:02 -0700 (PDT)
Date: Fri, 30 Aug 2024 03:44:02 -0700
In-Reply-To: <0000000000008886db06150bcc92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001a0600620e4451b@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in
 do_mpage_readpage (2)
From: syzbot <syzbot+6783b9aaa6a224fabde8@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 24c5100aceedcd47af89aaa404d4c96cd2837523
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Tue Jun 4 07:41:39 2024 +0000

    fs/ntfs3: Fix getting file type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1104eb2f980000
start commit:   d5d547aa7b51 Merge tag 'random-6.11-rc6-for-linus' of git:..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1304eb2f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1504eb2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d806687521800cad
dashboard link: https://syzkaller.appspot.com/bug?extid=6783b9aaa6a224fabde8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140ddf93980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c83909980000

Reported-by: syzbot+6783b9aaa6a224fabde8@syzkaller.appspotmail.com
Fixes: 24c5100aceed ("fs/ntfs3: Fix getting file type")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

