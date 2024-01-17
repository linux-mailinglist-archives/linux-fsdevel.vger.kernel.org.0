Return-Path: <linux-fsdevel+bounces-8138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E321830008
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 07:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827931C2318A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 06:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8641AB672;
	Wed, 17 Jan 2024 06:14:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAFB647
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472046; cv=none; b=JWK7ZrLRfH2d/nE40FkIzKRFC0s5Up1JFud2+Ky/yP8jOUaiug6YVNsjpJRl9JJCYk8mOo2OUJf0yUPuCe1fXk085LQk0GhkS3gRXH1ueT555DR7tW0+Az+7okm/EURBoHd35UWHbrM83lkl0aza6N1XebgdGp/QM98ySMYmaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472046; c=relaxed/simple;
	bh=pPzg9tthJoAOu+lQEXZAgjDm2WofgFPBzt3dvf1Hr/k=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=L29JR2jwF2eQmSxHUp8LkglzTF9+NAlyXEWytWLCdyuAYrVf5x/42/w6+gZw8WayXoWQF0vbmKyuPUWYIUvQ8peNqTWqvwjbhxF5e+jJMjz/yRFINDqxCPVvLsgkl9BjLCv8u94DIilHg3kmYm9NLd5Ky5lfiPQU/pHRXF2Phno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3618a7e0ab9so13896595ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 22:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705472044; x=1706076844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpeqYO1STVuhEh0ZMGXqHdVeIyqAb6nGsjatnQ9D3hw=;
        b=OI4c6mlIoDAHeso/hD2mVWAmhr9BMDcQTLYF5mqcgzZ7HIcdQvv0BwrsU9Rm2YtNZu
         tfPEbrhskgyYZ9+DTuDRCluT/cdZrnD9vJIxy9SPi4tSL/AKFZ6Qv5LNTr3lLhu2Mlk5
         M1Qf6eXRq+TGCJbsmljXoBM1Z1XQgwmkqXd8gizTw0AYGoOGbT+H5XHmnyh+h+qG2E8s
         1Lq3mpN7Q2cHfztAfWg7TZ0apzIdPcNNertPdKtVg3hq/8pMMMethq9DkF8OJqVwTjzV
         4kxKQ7XzGp0yYtkCh0uPggaJjvPowzW9/1QZrHI+pyQQ9PVrKSkclhVaTFLQV5Ibf2QX
         19Ow==
X-Gm-Message-State: AOJu0YxVrWT4Gelp93dPvsCWIcUPnVnqEwGSzL8QBhC84qDKP4LOLNb4
	UVFyzXGn/XtAC2rUrLad+xK9xAJ5SaDfQjKBXpZnX8nQEJ3h
X-Google-Smtp-Source: AGHT+IGN7SG4q0ov8Gm69KwgEdQrZp/D6GBRSwOctE4czBCjRhOMpDnSIEUqdZEUJccRhRMSF6joNkP+ru8b8flHBUjGWg0VX4VK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2b:b0:361:927f:17ec with SMTP id
 e11-20020a056e020b2b00b00361927f17ecmr183829ilu.3.1705472044160; Tue, 16 Jan
 2024 22:14:04 -0800 (PST)
Date: Tue, 16 Jan 2024 22:14:04 -0800
In-Reply-To: <00000000000007728e060f127eaf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ddc5d060f1e2730@google.com>
Subject: Re: [syzbot] [exfat?] kernel BUG in iov_iter_revert
From: syzbot <syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, andy.wu@sony.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	wataru.aoyama@sony.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 11a347fb6cef62ce47e84b97c45f2b2497c7593b
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Mon Mar 13 04:38:53 2023 +0000

    exfat: change to get file size from DataLength

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bd5ba3e80000
start commit:   052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11bd5ba3e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16bd5ba3e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c8840a4a09eab8
dashboard link: https://syzkaller.appspot.com/bug?extid=fd404f6b03a58e8bc403
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1558210be80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d39debe80000

Reported-by: syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com
Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

