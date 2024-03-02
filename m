Return-Path: <linux-fsdevel+bounces-13365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED3C86F068
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 13:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06844B242FF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02DD1756D;
	Sat,  2 Mar 2024 12:14:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E616439
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709381646; cv=none; b=rU21QkgAO6eBrolK6m+y88beckWqOI7wFaFRCVse+TXVJsWY+mrmuzxgthXipHFQb2a6ydCMtDGJIyAzw3D7HFhS6ti8Umke65Yds9Cqb/sBUZPTYr5nUdL2MGCqExsPnf3Elpy6b6WoWkdouEsHf215P/Ctz5r2zdNRJ0bUUyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709381646; c=relaxed/simple;
	bh=bFd8eX4Us0/YjmKzSKzjGwgIDpnWpg6gP95kNMPOmz4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oOB7HhOVj6p1U+TeOyzWeFmm3QVmTjrlH1WH3nBHfjeQGjZtspmDl/qJ79novlnUMgGzC5dWNmL/w3rw8YVOzhvdmfOqi+OsddYnXKGK7zJhy4DZ51AWRK5SofyVycYrVxw9pUPB36gCNkUDq5K7AL7NKjbkpUN/E5IHXCHAUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3657cf730a0so38294925ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Mar 2024 04:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709381644; x=1709986444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYoaaKFkoOiUzi2l6hHhIz7YnyXz41iQ7tjdGLqGYME=;
        b=nEKtmZ/LCRJH8Be0xmh5r35850DE/FGqDcEhGVQeo9zoGLH7ornBPmBQGCaNlhLedV
         WGZ2uLYoA5ixYls8xzHZ6s4/UqiKUe6wp258i1BG+YVt+I8YPuns4BI83CGzdoFKcesv
         sV+GdyxN2gUCzwrcaLDNxQMxSy5DHRq0zBif26YhJOSjBELZAJDEJ+PP9lLC7xvclSfF
         hWXWl84xvuEJFZaUKwl6YZQV2yFj3FnxvYVetzE4gwTUPEOBErfeWhsljDDXuTQSgZe/
         oPtU7QoVAmIH9eJtDsYvwfrsocENlZ//0onK9A5HOk5fbJz+VOoN+iRdgc8inTmCscjl
         hLrA==
X-Forwarded-Encrypted: i=1; AJvYcCWMYqkCaU8YMPWgLwUOe4mgheV4zvlOLvDKNIQCh6FSZDPIn9wJwvJPgQfPgWpLe3jus/kArqW92qCASLyHNiwvkO6efidWYveMgWmXqQ==
X-Gm-Message-State: AOJu0YxTuoZ9/eHvUyxQOZZGyt1I0NJ/FCZuUrfBvgX0o+YvQwhkyUFn
	p8HtcSWl1hntNWiGrKLE66EE0Z+OqjNI9CtelG9lNRxaIGd76VP+nXHQpSWvO32+xMG60njKxRO
	r4OM0gZ/6/m/37KFD7cIffzH+Hx8foTT1OD3XJ39FiLubmE9MZxKjB4E=
X-Google-Smtp-Source: AGHT+IGzYKGUPBAnHpRKFUS/Ttvbm9t92JKxhV3NxYE8TwRbo6Ol9O0X8ysMfiGCvGBL2jOGpG2Igxb5fqxTso+TPijHwSAYOSTK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b25:b0:365:26e3:6e51 with SMTP id
 e5-20020a056e020b2500b0036526e36e51mr147746ilu.0.1709381644143; Sat, 02 Mar
 2024 04:14:04 -0800 (PST)
Date: Sat, 02 Mar 2024 04:14:04 -0800
In-Reply-To: <000000000000eccdc505f061d47f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af5c290612ac6d86@google.com>
Subject: Re: [syzbot] [udf] WARNING in invalidate_bh_lru
From: syzbot <syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	hch@infradead.org, hch@lst.de, jack@suse.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liushixin2@huawei.com, nogikh@google.com, syzkaller-bugs@googlegroups.com, 
	tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a093ce180000
start commit:   9a3dad63edbe Merge tag '6.6-rc5-ksmbd-server-fixes' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
dashboard link: https://syzkaller.appspot.com/bug?extid=9743a41f74f00e50fc77
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ebc3c5680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122e8275680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

