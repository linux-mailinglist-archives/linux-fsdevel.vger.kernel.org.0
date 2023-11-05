Return-Path: <linux-fsdevel+bounces-1981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FF37E12A6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 09:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A35FB20E32
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA8F8833;
	Sun,  5 Nov 2023 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27020FE
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 08:40:05 +0000 (UTC)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE57EE
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 01:40:04 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b2e7ae47d1so5333881b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Nov 2023 01:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699173604; x=1699778404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubi1y/nFwBKOxlg1T1iV5JNUkHex1InrNIEt964xeT4=;
        b=YNd1zLeXyFYg1hFCyMHIC5QADMSXuTYrX2BKKsl8p9lRStZgVcYEQOucH9CIoysDF7
         w/rG8hOkz/KdWPT2RmS4LTLgmanITCQrvBE7x6nFwl6nFGuEN/II4e1QK92FM1uI5Qet
         3bKGBPvvQrA7uumcn/wJQXEGky7TG9t73apukJHap9ANmfFqNhuWb32yIR1s7nZ2VHtP
         y1HgvRLJy4ucY3nWZ3EkjWm8jKqUZjBWfT8aBdDIflsa4/+ZpceCjxAq+ddt3Jd+NzCA
         WlRZgqKrzGvQ/6uDU3BuxgXyVmRWJvoxmIOuxgmIP7MFPQ1fz0QLzOitUIyueSuK7E7t
         djLQ==
X-Gm-Message-State: AOJu0YzJoSwk5ZeW4G1+ytTME4xh/Cqv7IDvIbhANDwi10dVWKRFrbaY
	KLMZtA3ltRY2BpxaRRN4LtnG0NWrh/Or+x5q8w+ZVIpc67lL
X-Google-Smtp-Source: AGHT+IGqts477963RT4MDh/f/hOQ8Is3TL1ul5XZfsXe70UO+SdEY8Tj3eLHmIToYNzq6fUjwsfSMcQJugLkZMJ9xfcI14GwIpl/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a54:470b:0:b0:3b2:e214:9118 with SMTP id
 k11-20020a54470b000000b003b2e2149118mr8543741oik.4.1699173603875; Sun, 05 Nov
 2023 01:40:03 -0700 (PDT)
Date: Sun, 05 Nov 2023 01:40:03 -0700
In-Reply-To: <000000000000a6429e0609331930@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001222c4060963af3a@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_qgroup_account_extent
From: syzbot <syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit dce28769a33a95425b007f00842d6e12ffa28f83
Author: Qu Wenruo <wqu@suse.com>
Date:   Sat Sep 2 00:13:57 2023 +0000

    btrfs: qgroup: use qgroup_iterator_nested to in qgroup_update_refcnt()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f01717680000
start commit:   90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16f01717680000
console output: https://syzkaller.appspot.com/x/log.txt?x=12f01717680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4cc8c922092464e7
dashboard link: https://syzkaller.appspot.com/bug?extid=e0b615318f8fcfc01ceb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cae708e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1354647b680000

Reported-by: syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com
Fixes: dce28769a33a ("btrfs: qgroup: use qgroup_iterator_nested to in qgroup_update_refcnt()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

