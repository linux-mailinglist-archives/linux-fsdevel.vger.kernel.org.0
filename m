Return-Path: <linux-fsdevel+bounces-12824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4916E8679B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 16:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5E31C2B1B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856F12F392;
	Mon, 26 Feb 2024 15:00:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFB912A15C
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959606; cv=none; b=Hmg2HOohoQaKf0djcnT5YlY3W8xq7CCGEP0A7NQG5X8yNJCzloXw3NJKyfaZt4XSAeeqUz3fxokgENaEGq48wx+gyFUl7Vngb35cfSqviwlQkPjyrcYSCDaGEUl9cuALe73ROi5QaitZBUcG/aqIS94EeofNXH+K5Mzhpgn3KWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959606; c=relaxed/simple;
	bh=eHf6DhQsK0KZCPXgcrcFLMEU4s/axWJphZkoUqovX0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rfsERAsWChIyW1gfWPfSTObxPzCyYsEOF71gRZDJt7FAYEjQ9dScpRKyqmjFXc6uXfkuHsBk2eoXaaKLA2bM8/WbV7hr25Iiz0BqbdIf1YXDQ918SG3pdAwtoiqQMMNCA/HGW7D4nxpT2OK2VAimXp8c5EsDCVqTG0nEXW2nND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36424431577so28267715ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 07:00:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708959604; x=1709564404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWnimLAcCCtkR0KSTmxlZv4XKOQ8UbGKnAa9ZHp8bn8=;
        b=MlrpdNaAgdFzReT/ZH6YofaDXe7GHTwCj4zZXlij4PHTYFI67iZEHe+wOsH5HvXON6
         3oDYKfHKSsL4mRe3Mz0ViFfUk2E55ZQE2vHSvTbzSz/x6gubl5E/y9pAcG65ZsXiVmDM
         A05/bUis/cuWICnUxYKZ4hzH/Xjlx8bXvYSEZlhfoT29l7mxRPBzjDVh26rBU1yrqERr
         +cAmW2MhZ/amnYkoGVGmdmfyy4yUx+BBndIhZwAZU8B83ptxV2CqHiQiRYoz9XHSNJAp
         bAT+iiHwb2uzJ2Kh+WmJvLLf2HFYgurGxolKIp6kyz1kyZqLjD/9FbWWI4cGrjJVeBIv
         3Opg==
X-Forwarded-Encrypted: i=1; AJvYcCXCU1lV1wg4jk7RL1Qk5P86ClgQZti+DbyuzpcKWam0eGmcP44TjBZtz06C4F15cvGt4m8tHrbqlgSXzLxU0LeMXTcAIg1TGpkOOyS0ig==
X-Gm-Message-State: AOJu0Ywo3sJE5aAR+Q6t+PFcPiSslxTcEtbtCJyjHK/o0UpzSRI79Edj
	g+HJkmxqygPhaQkrAiflS5S5xcgRoCdpj0eCF2aLaQXizZ0yjGWct0ALGY4JUMEeK2my3zvWjMP
	1/QwxKFIxItlcmj5iDAjlGRJOyBN8kp9nM/b/C9VGXcEgtEV5K4hKNeE=
X-Google-Smtp-Source: AGHT+IGzpCE2nfkAg7pqbTcBeh9cTuldlXFttxjcewZTsZ4GZdTghVX1twDE6ea2vwl4aPcyM9GMOXvl7BXzuKiAcjQlhh0h57no
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1562:b0:363:9d58:805b with SMTP id
 k2-20020a056e02156200b003639d58805bmr363419ilu.3.1708959604738; Mon, 26 Feb
 2024 07:00:04 -0800 (PST)
Date: Mon, 26 Feb 2024 07:00:04 -0800
In-Reply-To: <20240226120623.1464-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d120806124a2afe@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
From: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, boqun.feng@gmail.com, 
	hdanton@sina.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com

Tested on:

commit:         d206a76d Linux 6.8-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10dec3aa180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
dashboard link: https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163e9a9a180000

Note: testing is done by a robot and is best-effort only.

