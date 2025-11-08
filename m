Return-Path: <linux-fsdevel+bounces-67528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB32C42954
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 09:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B40C34E1E14
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 08:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F52D77E2;
	Sat,  8 Nov 2025 08:13:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78216157A72
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Nov 2025 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589584; cv=none; b=qGFSuYFdln916uK5OY8sIxHwxuZu2mTEGvVFsiHwM/TCuTgQ6Mlt24pDg8J4Rjg7DobwMm22V2JOTX/FHaUz3XH1UPohkSwgQoznEKG2ko9gsH9/jXcUZ8tFWbpOhN1or5MByNz2lzPS4wPwvYTATmfB+L1L/vP+WyWx3PbfKrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589584; c=relaxed/simple;
	bh=27JXSn/FBRW2GWWhywQw7CZlC2js8f9iBI6IWFIG0tk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gbKWxoEgraW4N4VthbQYUAUkcHbOb/yvr5+ddlv8IdcpLSbARF0Erb3dpKYcDwjzZ6RLS9szpGUXuygJ2i2glSQOaopzf3GigGDPGOb7PP5r28WkPKCUXZ3XlH1EEXg9fKFabqLacxPJfXIK0csTt3VWEMN9sdn7mAR2anKW9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43328dcdac1so43310555ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Nov 2025 00:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589582; x=1763194382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jW27Sc9fO2weGnerMih3oS1yEbLnA7HebxJJHprHAhc=;
        b=CYBL2lEQT6iEo/vi19EkSu1KwsQeDSrx6gVEFLKF+eMcwDUrtOW9cOf2teARX3Z/fz
         zbAqDiGRJ8zrff2HtmAkiah/7i8kPw1EJYJ3nAaxSz8Wnb2Id7C31CJUWaoxts1ngaFD
         wftAvuqEQSULnQyIQShKDvvK8Obw8rlwm7sgcD1ujh6YjmtipW5AalgTS4Pw7b7WVT0K
         n9PKAEr4+YY89pavjWfpy1iALOuQOCokQ0O2L4jLJckNgVNYnRo00cJ+P+5cQn+kBq1b
         exfIwhxMMD9C4jzmDN1MbGjKDczEUHeGOlCyR6dNHayvEFyXCh19WQMtTjVd8WZohHID
         dQYA==
X-Forwarded-Encrypted: i=1; AJvYcCX0NWoa5+/NAbZx2+mOGfJL6Y+rIG3+/EM8catBf/PehyOgyMtmVYJf6GKR7Gj8DIHtt27EeNufR05Tu3xT@vger.kernel.org
X-Gm-Message-State: AOJu0YyoIpEkznhrsgDNDaKo9YQUONT1g+sjgLCxkoHHNcO4vdHvYAeN
	7QOaT4xrHd1N8o10ucjDulibe6y3B8JeNVE8SalqXLY4E1fjdRedJ2cX389iukcEQ3OMS6kCmEj
	ggjZUwrKSJ1NRn24ASCrdh4jEACv8O7qJli6kF7AT/9XZklYk3IQQuhbWHm4=
X-Google-Smtp-Source: AGHT+IFnp/37Mpq8a8szLmVV/9YQFU9jISxAaCqlFsMaQG6x6vkpfEZwfoq3bYpJkjNB3QYSI1u9ruzE6EnypNJOJc6nxR7MJG4l
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:431:d721:266d with SMTP id
 e9e14a558f8ab-43367e7e207mr28896035ab.31.1762589582719; Sat, 08 Nov 2025
 00:13:02 -0800 (PST)
Date: Sat, 08 Nov 2025 00:13:02 -0800
In-Reply-To: <000000000000804fb406009d9880@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690efb8e.a70a0220.22f260.0078.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_finish_one_ordered
From: syzbot <syzbot+6e54e639e7b934d64304@syzkaller.appspotmail.com>
To: brauner@kernel.org, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 736bd9d2e35866a07f32d9884019e0431b0b50d8
Author: Qu Wenruo <wqu@suse.com>
Date:   Fri Jul 4 09:38:03 2025 +0000

    btrfs: restrict writes to opened btrfs devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ecb812580000
start commit:   374a7f47bf40 Merge tag '6.5-rc5-ksmbd-server' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=da6e201fec031cc0
dashboard link: https://syzkaller.appspot.com/bug?extid=6e54e639e7b934d64304
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eef89da80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147c2fa5a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: restrict writes to opened btrfs devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

