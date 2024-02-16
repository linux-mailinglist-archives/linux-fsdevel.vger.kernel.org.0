Return-Path: <linux-fsdevel+bounces-11813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F3085756E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 05:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8D8B22DC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 04:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00F312E6D;
	Fri, 16 Feb 2024 04:59:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D4125C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708059545; cv=none; b=cZbMRuJGPIMKyih2P4BjB0WAiPrf0caHMwAScvA93COmkbJy7+HWcGki33jD8LU/Ue8/+pyf23Q3r4SGi79LvVbO/6YZZ4lJza5cpF3vydbW7Y1GImO24UZkYjR68UpdBMj0sZDxqQeRPG7b6odQD3kNdcYnZT9+6AuLeC9f+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708059545; c=relaxed/simple;
	bh=+AGLJ+h6ksQ1LMrUfaPJw1kfoY13+VERfmtwUV0/xm8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ax76+92K44iu+M/+pobI8GqHCd8+yVPDmrPW4DGfYF/4wSC+eSq+rQNpaCGrIE43yN/JNQNdGz7aHw/MUIoWzv570mCtoYOyNDKiFrJyN1F6SqeNZkY+Grmlpzzwwtp/1lNQisyilL0wnt8NJLRPbySmVZPIBd/Mis1bNXDLH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36414a7850aso15879805ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 20:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708059543; x=1708664343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JculTRychqwIzbiVTR2hbbWMlo9K2vSRcy7NOSpjdFc=;
        b=A8EusJEXVbN2bLZzy0JpO5FZRposfWRTHs1r+UbUuO4nK1bqc3OJeoTGciwB43Xsky
         Uwtbn3vHu1og7bpKzMFSm5U7qba/JaisqzmMHWup0k7UhgN1PwBk656VRav/3w0y9cFk
         4JHcY7CTsU2VnQTgLQ9wXRluYIjpBTjyCnelRudUfqiCjKbuq4bnEP7raq9NsMPPkLxD
         NXEO2Dh9lMbmA6fd+F9+iYVEmTcm/FIx6WQeIMgJ02vmh3njl7AwxXsEjXZ1zEvhoVM/
         cFa6OtxgYmWVz7rjsTCF+wweBgmA3uur5BulAz1mKKIsPIJ9gTQtuGlRkJt+F1pW3f3y
         hpdA==
X-Forwarded-Encrypted: i=1; AJvYcCWJl/K7zbqIw0Cc3NymwO6h2SLYKYuk7o6mgBvJkTqzjM8/VXYQOh/3yYDz7wQBemwJxqpkLQha14JvD/hRJlbq3iKWG+LSxVoRZszSLQ==
X-Gm-Message-State: AOJu0YyggMwDnuQ2cg6mr1OUHQcy/o/iQ1MJsWxffEyb7A3VOJM6a1GQ
	rzT8ka/PINkjLl7btjRP84sCKye3xR2Uvcaj8oh+bujxEinttc/YVHyf74GTpcSMEwFQMxzVWfo
	7H2XQMJl2oy6HHYlJwN5bMeaWO1iO4F08KEHMFFvESFp3ZjXe0QW33KY=
X-Google-Smtp-Source: AGHT+IG8V/bytoc11b1/xnBwTe9cwikfexDe7rGUBOXKjOIuOWeIt138WrdbT0Z2LLvL3fWDIHkULxgTTGnYyB59KvUPbLFgzdS4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c568:0:b0:363:8b04:6df7 with SMTP id
 b8-20020a92c568000000b003638b046df7mr297584ilj.0.1708059543346; Thu, 15 Feb
 2024 20:59:03 -0800 (PST)
Date: Thu, 15 Feb 2024 20:59:03 -0800
In-Reply-To: <00000000000096592405e5dcaa9f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005626e80611789a1b@google.com>
Subject: Re: [syzbot] [exfat?] [ntfs3?] INFO: task hung in __generic_file_fsync
 (3)
From: syzbot <syzbot+ed920a72fd23eb735158@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, david@fromorbit.com, fgheet255t@gmail.com, 
	hdanton@sina.com, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=131679fc180000
start commit:   200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=ed920a72fd23eb735158
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dd033e080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dbfa46080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

