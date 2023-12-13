Return-Path: <linux-fsdevel+bounces-5997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E54B811E76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 20:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3437B20F2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B2667B4F;
	Wed, 13 Dec 2023 19:15:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B3EB2
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 11:15:04 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5ca4ee5b97aso489061a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 11:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494904; x=1703099704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+qA+3s/ioGOJ3uxe2remjMWpiOFwkSY74KtXvjignU=;
        b=jCxqHuSwqQFsahdJoIDwZPmblFV4WKQqvJbqyu/7WLht1dg+dXJ42cgdmqyzurGxCP
         bgNEMzNbyOTlJsCxt6Gyw5q3LwO8kRaWcQBeCTn8gU4626Pag+CXPC0akAIBA/aipIFt
         3yxam2aXgpI4oGfB/C6TvxXgtbk7Mb5V+0jwzg/+01a0Gpsh1yOdoUw5QFH/qoN8MpGY
         nAryGLsJMu7azxQ6WJxHaQFlv7B7aScI4b7Y3xsRPtJz1y9ydcFz2gUnnHHI6PxkYl0C
         ZKdrShjUfgQ8nUNqXbBL0X8CQbd4zZPcvsDDZYJTjPz0h4ZzFV9GKLTSXEYbd00zIwd4
         x6ww==
X-Gm-Message-State: AOJu0Yyyoy/VCRjW+zsdEb/yXuqO4mjvz99mL7O7IaCf3Yr13U8UVOWt
	018+DzIgWwUvRMbIBnwrd0IQLf+jUowGJlaRJBLYzXmOk2W1
X-Google-Smtp-Source: AGHT+IHBMQwvlrMxR7i+6p1V4vI9Tfpi3BvMvOp82p8mZb0GiGk6YjOqZFMXqwV63GJQQo5TKhZ8D8Ggu99JrTwyA+M1hWIlSDRr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:32c8:b0:1d0:902c:e834 with SMTP id
 i8-20020a17090332c800b001d0902ce834mr487525plr.12.1702494903910; Wed, 13 Dec
 2023 11:15:03 -0800 (PST)
Date: Wed, 13 Dec 2023 11:15:03 -0800
In-Reply-To: <000000000000169326060971d07a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fac6ee060c68fb16@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io
From: syzbot <syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com>
To: axboe@kernel.dk, clm@fb.com, dsterba@suse.com, hch@lst.de, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	senozhatsky@chromium.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 95848dcb9d676738411a8ff70a9704039f1b3982
Author: Christoph Hellwig <hch@lst.de>
Date:   Sat Aug 5 05:55:37 2023 +0000

    zram: take device and not only bvec offset into account

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1325355ce80000
start commit:   eaadbbaaff74 Merge tag 'fuse-fixes-6.7-rc6' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a5355ce80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1725355ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=06006fc4a90bff8e8f17
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cc9deae80000

Reported-by: syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com
Fixes: 95848dcb9d67 ("zram: take device and not only bvec offset into account")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

