Return-Path: <linux-fsdevel+bounces-60414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5FBB4695C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 07:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F701BC3242
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 05:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0BB28136F;
	Sat,  6 Sep 2025 05:56:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53217996
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757138166; cv=none; b=g7UXlf2/3jyDh53WJm+f4MIv8WC2ioTDESbytZpHvY6/eKe6TwTX4uJXWl0GLTx1Q6D3TCSxBV9vVcTLqraSn5tZa0X8FLcrgIrZStFCFzcQCBwsr2IPjvw3u9f8j8rFJvrrm8aaWffgCtyiQKPkz8cqZErutzjP9EZWAwyTwpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757138166; c=relaxed/simple;
	bh=rwS+YQVKwMf2p/fBNKDMiWGnuwF1PhmQunsa3aTRicM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gh08DQrjMaR644UHYjlAusYZlMcTUkgetlW0TSkcQSjChu+dkj6KAlOTDSOcB6myWQJ+wOwWuGI+yUtKdWPEC5OkGFv4aHoaysmel146zK72tFQ2mHxT7e0Xzp1q60czsjOctnqdIM8HioZJS/18w5S1Th9KO6KN2Trob6qNWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8875735aecfso919007439f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 22:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757138164; x=1757742964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHTHq7OtikLx0TkjcVWxranl0l9tx/2o6fcLu4mdhBQ=;
        b=AGkRYDpGGN9fqmSDuFIWid/1fqHO5dhHFdc52EodfvhRX2Wtck3CHujW9i3TXascuc
         WnyzfzMEZ9w/IrM9zMa/DPensbLVfx7QyYf/xa6tb+om9WvZjBhsgHYMysftLf39kV69
         Ma6f87DhoEcf7zVFzBOHqX5eboYtTRzapsRL94K3QxRnQfSX6liE+7+OykBNqSyudpSs
         qVG0fspM9HPkGkOyQ0SY9U8da/ZGHVoT7qsZ2ye1SCl49TdIOjxeX8b1Zjc0SXXM9DqB
         8fqR2zbnoKGo+X1maZRve6pqhVTcPjLSQtryMNWMGQFqHqpw+8NfchlE/pHGrMY6GJzt
         Q+lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw5ZfNwTxwGFcn24ybQzp/wRpk4JEpAhiF3aa3Kp5EAsENtLdFalNFVP5cX2hYcUbXV0NxwlH1oHBU9wjR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8N1VQIP4qlE/HuUcofOtSm6bASLqjAAqjLfixH3sT1xCXsM81
	ozcxj4kx84QWM7QkPOCd/8p1b6Khjm9WwJ0BgG7InFYnPBXNi0UJZbZDtp/3qpLUib+3kodV+CE
	Mlp79RhE3zLVfIXfYE+pQKQevDU30sM8cfkszGjy991Y1QcPRWjrvYSTtO/8=
X-Google-Smtp-Source: AGHT+IGJShscWtke5WlVC/9/IgwAZNBtYCTN/XqqZz+AH83Piz1KXfVk7GvvINmromAz5XANIJoIHgKTai0kYSqcShkj9x0zJhA8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2504:b0:3f1:7907:5fb9 with SMTP id
 e9e14a558f8ab-3fd8cdbddcdmr20275035ab.6.1757138163761; Fri, 05 Sep 2025
 22:56:03 -0700 (PDT)
Date: Fri, 05 Sep 2025 22:56:03 -0700
In-Reply-To: <94eb2c0b816ebcae030568bb756a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bbccf3.a70a0220.7a912.02c1.GAE@google.com>
Subject: Re: [syzbot] [hfs?] general protection fault in hfs_find_init
From: syzbot <syzbot+7ca256d0da4af073b2e2@syzkaller.appspotmail.com>
To: anders.roxell@linaro.org, arnd@arndb.de, brauner@kernel.org, 
	frank.li@vivo.com, glaubitz@physik.fu-berlin.de, gregkh@linuxfoundation.org, 
	kstewart@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pombredanne@nexb.com, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 42b0ef01e6b5e9c77b383d32c25a0ec2a735d08a
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Jul 11 08:46:51 2025 +0000

    block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17c0d312580000
start commit:   ee88bddf7f2f Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=28cc6f051378bb16
dashboard link: https://syzkaller.appspot.com/bug?extid=7ca256d0da4af073b2e2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1026b182580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159e0f0c580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

