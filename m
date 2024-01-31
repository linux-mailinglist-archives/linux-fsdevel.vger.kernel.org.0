Return-Path: <linux-fsdevel+bounces-9678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0414844536
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 17:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1886B1C26027
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B20D12DDA4;
	Wed, 31 Jan 2024 16:52:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2E12CDAC
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719927; cv=none; b=duVN6mInSJfIoI9S+88hj9IhD1867tek62kxKjvGUg/t9LOfR/kUWDZAtOxN+BfOjFC+73TkyEe4cBjZWAdJhylMltDPW8l7CHFiqP6WIXj6n6IXz8ylFAxMzUpxwVvrrqTULh9UD9oqc0taTT/Mlh37gw+3YdXDO/bKo9KM02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719927; c=relaxed/simple;
	bh=8mIlbgNFRn4hfguvC9zxPYL1vcAbk0M7lwbNKf4D3Ug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MrYmYWAyBaTio9uZtwcKP5puw8rcg6e2SHU9ZJDjct7iBMeKXOK6Jg9UN4zbfulX5+dNr/nS1kviCBd4Af6zxyXkoNJb2UbIaM4+jR7uwqcFDSOX9WFZSefZ0Hr4iAtW6CQOYMl8VQLAyMQdS7aHn+l5bg/IbnWIkVf+Z8OHcNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3639d04fd20so2034875ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 08:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706719925; x=1707324725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKwMCNqqjxXZNdfuSQe4LlDy6lJeOUSAZT3H/H89flY=;
        b=eu7a7ksYH2Sgtw6GDPumLLBZQFhbkFwmxjMFuHeJ4xeMBL3s31yfH4miq2YKl4AApX
         sWtBHsepf3SQEonVH5PaYISBGzGwpkK0WpCzhrwuse+kaou4jVuTbl1Cq1YcN5v3jTdm
         FUJnPXgp0Gw+VLFCcDco4n6ChVryyG0BpFzX8UquO+a1N+X8sNl4oVZfDwvnXuuqJVdl
         JE4NYZ7SBvdDbQJXzVtiVmpikmW8Vl3nAvh45miE9CmhxRijCCEq6htgvqk05o5hQGVz
         RAByR61giyKEoBNN/akxEGr/ciQSdmWb7k00UZD2Mu22EKrrG+/hrwplr8AZ++Fgdhxi
         Knsg==
X-Gm-Message-State: AOJu0YxFLUpMMuq8KyR1Pc08xvx+ixkCsOJgYPwknzzYs5HwznsnyERl
	zYcsA511sVLMSWskxlgpvCvdpACImFjCtCr0tkttB6w31yO5PrY90Rd7++HLBoWJR8JT2eY6anU
	gnNmT3kKFc69e2KnNm/dNLiEYZrGrvHHnzATTJBvS69aVJ38aPpOWib8=
X-Google-Smtp-Source: AGHT+IGfIwM+AKkak4ZYg6BDLxJSI1TkOSSFyHTXghP3x687RLESV3g2QiRGib+cS5p+5Jf+Bq7ixz8Av0ejom50Ml9mYtKfyygv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e8:b0:35f:d9cc:1c9b with SMTP id
 l8-20020a056e0212e800b0035fd9cc1c9bmr198780iln.0.1706719925486; Wed, 31 Jan
 2024 08:52:05 -0800 (PST)
Date: Wed, 31 Jan 2024 08:52:05 -0800
In-Reply-To: <00000000000073b6d905eb48de3f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3d3f9061040b2ff@google.com>
Subject: Re: [syzbot] [reiserfs?] BUG: unable to handle kernel NULL pointer
 dereference in reiserfs_find_entry
From: syzbot <syzbot+4654552e088ed458b10d@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e6fb5be80000
start commit:   51f269a6ecc7 Merge tag 'probes-fixes-6.4-rc4' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
dashboard link: https://syzkaller.appspot.com/bug?extid=4654552e088ed458b10d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1177c895280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f4b2a5280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

