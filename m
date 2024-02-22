Return-Path: <linux-fsdevel+bounces-12496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCFE85FE3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 17:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3404B2374B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 16:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656C15351D;
	Thu, 22 Feb 2024 16:41:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98431150993
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620065; cv=none; b=RMrod06AZAfM7RyvV7uUi7aYFoIGHGCBNRt5MwhIIvlMjkUfCWY/hS71Xpat1WKBBS4KdoL3LkiEez4nukPBWInBZG1n4e75BgTMnx2DGXQ99e1MYJ8JNGd2Mu7T+vPiUFZnLEM+Tkwc/I5T3/zyjjRQFBZyCJuLTbuheqkqeh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620065; c=relaxed/simple;
	bh=h0qkg4ybl7Go+iMCC/iSGyWd+Gh2Kh3DWutLW4fCA1U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oEwqcHFNvxwxossRo5nzT7CnOUGIaP1ghDt7NKCcxhUpkpczR8z8jh6O6CZcKYR/mhZL6GHzAM+UaU7dDHKWtFw/3zZfWTNY5rIlI3alt3UkmkxLnQIz/khVq1ifUT0OVIhC4YYlzFNjXq/sHHh0TGlk4Yb0KMUUiGBHqZ834Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3651d2b88aeso27699755ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 08:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620062; x=1709224862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ5aqp9fdqY7o36k7fIAo7ucu2og5S19dbPdW4xD16g=;
        b=Pz9gq2dJ/nuwzBXjfAJWTB1DkDrVzcnffRTgefFn5Vb/MfjHYGSx79I4CH3q+Y1GX2
         yQPcEVOXaEW0ZauGGBZjJriYGls+9MdlTlvaW/JIcTtpS9z2M3ZA/n6GAH25KcJa0Tbz
         JpWfYOzN6DL+kI6vpv1dYs0CpNhXiB8dDs/FNurCysbq+/KAc+RiFq3WzxmsKB/nC/vu
         UOLKOWxp3o0BkgUzrumKUROAjune930BSpcJF2vrqCE3QI1qSS+nBaBOTTukQ8stBO59
         xaZYCnsOE6M0iNye/jrZCKI01rsQ6ajn6x1Ed0OyQqjoywXvD3fMuAdglWgNfJCD5Idy
         d/zg==
X-Forwarded-Encrypted: i=1; AJvYcCXr+a2QQFJi3PdW4IT1N5EU7139jUv9qK8GF6m+mX3mqZ/a4bwclpSaUxJ1rjRZyme8yzGtVUCNBRZ0rUrVKRMm8WHZfFwjSjjQV5DASA==
X-Gm-Message-State: AOJu0Yzj29mGwZdmI7oSUdQ6A4osPV4GAr2lXHNSJA0kIdvHV8YS3JF+
	tjaV7vWz7w9NjpPl35s78MDB13ksj+bPbn3/Vgf4rwUB8ek5V6AFImqmUjRYLh+uEkEIVWiKF1c
	rDjrZ+PhN7vMt8wVPrRYwhmBa2iSGL1GZsseFeJpOIbSIR0+e1CmEBkA=
X-Google-Smtp-Source: AGHT+IERfkQLLE1RjmqYWtZVQ/b0Z/t1fbVmJvDFARmZmYdz08jGgp/RbcQ9MJCC4ZNoa86l5tdCtIZkeRqBGdknpyso18exPKPE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:9252:ed47 with SMTP id
 j15-20020a056e02154f00b003639252ed47mr1821068ilu.1.1708620062699; Thu, 22 Feb
 2024 08:41:02 -0800 (PST)
Date: Thu, 22 Feb 2024 08:41:02 -0800
In-Reply-To: <00000000000034d16305e50acc8d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4b9c60611fb1be8@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: null-ptr-deref Read in do_journal_end (2)
From: syzbot <syzbot+845cd8e5c47f2a125683@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	bvanassche@acm.org, damien.lemoal@opensource.wdc.com, ghandatmanas@gmail.com, 
	jack@suse.cz, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neilb@suse.de, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com, 
	willy@infradead.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f6c4b4180000
start commit:   69b41ac87e4a Merge tag 'for-6.2-rc2-tag' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=845cd8e5c47f2a125683
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f68684480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142a1eaa480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

