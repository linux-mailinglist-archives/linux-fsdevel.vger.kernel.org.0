Return-Path: <linux-fsdevel+bounces-12158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727B585BF6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 16:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D439283356
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 15:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9508C73187;
	Tue, 20 Feb 2024 15:06:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7F71B3F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441565; cv=none; b=OvGYZHnRy3RdMIfuls97fAchPeRwIEvv1pwIbQPGNknh91Fu4CcW1L0eM2OhfFt2G1xrgEGuXK4p+fshA/kUj+E/3Efu1p2s2oOeiggGxJCRiRJ3cpENRCSnXDfsJLSUTFlE0sRaXTFERjJTZEf+t1wtA97hfq3Knd4uI8W0BgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441565; c=relaxed/simple;
	bh=QGSpzD8IrL2IL2FVOH+KRPNBrRVxL+/XdPkqbD0Yrgs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NHrXTp0IfrScE6vpK0ZjavqFCIw29Ylv2TYxT1fqN+uJOUzy6bnMZdCGvWaTcMIwyf/vRvim+6yMNrLkmuqzltC/+QUumaFthi75Cb0bz9FdWB13MNKJp6sk095X6OmG/aB6tqUEDrMk09o7gZK9BG/ZfbuljzZyRzUkMTjf4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c0088dc494so235059339f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 07:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708441563; x=1709046363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yTxsOwUhHvJATauDuWZBUQRT5fbxREug4NmWnZkrzE=;
        b=M2SXRpEzBXpb2Rg5GPFuUdG/t8g+cDURx6uH+FIe3pnnk71asoSemIZU7+4YDN3Z4h
         sB2Hni1cQLsxPVXJP6Fm3JV+JXffl4tLip9wYaQDUa2YrDP3TPUP+DlL5rsU6GOfija3
         FSUYb+38VYd/Scgt7H5NDnGddEOCIqVsGHIK/U5E1bbSRBGIZW9Wu7TYa8KFwXpWoUqW
         CivOw7l5bjx2p2hZQ9K4wE5dEo7oVF0mBfWT7bRzvSQASgRcXgHJeSa5TtrJYtlxYGeF
         uvMNw8gY48xakm2M7hAYjIS6Xs+tJ0SpsJSziXT6S15FfZFdautNsjC+vYl4qlgHliNO
         QgDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2uVsPnMq1D21HcfMDk7wVvj2fMVa6oEpcCECnuxd4aGGtA5V4iRDDsceSKq8GP1EGIpVPWBCC10N5vsWGmSvWNXIjPi5mpUpz6+vyUQ==
X-Gm-Message-State: AOJu0YxcE7vDuSk6+hh4ZXQzghXV+kEHO9KmPP9ne4SxPtIzdu/Hl4HQ
	lrY6t7CrO0kXhXviDLWKLGDaUj3RXxfB5ygjG2xP12j52MK5OEYY1pydotKC5KuH3u7BD9IJlZl
	Yk045kS2/LJk2Eu7XLicZ1ZPjmfT6YbRcWMMLshjQQATCq0CoAP09X7A=
X-Google-Smtp-Source: AGHT+IFdqJve6wJsxc9By8rzEOYNew2XImrd8r7hRr7EXK4O0t9yzUL8Ic/2bOauglDK4zzjRVPIP13b8gmSQayyuKpXBAYVt79z
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d91:b0:365:88b:3fba with SMTP id
 h17-20020a056e021d9100b00365088b3fbamr794506ila.1.1708441562919; Tue, 20 Feb
 2024 07:06:02 -0800 (PST)
Date: Tue, 20 Feb 2024 07:06:02 -0800
In-Reply-To: <000000000000bdf37505f1a7fc09@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a3b2a0611d18c03@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in run_unpack_ex
From: syzbot <syzbot+ba698041fcdf4d0214bb@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149d61e8180000
start commit:   41c03ba9beea Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdb1e7bec4b955a
dashboard link: https://syzkaller.appspot.com/bug?extid=ba698041fcdf4d0214bb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e43f56480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fbabea480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

