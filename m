Return-Path: <linux-fsdevel+bounces-20964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F8D8FB797
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 17:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64A4281FA0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E5144303;
	Tue,  4 Jun 2024 15:40:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA4BE4A
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515606; cv=none; b=J3jXmTs56NijgERukZ17YXmk729LO0zzCfcW1RTo+ja8/A3IGf8xSc4QtWOdaTjhLdHQg/WqOvtBC958PcQiPi1Jfv4CjsX5fXDYFK/Yd7L8lkiW54JK39kPZ9k6aQ86mUa5g92O9gnScYqxMszGrkQbVuhsUdbNhleRN6I4fCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515606; c=relaxed/simple;
	bh=IYrpEI9ESUXgfrd6PmmnBS91BTgpJHWgWPbCxOv4sfg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j0KWmyVNnbVFDjGMUKqB03xrCvIkOPdxwuA7nqTK/9vr9Mw7LJHEn55tI27UWMMMbk/9/pcxENBhS2d/KuiQFgBWuz0qcacahWigDw2tK+rCEEn4hgzij0iXy+lea4syhDqnYXRiwWpa2BgeML+xF+OaH4m1Z3hYTA90hgkVrHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-37481e2793eso43083535ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 08:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717515604; x=1718120404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUyz+L4QW1yPiCkGSSsrehPuI4CGB6TTCD6NGaUJQcs=;
        b=H2fHbAR+KBcdzleSgLxg/vfeB6IAo76LD6xsYYDESFf09p9p/Rl0NsWuCbbDyuIQ4w
         z7V4g00Zi7PTLgNF7PG4X89yLxD+bB4ot/Y3WI45AsR39/Eh9nt/aeFIIucCyV6R4jas
         1BuRjrsnoYZ5c/rBgpdKTo66ufgoV1pn+K8M0U4hzNzUmPglg9uzq43hbsFJm2qVMxIW
         0MyUok9lRq04J/LM+FTsi0y4ocSIZ7syDnpjE0LK4/NivKgxhi4JZ4tYDm4I7fnVrEJq
         L8++vIvvig9oUMdB78qfR8sQMymjzNYZC+9Xm6Y9LuDzNcHPlP/0uw+epH7AfmvMEpAc
         QCeA==
X-Forwarded-Encrypted: i=1; AJvYcCW6gfy9e9BEUDUd/TKLpoyXzyLP+wtom3WD1n2dblXufjSs2bb00wQOYEU2vmBWBQ1P4q9uPIFIXDoYBti2LlD1iiWgpJ57/sDYPrJ5uQ==
X-Gm-Message-State: AOJu0YyG9sdQDyU7GoBZpuonNyBybUiqowcIHZaNp+e4O2kaozcMUdXg
	qDknbrUeaEd6xmPdhU9vFLQS+1oa5QP9pi0RheY7o2neRMwGHtASnTP5sGCvPhzZ0LoSgpDQgDn
	muC+oLJHXjhbrjS8ATbmmh87NNbqoqFnAE49GybjOENpwkQe4ahvi5TA=
X-Google-Smtp-Source: AGHT+IFGhGxQk2d4VPpAMbOpbT3fHBYBgC5cRPRwhnU2rdKJrsLua3NcjPW+ofZYIToEnVAlPsVSGeQJSptZd9DrNQqZdq1fO/Ps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e1:b0:374:9305:62be with SMTP id
 e9e14a558f8ab-374a850a1fcmr1743585ab.2.1717515604014; Tue, 04 Jun 2024
 08:40:04 -0700 (PDT)
Date: Tue, 04 Jun 2024 08:40:04 -0700
In-Reply-To: <08cf0523-b70f-422b-8125-884ddc21d1ea@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079499e061a12436f@google.com>
Subject: Re: [syzbot] [f2fs?] INFO: task hung in f2fs_balance_fs
From: syzbot <syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com

Tested on:

commit:         4d419837 f2fs: fix to don't dirty inode for readonly f..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=117f66f6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db568e553e0f3797
dashboard link: https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

