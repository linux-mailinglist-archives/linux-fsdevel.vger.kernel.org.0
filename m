Return-Path: <linux-fsdevel+bounces-51663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1121DAD9BE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 11:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2728B189B361
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 09:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401381D5ADC;
	Sat, 14 Jun 2025 09:46:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC1DF42
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749894364; cv=none; b=ADF0BJagqZ4ea9ZkN1zebkp7apEx8eNWVfOTtm999EbYcA4tgA+tkA6bZbvgGekQtRp3lWElp8YOzNQfpXYYjrUJWCwstvIIDqo0gGJWwUQFwAqcu+BmCXrj83OGmckW0F0d7vKt4hIbkVtmmUfkt5QPdu9bnnFsY9JUAMkeX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749894364; c=relaxed/simple;
	bh=tb9mgmjJ0ev38mvO7oF2OEZBYaMFTRwRSfPnfq0Gfn4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jv+BRHTrt4TTs3yJiT5k1miG0hsUf2U5xpypzG5sKLGbogC40CJcFsGN1EQNKuUC0R+B2Yu0wUqNrbiRnCcSxW0oEbq3g8ZRaHgTMie+GPCO4CrDt8/AvOGMK86HO+LHM5guqyAG3hG28CdRqrQYQ+isZju8YU5oBG9A9t117WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddd045bb28so24329615ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 02:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749894362; x=1750499162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOullEj6fbTIFAODytKrgDERNVpRSjN594Q2Nd4pVdg=;
        b=WVoJsYOraGeSZscR+otki4Bw0f3Z4/GqEpQgLH5Df1BFhy8u4SElNmvl5EvWkzS1wl
         7AS7MKIVdF0LBXFkiPz43y3Wj9mopm+LZBiB2/plCFJNYzK9H4JFvgFeuY16TCttqaXd
         kf7bHp+a3P7sLx/vhJUBnT7Ykn7fYgg/fDxVRhmhUgIrhzQviiEZw4IliClrZcLfLLj1
         Z/zbCuBymhMmBnECYJBHF7Owkl1Bt9AbAVG3F4likqpobkGJcuUmKH3R4ZbJFnHXQfDi
         Qqs02IzlkDxaW5UfoxwQ5ePTuD9Cqc+GE3dual0SmQYcucvN9hr4iADHUrjan1RuAIt3
         VInA==
X-Forwarded-Encrypted: i=1; AJvYcCU8n6IloE+LFbPupEI3iDbS/t966cJU8KPhMwAT6/LdrxL1UjbcxUy/ADDgyUymiJt+UjbkwIZNIkLXwSr4@vger.kernel.org
X-Gm-Message-State: AOJu0YziJp4ktxyAVfy9NgqTYYCi0rBQDQUWqb1B7ikEJ5qJCfUEB6kz
	Dl7XpmW5QoAnZmQdpXWsihouxQ1u5P1r4Cmza8nfz4Fi5ucB8P6X2ggU1olZG91EcJvMwtRs62w
	qmORL2PMycXw10CWCtNVceh/tmqYZNCjTMKowC5sM2hu2/NBDT9FK9SIUW7M=
X-Google-Smtp-Source: AGHT+IEVUfA3mPXS3hA0DJoSSRV+Ghh9W3bYlbB4sUQ+RiorkpWaQkzcHee8EanONeMMSXpA5+N9R0E0c+PhDvzwN0h/7WUL0Klg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170b:b0:3dd:bfbc:2e84 with SMTP id
 e9e14a558f8ab-3de07cd17c6mr26890655ab.19.1749894362680; Sat, 14 Jun 2025
 02:46:02 -0700 (PDT)
Date: Sat, 14 Jun 2025 02:46:02 -0700
In-Reply-To: <684cb499.a00a0220.c6bd7.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684d44da.050a0220.be214.02b2.GAE@google.com>
Subject: Re: [syzbot] [iomap?] [erofs?] WARNING in iomap_iter (5)
From: syzbot <syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, eadavis@qq.com, 
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 1d191b4ca51d73699cb127386b95ac152af2b930
Author: Gao Xiang <hsiangkao@linux.alibaba.com>
Date:   Mon Mar 10 09:54:58 2025 +0000

    erofs: implement encoded extent metadata

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1352dd70580000
start commit:   02adc1490e6d Merge tag 'spi-fix-v6.16-rc1' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10d2dd70580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1752dd70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=162faeb2d1eaefb4
dashboard link: https://syzkaller.appspot.com/bug?extid=d8f000c609f05f52d9b5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115f9e0c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1688b10c580000

Reported-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

