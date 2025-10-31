Return-Path: <linux-fsdevel+bounces-66562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE2C23F28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775161A20DC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541433164D8;
	Fri, 31 Oct 2025 08:55:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B13176EF
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900931; cv=none; b=AxL47CdQVlg4M1/42+yTFF5vobAAi/BTRaDH69xn4Foud/5Qpm6F4aUkxpxRK/+O30U2Crr7FeDDS47/C/iC4uTMjksRCGVIQfY0byuLPdSGme/p2UYZCfWxzeJCU1n1TYOEb11w80ISt4tfG9Q5rhGMpIhqLOQuh9UpcULMPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900931; c=relaxed/simple;
	bh=yKJia9ig9B/6F1hYjOmDx4MH0LEy2pBuagFT2leWtpE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tP0SaPvMuNLOzmVM8skj+LtPnWKGIvTnKJhRWhcWiUAGcrx1GSPY/oEkBLxxrH2tH0jTMKbC2CzY73RNv4sc67e81qiWDWb9GQMaZSNYMsvfeNjPsF2YC8nCsX38iRUhnHJA+53S0NxKL8GooUuclCGSmLMXoGcCcqudTarfgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9435917adb9so225510239f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 01:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900928; x=1762505728;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQznDTewHzt7+x/YG9L0Jd10kp8tx1TfNBen+HEnewQ=;
        b=jTv7ZZu5GpRztF0oHCzO7NuoT7xN3sZyev1TNF8OJaqo0UIV4n7UGi8/vabeh5QntB
         ZvYYgtJj+9/sk9h7GJlKaRcAuEYGpPXGL+xx43BboBijfJf+Npqg4lKnq2R7lCIziYL4
         JL3zU44+wAyEPGPNgTI8WKiaBIGVA2P0nAbkprrQllDIVq7gzPmPQh8E0QiC9riJGlCT
         40DLtoQwKrn3TTV9PnLQitqJKu1DVm/JCojN7jxkSbgaDhL6HrJDYKHojibbGNjq4wgD
         FuWHaBsDvx9c8rr+KywZ1SJb665ciUwWUZQOzAQmpHXVPOuhKOdqq8sPtdiSiTJ38tCH
         Rt4g==
X-Gm-Message-State: AOJu0YyFP/nP9u1Pn8ACn+//kVWcxJ3XQVPAk0GB8Cx+I+Ke4cdkt/5h
	5yBQ4Seobf8pwMOl34r/RUSfdvyf50p76P5lo8C4nGqg4rfeWrSfip920FbtQVTINp2F2X2om9V
	tmnXN35N3E4VMqIsS95SvvxABgDWUhsrUp1oVFliBRJQ6fBI0hfd2pBvD9pc=
X-Google-Smtp-Source: AGHT+IGN0FNZi7bjppFgoPLB5NtNJOF6wA2T4eKlOvcfmIP1GS399KhMwT/MT6NeCXq8YnHjmGhpHmQGtwidwTeKMvVqhISXsqsC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a28:b0:430:ad98:981f with SMTP id
 e9e14a558f8ab-4330d14382cmr45224415ab.4.1761900928655; Fri, 31 Oct 2025
 01:55:28 -0700 (PDT)
Date: Fri, 31 Oct 2025 01:55:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69047980.050a0220.e9cb8.0006.GAE@google.com>
Subject: [syzbot] Monthly fs report (Oct 2025)
From: syzbot <syzbot+list0377cc5e08cc9b971109@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 5 new issues were detected and 1 were fixed.
In total, 59 issues are still open and 398 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7013    Yes   BUG: sleeping function called from invalid context in hook_sb_delete
                   https://syzkaller.appspot.com/bug?extid=12479ae15958fc3f54ec
<2>  6890    Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<3>  6341    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<4>  4584    Yes   INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<5>  4464    Yes   BUG: unable to handle kernel NULL pointer dereference in filemap_read_folio (4)
                   https://syzkaller.appspot.com/bug?extid=09b7d050e4806540153d
<6>  4309    Yes   WARNING in path_noexec (2)
                   https://syzkaller.appspot.com/bug?extid=a9391462075ffb9f77c6
<7>  3776    Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<8>  3646    Yes   INFO: task hung in page_cache_ra_unbounded (2)
                   https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
<9>  2852    Yes   KASAN: use-after-free Read in hpfs_get_ea
                   https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
<10> 2314    Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

