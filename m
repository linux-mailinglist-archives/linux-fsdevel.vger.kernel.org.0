Return-Path: <linux-fsdevel+bounces-24164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C07A793AA0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 01:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653D31F22C03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 23:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FF3149C78;
	Tue, 23 Jul 2024 23:58:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804CA149C61
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721779085; cv=none; b=lbkpviZv6sZSl97zFGbRqmzhwkYpGF3sndIajAXfz4xaPBVsRcobQft45livb7RCScJVGhDpxRmBQArikJjnOWmJ+NZ+PFmfso/26p+uipmNSTC4NRSpTW9WOW/+5eFmTn8OBitrve/G5RF6/8/0GMdTPH4YUNICXf7BjejK3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721779085; c=relaxed/simple;
	bh=hjOYStjjoYX2np0BHeHR/g/Tp+auHJmuVRMt2T6GoEc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qq79yR6jvQsIa5jixPjbDa1FrroOGOh02Ji0LJK8Ty7pRGgmoQJK0f9aF3Eva4BEzd+ByVgpN1jg8VY78e4P8xQByIuupysL7GBrD4/NUYjhuxnWnBTHHuDUi7uzskDqhZobC6W2EKrFRRWjNzu82PozmIY6yuksoAbKinQ4hQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a143db6c4so12854485ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 16:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721779083; x=1722383883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgOyZUlzEMZOpU/YW1FXvWk4x0U9V9/l/E3qzG/wK8Q=;
        b=uOhEXWBHLCmDJDBh4K9UN+bAbZF3ja+h2ITW0Zjtfgu78HC0TAN4aoewQEPqBQ3QDt
         0htkGpwez5x2Xwvu/xf5Ref3b+WtA3Bnf8W5Xj/ar7DG1xMJK+AKElaEVwsqiAR0a+vg
         accyqwzXIWcTmFXMUrDqDbwZUV8QHO+GK0qQ4PaH78OBy+R+puN9ZKL5wc4FkGi7UOsz
         ATdoKcgGd3R1xUuX3752AByWFVKofUqFTvPCbGsf8y55xnar+RlPnLLbBkbe/tONpV0F
         /Gwb0BOPue2yiU6iPg2w0BBHyNsXzYUVVkXMakCu3HoqhHPMF9sPf5s/N65LKxSzMzi4
         PBgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQau2TZH0WxyPH+P9s/smkFtcS67O2CJOA5Z+vWM8U+k5J4MYqzUY05DtqtfGaP9wELCNqwgNRsKlzZGFbi6vD2OFTORxZeRYWXISgeQ==
X-Gm-Message-State: AOJu0Yy9KTJu7aE/yyyzl5yuqvgKcV9hzW4s7yWpNirAFNT3GmiuztJL
	9M6Drrk4IrSL9h3zrlVkLMxIKxUii/QkXT0NvpN0jZZGiwqeovKa+dJPznbvLqQ9129MMxGl1qI
	ZYuDugVTZSJczi2limmiVVopUtAxDKNy47P6n6c0dTDKNe0562uJy0FM=
X-Google-Smtp-Source: AGHT+IEzZornDDZMpWDzFdkE+q/FriUsjqZ+4sHmZEu/bJAB9hWGgnKawl2seZVupWtON8ikupSSpqqlgz3tPuyYT3PdwKwJZ6Lc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c6:b0:374:9a34:a16 with SMTP id
 e9e14a558f8ab-398e7de7b70mr8748705ab.5.1721779083711; Tue, 23 Jul 2024
 16:58:03 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:58:03 -0700
In-Reply-To: <0000000000007cfb2405febf9023@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aaa8dc061df2eef7@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel paging request in attr_data_read_resident
From: syzbot <syzbot+33a67f9990381cc8951c@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d4adc3980000
start commit:   b57b17e88bf5 Merge tag 'parisc-for-6.7-rc1-2' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=33a67f9990381cc8951c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12493e98e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1334b4a8e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

