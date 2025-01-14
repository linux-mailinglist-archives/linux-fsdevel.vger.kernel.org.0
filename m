Return-Path: <linux-fsdevel+bounces-39116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F39A10057
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 06:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6769C3A6F78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 05:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4014D23354F;
	Tue, 14 Jan 2025 05:29:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6851537A8
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 05:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736832544; cv=none; b=FcJggeEQENLFgNNGXg2G/pV7LITchc8kp/FzpANuqhXk9Y7rav7VOl7/bWvi6bcquGVv5G14DLDe/J150eKhqYc9pmxVjIqL3NjBRUsf+vMM6wivuc2xw8rbkWRbq2HCE1F9G1IrqNn621s8vVFrqWQhvPKqDOIPwPb3UAKx87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736832544; c=relaxed/simple;
	bh=LDRMMtXvgsntrYQ2Qu24Cu/iG0KTxdHiuwg0pl/FNf0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fAuh689BbowL73zhxISU9LVpitnBy7RSbuazUSK4lhjJv+UEeNykZ3vojps7NLqJmnbJJiptgmpIepCUsSkivHC9T+Pq/GevhEGkaVFq3xXmtpIk14ut4SGZI4jVRXE17K5/oy3euMUdkwbLVl59m69BYFHZUzDFmjATEw8KPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a81754abb7so95348405ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 21:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736832542; x=1737437342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hxQFVKSIwGXs2LzOEZtXj+PR7j/N4G8a+YA/vW/pZ0=;
        b=Tsru/oFIpUN045RM2YDZfJpmWP4LJI4sSFelpTaMDluC9lpWRU7zaXYNQREHdJuVMW
         sEaEBo1sTmtfiFhg9sKq6MlK+l6RzIKQcbrfeo32TUnIO2zHqyM3cSXy4A+71wSBmJ5x
         eDOJn4n6LJaDKaAVrLo8E6hImXiYCQPspn8jjTsw6v8+trZ9NbMUb/29h32OkFwTlKub
         rZmJ0PUtwCsjjpvPz1sHPPYOi4wXiSBouGOmMVOPxLBuow9cXb9SweHJgy1I59hMULGx
         cGtW996D5bIZ3XQNJsEBo7woFM3OmUsJU0gUgtmSygmxCiRKzq1sOya+4OBLvS5yDBDg
         lj+g==
X-Forwarded-Encrypted: i=1; AJvYcCVGkwUj6Oty0pDjSWUYKJimDh0P1KYCLBsuSZgd+Pjtx7Nlw1c/A+q67VbTwXKO8M87iYxGuyhHobzy2UeS@vger.kernel.org
X-Gm-Message-State: AOJu0YznIKgGGpQHyi+3ijDCCTcKtlP4u6cECQ/rYm74h86P/K9ATyNo
	EkVDWVS6aK2oZyUE3jhcVoZxwBoMRdbCuVUzORbXbK5DA9RYAbRBp8IcPng+r9803HpzWYoMVM4
	0DHhlEpCVVi4jYDULUwyzhwvNg44sOhjURvhH80ZZeSiZFrq8DNbAj3g=
X-Google-Smtp-Source: AGHT+IHjyCs7x87VFFckXm5IMn7n1CzKc5yRv5/luW1oR564FtWguuc1H2me5LX+2w+HkSvZOD1SY7WljfKsiUSi8Q8tiw5pcLVN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1445:b0:3a7:c072:c69a with SMTP id
 e9e14a558f8ab-3ce3a9a4ad1mr200728775ab.3.1736832542661; Mon, 13 Jan 2025
 21:29:02 -0800 (PST)
Date: Mon, 13 Jan 2025 21:29:02 -0800
In-Reply-To: <67841058.050a0220.216c54.0034.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6785f61e.050a0220.216c54.0068.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: global-out-of-bounds Read in number
From: syzbot <syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com>
To: adobriyan@gmail.com, akpm@linux-foundation.org, 
	andriy.shevchenko@linux.intel.com, axboe@kernel.dk, brauner@kernel.org, 
	eadavis@qq.com, kirill.shutemov@linux.intel.com, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@rasmusvillemoes.dk, pmladek@suse.com, rick.p.edgecombe@intel.com, 
	rostedt@goodmis.org, senozhatsky@chromium.org, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	viro@zeniv.linux.org.uk, zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 8d4826cc8a8aca01a3b5e95438dfc0eb3bd589ab
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Dec 19 21:52:53 2024 +0000

    vsnprintf: collapse the number format state into one single state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16342a18580000
start commit:   7b4b9bf203da Add linux-next specific files for 20250107
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15342a18580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11342a18580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63fa2c9d5e12faef
dashboard link: https://syzkaller.appspot.com/bug?extid=fcee6b76cf2e261c51a4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174f0a18580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168aecb0580000

Reported-by: syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com
Fixes: 8d4826cc8a8a ("vsnprintf: collapse the number format state into one single state")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

