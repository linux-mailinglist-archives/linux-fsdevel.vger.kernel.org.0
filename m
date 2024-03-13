Return-Path: <linux-fsdevel+bounces-14273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D46D87A4CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 10:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF27A1C21BB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 09:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E872320DF4;
	Wed, 13 Mar 2024 09:21:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6BC18EB2
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321664; cv=none; b=qJHq6mXogBLd5hxPSxYuipyahDgmIsnKFWqJcbNK4HAmAb5BVlimmRypFc76+0UWrc3e7SW4SsXyLYNg5dcA6tW9ck3DDKfJxpPOXc3jg8+1+iYwM/4lKx6IK6mb+JJh71Vn6HxUk1PKGEkBBLYHhKN41MaXhDSeqynfshiQggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321664; c=relaxed/simple;
	bh=hNRXDRtkuiedHd5TjME+BJ20Vj1/8OolpAm1P8G18yg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jFIS6xGVNszzkcCP6aD5cJX12YxGiYZYwbi+FpD0plniUHZ3oHdVlUjjx5IQS0E6MNBNO90E7ZKMgc+K2L5Y/BVbI7mcUaKhPE5hy6+rlTeuJOQSzJoNAhxE9m+PYH5+/kgt5uC4j/fj5KEM04tBYFz8R47/OsHqTrwn89wpjzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3666d914c00so9875035ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 02:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710321662; x=1710926462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUVHXhfBzboZdbTNdDDdoN/fzRzCDakmnF632lqD8YI=;
        b=F9xm+Zs+4C0UJocjvTDvSzI55uPiqF05LqzEIGN/bIR1lcOYnvZm83lR40F1nFqtch
         IIGNnpMdlEmn8+AZIm/sDo9Y1K0aLMuJRxJVbsQmhsKCNSuUCedMnHiTIVrYstECc2mU
         2jUdw5qeCoV2+RDxsDQKJ818++FU0CaSGvF+/7VW88L42pwDZ09BjJwHFra6kYBgQuVD
         uSIiwtQS5WwqEBd7nnhieZDaZH9lec8M9UMpBStFCNj8eUcMmlsPMGIAjD7SXz0uWZmi
         2Pfq87fqGbsZDO0sDUTMAUhvM7v+4vFm6sbJzoro8VgnfUefGpYVwXGaT0iMt/b8VM5P
         iFCw==
X-Forwarded-Encrypted: i=1; AJvYcCXKYTOpQIpjlRDkSeNxQo1XDm42Mgx1DKMUv+GcukigzExcl6KdDp/f3vFWtct95sOSESAY5qxq2j1Dm19LAlwR/YzSZmWurXJq+66Xcg==
X-Gm-Message-State: AOJu0YzHHeWV+OgrmQJNId3jUvGFGcwZEWHLygW1oY+e23r9w9ruJ9Tc
	+UWj6MqNzw547fd0w1p7Vu0Isv4UQNFd96vmQdAtlqePfk7LXKa4Q3eCKbF+hY6FCYLH/PUcNyc
	ATHYJwpix/WJDycL1//A400uIUjD8pFR05ONxQ7H/gQgCUuA+hBr5Ntk=
X-Google-Smtp-Source: AGHT+IE+s+mbYxDvCB7dBwN3EfB7cqA1/PRdPkXZuKU9zMsZd/WD7u0x6cZHxeHk/z1fBsWR8niJHGUMZu9BlTXQSsPVf4fsLML1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:365:1c10:9cfa with SMTP id
 j15-20020a056e02218f00b003651c109cfamr429856ila.5.1710321661924; Wed, 13 Mar
 2024 02:21:01 -0700 (PDT)
Date: Wed, 13 Mar 2024 02:21:01 -0700
In-Reply-To: <3070359.1710320315@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c69f80613874b9a@google.com>
Subject: Re: [syzbot] [net?] [afs?] WARNING in rxrpc_alloc_data_txbuf
From: syzbot <syzbot+150fa730f40bce72aa05@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	kuba@kernel.org, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+150fa730f40bce72aa05@syzkaller.appspotmail.com

Tested on:

commit:         d1f2f222 rxrpc: Fix error check on ->alloc_txbuf()
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git rxrpc-iothread-20240312
console output: https://syzkaller.appspot.com/x/log.txt?x=13a2f71e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63afafeedf00ef8f
dashboard link: https://syzkaller.appspot.com/bug?extid=150fa730f40bce72aa05
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

