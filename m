Return-Path: <linux-fsdevel+bounces-38283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F79F9FEB9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 00:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883931882ED4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 23:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF38019D898;
	Mon, 30 Dec 2024 23:19:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCE819ADA6
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735600745; cv=none; b=reRd/j3xe0XTx0ya3BO43rKJo1rZQGWOdURQoc8ig0NlgGfOmR2ZqBJvkUDJWc/hMngnHd0CYKybZ3W8nKz8UunBFL+v02qiuxTXfxULeeMyH84+5mpDvhb9/P7spBrxeCAf7tzoAm/ZfTXgP9dJ4dsTcoTjqz9VMRd3STv2/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735600745; c=relaxed/simple;
	bh=vRI7372Q5Kne3rGvehqYNIqwTqXK973H3xAdZnjjOb4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XJzl3r4IV9XQDESKEn2IQU4o5tygcnDZzawP1rELhLS6kEOMZym4Rm70eVnvq7beGCzeSfWAX7sRbEJ/P3d8HPprB7N5bxIN6nnqCS0+BhmyiZha006AAbF4KfqlwxAe1Broq7VMyA8ToDR6+79PScWJapZ++A6UY1rmZaYUqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7e4bfae54so93624665ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 15:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735600743; x=1736205543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4gh6TBXzpYDMGAqsRtjB7Y9Y365UNBzUT6dDnA4j+w=;
        b=wXIDecRejGYcX3UePPlsmWYQJEQgqzlv3eO/1WNIHyhEd356mHVloDI8a8rmQC1ZmW
         3Dbg/erR7Dv3+kRIF/waSqZi9WPsKG4O88fjeVMhOwsJ8so78We4/eiBetkQ+EeYN/de
         i+FSBN29jqRbj3EmtYh9QGfuaRHn4fEyV0dxwtek92Q4WxPkpnGPsb899Y3wJdQLlq7z
         cAWQr3KBZ2pFcs7ldsAhkOEevjV+4+/CVfwRKVYvI0HpJBYV+RDuNYhRl+8PgtqBOfeb
         0IbFTt4nC15bP5VAx5qH4zEaHYFjv6Jw6CtccJFbnbHyyaOEphB2jfpGxsS3KHUGM7u4
         muHA==
X-Forwarded-Encrypted: i=1; AJvYcCVIf6ehGCe9ClojM97gq8idlcFRYdXprOeCnmiHM+Mipq5VdKuo3AHfu8zOF65ud+KGoj7c2jEVD61FbWEX@vger.kernel.org
X-Gm-Message-State: AOJu0YzdiUVd8prZP9631hu8umWEEN4SoDlYLCtjwghVsDC0RxHyqq0/
	XhnjP9c7ELBE4Mcm0TutbQ4G2X1MG7bEAWX2lQu2MpuG3P6T40W7GLPfGPuquIUVPgIpCzQMRTq
	6kP8UX0+WQBNVHQRaLUZn+yHRnaXbPhaYiYaj+hDPPBDpNRr3zEfNRxU=
X-Google-Smtp-Source: AGHT+IEIAhjemoYtlUG/oMqIutmApQFIGArxjoU2/F2Ad7OHjg5+NYtNHUAvUX5Fh11pIhQeq4advX2MGG6fdBpqlArQc2sDIczi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3687:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3c2d18b43aamr342242215ab.1.1735600743208; Mon, 30 Dec 2024
 15:19:03 -0800 (PST)
Date: Mon, 30 Dec 2024 15:19:03 -0800
In-Reply-To: <616118a2-e440-45c6-a548-a1cdb1b586f2@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67732a67.050a0220.2f3838.04d0.GAE@google.com>
Subject: Re: [syzbot] [fs?] [io-uring?] WARNING: locking bug in eventfd_signal_mask
From: syzbot <syzbot+b1fc199a40b65d601b65@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, bigeasy@linutronix.de, 
	brauner@kernel.org, clrkwllms@kernel.org, io-uring@vger.kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b1fc199a40b65d601b65@syzkaller.appspotmail.com
Tested-by: syzbot+b1fc199a40b65d601b65@syzkaller.appspotmail.com

Tested on:

commit:         a9c83a0a io_uring/timeout: flush timeouts outside of t..
git tree:       git://git.kernel.dk/linux io_uring-6.13
console output: https://syzkaller.appspot.com/x/log.txt?x=1566eaf8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=b1fc199a40b65d601b65
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

