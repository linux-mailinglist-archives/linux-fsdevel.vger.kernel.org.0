Return-Path: <linux-fsdevel+bounces-7148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C50E822609
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 01:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2CA1F22461
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 00:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C42805;
	Wed,  3 Jan 2024 00:40:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE4C63C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fda7cdff8so113531995ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jan 2024 16:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704242405; x=1704847205;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJf7vSGa/mloGWPSH35KgZw/pf1sF+YVSpzDDB0QvDE=;
        b=P6ottgWQhxo4O1/aoHbYCNpKBftTZhec5isO0eMrO+MGkmkpTHlJv71PMnV2HPfZvx
         vhpdAAh57ixkrCvp/rowm5/Jtnew6+dAUImaZZM8NSpFhlBdP+VqHWvbCAdlZsjaGYjK
         hwMW4gj49bt8jQWSDe6mIGVg1zsukxHSaR4cEyee+sK1Q5aawx8d81cM4h3Dp/eZok2b
         erhUa1G4qmYygAPSyrSHNzCOQ/hwBkrOswh6EYKaLADRzL6xSQ8UWnK/TgWW8YALe/DV
         7ijewfUieFZkyTjJ4PUSa3qOisVbS0Gwusvi0WcB+Xfj0kP7l0qSNYNjlzIiFBusjOes
         8dIQ==
X-Gm-Message-State: AOJu0YwnUXBctSQkcEw+foG+3/aDWMaMtR6iLIfTXSKK/k2qGqnxG88y
	Zj8ARDKPOACK/xs4C5AssCTsHF01imRfE6Y181FKM937foLx
X-Google-Smtp-Source: AGHT+IFmE5GI0godAPqNQyN2YPspMWWMHHYp0iA22IQDb1vdWvkwnmx2bQyjOI0TqH6so35dd1UY/Pedg5CWPbdkZdiUH4mIgEBa
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1543:b0:35f:ff56:c0fe with SMTP id
 j3-20020a056e02154300b0035fff56c0femr2296142ilu.1.1704242405290; Tue, 02 Jan
 2024 16:40:05 -0800 (PST)
Date: Tue, 02 Jan 2024 16:40:05 -0800
In-Reply-To: <000000000000d95cf9060c5038e3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002dbc50060dffdba0@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfs_extend_file (2)
From: syzbot <syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, eadavis@qq.com, ernesto.mnd.fernandez@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this issue to:

commit 54640c7502e5ed41fbf4eedd499e85f9acc9698f
Author: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.com>
Date:   Tue Oct 30 22:06:17 2018 +0000

    hfs: prevent btree data loss on ENOSPC

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1121e49ae800=
00
start commit:   610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1321e49ae800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D1521e49ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D247b5a935d307ee=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D41a88b825a315aac2=
254
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1552fe19e8000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1419bcade80000

Reported-by: syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com
Fixes: 54640c7502e5 ("hfs: prevent btree data loss on ENOSPC")

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

