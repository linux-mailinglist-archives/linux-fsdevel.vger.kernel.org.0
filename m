Return-Path: <linux-fsdevel+bounces-16862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A08A3D01
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F251C20AEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A55445977;
	Sat, 13 Apr 2024 14:40:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C202424A0E
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713019230; cv=none; b=u4nLF5SvZMmpa+fDR0jlN+4aw73UWXC+Y/MJbdKWUJlNZ/82yLEfFX2W1Q6dMWCuzAQU/MYwjdaMXP01tScWvStHXwsZvu7gRakRyrm30hUqy16ypIyPIkdJKmH1SkZteA5/SVrvGM/NdpHmnT+pKb506tTSySOn+dRgZTXqTX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713019230; c=relaxed/simple;
	bh=RQQzoGcTA6H4JIzpfeJj61LJPkub4GGavWVMwv1dkQY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PO6Kl6PD3kFCuWIY855IOlKhFsah8BLjPcSXwHtziDtqcedGAwBwthc3nku7BhejsYxl32tqQLWZVbrBpC0pLAqO/hCHhDcHJcBNf8sOLYajm8g5plZtjDp0VQsHhcBZxRonZSQ+PmCh5K38AHECjIuFYZforcf8V5TFNIA+weo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5f08fdba8so218560539f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 07:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713019228; x=1713624028;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Km9dnXwPQsStKWjNgok9y+DleaiYjugFVyAiM08sHuo=;
        b=An4vAepL2q/o9QOCA1rur9Umvq0xsJOgzcEjtffvjey1eG2USrGh+88poWdkifa9c3
         F9GSbHlGrLtOAe7H3u4TBdyBkTlziR9Njul2QswDzBQp75ayRBTWxuQ9+jMDDjLWEgws
         h6CY4NbzHPfe0b3zACB0qihpvB0BfMR9CsBAKufHQbd1w5GKooFcwG2BzkX/CU5pBrWL
         ipYcKOZ7dMB3YEb3WH6ReeU2HnxzOdL14o4GxMVyvqw6fzAfOd3rgy6AJAConUSJZMSq
         x9aDks2Wy5iT56cHGpFKZs67si9S35+cCVJSpDD+eWwVwkyQqKPClGceI9PhpZt+abtH
         nrFw==
X-Forwarded-Encrypted: i=1; AJvYcCXjPBRprVxPVFasf/jal+efOqELQoj+h5Oz9ea1RIF4Vfm+uZjsctmqQbB3HJgHADGyQrDcvAQzAfnLP4mTf+1+lCLXiytE2AUoAqOxQg==
X-Gm-Message-State: AOJu0Yyk/f7RRFKk/LOD53K4VgG/FgLkll6T8ngZZFAMCSNXVYJZPtU6
	p3k4w5Cn+90iebhDI7IDTzKyxWV5JzBsTIu8rZYuHcCYKJNyd/Q+Wvt2QhYItYJhuQEnK9C1i6W
	c3X535SC5f8gUgknbvwM5E1Nw0e/Tv2KVv++g7Xx9Ta2+Xv97EfxEpAU=
X-Google-Smtp-Source: AGHT+IELSI+0N0PKPjsg+txhSCNZ7OeFTZ7g0KKIEHJir2gzmU6qG80slK+FY0kSqKXjtl2slbCb1X2u62+q+5UZtWrtVICWB+Uc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8504:b0:482:ead5:4f5d with SMTP id
 is4-20020a056638850400b00482ead54f5dmr66240jab.1.1713019227967; Sat, 13 Apr
 2024 07:40:27 -0700 (PDT)
Date: Sat, 13 Apr 2024 07:40:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000939d0e0615fb5e68@google.com>
Subject: [syzbot] Monthly udf report (Apr 2024)
From: syzbot <syzbot+liste7cc1caa67ef1e37ff9e@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 27 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2562    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 440     Yes   KMSAN: uninit-value in udf_update_tag
                  https://syzkaller.appspot.com/bug?extid=d31185aa54170f7fc1f5
<3> 25      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

