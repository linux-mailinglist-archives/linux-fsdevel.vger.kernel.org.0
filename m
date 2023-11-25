Return-Path: <linux-fsdevel+bounces-3800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFC77F8A5D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 12:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A2D1C20BA6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 11:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F1E544;
	Sat, 25 Nov 2023 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410E410E4
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 03:54:04 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cfaeab7dafso9168685ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 03:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700913244; x=1701518044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KRHX69P+c/HonL20U6p52M6bOssV1LeZSiVOwq9udg=;
        b=iKT/Q/pt7ZGCD/LjWIJro2Lif7JcG8fWqBxEzPE8L7w4WrvaeC6Cfi14kjE7HL0Xet
         6fJHPi2US7Up4ZPUen1RCT9lwev/WHyyB4AIInlU5GdNMMCHS7CBPHAf4xr+3MRalmgH
         c4Ya79fCgLlnI2l7uOJSp5yRFt+qt+FEpxesHrL49c9aZeqhWPSLwBnuwGp9vqPkByT+
         5eW2WlSvjzEg6wP7OXNv7wuWzRRtfZuh4HYZF4wPYgJc0cQFI2i2Xi3SBceNuE3jQ9rl
         MG4XuKAHjhTWrBrkuHkg9Sznp2pbCcoX/BUFs+v4EynBZur/OGwcnDmTkOJbT+274hnE
         gzCA==
X-Gm-Message-State: AOJu0YzDJqGm950w3JJr2fAO0II5Y8rjsY+ZoFUblLDz3O6D+UyGTywf
	8TYMp7x37DOyS3bAfJ7x2702Hp+bdX7qR945KQjQOUWFZKH0
X-Google-Smtp-Source: AGHT+IHy5N+EUzhnu1BqL7Tre6DLYWnMI3bWa4fghmRRJW5x6mn1VxPp8iENwnRyZhLbrcEvUJ7+Wd0weLI92G6ARV1U74tRU3FD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:4282:b0:1cc:1e05:e0e7 with SMTP id
 ju2-20020a170903428200b001cc1e05e0e7mr1181364plb.2.1700913243801; Sat, 25 Nov
 2023 03:54:03 -0800 (PST)
Date: Sat, 25 Nov 2023 03:54:03 -0800
In-Reply-To: <000000000000d40c3c05fdc05cd1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0cfb7060af8b9e1@google.com>
Subject: Re: [syzbot] [udf?] KASAN: slab-use-after-free Read in udf_free_blocks
From: syzbot <syzbot+0b7937459742a0a4cffd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hch@lst.de, jack@suse.com, jack@suse.cz, 
	linkinjeon@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 36273e5b4e3a934c6d346c8f0b16b97e018094af
Author: Christoph Hellwig <hch@lst.de>
Date:   Sun Nov 13 16:29:02 2022 +0000

    udf: remove ->writepage

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14d71cece80000
start commit:   123212f53f3e Add linux-next specific files for 20230707
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16d71cece80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12d71cece80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15ec80b62f588543
dashboard link: https://syzkaller.appspot.com/bug?extid=0b7937459742a0a4cffd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15be1190a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d4666aa80000

Reported-by: syzbot+0b7937459742a0a4cffd@syzkaller.appspotmail.com
Fixes: 36273e5b4e3a ("udf: remove ->writepage")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

