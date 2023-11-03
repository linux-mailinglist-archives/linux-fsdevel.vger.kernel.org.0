Return-Path: <linux-fsdevel+bounces-1914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC2E7E02CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 13:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579F21F22804
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 12:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8B416438;
	Fri,  3 Nov 2023 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899ED79E1
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 12:27:12 +0000 (UTC)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37B41B2
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 05:27:04 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d3251109ebso2380393a34.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Nov 2023 05:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699014424; x=1699619224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbURBXZ/3HBo11neS1hBFiZneNWug5j0JM5oUnIOIkc=;
        b=flcBK49Q62q86LlBJUNeWzIkzeIShHEiBjModnIElyynFJ1JmLZVlc7TOdeSdpVI/8
         zn6t7czXiY2+gqknWCxlQkUp+gQH900YMuSV6dMnQDY5hsL/C1aW932jVr8qoDo9bM5Q
         S+xr0EMCZBr7zDRIk6Jl5AWwOmvqLfB/hqzp6TbEb9LQ9yDYrNFJCD5ulBm1WbTyX72v
         4j0NTnBK0R8cHa+Qy0oHqBZnAuX8htFZjoFI93JJBj0BL7DhzIFetorq6fTPov4Flaby
         wAeGgrqgpvkobu6qvGoO1UqjPmOy+u6onvSXyKW6moH0X7btCo1Khozr5n3PFRvma/uc
         CLoQ==
X-Gm-Message-State: AOJu0YwlqCqdkvUHc9KE32GaJeCLcjbdDQfm2Ad3Jsl+BI3Nqz2aIfPL
	0jQOBBKyeLQuyhNbQB+NF+WmApC0nksHHcMD3xhfab6+fpGn
X-Google-Smtp-Source: AGHT+IF432B2k/4JgF8MvDVFRRX/gAgDGc4yukU2jI9h9EJThloFIMpXblHdmi8bUUS4mHAw67tALiKWRT92dEEXtFtICAKoXVO9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a11a:b0:1ea:85b:62a3 with SMTP id
 m26-20020a056870a11a00b001ea085b62a3mr10048223oae.1.1699014424405; Fri, 03
 Nov 2023 05:27:04 -0700 (PDT)
Date: Fri, 03 Nov 2023 05:27:04 -0700
In-Reply-To: <000000000000af7bd706084b7cb2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c325306093e9f25@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in fat_write_inode
From: syzbot <syzbot+6f75830acb2e4cdc8e50@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, hirofumi@mail.parknet.co.jp, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

syzbot has bisected this issue to:

commit fb96458067a8043c256befe4bfe4fb3ebc81de1b
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon Oct 16 20:10:48 2023 +0000

    buffer: return bool from grow_dev_folio()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154b4ef7680000
start commit:   2dac75696c6d Add linux-next specific files for 20231018
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=174b4ef7680000
console output: https://syzkaller.appspot.com/x/log.txt?x=134b4ef7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f8545e1ef7a2b66
dashboard link: https://syzkaller.appspot.com/bug?extid=6f75830acb2e4cdc8e50
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148fed9d680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1019f523680000

Reported-by: syzbot+6f75830acb2e4cdc8e50@syzkaller.appspotmail.com
Fixes: fb96458067a8 ("buffer: return bool from grow_dev_folio()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

