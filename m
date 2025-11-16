Return-Path: <linux-fsdevel+bounces-68605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 844E3C613D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 12:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D91E35DB84
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 11:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41512BDC3E;
	Sun, 16 Nov 2025 11:46:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE0A16D9C2
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Nov 2025 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763293567; cv=none; b=G86gNLKg5V+KuZwIleyaDyJziMpaBIXBFUKMoE5mQKvUUmDzkqHUG56Jjo4HspnYFxw3xlazKvDLYftp5K5H+PenGvzPG/QmwId3CUZhcWdU6WJhJ7rI/8t326zi2fwLQsN5o+eRPoPln7jl/segfBxfz93aIb1m2A3Fia6xKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763293567; c=relaxed/simple;
	bh=yGAwkub6rt9vLAhGWICf4t2U/chgu3O41SupnrFW5Xg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cBIQBd/ctyeCqwbN3pVMg3vBNiPjH+qE2xIHH0Yxbkb6+53cYqZvsJIMFbur6BAGgmJlr6HYmvj3Gf7AI0W76QVUOsnpgl+3o1oqNVrCTuQv6Y1iALgVkgCCWMSLpwUMWHprZNEW7s6xScs1iRNV99FAK+UsUf+KEPIlKvLZejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-948fb707ca7so78375439f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Nov 2025 03:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763293563; x=1763898363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBGUdra7I0KPg9A8GJPQU74ijMDEHlDWO+T4yNix8O8=;
        b=UkGT08YlRMKc9AUWwljV9UphZEgEk1VIGX4RmnnWZjvMylFZvQ0XCpvQu+evQ+vT/3
         HNaheY7r2uqAKXKM81n6eOe81WMFe1+Uy0aUTXj1QXKcMzs2Axz2bjb8xbofqSfQsoTx
         rTXb6Gn6popm7iyUHTAkf36+6uKP9bRwexsfntuHziuOa7l7PHNTpV6dtkpM8mrGIoGq
         JBk1bCL0ISroe6JZG/un0oCYN3rKx7aRl5Tt71UrgQR/oYR5rHN+C2LE4FzSQWHTRdmR
         2W3RTGbQgYqB+gXyORnTfu372NvVXQwe2n8D86UNwGfAluqDaXk003vZo86T8r9Q0vRU
         DfGA==
X-Forwarded-Encrypted: i=1; AJvYcCUFIdxV0W1sTzJ+G4UBVr9YEUdkZnqVfXmSsB76MjaBiUp5jO+vHjx5vEcsgYOBo+pUadv5DW51CmUeqoR1@vger.kernel.org
X-Gm-Message-State: AOJu0YymZl1vKgBCcWXQPuYVZRLhv/5+m7IVqNziKXeBvh/3Gen5SJZ7
	2/aH8DChc9T34E5kbD9Pub6Djdo3zoKiN7fhfu2XUoQfJ2GQx7V0tGCJoTqwphZl3LdbpmZF7CU
	jArbLxEUwfACegoOKNj13/b4k+XdN0DS/vOfIPRTeVnaGMfjaL30WQQvY+Fw=
X-Google-Smtp-Source: AGHT+IFDaEzOVJjzE1l206Xg8DiBkhgPO85Zzi/e2ALGTYYCQDYltjniZalDFu2ErwC4GP84EOWq9rBYCTx6CIki6c6FH4cj2Vju
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c:b0:434:96ea:ff71 with SMTP id
 e9e14a558f8ab-43496eb02b9mr94585865ab.33.1763293563248; Sun, 16 Nov 2025
 03:46:03 -0800 (PST)
Date: Sun, 16 Nov 2025 03:46:03 -0800
In-Reply-To: <68ed75c7.050a0220.91a22.01ee.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6919b97b.a70a0220.3124cb.007c.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KASAN: stack-out-of-bounds Read in exfat_nls_to_ucs2
From: syzbot <syzbot+29934710e7fb9cb71f33@syzkaller.appspotmail.com>
To: aha310510@gmail.com, eadavis@qq.com, ethan.ferguson@zetier.com, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 2d8636119b92970ba135c3c4da87d24dbfdeb8ca
Author: Jeongjun Park <aha310510@gmail.com>
Date:   Wed Oct 15 07:34:54 2025 +0000

    exfat: fix out-of-bounds in exfat_nls_to_ucs2()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f5a212580000
start commit:   67029a49db6c Merge tag 'trace-v6.18-3' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1921939e847e6e87
dashboard link: https://syzkaller.appspot.com/bug?extid=29934710e7fb9cb71f33
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11aa067c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ba29e2580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: exfat: fix out-of-bounds in exfat_nls_to_ucs2()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

