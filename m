Return-Path: <linux-fsdevel+bounces-7899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0CD82C8B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 02:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7BF1C22BCE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 01:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41C315AF5;
	Sat, 13 Jan 2024 01:28:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FED12E64
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jan 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36089faa032so50626455ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 17:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705109284; x=1705714084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yO/xdw8mUiUeRo79DAK0wxdvi30bQpvVBNatj0IZ9bQ=;
        b=oFaDk0E5Ptra48x1ttzFjWF+1Hlytx5DIOpoSCPCH/7aUKnAk4vN7zjk9naBJk/kAc
         b62/ZVvtxT9CwkzvySKNQIxrDV0DxrsHHs0CTdepdkehGJURAvm2V4LlRULrau0XCkC2
         0BQQAmGbId5aeltl7WxC6uhMumvh/OGsH20siiCokdMclchN7Rq3s+vvMy4MXD1ttJu7
         HnDzRTAuuP7rbgY2P5bs0Ny/qrBMrzA4whQ9gVNnml1dNbL4uIiy/Ykfm3WCNITA+cis
         gZPUYmljWG7qoO/dLUEJQZj/3kEr/kr/0gKvWoHjlfcYnohPauJOzff9vaLnxu9kafww
         BfUQ==
X-Gm-Message-State: AOJu0YxD/Rxr8kstRHxinUyzxLF6zODrjHRntHwWm5JdocEjOkhZnsaY
	tc1QrqOW84/Qehukq6YubyEG3S7ffsC69i8rQS5Y35SXAjGw
X-Google-Smtp-Source: AGHT+IGcMUlOs/Tzd0+a1Uuk+acyfi90LBsot4shAq3B70+iVAprve0XWavepzODdBa0BESDLdRg+h02+m2jOZGlDkT26zifC63/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:35f:d5ea:8a86 with SMTP id
 s7-20020a056e021a0700b0035fd5ea8a86mr194343ild.5.1705109284375; Fri, 12 Jan
 2024 17:28:04 -0800 (PST)
Date: Fri, 12 Jan 2024 17:28:04 -0800
In-Reply-To: <0000000000009e798305fe8e95ac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032d485060ec9b172@google.com>
Subject: Re: [syzbot] [jfs?] kernel BUG in txEnd
From: syzbot <syzbot+3699edf4da1e736b317b@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1280b62be80000
start commit:   692b7dc87ca6 Merge tag 'hyperv-fixes-signed-20230619' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
dashboard link: https://syzkaller.appspot.com/bug?extid=3699edf4da1e736b317b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b373a7280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1749e8f3280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

