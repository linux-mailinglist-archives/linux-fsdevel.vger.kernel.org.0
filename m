Return-Path: <linux-fsdevel+bounces-39240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AC2A11C2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABAE18885BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 08:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471BF1E7C1A;
	Wed, 15 Jan 2025 08:39:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F021DB154
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930344; cv=none; b=Mh1LVFrVL/t9bX2Fm/smZ6pJGfqGLjJaGSHo2+6uxf/kRjvPSuiV3/KTC2FzHwbkYHtpbfDA2NrDgOrQ4Qag6R5f72PcKsktVQ2lDWwQCGOVR6qRo11FXwwah3hFeeS0y4HMYVbzZ4/y+dLFfskUwDGHZoIhrXxFJGb+cwmwW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930344; c=relaxed/simple;
	bh=Y24pZPuFwPFR1VZHcEMQpqo7yKBdVDnnPlgKCXjs+iY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kW8bXUyWvN+0QRLEaw7LyEZu2PvBqfUamU3sMQbBLUKFJi96BGRSS5FqLfcYw85zU7FkGeAC5n1dppEGlD6C9wMPbGwsFD8wOLqZbp04Ryu6sOPaFoyxtUiJ01VteqUzr+uED1vBdM915sqkN6Q9NYYh1GAmAFiKiiGm03gv6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce795254afso32658805ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 00:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736930342; x=1737535142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta5z2IK+7I07RU1ai/knZKO94BiSdaHRFL5TZfBCeEQ=;
        b=fRh9EQ290EFztEe7NXPHlUDC9TrL2Ii1LMG/1JCbCsDxEUTPtty1Ob0OwR03sS1Icl
         mIuoKAWTQNYMqeEw73FE7ATFl6wAlvxDkeLwda7l6r2qOrB5ezQuTixIxrgyil8uIcSK
         1DwxmkOBKjfnbqiKKxAv0b3RRIMW5FcVQvpmPGPq4Hrldy5mhKplnWrdiwUlXbpb8tu3
         pBr7hQIlpH4KhFgMquDjuM9ech1PKt3QZ74QPQxpp4Y7qvTfEtFzHBN1ZjGivtUkZqeC
         qVHBS9Yf7Sbv/eH+kGJ0/NL8PaBgIi11cSNgHexNglKD3wqEPLIFTgIxjVOcU/xN4rHh
         HiMg==
X-Forwarded-Encrypted: i=1; AJvYcCX3vK2r6Hck+PcSG67i1IDrrO8ztdUTONcusjie4r2WAr5997iaP2Icf2SGlyULssEEL5xw6UT1nmBbHvYV@vger.kernel.org
X-Gm-Message-State: AOJu0YyqqEdemz6amKa8qwYSQYdpSOMlrGrRA0pOT+56XpkmvM9CrsEp
	fXzk0MdTf9EF0k+74ud5eTSOxzy11bcF1YvWHK4eRciOplnUjZA/aWygeL3AfUCsF+4PPy//S6o
	U2Wt9QqZTtHLhedYkX33ZCM0ds3pTz13/2r7uIk9KN/IhzHPHXrds4yo=
X-Google-Smtp-Source: AGHT+IGBUSwrbDRmXtiHaqIZSAmvQ3odCW/shzY20iSKtiAv92ooamYnIFaosuQJLlCINwHHbzf8lnxHnEoj9TfCiaVFm7wp6750
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c9c6:0:b0:3ce:64a4:4c32 with SMTP id
 e9e14a558f8ab-3ce64a44d95mr102162105ab.3.1736930342600; Wed, 15 Jan 2025
 00:39:02 -0800 (PST)
Date: Wed, 15 Jan 2025 00:39:02 -0800
In-Reply-To: <6712465a.050a0220.1e4b4d.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67877426.050a0220.20d369.0009.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] INFO: rcu detected stall in sys_readlink (5)
From: syzbot <syzbot+23e14ec82f3c8692eaa9@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, davem@davemloft.net, frederic@kernel.org, 
	gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124487c4580000
start commit:   7dc8f809b87d Merge tag 'linux-can-next-for-6.14-20250110' ..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=114487c4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=164487c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28dc37e0ec0dfc41
dashboard link: https://syzkaller.appspot.com/bug?extid=23e14ec82f3c8692eaa9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1634f218580000

Reported-by: syzbot+23e14ec82f3c8692eaa9@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

