Return-Path: <linux-fsdevel+bounces-3832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 452EA7F904A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 00:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA0DB21014
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 23:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50969315A5;
	Sat, 25 Nov 2023 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A18A129
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 15:21:07 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cfc3496f51so1570755ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 15:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700954466; x=1701559266;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8irKbRQf4ulqP864AaN8Yh83B8c2j63BxzIEMPOYPM=;
        b=iHktl0wky9KUiwagkztsA9nb90was/TXGbyQA+VAa3kV0OofRrADy9mPSjfDHOPHJb
         tnEsqNmlU3/g/EyAHie80q9vZVGLkrIyLVJDKexphTU1W7casYAJKRxu8LVKuL6TxRz8
         pzj1FstDPSzpXUC2ASVYmLBnvQVdpvXtQLchKNtjt1II2F3dEoct0xKEBVxB8a/KiIzm
         a3DAzrcwYbPlhLPO4Bn7LN45Gyq61wg5aaf8q7Iyuk9C9kmuqKi2H2Mq+/aS9BwcjILr
         DLYDr9xdOc7w+I7d1jWe7/PjQJktSwjPAQlfchpIYCMlgeZ0A2X3X1rc1hQa7Dvtov2x
         dlTw==
X-Gm-Message-State: AOJu0Yyn1/jIl2Uj1usPZCUrMNKlsqeQi761/yorsrqd1No3gLbHVrKL
	UXxYTWLgUOZhoKd2ZU9AfpMWExFPYNgeuz3rJ8hSAYewtv6e
X-Google-Smtp-Source: AGHT+IFetQ4Ea4jYYNu4u1E8cYyU5EKkb9XFCyMuTXo4Yo84ERnycivmlcdAMjCkdweSpyAyN58iIPW0zBpeCEXnglUtqHcV13Dm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:f68e:b0:1cc:20dd:8811 with SMTP id
 l14-20020a170902f68e00b001cc20dd8811mr1631703plg.5.1700954466756; Sat, 25 Nov
 2023 15:21:06 -0800 (PST)
Date: Sat, 25 Nov 2023 15:21:06 -0800
In-Reply-To: <000000000000459c6205ea318e35@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c52fdb060b02522a@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in xtSearch
From: syzbot <syzbot+76a072c2f8a60280bd70@syzkaller.appspotmail.com>
To: cuigaosheng1@huawei.com, dave.kleikamp@oracle.com, ghandatmanas@gmail.com, 
	jfs-discussion@lists.sourceforge.net, juntong.deng@outlook.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a779ed754e52d582b8c0e17959df063108bd0656
Author: Dave Kleikamp <dave.kleikamp@oracle.com>
Date:   Thu Oct 5 14:16:14 2023 +0000

    jfs: define xtree root and page independently

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16eb55af680000
start commit:   72a85e2b0a1e Merge tag 'spi-fix-v6.2-rc1' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=76a072c2f8a60280bd70
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15802088480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: jfs: define xtree root and page independently

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

