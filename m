Return-Path: <linux-fsdevel+bounces-37431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCA19F21BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 03:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1947C165DA3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 02:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B028BE5;
	Sun, 15 Dec 2024 02:25:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243D3D68
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734229505; cv=none; b=roLmiU1I2otfKh4YxJRbp0t3u+TzY7HzNJO2bwo/btNcLC2OunzX5F+PH6sU50wyVbydJzc5ZJPhwS25MDCH1ohgO1BQ+GP8bgLd2lN8rqlmFNy0t4hdwuZNvESiLFWO5h21kCm8sx8kwJln8e9SGwjE+/iJ2f51LVAsYmrmBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734229505; c=relaxed/simple;
	bh=9z9CDIaL86rcqU3c/2Jy9KV0Lx5TLM5y3glw/CCBmfM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X3i6bSxzNlNEvQiGOD6YEqumDN0f8OUs4/S6Wr4V7PwaWY/w5WaCWYWmpo4rPlDCGeNzHzaSp50oe0BpPDOONtNWqqzZgyfqELa9XCo82uvXex/dkjXm2Hr6f9Wf+q/KdwHUzC5yBNzHgHOeRv/SPA7DgwgykxbTfkTtsfJ8Pok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso62560795ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 18:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734229503; x=1734834303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27X23hjyWyJlVIZ3/eBdUOmOtVwfJ5bUfhNLhs19TCo=;
        b=ESenmVzyS7VXSdXAZMFCxSlJOt2pmwiaXNNBP+dI6Udv6M4IWaFYo1JehLsMTok8Yv
         DHWAntA7/JVoM2Gn0aBF40XbAFvODxMtSlZNRoBpM78dfMrjGJMhQFOTM4bxNaorjqof
         DXoeLbXwo51CRuoL0AADQ+nWUeNwK6ZXox2eYgSuoYAjO4UZkBsV+vjXa33kiamt4Kc7
         O9q9qRnq/3fcJ0G3lBp23GL9ismx/B8KexYF0IcBKTLu2PkKPZe6i4fIRmNOuvu5pR2e
         NIsBPC7ULTyPN7hJFLMyfjE3d5eTrfTzimNja9urGXfzZwrEXNSn0YnccU7sZjZn4e3G
         sH3g==
X-Forwarded-Encrypted: i=1; AJvYcCU8Mj9bcVV5LTXkrROFxNeONvpgA14fTjAqCpbGojLOOhVpWAMWzxc4KWLsCvN4xVIfZcZZo6cacLNzMNzY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1hCTt1mJrmt4iT4HhF4/E7uzOnjfzCuqptGv9p8cEPVkPowSP
	rxuErVcZ5iw9qIMMqE52nGpaiyNV/iUJ5Szn4kj2Nmzlh2RoIDgh9ZvCKSY5NN3JfEh6+RrYmOd
	zFKRCEOIZ1h88HmV5EaTDWKp/tew4i1oj0z+Tmklb0VUeUUMTxFkyS/o=
X-Google-Smtp-Source: AGHT+IGhoBGt45vk1Ze/2pgcL5QxGDeKTYzyepNYA9qMvQk83i3H92FqfWdv8qUHpU0g30OIXoVTPKDPfw5icsvj1iUXEzVlw7pS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d03:b0:3a7:e83c:2d08 with SMTP id
 e9e14a558f8ab-3aff19b773bmr80785815ab.22.1734229503489; Sat, 14 Dec 2024
 18:25:03 -0800 (PST)
Date: Sat, 14 Dec 2024 18:25:03 -0800
In-Reply-To: <66f6c8ce.050a0220.46d20.001c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e3dff.050a0220.37aaf.00e5.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in input_inject_event
From: syzbot <syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, amir73il@gmail.com, bfields@fieldses.org, 
	brauner@kernel.org, changlianzhi@uniontech.com, chuck.lever@oracle.com, 
	dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org, jack@suse.cz, 
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit fb09d0ac07725b442b32dbf53f0ab0bea54804e9
Author: lianzhi chang <changlianzhi@uniontech.com>
Date:   Wed Dec 15 12:51:25 2021 +0000

    tty: Fix the keyboard led light display problem

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ad3cdf980000
start commit:   7eef7e306d3c Merge tag 'for-6.13/dm-changes' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11ad3cdf980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ad3cdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8df9bf3383f5970
dashboard link: https://syzkaller.appspot.com/bug?extid=79c403850e6816dc39cf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bfd530580000

Reported-by: syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com
Fixes: fb09d0ac0772 ("tty: Fix the keyboard led light display problem")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

