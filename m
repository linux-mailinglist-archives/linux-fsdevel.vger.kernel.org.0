Return-Path: <linux-fsdevel+bounces-13139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C7486BC09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 00:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF70282EBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 23:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7258A2575E;
	Wed, 28 Feb 2024 23:16:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9499413D300
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162167; cv=none; b=LgYospJGYcE4JHG6SymUFI4ioSO/80G1tOZlL6g26urgVCzRx9Duljnv/G5AbyR1HY2h4plnRWOk3jSUSd40bUoTwOPt3CItT2kPH9UJlW9lY8WMVaZpjh6owUMeObiVPki9BJMtprq24ML9h1ARXSY2yuxNIUyI5Erpd/aTJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162167; c=relaxed/simple;
	bh=AQUahNxliBRnxzbiLyFJhAv8zSnsPgpBvtR8vmHjVTI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tnEsCH+QNpx5zt9uCg5inZ001lMOwtb9HH383s4roS1i0Vmft1wjJBq03s080nOaqpO0XvandZxGw5AF/nVxNCnISLLkwflO9KipiOZ/0fkxkmH3qDhxakEawojGGfSLw3dCKEFPdcfOvNLy5FvL+jxu28APs6G2GIzNr/1ImIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7c4065282so32180739f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 15:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162165; x=1709766965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0RlstvxprlM4gkYbdJ5NUP8ntmVKrjAxjshVbrRXSc=;
        b=Ky0svCbt7L7ayM9Z4/07y83NKTXf61SX5ceAFzhs33IvYyVjQSscvaNCzmFjsM/Nj6
         uxYj48FzqMQ39juYm1uJLlK2y03QDfKvMgcShH/kuKkCPkvlu6+tMcDLEt7XFgmpLmLH
         cHqqMpGAs1c3L7JuqILdhPdJpWts4A3CB0geeeLp40z6bWcS8j1RoIuIrwQVsQTB2wf1
         T6Jd1SYl4QIuFjftPF7Jl5MRKERHWMFkXPt5A0ckPASaZzkZmt0C/hfubTYMucVhMryc
         vLfCC1ICReAGWLqSgJ8om9qp9xq/7K728igO6M5J6WucmEZE7AR4y+uuuu9q5CwQF5+B
         Yo7g==
X-Forwarded-Encrypted: i=1; AJvYcCW7n1nNsZE8aDFB8mL20B3RNm6aLmfhmoI2Cd3th/whHamOmulTbvVxDE3/DlJKnVZm81xPJ6lVvknJ58o/YeL7OTcS70Ls1hcXSKm5VA==
X-Gm-Message-State: AOJu0YzW8XPerlyrnTlxYn7SYzyc8FmMzbCuk3bNilqxNR5RViB95y7q
	65q19oE67mxqYjU6HvMGW7Roby13Af5dZM4Ahf2PNr8B3lyDS+gXEOXB6LeUYb9WfGT5+sJ6OWP
	QvZeligD0CO0lsm9tZ58UyDumcL2NDztHM/arMzl7ZJN//7ruk9qmXAk=
X-Google-Smtp-Source: AGHT+IFji+gWg2pA+eUmcqqi3S63tv894XUzwmU+L6rl/SIS/OebR1zkMrOwnEALjAYt6aL4+TwLBuzpQRHW46MxBHfiWMdCbk8l
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20eb:b0:365:25a2:18ab with SMTP id
 q11-20020a056e0220eb00b0036525a218abmr36292ilv.3.1709162164779; Wed, 28 Feb
 2024 15:16:04 -0800 (PST)
Date: Wed, 28 Feb 2024 15:16:04 -0800
In-Reply-To: <00000000000095141106008bf0b5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2059906127953c9@google.com>
Subject: Re: [syzbot] [ext4?] [reiserfs?] kernel BUG in __phys_addr (2)
From: syzbot <syzbot+daa1128e28d3c3961cb2@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, bp@alien8.de, 
	brauner@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com, jack@suse.com, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tytso@mit.edu, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1010d154180000
start commit:   95c8a35f1c01 Merge tag 'mm-hotfixes-stable-2024-01-05-11-3..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=247b5a935d307ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=daa1128e28d3c3961cb2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14562761e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1089280ee80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

