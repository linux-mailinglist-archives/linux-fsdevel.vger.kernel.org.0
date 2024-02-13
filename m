Return-Path: <linux-fsdevel+bounces-11414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C328B853A0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 19:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7868C1F248EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 18:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BBC10A29;
	Tue, 13 Feb 2024 18:42:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4910A0E
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849725; cv=none; b=WvJwz/Ryhpix7MyCvl8JRbZwlPnLNzRB4Udr6SqzC4RDvFIlK2zEXuMHVw9aU10QbJrnGqk52mR6DekAdnimLXNYwRLzRNgLq6eD9CHRiqt1fAtRu3AUhbPCMoADWnbwviBf2BgZw1vGNGNvqiZolJNu5Xrwgz8jnSe7ZsLV3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849725; c=relaxed/simple;
	bh=gGTofCRKDI0Z9TW+TeMYIS+KXW44FQb7kapqG3xt0NI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hz0mc6uyErJtXWATX4JAD9eWKI5w4Cmi1b+H4fEhOJqGRFCHtDWSs1xLFVZelWo9RNLn0kQADIJdbxjCINHx5arZvJRC3GO8uFqr+q/2182BGlRapM2Xhcn2uK5XNi2Lea+TxslyrDUKl6nZ7Vl4hPHR+HuEtYP2Wf6ULy3TMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363da08fc19so40907185ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 10:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707849723; x=1708454523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aiiASvbc7a26H8Bub12QdvoOFsqbdc7cNoE+2hwgvwk=;
        b=jckweTkeo+A4wW+zMSaUwrVFeRjhqMrGnKspG6sYfo5BjMzwYCE6MspL4cZ9xiga0Q
         Yo2aXYB+pmJ2c5rrMJo2yGl6SmpCP3CgRpGKCh9/ceVoZzA27t2rlZ0hCG020VFn4d8p
         r9JVn/ZMcOJmTWZxOO5SN5KpBM4krCRA6PEPNBfHWqP6dAmnc39tzzPvVMoZvTnUu85X
         tlLcWfBEhjcXvc4CALwnvYXCCOdl81Zu9I7xCMmZTTKeCwAYE0pTsiqmug6I30IyWge4
         nCz6m8nsfr9Qb0ubtb1bf6pczyENVq3+B/HewYZr2FzyR0jd6H+HLzBhn8+XCL84TypR
         QQeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDJBwmVee5GPU/6xoc69wWTOws93vB7j7k92YaoOFjQGO/eL43UKOcLKB7vo3HZ93Yd3BBIfWCZ6sNN/CDLpnuzlsW+yBBwihiwi0nbw==
X-Gm-Message-State: AOJu0Yyj9xnbhuz7quSw8aRSSYnWDhs5dDTbgaDlGWNokOPRFduPUuX/
	aW6UlBHw75C4U2tZueaELAul1zliPEsTi2mk7eRbrtMDSZt8lD9o1Nol5CPVShp/dUE6dK3EDo5
	CvJM01Rx6/1lLVn1UKyj1+sIZ47nPSSkWdmo2WZC/M/no0vjxVkaiYd4=
X-Google-Smtp-Source: AGHT+IENo1xPvITOHRQQJ+M5KbsV17Ysd+dOGuZAlsgGB+yI15qx8x+sXPoucnIA7sf0wLWSQPaLwLfwWQ3yIBkYN186lvWoDH8J
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:363:ba7e:ddc0 with SMTP id
 s3-20020a056e021a0300b00363ba7eddc0mr30763ild.0.1707849723685; Tue, 13 Feb
 2024 10:42:03 -0800 (PST)
Date: Tue, 13 Feb 2024 10:42:03 -0800
In-Reply-To: <00000000000042f98c05f16c0792@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c3739061147c07d@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel paging request in step_into
From: syzbot <syzbot+0994679b6f098bb3da6d@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10656c42180000
start commit:   bff687b3dad6 Merge tag 'block-6.2-2022-12-29' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=0994679b6f098bb3da6d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11307974480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c567f2480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

