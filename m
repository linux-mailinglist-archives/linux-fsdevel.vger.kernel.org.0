Return-Path: <linux-fsdevel+bounces-14056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D556A877193
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 15:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A422281AE7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDF440878;
	Sat,  9 Mar 2024 14:09:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA13FB9F
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709993346; cv=none; b=WyvcLNx1Y32cGpYr6kkOZ9IWHhUFeVUOnyLM8xwzGDiERqGfhUhIW1sarl9iM0VEy02nA0QsJ1CFS0J8f+hv+6FDabDPAYRD6zcmkFx4DARtVXSnxUG1S+LeoGDEkLTe4SYDb4fmWAdLc8kYLkIAHScrXA87iCtjj9je6N3cLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709993346; c=relaxed/simple;
	bh=2+frEfNY9kCZ1DL3xeqyryfAD6b5yyHATCqZqM5CrB8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SNFKfUCcJYdi1nJ8kZCS7BNHpiwmJMpLm61F4mfvIuccgzbF7Ws//zjKoEiFjDQgX9Q2spsl7JFrskIaMzK76Z9Oql+PltA5/oG06lM8tKOvuG1oqQeMLgR/MbIufbjE5+Pb9bk0CptsR82BkTNttsBuWGDGL1efWgPAqp1/A+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c84b3570cfso299467539f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Mar 2024 06:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709993344; x=1710598144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LGzq8t2cO0APm/rv1jJdipgtRW0jr2Ew9T+G34Z8Vk=;
        b=UxF1/15x9yFDcTAt9bS2LV798YvXy5/icRBI6PwKiJOnFJVeaMmkbl6dB6NDIxAbnQ
         ydPDrJMhEn2evyORpqpLWDz/TJAJEcSawG4AikPuzxb169MYUoWD2tsjtZ5vjOgpKznS
         3wesmPMsDSmm6S6/Vw2YimbXgUjDm0VnOXYidkniZsvtCrfwm3t8MqH3f9uqcn64fRyy
         /boc4+oLAelDer3Py1wz9V1C9N1TPtEpi1YpYMD2cOkekEjgGT4HfYFLgVOFFaqDV+rf
         MRgiYpSiHr9KiFyWIGa7ZtaCieWS18810EUaBPoUvHeA5EY50l0MFQ4DFQ5/7bgvMUka
         nm+A==
X-Forwarded-Encrypted: i=1; AJvYcCUUw4TjyqPBpMJZL/DFNhhC4aNtS/jngDDvH0iNC0SxuD5toFtXW2VzWLN3hICfGukREHwz1lAZKAKqrWD0khHicIzkgyJCv2jTeFx+zw==
X-Gm-Message-State: AOJu0YwTY2mRujotPCALSauhaTA15ca19KAR17By3b75rqhU0jZ2iSU6
	hPPXo7tGA10+fBUHOOYG8JZ9IzGE/eNzalc9Yu4N7UAD78Dve9da24C7o6MajzjYLrJRpZpGPT8
	RjnSPLbLYxfJjCu4eQOx5Fu+ko5jaKLOycNf4vgY++AVdGoap8wVI9Fc=
X-Google-Smtp-Source: AGHT+IEwvoaxIjpkkmAaqdrdf8pyKru+spENnqat1cc0Qzw8RLRm6Fge27YlG5LX18apnrqnwtvO3b/C7CB8oBa7ib0ryoatqXZ2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1654:b0:476:d5dc:b729 with SMTP id
 a20-20020a056638165400b00476d5dcb729mr79848jat.4.1709993344002; Sat, 09 Mar
 2024 06:09:04 -0800 (PST)
Date: Sat, 09 Mar 2024 06:09:03 -0800
In-Reply-To: <000000000000f250a605ec981d41@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d682ec06133ad9d2@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in mnt_want_write_file
From: syzbot <syzbot+1047e42179f502f2b0a2@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164f208e180000
start commit:   ac865f00af29 Merge tag 'pci-v6.7-fixes-2' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=1047e42179f502f2b0a2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116d8055e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15687d81e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

