Return-Path: <linux-fsdevel+bounces-38307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FC59FF1E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 23:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F92161CE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 22:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5481B2EFB;
	Tue, 31 Dec 2024 22:15:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21031B041C
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735683304; cv=none; b=S7dJRB4dOQ34c8Fzk79fovCNWne3piXgc2o8/q4AzFZwVipWHGvmKpckMT/S7ALuQGOMLgYbYqeUoUunpkniBN90fagkJfE5yYXtRO2/TGRlmUOjFaMhuWO2MePVwCSm2aPp/84zwlPXFtvLDdh+/FFweu63d7Ni6WIdItBtgyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735683304; c=relaxed/simple;
	bh=ZCnk8Lp5bmUkCXXKNkucrDN2l2ipDDKelnccKxsW8/E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kdkWeWPaF+BC1gOViYBjKLrWezWhCnrmSrGauc4/DCkoIjzBCtLHzjW7RpbgANSR7thquNmqCHuCYCFveBAQJNmrNqQZgmfcCIyoL8dgrtmTv2Josz1q/ctdaHdxQN9KIL95vfikkbAFErSdXWBwjeZQI+hyJo9HqUwgW4ege+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78c40fa96so79861855ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 14:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735683302; x=1736288102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUGo1ongEekp4p+Yt/Zt17zvrkPldBpIYS4DIGo6+PE=;
        b=vIJPl13UHSNvLH4zDSUYWX0bIXEqAUpZEgiUdlrixgAavXUrXjIwJP542+7f17TgnM
         1euy3kmKKRJHAbqpPdNt9YnqhgGa5OPHKcIQ3OPXO+tqSEBFOq42CbIrxsR5KPyFGhtz
         6oAtAHq+6iVv8dJFb1xDjndUGAnQpE/XeDWY6m7HzWgXEb0cN3sgCUgMwc45w9w4DLxI
         5Q4jhxq1mkDdvpL8Yk3011nItMUV4I+aWIAViPCAXMCrVDijBjqNs/rmqevC5r3D0nIq
         VGbzGYQXM+ZwIlResRufnQ0dwCzS1MYRJwBjy0gvQgf49mWWidxLuLt0CpHtLD+MXuLd
         Mifw==
X-Forwarded-Encrypted: i=1; AJvYcCV0an+9frhgVt2YlLz5bE0xYeH6rQEIwfFTJ0QhG5Ic72dkNZYbjWka8252iifh5+8fhvLmruo/dryR4KOF@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqCXhn7qfhjF6aFHd68fDgaDsSBzEyFrhrMByew8ecLqqkYgM
	gxboPgXeQ01kFvN7g4HVbLwvXVWd0yoCaGzaIUHuBjOE55BqirmmTgTpfxI8XYEnnW3xzMPpW1W
	ogWJQf+DXxcL07+Atb7s52HGQUVetQKJkG6klw0LvceFxJnb99oeZzQc=
X-Google-Smtp-Source: AGHT+IGkSWZou8BPGPOZEAOlqYrt4gCNUekjvrS7vScUaKTm2sflDcc/4bc4a7Jxm1REzy+DSzmMXkhoyW8dTgcdPXezdaBSFoM+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3201:b0:3a7:e286:a560 with SMTP id
 e9e14a558f8ab-3c2d1aa30b7mr309514455ab.2.1735683302008; Tue, 31 Dec 2024
 14:15:02 -0800 (PST)
Date: Tue, 31 Dec 2024 14:15:01 -0800
In-Reply-To: <6773f137.050a0220.2f3838.04e2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67746ce5.050a0220.25abdd.0952.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-out-of-bounds Write in __put_unused_fd
From: syzbot <syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com>
To: amir73il@gmail.com, eric.dumazet@gmail.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	repnop@google.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ebe559609d7829b52c6642b581860760984faf9d
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri Nov 15 15:30:14 2024 +0000

    fs: get rid of __FMODE_NONOTIFY kludge

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113e5818580000
start commit:   8155b4ef3466 Add linux-next specific files for 20241220
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=133e5818580000
console output: https://syzkaller.appspot.com/x/log.txt?x=153e5818580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88
dashboard link: https://syzkaller.appspot.com/bug?extid=6a3aa63412255587b21b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e670b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f42ac4580000

Reported-by: syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com
Fixes: ebe559609d78 ("fs: get rid of __FMODE_NONOTIFY kludge")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

