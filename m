Return-Path: <linux-fsdevel+bounces-49807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC27AC2EC4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 12:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A874A805F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 10:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766371ADC8D;
	Sat, 24 May 2025 10:05:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384D819D8A7
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 May 2025 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748081137; cv=none; b=pkUpa04jowbv0hKfBm0Ut3eJUSAol/MKlFppS/lr4XbrWcuCkuB4KMlQix3h4UoXapBZFKeqoj1uBi29xHvJrLyDD9ahMWqw/Y+pkeDh3QqJwA2qNQdsOLkI5Q0epOShdRwCyBM3zHSSVGVCSEmqModa2qUBbd+fd1ZOsDAyC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748081137; c=relaxed/simple;
	bh=lGw3DY65ueQVYKXqtXWX8gnFKsdoVy88glIX9gkXqQs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qKdahHWPa6jrrC8RxeciF6RgQ2p36dOKB0Tw+wt47q9xzVARkpgTf4/428nlk2YuzrAHNjmdcvGEoKwtjeFZKFSwFIsXMp6Scs/97EkMZOUJ5ejzkJDOorjTvq7Jak8QM7DcOClp1NMsunGKY4OglG5puSe2pppQqaWMYlt/73o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b5878a66cso205352139f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 May 2025 03:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748081134; x=1748685934;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZF0QGYyssk/KtoqKqz083DqbcjhDRw8W0phBEuMFFi4=;
        b=bNTCnnFoIbf0xZiBxH5Fu2iEq1bXixe2X77e7YTwLnzIAeNgelOmRB/7Wos5RV8xs7
         D/pf4uKn/jzBtRX81TDwwEIHYKIcNBmWt4dlCgosii7Y2ahHhqNOfBN7OkvodN0kqQ0Y
         ryB4Qf0CxMhA8nOidbsuOMnLjGQ+qxC+WAkPSRw8zNNkaLe9bB+gEWnsimnN6NzoIfUv
         8x9gRZwxPfbZvFGgeQYc7IRFS6cGRY6RNwHFiGbFt1xhuu0xMvzvl1LuGnIW2g2fOJB/
         SwQRuPgH8rd6VVPiwF/MJ3rRe8DbmIQq+PFZbp22ypj/YC51u73KcPwQ1bgpWjJBP6Lc
         l32A==
X-Forwarded-Encrypted: i=1; AJvYcCUKX6hEDpTCZBTqN+73/PoFeLlIomc8syX1wFplbX2I7ox4rqfoEdIk+6QKr6uycxFKHjxHd+4J3rdn8tYT@vger.kernel.org
X-Gm-Message-State: AOJu0YyfxDCfcT0roLC2Qkqeq4rgi8z7p5GFFbQmpKRAYWU7OiLAEkrJ
	JrZoZyo1saFVl3O8IZhcz9iknsvmEUmwNXMmwNuq8uhpTfDUlyqxA08jKKIKnTOYD7ixo+qT9TR
	YSE8wKn4IbKsfVO0LBUW1SQf4MQSLVk5jUZc7JQFYemnug1tsYVLdwuhPrc4=
X-Google-Smtp-Source: AGHT+IGBeRgaOle5h3604R+qkWqBVgjEkp5aLPVs03gg96GrLNb1jQCpQ4W+eEhTp+837c0PKI3pSX9/bYFYdl4KHW0NjGTzJvj5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3684:b0:86a:93b:c7de with SMTP id
 ca18e2360f4ac-86cbb7b5de5mr265760139f.3.1748081134401; Sat, 24 May 2025
 03:05:34 -0700 (PDT)
Date: Sat, 24 May 2025 03:05:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683199ee.a70a0220.29d4a0.07f9.GAE@google.com>
Subject: [syzbot] Monthly exfat report (May 2025)
From: syzbot <syzbot+list9e94a023fafdc8e336d3@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 22 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3314    Yes   INFO: task hung in exfat_write_inode
                  https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
<2> 96      Yes   KMSAN: uninit-value in iov_iter_alignment_iovec
                  https://syzkaller.appspot.com/bug?extid=f2a9c06bfaa027217ebb
<3> 14      Yes   INFO: task hung in vfs_rmdir (2)
                  https://syzkaller.appspot.com/bug?extid=42986aeeddfd7ed93c8b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

