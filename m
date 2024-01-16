Return-Path: <linux-fsdevel+bounces-8068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96BB82F1E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 16:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E7F1F23D10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE801C697;
	Tue, 16 Jan 2024 15:54:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473011C686
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fc70bd879so82628815ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 07:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420442; x=1706025242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjLKJeIUZFZaxihu0DFtFUlDAFoZeUeFTWq4/cmqec4=;
        b=Daz2pV1QwtkxxRst/tY81pDMr47RFKePKDkdZE4/+OwFOCM7V55ka83qN6cWaTpcz0
         x6umj2EZztoTo7M2IPruJSC8TIWMvMxAOgLnYQEy1JnT0IWci5r7cRobyBPKg+EP+wdT
         fctF6YOS0toDxndoT+C0giUAxS6sSICXFh3R1qWq2QkVQd9j3gwiYyWHzbnCiB3ONzG5
         Ao81v7k3aVnDAanzweRyKCbN2A/Lzy8qwga6iSqeXsS0CWSkiAfF3z6TQNIondwS4oae
         ZX5d2vvocF9nZl/No3H6AycAnU2i9jniiUDxAD7PRWaYlvZxYRdmi1jVm0TURZFJhtDq
         Xyvg==
X-Gm-Message-State: AOJu0Yw/NZMIaPZrAHvoXRGq/SlLE/o+zTFKYClXYQXNdh26h7fLhLyD
	WXHGACMim9BsKnc4RX0IpW7hfXpx8LQbq2AOPDm+xTKCVfQS
X-Google-Smtp-Source: AGHT+IFlxGeh6AVV3dy7wQP5TLN9X3pB0gPsRG+Ydvt6+VGd2M1Ue/mlIulGQpjXlNXkskBWVWAg5PmI8zIRlMA1Gap7ra3eI7D3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:35f:affb:bd7b with SMTP id
 s3-20020a056e021a0300b0035faffbbd7bmr1234893ild.2.1705420442573; Tue, 16 Jan
 2024 07:54:02 -0800 (PST)
Date: Tue, 16 Jan 2024 07:54:02 -0800
In-Reply-To: <0000000000008d00ec05f06bcb35@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac2378060f12234c@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: unable to handle kernel NULL pointer
 dereference in gfs2_rindex_update
From: syzbot <syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	cluster-devel@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12452f7be80000
start commit:   0a924817d2ed Merge tag '6.2-rc-smb3-client-fixes-part2' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=2b32df23ff6b5b307565
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14860f08480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174d24b0480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

