Return-Path: <linux-fsdevel+bounces-13608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F59871D10
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 12:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3EF28619E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52964548F6;
	Tue,  5 Mar 2024 11:09:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297F548F3
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636966; cv=none; b=FK0xiOH6Nrhn/wo3NxYSDisJ4U9IZpq3995pxMzz+q9BwF3nSYH7WrZaAM3Wlt7oOR9QHPWvcSCTyDdox0huhHUKHhj85ENuopRrff6K//mTFii6884R8ah5+7UeTX52uEtifKGJTASbT1vPhEge7z7RgcX8Zb7+ZNo5MjT43sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636966; c=relaxed/simple;
	bh=YGFkNFR6BVT4HzZEwFfHVNLmz3rtTFWjnXbYP88kSxk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qgODXqfy8J+suO2oWbmrxnYG/C+4Hta+bFAOZGZE62KXzSYW/JsImTcpAc4byaEyrMDYLzv/XAzEvC6Rlh4E9GUIPXl/llG8eUbYdRhpDKUqcYVrtvG+Vj37W5J8xGL4A6boq7vQIcvLhlYdwnUoA+pV4DUkF9PRbETEMPu40bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c85571a980so138415239f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 03:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636964; x=1710241764;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NINenztmi1JIDOL7+T+uX7S56DXuTaxMwu0U9sYeZh8=;
        b=amX4fpk4nFdU9GNGb2bgaLWBUzCIYJs1QUmjzjDUV5Fg9PySpYQTLeZXCWDwb3rkck
         3+pXUtix2qlkJLsdFObNq/GsHe5iBtFyCAo/7N2r50MXq1S9SMpacf2ZMLBt0xjlfqfD
         cUTQLyFKUN+1kFOV3/7xDHAN0gvKjkEx18239Wsnie4JlcqVq4iah3d2BLywctPFZHHJ
         TD+sOPeYoyEsa9cqsHUZK4o/NXycW2BjPWzmkHxGM7pZUxjTUqEApesUKPpBpnb1poMJ
         1g27gyDTa/WkjUetLirV9l8Vtt/DdoiS2L9URVvtPKEpYlcfVjtvtEhbm5KNmg7jKZu5
         RhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7QROw2ZWAL5f/XD0Fle1HvF8/SU46piUhM2mxxXuFGC1wmEEukvJx/dbkNWxzYm2qMuNFN8MRfFppylM6XT1lucINE6PooxwcSXVwig==
X-Gm-Message-State: AOJu0Yy0vkDNUTnaCYiUbur3ijk18dSsZhPEG9A9I8iWRUDz1OypJ5h/
	AlpsBiIYB9X+1Q1OoKqZSfL6sTkc1tJpNg62C2xRAuK4gvdTii7s5UIXSxRNeJdSu61TCIw0uPP
	ZyOV4aZwL1/H9HOd81GpxbNO/63gKGGrrXgWUTECyXHckLMbJ8ABnmrQ=
X-Google-Smtp-Source: AGHT+IE8tLV4V8t6SSMxemP9bmpaV+de9LW7kK6fYoUBrxgLrKYcz39WotJL8USLPdsfzWA0LRuRhuqaoYh+S/SiAs0RcNxheZBZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a7:b0:474:d2f6:f0d1 with SMTP id
 v39-20020a05663835a700b00474d2f6f0d1mr71197jal.1.1709636964623; Tue, 05 Mar
 2024 03:09:24 -0800 (PST)
Date: Tue, 05 Mar 2024 03:09:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8b0ab0612e7dffa@google.com>
Subject: [syzbot] Monthly ntfs3 report (Mar 2024)
From: syzbot <syzbot+list6abea8b8591745b4404a@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 1 new issues were detected and 0 were fixed.
In total, 47 issues are still open and 41 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11885   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  3848    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<3>  2589    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  2164    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  2136    Yes   KMSAN: uninit-value in longest_match_std (2)
                   https://syzkaller.appspot.com/bug?extid=08d8956768c96a2c52cf
<6>  1940    Yes   kernel BUG in __ntfs_grab_cache_pages
                   https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<7>  1785    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<8>  1003    Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<9>  672     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<10> 645     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

