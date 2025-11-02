Return-Path: <linux-fsdevel+bounces-66681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC44C289DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 02 Nov 2025 06:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F8AA347C4B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9EC2222A0;
	Sun,  2 Nov 2025 05:39:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F63F510
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Nov 2025 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762061944; cv=none; b=mCOTW4aKl6kehkk4yHJb78CLG2G8ORZdZEpsQcBcLvJehIUUBbpynxj/QmNlyGqg3NPabJEBLIPbEoF78u87KGbexP+NPN/AIlnaMrPreQ4FZToWbsxBDuLPXBKpaJ7Q3whlpBaxSEwAU68jvRIfFKCaTMin//E/nlrcC6QMJ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762061944; c=relaxed/simple;
	bh=WImCX7SvTyP9WE4YKYQAr5TtP5ayByld5OhLfhadDPQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DyMVfhPu8ZWqUxhvXZR3dauiCytZYobNdzQFe1JSGsGr/q6oCkJptQw/PI2bWbfPt9sqCUAqfKlAv58ul0AyspRPDeziajhgisrg9ILfGHaHhbSFeeqoXJDRLDUutcDErNgiX0w8QLThY+Xo6eZcGaFDs/tsaoZbFzMNdgEaEy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-432f8352633so98346065ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Nov 2025 22:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762061942; x=1762666742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5gofQLv9ATheBLZFs5eVxjk1NYdTx1xDPMzfJ3PQe4=;
        b=kkLNwWFaBFbOyAWn0BuWnBE+07BqyVPPCcNHmh0452Vh41ydqoCdDYWWrYxYJ4gRsv
         SATPKH81GVdsNc6BpTlwmn/2ITAnszciwLMqd+jKzdeWWB3TsgHDIeJEz9oiQryoXgkh
         P3tR3MUFgzIx4THBdmHU3umTXlKmz7fqXxyVKgBeJ0vD0NysEcAwy+VTT4S8W9zO7lXt
         C4lzaPN+BcpI6+ZpXZduvR6yhPzb5YdQDxt+MuRrxWFE7soZkLsXMlHPMuvO4aQphL2o
         O3f6JwM9CoF19eRCdnqHD97RuSr8kQlq9+BIfYUM2WDNeahMsb+YdhYGMxwOSJEzzAio
         6AtA==
X-Forwarded-Encrypted: i=1; AJvYcCUrN0sBngqEgyu34yLYYcSfteOO33uE9iHJLefdNFSaKZ1RojQT12L8fRzwYpG0oKl+KeH6RmHrUf7iw1MN@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPCwz2QX/B4I8jIZZMzqojk2LPEKGiNR7GglDDcaJrdbJU2BL
	jhSLM4jIQdQUAn2g8F+i/hqqUC1UOt25rIL82/4DoDmC3x/BkT1a3Z2HEDrQVggfdcVC6Y6H9hR
	zZy6In9kLbNFWMDXCSjvs1Bh+csxLhpHXgwpWHl0xOe5ndc37xP0s3vWn11g=
X-Google-Smtp-Source: AGHT+IHCp5x9Csze7ts1+FeJTWPJ23oGo3DuAx7NFNbgLSzgUoEWPJQbXpSqgSY8kC3XvptviGA3Mx7pJPxr111i/n4AQSQen7Gh
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4c18:b0:433:2389:e0ad with SMTP id
 e9e14a558f8ab-4332389e21fmr37683605ab.8.1762061942596; Sat, 01 Nov 2025
 22:39:02 -0700 (PDT)
Date: Sat, 01 Nov 2025 22:39:02 -0700
In-Reply-To: <68cc0578.050a0220.28a605.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6906ee76.050a0220.29fc44.0016.GAE@google.com>
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
From: syzbot <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, jaegeuk@kernel.org, 
	joannelkoong@gmail.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 51311f045375984dabdf8cc523e80d39a4c3dd5a
Author: Joanne Koong <joannelkoong@gmail.com>
Date:   Fri Sep 26 00:26:02 2025 +0000

    iomap: track pending read bytes more optimally

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103a0012580000
start commit:   98bd8b16ae57 Add linux-next specific files for 20251031
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=123a0012580000
console output: https://syzkaller.appspot.com/x/log.txt?x=143a0012580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63d09725c93bcc1c
dashboard link: https://syzkaller.appspot.com/bug?extid=3686758660f980b402dc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176fc342580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10403f34580000

Reported-by: syzbot+3686758660f980b402dc@syzkaller.appspotmail.com
Fixes: 51311f045375 ("iomap: track pending read bytes more optimally")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

