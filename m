Return-Path: <linux-fsdevel+bounces-68189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D1AC56A43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 10:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0C43BA29A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 09:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A3C314A86;
	Thu, 13 Nov 2025 09:33:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE62DF154
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026386; cv=none; b=KFcCpswweqTjKmqRSjYk8qhwdI/A4xZP90daEu4RJjmwRX4TiR9qgYa/99Iu/XJ/iYO/a/vMuD+BELp/E9UMejgUk2GUQjpWG9fMH/RuI11ggPrr2FvKSqvXfDZVqDhky1aKMsQ4g2uYgKZvalVN7nCPXUao9mpmjXfYqJjdGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026386; c=relaxed/simple;
	bh=i/gJ9OdcSlL2P2pnDCmw1Iju5BSX0Wns1jv1nn8Sn1k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XtZIJfnXHChDdmIviuodT7BK5IcUL/L7GUb0Ar3jaGzH2Fc7dnyFwK/71SK0krsmdrMe8TeemoV8gL9OHZlgAR5MeUviAa+5gUiLzfu8UTazadNEWwr1lMb8JRsWjHIVqbhid9Pdl/jxw3sl0sghSmU1u7wWyrpHd1jvyWT00ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8870219dce3so84874639f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 01:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026384; x=1763631184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnQbfy3BP7tZ5yQYDmEOKUZd+jMnHCYAe2SJPFPgL10=;
        b=sV7lm2MrSdD7cYAQOX/F8skNoUk7+2SrTVqPgoo7AenKyxSSHiTnLze/WRGqosuNVW
         J/tsyJfMp4yMu5+LuoFlV+NB4YXAlaPo43eWM3k0J8nVsb8a4NlKcmPb+30/ZwqaFYDC
         lNRF36PUwFABbxngY7b2qNwty4lCXj+ee37HGO6zgnkrjOLnanS6QTvDR1qx0zyIgapo
         +Y4RtwTUoEq9xZqFXDLpQjn9sugaCXxsnbh/gippaXvdooF0dijzNDRZ828PdS6nUKq2
         pDFGaW4DN3nczjaj0/1hTi8t2gxOQBzXrI1aCbF74pnCwf8ekusMogCcGKbldwkjCYzO
         YbmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM95qVIWyrtWOm5ngNB8HIkw0DJrocX7g8/L180FSMud4sEtW1eWTp4VjsjvEx21vbZdHaCHaZigUtvo6D@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLc+06OBKzr+i1f9RDtgv2yjGoAzVAjjno9YrJZ7dFcVZz5ad
	SFqhPwrL3UAXFath9hWAjT5Sir7Ctv2AVqKjVVgbqpaqWh/860UzWUILpMFsgWDtcQk/4MQzvFb
	OSBQE9QCfRa89Dz+FrbGdxXRkU+CSHGxqfbOxFTmgSjMP7swlyHPj3hZXBnA=
X-Google-Smtp-Source: AGHT+IFx/ByR1aVdOKGyVe9jmEMOK9B8X6NWIRr5k9C2ynZaFrg1uVQjjbQrjKW99Za+5V9uS/2k2Fp8j5W5mOS9Ph0LCj+ruzEI
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c1a:b0:948:a115:db85 with SMTP id
 ca18e2360f4ac-948c4561832mr789905739f.2.1763026384162; Thu, 13 Nov 2025
 01:33:04 -0800 (PST)
Date: Thu, 13 Nov 2025 01:33:04 -0800
In-Reply-To: <67886ff3.050a0220.20d369.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6915a5d0.050a0220.3565dc.0023.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_retry_writes
From: syzbot <syzbot+666a9cb4c41986207cdf@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, dhowells@redhat.com, ericvh@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, m@maowtm.org, 
	netfs@lists.linux.dev, pc@manguebit.org, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 290434474c332a2ba9c8499fe699c7f2e1153280
Author: Tingmao Wang <m@maowtm.org>
Date:   Sun Apr 6 16:18:42 2025 +0000

    fs/9p: Refresh metadata in d_revalidate for uncached mode too

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15831c12580000
start commit:   a2e94e80790b Merge tag 'block-6.17-20250822' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=666a9cb4c41986207cdf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137d5062580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e33fa2580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/9p: Refresh metadata in d_revalidate for uncached mode too

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

