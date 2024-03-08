Return-Path: <linux-fsdevel+bounces-14005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD67D876716
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 16:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79721280D81
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C0C1DDFC;
	Fri,  8 Mar 2024 15:12:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867711CD20
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910725; cv=none; b=lR4zkt6h9ofqs4/T5PReXaHFUdDF5t50YpDjBlmD7D5NU4MrtxQiCIZm079EjUuNoT3AtsO2xgLL0RYR8heT2kdi5szXP3WteLvIDFAyylueGpH82Z0jLo+R/KQB7cQALiCZQcgVCgjFtTmX/tCToiRGYsPxNbLI01lp01TDFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910725; c=relaxed/simple;
	bh=DYAoAYTOqZYFMlCTKHIXEKT7ltBnivpJ4fyeB7NO654=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lmfOT/r77+14lZ542rABqoIlePvbtQ4Y1Lm3z8D97ramoY65wsODQx+hicubvj3/6koldxW5Z1UwQT6naKjRQqvezVFby6ncnaU4dwS301NdOB+VmKH7Ufo22Pbs4kKJnkRe3tnAqkHSehGk5sYf2fneIBoAGcBme5aU9vFB2hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c8440b33b6so237211039f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 07:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709910724; x=1710515524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Taovf/w69oNFiPGLpF9FT70ngJrHA3KTAKar3z8sSg0=;
        b=LyR9i4bLUwy5vOQXR2Je2U/nDeXHujdubk2CUwciHTOhX1RIGqQhhTGRI/cX708Sgk
         GWMp+Lpi1hZFHcDNfV/7TTyn2Krgrhg/w+ZpU5XqoVREIwbOcu9zDXz3ZGwWpr3crb6q
         lx13sB12VNhKsU/5teJpu54YE8K9t+6CG1fafOtadp/oZEsyLtEFIsiHWlB+Fmauplp6
         6qwcFO7h9lWaunbVwwGS02Q7suLUUcaPT5QoPRdyToUDtck4gfnj0QJvjU6aesmvRhWO
         vmAq/nU2/3OpHB8pqdGxcQYVDiA2vtpaXz1zXUD4TOQuwAxlUqAu1S4GnR7S/s8BjLUt
         7Ejw==
X-Forwarded-Encrypted: i=1; AJvYcCUpUBXAfBRCePUO6qdxFfobNchzpZ6t8pvvA28ne/04ys9F7LqYS3LRZ2S/xEstLl2tJ/E/oTjDWZw4s2z2UGkP6mzou3c10yNIXQDNmw==
X-Gm-Message-State: AOJu0YxC73+YibfZ1fp1DhnOtnWjbxQZkEntwiIgpLzT3HzAJBohthRE
	a0MjAOOosZljEjr+W+t0sg/OlFCyY7TJPuIQIlAnB/nRwKD2CmnQRZ40Qdnk1FyQfeo+kIN4WdB
	oete36ssKdo0+dVs0CYa43h2/7Cqm3aP651WzMY0X9VLe2+EHybjOhdU=
X-Google-Smtp-Source: AGHT+IG73ul8oOb0FFH3FS2TkTIFxExRvyqFpcYXqkv30X1WbTe3AL+1s0Ho0RuJAAYn6qomXwemT5tcLG7lhpG7Y627Eu6puH8V
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15c9:b0:7c8:38af:c0de with SMTP id
 f9-20020a05660215c900b007c838afc0demr884589iow.2.1709910723885; Fri, 08 Mar
 2024 07:12:03 -0800 (PST)
Date: Fri, 08 Mar 2024 07:12:03 -0800
In-Reply-To: <0000000000009fea9505f134bf4d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b90e20613279d9d@google.com>
Subject: Re: [syzbot] [reiserfs?] general protection fault in direct2indirect
From: syzbot <syzbot+e69a9406662c63f12e24@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103df92e180000
start commit:   3b517966c561 Merge tag 'dma-mapping-6.6-2023-09-30' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=12da82ece7bf46f9
dashboard link: https://syzkaller.appspot.com/bug?extid=e69a9406662c63f12e24
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14250026680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b792d6680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

