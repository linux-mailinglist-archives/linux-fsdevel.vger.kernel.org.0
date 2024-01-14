Return-Path: <linux-fsdevel+bounces-7912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35AE82CFEA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jan 2024 08:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33FA1C20DC0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jan 2024 07:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B0C1876;
	Sun, 14 Jan 2024 07:18:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278A1851
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jan 2024 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35ff23275b8so73086145ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jan 2024 23:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705216685; x=1705821485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFuCfXt+BxUWXTPpDFo62pMwYcUozTAUPCD33bbohME=;
        b=IIbiiZh/5PknbS0H+1smrwH4drvQ61nfuHUZ0OE/Y+/+FcDmd3U487n3DZNrrNJMM/
         14r3zc3xIbeA+1YSB+f6X7SNEZaqH9Kf/2kM3E/GvslhLyJ5Wac0C6ojJpY+qjEMBn6J
         4fMc8k1XFT0tJFdE7II62jM0hS6q3feaXuA3sUIYAPDdGvszfs4zYnfZTs/iCxh+bkeU
         YndzacYdwM4NEDDS6ZJviMhpARjzg/ys/C/pVkoFJ+Y46n0IDqGgOK+4iFSkSdTJ8y6e
         cai1Bn7FlAkmGhU1FMcAv7MQEL98dse/VuSK21KBlebCAyAPdlls3Wp0+Zv4QmYmiH6h
         iyBA==
X-Gm-Message-State: AOJu0Yxo7Vvxfr8kbz0nMLA/CnQmOpb5X4E78vppO7YsR43l0V69BRss
	4K4mOGlQA+oICyhaYc2G4riZQtSbQyw3xjWsF7jdnc23qTa6
X-Google-Smtp-Source: AGHT+IGimRhoUIZge/Cefcap1amRLfI0F1bGWHGp+s1g1C+s2YzJZW/J5H80QFOHyQ2sc6MsZ6q2WFU0y1Lb49i7Bwlgo47qNbkD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ce:b0:360:7c34:ffa7 with SMTP id
 i14-20020a056e0212ce00b003607c34ffa7mr516080ilm.1.1705216685063; Sat, 13 Jan
 2024 23:18:05 -0800 (PST)
Date: Sat, 13 Jan 2024 23:18:05 -0800
In-Reply-To: <00000000000027993305eb841df8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c746f0060ee2b23a@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diWrite
From: syzbot <syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, dave.kleikamp@oracle.com, 
	ghandatmanas@gmail.com, jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ec162be80000
start commit:   493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=c1056fdfe414463fdb33
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f431d2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1208894a880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

