Return-Path: <linux-fsdevel+bounces-12747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D186692A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 05:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7681F20F4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 04:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56111B94C;
	Mon, 26 Feb 2024 04:09:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826419BA5
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708920545; cv=none; b=oKmf9BpiKleEL8889pFKISkMWGUkcbXq43MMkrUAO+TeuRiJkWUB73sJP4jfRCmeHRFdMCvpr0w9Zh8W7VdtIHu6s+Sbm3yANUQFCgUioipJWDE2LclkrWIHbsfSyOOIhUtkyc4iM7O1X3a4SwiUBjcYNGiJsc4vKm/yNMbEHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708920545; c=relaxed/simple;
	bh=sVf87IQzTzV0aVFiMywfSmA3BksnTd1FHjfXa6C0bbk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WwiQAtlkuRj/EEr+B1+l/flTxF4rucmNHJo0fh/N1A1zOmuepnJrqGK7XJmnz85Xq/biaDycDT3z1ChfjIK8aCnWjFgpZyCbCI0G0h80NOqMWIoOgYVELI4Q+Elo0y5InO07FIMWREvQJRzhB1DBwAFKMqDYqYNBonTbXyfD87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bc32b2226aso264480539f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 20:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708920543; x=1709525343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNDjEj3dO41B6yHWj0vKf07JfaPf4wfX68sy+dsc0cc=;
        b=iglHjJYUNyfBnRNGCl5ilWlf5qeOnujkVKrnuoGu/YkCOctXCjWsG/BFgd6aFm0+80
         ZZ9ejk9qnFyK0nwPT6Das9TBTW60NtPV33EkL0PNf+Bli6D6i1+luyJ7O9VTdokaOBHA
         tQO27bsaJ5doTIKHa7ujtkzrbfDaGBAwuXF2DkqiqYrmQ9UrnWXsNv23pd818Kaj9hLP
         Jxtr5sd5vthzHKdgosgzCroaQjC2ooLuMlEsdcj/l7gCpOE10YfKO4LQhy3wsDdWDBfG
         jZIGaJ83Cu9BteL2A3g73s+uAHlSnx79zP4yQ8gzg6PTGg4g5wJAehMaGg5E27t6aCuQ
         loow==
X-Forwarded-Encrypted: i=1; AJvYcCWkDaZmzVG5a2wKWXN+iSXNtnrE3+1oHlBcASyCqFJk2oWmuO9LU4vniWUKlwirahFZCBwf8Z+CGxk4tSMZEAlx4DV4ieMfyT7aGCypUQ==
X-Gm-Message-State: AOJu0Yxe2zcv4k2fCsiGt6ibWfcU8rWs4ay+Zl0Xp1HrXepHltpW+kE3
	fRaDRkNlgB6LmewdfdPEj45F9nae5Ng314GiMVvMz8XkqzgJToGiWRm+vXFlRI0W+n2tFFT8S4k
	Ci66/cgjRQ86a5EQbllLdZTfxUAv5AKVrFll2WxTefevoZ911YrVjQb4=
X-Google-Smtp-Source: AGHT+IHGIB6xFgTBe8rarTPKRKsWIcHLb2B4v1XZJ1w4HhxteEbNfAkQ533BJ23mhdcAFx0a27dCQeZQZTB4NpfTSSMAAxlsZQQQ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d13:b0:365:2f19:e597 with SMTP id
 i19-20020a056e021d1300b003652f19e597mr470242ila.5.1708920543138; Sun, 25 Feb
 2024 20:09:03 -0800 (PST)
Date: Sun, 25 Feb 2024 20:09:03 -0800
In-Reply-To: <001a113eba282f2ffc0568b76123@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec5a2f0612411136@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG at fs/reiserfs/journal.c:LINE!
From: syzbot <syzbot+6820505ae5978f4f8f2f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, alaaemadhossney.ae@gmail.com, 
	alex.shi@linux.alibaba.com, axboe@kernel.dk, baijiaju1990@gmail.com, 
	brauner@kernel.org, colin.king@canonical.com, dhowells@redhat.com, 
	gregkh@linuxfoundation.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, rdunlap@infradead.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yanaijie@huawei.com, zhengbin13@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16fcca02180000
start commit:   b85ea95d0864 Linux 6.7-rc1
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5bf1661f609e7f0
dashboard link: https://syzkaller.appspot.com/bug?extid=6820505ae5978f4f8f2f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1728c947680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1079c598e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

