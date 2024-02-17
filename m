Return-Path: <linux-fsdevel+bounces-11912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC651858F92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 14:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91941282FCB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1918B7A737;
	Sat, 17 Feb 2024 13:05:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFDF65BCA
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708175104; cv=none; b=pPOE4XfgN/gi/eA4dnyngD0jrbc48KRdPWIFv6fnUNukNwCz5azb3epJlhOti84+U3/eGdqZy6qcqNdnfKEdkZP1cNkE6C0pwQ55DtECa2zSSjkXoejzMM3qZSG93Ct9rHhtjx6bDHCGpjKjkEfaG6G4z3cajYDyKGc6SZ+FqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708175104; c=relaxed/simple;
	bh=3nrOran+3E/6VsB078+tXDWuibeDv+JF7NmZjhbKaME=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=myca/iXiWR095iGTd9Iub2xZfBfyScg8TbnVnnAzF0+HETeg81VYukOYAfmQTNER2uLo/azUDlCE1Q8dP4V59PJSXImiMHHQi/vGi2EWbRh+XWUlLNbxJlMYFCgAPVn4q5VauuQh5QFN8PZIV3dbi4XjDBvsJ6GANWsAg94Dies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c00a1374ecso196603039f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 05:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708175102; x=1708779902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FThBQXYga9w1cWMyp/yRXDDAEE94fJrZ4ihdn0r8aIQ=;
        b=qd55Nsk0COZqZuJZX+8StDSYG2CH5/fr8tYpLClTW/5tAVUmLF9k61e0z+f1X0bkIt
         Mx9oM8OzsyHQ916sr4e6ZU12uOcUEepMZef4KRgHdxqhktFyopwqdzJ5/ja1s0MgpAu+
         34ayD1zMUFZOhn1Y+zZap8kRby9qyQmNCy/tkrPky2+h+2f3zsAWThpiJBc6rfrBFW1L
         SD/Z/MiKgdsur8DT5Bm5d6oja/2o2GmV4+IvnltdXXFPXeRFujk5omUL1LH3vZ5ZSAfM
         5xKb23Q5lo5dwJ7u33BlAj2P8FXfdZ1fNdCaDzNUnQI7jh3GftpFXb8adH+BH/Zeto+3
         OEPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcRcrYENAtJwph6LNYjMEyYnr4hExF9Bzv3nEWmL4whEXJ+PL0NuVWpUPo7Mj6pUlnMzSWbfvR59caN1ALFGAnXAtRIgW619VOk4B5tA==
X-Gm-Message-State: AOJu0Yz5+NYBaB6YEtcf/cQCvu0GuRLoiUnIHlPypUbO/3UX0azqJaJY
	vOFDJVC9Gvu5x+CbS1K2btrVyz2mJRm3We8BDXB8G9muAS8bVB58tqZDlheKq8oqnArfPjPM5XL
	Y2fv7xaDRaH7AB3s1QjiffQOq1OQingdTTfKhQArw5OycuQ4l6Ja0whA=
X-Google-Smtp-Source: AGHT+IEX9WITVv4GtTYdnW4Gcm9u1rwfgoZb080R3rLYEmMo/IgaR6FjIYJegvp5dLVSAfB3thDnrcKX+MYpjj+ledVz59058AXK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:388c:b0:363:a059:670b with SMTP id
 cn12-20020a056e02388c00b00363a059670bmr436688ilb.4.1708175102569; Sat, 17 Feb
 2024 05:05:02 -0800 (PST)
Date: Sat, 17 Feb 2024 05:05:02 -0800
In-Reply-To: <00000000000046238c05f69776ab@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033f84e06119382d7@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel BUG in ntfs_end_buffer_async_read
From: syzbot <syzbot+72ba5fe5556d82ad118b@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14016cf8180000
start commit:   dfab92f27c60 Merge tag 'nfs-for-6.5-1' of git://git.linux-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=71a52faf60231bc7
dashboard link: https://syzkaller.appspot.com/bug?extid=72ba5fe5556d82ad118b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c987eca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144a738f280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

