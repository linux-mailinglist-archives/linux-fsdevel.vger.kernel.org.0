Return-Path: <linux-fsdevel+bounces-16885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291C18A4150
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 10:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4312820DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C9F225D6;
	Sun, 14 Apr 2024 08:41:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1C15E9B
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Apr 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713084066; cv=none; b=tVJ5VDH3Cu5oXhQbaozHMbJ9i+dYh8IgzwMOCG05F0jI9ZJpOtYN+5OdcgVMoNT7Hpuj8o17KI1qUcCzT8BNcH7HOPQ3eJt0F5zqCV/STgMU01sc5PzlbKaWnCnqgYGD4Kk6Q/oXvAmQYbqRjxGVGdgIMF0LtNI+y17gGyrpfuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713084066; c=relaxed/simple;
	bh=dZAnNFSFXpH82xQIjtfXvnRg328Zk2sD5+LoAz3HECw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n9x8Owl9+razpuNZqN7TIntCtGASjoD1M5bcHoqi3ZdrWXGi5PK/WbwffTH3GcmETnH+QVEteui/XJEwXalwxleh3hnXVByMsUMt2g9HDsVsosLioHhUE7ib8HIzasIjsoNZeY1wBKeYX8aKYzDz3Vc4NlpYFCvedWW4fNuzrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d6bf30c9e3so182455339f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Apr 2024 01:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713084064; x=1713688864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rLBkUcPmuLzb3F8ivPr5HzBIa58niQNYwzeMWHMDr4=;
        b=rEIYtAYs1uGixfBUXMXAPI0VXsck8KP0MhxJmbPaTKRYRS+sxDyhCZ4wi/BvAE+haC
         G73ZyjBVTT4oyNPfGlZ4YWdow6qEE9M+aWshrV/VVE33hOTD6Issyo3Qg7AlBwXWxUOz
         k/467+ALfp6VUKVxtINeJ24N45jy0mhm0qdpJ/AQIhP2v3Hv+oqoOsfb1eAwrZ9ZLt/n
         dxBgyIKsLfA+0gW4szojFWPr02w716d+i271K+3lC80o5CmchRQfbNixCc5RWo1e7crU
         OyzdJYuQl+rCF24FKyDqI76L7XxiJZyAo2V3SLNlo4YkYuxzhX7cK2ktaGOEQJH78iDP
         EzjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4mKZ8f0fDL/9xUheMHYNW0B0MhfIxRCYWzZZ6x7+y1iDcM1/GJCILR7+siPz57U//XFkk+Rb8z8dsDg29b4cQkjD3MBAUy83vmtp+2Q==
X-Gm-Message-State: AOJu0YwjE/o3wYR+sYBp+UvL1JyqcgHBc2s+2ZE66jpvJQVpvVQEqGoh
	FKW4QmHgmi6nwqZT2FWS2Ajl7fxDBfe55F4tGWd+iMzQ/6k7e5sJru231KIETtVz591ngyYJkD9
	OLk7yWwGm7wQR++xHGsMZfcvefl2rZUESOTjId8uEX+2SVqCEgQoUHe8=
X-Google-Smtp-Source: AGHT+IGY7ePPYppgtdO3jmP9A+EE39pQbXeoHylEBaXuVHNz7j0jnXeYz7Rdw489ll2vV7cDrFRmcDCoGjq9frsx5BdPhmNy8v5Y
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:36a:3dda:d71c with SMTP id
 g5-20020a056e02198500b0036a3ddad71cmr508822ilf.5.1713084063013; Sun, 14 Apr
 2024 01:41:03 -0700 (PDT)
Date: Sun, 14 Apr 2024 01:41:02 -0700
In-Reply-To: <0000000000000946cf05f34e12c2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bef2806160a776f@google.com>
Subject: Re: [syzbot] [btrfs?] INFO: task hung in lock_extent
From: syzbot <syzbot+eaa05fbc7563874b7ad2@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, fdmanana@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit b0ad381fa7690244802aed119b478b4bdafc31dd
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon Feb 12 16:56:02 2024 +0000

    btrfs: fix deadlock with fiemap and extent locking

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101316f5180000
start commit:   7521f258ea30 Merge tag 'mm-hotfixes-stable-2024-02-10-11-1..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=89a5d896b14c4565
dashboard link: https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c0d1e0180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10aff5b8180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: fix deadlock with fiemap and extent locking

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

