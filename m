Return-Path: <linux-fsdevel+bounces-38574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C226CA04366
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F783163771
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 14:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC381F2396;
	Tue,  7 Jan 2025 14:54:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4BE1EE01F
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261670; cv=none; b=s/mZn8/QOjisxdEKrKHcJfP0WtlMH5rbWTX0gqmytubJkhyqYe4zv/ZXxjN26VsNeR7btQABljkXeLuAgBl9Tzn5oNe88REOHN8nee6vsOGKDo2VUgPCoWVghziv+YsBaTvtQLyDbFEiHHzr62vpWwMUMIxHKyoebbdUU6IJMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261670; c=relaxed/simple;
	bh=QzZxx2Oc5TPuhrNsQ3ajUwDG1bo0smOm/dSZglF1Zws=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=okzke6MyNNJi7bgmPLdOpktSlCBirPtECnfI4hHFkXxYUYQd0DZwl2oLz9IL+m0qZY/+APvsqCf3jcgFQeA7Rkgw/PXcecd/e/ANvbVqiyoO2iLVTbsW0G9WFREpyDcs3fQxRVPUmGQM3qrxD0HzNGDBVsE5sXxu59NS5Lp9I3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a91a13f63fso136847585ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2025 06:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261666; x=1736866466;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svjDloMgW4H/INr3u4boryd9gbKBZmqI27eqAVnul/s=;
        b=rs1ivd3jvJlt4+ao/ovqfI43gInwRhTh/ZQGj0jdlM7DbTDY2HZuMDalyP3FO1pnxZ
         EMjnxGp/mgVJ4elyxHBfnc2495y9SSM9IWtzWEZ8o1ViX/VgtI3SH3gGyh600fy+ErEZ
         8IptxvIxF952qRxtAKFjf2Dryc5+0qkIN3TegUXxd+2rnwkXKC0b8y65YQ/zAi04rDOg
         kJzDda3it9hIwHvlBFQTzjHdOW9PFlKQ201D0NcuYXP2Ehvse0LWVhfnYsNp7hf3RUyg
         deZic08P30enJGLLSUhBzCnpt5+rQ5nWFitPc+nvya4LTfHu4pKj9VszPElbS5XMzBe9
         XIOw==
X-Forwarded-Encrypted: i=1; AJvYcCXIz8h040x4MXLSsXwJiLeOubR1x2nuOei5SF5Nc01fReyZ3GOJLN1m2RPqV2POpxPo0VguUOn7iYkddXgR@vger.kernel.org
X-Gm-Message-State: AOJu0YxWX37Db79Raopf1/GGjLLdqddGR+v7MpplkUWZtjsIBX5Adwze
	MwjElRDC3oRcblMerQk3s0jBsF5cYChDqiRhRizmc6FqU/ipqO6f22vXwj3QEKvVpWYuF1xck+K
	TkIpaFynvYew8GGqO9odih7pHuC6abB6G3p07W5TWFHx5XGjP41sKN6o=
X-Google-Smtp-Source: AGHT+IGOWTBzVNR+wPwRu7pZqCQsZZvwXNCW+aPEN4iA5Rzhn4nTZ3uRdnyjR6ocW+SbV2bBw9V2eE7F0F6Q8HsIgy6v+6beUMXT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1546:b0:3a7:764c:42fc with SMTP id
 e9e14a558f8ab-3c2d5916145mr523497085ab.21.1736261666031; Tue, 07 Jan 2025
 06:54:26 -0800 (PST)
Date: Tue, 07 Jan 2025 06:54:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677d4022.050a0220.a40f5.0020.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Jan 2025)
From: syzbot <syzbot+list097cc95b0664fec261ec@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 1 new issues were detected and 1 were fixed.
In total, 14 issues are still open and 21 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3312    Yes   INFO: task hung in exfat_write_inode
                  https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
<2> 1094    Yes   WARNING in __brelse (3)
                  https://syzkaller.appspot.com/bug?extid=ce3af36144a13b018cc7
<3> 60      Yes   KMSAN: uninit-value in iov_iter_alignment_iovec
                  https://syzkaller.appspot.com/bug?extid=f2a9c06bfaa027217ebb
<4> 16      No    general protection fault in exfat_init_dir_entry
                  https://syzkaller.appspot.com/bug?extid=ff3c3b48f27747505446
<5> 14      Yes   general protection fault in exfat_get_dentry_cached
                  https://syzkaller.appspot.com/bug?extid=8f8fe64a30c50b289a18
<6> 12      Yes   KMSAN: kernel-infoleak in pipe_read
                  https://syzkaller.appspot.com/bug?extid=41ebd857f013384237a9
<7> 11      Yes   INFO: task hung in chmod_common (5)
                  https://syzkaller.appspot.com/bug?extid=4426dfa686191fab8b50
<8> 7       Yes   INFO: task hung in exfat_lookup (3)
                  https://syzkaller.appspot.com/bug?extid=73c8cd74d6440aef4d6a
<9> 6       Yes   general protection fault in exfat_find_empty_entry
                  https://syzkaller.appspot.com/bug?extid=8941485e471cec199c9e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

