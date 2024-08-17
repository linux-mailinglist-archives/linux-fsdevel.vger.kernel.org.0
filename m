Return-Path: <linux-fsdevel+bounces-26184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7D79556D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 11:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74BBAB21CEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DA414884D;
	Sat, 17 Aug 2024 09:43:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9712CDB0
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723887785; cv=none; b=IsNQf3qa87FSnC6F6uRNxwIvL59uWaIxjSsI7q9gqK6IfAEYxw4mLSgX5xTDrt8n4WOKemlO7lyfdpts2Seki/9Ehe1Btb8DXFeRSM8fwrKTdY/KNx1DpVStEW7i/dDnmyqoNBNpSqKLnX0WGMkRcY/5Z21MFuIpOtHu9r9w9rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723887785; c=relaxed/simple;
	bh=aw3OrjGPyOiGlZAT3FZ+bO0SCHYvTxv26JvXyJ2LBC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=izZe/DFaZcdGcg9XIUXZ6u3GO9+2wOcozPJuaCPwgBmomr+5b/C4e2sME128NFSB1S51Ru7ESRg9Up7XtAgmUB6tOy8HpRcAmzXmRJzMq/to+KeuFAZm66BceTypYgBT8fsSVTddSFxkyd2ShaMFoL01JbhU6DZSbdKLDX6SX7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d2ceca837so13570425ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 02:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723887783; x=1724492583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSD89904qpwLmfrxCcXP28eUr7NSxC1NZ5Fvz+p5mUQ=;
        b=soYk3bQqa4wBHtWOgnZUfAa6gdGKRnxliA7un6bFTdZJDLr6UxNfTmR+ad7TXtLCvd
         kMj9F/uPFnQhQkLzbR6mEJJJ4wQ5yfqBT/WA/YkzC+FvOcadlUIj0i09jRreWGB/f5sS
         XJHM6W1CuUOkBlgGjqWZr3jJ0hJ2yjD/lE8VdKId/rDV8Anam3NC4p8FLEMFXmVWPcAP
         NC4OPBpUv76AqFQy885tLNzI+q4BinX/BMljmqdbPXZ+OpFvzDmLzbfypmQvmvCFHlD7
         nAs2ij9fyORXE0ArYy/6+Ak7wPqKikyslamQjUyaw0kGyazjEklegC6PhzvarecizXbR
         pu2A==
X-Forwarded-Encrypted: i=1; AJvYcCU2tsC6NjMn2nWAECfPFp89/WeDixD9HuykGBDPgPCrkyfl3VD/MfeDlboio4ziB++BIKOcmZYMlSOdO3W5gMEdsbyaRLFWRC3kokmArw==
X-Gm-Message-State: AOJu0Yyszxb8Vx71BKM4Pol6LUdt0jDvuUjDGuiYV7szQFxA5wmmWISk
	MK5JdU5JFGUTVAmEXq/AbQFjIAU+duFM4/zHgkt+wVD6Ka5SpON1sIL8FCqpx4wuYt1PS8b7ewj
	FpYkySST5lWNB7E7vVFZJTrnoTkGYf+OwxrLm6+KQdEybzz4AdKjlDQk=
X-Google-Smtp-Source: AGHT+IFT5pwTzCVlFpLJPWYMEgMO9md978fZAAaZXpZ4i0Pwzf0awZHU6cX89B6NqA+XmRrh9qSadggyA41R0z6rKF7ETwZpbZsn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c04:b0:396:ec3b:df63 with SMTP id
 e9e14a558f8ab-39d26d84a29mr5013885ab.4.1723887782588; Sat, 17 Aug 2024
 02:43:02 -0700 (PDT)
Date: Sat, 17 Aug 2024 02:43:02 -0700
In-Reply-To: <00000000000093ea0d06142c361a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea066d061fdde62b@google.com>
Subject: Re: [syzbot] [fs] INFO: task hung in do_new_mount (2)
From: syzbot <syzbot+f59c2feaf7cb5988e877@syzkaller.appspotmail.com>
To: brauner@kernel.org, eadavis@qq.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sandeen@redhat.com, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ffe1b94d7464bef15b6585f9e7f8192cd0668327
Author: Eric Sandeen <sandeen@redhat.com>
Date:   Fri Jun 28 00:31:51 2024 +0000

    exfat: Convert to new uid/gid option parsing helpers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17cdae05980000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=f59c2feaf7cb5988e877
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1075d2c9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161012a5180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: exfat: Convert to new uid/gid option parsing helpers

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

