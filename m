Return-Path: <linux-fsdevel+bounces-38465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C94A02F38
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00D518872BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CDE1DF26F;
	Mon,  6 Jan 2025 17:42:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BFE18A6AC
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185328; cv=none; b=Mi4kfrHVAinx0HoHPqjPIXUljiFxyTiUSDX4Jr5MPf2oU9t80eNGFl+aKN5Rqitiq2FMlPAGO0Ui5navHzLMdfhn9IhPLcSF3XpGF+VOHmMEmDOj11G+ByJ69atB90UJoh8ccJ6n+mYwGPMCqp8uAKnsca2rVyZ4Yw5CZIReSfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185328; c=relaxed/simple;
	bh=qDoZS3NKdSeE+nCo/Q27/As6lKC0AXdtcZdMKhSej3Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hEyK3TR8I0/oio/l1AJVRZJTJpdUypFlvhC89dJBJrrPPzWzm83xDDq3PanCpS8osMqB0UZjCdrNk3V8Alqb7ST3nonkGx7IFtG0gT6WAjEaT6vcNLjKjpW0rNUofGhm5yQsSD7R/jstrZ7nElUe/afgzBR2M1jNVqM+KAbF06I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a81357cdc7so142959915ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 09:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736185325; x=1736790125;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNENMpa70ZFUxpC/qH5uyHnJyYbgF2N+67wGvKH0tJY=;
        b=f6gGjet4gQA042eohiW76ogCOPyPbIOucDGfOxr78j/97akb+cXZz79F+Aafo1vIWM
         B+U8V5MIe8eOyLOozJ1ATKjHdtmh7jUq5tH+f8yINHAzYXKVqPSIHtoakqbXsoQOl+2W
         jz8FZTqtfHrmkJ2kRcIiNqcunGFiB2rAffD9Ujw0bHempvRU62UwkcMXdbYfWTdiv7pH
         g9KUsbNeMFEEGiF5T8ev0ynz/TFHx/JqFgzE/hD6+4nAb/FtT3j9vxMtCcOXdGZx/1AR
         3KGYLYrFwHKtJr14HMrXozhkTayxC/nxi/FxTaOeLAlf7N2J9FFoJtIsM/vmJeUENUJw
         eWhg==
X-Forwarded-Encrypted: i=1; AJvYcCUa3RL0C9utz55XO5zfvhovw9FZHecaLVVfaumZhwlEz2AH7ajpkpwM7eBT8Y+90hBINqeCj6QBBD5o4Zh8@vger.kernel.org
X-Gm-Message-State: AOJu0YymcTU4smjFQ3t63gtpMGbRdy4APbiQrGjJI7JMQqdh86Dl4Y33
	6GRHVRiwATtYd7YjTLXqgmZmOImsKRfwXwTpY9fQvlkl8C4cJqtr1bW/iBrVqS3Yzh1IiSnzbtX
	CXnz7tz32aamyuMOV1ZuaEcB2pOWmKSYebnGubPdGviH/cYlwVz3tvLY=
X-Google-Smtp-Source: AGHT+IH2sA1PHDte7MnFAI5UDFyl6+57MyFTp+jr53IHp24CXdnaVcc7eiEp40FSRBdicfxfzHzbowsbHGx/11z9/QdsFQIlNKjo
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1808:b0:3a7:e956:13fc with SMTP id
 e9e14a558f8ab-3ce31d3c1c3mr1609715ab.5.1736185325499; Mon, 06 Jan 2025
 09:42:05 -0800 (PST)
Date: Mon, 06 Jan 2025 09:42:05 -0800
In-Reply-To: <CAJnrk1ZC4orWTbJAKVuDwmRCRRN-WSM6xpcNiGW48P55nD3r+Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677c15ed.050a0220.3b3668.0016.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com
Tested-by: syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com

Tested on:

commit:         78f2560f fuse: Set *nbytesp=0 in fuse_get_user_pages o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16eeb418580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0669984e46cc674
dashboard link: https://syzkaller.appspot.com/bug?extid=2625ce08c2659fb9961a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

