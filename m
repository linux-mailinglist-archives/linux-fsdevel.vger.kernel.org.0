Return-Path: <linux-fsdevel+bounces-32435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D959A512A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 00:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B31B21157
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 22:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10D6192B78;
	Sat, 19 Oct 2024 22:03:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10413C816
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729375385; cv=none; b=n39UZU+8rM1p5asVhlR8CANV662asKlw9CmUN35+5nwCh+smZJzHan68gCKUB/y+hN7QCI7eKEBQqgkvWT/CZ87/a+BOiu8Bn7aJd6t3Z6dhhn6w5G8mpvz1B7zL0o15hZpueZt/B146qcRBCRPmumaw7nUIeDpgrSOSJjatj+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729375385; c=relaxed/simple;
	bh=4r/dnSU2iv58zYZkcF3J2NBOOcfh+f3piDebouy/9IA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Oc9JFjDx2RYRDNdoa8sxKvo6hn+AsqSaI5TjxxILdecbEa9iyzgHqIOcy/AkXWzlnOcZOkheKAokndyv7ZTR7Buc1tzJfhgac0078IHckVriUMbYMBwH6CUa1p83VNJlrIG8U5d8UssH23NASwlecIK/Bl7aghkL12lzFu6mScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3cc9fa12dso25602965ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 15:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729375383; x=1729980183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RLqbF/44Rgljiqe7gmVwXbfdAgdxhslKmNZMh8Pfbw=;
        b=q2WvPh08vtKZuTkKohnnVvEXBjKhu3T2XwsORFPIzRHv2g/kEMDhKpiPVGVdmeCCRQ
         Ub51b8K65muUl/wXFuE8mxqxyJVvLUKACa27c9wdLFzcn8zVKwpftf+4ple44Hqz94CO
         hmlmhfP7K8Tldy4HYMAcLwuhUhftM9gNObQQlUrl1Lp27Ml3V44RUnPPrnPyqGd2y+3N
         0e9hFpRveiGWX+3tbl1b4CVGjTqQvWNgJABRaz2/4IoAK3gugw5JH6KMnwHPsh+jcULz
         TsPfHEFPFgfYoEloXLhd/sAyDZJkYQrEadHX2QYhZlPEY6YigB/+uZeOABOfI2XSb0Go
         SHCw==
X-Forwarded-Encrypted: i=1; AJvYcCXymhLcOCwScnMLpdPvA24lSyZeIbXoNedwU7AcKXnIA33+k9+NchLPY5Sv2pmUxw/DqEy12sk31ZgEMH6v@vger.kernel.org
X-Gm-Message-State: AOJu0YxwsGaJpnRC4XhryKSzG1P0aCH+VtM/0SOzXxXlaBoMOfB5mP9j
	PMvgTVFNv6dEq5wTF4t/z9pyvFYUPwkM3RqawzeyU8aA7zJCON6bdrAHfftZa0krlLoscO0OW6x
	FSV0sasg87XzHzd5svwvTCa63K9vlVzjoOb+TVOpByOy3qnZn1YlREV8=
X-Google-Smtp-Source: AGHT+IE96T6mtPOXUI/WweupFLsfamKoYzsTZ0Bbhwr3/cBXtjGsDjI/N0hiSqdkU1zKkxy1ivao0cGe6sBEuVvyhhqrBErxxqXc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c6:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a3f4054723mr65915665ab.10.1729375382809; Sat, 19 Oct 2024
 15:03:02 -0700 (PDT)
Date: Sat, 19 Oct 2024 15:03:02 -0700
In-Reply-To: <00000000000087e83e061dd271bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67142c96.050a0220.10f4f4.0021.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] INFO: task hung in eventpoll_release_file (2)
From: syzbot <syzbot+63ab1a905aebbf410bb7@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, isdn@linux-pingi.de, 
	jack@suse.cz, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 0023d340ba86cfe50b935829a73adea57ec2c629
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Tue Sep 10 14:22:36 2024 +0000

    Bluetooth: CMTP: Mark BT_CMTP as DEPRECATED

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1594c430580000
start commit:   b31c44928842 Merge tag 'linux_kselftest-kunit-fixes-6.11-r..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a85aa6925a8b78
dashboard link: https://syzkaller.appspot.com/bug?extid=63ab1a905aebbf410bb7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10662bc7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137bba00580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: CMTP: Mark BT_CMTP as DEPRECATED

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

