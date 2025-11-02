Return-Path: <linux-fsdevel+bounces-66694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42C7C29412
	for <lists+linux-fsdevel@lfdr.de>; Sun, 02 Nov 2025 18:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3105C3AD16E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 17:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121C02DF6E6;
	Sun,  2 Nov 2025 17:38:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502A2DEA6A
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Nov 2025 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762105084; cv=none; b=JbZuRFq03y4R3nQXlKdTicIT1keJQ84ofca8NxAV6sls+ww7fp2r8upXlDon1Ey/iyvg7sdidLfbmq2huNZwJmqeRsv8GCf4rViknWe1QpfJFpEsC71UNFr7lp+Ola8/DgIfVKeJd3YLkRhaXbv0YdfUOYc2j6Rf3BcjROojowA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762105084; c=relaxed/simple;
	bh=o0FIdqFREk++l3J1v2J3tW9h4pt95Mr7/7IG2Ece5Aw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g7G4pRLgJkIY3oKTRvx00gZwRJXlRHI9b23b/PM+OzI56CvfQuVL/e9fRwX0P6iPAbrGcx+wkQyDpjDDt/klhMKSJoaoSNqMGaiDSvj9YHv8jo+aMSKSkFjUyJsJW/1eJ7lTnOA55eWpyAYhWGrS/1GzVi15vveWTK618vBMvsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e86696b5fso388460239f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Nov 2025 09:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762105082; x=1762709882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/wAEv9GIPrwh1+x/pr00cLookNh43MVdSe1H945Cxs=;
        b=FaD1ECtpaO4kGFTEjbAAUNloNzye28U+mIlLWxNq26GE3mBj/83pb4Q7dJKdJhekRS
         dW0BNxVyhMUGFkX6qCMMOoeZnyV4Q/J/0l0j99tI2QzIy/Tq54yQg0v+Yqu8zQfP4TO0
         9Ie30GVVX65GqHJfE4bkSPxX36pT+DMPr7zslW9zKpARn7mXs1TobwH95WpEN2EXnf1V
         R1ywDb8xHr3NJbK4CKiimvLb5MRi1u+gRjrSIPeHDOImJlgpJBWSOeAuDZfzveewkjb1
         QK/HBTNlfkAvECz8L9+YMQEM4tcREpKLvNyUYMfWH4law4vc2lsfa8ZMi+nU1vz2YsSk
         6fmg==
X-Forwarded-Encrypted: i=1; AJvYcCUjeuRHl8z62qlfqLfNRFas+YsD3hdQcekVielakPjj/EfKqSc4XCbwNtVV/NSYdPIZPjQcLRZYCgOMe+RG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+8VHoPbAvfYk8vmc0sUcnsh8PoAEWjoMzFVzv73LT1W7N2ImU
	SwjkeZ2OrWYvJxV9hDRNBPaN5ZGCd385/T/ccM6CDLAdAlY2jhOyuSPSlkUMFcNEp1wek20xx3q
	hrlubi6dfnD02Vw7RIlWcqDyjYERWlIYI5pTIH31Zhkun1ZOB1vC3tVAiWeo=
X-Google-Smtp-Source: AGHT+IG1zgigFckBfcGNeJaiPbJX6Gh9TmGX80g1LSF0Ct9iysgCECfpHX/faSxFEexyhP9Nc8O6trkMpNHWl4XussCMo5cabh/D
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e8c:b0:430:ab63:69d6 with SMTP id
 e9e14a558f8ab-4330d1c9e60mr128484625ab.21.1762105082195; Sun, 02 Nov 2025
 09:38:02 -0800 (PST)
Date: Sun, 02 Nov 2025 09:38:02 -0800
In-Reply-To: <67b454d4.050a0220.173698.0051.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690796fa.a70a0220.37351b.000b.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] [netfs?] INFO: task hung in pipe_write (6)
From: syzbot <syzbot+5984e31a805252b3b40a@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, ceph-devel@vger.kernel.org, 
	dhowells@redhat.com, gregkh@linuxfoundation.org, idryomov@gmail.com, 
	jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, netfs@lists.linux.dev, oleg@redhat.com, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	viro@zeniv.linux.org.uk, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e8fe3f07a357c39d429e02ca34f740692d88967a
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Tue Aug 19 16:10:13 2025 +0000

    9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154ba342580000
start commit:   ad1b832bf1cf Merge tag 'devicetree-fixes-for-6.14-1' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e55cabe422b4fcaf
dashboard link: https://syzkaller.appspot.com/bug?extid=5984e31a805252b3b40a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170d57df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12df35a4580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: 9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

